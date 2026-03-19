"""
FastAPI routes for real-time dashboard endpoints.
Provides timeline, metrics, and process monitoring APIs.
Also provides Docker/project management APIs for web dashboard.
"""

from datetime import datetime
from typing import Optional, List
import asyncio
import subprocess
import os
from pathlib import Path
from fastapi import APIRouter, Depends, HTTPException, Query
from fastapi.responses import JSONResponse
from sqlalchemy.ext.asyncio import AsyncSession
from pydantic import BaseModel

from src.models.dashboard_models import (
    TimelineResponse,
    DashboardMetrics,
    DashboardOverview,
    ProcessListResponse,
    EventFilter,
    PerformanceMetrics,
    HealthStatus,
)
from src.services.dashboard_service import DashboardService
from src.models.base import get_db
from src.mind.shared_state import SharedState
from src.mind.event_bus import EventBus, Event, EventType
from src.mind.event_payloads import BuildFailurePayload, SandboxTestPayload
import structlog


# ============================================================================
# Pydantic models for Docker management
# ============================================================================

class DockerStatusResponse(BaseModel):
    running: bool
    services: List[str] = []

class ProjectStartRequest(BaseModel):
    projectId: str
    outputDir: str
    vncPort: int
    appPort: int

class ProjectStopRequest(BaseModel):
    projectId: str

class GenerateRequest(BaseModel):
    requirementsPath: str

class ReviewResumeRequest(BaseModel):
    feedback: Optional[str] = None


class SandboxErrorReport(BaseModel):
    """Error report from Docker sandbox container."""
    project_id: str
    container_name: Optional[str] = None
    error_type: str  # "build_failed", "runtime_error", "test_failed"
    build_output: str  # Full error log
    exit_code: int = 1
    working_dir: Optional[str] = None
    project_type: Optional[str] = None  # "react", "node_fullstack", etc.

class SuccessResponse(BaseModel):
    success: bool
    error: Optional[str] = None

class ProjectStatusResponse(BaseModel):
    running: bool
    vncPort: Optional[int] = None
    appPort: Optional[int] = None
    health: Optional[str] = None

class LogsResponse(BaseModel):
    logs: str


# Project container tracking
_project_containers: dict = {}

# Generation state tracking (keyed by projectId)
# Stores: { phase, progress_pct, completed, failed, total, started_at, error }
_generation_state: dict = {}

logger = structlog.get_logger(__name__)

router = APIRouter(prefix="/api/v1/dashboard", tags=["dashboard"])


def get_dashboard_service(db: AsyncSession = Depends(get_db)) -> DashboardService:
    """Dependency to get dashboard service instance."""
    return DashboardService(db)


@router.get("/timeline", response_model=TimelineResponse)
async def get_timeline(
    limit: int = Query(100, ge=1, le=1000, description="Maximum number of events to return"),
    offset: int = Query(0, ge=0, description="Offset for pagination"),
    event_types: Optional[str] = Query(None, description="Comma-separated event types to filter"),
    severity: Optional[str] = Query(None, description="Comma-separated severity levels (info,warning,error,success)"),
    process_id: Optional[int] = Query(None, description="Filter by process ID"),
    port: Optional[int] = Query(None, description="Filter by port number"),
    since: Optional[datetime] = Query(None, description="Events since timestamp (ISO format)"),
    until: Optional[datetime] = Query(None, description="Events until timestamp (ISO format)"),
    service: DashboardService = Depends(get_dashboard_service)
) -> TimelineResponse:
    """
    Get connection events timeline with filtering and pagination.

    Returns the last N connection events with timestamp, event type, and affected resource.
    Supports filtering by event type, severity, process, port, and time range.

    **REQ-ea7004-015**: Displays real-time timeline of last 100 connection events.
    """
    try:
        # Build filter
        event_filter = EventFilter(
            event_types=event_types.split(",") if event_types else None,
            severity=severity.split(",") if severity else None,
            process_id=process_id,
            port=port,
            since=since,
            until=until,
            limit=limit,
            offset=offset
        )

        timeline = await service.get_timeline(
            limit=limit,
            offset=offset,
            event_filter=event_filter
        )

        logger.info(
            "timeline_fetched",
            returned_count=timeline.returned_count,
            total_count=timeline.total_count,
            page=timeline.page
        )

        return timeline

    except Exception as e:
        logger.error("timeline_fetch_failed", error=str(e))
        raise HTTPException(status_code=500, detail=f"Failed to fetch timeline: {str(e)}")


@router.get("/metrics", response_model=DashboardMetrics)
async def get_metrics(
    service: DashboardService = Depends(get_dashboard_service)
) -> DashboardMetrics:
    """
    Get current dashboard metrics including process and connection stats.

    Returns real-time metrics for processes, connections, and recent event activity.
    """
    try:
        metrics = await service.get_dashboard_metrics()

        logger.info(
            "metrics_fetched",
            active_processes=metrics.process_metrics.active_processes,
            active_connections=metrics.connection_metrics.active_connections,
            recent_events=metrics.recent_events_count
        )

        return metrics

    except Exception as e:
        logger.error("metrics_fetch_failed", error=str(e))
        raise HTTPException(status_code=500, detail=f"Failed to fetch metrics: {str(e)}")


@router.get("/overview", response_model=DashboardOverview)
async def get_overview(
    timeline_limit: int = Query(100, ge=1, le=1000, description="Number of timeline events"),
    event_types: Optional[str] = Query(None, description="Filter timeline by event types"),
    severity: Optional[str] = Query(None, description="Filter timeline by severity"),
    service: DashboardService = Depends(get_dashboard_service)
) -> DashboardOverview:
    """
    Get complete dashboard overview with timeline and metrics.

    Provides a comprehensive view of system state including:
    - Process and connection metrics
    - Recent connection events timeline
    - Performance statistics

    **REQ-ea7004-016**: Loads within 2 seconds for up to 500 active processes.

    Returns:
        DashboardOverview with metrics, timeline, and load time
    """
    try:
        # Build filter if provided
        event_filter = None
        if event_types or severity:
            event_filter = EventFilter(
                event_types=event_types.split(",") if event_types else None,
                severity=severity.split(",") if severity else None,
                limit=timeline_limit
            )

        overview, performance = await service.get_dashboard_overview(
            timeline_limit=timeline_limit,
            timeline_filter=event_filter
        )

        logger.info(
            "overview_fetched",
            load_time_ms=overview.load_time_ms,
            active_processes=performance.active_processes_count,
            meets_sla=performance.meets_sla,
            timeline_events=overview.timeline.returned_count
        )

        # Log warning if SLA not met
        if not performance.meets_sla:
            logger.warning(
                "dashboard_sla_exceeded",
                load_time_ms=overview.load_time_ms,
                active_processes=performance.active_processes_count,
                sla_threshold_ms=2000
            )

        return overview

    except Exception as e:
        logger.error("overview_fetch_failed", error=str(e))
        raise HTTPException(status_code=500, detail=f"Failed to fetch overview: {str(e)}")


@router.get("/processes", response_model=ProcessListResponse)
async def get_processes(
    sort_by: str = Query("cpu", regex="^(cpu|memory|name|pid)$", description="Sort field"),
    limit: int = Query(100, ge=1, le=1000, description="Maximum processes to return"),
    service: DashboardService = Depends(get_dashboard_service)
) -> ProcessListResponse:
    """
    Get list of active processes with detailed information.

    Returns process details including CPU/memory usage, ports, and thread count.
    Optimized for fast retrieval with up to 500 active processes.
    """
    try:
        process_list = await service.get_process_list(
            sort_by=sort_by,
            limit=limit
        )

        logger.info(
            "process_list_fetched",
            total_count=process_list.total_count,
            returned_count=len(process_list.processes),
            load_time_ms=process_list.load_time_ms
        )

        return process_list

    except Exception as e:
        logger.error("process_list_fetch_failed", error=str(e))
        raise HTTPException(status_code=500, detail=f"Failed to fetch process list: {str(e)}")


@router.get("/health", response_model=HealthStatus)
async def get_health(
    service: DashboardService = Depends(get_dashboard_service)
) -> HealthStatus:
    """
    Get dashboard health status.

    Returns overall system health, WebSocket status, and event processing metrics.
    """
    try:
        # Get recent events to check activity
        recent_events = await service.get_recent_events_count(minutes=5)

        # Get latest event timestamp
        timeline = await service.get_timeline(limit=1)
        last_event_timestamp = timeline.events[0].timestamp if timeline.events else None

        # Calculate event processing lag
        event_lag_ms = 0.0
        if last_event_timestamp:
            lag = datetime.utcnow() - last_event_timestamp
            event_lag_ms = lag.total_seconds() * 1000

        # Determine health status
        status = "healthy"
        if event_lag_ms > 5000:  # More than 5 seconds lag
            status = "degraded"
        if recent_events == 0:  # No events in last 5 minutes
            status = "degraded"

        health = HealthStatus(
            status=status,
            websocket_connected=True,  # Will be updated by WebSocket handler
            active_connections=0,  # Will be updated by WebSocket handler
            last_event_timestamp=last_event_timestamp,
            event_processing_lag_ms=event_lag_ms,
            metrics_update_interval_ms=1000.0
        )

        logger.info(
            "health_check",
            status=status,
            recent_events=recent_events,
            event_lag_ms=event_lag_ms
        )

        return health

    except Exception as e:
        logger.error("health_check_failed", error=str(e))
        return HealthStatus(
            status="unhealthy",
            websocket_connected=False,
            active_connections=0,
            event_processing_lag_ms=0.0
        )


# ============================================================================
# Docker Management Routes (for web dashboard)
# ============================================================================

async def run_command(cmd: str, cwd: str = None) -> tuple[str, str, int]:
    """Run a command asynchronously and return stdout, stderr, returncode."""
    process = await asyncio.create_subprocess_shell(
        cmd,
        stdout=asyncio.subprocess.PIPE,
        stderr=asyncio.subprocess.PIPE,
        cwd=cwd
    )
    stdout, stderr = await process.communicate()
    return (
        stdout.decode('utf-8', errors='replace'),
        stderr.decode('utf-8', errors='replace'),
        process.returncode
    )


@router.get("/docker/status", response_model=DockerStatusResponse)
async def get_docker_status() -> DockerStatusResponse:
    """
    Get Docker engine status - check if relevant containers are running.
    """
    try:
        stdout, stderr, rc = await run_command('docker ps --format "{{.Names}}"')
        if rc != 0:
            return DockerStatusResponse(running=False, services=[])

        services = [
            name.strip() for name in stdout.strip().split('\n')
            if name.strip() and any(x in name for x in ['coding-engine', 'postgres', 'redis'])
        ]

        return DockerStatusResponse(running=len(services) > 0, services=services)
    except Exception as e:
        logger.error("docker_status_check_failed", error=str(e))
        return DockerStatusResponse(running=False, services=[])


