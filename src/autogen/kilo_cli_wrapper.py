"""
Kilo CLI Wrapper - Invokes Kilo Code CLI for agent tasks.

This wrapper:
1. Invokes 'kilocode' CLI via subprocess
2. Supports autonomous mode (--auto)
3. Handles JSON output parsing
4. Parses output for generated files
5. Supports workspace and mode configuration

Kilo CLI Features:
- kilocode --auto "prompt"          # Autonomous mode
- kilocode --auto --json "prompt"   # JSON output
- kilocode --workspace /path        # Set working directory
- kilocode --mode architect         # Agent mode selection
- kilocode --timeout 300            # Max execution time

Exit Codes:
- 0: Success
- 1: Error
- 124: Timeout
"""
import asyncio
import json
import os
import re
import subprocess
from dataclasses import dataclass, field
from datetime import datetime
from pathlib import Path
from typing import Optional, Any

import structlog

from ..config import get_settings

logger = structlog.get_logger()

# Code file extensions for disk scanning
CODE_EXTENSIONS = {'.ts', '.tsx', '.js', '.jsx', '.py', '.css', '.html', '.json', '.vue', '.svelte', '.md', '.yaml', '.yml'}
IGNORE_DIRS = {'node_modules', '.git', '__pycache__', 'dist', 'build', '.next', '.venv', 'venv', '.cache'}


@dataclass
class GeneratedFile:
    """A file extracted from CLI output."""
    path: str
    content: str
    language: str


@dataclass
class KiloCLIResponse:
    """Response from Kilo CLI execution."""
    success: bool
    output: str
    files: list[GeneratedFile] = field(default_factory=list)
    error: Optional[str] = None
    exit_code: int = 0
    execution_time_ms: int = 0
    json_data: Optional[dict] = None  # Parsed JSON from --json flag


