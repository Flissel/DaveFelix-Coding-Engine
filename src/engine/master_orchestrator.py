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
        """Load requirements.json from project path."""
        req_file = self.project_path / "requirements.json"
        if not req_file.exists():
            print(f"[!] requirements.json not found in {self.project_path}")
            return None

        with open(req_file, "r", encoding="utf-8") as f:
            raw = json.load(f)

        return ProjectRequirements(
            name=raw.get("name", self.project_path.name),
            type=raw.get("type", "unknown"),
            description=raw.get("description", ""),
            features=raw.get("features", []),
            tech_stack=raw.get("tech_stack", {}),
            raw=raw,
        )

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

    def _phase_code_generation(self) -> PhaseResult:
        """Phase 2: Backend, API, Auth, Frontend agents generate code."""
        start = time.time()
        errors = []
        total_files = 0

        # Get architecture plan from architect's previous output
        arch_context = self._get_latest_output("architect")
        manifest = self._file_manifest()

        gen_tasks = [
            ("backend-gen", "Implement Backend Services",
             f"""Based on the architecture plan, implement ALL backend service files.

## Architecture
{arch_context}

## Already Generated Files
{manifest}

## YOUR TASK — Generate these files (COMPLETE, not snippets):
1. `src/main.ts` — NestJS bootstrap with CORS, validation, Swagger
2. `src/app.module.ts` — Root module importing ALL feature modules
3. Each domain module: `src/<domain>/<domain>.module.ts`
4. Each domain service: `src/<domain>/<domain>.service.ts` (FULL business logic, not stubs)
5. Each domain entity: `src/<domain>/entities/<domain>.entity.ts`

## RULES
- Every file must be COMPLETE — all imports, full method bodies, error handling
- DO NOT generate files that another agent is responsible for (auth, API controllers, frontend, infra)
- Use NestJS decorators: @Module, @Injectable, @InjectRepository
- Include proper error handling with HttpException
- Services must have real business logic, not just pass-through to repository"""),

            ("api-gen", "Implement API Endpoints",
             f"""Based on the architecture plan, implement ALL REST API controllers and DTOs.

## Architecture
{arch_context}

## Already Generated Files
{manifest}

## YOUR TASK — Generate these files:
1. Each domain controller: `src/<domain>/<domain>.controller.ts`
2. Each DTO: `src/<domain>/dto/create-<domain>.dto.ts`, `update-<domain>.dto.ts`
3. Guards: `src/common/guards/` (jwt, roles, throttle)
4. Interceptors: `src/common/interceptors/` (logging, transform)
5. Filters: `src/common/filters/http-exception.filter.ts`
6. Pipes: `src/common/pipes/validation.pipe.ts`

## RULES
- Controllers must use @Controller, @Get, @Post, @Put, @Delete, @Patch
- DTOs must use class-validator decorators (@IsString, @IsEmail, etc.)
- Include @ApiTags, @ApiOperation, @ApiResponse for Swagger
- DO NOT regenerate services or entities (backend-gen does those)
- DO NOT regenerate auth files (auth-gen does those)"""),

            ("auth-gen", "Implement Authentication System",
             f"""Implement the COMPLETE authentication system.

## Architecture
{arch_context}

## Already Generated Files
{manifest}

## YOUR TASK — Generate these files:
1. `src/auth/auth.module.ts` — Auth module with JWT, Passport
2. `src/auth/auth.service.ts` — Register, login, logout, refresh, verify-2fa
3. `src/auth/auth.controller.ts` — Auth endpoints
4. `src/auth/strategies/jwt.strategy.ts` — Passport JWT strategy
5. `src/auth/strategies/local.strategy.ts` — Passport local strategy
6. `src/auth/guards/jwt-auth.guard.ts` — JWT guard
7. `src/auth/guards/roles.guard.ts` — RBAC guard
8. `src/auth/dto/register.dto.ts`, `login.dto.ts`, `refresh-token.dto.ts`
9. `src/auth/decorators/roles.decorator.ts`, `current-user.decorator.ts`

## RULES
- Use @nestjs/passport and @nestjs/jwt
- Implement bcrypt password hashing (NOT plaintext)
- JWT access + refresh token pattern
- Include 2FA/TOTP support if in requirements
- FULL implementation — no TODO comments, no placeholder methods"""),

            ("frontend-gen", "Implement Frontend Components",
             f"""Build ALL React frontend components.

## Architecture
{arch_context}

## Already Generated Files
{manifest}

## YOUR TASK — Generate these files:
1. `frontend/src/App.tsx` — Main app with routing
2. `frontend/src/main.tsx` — Entry point with providers
3. `frontend/src/pages/` — Page components for each feature
4. `frontend/src/components/` — Reusable UI components
5. `frontend/src/hooks/` — Custom hooks (useAuth, useSocket, etc.)
6. `frontend/src/services/api.ts` — API client with Axios
7. `frontend/src/store/` — State management (Zustand or Context)
8. `frontend/src/types/` — TypeScript interfaces
9. `frontend/package.json` — Frontend dependencies
10. `frontend/tailwind.config.js` — Tailwind configuration

## RULES
- Use React 18 + TypeScript + Tailwind CSS
- All components must be functional with hooks
- Use react-router-dom v6 for routing
- Include proper loading states, error boundaries
- Responsive design (mobile-first)
- All files go under `frontend/` directory prefix"""),
        ]

        for agent_name, title, content in gen_tasks:
            print(f"  [{agent_name}] {title}...")
            result = self._assign_and_wait(
                agent_name, title, content,
                tags=["code-gen", "phase-2", agent_name],
            )
            if result.success:
                total_files += len(result.files_generated)
                print(f"  [{agent_name}] Done: {len(result.files_generated)} files")
            else:
                errors.append(f"{agent_name}: {result.error}")
                print(f"  [{agent_name}] Error: {result.error}")

        return PhaseResult(
            phase="code-generation",
            success=len(errors) == 0,
            posts_created=len(gen_tasks),
            comments_received=len(gen_tasks),
            files_generated=total_files,
            duration_ms=int((time.time() - start) * 1000),
            errors=errors,
        )

    def _phase_database(self) -> PhaseResult:
        """Phase 3: Database agent creates schema and migrations."""
        start = time.time()
        arch_context = self._get_latest_output("architect")
        manifest = self._file_manifest()

        result = self._assign_and_wait(
            "database-gen",
            "Create Database Schema & Migrations",
            f"""Create the complete database layer.

## Architecture
{arch_context}

## Already Generated Files
{manifest}

## YOUR TASK — Generate these files:
1. `prisma/schema.prisma` — Complete Prisma schema (ALL models, relations, enums, indexes)
2. `prisma/migrations/001_initial/migration.sql` — Initial SQL migration
3. `prisma/seed.ts` — Seed script with realistic test data
4. `src/prisma/prisma.module.ts` — NestJS Prisma module
5. `src/prisma/prisma.service.ts` — Prisma service with onModuleInit/onModuleDestroy

## RULES
- Schema must match ALL entities from the architecture
- Include proper indexes for common queries
- Add cascade delete/update where appropriate
- Seed data must be realistic (not "test1", "test2")
- Include createdAt/updatedAt on all models""",
            tags=["database", "phase-3"],
        )

        return PhaseResult(
            phase="database",
            success=result.success,
            posts_created=1,
            files_generated=len(result.files_generated),
            duration_ms=int((time.time() - start) * 1000),
            errors=[result.error] if result.error else [],
        )

    def _phase_testing(self) -> PhaseResult:
        """Phase 4: Tester writes tests for all generated code."""
        start = time.time()

        # Gather all generated code as context
        code_summary = self._summarize_generated_code()

        result = self._assign_and_wait(
            "tester",
            "Write Tests for All Modules",
            f"""Write comprehensive tests for all generated code.

## Generated Code
{code_summary}

## YOUR TASK — Generate test files:
1. Unit tests for each service: `src/<domain>/<domain>.service.spec.ts`
2. Controller tests: `src/<domain>/<domain>.controller.spec.ts`
3. E2E tests: `test/<domain>.e2e-spec.ts`
4. `test/jest-e2e.json` — E2E Jest config
5. `test/setup.ts` — Test setup with database teardown

## RULES
- Use Jest + @nestjs/testing
- Mock dependencies with jest.fn() and custom providers
- Test both success and error paths
- E2E tests use supertest against real HTTP endpoints
- Include realistic test data
- DO NOT write placeholder tests — each test must assert real behavior
- Each service spec must test ALL public methods""",
            tags=["testing", "phase-4"],
        )

        return PhaseResult(
            phase="testing",
            success=result.success,
            posts_created=1,
            files_generated=len(result.files_generated),
            duration_ms=int((time.time() - start) * 1000),
            errors=[result.error] if result.error else [],
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
        """Phase 7: Infra agent adds Docker, CI/CD, configs."""
        start = time.time()
        manifest = self._file_manifest()

        result = self._assign_and_wait(
            "infra-gen",
            "Add Infrastructure (Docker, CI/CD, Config)",
            f"""Add complete infrastructure files for production deployment.

## Generated Files
{manifest}

## YOUR TASK — Generate these files:
1. `Dockerfile` — Multi-stage build (builder + runner)
2. `docker-compose.yml` — Full stack: app, postgres, redis, (optional: nginx)
3. `docker-compose.dev.yml` — Dev overrides with hot-reload
4. `.github/workflows/ci.yml` — GitHub Actions: lint, test, build, push
5. `.github/workflows/deploy.yml` — Deploy workflow (staging + production)
6. `.env.example` — All environment variables with descriptions
7. `.dockerignore` — Standard Node.js dockerignore
8. `.gitignore` — Standard Node.js + Prisma gitignore
9. `nest-cli.json` — NestJS CLI configuration
10. `.eslintrc.js` — ESLint config for TypeScript
11. `.prettierrc` — Prettier config
12. `README.md` — Project README with setup instructions

## RULES
- Dockerfile must use node:20-alpine
- Docker Compose must include health checks for all services
- CI must run on push to main and PRs
- .env.example must list ALL variables used in the codebase
- README must include: prerequisites, installation, running, testing, deployment""",
            tags=["infrastructure", "phase-7"],
        )

        return PhaseResult(
            phase="infrastructure",
            success=result.success,
            posts_created=1,
            files_generated=len(result.files_generated),
            duration_ms=int((time.time() - start) * 1000),
            errors=[result.error] if result.error else [],
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
            # Normalize: strip leading ./ or /
            norm_path = path.lstrip("./").lstrip("/")
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
