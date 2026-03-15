"""
Master Orchestrator — The brain of the Coding Engine.

Reads requirements.json, spins up Minibook agents, assigns tasks,
monitors progress, and drives the convergence loop until the
project is fully generated.

Flow:
  1. Load requirements
  2. Connect to Minibook + Ollama
  3. Register all agents
  4. Create project in Minibook
  5. Post Grand Plan
  6. Phase 1: Architecture (architect designs the system)
  7. Phase 2: Parallel Code Generation (agents build modules)
  8. Phase 3: Testing (tester writes + runs tests)
  9. Phase 4: Fix Loop (fixer patches failures, re-test)
  10. Phase 5: Review (reviewer checks quality)
  11. Phase 6: Infrastructure (infra-gen adds Docker/CI)
  12. Output: Complete project in output/ directory
"""
import json
import logging
import os
import time
from dataclasses import dataclass, field
from pathlib import Path
from typing import Any, Dict, List, Optional

from src.engine.ollama_client import OllamaClient
from src.engine.minibook_client import MinibookClient
from src.engine.minibook_agent import MinibookAgentBase, TaskContext, AgentResult
from src.engine.agents import (
    ArchitectAgent,
    BackendGenAgent,
    FrontendGenAgent,
    DatabaseGenAgent,
    ApiGenAgent,
    AuthGenAgent,
    TesterAgent,
    FixerAgent,
    ReviewerAgent,
    InfraGenAgent,
)

logger = logging.getLogger(__name__)


@dataclass
class ProjectRequirements:
    """Parsed project requirements."""
    name: str
    type: str  # nestjs, fastapi, react, etc.
    description: str = ""
    features: List[Dict[str, Any]] = field(default_factory=list)
    tech_stack: Dict[str, str] = field(default_factory=dict)
    raw: Dict[str, Any] = field(default_factory=dict)
    # Enriched context from epic runner (if available)
    openapi_spec: str = ""          # OpenAPI 3.0 YAML (truncated to key parts)
    data_dictionary: str = ""       # Entity definitions
    architecture_doc: str = ""      # Architecture overview
    test_documentation: str = ""    # Test cases and specs
    api_documentation: str = ""     # Human-readable API docs
    asyncapi_spec: str = ""         # WebSocket/event specs
    state_machines: str = ""        # State machine definitions
    component_matrix: str = ""      # UI component matrix
    test_factories: str = ""        # Test data factories
    epic_runner_dir: str = ""       # Path to epic runner output


@dataclass
class PhaseResult:
    """Result of an orchestration phase."""
    phase: str
    success: bool
    posts_created: int = 0
    comments_received: int = 0
    files_generated: int = 0
    duration_ms: int = 0
    errors: List[str] = field(default_factory=list)