class KiloCLI:
    """
    Wrapper for Kilo Code CLI.

    Uses subprocess to invoke 'kilocode' with prompts.
    Supports autonomous mode for non-interactive execution.

    Modes:
    - code: General code generation
    - architect: Architecture and planning
    - orchestrator: Multi-step workflows
    - test: Test generation
    """

    # Kilo-specific agent modes
    MODES = ["code", "architect", "orchestrator", "test", "debug"]

    def __init__(
        self,
        working_dir: Optional[str] = None,
        timeout: Optional[int] = None,
        mode: str = "code",
        agent_name: str = "KiloCLI",
    ):
        # Convert to absolute path to ensure Kilo CLI can find the workspace
        self.working_dir = str(Path(working_dir).resolve()) if working_dir else os.getcwd()
        self.timeout = timeout if timeout is not None else get_settings().cli_timeout
        self.mode = mode if mode in self.MODES else "code"
        self.agent_name = agent_name
        self.logger = logger.bind(component="kilo_cli")

    async def execute(
        self,
        prompt: str,
        mode: Optional[str] = None,
        output_format: str = "json",
        timeout: Optional[int] = None,
        # ClaudeCLI-compatible parameters for interface compatibility:
        context_files: Optional[list[str]] = None,
        use_mcp: bool = True,  # Ignored for Kilo, kept for API compatibility
        file_context: str = "",  # Used for meaningful file naming
    ) -> KiloCLIResponse:
        """
        Execute a prompt using Kilo CLI in autonomous mode.

        Args:
            prompt: The task prompt
            mode: Optional mode override (architect, orchestrator, code, etc.)
            output_format: Output format ("text" or "json")
            timeout: Optional timeout override
            context_files: Optional list of file paths to include as context
            use_mcp: Ignored (for ClaudeCLI compatibility)
            file_context: Context string for meaningful file naming

        Returns:
            KiloCLIResponse with results
        """
        import time
        start_time = time.time()

        try:
            # Append context files to prompt if provided
            enriched_prompt = prompt
            if context_files:
                context_content = self._read_context_files(context_files)
                if context_content:
                    enriched_prompt = f"{prompt}\n\n## Context Files\n{context_content}"

            # Sanitize prompt
            sanitized_prompt = self._sanitize_prompt(enriched_prompt)

            # Create file snapshot BEFORE CLI execution
            before_snapshot = self._get_file_snapshot()

            # Build command
            effective_mode = mode or self.mode
            effective_timeout = timeout or self.timeout
            settings = get_settings()

            # Base command: kilocode --auto
            cmd_parts = ["kilocode", "--auto"]

            # Add model flag if configured (uses OpenRouter)
            if settings.kilo_model:
                cmd_parts.extend(["--model", settings.kilo_model])

            # Add JSON output flag
            if output_format == "json":
                cmd_parts.append("--json")

            # Add workspace
            cmd_parts.extend(["--workspace", self.working_dir])

            # Add mode
            if effective_mode:
                cmd_parts.extend(["--mode", effective_mode])

            # Add timeout
            cmd_parts.extend(["--timeout", str(effective_timeout)])

            # Build command string (prompt passed via stdin for safety)
            cmd = " ".join(cmd_parts)

            self.logger.info(
                "executing_kilo_cli",
                prompt_length=len(sanitized_prompt),
                working_dir=self.working_dir,
                mode=effective_mode,
                output_format=output_format,
            )

            # Run subprocess with UTF-8 encoding
            def run_cmd():
                env = os.environ.copy()
                env['PYTHONIOENCODING'] = 'utf-8'
                # Remove CLAUDECODE env var to prevent "nested session" error
                env.pop('CLAUDECODE', None)

                return subprocess.run(
                    cmd,
                    input=sanitized_prompt,
                    capture_output=True,
                    text=True,
                    encoding='utf-8',
                    errors='replace',
                    timeout=effective_timeout,
                    cwd=self.working_dir,
                    shell=True,
                    env=env,
                )

            # Add asyncio-level timeout
            try:
                result = await asyncio.wait_for(
                    asyncio.get_event_loop().run_in_executor(None, run_cmd),
                    timeout=effective_timeout + 30
                )
            except asyncio.TimeoutError:
                self.logger.error("kilo_cli_asyncio_timeout", timeout=effective_timeout)
                return KiloCLIResponse(
                    success=False,
                    output="",
                    error=f"Asyncio timeout after {effective_timeout}s",
                    exit_code=-2,
                    execution_time_ms=int((time.time() - start_time) * 1000),
                )

            execution_time = int((time.time() - start_time) * 1000)

            # Handle exit codes
            if result.returncode != 0:
                error_msg = result.stderr or f"Exit code: {result.returncode}"

                # Check for specific error types
                if result.returncode == 124:
                    error_msg = f"KILO_TIMEOUT: Command timed out after {effective_timeout}s"
                elif "command not found" in error_msg.lower() or "not recognized" in error_msg.lower():
                    error_msg = f"KILO_NOT_INSTALLED: kilocode CLI not found. Install with 'npm install -g @kilocode/cli'. Original: {error_msg}"
                elif "rate limit" in error_msg.lower():
                    error_msg = f"KILO_RATE_LIMIT: API rate limit exceeded. Original: {error_msg}"

                self.logger.error(
                    "kilo_cli_error",
                    exit_code=result.returncode,
                    stderr=result.stderr[:500] if result.stderr else None,
                    stdout_preview=result.stdout[:200] if result.stdout else None,
                )

                return KiloCLIResponse(
                    success=False,
                    output=result.stdout,
                    error=error_msg,
                    exit_code=result.returncode,
                    execution_time_ms=execution_time,
                )

            # Parse JSON output if available
            json_data = None
            if output_format == "json" and result.stdout:
                json_data = self._parse_json_output(result.stdout)

            # Extract files from output
            files = self._extract_files(result.stdout, context=file_context)

            # Write extracted files to disk
            files_written = self._write_files(files)

            # Scan disk for files created by CLI directly
            if not files:
                disk_files = self._scan_disk_for_new_files(before_snapshot)
                if disk_files:
                    files.extend(disk_files)
                    self.logger.info(
                        "kilo_files_detected_from_disk",
                        count=len(disk_files),
                        paths=[f.path for f in disk_files[:5]],
                    )

            self.logger.info(
                "kilo_cli_success",
                output_length=len(result.stdout),
                files_extracted=len(files),
                files_written=files_written,
                execution_time_ms=execution_time,
                has_json=json_data is not None,
            )

            return KiloCLIResponse(
                success=True,
                output=result.stdout,
                files=files,
                exit_code=0,
                execution_time_ms=execution_time,
                json_data=json_data,
            )

        except subprocess.TimeoutExpired:
            self.logger.error("kilo_cli_timeout", timeout=self.timeout)
            return KiloCLIResponse(
                success=False,
                output="",
                error=f"Command timed out after {self.timeout}s",
                exit_code=124,  # Kilo uses 124 for timeout
                execution_time_ms=self.timeout * 1000,
            )
        except Exception as e:
            self.logger.error("kilo_cli_exception", error=str(e))
            execution_time = int((time.time() - start_time) * 1000)
            return KiloCLIResponse(
                success=False,
                output="",
                error=str(e),
                exit_code=-1,
                execution_time_ms=execution_time,
            )

    def _parse_json_output(self, output: str) -> Optional[dict]:
        """
        Parse JSON output from kilocode --json.

        Kilo CLI outputs structured JSON including:
        - result: Success/failure status
        - files: List of generated/modified files
        - message: Response message
        - tokens: Token usage statistics

        Args:
            output: Raw stdout from CLI

        Returns:
            Parsed JSON dict or None if parsing fails
        """
        try:
            # Try to find JSON in the output
            # Kilo may output logs before JSON, so find the JSON block

            # First, try direct parse
            try:
                return json.loads(output)
            except json.JSONDecodeError:
                pass

            # Look for JSON block between markers or at the end
            json_patterns = [
                r'\{[\s\S]*\}$',  # JSON at end of output
                r'```json\s*([\s\S]*?)```',  # JSON in code block
                r'RESULT:\s*(\{[\s\S]*\})',  # After RESULT: marker
            ]

            for pattern in json_patterns:
                match = re.search(pattern, output)
                if match:
                    json_str = match.group(1) if '(' in pattern else match.group(0)
                    try:
                        return json.loads(json_str)
                    except json.JSONDecodeError:
                        continue

            return None

        except Exception as e:
            self.logger.debug("json_parse_failed", error=str(e))
            return None

    def _sanitize_prompt(self, prompt: str) -> str:
        """
        Sanitize prompt for safe transmission to CLI.

        Removes or replaces problematic Unicode characters.
        """
        replacements = {
            '\u2264': '<=',
            '\u2265': '>=',
            '\u2260': '!=',
            '\u2192': '->',
            '\u2190': '<-',
            '\u2713': '[OK]',
            '\u2717': '[X]',
            '\u2022': '*',
            '\u2026': '...',
            '\u201c': '"',
            '\u201d': '"',
            '\u2018': "'",
            '\u2019': "'",
            '\u2014': '--',
            '\u2013': '-',
        }

        result = prompt
        for char, replacement in replacements.items():
            result = result.replace(char, replacement)

        # Keep basic UTF-8 but remove combining chars
        cleaned = []
        for char in result:
            code = ord(char)
            if code < 0x300 or (code >= 0x400 and code < 0x500):
                cleaned.append(char)
            elif code >= 0x300 and code < 0x370:
                continue
            else:
                cleaned.append(' ')

        return ''.join(cleaned)

    def _read_context_files(self, file_paths: list[str]) -> str:
        """
        Read file contents and format them as context for the prompt.

        Args:
            file_paths: List of file paths to read

        Returns:
            Formatted string with file contents, or empty string if no files read
        """
        parts = []
        max_content_size = 5000  # Max chars per file to prevent token explosion

        for file_path in file_paths:
            try:
                path = Path(file_path)
                if not path.is_absolute():
                    path = Path(self.working_dir) / path

                if path.exists() and path.is_file():
                    content = path.read_text(encoding='utf-8', errors='replace')
                    if len(content) > max_content_size:
                        content = content[:max_content_size] + "\n... (truncated)"

                    ext = path.suffix.lstrip('.') or 'txt'
                    parts.append(f"### {path.name}\n```{ext}\n{content}\n```")
                else:
                    self.logger.debug("context_file_not_found", path=str(path))

            except Exception as e:
                self.logger.debug("context_file_read_error", path=file_path, error=str(e))

        return "\n\n".join(parts)

    def _extract_files(self, output: str, context: str = "") -> list[GeneratedFile]:
        """
        Extract generated files from CLI output.

        Args:
            output: CLI output containing code blocks
            context: Optional context for meaningful file naming

        Looks for code blocks with file paths in the output.
        """
        files = []
        timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")

        # Generate meaningful prefix from context
        if context:
            prefix = re.sub(r'[^a-z0-9]+', '_', context.lower())[:30]
            prefix = prefix.strip('_') or "generated"
        else:
            prefix = "generated"

        # Pattern: ```language:path or ```language filename
        patterns = [
            r'```(\w+):([^\n]+)\n(.*?)```',
            r'File:\s*([^\n]+)\n```(\w+)\n(.*?)```',
            r'<!--\s*file:\s*([^\n]+)\s*-->\n```(\w+)\n(.*?)```',
        ]

        for pattern in patterns:
            matches = re.findall(pattern, output, re.DOTALL)
            for match in matches:
                if len(match) == 3:
                    if pattern == patterns[0]:
                        lang, path, content = match
                    else:
                        path, lang, content = match

                    files.append(GeneratedFile(
                        path=path.strip(),
                        content=content.strip(),
                        language=lang.strip(),
                    ))

        # Also look for standalone code blocks
        standalone_pattern = r'```(\w+)\n(.*?)```'
        standalone_matches = re.findall(standalone_pattern, output, re.DOTALL)

        captured_content = {f.content for f in files}

        for lang, content in standalone_matches:
            content = content.strip()
            if content not in captured_content:
                ext_map = {
                    'python': '.py',
                    'javascript': '.js',
                    'typescript': '.ts',
                    'rust': '.rs',
                    'go': '.go',
                    'java': '.java',
                    'cpp': '.cpp',
                    'c': '.c',
                    'html': '.html',
                    'css': '.css',
                    'json': '.json',
                    'yaml': '.yaml',
                }
                ext = ext_map.get(lang.lower(), f'.{lang}')
                # Use context-based prefix for meaningful file names
                filename = f"{prefix}_{timestamp}_{len(files) + 1}{ext}"

                files.append(GeneratedFile(
                    path=filename,
                    content=content,
                    language=lang,
                ))
                captured_content.add(content)

        return files

    def _write_files(self, files: list[GeneratedFile]) -> int:
        """Write extracted files to disk."""
        written = 0

        for file in files:
            try:
                file_path = Path(file.path)

                if file_path.is_absolute():
                    file_path = Path(file_path.name)

                parts = [p for p in file_path.parts if p not in ('..', '.')]
                if not parts:
                    self.logger.warning("invalid_file_path", path=file.path)
                    continue

                file_path = Path(*parts)
                full_path = Path(self.working_dir) / file_path
                full_path.parent.mkdir(parents=True, exist_ok=True)

                with open(full_path, 'w', encoding='utf-8') as f:
                    f.write(file.content)
                written += 1
                self.logger.debug(
                    "file_written",
                    path=str(full_path),
                    size=len(file.content),
                )

            except Exception as e:
                self.logger.error(
                    "file_write_error",
                    path=file.path,
                    error=str(e),
                )

        return written

    def _get_file_snapshot(self) -> dict[str, float]:
        """Create a snapshot of all files in working directory."""
        snapshot = {}
        working_path = Path(self.working_dir)

        try:
            for file_path in working_path.rglob("*"):
                if not file_path.is_file():
                    continue

                if any(ignored in file_path.parts for ignored in IGNORE_DIRS):
                    continue

                if file_path.suffix.lower() not in CODE_EXTENSIONS:
                    continue

                try:
                    rel_path = str(file_path.relative_to(working_path))
                    snapshot[rel_path] = file_path.stat().st_mtime
                except (ValueError, OSError):
                    continue

        except Exception as e:
            self.logger.warning("file_snapshot_failed", error=str(e))

        return snapshot

    def _scan_disk_for_new_files(self, before_snapshot: dict[str, float]) -> list[GeneratedFile]:
        """Scan working directory for files created or modified after the snapshot."""
        new_files = []
        working_path = Path(self.working_dir)

        try:
            for file_path in working_path.rglob("*"):
                if not file_path.is_file():
                    continue

                if any(ignored in file_path.parts for ignored in IGNORE_DIRS):
                    continue

                if file_path.suffix.lower() not in CODE_EXTENSIONS:
                    continue

                try:
                    rel_path = str(file_path.relative_to(working_path))
                    current_mtime = file_path.stat().st_mtime

                    is_new = rel_path not in before_snapshot
                    is_modified = not is_new and current_mtime > before_snapshot.get(rel_path, 0)

                    if is_new or is_modified:
                        content = file_path.read_text(encoding='utf-8', errors='replace')
                        language = self._detect_language(file_path.suffix)

                        new_files.append(GeneratedFile(
                            path=rel_path,
                            content=content,
                            language=language,
                        ))

                except (ValueError, OSError, UnicodeDecodeError) as e:
                    self.logger.warning("disk_scan_file_error", path=str(file_path), error=str(e))
                    continue

        except Exception as e:
            self.logger.warning("disk_scan_failed", error=str(e))

        return new_files

    def _detect_language(self, suffix: str) -> str:
        """Detect programming language from file extension."""
        ext_to_lang = {
            '.ts': 'typescript',
            '.tsx': 'typescript',
            '.js': 'javascript',
            '.jsx': 'javascript',
            '.py': 'python',
            '.css': 'css',
            '.html': 'html',
            '.json': 'json',
            '.yaml': 'yaml',
            '.yml': 'yaml',
            '.md': 'markdown',
            '.vue': 'vue',
            '.svelte': 'svelte',
            '.sql': 'sql',
            '.sh': 'bash',
            '.bash': 'bash',
        }
        return ext_to_lang.get(suffix.lower(), suffix.lstrip('.'))

    async def check_installed(self) -> bool:
        """Check if Kilo CLI is installed."""
        try:
            result = subprocess.run(
                "kilocode --version",
                capture_output=True,
                text=True,
                timeout=10,
                shell=True,
            )
            return result.returncode == 0
        except Exception:
            return False

    def execute_sync(self, prompt: str) -> KiloCLIResponse:
        """Synchronous version of execute."""
        return asyncio.run(self.execute(prompt))


