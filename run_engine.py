# -*- coding: utf-8 -*-
"""
Unified Engine Entry Point — Phase 27

Single entry point that connects all 3 layers:
  Layer 1: Code Gen Pipeline (37+ agents, EventBus, convergence loop)
  Layer 2: MCP Orchestrator (55+ tools)
  Layer 3: MCP Plugin Agents (20+ servers)

Defaults:
  - SoM Bridge always-on (agents react to task events in real-time)
  - Differential + CrossLayer validation in convergence loop
  - Parallel pipeline (default 10)
  - Fail-forward execution

Usage:
    python run_engine.py                                   # Auto-detect project
    python run_engine.py --project-path Data/all_services/whatsapp
    python run_engine.py --parallel 10 --diff-fixes 5      # Fix top 5 gaps
    python run_engine.py --autonomous                       # Strict convergence
    python run_engine.py --fast                             # Minimal iterations
    python run_engine.py --no-som --no-diff                 # Legacy mode
"""
import argparse
import asyncio
import json
import logging
import os
import sys
import time
import threading
from pathlib import Path

# Ensure project root is on sys.path
sys.path.insert(0, str(Path(__file__).parent))
sys.path.insert(0, str(Path(__file__).parent / "mcp_plugins" / "servers" / "grpc_host"))

# Load .env file if present
try:
    from dotenv import load_dotenv
    load_dotenv()
except ImportError:
    pass

logger = logging.getLogger(__name__)


def find_latest_project() -> Path:
    """Find the most recently modified project in Data/all_services/."""
    data_dir = Path("Data/all_services")
    if not data_dir.exists():
        return Path("")

    candidates = []
    for project_dir in data_dir.iterdir():
        if project_dir.is_dir() and (project_dir / "tasks").exists():
            candidates.append(project_dir)

    if not candidates:
        return Path("")

    candidates.sort(key=lambda p: p.stat().st_mtime, reverse=True)
    return candidates[0]


def load_full_config() -> dict:
    """Load full config from society_defaults.json."""
    config_path = Path(__file__).parent / "config" / "society_defaults.json"
    if config_path.exists():
        try:
            return json.loads(config_path.read_text(encoding="utf-8"))
        except (json.JSONDecodeError, OSError):
            pass
    return {}


def _pct(count: int, total: int) -> str:
    """Format count as percentage."""
    if total == 0:
        return "0%"
    return f"{count / total * 100:.0f}%"


# =============================================================================
# Post-Execution: Differential Validation + Auto-Fix
# =============================================================================