@router.post("/docker/start", response_model=SuccessResponse)
async def start_docker_engine() -> SuccessResponse:
    """
    Start the Coding Engine Docker stack.
    """
    try:
        engine_root = Path(__file__).parent.parent.parent.parent
        compose_file = engine_root / "infra" / "docker" / "docker-compose.dashboard.yml"

        if not compose_file.exists():
            return SuccessResponse(success=False, error=f"Compose file not found: {compose_file}")

        stdout, stderr, rc = await run_command(
            f'docker-compose -f "{compose_file}" up -d',
            cwd=str(engine_root)
        )

        if rc != 0:
            return SuccessResponse(success=False, error=stderr or stdout)

        logger.info("docker_engine_started")
        return SuccessResponse(success=True)
    except Exception as e:
        logger.error("docker_start_failed", error=str(e))
        return SuccessResponse(success=False, error=str(e))


@router.post("/docker/stop", response_model=SuccessResponse)
async def stop_docker_engine() -> SuccessResponse:
    """
    Stop the Coding Engine Docker stack.
    """
    try:
        engine_root = Path(__file__).parent.parent.parent.parent
        compose_file = engine_root / "infra" / "docker" / "docker-compose.dashboard.yml"

        stdout, stderr, rc = await run_command(
            f'docker-compose -f "{compose_file}" down',
            cwd=str(engine_root)
        )

        if rc != 0:
            return SuccessResponse(success=False, error=stderr or stdout)

        logger.info("docker_engine_stopped")
        return SuccessResponse(success=True)
    except Exception as e:
        logger.error("docker_stop_failed", error=str(e))
        return SuccessResponse(success=False, error=str(e))


@router.post("/project/start", response_model=SuccessResponse)
async def start_project_container(request: ProjectStartRequest) -> SuccessResponse:
    """
    Start the sandbox container via docker-compose for live preview with VNC.
    Gracefully handles sandbox not being available (does not block generation).
    """
    try:
        container_name = f"project-{request.projectId}"

        # Check if already running
        if request.projectId in _project_containers:
            info = _project_containers[request.projectId]
            if info.get('status') == 'running':
                return SuccessResponse(success=True)

        engine_root = Path(__file__).parent.parent.parent.parent
        compose_file = engine_root / "docker-compose.yml"

        # Start sandbox service via docker-compose
        cmd = (
            f'docker-compose -f "{compose_file}" up -d sandbox'
        )
        stdout, stderr, rc = await run_command(cmd, cwd=str(engine_root))

        if rc != 0:
            # Sandbox failed to start — log but don't block generation
            logger.warning(
                "sandbox_start_failed_non_blocking",
                projectId=request.projectId,
                error=stderr or stdout,
            )
            return SuccessResponse(
                success=False,
                error=f"Sandbox unavailable (generation continues): {stderr or stdout}",
            )

        _project_containers[request.projectId] = {
            'id': 'coding-engine-sandbox',
            'vncPort': request.vncPort,
            'appPort': request.appPort,
            'status': 'running'
        }

        logger.info("project_container_started", projectId=request.projectId, vncPort=request.vncPort)
        return SuccessResponse(success=True)
    except Exception as e:
        # Sandbox errors must not block the generation pipeline
        logger.warning("project_start_failed_non_blocking", projectId=request.projectId, error=str(e))
        return SuccessResponse(success=False, error=f"Sandbox unavailable: {str(e)}")


@router.post("/project/stop", response_model=SuccessResponse)
async def stop_project_container(request: ProjectStopRequest) -> SuccessResponse:
    """
    Stop a project container.
    """
    try:
        container_name = f"project-{request.projectId}"

        await run_command(f'docker stop {container_name}')
        await run_command(f'docker rm {container_name}')

        if request.projectId in _project_containers:
            del _project_containers[request.projectId]

        logger.info("project_container_stopped", projectId=request.projectId)
        return SuccessResponse(success=True)
    except Exception as e:
        logger.error("project_stop_failed", projectId=request.projectId, error=str(e))
        return SuccessResponse(success=False, error=str(e))


@router.get("/project/status")
async def get_project_status(projectId: str = Query(..., description="Project ID")):
    """
    Get project generation status. Returns generation phase, progress, and task counts
    when generation is active. Falls back to container status otherwise.
    """
    # Check generation state first
    gen = _generation_state.get(projectId)
    if gen and gen.get("phase") not in (None, "idle"):
        # Lazy-load epics from project if not cached
        if not gen.get("epics") and gen.get("project_path"):
            try:
                from mcp_plugins.servers.grpc_host.epic_task_generator import EpicTaskGenerator
                etg = EpicTaskGenerator(gen["project_path"])
                raw_epics = etg.get_epic_list()
                epic_infos = []
                for e in raw_epics:
                    epic_infos.append({
                        "id": e.get("id", ""),
                        "name": e.get("name", ""),
                        "progress_pct": e.get("progress_percent", 0),
                        "tasks_total": 0,
                        "tasks_complete": 0,
                    })
                gen["epics"] = epic_infos
            except Exception:
                # Fallback: try reading tasks files for epic IDs
                import glob as _glob
                import json as _json
                epic_infos = []
                tasks_dir = Path(gen["project_path"]) / "tasks"
                for tf in sorted(tasks_dir.glob("epic-*-tasks.json")):
                    try:
                        with open(tf) as f:
                            td = _json.load(f)
                        tasks = td.get("tasks", [])
                        completed = sum(1 for t in tasks if t.get("status") == "completed")
                        total = len(tasks)
                        epic_id = td.get("epic_id", tf.stem.split("-tasks")[0].upper())
                        epic_infos.append({
                            "id": epic_id,
                            "name": td.get("epic_name", epic_id),
                            "progress_pct": int(completed * 100 / max(total, 1)),
                            "tasks_total": total,
                            "tasks_complete": completed,
                        })
                    except Exception:
                        pass
                gen["epics"] = epic_infos

        return {
            "phase": gen.get("phase", "idle"),
            "progress_pct": gen.get("progress_pct", 0),
            "agents": gen.get("agents", []),
            "epics": gen.get("epics", []),
            "service_count": gen.get("service_count", 0),
            "endpoint_count": gen.get("endpoint_count", 0),
            "completed": gen.get("completed", 0),
            "failed": gen.get("failed", 0),
            "total": gen.get("total", 0),
            "running": True,
        }

    # Fallback: container status
    try:
        container_name = f"project-{projectId}"
        stdout, stderr, rc = await run_command(
            f"docker inspect --format='{{{{.State.Status}}}}' {container_name}"
        )
        if rc != 0:
            return {"phase": "idle", "progress_pct": 0, "agents": [], "epics": [],
                    "service_count": 0, "endpoint_count": 0, "running": False}

        status = stdout.strip().strip("'")
        info = _project_containers.get(projectId, {})
        return {"phase": "idle", "progress_pct": 0, "agents": [], "epics": [],
                "service_count": 0, "endpoint_count": 0,
                "running": (status == 'running'),
                "vncPort": info.get('vncPort'), "appPort": info.get('appPort'),
                "health": status}
    except Exception:
        return {"phase": "idle", "progress_pct": 0, "agents": [], "epics": [],
                "service_count": 0, "endpoint_count": 0, "running": False}


@router.get("/project/logs", response_model=LogsResponse)
async def get_project_logs(
    projectId: str = Query(..., description="Project ID"),
    tail: int = Query(100, description="Number of lines to return")
) -> LogsResponse:
    """
    Get project container logs.
    """
    try:
        container_name = f"project-{projectId}"

        stdout, stderr, rc = await run_command(f'docker logs --tail {tail} {container_name}')

        if rc != 0:
            return LogsResponse(logs=f"Error: {stderr or 'Container not found'}")

        return LogsResponse(logs=stdout + stderr)
    except Exception as e:
        return LogsResponse(logs=f"Error: {str(e)}")


@router.post("/generate", response_model=SuccessResponse)
async def start_generation(request: GenerateRequest) -> SuccessResponse:
    """
    Start a code generation job.
    """
    try:
        engine_root = Path(__file__).parent.parent.parent.parent

        # Build command
        cmd = f'python run_society_hybrid.py "{request.requirementsPath}" --output-dir "{request.outputDir}" --fast'

        # Start generation in background
        # Remove CLAUDECODE env var to prevent "nested session" error
        # when the generation pipeline spawns Claude CLI subprocesses
        env = os.environ.copy()
        env.pop('CLAUDECODE', None)

        process = subprocess.Popen(
            cmd,
            shell=True,
            cwd=str(engine_root),
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL,
            env=env,
            creationflags=subprocess.CREATE_NEW_PROCESS_GROUP if os.name == 'nt' else 0
        )

        logger.info("generation_started", requirements=request.requirementsPath, output=request.outputDir)
        return SuccessResponse(success=True)
    except Exception as e:
        logger.error("generation_start_failed", error=str(e))
        return SuccessResponse(success=False, error=str(e))


class StopGenerationRequest(BaseModel):
    """Request to stop any running generation."""
    project_id: str


@router.post("/stop-generation", response_model=SuccessResponse)
async def stop_generation(request: StopGenerationRequest):
    """
    Gracefully stop any running generation (epic or legacy).

    Pauses all running EpicOrchestrators so they finish the current task
    before stopping. The checkpoint is preserved for later resume.
    """
    try:
        paused_count = 0
        for key, orch in _epic_orchestrators.items():
            try:
                if orch.is_running() and not orch.is_paused():
                    orch.pause()
                    paused_count += 1
                    logger.info("epic_orchestrator_paused", key=key, project_id=request.project_id)
            except Exception as e:
                logger.warning("epic_orchestrator_pause_failed", key=key, error=str(e))

        # Publish stop event to dashboard
        if _event_bus:
            try:
                from src.mind.event_bus import Event, EventType
                await _event_bus.publish(Event(
                    type=EventType.TASK_PROGRESS_UPDATE,
                    source="stop_generation",
                    data={
                        "type": "generation_stopped",
                        "project_id": request.project_id,
                        "paused_orchestrators": paused_count,
                    }
                ))
            except Exception:
                pass

        logger.info("generation_stopped", project_id=request.project_id, paused=paused_count)
        return SuccessResponse(success=True)
    except Exception as e:
        logger.error("generation_stop_failed", error=str(e))
        return SuccessResponse(success=False, error=str(e))


@router.delete("/events/cleanup")
async def cleanup_old_events(
    days: int = Query(7, ge=1, le=365, description="Delete events older than N days"),
    service: DashboardService = Depends(get_dashboard_service)
) -> dict:
    """
    Clean up old connection events from the database.

    Deletes events older than the specified number of days to maintain performance.

    Args:
        days: Number of days to retain (default: 7)

    Returns:
        Count of deleted events
    """
    try:
        deleted_count = await service.cleanup_old_events(days=days)

        logger.info(
            "events_cleaned_up",
            deleted_count=deleted_count,
            retention_days=days
        )

        return {
            "success": True,
            "deleted_count": deleted_count,
            "retention_days": days,
            "message": f"Deleted {deleted_count} events older than {days} days"
        }

    except Exception as e:
        logger.error("cleanup_failed", error=str(e))
        raise HTTPException(status_code=500, detail=f"Failed to clean up events: {str(e)}")