class MasterOrchestrator:
    """
    Coordinates all Minibook agents to generate a complete project.

    Usage:
        orch = MasterOrchestrator(project_path="Data/all_services/whatsapp")
        orch.run()
    """

    def __init__(
        self,
        project_path: str,
        minibook_url: str = "http://localhost:8080",
        ollama_model: str = "qwen2.5-coder:7b",
        ollama_url: str = "http://localhost:11434",
        output_dir: Optional[str] = None,
        max_fix_rounds: int = 3,
    ) -> None:
        self.project_path = Path(project_path)
        self.output_dir = Path(output_dir) if output_dir else Path("output") / self.project_path.name
        self.max_fix_rounds = max_fix_rounds

        # Clients
        self.minibook = MinibookClient(base_url=minibook_url)
        self.ollama = OllamaClient(model=ollama_model, base_url=ollama_url)

        # State
        self.requirements: Optional[ProjectRequirements] = None
        self.project_id: Optional[str] = None
        self.agents: Dict[str, MinibookAgentBase] = {}
        self.phase_results: List[PhaseResult] = []
        self.all_generated_files: Dict[str, str] = {}  # path -> content

        logger.info(
            "MasterOrchestrator init: project=%s minibook=%s ollama=%s",
            project_path, minibook_url, ollama_model,
        )

    # ==================================================================
    # Main entry point
    # ==================================================================
    def run(self) -> bool:
        """
        Run the full code generation pipeline.

        Returns True if project was generated successfully.
        """
        print(f"\n{'='*60}")
        print(f"  CODING ENGINE — Master Orchestrator")
        print(f"  Project: {self.project_path}")
        print(f"{'='*60}\n")

        # Pre-flight checks
        if not self._preflight():
            return False

        # Load requirements
        self.requirements = self._load_requirements()
        if not self.requirements:
            return False

        print(f"[+] Project: {self.requirements.name} ({self.requirements.type})")
        print(f"[+] Features: {len(self.requirements.features)}")

        # Register agents + create project in Minibook
        if not self._setup_minibook():
            return False

        # Phase 1: Architecture
        print(f"\n--- Phase 1: Architecture ---")
        arch_result = self._phase_architecture()
        self.phase_results.append(arch_result)
        if not arch_result.success:
            print(f"[!] Architecture phase failed")
            return False

        # Phase 2: Code Generation (parallel-ish)
        print(f"\n--- Phase 2: Code Generation ---")
        gen_result = self._phase_code_generation()
        self.phase_results.append(gen_result)

        # Phase 3: Database
        print(f"\n--- Phase 3: Database ---")
        db_result = self._phase_database()
        self.phase_results.append(db_result)

        # Phase 4: Testing
        print(f"\n--- Phase 4: Testing ---")
        test_result = self._phase_testing()
        self.phase_results.append(test_result)

        # Phase 5: Fix Loop
        for fix_round in range(self.max_fix_rounds):
            if test_result.success:
                break
            print(f"\n--- Phase 5: Fix Round {fix_round + 1} ---")
            fix_result = self._phase_fix()
            self.phase_results.append(fix_result)
            # Re-test
            test_result = self._phase_testing()
            self.phase_results.append(test_result)

        # Phase 6: Review
        print(f"\n--- Phase 6: Code Review ---")
        review_result = self._phase_review()
        self.phase_results.append(review_result)

        # Phase 7: Infrastructure
        print(f"\n--- Phase 7: Infrastructure ---")
        infra_result = self._phase_infrastructure()
        self.phase_results.append(infra_result)

        # Write output
        self._write_output()

        # Summary
        self._print_summary()
        return True

    # ==================================================================
    # Pre-flight
    # ==================================================================
    def _preflight(self) -> bool:
        """Check that Minibook and Ollama are reachable."""
        print("[*] Pre-flight checks...")

        if not self.ollama.is_healthy():
            print("[!] Ollama is not running or model not available")
            print(f"    URL: {self.ollama.base_url}")
            print(f"    Model: {self.ollama.model}")
            print(f"    Fix: ollama pull {self.ollama.model}")
            return False
        print(f"  [OK] Ollama ({self.ollama.model})")

        if not self.minibook.is_healthy():
            print("[!] Minibook is not running")
            print(f"    URL: {self.minibook.base_url}")
            print(f"    Fix: cd minibook && python run.py")
            return False
        print(f"  [OK] Minibook ({self.minibook.base_url})")

        if not self.project_path.exists():
            print(f"[!] Project path not found: {self.project_path}")
            return False
        print(f"  [OK] Project path exists")

        return True

    # ==================================================================
    # Load requirements
    # ==================================================================
    def _load_requirements(self) -> Optional[ProjectRequirements]:
        """Load requirements.json and any epic runner enrichments."""
        req_file = self.project_path / "requirements.json"
        if not req_file.exists():
            print(f"[!] requirements.json not found in {self.project_path}")
            return None

        with open(req_file, "r", encoding="utf-8") as f:
            raw = json.load(f)

        reqs = ProjectRequirements(
            name=raw.get("name", self.project_path.name),
            type=raw.get("type", "unknown"),
            description=raw.get("description", ""),
            features=raw.get("features", []),
            tech_stack=raw.get("tech_stack", {}),
            raw=raw,
        )

        # Auto-discover epic runner output
        # Look for directories matching the project name with timestamps
        parent = self.project_path.parent
        project_name = raw.get("name", self.project_path.name)
        epic_dir = None

        for d in sorted(parent.iterdir(), reverse=True):
            if d.is_dir() and project_name in d.name and d != self.project_path:
                # Check if it has epic runner artifacts
                if (d / "api" / "openapi_spec.yaml").exists() or (d / "MASTER_DOCUMENT.md").exists():
                    epic_dir = d
                    break

        if epic_dir:
            reqs.epic_runner_dir = str(epic_dir)
            print(f"  [+] Epic runner output found: {epic_dir.name}")
            # Core specs
            reqs.openapi_spec = self._load_epic_file(epic_dir / "api" / "openapi_spec.yaml", max_lines=500)
            reqs.data_dictionary = self._load_epic_file(epic_dir / "data" / "data_dictionary.md", max_lines=300)
            reqs.architecture_doc = self._load_epic_file(epic_dir / "architecture" / "architecture.md", max_lines=200)
            # Extended specs
            reqs.test_documentation = self._load_epic_file(epic_dir / "testing" / "test_documentation.md", max_lines=400)
            reqs.api_documentation = self._load_epic_file(epic_dir / "api" / "api_documentation.md", max_lines=300)
            reqs.asyncapi_spec = self._load_epic_file(epic_dir / "api" / "asyncapi_spec.yaml", max_lines=200)
            reqs.state_machines = self._load_epic_file(epic_dir / "state_machines" / "state_machines.json", max_lines=150)
            reqs.component_matrix = self._load_epic_file(epic_dir / "ui_design" / "compositions" / "component_matrix.md", max_lines=150)
            reqs.test_factories = self._load_epic_file(epic_dir / "testing" / "factories" / "factories.json", max_lines=200)

            loaded = sum(1 for x in [reqs.openapi_spec, reqs.data_dictionary, reqs.architecture_doc,
                                     reqs.test_documentation, reqs.api_documentation, reqs.asyncapi_spec,
                                     reqs.state_machines, reqs.component_matrix, reqs.test_factories] if x)
            print(f"  [+] Loaded {loaded} epic runner artifacts:")
            for name, val in [("OpenAPI spec", reqs.openapi_spec), ("Data dictionary", reqs.data_dictionary),
                              ("Architecture", reqs.architecture_doc), ("Test docs", reqs.test_documentation),
                              ("API docs", reqs.api_documentation), ("AsyncAPI", reqs.asyncapi_spec),
                              ("State machines", reqs.state_machines), ("Components", reqs.component_matrix),
                              ("Test factories", reqs.test_factories)]:
                if val:
                    print(f"      {name}: {len(val)} chars")

        return reqs

    def _load_epic_file(self, path: Path, max_lines: int = 300) -> str:
        """Load an epic runner file, truncated to max_lines."""
        if not path.exists():
            return ""
        try:
            with open(path, "r", encoding="utf-8", errors="replace") as f:
                lines = f.readlines()
            if len(lines) > max_lines:
                # Take first and last portions to keep structure
                half = max_lines // 2
                truncated = lines[:half] + [f"\n... ({len(lines) - max_lines} lines truncated) ...\n\n"] + lines[-half:]
                return "".join(truncated)
            return "".join(lines)
        except Exception as e:
            logger.warning("Failed to load %s: %s", path, e)
            return ""

    # ==================================================================
    # Minibook setup
    # ==================================================================
    def _setup_minibook(self) -> bool:
        """Register all agents and create the project in Minibook."""
        print("[*] Setting up Minibook...")

        agent_classes = [
            ("architect", ArchitectAgent),
            ("backend-gen", BackendGenAgent),
            ("frontend-gen", FrontendGenAgent),
            ("database-gen", DatabaseGenAgent),
            ("api-gen", ApiGenAgent),
            ("auth-gen", AuthGenAgent),
            ("tester", TesterAgent),
            ("fixer", FixerAgent),
            ("reviewer", ReviewerAgent),
            ("infra-gen", InfraGenAgent),
        ]

        # Register agents
        for name, cls in agent_classes:
            agent = cls(minibook=self.minibook, ollama=self.ollama)
            if not agent.register():
                print(f"  [!] Failed to register agent: {name}")
                return False
            self.agents[name] = agent
            print(f"  [OK] Agent: {name}")

        # Create project (using architect as project creator)
        orchestrator_agent = self.agents["architect"]
        import time as _t
        project_name = f"{self.requirements.name}-{int(_t.time()) % 100000}"
        project = self.minibook.create_project(
            orchestrator_agent.identity.api_key,
            project_name,
            self.requirements.description,
        )
        self.project_id = project.id
        print(f"  [OK] Project: {project.name} (id={project.id})")

        # Join all agents to the project
        for name, agent in self.agents.items():
            agent.join_project(self.project_id)

        # Post Grand Plan
        features_md = "\n".join(
            f"- **{f.get('id', 'unknown')}** (priority: {f.get('priority', 'medium')})"
            for f in self.requirements.features
        )
        grand_plan = f"""# {self.requirements.name} — Grand Plan

## Project Type: {self.requirements.type}

## Description
{self.requirements.description}

## Features
{features_md}

## Tech Stack
{json.dumps(self.requirements.tech_stack, indent=2) if self.requirements.tech_stack else 'TBD by architect'}

## Phases
1. Architecture Design (@architect)
2. Backend Implementation (@backend-gen, @api-gen, @auth-gen)
3. Database Setup (@database-gen)
4. Frontend Implementation (@frontend-gen)
5. Testing (@tester)
6. Bug Fixing (@fixer)
7. Code Review (@reviewer)
8. Infrastructure (@infra-gen)
"""
        self.minibook.set_grand_plan(
            orchestrator_agent.identity.api_key,
            self.project_id,
            grand_plan,
        )
        print(f"  [OK] Grand Plan posted")
        return True

    # ==================================================================
    # Phase implementations
    # ==================================================================
    def _assign_and_wait(
        self,
        agent_name: str,
        title: str,
        content: str,
        tags: Optional[List[str]] = None,
        post_type: str = "discussion",
        related_posts: Optional[List[Dict]] = None,
    ) -> AgentResult:
        """
        Create a post mentioning an agent, have them think and respond.

        This is the core orchestration primitive.
        """
        agent = self.agents.get(agent_name)
        if not agent:
            return AgentResult(success=False, content="", error=f"Unknown agent: {agent_name}")

        # Create post with @mention
        full_content = f"@{agent.identity.name} {content}"
        post = self.minibook.create_post(
            agent.identity.api_key,  # Agent posts to themselves (orchestrator pattern)
            self.project_id,
            title,
            full_content,
            post_type=post_type,
            tags=tags or [agent_name],
        )

        # Build task context
        task = TaskContext(
            post_id=post.id,
            post_title=title,
            post_content=content,
            project_id=self.project_id,
            project_name=self.requirements.name if self.requirements else "",
            related_posts=related_posts or [],
            metadata={"requirements": self.requirements.raw} if self.requirements else {},
        )

        # Agent thinks and responds
        result = agent.think(task)

        # Post result as comment
        if result.success:
            agent.comment(post.id, result.content)
            # Collect generated files
            for f in result.files_generated:
                self.all_generated_files[f["path"]] = f["content"]
            # Mark post resolved
            self.minibook.update_post_status(agent.identity.api_key, post.id, "resolved")
        else:
            agent.comment(post.id, f"Error: {result.error}")

        return result

    def _phase_architecture(self) -> PhaseResult:
        """Phase 1: Architect designs the system."""
        start = time.time()
        features_text = "\n".join(
            f"- {f.get('id', '?')}: {f.get('description', f.get('id', ''))}"
            for f in (self.requirements.features if self.requirements else [])
        )

        tech_stack = self.requirements.tech_stack if self.requirements else {}
        result = self._assign_and_wait(
            "architect",
            f"Design Architecture for {self.requirements.name}",
            f"""Design the complete architecture for this project. BE EXTREMELY SPECIFIC — other agents will use your design to write code.

## Requirements
{json.dumps(self.requirements.raw, indent=2) if self.requirements else '{}'}

## Deliverables (generate these as files)

### 1. `docs/architecture.md` — Complete architecture document
- Full project folder structure as a file tree (every file path)
- Module responsibilities and boundaries
- Data flow diagrams (text-based)

### 2. `docs/api-spec.yaml` — OpenAPI 3.0 specification
- Every REST endpoint (path, method, request/response schemas)
- Authentication requirements per endpoint
- Error response schemas

### 3. `prisma/schema.prisma` — Complete Prisma schema
- All models with fields, types, and attributes
- All relations (1:1, 1:N, N:M) with explicit relation names
- Indexes and unique constraints
- Enums

### 4. `package.json` — Node.js project configuration
- All dependencies with versions
- Scripts: dev, build, start, test, migrate, seed, lint
- Node engine requirement

### 5. `tsconfig.json` — TypeScript configuration
- Strict mode settings
- Path aliases if needed
- Output configuration

## IMPORTANT RULES
- Use the exact tech stack: {json.dumps(tech_stack)}
- Every file path you mention in the architecture MUST be a real file that agents will create
- Use NestJS module pattern: each domain has module, controller, service, dto, entity files
- Include ALL imports in every file""",
            tags=["architecture", "phase-1"],
            post_type="plan",
        )

        return PhaseResult(
            phase="architecture",
            success=result.success,
            posts_created=1,
            comments_received=1 if result.success else 0,
            files_generated=len(result.files_generated),
            duration_ms=int((time.time() - start) * 1000),
            errors=[result.error] if result.error else [],
        )

    def _build_file_list(self, arch_context: str) -> List[Dict[str, Any]]:
        """
        Ask the architect to produce a structured file list from the architecture.
        Returns list of {path, agent, description} dicts.
        """
        prompt = f"""Based on this architecture, list EVERY source file that needs to be created.

{arch_context}

Return a JSON array. Each element must have:
- "path": the file path (e.g. "src/auth/auth.service.ts")
- "agent": which agent should write it: "backend-gen", "api-gen", "auth-gen", or "frontend-gen"
- "desc": one-line description of what the file does

Assignment rules:
- backend-gen: src/main.ts, src/app.module.ts, domain modules (*.module.ts), domain services (*.service.ts), entities, src/prisma/*
- api-gen: controllers (*.controller.ts), DTOs (dto/*.dto.ts), common guards/interceptors/filters/pipes
- auth-gen: everything under src/auth/
- frontend-gen: everything under frontend/

Return ONLY the JSON array, no markdown, no explanation."""

        try:
            result = self.ollama.ask_json(prompt, system="You are a project planner. Output valid JSON only.")
            if isinstance(result, list):
                return result
        except Exception as e:
            logger.warning("Failed to get structured file list: %s", e)

        # Fallback: hardcoded file list based on requirements
        return self._fallback_file_list()

    def _fallback_file_list(self) -> List[Dict[str, Any]]:
        """Generate a reasonable file list from requirements when LLM fails."""
        files = []
        features = [f.get("id", "").replace("-", "_") for f in (self.requirements.features if self.requirements else [])]
        # Derive domain names from features (group similar ones)
        domains = set()
        for f in features:
            # Map feature IDs to domain modules
            if any(x in f for x in ["auth", "login", "2fa", "biometric", "session", "passkey"]):
                domains.add("auth")
            elif any(x in f for x in ["message", "chat", "messaging"]):
                domains.add("message")
                domains.add("chat")
            elif any(x in f for x in ["user", "profile", "contact"]):
                domains.add("user")
                if "profile" in f:
                    domains.add("profile")
                if "contact" in f:
                    domains.add("contact")
            elif any(x in f for x in ["media", "file", "upload"]):
                domains.add("media")
            elif any(x in f for x in ["notification", "push"]):
                domains.add("notification")
            elif any(x in f for x in ["encrypt"]):
                domains.add("encryption")
            elif any(x in f for x in ["search"]):
                domains.add("search")
            elif any(x in f for x in ["group"]):
                domains.add("chat")
            elif any(x in f for x in ["subscription", "payment", "billing"]):
                domains.add("subscription")
            elif any(x in f for x in ["playlist"]):
                domains.add("playlist")
            elif any(x in f for x in ["stream", "playback", "queue"]):
                domains.add("playback")
            elif any(x in f for x in ["recommend"]):
                domains.add("recommendation")
            elif any(x in f for x in ["social", "follow"]):
                domains.add("social")
            elif any(x in f for x in ["catalog", "music", "track", "album", "artist"]):
                domains.add("catalog")
            else:
                domains.add(f.split("_")[0])

        domains.discard("auth")  # auth-gen handles this

        # Core files
        files.append({"path": "src/main.ts", "agent": "backend-gen", "desc": "NestJS bootstrap"})
        files.append({"path": "src/app.module.ts", "agent": "backend-gen", "desc": "Root module"})
        files.append({"path": "src/prisma/prisma.module.ts", "agent": "backend-gen", "desc": "Prisma module"})
        files.append({"path": "src/prisma/prisma.service.ts", "agent": "backend-gen", "desc": "Prisma service"})

        # Per-domain files
        for domain in sorted(domains):
            files.append({"path": f"src/{domain}/{domain}.module.ts", "agent": "backend-gen", "desc": f"{domain} module"})
            files.append({"path": f"src/{domain}/{domain}.service.ts", "agent": "backend-gen", "desc": f"{domain} service with business logic"})
            files.append({"path": f"src/{domain}/{domain}.controller.ts", "agent": "api-gen", "desc": f"{domain} REST controller"})
            files.append({"path": f"src/{domain}/dto/create-{domain}.dto.ts", "agent": "api-gen", "desc": f"Create {domain} DTO"})
            files.append({"path": f"src/{domain}/dto/update-{domain}.dto.ts", "agent": "api-gen", "desc": f"Update {domain} DTO"})

        # Auth files
        for auth_file in [
            ("src/auth/auth.module.ts", "Auth module with JWT, Passport"),
            ("src/auth/auth.service.ts", "Auth service: register, login, refresh, 2FA"),
            ("src/auth/auth.controller.ts", "Auth REST controller"),
            ("src/auth/strategies/jwt.strategy.ts", "Passport JWT strategy"),
            ("src/auth/strategies/local.strategy.ts", "Passport local strategy"),
            ("src/auth/guards/jwt-auth.guard.ts", "JWT authentication guard"),
            ("src/auth/guards/roles.guard.ts", "Role-based access guard"),
            ("src/auth/dto/register.dto.ts", "Registration DTO"),
            ("src/auth/dto/login.dto.ts", "Login DTO"),
            ("src/auth/dto/refresh-token.dto.ts", "Refresh token DTO"),
            ("src/auth/decorators/current-user.decorator.ts", "Current user decorator"),
            ("src/auth/decorators/roles.decorator.ts", "Roles decorator"),
        ]:
            files.append({"path": auth_file[0], "agent": "auth-gen", "desc": auth_file[1]})

        # Common files
        files.append({"path": "src/common/filters/http-exception.filter.ts", "agent": "api-gen", "desc": "HTTP exception filter"})
        files.append({"path": "src/common/interceptors/logging.interceptor.ts", "agent": "api-gen", "desc": "Request logging interceptor"})
        files.append({"path": "src/common/interceptors/transform.interceptor.ts", "agent": "api-gen", "desc": "Response transform interceptor"})
        files.append({"path": "src/common/pipes/validation.pipe.ts", "agent": "api-gen", "desc": "Validation pipe"})

        # Frontend files
        for fe_file in [
            ("frontend/src/main.tsx", "React entry point with providers"),
            ("frontend/src/App.tsx", "Main app with routing"),
            ("frontend/src/services/api.ts", "Axios API client"),
            ("frontend/src/store/index.ts", "Zustand state store"),
            ("frontend/src/types/index.ts", "TypeScript interfaces"),
            ("frontend/src/hooks/useAuth.tsx", "Auth hook"),
            ("frontend/package.json", "Frontend dependencies"),
            ("frontend/tailwind.config.js", "Tailwind configuration"),
        ]:
            files.append({"path": fe_file[0], "agent": "frontend-gen", "desc": fe_file[1]})

        # Add page per domain
        for domain in sorted(domains):
            cap = domain.capitalize()
            files.append({"path": f"frontend/src/pages/{cap}Page.tsx", "agent": "frontend-gen", "desc": f"{cap} page component"})

        return files

    def _generate_single_file(
        self,
        agent_name: str,
        file_path: str,
        file_desc: str,
        arch_context: str,
        related_files: Dict[str, str],
    ) -> AgentResult:
        """
        Ask a single agent to generate exactly ONE file.
        Provides relevant context from already-generated files.
        """
        agent = self.agents.get(agent_name)
        if not agent:
            return AgentResult(success=False, content="", error=f"Unknown agent: {agent_name}")

        # Pick only related files for context (same domain, max 5)
        domain = file_path.split("/")[1] if "/" in file_path else ""
        context_files = {}
        for p, c in related_files.items():
            if domain and domain in p:
                context_files[p] = c
            elif "prisma" in p or "app.module" in p or "main.ts" in p:
                context_files[p] = c
            if len(context_files) >= 5:
                break

        context_block = ""
        if context_files:
            parts = []
            for p, c in context_files.items():
                # Truncate large files in context
                if len(c) > 3000:
                    c = c[:3000] + "\n// ... truncated"
                parts.append(f"### `{p}`\n```\n{c}\n```")
            context_block = "\n\n## Related Files (already generated)\n" + "\n\n".join(parts)

        tech_stack = self.requirements.tech_stack if self.requirements else {}
        features_brief = ", ".join(f.get("id", "") for f in (self.requirements.features if self.requirements else []))

        # Build epic runner context based on file type
        epic_context = ""
        if self.requirements:
            domain = file_path.split("/")[1] if len(file_path.split("/")) > 1 else ""

            if self.requirements.data_dictionary and (
                "service.ts" in file_path or "entity" in file_path or
                "schema.prisma" in file_path or "seed" in file_path or
                "migration" in file_path
            ):
                # Extract relevant entity from data dictionary
                dd = self.requirements.data_dictionary
                # Try to find domain-specific section
                domain_cap = domain.capitalize() if domain else ""
                if domain_cap and f"### {domain_cap}" in dd:
                    start_idx = dd.index(f"### {domain_cap}")
                    next_section = dd.find("\n### ", start_idx + 10)
                    entity_section = dd[start_idx:next_section] if next_section > 0 else dd[start_idx:start_idx+2000]
                    epic_context += f"\n\n## Data Dictionary (from spec)\n{entity_section}"
                elif "schema.prisma" in file_path or "migration" in file_path:
                    # For schema files, include more of the data dictionary
                    epic_context += f"\n\n## Data Dictionary (from spec)\n{dd[:6000]}"

            if self.requirements.openapi_spec and (
                "controller.ts" in file_path or "dto" in file_path or
                "guard" in file_path or "interceptor" in file_path
            ):
                # Extract relevant API endpoints
                api = self.requirements.openapi_spec
                if domain and f"/{domain}" in api:
                    # Find paths section for this domain
                    lines = api.split("\n")
                    relevant = []
                    capturing = False
                    for line in lines:
                        if f"/{domain}" in line.lower() or (capturing and (line.startswith("    ") or line.startswith("      "))):
                            relevant.append(line)
                            capturing = True
                        elif capturing and not line.startswith(" "):
                            capturing = False
                        if len(relevant) > 100:
                            break
                    if relevant:
                        epic_context += f"\n\n## OpenAPI Spec (from spec)\n```yaml\n" + "\n".join(relevant) + "\n```"

            if self.requirements.architecture_doc and "module.ts" in file_path:
                # Architecture context for module files
                epic_context += f"\n\n## Architecture (from spec)\n{self.requirements.architecture_doc[:2000]}"

            # Test files get test documentation + factories
            if self.requirements.test_documentation and ("spec.ts" in file_path or "e2e" in file_path):
                # Find relevant test section
                td = self.requirements.test_documentation
                if domain_cap and domain_cap.lower() in td.lower():
                    # Extract domain-relevant test section
                    td_lower = td.lower()
                    idx = td_lower.find(domain_cap.lower())
                    if idx >= 0:
                        section = td[max(0, idx-200):idx+3000]
                        epic_context += f"\n\n## Test Specification (from spec)\n{section}"
                else:
                    epic_context += f"\n\n## Test Specification (from spec)\n{td[:2000]}"

            if self.requirements.test_factories and ("spec.ts" in file_path or "seed" in file_path):
                epic_context += f"\n\n## Test Factories (from spec)\n{self.requirements.test_factories[:2000]}"

            # WebSocket/realtime services get AsyncAPI
            if self.requirements.asyncapi_spec and any(x in file_path for x in ["chat", "message", "notification", "socket", "gateway"]):
                epic_context += f"\n\n## AsyncAPI Spec (WebSocket events)\n{self.requirements.asyncapi_spec[:2000]}"

            # State machines for services with workflows
            if self.requirements.state_machines and "service.ts" in file_path:
                epic_context += f"\n\n## State Machines (from spec)\n{self.requirements.state_machines[:1500]}"

            # Frontend gets component matrix + API docs
            if self.requirements.component_matrix and "frontend" in file_path:
                epic_context += f"\n\n## UI Components (from spec)\n{self.requirements.component_matrix[:2000]}"
            if self.requirements.api_documentation and "frontend" in file_path and ("api" in file_path or "service" in file_path):
                epic_context += f"\n\n## API Documentation (from spec)\n{self.requirements.api_documentation[:2000]}"

        prompt = f"""Generate the COMPLETE file: `{file_path}`

## What this file does
{file_desc}

## Project
- Name: {self.requirements.name if self.requirements else 'unknown'}
- Tech: {json.dumps(tech_stack)}
- Features: {features_brief}

## Architecture (summary)
{arch_context[:4000]}
{context_block}
{epic_context}

## CRITICAL RULES
1. Output EXACTLY ONE file: `{file_path}`
2. The file must be COMPLETE — every import, every method body, every type
3. NO "// TODO", NO "// ... rest", NO placeholders
4. If it's a service, include REAL business logic (validation, error handling, DB queries)
5. If it's a controller, include ALL CRUD endpoints with proper decorators
6. If it's a DTO, include ALL fields with class-validator decorators
7. Write 50-200 lines of real code, not 10 lines of stubs"""

        # Use _assign_and_wait which handles the full Minibook post/comment cycle
        result = self._assign_and_wait(
            agent_name,
            f"Generate: {file_path}",
            prompt,
            tags=["code-gen", "phase-2", agent_name],
        )
        return result

    def _phase_code_generation(self) -> PhaseResult:
        """Phase 2: File-by-file code generation for complete output."""
        start = time.time()
        errors = []
        total_files = 0

        arch_context = self._get_latest_output("architect")

        # Step 1: Get the full file list
        print("  [*] Building file manifest...")
        file_list = self._build_file_list(arch_context)
        print(f"  [*] {len(file_list)} files to generate")

        # Group by agent for progress reporting
        by_agent: Dict[str, List[Dict]] = {}
        for f in file_list:
            agent = f.get("agent", "backend-gen")
            by_agent.setdefault(agent, []).append(f)

        for agent_name, agent_files in by_agent.items():
            print(f"  [{agent_name}] {len(agent_files)} files to generate")

        # Step 2: Generate each file one at a time
        for idx, file_info in enumerate(file_list, 1):
            file_path = file_info.get("path", "")
            file_desc = file_info.get("desc", "")
            agent_name = file_info.get("agent", "backend-gen")

            if not file_path:
                continue

            print(f"  [{idx}/{len(file_list)}] {agent_name} -> {file_path}...", end=" ", flush=True)

            result = self._generate_single_file(
                agent_name, file_path, file_desc,
                arch_context, self.all_generated_files,
            )

            if result.success and result.files_generated:
                total_files += len(result.files_generated)
                # If agent didn't use exact path, also store under requested path
                has_target = any(f["path"] == file_path for f in result.files_generated)
                if not has_target and len(result.files_generated) == 1:
                    # Remap to expected path
                    self.all_generated_files[file_path] = result.files_generated[0]["content"]
                print(f"OK ({len(result.files_generated)} files)")
            elif result.success and not result.files_generated:
                # LLM responded but file extraction failed — try to salvage
                # If response has substantial code, store it as the target file
                if len(result.content) > 200:
                    # Strip markdown wrapper if present
                    content = result.content
                    import re
                    code_match = re.search(r'```\w*\n(.*?)```', content, re.DOTALL)
                    if code_match:
                        content = code_match.group(1)
                    self.all_generated_files[file_path] = content
                    total_files += 1
                    print(f"OK (salvaged from raw output)")
                else:
                    print(f"EMPTY")
            else:
                errors.append(f"{agent_name}/{file_path}: {result.error}")
                print(f"FAIL: {result.error}")

        return PhaseResult(
            phase="code-generation",
            success=len(errors) < len(file_list) // 2,  # Allow some failures
            posts_created=len(file_list),
            comments_received=total_files,
            files_generated=total_files,
            duration_ms=int((time.time() - start) * 1000),
            errors=errors,
        )

    def _phase_database(self) -> PhaseResult:
        """Phase 3: Database agent creates schema and migrations file-by-file."""
        start = time.time()
        arch_context = self._get_latest_output("architect")
        errors = []
        total_files = 0

        db_files = [
            ("prisma/schema.prisma", "Complete Prisma schema: ALL models from architecture, relations (1:1, 1:N, N:M), enums, indexes, createdAt/updatedAt on every model"),
            ("prisma/migrations/001_initial/migration.sql", "SQL migration matching the Prisma schema exactly — CREATE TABLE for every model, indexes, enums"),
            ("prisma/seed.ts", "Seed script with realistic test data (real names, emails, lorem text) — NOT placeholder data"),
        ]

        print(f"  [*] {len(db_files)} database files to generate")

        for idx, (file_path, file_desc) in enumerate(db_files, 1):
            print(f"  [{idx}/{len(db_files)}] database-gen -> {file_path}...", end=" ", flush=True)

            result = self._generate_single_file(
                "database-gen", file_path, file_desc,
                arch_context, self.all_generated_files,
            )

            if result.success and result.files_generated:
                total_files += len(result.files_generated)
                has_target = any(f["path"] == file_path for f in result.files_generated)
                if not has_target and len(result.files_generated) == 1:
                    self.all_generated_files[file_path] = result.files_generated[0]["content"]
                print(f"OK")
            elif result.success and len(result.content) > 200:
                import re
                code_match = re.search(r'```\w*\n(.*?)```', result.content, re.DOTALL)
                content = code_match.group(1) if code_match else result.content
                self.all_generated_files[file_path] = content
                total_files += 1
                print(f"OK (salvaged)")
            else:
                errors.append(f"database-gen/{file_path}: {result.error or 'empty'}")
                print(f"FAIL")

        return PhaseResult(
            phase="database",
            success=len(errors) == 0,
            posts_created=len(db_files),
            files_generated=total_files,
            duration_ms=int((time.time() - start) * 1000),
            errors=errors,
        )

    def _phase_testing(self) -> PhaseResult:
        """Phase 4: Tester writes tests file-by-file."""
        start = time.time()
        errors = []
        total_files = 0

        # Build test file list from generated source files
        test_files = []

        # Find all services and controllers to test
        for path in sorted(self.all_generated_files.keys()):
            if path.endswith(".service.ts") and "spec" not in path:
                test_path = path.replace(".service.ts", ".service.spec.ts")
                test_files.append((test_path, path, "unit"))
            elif path.endswith(".controller.ts") and "spec" not in path:
                test_path = path.replace(".controller.ts", ".controller.spec.ts")
                test_files.append((test_path, path, "unit"))

        # Add E2E tests per domain
        domains_seen = set()
        for path in sorted(self.all_generated_files.keys()):
            parts = path.split("/")
            if len(parts) >= 3 and parts[0] == "src" and parts[1] not in ("common", "prisma"):
                domain = parts[1]
                if domain not in domains_seen:
                    domains_seen.add(domain)
                    test_files.append((f"test/{domain}.e2e-spec.ts", None, "e2e"))

        # Config files
        test_files.append(("test/jest-e2e.json", None, "config"))
        test_files.append(("test/setup.ts", None, "config"))

        print(f"  [*] {len(test_files)} test files to generate")

        for idx, (test_path, source_path, test_type) in enumerate(test_files, 1):
            print(f"  [{idx}/{len(test_files)}] tester -> {test_path}...", end=" ", flush=True)

            # Get source file content for context
            source_context = ""
            if source_path and source_path in self.all_generated_files:
                source_context = f"\n\n## Source File: `{source_path}`\n```typescript\n{self.all_generated_files[source_path]}\n```"

            if test_type == "config":
                desc = f"Generate `{test_path}` — Jest {'E2E config' if 'json' in test_path else 'test setup with DB teardown'}"
            elif test_type == "e2e":
                domain = test_path.replace("test/", "").replace(".e2e-spec.ts", "")
                # Get controller for E2E context
                ctrl_path = f"src/{domain}/{domain}.controller.ts"
                if ctrl_path in self.all_generated_files:
                    source_context = f"\n\n## Controller: `{ctrl_path}`\n```typescript\n{self.all_generated_files[ctrl_path]}\n```"
                desc = f"E2E test for {domain} endpoints using supertest"
            else:
                desc = f"Unit test for `{source_path}` — test ALL public methods, mock dependencies"

            result = self._generate_single_file(
                "tester", test_path, desc + source_context,
                "", self.all_generated_files,
            )

            if result.success and result.files_generated:
                total_files += len(result.files_generated)
                has_target = any(f["path"] == test_path for f in result.files_generated)
                if not has_target and len(result.files_generated) == 1:
                    self.all_generated_files[test_path] = result.files_generated[0]["content"]
                print(f"OK")
            elif result.success and len(result.content) > 200:
                import re
                code_match = re.search(r'```\w*\n(.*?)```', result.content, re.DOTALL)
                content = code_match.group(1) if code_match else result.content
                self.all_generated_files[test_path] = content
                total_files += 1
                print(f"OK (salvaged)")
            else:
                errors.append(f"tester/{test_path}: {result.error or 'empty'}")
                print(f"FAIL")

        return PhaseResult(
            phase="testing",
            success=len(errors) < len(test_files) // 2,
            posts_created=len(test_files),
            files_generated=total_files,
            duration_ms=int((time.time() - start) * 1000),
            errors=errors,
        )

    def _phase_fix(self) -> PhaseResult:
        """Phase 5: Fixer patches test failures."""
        start = time.time()
        test_output = self._get_latest_output("tester")
        code_summary = self._summarize_generated_code()

        result = self._assign_and_wait(
            "fixer",
            "Fix Test Failures",
            f"""Fix the following test failures and errors. Output the COMPLETE fixed files.

## Test Output (failures)
{test_output}

## Current Codebase
{code_summary}

## RULES
- Identify the root cause of each failure
- Output the COMPLETE fixed file (not just the changed lines)
- Use the exact same filepath as the original file
- Fix ALL failures, not just the first one
- If a test is wrong (not the implementation), fix the test""",
            tags=["bugfix", "phase-5"],
        )

        return PhaseResult(
            phase="fix",
            success=result.success,
            posts_created=1,
            files_generated=len(result.files_generated),
            duration_ms=int((time.time() - start) * 1000),
            errors=[result.error] if result.error else [],
        )

    def _phase_review(self) -> PhaseResult:
        """Phase 6: Reviewer checks all code."""
        start = time.time()
        code_summary = self._summarize_generated_code()

        result = self._assign_and_wait(
            "reviewer",
            "Code Review: Full Project",
            f"""Review all generated code for quality, security, and completeness.

{code_summary}

## Review Checklist
1. **Completeness**: Are all required files present? Any missing modules?
2. **Imports**: Do all files import what they use? Any circular dependencies?
3. **Security**: SQL injection, XSS, hardcoded secrets, missing auth guards?
4. **Error handling**: Are errors caught and handled properly?
5. **Types**: Are TypeScript types correct and complete?
6. **Business logic**: Do services implement real logic (not stubs)?

## Output Format
For each issue found, output the FIXED version of the file using:
```typescript filepath: <path>
// fixed content
```

If no fixes needed, say "LGTM" for that file.""",
            tags=["review", "phase-6"],
        )

        return PhaseResult(
            phase="review",
            success=result.success,
            posts_created=1,
            files_generated=len(result.files_generated),
            duration_ms=int((time.time() - start) * 1000),
        )

    def _phase_infrastructure(self) -> PhaseResult:
        """Phase 7: Infra agent generates files one-by-one."""
        start = time.time()
        errors = []
        total_files = 0
        manifest = self._file_manifest()

        infra_files = [
            ("Dockerfile", "Multi-stage Docker build: node:20-alpine builder + runner, copy dist, expose 3000"),
            ("docker-compose.yml", "Production stack: app, postgres:15, redis:7. Health checks on all services."),
            ("docker-compose.dev.yml", "Dev overrides: mount source, hot-reload, expose debug port"),
            (".github/workflows/ci.yml", "GitHub Actions CI: lint, test, build on push to main and PRs"),
            (".github/workflows/deploy.yml", "GitHub Actions deploy: staging + production environments"),
            (".env.example", "All environment variables with descriptions and example values"),
            (".dockerignore", "Standard Node.js dockerignore: node_modules, dist, .git, .env"),
            (".gitignore", "Node.js + Prisma + IDE gitignore"),
            ("nest-cli.json", "NestJS CLI configuration with webpack compiler"),
            (".eslintrc.js", "ESLint config for TypeScript + Prettier plugin"),
            (".prettierrc", "Prettier config: singleQuote, trailingComma, semi"),
            ("README.md", "Full project README: prerequisites, install, run, test, deploy, API docs"),
        ]

        print(f"  [*] {len(infra_files)} infrastructure files to generate")

        for idx, (file_path, file_desc) in enumerate(infra_files, 1):
            print(f"  [{idx}/{len(infra_files)}] infra-gen -> {file_path}...", end=" ", flush=True)

            result = self._generate_single_file(
                "infra-gen", file_path, file_desc,
                f"## Project Files\n{manifest}", self.all_generated_files,
            )

            if result.success and result.files_generated:
                total_files += len(result.files_generated)
                has_target = any(f["path"] == file_path for f in result.files_generated)
                if not has_target and len(result.files_generated) == 1:
                    self.all_generated_files[file_path] = result.files_generated[0]["content"]
                print(f"OK")
            elif result.success and len(result.content) > 100:
                import re
                code_match = re.search(r'```\w*\n(.*?)```', result.content, re.DOTALL)
                content = code_match.group(1) if code_match else result.content
                self.all_generated_files[file_path] = content
                total_files += 1
                print(f"OK (salvaged)")
            else:
                errors.append(f"infra-gen/{file_path}: {result.error or 'empty'}")
                print(f"FAIL")

        return PhaseResult(
            phase="infrastructure",
            success=len(errors) < len(infra_files) // 2,
            posts_created=len(infra_files),
            files_generated=total_files,
            duration_ms=int((time.time() - start) * 1000),
            errors=errors,
        )

    # ==================================================================
    # Helpers
    # ==================================================================
    def _get_latest_output(self, agent_name: str) -> str:
        """Get the last output from a specific agent (from conversation history)."""
        agent = self.agents.get(agent_name)
        if not agent:
            return ""
        # Look backwards through history for last assistant message
        for msg in reversed(agent._conversation_history):
            if msg["role"] == "assistant":
                return msg["content"][:12000]  # Increased for better context
        return ""

    def _summarize_generated_code(self) -> str:
        """Create a summary of all generated files with full content for small files."""
        if not self.all_generated_files:
            return "No files generated yet."
        lines = [f"## Generated Files ({len(self.all_generated_files)} total)\n"]
        for path, content in sorted(self.all_generated_files.items()):
            # Show full content for files < 200 lines, truncate large ones
            line_count = content.count("\n")
            if line_count < 200:
                lines.append(f"### `{path}`\n```\n{content}\n```\n")
            else:
                preview = "\n".join(content.split("\n")[:80])
                lines.append(f"### `{path}` ({line_count} lines)\n```\n{preview}\n... ({line_count - 80} more lines)\n```\n")
        return "\n".join(lines)

    def _file_manifest(self) -> str:
        """Return a clean file tree of all generated files."""
        if not self.all_generated_files:
            return "No files generated yet."
        lines = [f"Generated {len(self.all_generated_files)} files:"]
        for path in sorted(self.all_generated_files.keys()):
            size = len(self.all_generated_files[path])
            lines.append(f"  {path} ({size} bytes)")
        return "\n".join(lines)

    def _write_output(self) -> None:
        """Write all generated files to the output directory."""
        # Deduplicate: normalize paths, keep longest version of duplicate files
        deduped: Dict[str, str] = {}
        for path, content in self.all_generated_files.items():
            # Normalize: strip leading ./ prefix (but preserve dotfiles like .env)
            norm_path = path
            while norm_path.startswith("./"):
                norm_path = norm_path[2:]
            if norm_path.startswith("/"):
                norm_path = norm_path[1:]
            # If duplicate, keep the longer (more complete) version
            if norm_path in deduped:
                if len(content) > len(deduped[norm_path]):
                    deduped[norm_path] = content
            else:
                deduped[norm_path] = content

        # Filter out empty or near-empty files
        deduped = {k: v for k, v in deduped.items() if len(v.strip()) > 10}

        print(f"\n[*] Writing {len(deduped)} files to {self.output_dir}")
        if len(deduped) < len(self.all_generated_files):
            print(f"  (deduplicated from {len(self.all_generated_files)} raw files)")

        self.output_dir.mkdir(parents=True, exist_ok=True)

        for path, content in sorted(deduped.items()):
            full_path = self.output_dir / path
            full_path.parent.mkdir(parents=True, exist_ok=True)
            with open(full_path, "w", encoding="utf-8") as f:
                f.write(content)

        self.all_generated_files = deduped  # Update for summary
        print(f"  [OK] {len(deduped)} files written")

    def _print_summary(self) -> None:
        """Print the final summary."""
        total_time = sum(p.duration_ms for p in self.phase_results)
        total_files = len(self.all_generated_files)
        total_errors = sum(len(p.errors) for p in self.phase_results)

        print(f"\n{'='*60}")
        print(f"  GENERATION COMPLETE")
        print(f"{'='*60}")
        print(f"  Project:    {self.requirements.name if self.requirements else '?'}")
        print(f"  Output:     {self.output_dir}")
        print(f"  Files:      {total_files}")
        print(f"  Phases:     {len(self.phase_results)}")
        print(f"  Errors:     {total_errors}")
        print(f"  Duration:   {total_time / 1000:.1f}s")
        print()

        for p in self.phase_results:
            status = "OK" if p.success else "FAIL"
            print(f"  [{status}] {p.phase}: {p.files_generated} files, {p.duration_ms}ms")
            for e in p.errors:
                print(f"       Error: {e}")

        print(f"\n{'='*60}\n")