@dataclass
class KiloParallelResult:
    """Result from a single parallel Kilo worker."""
    worker_id: str
    success: bool
    branch_name: Optional[str]  # Git branch created by --parallel
    output: str
    files: list[GeneratedFile] = field(default_factory=list)
    error: Optional[str] = None
    execution_time_ms: int = 0


class KiloCLIParallel:
    """
    Kilo CLI Parallel Mode - Branch-isolated parallel execution.

    Uses Kilo's --parallel flag which:
    1. Creates separate git branches for each worker
    2. Prevents conflicts when multiple workers modify same files
    3. Allows A/B solution comparison and merge

    Usage:
        parallel = KiloCLIParallel(working_dir="./project")
        results = await parallel.execute([
            "implement user authentication",
            "implement user authentication",  # Same task, different approaches
        ])

        # Each result has branch_name for merge
        for r in results:
            print(f"Worker {r.worker_id}: branch {r.branch_name}")
    """

    def __init__(
        self,
        working_dir: Optional[str] = None,
        timeout: Optional[int] = None,
        mode: str = "code",
        max_workers: int = 3,
    ):
        # Convert to absolute path to ensure Kilo CLI can find the workspace
        self.working_dir = str(Path(working_dir).resolve()) if working_dir else os.getcwd()
        self.timeout = timeout if timeout is not None else get_settings().cli_timeout
        self.mode = mode
        self.max_workers = max_workers
        self.logger = logger.bind(component="kilo_parallel")

    async def execute(
        self,
        prompts: list[str],
        mode: Optional[str] = None,
    ) -> list[KiloParallelResult]:
        """
        Execute multiple prompts in parallel using Kilo's --parallel flag.

        Each prompt gets its own git branch for isolation.

        Args:
            prompts: List of task prompts (can be same prompt for A/B testing)
            mode: Optional mode override

        Returns:
            List of KiloParallelResult with branch names
        """
        import time
        import uuid

        effective_mode = mode or self.mode
        results = []

        # Limit concurrent workers
        semaphore = asyncio.Semaphore(self.max_workers)

        async def run_worker(worker_id: str, prompt: str) -> KiloParallelResult:
            start_time = time.time()

            async with semaphore:
                try:
                    # Build command with --parallel flag
                    cmd_parts = [
                        "kilocode",
                        "--parallel",  # Enables branch isolation
                        "--auto",
                        "--json",
                        "--workspace", self.working_dir,
                        "--timeout", str(self.timeout),
                    ]

                    if effective_mode:
                        cmd_parts.extend(["--mode", effective_mode])

                    cmd = " ".join(cmd_parts)

                    self.logger.info(
                        "kilo_parallel_worker_start",
                        worker_id=worker_id,
                        prompt_length=len(prompt),
                    )

                    # Run subprocess
                    env = os.environ.copy()
                    env['PYTHONIOENCODING'] = 'utf-8'
                    # Remove CLAUDECODE env var to prevent "nested session" error
                    env.pop('CLAUDECODE', None)

                    def run_cmd():
                        return subprocess.run(
                            cmd,
                            input=prompt,
                            capture_output=True,
                            text=True,
                            encoding='utf-8',
                            errors='replace',
                            timeout=self.timeout,
                            cwd=self.working_dir,
                            shell=True,
                            env=env,
                        )

                    result = await asyncio.wait_for(
                        asyncio.get_event_loop().run_in_executor(None, run_cmd),
                        timeout=self.timeout + 30
                    )

                    execution_time = int((time.time() - start_time) * 1000)

                    # Extract branch name from output
                    branch_name = self._extract_branch_name(result.stdout)

                    if result.returncode != 0:
                        return KiloParallelResult(
                            worker_id=worker_id,
                            success=False,
                            branch_name=branch_name,
                            output=result.stdout,
                            error=result.stderr or f"Exit code: {result.returncode}",
                            execution_time_ms=execution_time,
                        )

                    # Extract files
                    files = self._extract_files_from_output(result.stdout)

                    self.logger.info(
                        "kilo_parallel_worker_success",
                        worker_id=worker_id,
                        branch=branch_name,
                        files_count=len(files),
                        execution_time_ms=execution_time,
                    )

                    return KiloParallelResult(
                        worker_id=worker_id,
                        success=True,
                        branch_name=branch_name,
                        output=result.stdout,
                        files=files,
                        execution_time_ms=execution_time,
                    )

                except asyncio.TimeoutError:
                    return KiloParallelResult(
                        worker_id=worker_id,
                        success=False,
                        branch_name=None,
                        output="",
                        error=f"Timeout after {self.timeout}s",
                        execution_time_ms=self.timeout * 1000,
                    )
                except Exception as e:
                    self.logger.error(
                        "kilo_parallel_worker_error",
                        worker_id=worker_id,
                        error=str(e),
                    )
                    return KiloParallelResult(
                        worker_id=worker_id,
                        success=False,
                        branch_name=None,
                        output="",
                        error=str(e),
                        execution_time_ms=int((time.time() - start_time) * 1000),
                    )

        # Create worker tasks
        worker_tasks = [
            run_worker(f"worker-{i}-{uuid.uuid4().hex[:6]}", prompt)
            for i, prompt in enumerate(prompts)
        ]

        # Execute all workers in parallel
        results = await asyncio.gather(*worker_tasks, return_exceptions=False)

        # Log summary
        successful = sum(1 for r in results if r.success)
        self.logger.info(
            "kilo_parallel_complete",
            total_workers=len(prompts),
            successful=successful,
            failed=len(prompts) - successful,
            branches=[r.branch_name for r in results if r.branch_name],
        )

        return results

    def _extract_branch_name(self, output: str) -> Optional[str]:
        """Extract the git branch name created by --parallel."""
        # Kilo --parallel creates branches like: kilo-parallel-abc123
        patterns = [
            r'branch[:\s]+["\']?(kilo-parallel-[a-zA-Z0-9]+)["\']?',
            r'Created branch[:\s]+["\']?([a-zA-Z0-9\-_/]+)["\']?',
            r'"branch"[:\s]*"([^"]+)"',
        ]

        for pattern in patterns:
            match = re.search(pattern, output, re.IGNORECASE)
            if match:
                return match.group(1)

        return None

    def _extract_files_from_output(self, output: str) -> list[GeneratedFile]:
        """Extract generated files from output."""
        files = []

        # Pattern for code blocks with file paths
        patterns = [
            r'```(\w+):([^\n]+)\n(.*?)```',
            r'File:\s*([^\n]+)\n```(\w+)\n(.*?)```',
        ]

        for pattern in patterns:
            matches = re.findall(pattern, output, re.DOTALL)
            for match in matches:
                if len(match) == 3:
                    if ':' in pattern:
                        lang, path, content = match
                    else:
                        path, lang, content = match

                    files.append(GeneratedFile(
                        path=path.strip(),
                        content=content.strip(),
                        language=lang.strip(),
                    ))

        return files

    async def execute_ab_test(
        self,
        prompt: str,
        num_variants: int = 2,
    ) -> list[KiloParallelResult]:
        """
        Execute same prompt multiple times for A/B testing.

        Each variant runs in its own branch, allowing comparison.

        Args:
            prompt: Task to execute
            num_variants: Number of variants to generate (default: 2)

        Returns:
            List of results, one per variant
        """
        prompts = [prompt] * num_variants
        return await self.execute(prompts)

    async def merge_branch(self, branch_name: str) -> bool:
        """
        Merge a parallel branch back to main branch.

        Args:
            branch_name: Branch to merge (e.g., kilo-parallel-abc123)

        Returns:
            True if merge succeeded
        """
        try:
            # Get current branch
            result = subprocess.run(
                "git branch --show-current",
                capture_output=True,
                text=True,
                cwd=self.working_dir,
                shell=True,
            )
            current_branch = result.stdout.strip()

            # Merge the parallel branch
            merge_result = subprocess.run(
                f"git merge {branch_name} --no-edit",
                capture_output=True,
                text=True,
                cwd=self.working_dir,
                shell=True,
            )

            if merge_result.returncode != 0:
                self.logger.error(
                    "kilo_parallel_merge_failed",
                    branch=branch_name,
                    error=merge_result.stderr,
                )
                return False

            self.logger.info(
                "kilo_parallel_merged",
                branch=branch_name,
                into=current_branch,
            )
            return True

        except Exception as e:
            self.logger.error("kilo_parallel_merge_error", error=str(e))
            return False


