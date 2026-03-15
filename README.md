# Coding Engine

[![Python 3.11+](https://img.shields.io/badge/python-3.11+-blue.svg)](https://www.python.org/downloads/)
[![Services](https://img.shields.io/badge/services-902-green.svg)](#emergent-pipeline)
[![Tests](https://img.shields.io/badge/integration_tests-389-green.svg)](#testing)
[![Compile](https://img.shields.io/badge/compile_check-952%2F952-brightgreen.svg)](#verification)

> **Emergent Autonomous Software Development Platform**

Coding Engine is a multi-agent code generation system that transforms structured requirements into production-ready applications. It combines a **Society of Mind** orchestration layer with a massive **Emergent Service Pipeline** of 900+ specialized microservices, all wired through a unified integration bus.

## How It Works

```
Requirements JSON
       │
       ▼
┌─────────────────────────────────────────────────────────┐
│  LAYER 1: Society of Mind (37+ AI Agents)               │
│  EventBus (push) → Generate → Build → Test → Fix Loop  │
├─────────────────────────────────────────────────────────┤
│  LAYER 2: Epic Orchestrator (55+ Tools)                 │
│  DAG scheduling → Parallel exec → Fail-forward          │
├─────────────────────────────────────────────────────────┤
│  LAYER 3: MCP Plugin Agents (20+ Servers)               │
│  filesystem / docker / prisma / playwright / github      │
├─────────────────────────────────────────────────────────┤
│  EMERGENT PIPELINE: 902 Service Modules                  │
│  PipelineIntegrationBus → 211 Chains → 389 Tests        │
└─────────────────────────────────────────────────────────┘
       │
       ▼
  Production-Ready Project
```

## Emergent Pipeline

The core differentiator: **902 service modules** following a consistent `@dataclass` pattern, all orchestrated through the `PipelineIntegrationBus`.

### Module Categories

| Category | Count | Examples |
|----------|-------|---------|
| `agent_task_*` | ~220 | auditor, scheduler, decomposer, merger, validator, watcher |
| `agent_workflow_*` | ~200 | coordinator, dispatcher, governor, balancer, timer, tracker |
| `pipeline_data_*` | ~200 | transformer, encoder, resolver, compressor, tokenizer, archiver |
| `pipeline_step_*` | ~200 | optimizer, guard, profiler, sequencer, annotator, versioner |
| Infrastructure | ~80 | circuit_breaker, health_dashboard, rate_limiter, consensus |

### Module Pattern

Every module follows the same architecture:

```python
@dataclass
class ModuleState:
    entries: Dict[str, dict] = field(default_factory=dict)
    _seq: int = 0
    callbacks: Dict[str, Callable] = field(default_factory=dict)

class Module:
    PREFIX = "xx-"           # Unique ID prefix
    MAX_ENTRIES = 10000      # Auto-prune oldest 25% when exceeded

    def operation(self, id, key, param="default", metadata=None) -> str:
        # SHA256 + _seq collision-free IDs
        # Dict-based return values
        # Callback firing via _fire(action, **detail)

    def get_stats(self) -> dict      # Metrics
    def reset(self) -> None           # Full state reset
    def on_change                     # Property: global callback
    def remove_callback(name) -> bool # Named callback removal
```

### Integration Bus

```python
from src.services.pipeline_integration_bus import PipelineIntegrationBus

bus = PipelineIntegrationBus()
bus.register_chain("my_pipeline", tags=["production"])
bus.add_step("my_pipeline", "transform", transform_fn, "pipeline_data_transformer")
bus.add_step("my_pipeline", "validate", validate_fn, "pipeline_step_validator")
result = bus.execute("my_pipeline", {"input": data})
# → {"success": True, "context": {...}, "steps_completed": 2}
```

## Features

- **Autonomous Code Generation** — Full-stack apps from JSON requirements
- **902 Emergent Services** — Consistent, tested, wired microservice modules
- **37+ AI Agents** — Parallel agents for code, schemas, APIs, auth, tests, deployment
- **3-Layer Architecture** — Society of Mind + Epic Orchestrator + MCP Plugins
- **Self-Correcting** — Automatic build/test error fixing until convergence
- **Push-Based EventBus** — Agents communicate via async event queues
- **Task Enrichment** — LLM-assisted schema discovery before code generation
- **Cross-Layer Validation** — Static FE/BE consistency checks
- **Electron Dashboard** — Modern UI for project management and monitoring
- **Fungus Memory** — RAG-based semantic search for persistent project knowledge
- **Multi-Tech Support** — React, Vue, Node.js, NestJS, Python, FastAPI, Electron

## Quick Start

### Prerequisites

- Python 3.11+
- Node.js 20+
- Docker Desktop
- Anthropic API Key (Claude)

### Installation

```bash
git clone https://github.com/Flissel/DaveFelix-Coding-Engine.git
cd DaveFelix-Coding-Engine

python -m venv venv
source venv/bin/activate  # Windows: venv\Scripts\activate

pip install -r requirements.txt

cp .env.example .env
# Edit .env: set ANTHROPIC_API_KEY
```

### Usage

```bash
# Generate project from requirements
python run_engine.py --project-path Data/all_services/whatsapp

# Compile check all 952 modules
python check_compile_all.py

# Run integration test suite (389 tests)
python test_integration_chains.py

# Run unit tests for specific modules
python -m pytest tests/test_pipeline_data_transformer_v2.py -v -p no:asyncio

# Generate new module batch (update MODULES in gen_phase.py first)
python gen_phase.py
```

## Project Structure

```
Coding_engine/
├── src/
│   ├── mind/              # EventBus, SharedState, Orchestrator
│   ├── engine/            # HybridPipeline, Slicer, Merger, Contracts
│   ├── agents/            # 37+ autonomous agents
│   ├── services/          # 902 emergent service modules
│   ├── autogen/           # AutoGen teams, TaskEnricher
│   ├── api/               # FastAPI REST/WebSocket server
│   ├── tools/             # Claude CLI, test runner, vision analysis
│   └── validators/        # TypeScript, build, runtime validation
├── tests/                 # 493 unit test files
├── mcp_plugins/           # 20+ MCP server plugins
├── dashboard-app/         # Electron/React dashboard
├── config/                # LLM models, worker config
├── infra/                 # Docker & Kubernetes manifests
├── docs/                  # Architecture documentation
├── Data/                  # Requirements & project data
├── run_engine.py          # Main entry point
├── check_compile_all.py   # Compile verification (952 modules)
├── test_integration_chains.py  # Integration tests (389 tests, 211 chains)
└── gen_phase.py           # Module batch generator
```

## Verification

```bash
# Full system check
python check_compile_all.py          # Expects: 952/952 clean
python test_integration_chains.py    # Expects: 389/389 passed

# Unit tests (any module)
python -m pytest tests/ -v -p no:asyncio
```

## Configuration

| Variable | Description | Required |
|----------|-------------|----------|
| `ANTHROPIC_API_KEY` | Claude API key | Yes |
| `OPENROUTER_API_KEY` | OpenRouter key (AutoGen teams) | Optional |
| `DATABASE_URL` | PostgreSQL connection | Optional |
| `REDIS_URL` | Redis connection | Optional |

## License

Apache License 2.0

---

<p align="center">Built by DaveFelix</p>