# ============================================================================
# Review Gate Endpoints (Pause/Resume Generation for User Review)
# ============================================================================

# Global instances - these will be set by the main API module
_shared_state: Optional[SharedState] = None
_event_bus: Optional[EventBus] = None


def set_review_gate_dependencies(shared_state: SharedState, event_bus: EventBus) -> None:
    """Set the global SharedState and EventBus instances for review gate."""
    global _shared_state, _event_bus
    _shared_state = shared_state
    _event_bus = event_bus


def set_event_bus(event_bus: EventBus) -> None:
    """Set the EventBus for dashboard routes (used by run_engine.py).

    This allows external callers to inject a shared EventBus without
    requiring a SharedState instance (which is only available in the
    full Society of Mind pipeline).
    """
    global _event_bus
    _event_bus = event_bus


@router.post("/generation/{project_id}/pause")
async def pause_generation(project_id: str):
    """
    Pause generation for user review.

    The generation will pause after the current batch completes.
    """
    if not _shared_state:
        raise HTTPException(status_code=503, detail="SharedState not initialized")

    try:
        await _shared_state.pause_for_review()

        if _event_bus:
            await _event_bus.publish(Event(
                type=EventType.REVIEW_PAUSE_REQUESTED,
                source="dashboard",
                data={"project_id": project_id}
            ))

        logger.info("pause_requested", project_id=project_id)
        return {"success": True, "status": "pause_requested"}

    except Exception as e:
        logger.error("pause_failed", project_id=project_id, error=str(e))
        raise HTTPException(status_code=500, detail=f"Failed to pause: {str(e)}")


@router.post("/generation/{project_id}/resume")
async def resume_generation(project_id: str, request: ReviewResumeRequest):
    """
    Resume generation after user review.

    Optionally include feedback to inject into the next generation iteration.
    """
    if not _shared_state:
        raise HTTPException(status_code=503, detail="SharedState not initialized")

    try:
        await _shared_state.resume_from_review(request.feedback)

        if _event_bus:
            await _event_bus.publish(Event(
                type=EventType.REVIEW_RESUME_REQUESTED,
                source="dashboard",
                data={
                    "project_id": project_id,
                    "has_feedback": bool(request.feedback)
                }
            ))

        logger.info(
            "resume_requested",
            project_id=project_id,
            has_feedback=bool(request.feedback)
        )
        return {"success": True, "status": "resumed"}

    except Exception as e:
        logger.error("resume_failed", project_id=project_id, error=str(e))
        raise HTTPException(status_code=500, detail=f"Failed to resume: {str(e)}")


@router.get("/generation/{project_id}/review-status")
async def get_review_status(project_id: str):
    """Get the current review gate status."""
    if not _shared_state:
        raise HTTPException(status_code=503, detail="SharedState not initialized")

    return _shared_state.get_review_status()


@router.post("/generation/{project_id}/feedback")
async def submit_review_feedback(project_id: str, request: ReviewResumeRequest):
    """
    Submit additional feedback during pause.

    This allows the user to add multiple feedback items before resuming.
    """
    if not _shared_state:
        raise HTTPException(status_code=503, detail="SharedState not initialized")

    if not request.feedback:
        raise HTTPException(status_code=400, detail="Feedback is required")

    try:
        await _shared_state.submit_review_feedback(request.feedback)

        if _event_bus:
            await _event_bus.publish(Event(
                type=EventType.REVIEW_FEEDBACK_SUBMITTED,
                source="dashboard",
                data={
                    "project_id": project_id,
                    "feedback_length": len(request.feedback)
                }
            ))

        logger.info(
            "feedback_submitted",
            project_id=project_id,
            feedback_length=len(request.feedback)
        )
        return {"success": True, "feedback_accepted": True}

    except Exception as e:
        logger.error("feedback_submit_failed", project_id=project_id, error=str(e))
        raise HTTPException(status_code=500, detail=f"Failed to submit feedback: {str(e)}")


# =============================================================================
# Clarification API (Tier 1 Core Intelligence)
# =============================================================================

# Pydantic models for clarification
class ClarificationChoice(BaseModel):
    """Single choice submission for a clarification question."""
    ambiguity_id: str
    interpretation_id: str


class ClarificationSubmitRequest(BaseModel):
    """Request to submit clarification choices."""
    choices: List[ClarificationChoice]
    use_defaults_for_remaining: bool = False


class ClarificationQuestionOption(BaseModel):
    """Option for a clarification question."""
    id: str
    label: str
    description: str
    is_recommended: bool = False


class ClarificationQuestion(BaseModel):
    """Single clarification question."""
    ambiguity_id: str
    description: str
    requirement_text: str
    severity: str
    options: List[ClarificationQuestionOption]


class ClarificationStatusResponse(BaseModel):
    """Response for clarification status."""
    has_pending: bool
    request_id: Optional[str] = None
    questions: List[ClarificationQuestion] = []
    answered: int = 0
    total: int = 0
    is_complete: bool = False


# Global clarification gate reference (set by initialize_event_systems)
_clarification_gate = None


def set_clarification_gate(gate):
    """Set the clarification gate instance."""
    global _clarification_gate
    _clarification_gate = gate


@router.get("/generation/{project_id}/clarifications")
async def get_clarification_status(project_id: str) -> ClarificationStatusResponse:
    """
    Get the current clarification status.

    Returns pending clarification questions if any exist.
    """
    if not _clarification_gate:
        return ClarificationStatusResponse(has_pending=False)

    pending_requests = _clarification_gate.get_pending_requests()
    if not pending_requests:
        return ClarificationStatusResponse(has_pending=False)

    # Get the first pending request
    request = pending_requests[0]

    questions = []
    for iset in request.interpretation_sets:
        options = [
            ClarificationQuestionOption(
                id=interp.id,
                label=interp.label,
                description=interp.description,
                is_recommended=interp.is_recommended,
            )
            for interp in iset.interpretations
        ]
        questions.append(
            ClarificationQuestion(
                ambiguity_id=iset.ambiguity.id,
                description=iset.ambiguity.description,
                requirement_text=iset.ambiguity.requirement_text[:200],
                severity=iset.ambiguity.severity.value,
                options=options,
            )
        )

    return ClarificationStatusResponse(
        has_pending=True,
        request_id=request.id,
        questions=questions,
        answered=request.answered_questions,
        total=request.total_questions,
        is_complete=request.is_complete,
    )


@router.post("/generation/{project_id}/clarifications/submit")
async def submit_clarification_choices(
    project_id: str,
    request: ClarificationSubmitRequest,
):
    """
    Submit clarification choices.

    Can submit one or more choices at a time.
    Set use_defaults_for_remaining=true to use recommended defaults for unanswered questions.
    """
    if not _clarification_gate:
        raise HTTPException(status_code=503, detail="ClarificationGate not initialized")

    pending_requests = _clarification_gate.get_pending_requests()
    if not pending_requests:
        raise HTTPException(status_code=404, detail="No pending clarification request")

    clar_request = pending_requests[0]

    try:
        # Submit each choice
        for choice in request.choices:
            success = await _clarification_gate.submit_choice(
                request_id=clar_request.id,
                ambiguity_id=choice.ambiguity_id,
                interpretation_id=choice.interpretation_id,
            )
            if not success:
                logger.warning(
                    "clarification_choice_rejected",
                    ambiguity_id=choice.ambiguity_id,
                    interpretation_id=choice.interpretation_id,
                )

        # Use defaults for remaining if requested
        if request.use_defaults_for_remaining:
            await _clarification_gate.use_defaults(clar_request.id)

        # Get updated status
        updated_request = _clarification_gate.get_request(clar_request.id)

        if _event_bus and updated_request:
            await _event_bus.publish(Event(
                type=EventType.CLARIFICATION_CHOICE_SUBMITTED,
                source="dashboard",
                data={
                    "project_id": project_id,
                    "request_id": clar_request.id,
                    "choices_submitted": len(request.choices),
                    "is_complete": updated_request.is_complete,
                }
            ))

        logger.info(
            "clarification_choices_submitted",
            project_id=project_id,
            choices=len(request.choices),
            is_complete=updated_request.is_complete if updated_request else False,
        )

        return {
            "success": True,
            "is_complete": updated_request.is_complete if updated_request else False,
            "remaining": updated_request.total_questions - updated_request.answered_questions
            if updated_request else 0,
        }

    except Exception as e:
        logger.error("clarification_submit_failed", project_id=project_id, error=str(e))
        raise HTTPException(status_code=500, detail=f"Failed to submit clarifications: {str(e)}")


@router.post("/generation/{project_id}/clarifications/use-defaults")
async def use_default_clarifications(project_id: str):
    """
    Use recommended defaults for all pending clarification questions.

    This allows the generation to proceed without manual choices.
    """
    if not _clarification_gate:
        raise HTTPException(status_code=503, detail="ClarificationGate not initialized")

    pending_requests = _clarification_gate.get_pending_requests()
    if not pending_requests:
        raise HTTPException(status_code=404, detail="No pending clarification request")

    clar_request = pending_requests[0]

    try:
        await _clarification_gate.use_defaults(clar_request.id)

        if _event_bus:
            await _event_bus.publish(Event(
                type=EventType.CLARIFICATION_RESOLVED,
                source="dashboard",
                data={
                    "project_id": project_id,
                    "request_id": clar_request.id,
                    "used_defaults": True,
                }
            ))

        logger.info(
            "clarification_defaults_used",
            project_id=project_id,
            request_id=clar_request.id,
        )

        return {"success": True, "used_defaults": True}

    except Exception as e:
        logger.error("clarification_defaults_failed", project_id=project_id, error=str(e))
        raise HTTPException(status_code=500, detail=f"Failed to use defaults: {str(e)}")


@router.post("/generation/{project_id}/clarifications/cancel")
async def cancel_clarification(project_id: str):
    """
    Cancel the current clarification request.

    This will cancel the clarification and may cause generation to fail
    or use defaults.
    """
    if not _clarification_gate:
        raise HTTPException(status_code=503, detail="ClarificationGate not initialized")

    pending_requests = _clarification_gate.get_pending_requests()
    if not pending_requests:
        raise HTTPException(status_code=404, detail="No pending clarification request")

    clar_request = pending_requests[0]

    try:
        _clarification_gate.cancel_request(clar_request.id)

        logger.info(
            "clarification_cancelled",
            project_id=project_id,
            request_id=clar_request.id,
        )

        return {"success": True, "cancelled": True}

    except Exception as e:
        logger.error("clarification_cancel_failed", project_id=project_id, error=str(e))
        raise HTTPException(status_code=500, detail=f"Failed to cancel: {str(e)}")


# =============================================================================
# Clarification Queue Notifications (Non-Blocking Mode)
# =============================================================================