async def run_differential_validation(
    data_dir: str,
    code_dir: str,
    max_fixes: int = 0,
    verify: bool = False,
) -> dict:
    """
    Run differential analysis on the generated code vs documentation.

    Reused from run_epic001_live.py — measures coverage, identifies gaps,
    and optionally spawns claude-code agents to fix critical ones.
    """
    from src.services.differential_analysis_service import (
        AnalysisMode,
        DifferentialAnalysisService,
        ImplementationStatus,
        GapSeverity,
    )

    print(f"\n{'='*60}")
    print(f"  POST-RUN: Differential Validation")
    print(f"{'='*60}")
    print(f"  Data dir:    {data_dir}")
    print(f"  Code dir:    {code_dir}")
    print(f"  Auto-fix:    {max_fixes} gaps" if max_fixes > 0 else "  Auto-fix:    disabled")
    print(f"{'='*60}\n")

    print("[DIFF 1/3] Loading documentation and code...")

    service = DifferentialAnalysisService(
        data_dir=data_dir,
        code_dir=code_dir,
        job_id="unified_engine_validation",
        enable_supermemory=False,
    )

    start_time = time.time()
    started = await service.start()
    if not started:
        print("  WARNING: Could not start differential analysis (missing data?)")
        return {"error": "start_failed", "coverage": 0}

    print(f"      {service.user_story_count} user stories, "
          f"{service.task_count} tasks, "
          f"{service.requirement_count} requirements")

    print("\n[DIFF 2/3] Running differential analysis (LLM Judge)...")

    report = await service.run_analysis(mode=AnalysisMode.FULL_DIFFERENTIAL)

    elapsed = time.time() - start_time
    print(f"      Analysis complete in {elapsed:.0f}s")
    print(f"\n      Coverage Report:")
    print(f"        Total requirements:  {report.total_requirements}")
    print(f"        Implemented:         {report.implemented} ({_pct(report.implemented, report.total_requirements)})")
    print(f"        Partial:             {report.partial} ({_pct(report.partial, report.total_requirements)})")
    print(f"        Missing:             {report.missing} ({_pct(report.missing, report.total_requirements)})")
    print(f"        Coverage:            {report.coverage_percent:.1f}%")
    print(f"        Judge confidence:    {report.judge_confidence:.2f}")

    result = {
        "coverage_before": report.coverage_percent,
        "total_requirements": report.total_requirements,
        "implemented": report.implemented,
        "partial": report.partial,
        "missing": report.missing,
        "judge_confidence": report.judge_confidence,
        "fixes_attempted": 0,
        "fixes_succeeded": 0,
    }

    if max_fixes > 0:
        min_conf = 0.6
        critical_gaps = [
            f for f in report.findings
            if f.severity == GapSeverity.CRITICAL
            and f.confidence >= min_conf
            and f.status != ImplementationStatus.IMPLEMENTED
        ]

        if not critical_gaps:
            print(f"\n[DIFF 3/3] No critical gaps to fix.")
        else:
            from src.agents.differential_fix_agent import (
                DifferentialFixAgent,
                GAP_AGENT_ROUTING,
            )
            from src.mind.event_bus import Event, EventType

            gaps_to_fix = critical_gaps[:max_fixes]
            print(f"\n[DIFF 3/3] Auto-fixing {len(gaps_to_fix)} critical gaps via claude-code...")

            try:
                from src.mcp.agent_pool import MCPAgentPool

                pool = MCPAgentPool(working_dir=code_dir)
                available = pool.list_available()

                fix_results = []
                for i, gap in enumerate(gaps_to_fix, 1):
                    event = Event(
                        type=EventType.CODE_FIX_NEEDED,
                        source="pipeline",
                        data={
                            "gap_description": gap.gap_description or "",
                            "reason": gap.requirement_title or "",
                            "suggested_tasks": gap.suggested_tasks or [],
                        },
                    )
                    gap_type = DifferentialFixAgent._determine_gap_type(event)
                    agents = GAP_AGENT_ROUTING.get(gap_type, GAP_AGENT_ROUTING["default"])

                    agent_name = next((a for a in agents if a in available), None)
                    if not agent_name:
                        agent_name = "claude-code" if "claude-code" in available else None

                    if not agent_name:
                        print(f"  [{gap.requirement_id}] SKIP - no agents available")
                        continue

                    task_desc = DifferentialFixAgent._build_agent_task(
                        agent_name=agent_name,
                        requirement_id=gap.requirement_id,
                        description=gap.gap_description or gap.requirement_title,
                        suggested_tasks=gap.suggested_tasks or [],
                    )

                    print(f"\n  [{i}/{len(gaps_to_fix)}] {gap.requirement_id}: {gap.requirement_title}")
                    print(f"     Agent: {agent_name} | Type: {gap_type}")

                    spawn_result = await pool.spawn(agent_name, task_desc)
                    status = "OK" if spawn_result.success else "FAIL"
                    print(f"     Result: {status} ({spawn_result.duration:.0f}s)")

                    fix_results.append({
                        "requirement_id": gap.requirement_id,
                        "success": spawn_result.success,
                        "agent": agent_name,
                        "duration": spawn_result.duration,
                    })

                result["fixes_attempted"] = len(fix_results)
                result["fixes_succeeded"] = sum(1 for r in fix_results if r["success"])
                result["fix_details"] = fix_results

            except Exception as e:
                print(f"\n  ERROR: Auto-fix failed: {e}")
                result["fix_error"] = str(e)

        if verify and result.get("fixes_succeeded", 0) > 0:
            print(f"\n  Re-running analysis to verify improvements...")
            service2 = DifferentialAnalysisService(
                data_dir=data_dir,
                code_dir=code_dir,
                job_id="unified_engine_verify",
                enable_supermemory=False,
            )
            started2 = await service2.start()
            if started2:
                report2 = await service2.run_analysis(mode=AnalysisMode.FULL_DIFFERENTIAL)
                result["coverage_after"] = report2.coverage_percent
                delta = report2.coverage_percent - report.coverage_percent
                print(f"  Coverage: {report.coverage_percent:.1f}% -> {report2.coverage_percent:.1f}% ({'+' if delta >= 0 else ''}{delta:.1f}%)")
                await service2.stop()
    else:
        print(f"\n[DIFF 3/3] Auto-fix disabled (use --diff-fixes N to enable).")

    report_path = os.path.join(data_dir, "differential_report.json")
    service.export_report(report_path)
    print(f"\n  Report saved: {report_path}")

    await service.stop()
    return result


