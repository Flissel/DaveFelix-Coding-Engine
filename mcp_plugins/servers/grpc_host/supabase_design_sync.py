"""
Supabase design + verification sync for the coding-engine.

Writes DESIGN artifacts (requirements / architecture / contracts / api docs) and
VERIFICATION signals (build / test pass-fail) to the **vibemind supabase** via
postgrest REST, so the brain's `truth:` validators can verify "design persisted"
and "build passed" the same way as the bubble caps (independent re-query).

This is ADDITIVE and write-only — it sits alongside DBTaskSync (which syncs task
*status* to the coding-engine's own Postgres). It never throws: a down supabase
just means the row isn't written and a warning is logged, exactly like DBTaskSync.

Tables: design_artifacts, verification_results
        (supabase/migrations/20260627_coding_design_verification.sql).

Env:
  VIBEMIND_SUPABASE_URL  | SUPABASE_URL   default http://127.0.0.1:54321
  SUPABASE_SERVICE_ROLE_KEY | SUPABASE_SERVICE_KEY | SUPABASE_ANON_KEY  (first set wins)
  CODING_SUPABASE_SYNC   set "0" to disable (default: on when a key is present)

Usage in epic_orchestrator.py:
    from supabase_design_sync import SupabaseDesignSync
    sds = SupabaseDesignSync()
    sds.record_design_artifact(project_ref, "architecture", "Epic-001 contracts", md)
    sds.record_verification(project_ref, "build", passed=True, exit_code=0, command="npm run build")
"""

import json
import logging
import os
import urllib.error
import urllib.request

logger = logging.getLogger("supabase_design_sync")

_DEFAULT_URL = "http://127.0.0.1:54321"


class SupabaseDesignSync:
    """Writes coding-engine design + verification rows to the vibemind supabase."""

    def __init__(self, url: str = "", key: str = ""):
        self.url = (
            url
            or os.environ.get("VIBEMIND_SUPABASE_URL")
            or os.environ.get("SUPABASE_URL")
            or _DEFAULT_URL
        ).rstrip("/")
        # service_role bypasses RLS; anon also works against the allow_all policy.
        self.key = (
            key
            or os.environ.get("SUPABASE_SERVICE_ROLE_KEY")
            or os.environ.get("SUPABASE_SERVICE_KEY")
            or os.environ.get("SUPABASE_ANON_KEY")
            or ""
        )
        self.enabled = os.environ.get("CODING_SUPABASE_SYNC", "1") != "0" and bool(self.key)
        if not self.enabled:
            logger.info(
                "Supabase design sync disabled (no key, or CODING_SUPABASE_SYNC=0)"
            )

    # -- transport ---------------------------------------------------------
    def _post(self, table: str, row: dict) -> bool:
        if not self.enabled:
            return False
        # drop None values so postgrest uses column defaults
        payload = {k: v for k, v in row.items() if v is not None}
        try:
            req = urllib.request.Request(
                "%s/rest/v1/%s" % (self.url, table),
                data=json.dumps(payload).encode(),
                headers={
                    "Content-Type": "application/json",
                    "apikey": self.key,
                    "Authorization": "Bearer %s" % self.key,
                    "Prefer": "return=minimal",
                },
                method="POST",
            )
            with urllib.request.urlopen(req, timeout=8) as resp:
                ok = 200 <= resp.status < 300
                if not ok:
                    logger.warning("supabase %s insert HTTP %s", table, resp.status)
                return ok
        except urllib.error.HTTPError as e:
            body = e.read().decode("utf-8", "replace")[:300] if e.fp else ""
            logger.warning("supabase %s insert HTTP %s: %s", table, e.code, body)
            return False
        except Exception as e:  # down supabase, DNS, timeout — non-fatal
            logger.warning("supabase %s insert failed: %s", table, e)
            return False

    # -- design artifacts --------------------------------------------------
    def record_design_artifact(
        self,
        project_ref: str,
        artifact_type: str,
        title: str,
        content: str,
        *,
        fmt: str = "markdown",
        epic_id: str = None,
        source_file: str = None,
        project_id: str = None,
        metadata: dict = None,
    ) -> bool:
        """Persist one design doc (requirements/architecture/contracts/api_doc/...)."""
        return self._post(
            "design_artifacts",
            {
                "project_ref": project_ref,
                "project_id": project_id,
                "epic_id": epic_id,
                "artifact_type": artifact_type,
                "title": title,
                "content": (content or "")[:100000],
                "format": fmt,
                "source_file": source_file,
                "metadata": metadata or {},
            },
        )

    # -- verification signals ---------------------------------------------
    def record_verification(
        self,
        project_ref: str,
        verification_type: str,
        passed: bool,
        *,
        task_id: str = None,
        epic_id: str = None,
        exit_code: int = None,
        command: str = None,
        stdout: str = "",
        stderr: str = "",
        duration_ms: int = None,
        project_id: str = None,
    ) -> bool:
        """Persist a build/test verdict — the ground-truth 'build passed' signal."""
        return self._post(
            "verification_results",
            {
                "project_ref": project_ref,
                "project_id": project_id,
                "task_id": task_id,
                "epic_id": epic_id,
                "verification_type": verification_type,
                "passed": bool(passed),
                "exit_code": exit_code,
                "command": command,
                "stdout_tail": (stdout or "")[-4000:],
                "stderr_tail": (stderr or "")[-4000:],
                "duration_ms": duration_ms,
            },
        )


if __name__ == "__main__":
    # Standalone smoke test (no infra needed): construct + verify graceful no-key path.
    logging.basicConfig(level=logging.INFO)
    s = SupabaseDesignSync(url="http://127.0.0.1:54321", key="")
    assert s.enabled is False, "should be disabled without a key"
    assert s.record_design_artifact("proj-x", "architecture", "t", "c") is False
    assert s.record_verification("proj-x", "build", True) is False
    print("OK: SupabaseDesignSync imports + no-key path graceful (disabled, no throw)")