@router.get("/notifications/clarifications")
async def get_pending_clarifications():
    """
    Get all pending clarification notifications from the queue.

    In queue mode, clarifications are collected without blocking generation.
    This endpoint returns all pending clarifications that need user attention.

    Returns:
        List of pending clarifications with:
        - id: Unique clarification ID
        - ambiguity_id: ID of the detected ambiguity
        - description: Human-readable description
        - requirement_text: Original requirement text
        - interpretations: List of possible interpretations
        - priority: 1=high, 2=medium, 3=low
        - severity: high, medium, low
        - queued_at: When it was added to queue
        - timeout_at: When it will auto-resolve
    """
    if not _clarification_gate:
        return {"pending": [], "queue_mode": False}

    if not _clarification_gate.queue_mode:
        # Not in queue mode, return empty
        return {"pending": [], "queue_mode": False}

    pending = _clarification_gate.get_pending_from_queue()

    return {
        "pending": pending,
        "queue_mode": True,
        "count": len(pending),
        "statistics": _clarification_gate._queue.get_statistics() if _clarification_gate._queue else {},
    }


@router.post("/notifications/clarifications/{clarification_id}/resolve")
async def resolve_queued_clarification(
    clarification_id: str,
    choice: ClarificationChoice,
):
    """
    Resolve a specific clarification from the queue.

    Args:
        clarification_id: The queue item ID (CLARQ-XXXX)
        choice: Contains interpretation_id to select

    Returns:
        Success status and remaining pending count
    """
    if not _clarification_gate:
        raise HTTPException(status_code=503, detail="ClarificationGate not initialized")

    if not _clarification_gate.queue_mode:
        raise HTTPException(status_code=400, detail="Not in queue mode")

    success = await _clarification_gate.resolve_from_queue(
        clarification_id,
        choice.interpretation_id
    )

    if not success:
        raise HTTPException(status_code=404, detail="Clarification not found or invalid interpretation")

    pending = _clarification_gate.get_pending_from_queue()

    return {
        "success": True,
        "clarification_id": clarification_id,
        "interpretation_id": choice.interpretation_id,
        "pending_count": len(pending),
    }


@router.post("/notifications/clarifications/resolve-all-defaults")
async def resolve_all_clarifications_with_defaults():
    """
    Auto-resolve all pending clarifications with recommended defaults.

    Use this when the user wants to accept all default interpretations
    and continue generation without reviewing each one.

    Returns:
        Number of clarifications resolved
    """
    if not _clarification_gate:
        raise HTTPException(status_code=503, detail="ClarificationGate not initialized")

    if not _clarification_gate.queue_mode:
        raise HTTPException(status_code=400, detail="Not in queue mode")

    count = await _clarification_gate.resolve_all_defaults_from_queue()

    return {
        "success": True,
        "resolved_count": count,
        "pending_count": len(_clarification_gate.get_pending_from_queue()),
    }


@router.get("/notifications/clarifications/statistics")
async def get_clarification_statistics():
    """
    Get statistics about the clarification queue.

    Returns:
        - total: Total clarifications ever queued
        - pending: Currently pending
        - resolved: Already resolved
        - auto_resolved: Resolved by timeout
        - by_priority: Breakdown by priority level
        - by_severity: Breakdown by severity level
    """
    if not _clarification_gate or not _clarification_gate._queue:
        return {
            "queue_mode": False,
            "statistics": {},
        }

    return {
        "queue_mode": _clarification_gate.queue_mode,
        "statistics": _clarification_gate._queue.get_statistics(),
    }


# =============================================================================
# Sandbox Error Reporting (for auto-fix integration)
# =============================================================================

@router.post("/sandbox/report-error")
async def report_sandbox_error(report: SandboxErrorReport):
    """
    Receive error reports from Docker sandbox containers.

    When a sandbox container encounters a build failure or runtime error,
    it POSTs the error details here. This endpoint parses the error
    and publishes BUILD_FAILED or SANDBOX_TEST_FAILED events to the EventBus,
    which triggers the ContinuousDebugAgent to auto-fix the code.

    This enables the "auto-fix on error" loop:
    1. Sandbox builds/runs code -> fails
    2. Sandbox POSTs error to this endpoint
    3. This endpoint publishes BUILD_FAILED event
    4. ContinuousDebugAgent receives event
    5. Agent analyzes error, generates fix
    6. Agent syncs fix to container via docker cp
    7. Sandbox rebuilds -> repeat until success
    """
    if not _event_bus:
        logger.warning("sandbox_error_received_but_eventbus_not_initialized",
                      project_id=report.project_id)
        return {"success": False, "error": "EventBus not initialized"}

    try:
        # Parse build output into structured payload
        payload = BuildFailurePayload.from_build_output(
            output=report.build_output,
            exit_code=report.exit_code
        )
        payload.failing_command = f"{report.project_type} build" if report.project_type else "build"

        # Determine event type based on error type
        if report.error_type == "build_failed":
            event_type = EventType.BUILD_FAILED
        elif report.error_type == "test_failed":
            event_type = EventType.SANDBOX_TEST_FAILED
        elif report.error_type in ("database_migration_failed", "database_runtime_error"):
            event_type = EventType.VALIDATION_ERROR
            # Mark as database error for DatabaseDockerAgent to pick up
            payload.is_database_error = True
        else:
            event_type = EventType.BUILD_FAILED  # Default to build failed

        # Publish event to trigger auto-fix
        await _event_bus.publish(Event(
            type=event_type,
            source="sandbox",
            data={
                "project_id": report.project_id,
                "container_name": report.container_name,
                "working_dir": report.working_dir,
                "project_type": report.project_type,
                **payload.to_dict()
            }
        ))

        logger.info(
            "sandbox_error_published",
            project_id=report.project_id,
            error_type=report.error_type,
            error_count=payload.error_count,
            is_type_error=payload.is_type_error,
            is_import_error=payload.is_import_error,
            is_database_error=payload.is_database_error,
            affected_files=payload.affected_files[:5]  # Log first 5 files
        )

        return {
            "success": True,
            "event_published": event_type.value,
            "error_count": payload.error_count,
            "affected_files": payload.affected_files
        }

    except Exception as e:
        logger.error("sandbox_error_report_failed",
                    project_id=report.project_id, error=str(e))
        raise HTTPException(status_code=500, detail=f"Failed to process error report: {str(e)}")


# =============================================================================
# Epic-based Task Management API
# =============================================================================

# Pydantic models for Epic management
class EpicResponse(BaseModel):
    """Single Epic response."""
    id: str
    name: str
    description: str
    status: str
    progress_percent: float
    user_stories: List[str]
    requirements: List[str]
    entities: List[str]
    api_endpoints: List[str]
    last_run_at: Optional[str] = None
    run_count: int = 0


class EpicListResponse(BaseModel):
    """Response for listing all epics."""
    project_path: str
    total_epics: int
    epics: List[EpicResponse]


class LocalProjectResponse(BaseModel):
    """Response for a local project found in Data/all_services."""
    project_id: str
    project_name: str
    project_path: str
    has_user_stories: bool
    has_api_docs: bool
    has_data_dictionary: bool
    epic_count: int = 0
    user_story_count: int = 0
    created_at: Optional[str] = None


class LocalProjectsResponse(BaseModel):
    """Response for local projects scan."""
    projects: List[LocalProjectResponse]
    total: int
    scan_path: str


@router.get("/local-projects", response_model=LocalProjectsResponse)
async def scan_local_projects(
    base_path: str = Query("Data/all_services", description="Base path to scan for projects")
):
    """
    Scan for local projects in the Data/all_services folder.

    Returns all project folders that contain user_stories.md or other spec files.
    This allows the dashboard to display projects without needing the req-orchestrator.
    """
    try:
        engine_root = Path(__file__).parent.parent.parent.parent
        scan_path = engine_root / base_path

        if not scan_path.exists():
            raise HTTPException(status_code=404, detail=f"Path does not exist: {scan_path}")

        projects = []

        for project_dir in sorted(scan_path.iterdir()):
            if not project_dir.is_dir():
                continue

            # Check for spec files
            user_stories_path = project_dir / "user_stories" / "user_stories.md"
            api_docs_path = project_dir / "api" / "api_documentation.md"
            data_dict_path = project_dir / "data" / "data_dictionary.md"

            has_user_stories = user_stories_path.exists()
            has_api_docs = api_docs_path.exists()
            has_data_dict = data_dict_path.exists()

            # Skip folders without any spec files
            if not (has_user_stories or has_api_docs or has_data_dict):
                continue

            # Count epics and user stories if user_stories.md exists
            epic_count = 0
            user_story_count = 0

            if has_user_stories:
                try:
                    content = user_stories_path.read_text(encoding='utf-8')
                    import re
                    epic_count = len(re.findall(r'## EPIC-\d+:', content))
                    user_story_count = len(re.findall(r'### US-\d+:', content))
                except Exception:
                    pass

            # Get creation time
            try:
                created_at = datetime.fromtimestamp(project_dir.stat().st_ctime).isoformat()
            except Exception:
                created_at = None

            # Generate readable name from folder name
            folder_name = project_dir.name
            if folder_name.startswith("unnamed_project_"):
                # "unnamed_project_20260204_165411" -> "Project (Feb 04, 2026)"
                parts = folder_name.replace("unnamed_project_", "").split("_")
                if len(parts) >= 1 and len(parts[0]) == 8:
                    date_str = parts[0]
                    try:
                        date = datetime.strptime(date_str, "%Y%m%d")
                        project_name = f"Project ({date.strftime('%b %d, %Y')})"
                    except ValueError:
                        project_name = folder_name
                else:
                    project_name = folder_name
            else:
                project_name = folder_name.replace("_", " ").replace("-", " ").title()

            projects.append(LocalProjectResponse(
                project_id=folder_name,
                project_name=project_name,
                project_path=str(project_dir),
                has_user_stories=has_user_stories,
                has_api_docs=has_api_docs,
                has_data_dictionary=has_data_dict,
                epic_count=epic_count,
                user_story_count=user_story_count,
                created_at=created_at,
            ))

        return LocalProjectsResponse(
            projects=projects,
            total=len(projects),
            scan_path=str(scan_path),
        )

    except HTTPException:
        raise
    except Exception as e:
        logger.error("local_projects_scan_failed", error=str(e))
        raise HTTPException(status_code=500, detail=f"Failed to scan projects: {str(e)}")


class EpicTaskResponse(BaseModel):
    """Single task response."""
    id: str
    epic_id: str
    type: str
    title: str
    description: str
    status: str
    dependencies: List[str]
    estimated_minutes: int
    actual_minutes: Optional[int] = None
    error_message: Optional[str] = None
    output_files: List[str] = []
    related_requirements: List[str] = []
    related_user_stories: List[str] = []
    tested: bool = False
    user_fix_instructions: Optional[str] = None


class EpicTaskListResponse(BaseModel):
    """Task list response for an epic."""
    epic_id: str
    epic_name: str
    tasks: List[EpicTaskResponse]
    total_tasks: int
    completed_tasks: int
    failed_tasks: int
    progress_percent: float
    estimated_total_minutes: int
    run_count: int
    last_run_at: Optional[str] = None


