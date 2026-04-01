"""
ClawCode Client — Bridge between DaveFelix and the ClawCode Rust binary.

Drop-in replacement for OllamaClient. All Minibook agents call
self.ollama.chat() which now routes to the ClawCode multi-provider CLI.

The ClawCode binary is invoked as a subprocess with:
    clawcode --provider <provider> --model <model> prompt "<text>"

Provider selection happens via the model string:
    "clawcode:anthropic/claude-sonnet-4-6"  → --provider anthropic
    "clawcode:openrouter/qwen3-coder:free"  → --provider openrouter
    "clawcode:ollama/qwen2.5-coder:7b"      → --provider ollama
    "clawcode"                               → --provider anthropic (default)
"""
import json
import logging
import os
import re
import shutil
import subprocess
import time
from dataclasses import dataclass
from typing import Any, Dict, List, Optional

logger = logging.getLogger(__name__)

# Re-use OllamaResponse so agents don't need any changes
from src.engine.ollama_client import OllamaResponse


def _find_clawcode_binary() -> str:
    """Find the clawcode binary on the system."""
    # 1. Environment variable
    env_path = os.getenv("CLAWCODE_PATH")
    if env_path and os.path.isfile(env_path):
        return env_path

    # 2. Adjacent to this project (built from source)
    project_root = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
    local_binary = os.path.join(
        project_root, "..", "ClawCode", "rust", "target", "release", "rusty-claude-cli"
    )
    if os.name == "nt":
        local_binary += ".exe"
    if os.path.isfile(local_binary):
        return local_binary

    # Debug build fallback
    debug_binary = local_binary.replace("release", "debug")
    if os.path.isfile(debug_binary):
        return debug_binary

    # 3. System PATH
    which = shutil.which("clawcode") or shutil.which("rusty-claude-cli")
    if which:
        return which

    # 4. Fallback
    return "rusty-claude-cli"


