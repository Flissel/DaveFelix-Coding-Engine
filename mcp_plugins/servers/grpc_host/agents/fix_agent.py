"""
FixAgent - Spezialisiert auf Code-Fixes und Migrationen
"""

import asyncio
import json
import logging
from typing import Dict, List, Optional, Any
from datetime import datetime

from .base_agent import BaseAgent
from .grpc_client import GrpcClient
from .proto.agent_service_pb2 import (
    TaskRequest, TaskResponse, TaskStatus, 
    TaskType, TaskPriority, AgentCapability
)

logger = logging.getLogger(__name__)


class FixAgent(BaseAgent):
    """
    Agent für Code-Fixes und Migrationen.
    """
    
    def __init__(self, agent_id: str, grpc_client: GrpcClient):
        super().__init__(agent_id, "FixAgent", grpc_client)
        self.capabilities = [
            AgentCapability.CODE_FIXING,
            AgentCapability.MIGRATION,
            AgentCapability.REFACTORING,
            AgentCapability.DEBUGGING
        ]
    
    async def fix_bug_task(
        self,
        file_path: str,
        bug_description: str,
        fix_strategy: str = "automated",
        priority: TaskPriority = TaskPriority.HIGH,
        dependencies: Optional[List[str]] = None
    ) -> str:
        """
        Erstellt einen Task zum Fixen eines Bugs.
        
        Args:
            file_path: Pfad zur Datei mit dem Bug
            bug_description: Beschreibung des Bugs
            fix_strategy: Strategie für den Fix (automated, manual, hybrid)
            priority: Priorität des Tasks
            dependencies: Liste von abhängigen Task-IDs
            
        Returns:
            Task-ID
        """
        task_data = {
            "file_path": file_path,
            "bug_description": bug_description,
            "fix_strategy": fix_strategy,
            "operation": "fix_bug"
        }
        
        task_request = TaskRequest(
            task_type=TaskType.CODE_FIX,
            priority=priority,
            description=f"Bug-Fix: {file_path}",
            task_data=json.dumps(task_data),
            dependencies=dependencies or [],
            created_by=self.agent_id
        )
        
        response = await self.grpc_client.submit_task(task_request)
        logger.info(f"Bug-Fix Task erstellt: {response.task_id}")
        return response.task_id
    
    async def migrate_code_task(
        self,
        source_path: str,
        target_version: str,
        migration_type: str = "version_upgrade",
        priority: TaskPriority = TaskPriority.HIGH,
        dependencies: Optional[List[str]] = None
    ) -> str:
        """
        Erstellt einen Task für Code-Migration.
        
        Args:
            source_path: Pfad zum zu migrierenden Code
            target_version: Zielversion
            migration_type: Art der Migration (version_upgrade, framework_change, language_migration)
            priority: Priorität des Tasks
            dependencies: Liste von abhängigen Task-IDs
            
        Returns:
            Task-ID
        """
        task_data = {
            "source_path": source_path,
            "target_version": target_version,
            "migration_type": migration_type,
            "operation": "migrate_code"
        }
        
        task_request = TaskRequest(
            task_type=TaskType.MIGRATION,
            priority=priority,
            description=f"Migration: {source_path} -> {target_version}",
            task_data=json.dumps(task_data),
            dependencies=dependencies or [],
            created_by=self.agent_id
        )
        
        response = await self.grpc_client.submit_task(task_request)
        logger.info(f"Migration Task erstellt: {response.task_id}")
        return response.task_id
    
    async def refactor_code_task(
        self,
        file_path: str,
        refactor_type: str,
        refactor_description: str,
        priority: TaskPriority = TaskPriority.MEDIUM,
        dependencies: Optional[List[str]] = None
    ) -> str:
        """
        Erstellt einen Task für Code-Refactoring.
        
        Args:
            file_path: Pfad zur Datei
            refactor_type: Art des Refactorings (performance, readability, maintainability)
            refactor_description: Beschreibung des Refactorings
            priority: Priorität des Tasks
            dependencies: Liste von abhängigen Task-IDs
            
        Returns:
            Task-ID
        """
        task_data = {
            "file_path": file_path,
            "refactor_type": refactor_type,
            "refactor_description": refactor_description,
            "operation": "refactor_code"
        }
        
        task_request = TaskRequest(
            task_type=TaskType.CODE_FIX,
            priority=priority,
            description=f"Refactoring: {file_path}",
            task_data=json.dumps(task_data),
            dependencies=dependencies or [],
            created_by=self.agent_id
        )
        
        response = await self.grpc_client.submit_task(task_request)
        logger.info(f"Refactoring Task erstellt: {response.task_id}")
        return response.task_id
    
    async def apply_hotfix_task(
        self,
        file_path: str,
        hotfix_description: str,
        rollback_plan: str,
        priority: TaskPriority = TaskPriority.CRITICAL,
        dependencies: Optional[List[str]] = None
    ) -> str:
        """
        Erstellt einen Task für Hotfix-Anwendung.
        
        Args:
            file_path: Pfad zur Datei
            hotfix_description: Beschreibung des Hotfixes
            rollback_plan: Rollback-Plan
            priority: Priorität des Tasks
            dependencies: Liste von abhängigen Task-IDs
            
        Returns:
            Task-ID
        """
        task_data = {
            "file_path": file_path,
            "hotfix_description": hotfix_description,
            "rollback_plan": rollback_plan,
            "operation": "apply_hotfix"
        }
        
        task_request = TaskRequest(
            task_type=TaskType.CODE_FIX,
            priority=priority,
            description=f"Hotfix: {file_path}",
            task_data=json.dumps(task_data),
            dependencies=dependencies or [],
            created_by=self.agent_id
        )
        
        response = await self.grpc_client.submit_task(task_request)
        logger.info(f"Hotfix Task erstellt: {response.task_id}")
        return response.task_id
    
    async def dependency_update_task(
        self,
        project_path: str,
        dependency_name: str,
        target_version: str,
        priority: TaskPriority = TaskPriority.MEDIUM,
        dependencies: Optional[List[str]] = None
    ) -> str:
        """
        Erstellt einen Task für Dependency-Update.
        
        Args:
            project_path: Pfad zum Projekt
            dependency_name: Name der Dependency
            target_version: Zielversion
            priority: Priorität des Tasks
            dependencies: Liste von abhängigen Task-IDs
            
        Returns:
            Task-ID
        """
        task_data = {
            "project_path": project_path,
            "dependency_name": dependency_name,
            "target_version": target_version,
            "operation": "dependency_update"
        }
        
        task_request = TaskRequest(
            task_type=TaskType.MIGRATION,
            priority=priority,
            description=f"Dependency-Update: {dependency_name} -> {target_version}",
            task_data=json.dumps(task_data),
            dependencies=dependencies or [],
            created_by=self.agent_id
        )
        
        response = await self.grpc_client.submit_task(task_request)
        logger.info(f"Dependency-Update Task erstellt: {response.task_id}")
        return response.task_id
    
    async def security_patch_task(
        self,
        file_path: str,
        vulnerability_description: str,
        patch_strategy: str,
        priority: TaskPriority = TaskPriority.CRITICAL,
        dependencies: Optional[List[str]] = None
    ) -> str:
        """
        Erstellt einen Task für Security-Patch.
        
        Args:
            file_path: Pfad zur Datei
            vulnerability_description: Beschreibung der Vulnerability
            patch_strategy: Strategie für den Patch
            priority: Priorität des Tasks
            dependencies: Liste von abhängigen Task-IDs
            
        Returns:
            Task-ID
        """
        task_data = {
            "file_path": file_path,
            "vulnerability_description": vulnerability_description,
            "patch_strategy": patch_strategy,
            "operation": "security_patch"
        }
        
        task_request = TaskRequest(
            task_type=TaskType.CODE_FIX,
            priority=priority,
            description=f"Security-Patch: {file_path}",
            task_data=json.dumps(task_data),
            dependencies=dependencies or [],
            created_by=self.agent_id
        )
        
        response = await self.grpc_client.submit_task(task_request)
        logger.info(f"Security-Patch Task erstellt: {response.task_id}")
        return response.task_id
    
    async def process_event(self, event: Dict[str, Any]) -> List[str]:
        """
        Verarbeitet ein Event und erstellt entsprechende Tasks.
        
        Args:
            event: Event-Daten
            
        Returns:
            Liste der erstellten Task-IDs
        """
        event_type = event.get("type", "unknown")
        task_ids = []
        
        try:
            if event_type == "bug_fix_request":
                task_id = await self.fix_bug_task(
                    file_path=event["file_path"],
                    bug_description=event["bug_description"],
                    fix_strategy=event.get("fix_strategy", "automated"),
                    priority=self._parse_priority(event.get("priority", "high"))
                )
                task_ids.append(task_id)
            
            elif event_type == "migration_request":
                task_id = await self.migrate_code_task(
                    source_path=event["source_path"],
                    target_version=event["target_version"],
                    migration_type=event.get("migration_type", "version_upgrade"),
                    priority=self._parse_priority(event.get("priority", "high"))
                )
                task_ids.append(task_id)
            
            elif event_type == "refactoring_request":
                task_id = await self.refactor_code_task(
                    file_path=event["file_path"],
                    refactor_type=event["refactor_type"],
                    refactor_description=event["refactor_description"],
                    priority=self._parse_priority(event.get("priority", "medium"))
                )
                task_ids.append(task_id)
            
            elif event_type == "hotfix_request":
                task_id = await self.apply_hotfix_task(
                    file_path=event["file_path"],
                    hotfix_description=event["hotfix_description"],
                    rollback_plan=event["rollback_plan"],
                    priority=self._parse_priority(event.get("priority", "critical"))
                )
                task_ids.append(task_id)
            
            elif event_type == "dependency_update_request":
                task_id = await self.dependency_update_task(
                    project_path=event["project_path"],
                    dependency_name=event["dependency_name"],
                    target_version=event["target_version"],
                    priority=self._parse_priority(event.get("priority", "medium"))
                )
                task_ids.append(task_id)
            
            elif event_type == "security_patch_request":
                task_id = await self.security_patch_task(
                    file_path=event["file_path"],
                    vulnerability_description=event["vulnerability_description"],
                    patch_strategy=event["patch_strategy"],
                    priority=self._parse_priority(event.get("priority", "critical"))
                )
                task_ids.append(task_id)
            
            else:
                logger.warning(f"Unbekannter Event-Typ: {event_type}")
        
        except Exception as e:
            logger.error(f"Fehler bei der Event-Verarbeitung: {e}")
            raise
        
        return task_ids
    
    def _parse_priority(self, priority_str: str) -> TaskPriority:
        """Parst Prioritäts-String zu Enum."""
        priority_map = {
            "low": TaskPriority.LOW,
            "medium": TaskPriority.MEDIUM,
            "high": TaskPriority.HIGH,
            "critical": TaskPriority.CRITICAL
        }
        return priority_map.get(priority_str.lower(), TaskPriority.MEDIUM)
