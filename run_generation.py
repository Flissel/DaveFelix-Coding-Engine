#!/usr/bin/env python3
"""
Standalone generation subprocess.

Runs EpicOrchestrator in its own process with its own event loop.
Called by the API via subprocess.Popen — does NOT share the uvicorn event loop.

Usage:
    python run_generation.py --project-path /app/Data/all_services/whatsapp-... --output-dir /app/output/whatsapp-...
"""
import argparse
import asyncio
import json
import logging
import os
import sys
import time
from pathlib import Path

# Ensure project root is in path
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), "mcp_plugins", "servers", "grpc_host"))

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s %(name)s %(levelname)s %(message)s",
)
logger = logging.getLogger("run_generation")


async def run(args):
    from epic_orchestrator import EpicOrchestrator

    project_path = args.project_path
    output_dir = args.output_dir

    # Load SoM bridge config
    som_config = {}
    config_path = Path(__file__).parent / "config" / "society_defaults.json"
    if config_path.exists():
        try:
            raw = json.loads(config_path.read_text(encoding="utf-8"))
            som_config = raw.get("som_bridge", {})
            som_config["vnc_port"] = args.vnc_port
            som_config["app_port"] = args.app_port
        except Exception:
            pass

    # Create output dir
    Path(output_dir).mkdir(parents=True, exist_ok=True)

    logger.info("Starting generation: project=%s output=%s", project_path, output_dir)
    start_time = time.time()

    orchestrator = EpicOrchestrator(
        project_path=project_path,
        output_dir=output_dir,
        event_bus=None,  # No shared event bus — we're in our own process
        max_parallel_tasks=args.parallelism,
        enable_som=True,
        som_config=som_config,
    )

    # Find all epics
    tasks_dir = Path(project_path) / "tasks"
    epic_files = sorted(tasks_dir.glob("epic-*-tasks.json"))
    if not epic_files:
        logger.error("No epic task files found in %s", tasks_dir)
        sys.exit(1)

    epic_ids = []
    for f in epic_files:
        data = json.loads(f.read_text(encoding="utf-8"))
        eid = data.get("epic_id", f.stem.replace("-tasks", ""))
        epic_ids.append(eid)

    logger.info("Found %d epics: %s", len(epic_ids), epic_ids)

    # Run all epics
    total_completed = 0
    total_failed = 0

    for epic_id in epic_ids:
        logger.info("=== Running %s ===", epic_id)
        try:
            result = await orchestrator.run_epic(epic_id)
            total_completed += result.completed_tasks
            total_failed += result.failed_tasks
            logger.info(
                "%s done: %d completed, %d failed",
                epic_id, result.completed_tasks, result.failed_tasks,
            )
        except Exception as e:
            logger.error("%s failed: %s", epic_id, e)
            total_failed += 1

    elapsed = time.time() - start_time
    logger.info(
        "Generation complete: %d completed, %d failed, %.1fs elapsed",
        total_completed, total_failed, elapsed,
    )

    # Write status file for API to read
    status_file = Path(output_dir) / ".generation_status.json"
    status_file.write_text(json.dumps({
        "status": "completed" if total_failed == 0 else "completed_with_errors",
        "completed": total_completed,
        "failed": total_failed,
        "elapsed_seconds": round(elapsed, 1),
        "timestamp": time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime()),
    }, indent=2))


def main():
    parser = argparse.ArgumentParser(description="Run code generation as standalone process")
    parser.add_argument("--project-path", required=True, help="Path to project data directory")
    parser.add_argument("--output-dir", required=True, help="Path to write generated code")
    parser.add_argument("--vnc-port", type=int, default=6090)
    parser.add_argument("--app-port", type=int, default=3100)
    parser.add_argument("--parallelism", type=int, default=1)
    args = parser.parse_args()

    asyncio.run(run(args))


if __name__ == "__main__":
    main()