class ClawCodeClient:
    """
    Subprocess-based client that calls the ClawCode Rust binary.

    Implements the same interface as OllamaClient:
    - chat(messages, system, temperature, max_tokens, json_mode) -> OllamaResponse
    - ask(prompt, system, temperature) -> str
    - ask_json(prompt, system) -> Any
    - is_healthy() -> bool
    """

    def __init__(
        self,
        model: str = "clawcode",
        timeout: int = 600,
        config_path: Optional[str] = None,
        **kwargs,
    ) -> None:
        # Parse "clawcode:provider/model" format
        self.provider, self.model_name = self._parse_model(model)
        self.timeout = timeout
        self.config_path = config_path
        self.binary = _find_clawcode_binary()
        logger.info(
            "ClawCodeClient init provider=%s model=%s binary=%s",
            self.provider, self.model_name, self.binary,
        )

    @staticmethod
    def _parse_model(model: str) -> tuple:
        """Parse 'clawcode:provider/model' into (provider, model)."""
        if ":" not in model or model == "clawcode":
            return ("anthropic", "claude-sonnet-4-6")

        _, rest = model.split(":", 1)
        if "/" in rest:
            provider, model_name = rest.split("/", 1)
            return (provider, model_name)
        return (rest, "")

    def _run_clawcode(self, prompt: str) -> tuple:
        """Run clawcode binary and return (stdout, duration_ms, error)."""
        cmd = [self.binary]
        if self.provider != "anthropic":
            cmd.extend(["--provider", self.provider])
        if self.model_name:
            cmd.extend(["--model", self.model_name])
        if self.config_path:
            cmd.extend(["--config", self.config_path])
        cmd.extend(["prompt", prompt])

        logger.debug("ClawCode cmd: %s", " ".join(cmd))
        start = time.time()

        try:
            env = {**os.environ, "PYTHONIOENCODING": "utf-8"}
            # Windows: force UTF-8 codepage for subprocess
            kwargs = {}
            if os.name == "nt":
                import ctypes
                kwargs["creationflags"] = subprocess.CREATE_NO_WINDOW
            result = subprocess.run(
                cmd,
                capture_output=True,
                text=False,  # Raw bytes to avoid codepage issues
                timeout=self.timeout,
                env=env,
                **kwargs,
            )
            duration_ms = int((time.time() - start) * 1000)
            stdout = result.stdout.decode("utf-8", errors="replace")
            stderr = result.stderr.decode("utf-8", errors="replace")

            if result.returncode != 0:
                error = stderr.strip() or f"Exit code {result.returncode}"
                logger.error("ClawCode error: %s", error)
                return ("", duration_ms, error)

            # Strip ANSI escape codes and spinner artifacts from terminal output
            clean = re.sub(r'\x1b\[[0-9;]*[a-zA-Z]', '', stdout)
            clean = re.sub(r'[\x00-\x08\x0b\x0c\x0e-\x1f]', '', clean)
            # Remove spinner lines (⠋ Waiting..., ✔ Claude response...)
            lines = clean.split('\n')
            lines = [l for l in lines if not any(
                s in l for s in ['Waiting for Claude', 'Claude response complete', 'Claude request failed']
            )]
            clean = '\n'.join(lines).strip()

            return (clean, duration_ms, None)

        except subprocess.TimeoutExpired:
            duration_ms = int((time.time() - start) * 1000)
            return ("", duration_ms, f"Timeout after {self.timeout}s")
        except FileNotFoundError:
            return ("", 0, f"ClawCode binary not found: {self.binary}")
        except Exception as e:
            duration_ms = int((time.time() - start) * 1000)
            return ("", duration_ms, str(e))

    # ------------------------------------------------------------------
    # OllamaClient-compatible interface
    # ------------------------------------------------------------------

    def chat(
        self,
        messages: List[Dict[str, str]],
        system: Optional[str] = None,
        temperature: Optional[float] = None,
        max_tokens: Optional[int] = None,
        json_mode: bool = False,
    ) -> OllamaResponse:
        """Send a chat completion via ClawCode subprocess."""
        # Build prompt from messages
        parts = []
        if system:
            parts.append(f"<system>\n{system}\n</system>\n")

        for msg in messages:
            role = msg.get("role", "user")
            content = msg.get("content", "")
            if role == "system" and not system:
                parts.append(f"<system>\n{content}\n</system>\n")
            elif role == "user":
                parts.append(content)
            elif role == "assistant":
                parts.append(f"[Previous response]\n{content}\n")

        if json_mode:
            parts.append(
                "\nIMPORTANT: Respond with valid JSON only. "
                "No markdown, no explanation, just the JSON object."
            )

        full_prompt = "\n\n".join(parts)
        stdout, duration_ms, error = self._run_clawcode(full_prompt)

        if error:
            return OllamaResponse(
                content="",
                model=f"clawcode:{self.provider}/{self.model_name}",
                done=False,
                error=error,
                total_duration_ms=duration_ms,
            )

        logger.info(
            "clawcode_chat provider=%s model=%s output_len=%d duration=%dms",
            self.provider, self.model_name, len(stdout), duration_ms,
        )

        return OllamaResponse(
            content=stdout.strip(),
            model=f"clawcode:{self.provider}/{self.model_name}",
            total_duration_ms=duration_ms,
            eval_count=len(stdout.split()),
            done=True,
        )

    def ask(
        self,
        prompt: str,
        system: Optional[str] = None,
        temperature: Optional[float] = None,
    ) -> str:
        """Simple one-shot question → answer string."""
        resp = self.chat(
            messages=[{"role": "user", "content": prompt}],
            system=system,
            temperature=temperature,
        )
        if resp.error:
            raise RuntimeError(f"ClawCode error: {resp.error}")
        return resp.content

    def ask_json(
        self,
        prompt: str,
        system: Optional[str] = None,
    ) -> Any:
        """Ask for JSON output and parse it."""
        resp = self.chat(
            messages=[{"role": "user", "content": prompt}],
            system=system,
            json_mode=True,
        )
        if resp.error:
            raise RuntimeError(f"ClawCode error: {resp.error}")
        try:
            return json.loads(resp.content)
        except json.JSONDecodeError:
            # Try to extract JSON from response
            match = re.search(r'\{[\s\S]*\}', resp.content)
            if match:
                try:
                    return json.loads(match.group())
                except json.JSONDecodeError:
                    pass
            logger.warning("Failed to parse JSON from ClawCode response, returning raw")
            return resp.content

    def is_healthy(self) -> bool:
        """Check if ClawCode binary is available."""
        try:
            result = subprocess.run(
                [self.binary, "--help"],
                capture_output=True,
                timeout=10,
            )
            return result.returncode == 0
        except Exception:
            return False

    def list_models(self) -> List[str]:
        """List available provider/model combinations."""
        return [
            "clawcode:anthropic/claude-sonnet-4-6",
            "clawcode:anthropic/claude-opus-4-6",
            "clawcode:openrouter/qwen/qwen3-coder:free",
            "clawcode:ollama/qwen2.5-coder:7b",
        ]

    def close(self) -> None:
        """No-op — subprocess is per-call."""
        pass