class RunEpicRequest(BaseModel):
    """Request to run an epic."""
    project_path: str
    max_parallel_tasks: int = 1  # 1=sequential (default), 2-5=parallel


class TaskRerunRequest(BaseModel):
    """Request to rerun a single task."""
    project_path: str
    fix_instructions: Optional[str] = None


class GenerateTaskListsRequest(BaseModel):
    """Request to generate task lists."""
    project_path: str


class ChatRequest(BaseModel):
    """Request for interactive Claude chat (Cursor-like)."""
    message: str
    project_path: str
    output_dir: str
    history: list = []


@router.get("/epics", response_model=EpicListResponse)
async def get_epics(project_path: str = Query(..., description="Path to the project")):
    """
    Get all epics from a project.

    Parses the user_stories.md file and extracts epic information.
    """
    try:
        # Import the epic parser
        import sys
        engine_root = Path(__file__).parent.parent.parent.parent
        sys.path.insert(0, str(engine_root / "mcp_plugins" / "servers" / "grpc_host"))

        from epic_parser import EpicParser

        parser = EpicParser(project_path)
        epics = parser.parse_all_epics()

        epic_responses = [
            EpicResponse(
                id=e.id,
                name=e.name,
                description=e.description[:500] if e.description else "",
                status=e.status,
                progress_percent=e.progress_percent,
                user_stories=e.user_stories,
                requirements=e.requirements,
                entities=e.entities,
                api_endpoints=e.api_endpoints,
                last_run_at=e.last_run_at,
                run_count=e.run_count,
            )
            for e in epics
        ]

        logger.info("epics_fetched", project_path=project_path, count=len(epics))

        return EpicListResponse(
            project_path=project_path,
            total_epics=len(epics),
            epics=epic_responses,
        )

    except FileNotFoundError as e:
        logger.error("epics_fetch_failed", project_path=project_path, error=str(e))
        raise HTTPException(status_code=404, detail=f"Project not found: {str(e)}")
    except Exception as e:
        logger.error("epics_fetch_failed", project_path=project_path, error=str(e))
        raise HTTPException(status_code=500, detail=f"Failed to fetch epics: {str(e)}")


@router.get("/epic/{epic_id}/tasks", response_model=EpicTaskListResponse)
async def get_epic_tasks(
    epic_id: str,
    project_path: str = Query(..., description="Path to the project")
):
    """
    Get tasks for a specific epic.

    Returns the task list if it exists, or generates it on-demand.
    """
    try:
        import sys
        engine_root = Path(__file__).parent.parent.parent.parent
        sys.path.insert(0, str(engine_root / "mcp_plugins" / "servers" / "grpc_host"))

        from epic_task_generator import EpicTaskGenerator

        generator = EpicTaskGenerator(project_path)

        # Try to load existing tasks first
        task_list = generator.load_epic_tasks(epic_id)

        # If no existing tasks, generate them
        if not task_list:
            task_list = generator.generate_tasks_for_epic(epic_id)
            generator.save_epic_tasks(epic_id)

        task_responses = [
            EpicTaskResponse(
                id=t.id,
                epic_id=t.epic_id,
                type=t.type,
                title=t.title,
                description=t.description,
                status=t.status,
                dependencies=t.dependencies,
                estimated_minutes=t.estimated_minutes,
                actual_minutes=t.actual_minutes,
                error_message=t.error_message,
            )
            for t in task_list.tasks
        ]

        logger.info("epic_tasks_fetched", epic_id=epic_id, task_count=len(task_responses))

        return EpicTaskListResponse(
            epic_id=task_list.epic_id,
            epic_name=task_list.epic_name,
            tasks=task_responses,
            total_tasks=task_list.total_tasks,
            completed_tasks=task_list.completed_tasks,
            failed_tasks=task_list.failed_tasks,
            progress_percent=task_list.progress_percent,
            estimated_total_minutes=task_list.estimated_total_minutes,
            run_count=task_list.run_count,
            last_run_at=task_list.last_run_at,
        )

    except ValueError as e:
        logger.error("epic_tasks_fetch_failed", epic_id=epic_id, error=str(e))
        raise HTTPException(status_code=404, detail=f"Epic not found: {str(e)}")
    except Exception as e:
        logger.error("epic_tasks_fetch_failed", epic_id=epic_id, error=str(e))
        raise HTTPException(status_code=500, detail=f"Failed to fetch epic tasks: {str(e)}")


@router.post("/epic/{epic_id}/run", response_model=SuccessResponse)
async def run_epic(epic_id: str, request: RunEpicRequest):
    """
    Start running an epic with LLM code generation.

    This initiates the actual code generation process for all tasks in the epic
    using the EpicOrchestrator and TaskExecutor with Claude Code Tool.
    Progress updates are sent via WebSocket.
    """
    try:
        import sys
        engine_root = Path(__file__).parent.parent.parent.parent
        sys.path.insert(0, str(engine_root / "mcp_plugins" / "servers" / "grpc_host"))

        from epic_orchestrator import EpicOrchestrator

        # Load SoM bridge config from society_defaults.json
        som_config = {}
        config_path = Path(__file__).parent.parent.parent.parent / "config" / "society_defaults.json"
        if config_path.exists():
            try:
                import json as _json
                som_config = _json.loads(config_path.read_text(encoding="utf-8")).get("som_bridge", {})
            except Exception:
                pass

        # Create orchestrator with event bus for WebSocket updates
        # max_parallel_tasks: 1=sequential (default), 2-5=parallel execution
        # enable_som=True activates convergence loop (validate→fix→re-run)
        orchestrator = EpicOrchestrator(
            project_path=request.project_path,
            event_bus=_event_bus,
            max_parallel_tasks=request.max_parallel_tasks,
            enable_som=True,
            som_config=som_config,
        )

        logger.info(
            "epic_orchestrator_created",
            epic_id=epic_id,
            max_parallel=request.max_parallel_tasks
        )

        # Store orchestrator reference for checkpoint approval
        global _epic_orchestrators
        if '_epic_orchestrators' not in globals():
            _epic_orchestrators = {}
        _epic_orchestrators[epic_id] = orchestrator

        # Run epic in background task
        asyncio.create_task(_run_epic_background(epic_id, orchestrator))

        logger.info("epic_run_started", epic_id=epic_id, project_path=request.project_path)

        return SuccessResponse(success=True)

    except Exception as e:
        logger.error("epic_run_failed", epic_id=epic_id, error=str(e))
        return SuccessResponse(success=False, error=str(e))


# Global orchestrator storage for checkpoint approval
_epic_orchestrators: dict = {}


async def _run_epic_background(epic_id: str, orchestrator):
    """Background task to run epic execution."""
    try:
        result = await orchestrator.run_epic(epic_id)

        # Publish completion event
        if _event_bus:
            await _event_bus.publish(Event(
                type=EventType.GENERATION_COMPLETE if result.success else EventType.BUILD_FAILED,
                source="epic_orchestrator",
                data={
                    "epic_id": epic_id,
                    "success": result.success,
                    "completed_tasks": result.completed_tasks,
                    "failed_tasks": result.failed_tasks,
                    "duration_seconds": result.duration_seconds,
                    "error": result.error,
                }
            ))

        logger.info(
            "epic_run_completed",
            epic_id=epic_id,
            success=result.success,
            completed=result.completed_tasks,
            failed=result.failed_tasks,
        )

    except Exception as e:
        logger.error("epic_run_background_failed", epic_id=epic_id, error=str(e))

        if _event_bus:
            await _event_bus.publish(Event(
                type=EventType.BUILD_FAILED,
                source="epic_orchestrator",
                data={"epic_id": epic_id, "error": str(e)}
            ))


@router.post("/epic/{epic_id}/rerun", response_model=SuccessResponse)
async def rerun_epic(epic_id: str, request: RunEpicRequest):
    """
    Rerun an epic, resetting all tasks to pending first.

    This allows re-executing a previously completed or failed epic.
    """
    try:
        import sys
        engine_root = Path(__file__).parent.parent.parent.parent
        sys.path.insert(0, str(engine_root / "mcp_plugins" / "servers" / "grpc_host"))

        from epic_task_generator import EpicTaskGenerator

        generator = EpicTaskGenerator(request.project_path)

        # Reset tasks
        generator.reset_epic_tasks(epic_id)

        # Publish event to start epic generation
        if _event_bus:
            await _event_bus.publish(Event(
                type=EventType.GENERATION_REQUESTED,
                source="dashboard",
                data={
                    "epic_id": epic_id,
                    "project_path": request.project_path,
                    "action": "rerun_epic",
                }
            ))

        logger.info("epic_rerun_started", epic_id=epic_id, project_path=request.project_path)

        return SuccessResponse(success=True)

    except Exception as e:
        logger.error("epic_rerun_failed", epic_id=epic_id, error=str(e))
        return SuccessResponse(success=False, error=str(e))


# =============================================================================
# Single-Task Rerun
# =============================================================================

@router.post("/epic/{epic_id}/task/{task_id}/rerun", response_model=SuccessResponse)
async def rerun_task(epic_id: str, task_id: str, request: TaskRerunRequest):
    """
    Rerun a single task within an epic, optionally with user fix instructions.

    The fix_instructions are injected into the LLM prompt for the next execution.
    """
    try:
        import sys
        engine_root = Path(__file__).parent.parent.parent.parent
        sys.path.insert(0, str(engine_root / "mcp_plugins" / "servers" / "grpc_host"))

        from epic_orchestrator import EpicOrchestrator

        global _epic_orchestrators

        orchestrator = _epic_orchestrators.get(epic_id)

        if not orchestrator:
            # Load SoM config
            som_config = {}
            config_path = engine_root / "config" / "society_defaults.json"
            if config_path.exists():
                try:
                    import json as _json
                    som_config = _json.loads(config_path.read_text(encoding="utf-8")).get("som_bridge", {})
                except Exception:
                    pass

            orchestrator = EpicOrchestrator(
                project_path=request.project_path,
                enable_som=False,
                som_config=som_config,
            )
            _epic_orchestrators[epic_id] = orchestrator

        # Run single task rerun in background
        asyncio.create_task(
            _rerun_task_background(epic_id, task_id, orchestrator, request.fix_instructions)
        )

        logger.info("task_rerun_started", epic_id=epic_id, task_id=task_id,
                     has_fix_instructions=bool(request.fix_instructions))

        return SuccessResponse(success=True)

    except Exception as e:
        logger.error("task_rerun_failed", epic_id=epic_id, task_id=task_id, error=str(e))
        return SuccessResponse(success=False, error=str(e))


async def _rerun_task_background(
    epic_id: str, task_id: str, orchestrator, fix_instructions: str = None
):
    """Background task for single-task rerun."""
    try:
        result = await orchestrator.rerun_single_task(epic_id, task_id, fix_instructions)

        if _event_bus:
            await _event_bus.publish(Event(
                type=EventType.GENERATION_COMPLETE,
                source="epic_orchestrator",
                data={
                    "epic_id": epic_id,
                    "task_id": task_id,
                    "action": "task_rerun",
                    "success": result.success,
                }
            ))
    except Exception as e:
        logger.error("task_rerun_background_failed", epic_id=epic_id,
                     task_id=task_id, error=str(e))