# =============================================================================
# Main
# =============================================================================

async def main():
    parser = argparse.ArgumentParser(
        description="Unified Engine — 3-layer code generation with SoM agents + MCP tools",
    )
    parser.add_argument("requirements", nargs="?", default=None,
                        help="Requirements JSON file (positional, optional)")
    parser.add_argument("--project-path", default=None, help="Project directory")
    parser.add_argument("--output-dir", default=None, help="Output directory override")
    parser.add_argument("--parallel", type=int, default=10,
                        help="Max parallel tasks (default: 10)")

    # SoM / Diff flags (default: enabled)
    parser.add_argument("--no-som", action="store_true",
                        help="Disable SoM Bridge (agents won't react to events)")
    parser.add_argument("--no-diff", action="store_true",
                        help="Skip post-run differential validation")
    parser.add_argument("--diff-fixes", type=int, default=0,
                        help="Auto-fix N critical gaps after run (default: 0)")
    parser.add_argument("--diff-verify", action="store_true",
                        help="Re-run analysis after auto-fixes")

    # Convergence presets
    parser.add_argument("--autonomous", action="store_true",
                        help="Use AUTONOMOUS_CRITERIA (strict convergence)")
    parser.add_argument("--fast", action="store_true",
                        help="Use FAST_ITERATION_CRITERIA (minimal checks)")

    # Task selection
    parser.add_argument("--max-tasks", type=int, default=None,
                        help="Limit execution to N tasks")
    parser.add_argument("--phases", type=str, default=None,
                        help="Execute only these phases (comma-separated)")
    parser.add_argument("--block-on-fail", action="store_true",
                        help="Block downstream tasks on failed deps (default: fail-forward)")

    args = parser.parse_args()

    # Resolve project path
    if args.project_path:
        project_path = Path(args.project_path)
    elif args.requirements:
        project_path = Path(args.requirements).parent
    else:
        project_path = find_latest_project()

    if not project_path or not project_path.exists():
        print("Error: No project found. Use --project-path or pass requirements JSON.")
        sys.exit(1)

    # Load config
    full_config = load_full_config()
    som_config = full_config.get("som_bridge", {})
    engine_config = full_config.get("unified_engine", {})

    # Merge CLI with config defaults
    enable_som = not args.no_som and engine_config.get("enable_som", True)
    parallel = args.parallel
    if parallel == 10 and som_config.get("pipeline_max_parallel"):
        parallel = som_config["pipeline_max_parallel"]
    diff_fixes = args.diff_fixes or engine_config.get("diff_fixes", 0)
    skip_failed_deps = not args.block_on_fail
    phases = [p.strip() for p in args.phases.split(",")] if args.phases else None

    # Banner
    print(f"\n{'='*70}")
    print(f"  Unified Engine (Phase 27: 3-Layer Connected)")
    print(f"{'='*70}")
    print(f"  Project:       {project_path}")
    print(f"  Parallel:      {parallel}")
    print(f"  SoM Bridge:    {'enabled (agents react to events)' if enable_som else 'disabled'}")
    print(f"  Fail-forward:  {'disabled' if args.block_on_fail else 'enabled'}")
    print(f"  Diff analysis: {'enabled' if som_config.get('enable_differential_analysis') else 'disabled'} (in convergence loop)")
    print(f"  Cross-layer:   {'enabled' if som_config.get('enable_cross_layer_validation') else 'disabled'} (in convergence loop)")
    if args.autonomous:
        print(f"  Convergence:   AUTONOMOUS (strict)")
    elif args.fast:
        print(f"  Convergence:   FAST (minimal)")
    else:
        print(f"  Convergence:   DEFAULT")
    if phases:
        print(f"  Phases:        {', '.join(phases)}")
    if args.max_tasks:
        print(f"  Max tasks:     {args.max_tasks}")
    if not args.no_diff:
        print(f"  Post-run diff: enabled (fixes: {diff_fixes})")
    print(f"{'='*70}\n")

    # =========================================================================
    # Start FastAPI + WebSocket server in background thread
    # This allows the Electron dashboard to receive real-time events
    # even when the engine is started from CLI (not from Electron IPC).
    # =========================================================================
    from src.mind.event_bus import EventBus
    event_bus = EventBus()

    # Phase 31: Create a shared SharedState for vibe-coding file tracking
    from src.mind.shared_state import SharedState
    shared_state = SharedState()

    def _start_api_server(shared_event_bus, shared_state_instance):
        """Start FastAPI server in background thread for dashboard WebSocket."""
        try:
            import uvicorn
            from src.api.main import app, set_shared_event_bus, set_shared_state

            # Replace the module-level EventBus with our shared one
            # This must happen BEFORE uvicorn starts the lifespan
            set_shared_event_bus(shared_event_bus)

            # Phase 31: Inject SharedState so vibe.py can mark user-managed files
            set_shared_state(shared_state_instance)

            print("  [API] Starting FastAPI server on port 8000 for dashboard WebSocket...")
            uvicorn.run(app, host="0.0.0.0", port=8000, log_level="warning")
        except Exception as e:
            print(f"  [API] Warning: Could not start FastAPI server: {e}")
            print(f"  [API] Dashboard WebSocket will not be available.")

    api_thread = threading.Thread(target=_start_api_server, args=(event_bus, shared_state), daemon=True)
    api_thread.start()
    time.sleep(2)  # Give server time to start

    # Import orchestrator
    from epic_orchestrator import EpicOrchestrator

    orchestrator = EpicOrchestrator(
        str(project_path),
        event_bus=event_bus,
        max_parallel_tasks=parallel,
        enable_som=enable_som,
        som_config=som_config,
    )

    # =========================================================================
    # Step 1: Execute Epic (fail-forward, SoM always-on)
    # =========================================================================
    print("=" * 70)
    print("  STEP 1: Running Epic (unified pipeline, SoM agents active)...")
    print("=" * 70)

    epic_start = time.time()

    result = await orchestrator.run_epic(
        "EPIC-001",
        max_tasks=args.max_tasks,
        phases=phases,
        skip_failed_deps=skip_failed_deps,
    )

    epic_duration = time.time() - epic_start

    print()
    print("=" * 70)
    status_label = "OK" if result.success else "PARTIAL"
    print(f"  [{status_label}] Epic execution ended")
    print(f"    Completed: {result.completed_tasks}/{result.total_tasks}")
    print(f"    Failed:    {result.failed_tasks}")
    print(f"    Skipped:   {result.skipped_tasks}")
    print(f"    Duration:  {epic_duration:.0f}s")
    print("=" * 70)

    # =========================================================================
    # Step 2: Post-Run Differential Validation
    # =========================================================================
    diff_result = None
    if not args.no_diff:
        # Phase 28: Skip if convergence loop already ran differential analysis
        if getattr(orchestrator, '_convergence_ran_diff', False):
            print(f"\n  SKIP post-run diff: already ran in convergence loop (SoM + diff enabled)")
        else:
            code_dir = str(project_path / "output")
            if args.output_dir:
                code_dir = args.output_dir
            if Path(code_dir).exists():
                diff_result = await run_differential_validation(
                    data_dir=str(project_path),
                    code_dir=code_dir,
                    max_fixes=diff_fixes,
                    verify=args.diff_verify,
                )
            else:
                print(f"\n  SKIP differential validation: no output dir at {code_dir}")

    # =========================================================================
    # Final Summary
    # =========================================================================
    total_duration = time.time() - epic_start

    print(f"\n{'='*70}")
    print(f"  FINAL SUMMARY")
    print(f"{'='*70}")
    print(f"  Total duration:    {total_duration:.0f}s")
    print(f"  Epic tasks:        {result.completed_tasks}/{result.total_tasks} completed, "
          f"{result.failed_tasks} failed, {result.skipped_tasks} skipped")

    if diff_result and "error" not in diff_result:
        cov = diff_result.get("coverage_before", 0)
        impl = diff_result.get("implemented", 0)
        total_req = diff_result.get("total_requirements", 0)
        print(f"  Req coverage:      {cov:.1f}% ({impl}/{total_req} implemented)")
        if diff_result.get("fixes_attempted", 0) > 0:
            print(f"  Auto-fixes:        {diff_result['fixes_succeeded']}/{diff_result['fixes_attempted']} succeeded")
        if diff_result.get("coverage_after") is not None:
            delta = diff_result["coverage_after"] - cov
            print(f"  Coverage after fix: {diff_result['coverage_after']:.1f}% ({'+' if delta >= 0 else ''}{delta:.1f}%)")

    print(f"{'='*70}\n")


if __name__ == "__main__":
    logging.basicConfig(
        level=logging.INFO,
        format="%(asctime)s [%(levelname)s] %(name)s: %(message)s",
    )
    asyncio.run(main())
