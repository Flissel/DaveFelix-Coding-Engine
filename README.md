# Coding Engine

Autonomous code generation platform -- 10 AI agents collaborate in [Minibook](https://github.com/Flissel/minibook) to generate complete projects from JSON requirements, powered by local LLMs via [Ollama](https://ollama.com).

## Architecture

```
                    MINIBOOK (Collaboration Hub)
    +------------------------------------------------------+
    |  architect   backend-gen   frontend-gen               |
    |  database-gen   api-gen   auth-gen                    |
    |  tester   fixer   reviewer   infra-gen                |
    |                                                        |
    |  Each agent = Minibook account + Ollama LLM            |
    |  Communication = Posts, Comments, @mentions            |
    +------------------------+-----------------------------+
                             |
                    MASTER ORCHESTRATOR
                    (reads requirements.json,
                     assigns tasks, monitors,
                     drives convergence loop)
                             |
                    OUTPUT: Complete Project
                             |
                    DAVELOVABLE (optional)
                    (Live Preview UI)
```

## Quick Start

### Prerequisites

```bash
# 1. Ollama (local LLM)
ollama pull qwen2.5-coder:7b

# 2. Minibook (agent collaboration platform)
cd ../minibook
pip install -r requirements.txt
python run.py  # starts on port 3456

# 3. Python dependencies
cd ../Coding_engine
pip install httpx
```

### Run

```bash
python run_engine.py --project Data/all_services/whatsapp
```

### Options

```
--project, -p      Path to project with requirements.json (required)
--output, -o       Output directory (default: output/<project-name>)
--model, -m        Ollama model (default: qwen2.5-coder:7b)
--ollama-url       Ollama URL (default: http://localhost:11434)
--minibook-url     Minibook URL (default: http://localhost:3456)
--max-fix-rounds   Bug-fix iterations (default: 3)
--verbose, -v      Debug logging
```

## How It Works

### 1. Requirements (Input)

```json
{
  "name": "whatsapp-messaging-service",
  "type": "nestjs",
  "features": [
    {"id": "phone-registration", "priority": "high"},
    {"id": "2fa-auth", "priority": "high"},
    {"id": "real-time-messaging", "priority": "high"}
  ],
  "tech_stack": {
    "backend": "NestJS + TypeScript",
    "database": "PostgreSQL + Prisma"
  }
}
```

### 2. Orchestration Phases

| Phase | Agent | What Happens |
|-------|-------|-------------|
| 1. Architecture | `architect` | Designs folder structure, DB schema, API contracts |
| 2. Code Gen | `backend-gen`, `api-gen`, `auth-gen`, `frontend-gen` | Implements all modules |
| 3. Database | `database-gen` | Creates Prisma schema, migrations, seeds |
| 4. Testing | `tester` | Writes unit + integration + E2E tests |
| 5. Fix Loop | `fixer` | Patches failures, re-tests (up to 3 rounds) |
| 6. Review | `reviewer` | Code quality, security, architecture check |
| 7. Infra | `infra-gen` | Docker, CI/CD, config, health checks |

### 3. Agent Communication (via Minibook)

Agents don't call each other directly. They communicate through Minibook posts:

```
Orchestrator -> POST "Design Architecture" (@architect)
Architect    -> COMMENT with folder structure + DB schema
Orchestrator -> POST "Implement Backend" (@backend-gen) [includes architect's output]
Backend-Gen  -> COMMENT with generated NestJS services
Orchestrator -> POST "Write Tests" (@tester) [includes all generated code]
...
```

### 4. Output

Complete project in `output/<project-name>/` with:
- Full source code (backend + frontend)
- Database schema + migrations
- Tests (unit, integration, E2E)
- Docker + CI/CD configs
- Documentation

## Project Structure

```
Coding_engine/
|-- run_engine.py                 # CLI entry point
|-- src/engine/
|   |-- ollama_client.py          # Ollama REST API wrapper
|   |-- minibook_client.py        # Minibook REST API wrapper
|   |-- minibook_agent.py         # Base agent class
|   |-- master_orchestrator.py    # Main orchestrator
|   +-- agents/
|       |-- architect.py          # Software architect
|       |-- backend_gen.py        # Backend code generator
|       |-- frontend_gen.py       # Frontend code generator
|       |-- database_gen.py       # Database engineer
|       |-- api_gen.py            # API developer
|       |-- auth_gen.py           # Auth & security
|       |-- tester.py             # QA & test engineer
|       |-- fixer.py              # Bug fixer
|       |-- reviewer.py           # Code reviewer
|       +-- infra_gen.py          # DevOps engineer
|-- Data/all_services/
|   +-- whatsapp/
|       +-- requirements.json     # Project requirements
|-- src/services/                 # 902 emergent pipeline modules
+-- tests/                        # Unit tests
```

## Emergent Pipeline

The engine includes 902 service modules providing infrastructure:
- Pipeline data processing (validators, transformers, encoders, etc.)
- Agent workflow management (schedulers, trackers, coordinators, etc.)
- Pipeline step orchestration (guards, profilers, sequencers, etc.)
- Agent task lifecycle (estimators, recyclers, dispatchers, etc.)

952 compile-clean entries, 389 integration tests passing.

## Connected Projects

| Project | Purpose |
|---------|---------|
| [Minibook](https://github.com/Flissel/minibook) | Agent collaboration platform (posts, comments, @mentions) |
| [DaveLovable](https://github.com/Flissel/DaveLovable) | Vibe coding UI with live preview (separate, optional) |
| [Ollama](https://ollama.com) | Local LLM runtime (qwen2.5-coder) |

## License

MIT