# =============================================================================
# Claude Chat (Cursor-like interactive coding assistant)
# =============================================================================

@router.post("/chat")
async def claude_chat(request: ChatRequest):
    """Interactive chat with Claude during generation.

    Cursor-like flow: user message -> Claude CLI -> code suggestions -> response.
    Claude receives the user message plus project context (build errors, changed
    files) and can directly modify files in the output directory.
    """
    try:
        import sys as _sys
        engine_root = Path(__file__).parent.parent.parent.parent
        _sys.path.insert(0, str(engine_root))

        from src.tools.claude_code_tool import ClaudeCodeTool

        output_dir = request.output_dir
        if not Path(output_dir).is_absolute():
            output_dir = str(Path(request.project_path) / output_dir)

        tool = ClaudeCodeTool(working_dir=output_dir)

        # Build prompt with conversation history and context
        parts = []
        if request.history:
            parts.append("Conversation so far:")
            for msg in request.history[-10:]:  # Last 10 messages
                role = msg.get("role", "user")
                content = msg.get("content", "")
                parts.append(f"  {role}: {content}")
            parts.append("")

        parts.append(f"User request: {request.message}")
        parts.append(f"\nWorking directory: {output_dir}")
        parts.append("Apply any code changes directly to the files.")

        prompt = "\n".join(parts)

        result = await tool.execute(
            prompt=prompt,
            agent_type="fixer",
        )

        # Extract modified/created file paths
        files_modified = []
        files_created = []
        for f in result.files:
            fp = f.path if hasattr(f, "path") else str(f)
            if Path(output_dir, fp).exists():
                files_modified.append(fp)
            else:
                files_created.append(fp)

        return {
            "success": result.success,
            "response": result.output or "",
            "files_modified": files_modified,
            "files_created": files_created,
            "error": result.error,
        }

    except Exception as e:
        logger.error("claude_chat_failed", error=str(e))
        return {
            "success": False,
            "response": "",
            "files_modified": [],
            "files_created": [],
            "error": str(e),
        }


# =============================================================================
# Debug Mode - Session Analysis & Fix-Task Generation
# =============================================================================

class DebugAnalyzeRequest(BaseModel):
    """Request to analyze a debug session and generate fix tasks."""
    project_id: str
    output_dir: str
    interactions: list = []  # List of {type, x, y, errorMessage, logContent, ...}


def _format_debug_errors(errors: list) -> str:
    """Format error interactions for the Claude analysis prompt."""
    if not errors:
        return "No errors recorded."
    lines = []
    for i, err in enumerate(errors, 1):
        msg = err.get("errorMessage") or err.get("logContent") or "Unknown error"
        src = err.get("sourceFile", "")
        ln = err.get("lineNumber", "")
        etype = err.get("errorType", err.get("logSource", "error"))
        loc = f" at {src}:{ln}" if src else ""
        lines.append(f"  {i}. [{etype}] {msg}{loc}")
    return "\n".join(lines)


def _format_debug_clicks(clicks: list) -> str:
    """Format click interactions for the Claude analysis prompt."""
    if not clicks:
        return "No click interactions recorded."
    lines = []
    for i, click in enumerate(clicks, 1):
        info = click.get("componentInfo", "")
        x = click.get("x", "?")
        y = click.get("y", "?")
        lines.append(f"  {i}. Click at ({x}%, {y}%) {info}")
    return "\n".join(lines)


def _parse_fix_tasks(output: str) -> list:
    """Parse Claude's response into fix task dicts."""
    import json as _json
    import re
    import uuid

    # Try to extract JSON array from the response
    # Claude may wrap it in markdown code blocks
    json_match = re.search(r'\[[\s\S]*?\]', output or "")
    if json_match:
        try:
            tasks = _json.loads(json_match.group())
            result = []
            for t in tasks:
                result.append({
                    "id": str(uuid.uuid4())[:8],
                    "title": t.get("title", "Fix task"),
                    "description": t.get("description", ""),
                    "error_type": t.get("error_type", t.get("errorType", "unknown")),
                    "affected_files": t.get("affected_files", t.get("affectedFiles", [])),
                    "suggested_fix": t.get("suggested_fix", t.get("suggestedFix", "")),
                    "severity": t.get("severity", "medium"),
                    "source_interactions": [],
                })
            return result
        except _json.JSONDecodeError:
            pass

    # Fallback: return a single generic task if we couldn't parse
    if output and output.strip():
        return [{
            "id": str(uuid.uuid4())[:8],
            "title": "Review debug session findings",
            "description": output[:500],
            "error_type": "analysis",
            "affected_files": [],
            "suggested_fix": output[:1000],
            "severity": "medium",
            "source_interactions": [],
        }]

    return []


@router.post("/debug/analyze")
async def analyze_debug_session(request: DebugAnalyzeRequest):
    """Analyze a debug session and generate fix tasks.

    Takes recorded interactions (clicks, errors, logs) and uses Claude
    to analyze patterns, identify root causes, and create actionable fix tasks.
    """
    try:
        import sys as _sys
        import uuid
        engine_root = Path(__file__).parent.parent.parent.parent
        _sys.path.insert(0, str(engine_root))

        from src.tools.claude_code_tool import ClaudeCodeTool

        output_dir = request.output_dir
        if not Path(output_dir).is_absolute():
            output_dir = str(Path(output_dir).resolve())

        # Separate errors/logs from clicks
        errors = [i for i in request.interactions if i.get("type") in ("error", "log")]
        clicks = [i for i in request.interactions if i.get("type") == "click"]

        if not errors and not clicks:
            return {"success": True, "fix_tasks": []}

        # Build analysis prompt
        prompt = f"""Analyze these debug session recordings from a web application and generate fix tasks.

ERRORS CAPTURED ({len(errors)}):
{_format_debug_errors(errors)}

USER INTERACTIONS ({len(clicks)} clicks on VNC preview):
{_format_debug_clicks(clicks)}

Based on these errors and user interactions, generate a JSON array of fix tasks.
Each task should be a JSON object with these fields:
- title: short description of the fix
- description: detailed explanation
- error_type: category (e.g. "runtime_error", "type_error", "api_error", "ui_bug")
- affected_files: array of file paths that likely need changes
- suggested_fix: approach to fix the issue
- severity: "critical", "high", "medium", or "low"

Return ONLY a JSON array, no other text."""

        tool = ClaudeCodeTool(working_dir=output_dir)
        result = await tool.execute(prompt=prompt, agent_type="fixer")

        fix_tasks = _parse_fix_tasks(result.output if result else "")

        logger.info(
            "debug_session_analyzed",
            project_id=request.project_id,
            errors=len(errors),
            clicks=len(clicks),
            fix_tasks=len(fix_tasks),
        )

        return {"success": True, "fix_tasks": fix_tasks}

    except Exception as e:
        logger.error("debug_analyze_failed", error=str(e))
        return {"success": False, "fix_tasks": [], "error": str(e)}


# =============================================================================
# Checkpoint Approval Endpoints
# =============================================================================

class CheckpointApprovalRequest(BaseModel):
    """Request to approve a checkpoint."""
    task_id: str
    response: Optional[str] = None


class CheckpointRejectRequest(BaseModel):
    """Request to reject a checkpoint."""
    task_id: str
    reason: str


@router.post("/epic/{epic_id}/checkpoint/approve", response_model=SuccessResponse)
async def approve_checkpoint(epic_id: str, request: CheckpointApprovalRequest):
    """
    Approve a checkpoint to continue epic execution.

    When the orchestrator reaches a checkpoint task, it waits for user approval.
    This endpoint approves the checkpoint and allows execution to continue.
    """
    try:
        if epic_id not in _epic_orchestrators:
            return SuccessResponse(success=False, error="No running orchestrator for this epic")

        orchestrator = _epic_orchestrators[epic_id]
        success = orchestrator.approve_checkpoint(request.task_id, request.response)

        if success:
            logger.info("checkpoint_approved", epic_id=epic_id, task_id=request.task_id)
            return SuccessResponse(success=True)
        else:
            return SuccessResponse(success=False, error="Checkpoint not found or already processed")

    except Exception as e:
        logger.error("checkpoint_approval_failed", epic_id=epic_id, error=str(e))
        return SuccessResponse(success=False, error=str(e))


@router.post("/epic/{epic_id}/checkpoint/reject", response_model=SuccessResponse)
async def reject_checkpoint(epic_id: str, request: CheckpointRejectRequest):
    """
    Reject a checkpoint, marking it as failed.

    This will cause the checkpoint task to fail and stop epic execution.
    """
    try:
        if epic_id not in _epic_orchestrators:
            return SuccessResponse(success=False, error="No running orchestrator for this epic")

        orchestrator = _epic_orchestrators[epic_id]
        success = orchestrator.task_executor.reject_checkpoint(request.task_id, request.reason)

        if success:
            logger.info("checkpoint_rejected", epic_id=epic_id, task_id=request.task_id, reason=request.reason)
            return SuccessResponse(success=True)
        else:
            return SuccessResponse(success=False, error="Checkpoint not found or already processed")

    except Exception as e:
        logger.error("checkpoint_rejection_failed", epic_id=epic_id, error=str(e))
        return SuccessResponse(success=False, error=str(e))


@router.post("/epic/{epic_id}/pause", response_model=SuccessResponse)
async def pause_epic_execution(epic_id: str):
    """
    Pause epic execution at the next task boundary.

    The current task will complete, but no new tasks will start.
    """
    try:
        if epic_id not in _epic_orchestrators:
            return SuccessResponse(success=False, error="No running orchestrator for this epic")

        orchestrator = _epic_orchestrators[epic_id]
        orchestrator.pause()

        logger.info("epic_paused", epic_id=epic_id)
        return SuccessResponse(success=True)

    except Exception as e:
        logger.error("epic_pause_failed", epic_id=epic_id, error=str(e))
        return SuccessResponse(success=False, error=str(e))


@router.get("/epic/{epic_id}/execution-status")
async def get_epic_execution_status(epic_id: str, project_path: str = Query(...)):
    """
    Get the current execution status of an epic.

    Returns whether the orchestrator is running, paused, and current task info.
    """
    try:
        status = {
            "epic_id": epic_id,
            "is_running": False,
            "is_paused": False,
            "current_task_id": None,
        }

        if epic_id in _epic_orchestrators:
            orchestrator = _epic_orchestrators[epic_id]
            status["is_running"] = orchestrator.is_running()
            status["is_paused"] = orchestrator.is_paused()
            status["current_task_id"] = orchestrator._current_task_id

        # Also get task progress from stored file
        import sys
        engine_root = Path(__file__).parent.parent.parent.parent
        sys.path.insert(0, str(engine_root / "mcp_plugins" / "servers" / "grpc_host"))

        from epic_orchestrator import EpicOrchestrator as EO

        temp_orch = EO(project_path)
        file_status = temp_orch.get_epic_status(epic_id)

        if file_status:
            status.update(file_status)

        return status

    except Exception as e:
        logger.error("epic_status_failed", epic_id=epic_id, error=str(e))
        return {"epic_id": epic_id, "error": str(e)}