class KiloCLIPool:
    """
    Pool of CLI instances for parallel execution.

    Manages multiple concurrent Kilo CLI calls while respecting rate limits.
    """

    def __init__(
        self,
        max_concurrent: int = 5,
        working_dir: Optional[str] = None,
        mode: str = "code",
    ):
        self.max_concurrent = max_concurrent
        self.working_dir = working_dir
        self.mode = mode
        self._semaphore = asyncio.Semaphore(max_concurrent)
        self.logger = logger.bind(component="kilo_cli_pool")

    async def execute_batch(
        self,
        prompts: list[tuple[str, str]],  # (task_id, prompt)
    ) -> dict[str, KiloCLIResponse]:
        """
        Execute multiple prompts in parallel.

        Args:
            prompts: List of (task_id, prompt) tuples

        Returns:
            Dict mapping task_id to KiloCLIResponse
        """
        results: dict[str, KiloCLIResponse] = {}

        async def execute_one(task_id: str, prompt: str):
            async with self._semaphore:
                cli = KiloCLI(
                    working_dir=self.working_dir,
                    mode=self.mode,
                )
                response = await cli.execute(prompt)
                results[task_id] = response

        tasks = [
            execute_one(task_id, prompt)
            for task_id, prompt in prompts
        ]

        await asyncio.gather(*tasks, return_exceptions=True)

        return results
