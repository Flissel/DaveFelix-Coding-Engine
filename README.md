# Coding Engine

[![License: Apache 2.0](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://www.apache.org/licenses/LICENSE-2.0)
[![Python 3.11+](https://img.shields.io/badge/python-3.11+-blue.svg)](https://www.python.org/downloads/)
[![TypeScript](https://img.shields.io/badge/TypeScript-5.0+-blue.svg)](https://www.typescriptlang.org/)
[![Docker](https://img.shields.io/badge/Docker-Required-blue.svg)](https://www.docker.com/)

> **Society of Mind Autonomous Code Generation Platform**

Coding Engine transforms structured JSON requirements into fully functional, production-ready software applications using a 3-layer multi-agent architecture with 37+ specialized AI agents. Built on a push-based EventBus, the system iterates autonomously through generate-build-test-fix cycles until convergence.

## How It Works

```
Requirements JSON → 37+ AI Agents → Build/Test/Fix Loop → Production-Ready Project
```

The system reads your project requirements, distributes work across specialized agents (code generation, database schemas, API routes, auth, tests, deployment), and iterates until all builds pass, tests succeed, and quality checks converge.

## Features

- **Autonomous Code Generation** — Generate complete full-stack applications from JSON requirements
- **37+ Specialized Agents** — Parallel agents for code, schemas, APIs, auth, tests, validation, deployment
- **3-Layer Architecture** — Society of Mind (Layer 1) + Epic Orchestrator (Layer 2) + MCP Plugins (Layer 3)
- **Self-Correcting** — Automatic build/test error fixing until convergence criteria are met
- **Push-Based EventBus** — Agents communicate via async event queues, not polling
- **Task Enrichment** — LLM-assisted schema discovery enriches tasks with documentation context before generation
- **Differential Analysis** — Compares generated code against requirements to find coverage gaps
- **Cross-Layer Validation** — Static FE/BE consistency checks (routes, DTOs, security)
- **Live Preview** — Real-time VNC streaming of running applications during generation
- **Review Gate** — Pause generation, provide feedback via chat, resume with context
- **Vision AI** — Claude Vision analyzes screenshots for UI/UX issues
- **Electron Dashboard** — Modern UI for project management and monitoring
- **Fungus Memory** — RAG-based semantic search (via [la_fungus_search](https://github.com/Flissel/la_fungus_search)) for persistent project knowledge
- **Multi-Tech Support** — React, Vue, Node.js, NestJS, Python, FastAPI, Electron

## Quick Start

### Prerequisites

- Python 3.11+
- Node.js 20+
- Docker Desktop
- Anthropic API Key (Claude)

### Installation

```bash
# Clone with submodules
git clone --recurse-submodules https://github.com/Flissel/Coding_engine.git
cd Coding_engine

# Create virtual environment
python -m venv venv
source venv/bin/activate  # Windows: venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt

# Copy environment template and add your API keys
cp .env.example .env
# Edit .env: set ANTHROPIC_API_KEY, OPENROUTER_API_KEY (optional)
```

### Usage

```bash
# Basic: Generate project from requirements (Society of Mind pipeline)
python run_society_hybrid.py requirements.json --output-dir ./output

# Unified Engine: All 3 layers connected (SoM + Epic Orchestrator + MCP)
python run_engine.py --project-path Data/all_services/whatsapp

# Epic Orchestrator: Run task-based pipeline with parallel execution
python run_epic001_live.py --parallel 3 --skip-failed-deps

# Fast mode (quick prototyping, relaxed convergence)
python run_society_hybrid.py requirements.json --fast

# Autonomous mode (runs until 100% complete)
python run_society_hybrid.py requirements.json --autonomous

# Differential analysis: Find gaps between docs and generated code
python run_differential_pipeline.py --project-path ./output
```

### Requirements JSON Format

```json
{
  "name": "my-app",
  "type": "react",
  "description": "A modern web application",
  "features": [
    {
      "id": "auth",
      "name": "User Authentication",
      "description": "JWT-based login with email/password",
      "priority": "high"
    },
    {
      "id": "dashboard",
      "name": "Dashboard",
      "description": "Main dashboard with statistics",
      "priority": "high"
    }
  ]
}
```

## Architecture

### 3-Layer System

```
┌─────────────────────────────────────────────────────────────────┐
│  LAYER 1: Society of Mind Pipeline (37+ Agents)                 │
│                                                                 │
│  EventBus (push)    SharedState      Convergence Loop           │
│  src/mind/          src/mind/        src/mind/orchestrator.py   │
│                                                                 │
│  Skills (12)        Engine (6-phase) Agents (37+)               │
│  .claude/skills/    src/engine/      src/agents/                │
├─────────────────────────────────────────────────────────────────┤
│  LAYER 2: Epic Orchestrator (55+ Tools)                         │
│                                                                 │
│  EpicOrchestrator   TaskExecutor     SoM Bridge                 │
│  - DAG scheduling   - Claude CLI     - Connects Layer 1↔2       │
│  - Parallel exec    - AutoGen teams  - Event translation         │
│  - Fail-forward     - Diff analysis  - Redundancy prevention     │
├─────────────────────────────────────────────────────────────────┤
│  LAYER 3: MCP Plugin Agents (20+ Servers)                       │
│                                                                 │
│  filesystem/ docker/ prisma/ playwright/ redis/ github/          │
│  npm/ postgres/ brave-search/ context7/ claude-code/ git/        │
│                                                                 │
│  Fungus Stack: FungusValidation + FungusMemory + FungusContext   │
└─────────────────────────────────────────────────────────────────┘
```

### Agent Categories

| Category | Agents | Purpose |
|----------|--------|---------|
| **Generation** | Architect, Generator, Database, API, Auth, Infrastructure | Code & schema creation |
| **Validation** | Builder, Tester, Validator, ValidationTeam, CrossLayer | Quality assurance |
| **Fixing** | Fixer, BugFixer, ContinuousDebug, DifferentialFix | Auto-correction |
| **Deployment** | DeploymentTeam, Docker, Sandbox | Runtime verification |
| **E2E Testing** | TesterTeam, PlaywrightE2E, ContinuousE2E, RequirementsPlaywright | Browser testing |
| **Quality** | UXDesign, CodeQuality, Security, Performance, Accessibility | Enhancement |
| **Memory** | FungusValidation, FungusMemory, FungusContext | RAG-based knowledge |

### Event-Driven Communication

Agents communicate via a push-based EventBus with async queues:

```
GeneratorAgent ──publish──► CODE_GENERATED
                                │
                    EventBus routes to subscribers
                                │
                    ┌───────────┼───────────┐
                    ▼           ▼           ▼
              BuilderAgent  TesterAgent  ValidatorAgent
              BUILD_*       TEST_*       TYPE_CHECK_*
                    │
                    ▼ (on failure)
              FixerAgent ──► CODE_FIXED ──► BuilderAgent (retry)
```

### Convergence Modes

| Mode | Test Rate | Max Errors | Use Case |
|------|-----------|------------|----------|
| `--autonomous` | 100% | 0 | Production quality |
| `--strict` | 100% | 0 | Quality gate |
| `--relaxed` | 80% | 5 | MVP / prototyping |
| `--fast` | 70% | 10 | Quick iteration |

### Skills & Token Management

Agents use skills (`.claude/skills/{name}/SKILL.md`) with 3-tier progressive loading:

| Tier | Tokens | Use Case |
|------|--------|----------|
| Minimal | ~200 | Single type error, import fix |
| Standard | ~800 | Multi-file fix, component creation |
| Full | ~1600 | New feature, architecture change |

## Project Structure

```
Coding_engine/
├── src/
│   ├── mind/              # EventBus, SharedState, Orchestrator
│   ├── engine/            # HybridPipeline, Slicer, Merger, Contracts
│   ├── agents/            # 37+ autonomous agents
│   ├── autogen/           # AutoGen teams, TaskEnricher, SchemaDiscoverer
│   ├── api/               # FastAPI REST/WebSocket server
│   ├── colony/            # Kubernetes Cell Colony system
│   ├── security/          # LLM security, supply chain scanning
│   ├── tools/             # Claude CLI, test runner, vision analysis
│   ├── validators/        # TypeScript, build, runtime, no-mock validation
│   ├── skills/            # Skill loader with tier support
│   └── monitoring/        # Browser error detection, CLI tracker
├── mcp_plugins/           # 20+ MCP server plugins
│   └── servers/
│       └── grpc_host/     # Epic Orchestrator, TaskExecutor, SoM Bridge
├── la_fungus_search/      # RAG semantic search (git submodule)
├── dashboard-app/         # Electron/React dashboard
├── config/                # LLM models, worker config, society defaults
├── infra/
│   ├── docker/            # Dockerfile.sandbox, docker-compose configs
│   └── k8s/               # Kubernetes manifests
├── tests/                 # Unit, integration, E2E, pipeline tests
├── Data/                  # Requirements & generated project data
├── .claude/
│   ├── agents/            # 12 Claude Code agent personas
│   └── skills/            # 12+ skill definitions
├── run_engine.py          # Unified entry point (all 3 layers)
├── run_society_hybrid.py  # Layer 1 entry point
├── run_epic001_live.py    # Layer 2+3 entry point
└── docs/                  # Architecture documentation
```

## Reference Output: WhatsApp Messaging Service

The repository includes a complete reference output from a 200-task epic generating a WhatsApp-like authentication system:

- `Data/all_services/whatsapp-messaging-service_20260211_025459/` — Requirements, architecture docs, task definitions, diagrams
- `output_whatsapp-messaging-service_20260211_025459/` — Generated NestJS project (77+ source files, Prisma schema, guards, DTOs)

This demonstrates the system generating phone registration, 2FA, biometric auth, passkeys, session management, app-lock, and PIN features.

## Dashboard

The Electron-based dashboard provides:

- **Project Management** — Create, monitor, manage generation projects
- **Live Preview** — VNC-based application streaming with health checks
- **Review Gate** — Pause generation, chat-style feedback with Vision AI analysis
- **Agent Monitor** — Real-time agent activity and convergence progress

```bash
cd dashboard-app
npm install
npm run build
npm run dev
```

## API

```bash
# Start the API server
uvicorn src.api.main:app --reload --port 8000
```

| Endpoint | Method | Description |
|----------|--------|-------------|
| `/api/v1/projects` | GET/POST | Project CRUD |
| `/api/v1/jobs` | POST | Submit generation job |
| `/api/v1/jobs/{id}` | GET | Job status |
| `/api/v1/ws` | WS | Real-time event stream |
| `/api/v1/dashboard/generation/{id}/pause` | POST | Pause for review |
| `/api/v1/dashboard/generation/{id}/resume` | POST | Resume with feedback |
| `/api/v1/vision/analyze-ui-feedback` | POST | Vision AI screenshot analysis |

## Configuration

### Environment Variables

| Variable | Description | Required |
|----------|-------------|----------|
| `ANTHROPIC_API_KEY` | Claude API key | Yes |
| `OPENROUTER_API_KEY` | OpenRouter key (for AutoGen teams) | Optional |
| `DATABASE_URL` | PostgreSQL connection string | Optional |
| `REDIS_URL` | Redis connection string | Optional |

### LLM Model Configuration

Models are configured centrally in `config/llm_models.yml` with 7 roles:

| Role | Purpose | Override Env Var |
|------|---------|-----------------|
| `primary` | Main code generation | `LLM_MODEL_PRIMARY` |
| `cli` | Claude CLI calls | `LLM_MODEL_CLI` |
| `judge` | Validation judgments | `LLM_MODEL_JUDGE` |
| `reasoning` | Complex analysis | `LLM_MODEL_REASONING` |
| `enrichment` | Task enrichment | `LLM_MODEL_ENRICHMENT` |

## CLI Flags

| Flag | Description |
|------|-------------|
| `--output-dir` | Output directory for generated project |
| `--fast` | Fast iteration criteria |
| `--strict` | Strict convergence criteria |
| `--autonomous` | Run until 100% complete |
| `--parallel N` | Number of parallel task executors |
| `--skip-failed-deps` | Continue past failed dependencies (default) |
| `--diff-fixes N` | Auto-fix N differential gaps after generation |
| `--no-preview` | Disable live preview server |
| `--max-iterations` | Maximum convergence iterations |

## Testing

```bash
# Run all tests
pytest

# Specific test suites
pytest tests/mind/ -v              # EventBus, push architecture
pytest tests/orchestrator/ -v      # Pipeline executor, fail-forward
pytest tests/autogen/ -v           # Task enrichment, schema discovery
pytest tests/agents/ -v            # Individual agents
pytest -m e2e                      # End-to-end tests
pytest -m integration              # Integration tests
```

## Contributing

We welcome contributions! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

```bash
# Development setup
pip install -r requirements.txt
pytest  # Verify tests pass
```

## License

This project is licensed under the Apache License 2.0 — see [LICENSE](LICENSE) for details.

## Acknowledgments

- [Anthropic](https://www.anthropic.com/) — Claude API
- [AutoGen](https://github.com/microsoft/autogen) — Multi-agent orchestration patterns
- [Playwright](https://playwright.dev/) — E2E browser testing
- [la_fungus_search](https://github.com/Flissel/la_fungus_search) — RAG semantic search

---

<p align="center">
  Built with AI by the Coding Engine Community
</p>