# =============================================================================
# Parallelism Configuration
# =============================================================================

class ParallelismConfig(BaseModel):
    """Request to set parallelism."""
    max_parallel_tasks: int = 1  # 1-5


@router.get("/epic/{epic_id}/parallel-config")
async def get_parallel_config(epic_id: str):
    """
    Get the current parallelism configuration for an epic.

    Returns the max parallel tasks setting and current running task count.
    """
    try:
        if epic_id not in _epic_orchestrators:
            return {
                "epic_id": epic_id,
                "max_parallel_tasks": 1,
                "currently_running": 0,
                "running_task_ids": [],
                "max_allowed": 5,
                "message": "No active orchestrator, using defaults"
            }

        orchestrator = _epic_orchestrators[epic_id]
        config = orchestrator.get_parallel_config()
        config["epic_id"] = epic_id
        return config

    except Exception as e:
        logger.error("get_parallel_config_failed", epic_id=epic_id, error=str(e))
        return {"epic_id": epic_id, "error": str(e)}


@router.post("/epic/{epic_id}/parallel-config", response_model=SuccessResponse)
async def set_parallel_config(epic_id: str, config: ParallelismConfig):
    """
    Set the parallelism configuration for an epic.

    Args:
        epic_id: The epic to configure
        config.max_parallel_tasks: Number of tasks to run in parallel (1-5)

    Note: Setting max_parallel_tasks > 1 enables parallel execution of
    independent tasks (tasks with no dependencies on each other).
    Recommended: Start with 2-3 for typical projects.
    """
    try:
        if epic_id not in _epic_orchestrators:
            return SuccessResponse(
                success=False,
                error=f"No active orchestrator for {epic_id}. Start the epic first."
            )

        orchestrator = _epic_orchestrators[epic_id]
        success = orchestrator.set_max_parallel_tasks(config.max_parallel_tasks)

        if success:
            logger.info(
                "parallel_config_updated",
                epic_id=epic_id,
                max_parallel=config.max_parallel_tasks
            )
            return SuccessResponse(success=True)
        else:
            return SuccessResponse(
                success=False,
                error=f"Invalid value. Must be 1-5."
            )

    except Exception as e:
        logger.error("set_parallel_config_failed", epic_id=epic_id, error=str(e))
        return SuccessResponse(success=False, error=str(e))


class StartEpicGenerationRequest(BaseModel):
    """Request to start full epic-based generation for a project."""
    project_path: str
    output_dir: str
    vnc_port: int = 6090
    app_port: int = 3100
    max_parallel_tasks: int = 1  # 1=sequential (default), 2-5=parallel


@router.post("/start-epic-generation", response_model=SuccessResponse)
async def start_epic_generation(request: StartEpicGenerationRequest):
    """
    Start full epic-based code generation for a project.

    This is the main entry point when "Generate Code" is clicked on an RE project.
    It parses all epics, creates an EpicOrchestrator, and runs all epics in sequence
    as a background task. Progress updates are pushed via WebSocket events.
    Data is persisted to PostgreSQL (projects/jobs/tasks tables).
    """
    try:
        import sys as _sys
        engine_root = Path(__file__).parent.parent.parent.parent
        _sys.path.insert(0, str(engine_root / "mcp_plugins" / "servers" / "grpc_host"))

        from epic_orchestrator import EpicOrchestrator

        # Load SoM bridge config from society_defaults.json
        som_config = {}
        config_path = engine_root / "config" / "society_defaults.json"
        if config_path.exists():
            try:
                import json as _json
                raw = _json.loads(config_path.read_text(encoding="utf-8"))
                som_config = raw.get("som_bridge", {})
                # Override VNC/app ports with the allocated ones
                som_config["vnc_port"] = request.vnc_port
                som_config["app_port"] = request.app_port
            except Exception:
                pass

        # Resolve output dir
        output_dir = request.output_dir
        if not Path(output_dir).is_absolute():
            output_dir = str(Path(request.project_path) / output_dir)

        orchestrator = EpicOrchestrator(
            project_path=request.project_path,
            output_dir=output_dir,
            event_bus=_event_bus,
            max_parallel_tasks=request.max_parallel_tasks,
            enable_som=True,
            som_config=som_config,
        )

        # Generate project-specific MCP config for dynamic server configuration
        try:
            from src.mcp.project_config import generate_project_mcp_config, save_project_mcp_config
            project_id = Path(request.project_path).name
            mcp_config = generate_project_mcp_config(
                project_id=project_id,
                project_path=request.project_path,
                output_dir=output_dir,
                sandbox_container=f"sandbox-{project_id}",
                vnc_port=request.vnc_port,
                app_port=request.app_port,
            )
            save_project_mcp_config(mcp_config)
            logger.info("mcp_config_generated_for_project", project_id=project_id)
        except Exception as mcp_err:
            logger.warning("mcp_config_generation_failed", error=str(mcp_err))

        # Store orchestrator reference
        _epic_orchestrators[f"all:{request.project_path}"] = orchestrator

        # --- Persist Project + Job to PostgreSQL ---
        db_project_id = None
        db_job_id = None
        try:
            from src.models.base import get_session_factory
            from src.models.project import Project, ProjectStatus
            from src.models.job import Job, JobStatus
            import json as _json

            session_factory = get_session_factory()
            async with session_factory() as session:
                project_id_name = Path(request.project_path).name
                # Upsert project
                from sqlalchemy import select
                result = await session.execute(
                    select(Project).where(Project.name == project_id_name)
                )
                db_project = result.scalar_one_or_none()
                if not db_project:
                    db_project = Project(
                        name=project_id_name,
                        description=f"Generated from {request.project_path}",
                        status=ProjectStatus.ACTIVE,
                        config_json=_json.dumps({
                            "project_path": request.project_path,
                            "output_dir": output_dir,
                            "vnc_port": request.vnc_port,
                            "app_port": request.app_port,
                        }),
                    )
                    session.add(db_project)
                    await session.flush()
                else:
                    db_project.status = ProjectStatus.ACTIVE
                db_project_id = db_project.id

                # Create job
                db_job = Job(
                    project_id=db_project.id,
                    status=JobStatus.RUNNING,
                    requirements_json="{}",
                    source_file=request.project_path,
                )
                session.add(db_job)
                await session.flush()
                db_job_id = db_job.id
                await session.commit()
            logger.info("db_project_job_created", project_id=db_project_id, job_id=db_job_id)
        except Exception as db_err:
            logger.warning("db_persist_failed_continuing", error=str(db_err))

        # Set generation state so status endpoint reflects progress
        project_id = Path(request.project_path).name
        _generation_state[project_id] = {
            "phase": "generation",
            "progress_pct": 0,
            "completed": 0,
            "failed": 0,
            "total": 0,
            "agents": [],
            "epics": [],
            "service_count": 0,
            "endpoint_count": 0,
            "project_path": request.project_path,
            "db_project_id": db_project_id,
            "db_job_id": db_job_id,
        }

        # Run all epics in background
        asyncio.create_task(
            _run_all_epics_background(request.project_path, orchestrator, project_id)
        )

        logger.info(
            "epic_generation_started",
            project_path=request.project_path,
            output_dir=output_dir,
            vnc_port=request.vnc_port,
            db_project_id=db_project_id,
            db_job_id=db_job_id,
        )

        return SuccessResponse(success=True)

    except Exception as e:
        logger.error("epic_generation_start_failed", error=str(e))
        return SuccessResponse(success=False, error=str(e))


async def _run_all_epics_background(project_path: str, orchestrator, project_id: str = ""):
    """Background task to run all epics for a project. Persists progress to PostgreSQL."""
    if not project_id:
        project_id = Path(project_path).name

    # Get DB IDs from generation state
    gen_state = _generation_state.get(project_id, {})
    db_job_id = gen_state.get("db_job_id")
    db_project_id = gen_state.get("db_project_id")

    # Helper to update generation state from task files AND sync to DB
    async def _update_progress():
        try:
            import json as _json
            tasks_dir = Path(project_path) / "tasks"
            completed = failed = total = 0
            task_records = []
            for tf in tasks_dir.glob("epic-*-tasks.json"):
                with open(tf) as f:
                    data = _json.load(f)
                for t in data.get("tasks", []):
                    total += 1
                    s = t.get("status", "pending")
                    if s == "completed":
                        completed += 1
                    elif s == "failed":
                        failed += 1
                    task_records.append(t)
            if project_id in _generation_state:
                _generation_state[project_id]["completed"] = completed
                _generation_state[project_id]["failed"] = failed
                _generation_state[project_id]["total"] = total
                _generation_state[project_id]["progress_pct"] = int(completed * 100 / max(total, 1))

            # Sync tasks to PostgreSQL
            if db_job_id and task_records:
                try:
                    await _sync_tasks_to_db(db_job_id, task_records)
                except Exception as db_err:
                    logger.debug("db_task_sync_failed", error=str(db_err))
        except Exception:
            pass

    # Start a background progress updater
    async def _progress_loop():
        while project_id in _generation_state and _generation_state[project_id].get("phase") == "generation":
            await _update_progress()
            await asyncio.sleep(5)

    progress_task = asyncio.create_task(_progress_loop())

    try:
        results = await orchestrator.run_all_epics()

        # Summarize results
        total_completed = sum(r.completed_tasks for r in results.values())
        total_failed = sum(r.failed_tasks for r in results.values())
        all_success = all(r.success for r in results.values())

        # Update final state
        if project_id in _generation_state:
            _generation_state[project_id]["phase"] = "complete" if all_success else "failed"
            _generation_state[project_id]["progress_pct"] = 100 if all_success else _generation_state[project_id].get("progress_pct", 0)
            _generation_state[project_id]["completed"] = total_completed
            _generation_state[project_id]["failed"] = total_failed

        # Final DB sync
        await _update_progress()

        # Update Job status in DB
        if db_job_id:
            try:
                from src.models.base import get_session_factory
                from src.models.job import Job, JobStatus
                from src.models.project import Project, ProjectStatus
                session_factory = get_session_factory()
                async with session_factory() as session:
                    job = await session.get(Job, db_job_id)
                    if job:
                        job.status = JobStatus.COMPLETED if all_success else JobStatus.FAILED
                        job.tasks_completed = total_completed
                        job.tasks_failed = total_failed
                        job.total_tasks = total_completed + total_failed
                    if db_project_id:
                        project = await session.get(Project, db_project_id)
                        if project:
                            project.status = ProjectStatus.COMPLETED if all_success else ProjectStatus.FAILED
                    await session.commit()
                logger.info("db_job_finalized", job_id=db_job_id, success=all_success)
            except Exception as db_err:
                logger.warning("db_job_finalize_failed", error=str(db_err))

        if _event_bus:
            await _event_bus.publish(Event(
                type=EventType.GENERATION_COMPLETE if all_success else EventType.BUILD_FAILED,
                source="epic_orchestrator",
                data={
                    "project_path": project_path,
                    "epic_count": len(results),
                    "all_success": all_success,
                    "completed_tasks": total_completed,
                    "failed_tasks": total_failed,
                }
            ))

        logger.info(
            "all_epics_completed",
            project_path=project_path,
            epic_count=len(results),
            all_success=all_success,
            completed=total_completed,
            failed=total_failed,
        )

    except Exception as e:
        logger.error("all_epics_background_failed", project_path=project_path, error=str(e))

        if project_id in _generation_state:
            _generation_state[project_id]["phase"] = "failed"
            _generation_state[project_id]["error"] = str(e)

        # Mark Job as failed in DB
        if db_job_id:
            try:
                from src.models.base import get_session_factory
                from src.models.job import Job, JobStatus
                session_factory = get_session_factory()
                async with session_factory() as session:
                    job = await session.get(Job, db_job_id)
                    if job:
                        job.status = JobStatus.FAILED
                        job.error_log = str(e)
                    await session.commit()
            except Exception:
                pass

        if _event_bus:
            await _event_bus.publish(Event(
                type=EventType.BUILD_FAILED,
                source="epic_orchestrator",
                data={"project_path": project_path, "error": str(e)}
            ))
    finally:
        progress_task.cancel()


async def _sync_tasks_to_db(job_id: int, task_records: list):
    """Sync task records from JSON files to PostgreSQL tasks table."""
    from src.models.base import get_session_factory
    from src.models.task import Task, TaskStatus, TaskType
    from sqlalchemy import select
    import json as _json

    status_map = {
        "pending": TaskStatus.PENDING,
        "running": TaskStatus.RUNNING,
        "completed": TaskStatus.COMPLETED,
        "failed": TaskStatus.FAILED,
        "blocked": TaskStatus.BLOCKED,
        "cancelled": TaskStatus.CANCELLED,
    }

    session_factory = get_session_factory()
    async with session_factory() as session:
        for t in task_records:
            # Task files use "id" field, model uses "task_id"
            tid = t.get("id", t.get("task_id", ""))
            if not tid:
                continue

            # Check if task exists
            result = await session.execute(
                select(Task).where(Task.job_id == job_id, Task.task_id == str(tid))
            )
            existing = result.scalar_one_or_none()

            task_status = status_map.get(t.get("status", "pending"), TaskStatus.PENDING)

            if existing:
                existing.status = task_status
                existing.status_message = t.get("error_message", t.get("error", t.get("status_message")))
                if t.get("result"):
                    existing.agent_response = _json.dumps(t["result"]) if isinstance(t["result"], dict) else str(t["result"])
            else:
                # prompt MUST not be null
                prompt = t.get("command") or t.get("description") or t.get("title") or str(tid)
                new_task = Task(
                    job_id=job_id,
                    task_id=str(tid),
                    requirement_ids=t.get("related_requirements", []),
                    title=t.get("title", t.get("description", str(tid))),
                    description=t.get("description", ""),
                    prompt=prompt,
                    depends_on=t.get("dependencies", t.get("depends_on", [])),
                    status=task_status,
                    status_message=t.get("error_message"),
                    retry_count=t.get("retry_count", 0),
                    max_retries=t.get("max_retries", 3),
                )
                session.add(new_task)

        await session.commit()


@router.get("/db/projects")
async def get_db_projects():
    """Get all projects from PostgreSQL."""
    try:
        from src.models.base import get_session_factory
        from src.models.project import Project
        from sqlalchemy import select
        session_factory = get_session_factory()
        async with session_factory() as session:
            result = await session.execute(select(Project).order_by(Project.updated_at.desc()))
            projects = result.scalars().all()
            return [
                {
                    "id": p.id,
                    "name": p.name,
                    "description": p.description,
                    "status": p.status.value if p.status else "unknown",
                    "created_at": p.created_at.isoformat() if p.created_at else None,
                    "updated_at": p.updated_at.isoformat() if p.updated_at else None,
                }
                for p in projects
            ]
    except Exception as e:
        logger.error("db_projects_fetch_failed", error=str(e))
        return []


@router.get("/db/projects/{project_id}/tasks")
async def get_db_tasks(project_id: int):
    """Get all tasks for a project from PostgreSQL (via latest job)."""
    try:
        from src.models.base import get_session_factory
        from src.models.job import Job
        from src.models.task import Task
        from sqlalchemy import select
        session_factory = get_session_factory()
        async with session_factory() as session:
            # Get latest job for project
            result = await session.execute(
                select(Job).where(Job.project_id == project_id).order_by(Job.created_at.desc()).limit(1)
            )
            job = result.scalar_one_or_none()
            if not job:
                return {"tasks": [], "job": None}

            # Get tasks for job
            result = await session.execute(
                select(Task).where(Task.job_id == job.id).order_by(Task.id)
            )
            tasks = result.scalars().all()
            return {
                "job": {
                    "id": job.id,
                    "status": job.status.value if job.status else "unknown",
                    "tasks_completed": job.tasks_completed,
                    "tasks_failed": job.tasks_failed,
                    "total_tasks": job.total_tasks,
                    "progress_pct": job.progress_percent,
                },
                "tasks": [
                    {
                        "id": t.id,
                        "task_id": t.task_id,
                        "title": t.title,
                        "description": t.description,
                        "status": t.status.value if t.status else "pending",
                        "status_message": t.status_message,
                        "task_type": t.task_type.value if t.task_type else "general",
                        "depends_on": t.depends_on or [],
                        "retry_count": t.retry_count,
                        "execution_time_ms": t.execution_time_ms,
                        "tokens_used": t.tokens_used,
                        "cost_usd": t.cost_usd,
                        "created_at": t.created_at.isoformat() if t.created_at else None,
                        "updated_at": t.updated_at.isoformat() if t.updated_at else None,
                    }
                    for t in tasks
                ],
            }
    except Exception as e:
        logger.error("db_tasks_fetch_failed", error=str(e))
        return {"tasks": [], "job": None, "error": str(e)}


@router.post("/generate-task-lists", response_model=SuccessResponse)
async def generate_all_task_lists(request: GenerateTaskListsRequest):
    """
    Generate task lists for all epics in a project.

    This parses all epics and creates task JSON files for each.
    """
    try:
        import sys
        engine_root = Path(__file__).parent.parent.parent.parent
        sys.path.insert(0, str(engine_root / "mcp_plugins" / "servers" / "grpc_host"))

        from epic_parser import EpicParser
        from epic_task_generator import EpicTaskGenerator

        # Save epics summary
        parser = EpicParser(request.project_path)
        parser.save_epics_json()

        # Generate and save tasks for all epics
        generator = EpicTaskGenerator(request.project_path)
        saved_files = generator.save_all_epic_tasks()

        logger.info(
            "task_lists_generated",
            project_path=request.project_path,
            files_created=len(saved_files)
        )

        return SuccessResponse(success=True)

    except Exception as e:
        logger.error("task_lists_generation_failed", project_path=request.project_path, error=str(e))
        return SuccessResponse(success=False, error=str(e))


# ─── Project MCP Config Endpoints ────────────────────────────────────


class MCPConfigUpdateRequest(BaseModel):
    """Request to update project MCP config."""
    project_path: str
    updates: dict  # Partial update dict


@router.get("/project/mcp-config")
async def get_project_mcp_config(project_path: str = Query(...)):
    """
    Get the MCP server config for a project.

    Returns the .mcp-config.json content showing which MCP servers
    are configured and their project-specific overrides.
    """
    try:
        from src.mcp.project_config import load_project_mcp_config, generate_project_mcp_config, save_project_mcp_config

        config = load_project_mcp_config(project_path)
        if not config:
            # Generate default config if none exists
            project_id = Path(project_path).name
            output_dir = str(Path(project_path) / "output")
            config = generate_project_mcp_config(
                project_id=project_id,
                project_path=project_path,
                output_dir=output_dir,
            )
            save_project_mcp_config(config)

        return config.to_dict()

    except Exception as e:
        logger.error("get_mcp_config_failed", project_path=project_path, error=str(e))
        raise HTTPException(status_code=500, detail=str(e))


@router.put("/project/mcp-config")
async def update_project_mcp_config(request: MCPConfigUpdateRequest):
    """
    Update MCP server config for a project.

    Supports partial updates:
    {
        "project_path": "/data/projects/my-app",
        "updates": {
            "servers": {
                "postgres": {"env_vars": {"DATABASE_URL": "postgresql://..."}}
            }
        }
    }
    """
    try:
        from src.mcp.project_config import update_project_mcp_config as _update, load_project_mcp_config

        config = _update(request.project_path, request.updates)
        if not config:
            raise HTTPException(status_code=404, detail="No MCP config found for project")

        return config.to_dict()

    except HTTPException:
        raise
    except Exception as e:
        logger.error("update_mcp_config_failed", project_path=request.project_path, error=str(e))
        raise HTTPException(status_code=500, detail=str(e))


# ============================================================
# Task Verification + Kill/Restart Control Endpoints
# ============================================================

@router.post("/kill")
async def kill_verification():
    """Stop all running verification loops. Called by Minibook."""
    try:
        from src.tools.task_verifier import request_kill
        request_kill()
        return {"success": True, "message": "Kill signal sent"}
    except Exception as e:
        return {"success": False, "error": str(e)}


@router.post("/restart")
async def restart_verification():
    """Reset kill signal and prepare for next project. Called by Minibook."""
    try:
        from src.tools.task_verifier import reset_kill
        reset_kill()
        return {"success": True, "message": "Ready for next project"}
    except Exception as e:
        return {"success": False, "error": str(e)}


@router.get("/verification-status")
async def verification_status():
    """Get current task verification progress."""
    try:
        from src.tools.task_verifier import is_killed
        return {
            "kill_active": is_killed(),
            "status": "stopped" if is_killed() else "running",
        }
    except Exception as e:
        return {"kill_active": False, "status": "unknown", "error": str(e)}


class VerifyTaskRequest(BaseModel):
    task_id: str
    task_name: str = ""
    preview_url: str = "http://localhost:3100"
    component: str = ""
    requirements: str = ""


@router.post("/verify-task")
async def verify_single_task(request: VerifyTaskRequest):
    """Manually trigger verification for a single task."""
    try:
        from src.tools.task_verifier import TaskVerifier
        verifier = TaskVerifier(preview_url=request.preview_url)
        result = await verifier.verify_task(
            task_id=request.task_id,
            task_name=request.task_name or request.task_id,
            component=request.component,
            requirements=request.requirements,
        )
        return {
            "task_id": result.task_id,
            "status": result.status.value,
            "errors": result.errors,
            "attempts": result.attempts,
            "fix_applied": result.fix_applied,
        }
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
