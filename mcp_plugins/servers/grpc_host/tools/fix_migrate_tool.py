"""
Fix Migrate Tool für EventFixTeam
Bietet Funktionen zum Migrieren und Fixen von Code
"""

import os
import json
import logging
import subprocess
from pathlib import Path
from typing import Dict, Any, Optional, List
from datetime import datetime

logger = logging.getLogger(__name__)


class FixMigrateTool:
    """Tool für Fix- und Migrate-Operationen"""
    
    def __init__(self, base_dir: str = "."):
        """
        Fix Migrate Tool initialisieren
        
        Args:
            base_dir: Basisverzeichnis für das Projekt
        """
        self.base_dir = Path(base_dir)
        self.fix_migrate_dir = self.base_dir / "fix_migrate"
        self.fix_migrate_dir.mkdir(exist_ok=True)
        self.fixes_dir = self.fix_migrate_dir / "fixes"
        self.fixes_dir.mkdir(exist_ok=True)
        self.migrations_dir = self.fix_migrate_dir / "migrations"
        self.migrations_dir.mkdir(exist_ok=True)
        
        logger.info(f"Fix Migrate Tool initialisiert mit Basisverzeichnis: {base_dir}")
    
    def analyze_code(self, file_path: str) -> Dict[str, Any]:
        """
        Code analysieren
        
        Args:
            file_path: Pfad zur Datei (relativ zum Basisverzeichnis)
        
        Returns:
            Dict mit success, output, logs, error
        """
        try:
            # Vollständigen Pfad erstellen
            full_path = self.base_dir / file_path
            
            # Datei lesen
            with open(full_path, 'r', encoding='utf-8') as f:
                content = f.read()
            
            # Analyse durchführen
            analysis = {
                "file_path": file_path,
                "line_count": len(content.splitlines()),
                "char_count": len(content),
                "language": self._detect_language(file_path),
                "potential_issues": self._detect_issues(content),
                "suggestions": self._generate_suggestions(content)
            }
            
            # Log speichern
            logs = self._save_log("analyze_code", file_path, json.dumps(analysis, indent=2), "")
            
            logger.info(f"Code analysiert: {full_path}")
            return {
                "success": True,
                "output": analysis,
                "file_path": str(full_path),
                "logs": logs
            }
        except Exception as e:
            logger.error(f"Fehler beim Analysieren des Codes: {e}")
            return {
                "success": False,
                "error": str(e),
                "logs": ""
            }
    
    def fix_code(self, file_path: str, fixes: List[Dict[str, str]], 
                 backup: bool = True) -> Dict[str, Any]:
        """
        Code fixen
        
        Args:
            file_path: Pfad zur Datei (relativ zum Basisverzeichnis)
            fixes: Liste von Fixes mit old_string und new_string
            backup: Backup erstellen (default: True)
        
        Returns:
            Dict mit success, output, logs, error
        """
        try:
            # Vollständigen Pfad erstellen
            full_path = self.base_dir / file_path
            
            # Backup erstellen
            if backup:
                backup_path = self._create_backup(full_path)
            
            # Datei lesen
            with open(full_path, 'r', encoding='utf-8') as f:
                content = f.read()
            
            # Fixes anwenden
            for fix in fixes:
                old_string = fix.get("old_string", "")
                new_string = fix.get("new_string", "")
                if old_string:
                    content = content.replace(old_string, new_string)
            
            # Datei schreiben
            with open(full_path, 'w', encoding='utf-8') as f:
                f.write(content)
            
            # Fix-Daten speichern
            fix_data = {
                "file_path": file_path,
                "fixes": fixes,
                "backup_path": str(backup_path) if backup else None,
                "timestamp": datetime.now().isoformat()
            }
            
            fix_id = f"fix_{datetime.now().strftime('%Y%m%d_%H%M%S')}"
            fix_file = self.fixes_dir / f"{fix_id}.json"
            with open(fix_file, 'w', encoding='utf-8') as f:
                json.dump(fix_data, f, indent=2, ensure_ascii=False)
            
            # Log speichern
            logs = self._save_log("fix_code", file_path, json.dumps(fix_data, indent=2), "")
            
            logger.info(f"Code gefixt: {full_path}")
            return {
                "success": True,
                "output": f"Code gefixt: {full_path}",
                "file_path": str(full_path),
                "fix_id": fix_id,
                "backup_path": str(backup_path) if backup else None,
                "logs": logs
            }
        except Exception as e:
            logger.error(f"Fehler beim Fixen des Codes: {e}")
            return {
                "success": False,
                "error": str(e),
                "logs": ""
            }
    
    def migrate_code(self, file_path: str, migration_type: str, 
                     target_version: str) -> Dict[str, Any]:
        """
        Code migrieren
        
        Args:
            file_path: Pfad zur Datei (relativ zum Basisverzeichnis)
            migration_type: Typ der Migration (e.g., "python_3_to_4", "react_17_to_18")
            target_version: Zielversion
        
        Returns:
            Dict mit success, output, logs, error
        """
        try:
            # Vollständigen Pfad erstellen
            full_path = self.base_dir / file_path
            
            # Backup erstellen
            backup_path = self._create_backup(full_path)
            
            # Datei lesen
            with open(full_path, 'r', encoding='utf-8') as f:
                content = f.read()
            
            # Migration durchführen
            migrated_content = self._apply_migration(content, migration_type, target_version)
            
            # Datei schreiben
            with open(full_path, 'w', encoding='utf-8') as f:
                f.write(migrated_content)
            
            # Migrations-Daten speichern
            migration_data = {
                "file_path": file_path,
                "migration_type": migration_type,
                "target_version": target_version,
                "backup_path": str(backup_path),
                "timestamp": datetime.now().isoformat()
            }
            
            migration_id = f"migration_{datetime.now().strftime('%Y%m%d_%H%M%S')}"
            migration_file = self.migrations_dir / f"{migration_id}.json"
            with open(migration_file, 'w', encoding='utf-8') as f:
                json.dump(migration_data, f, indent=2, ensure_ascii=False)
            
            # Log speichern
            logs = self._save_log("migrate_code", file_path, json.dumps(migration_data, indent=2), "")
            
            logger.info(f"Code migriert: {full_path}")
            return {
                "success": True,
                "output": f"Code migriert: {full_path}",
                "file_path": str(full_path),
                "migration_id": migration_id,
                "backup_path": str(backup_path),
                "logs": logs
            }
        except Exception as e:
            logger.error(f"Fehler beim Migrieren des Codes: {e}")
            return {
                "success": False,
                "error": str(e),
                "logs": ""
            }
    
    def run_linter(self, file_path: str, linter: str = "auto") -> Dict[str, Any]:
        """
        Linter ausführen
        
        Args:
            file_path: Pfad zur Datei (relativ zum Basisverzeichnis)
            linter: Linter-Typ (auto, pylint, flake8, eslint, etc.)
        
        Returns:
            Dict mit success, output, logs, error
        """
        try:
            # Vollständigen Pfad erstellen
            full_path = self.base_dir / file_path
            
            # Linter automatisch erkennen
            if linter == "auto":
                linter = self._detect_linter(file_path)
            
            # Linter ausführen
            result = subprocess.run(
                [linter, str(full_path)],
                capture_output=True,
                text=True,
                timeout=30
            )
            
            # Log speichern
            logs = self._save_log("run_linter", file_path, result.stdout, result.stderr)
            
            logger.info(f"Linter ausgeführt: {linter} auf {full_path}")
            return {
                "success": True,
                "output": result.stdout,
                "error": result.stderr,
                "return_code": result.returncode,
                "linter": linter,
                "file_path": str(full_path),
                "logs": logs
            }
        except Exception as e:
            logger.error(f"Fehler beim Ausführen des Linters: {e}")
            return {
                "success": False,
                "error": str(e),
                "logs": ""
            }
    
    def run_formatter(self, file_path: str, formatter: str = "auto") -> Dict[str, Any]:
        """
        Formatter ausführen
        
        Args:
            file_path: Pfad zur Datei (relativ zum Basisverzeichnis)
            formatter: Formatter-Typ (auto, black, autopep8, prettier, etc.)
        
        Returns:
            Dict mit success, output, logs, error
        """
        try:
            # Vollständigen Pfad erstellen
            full_path = self.base_dir / file_path
            
            # Formatter automatisch erkennen
            if formatter == "auto":
                formatter = self._detect_formatter(file_path)
            
            # Formatter ausführen
            result = subprocess.run(
                [formatter, str(full_path)],
                capture_output=True,
                text=True,
                timeout=30
            )
            
            # Log speichern
            logs = self._save_log("run_formatter", file_path, result.stdout, result.stderr)
            
            logger.info(f"Formatter ausgeführt: {formatter} auf {full_path}")
            return {
                "success": True,
                "output": result.stdout,
                "error": result.stderr,
                "return_code": result.returncode,
                "formatter": formatter,
                "file_path": str(full_path),
                "logs": logs
            }
        except Exception as e:
            logger.error(f"Fehler beim Ausführen des Formatters: {e}")
            return {
                "success": False,
                "error": str(e),
                "logs": ""
            }
    
    def create_fix_task(self, task_name: str, description: str, files: List[str], 
                        fixes: List[Dict[str, str]], priority: str = "medium") -> Dict[str, Any]:
        """
        Fix-Task erstellen
        
        Args:
            task_name: Name des Tasks
            description: Beschreibung des Tasks
            files: Liste von Dateien
            fixes: Liste von Fixes
            priority: Priorität (low, medium, high)
        
        Returns:
            Dict mit success, output, logs, error
        """
        try:
            # Task-Daten erstellen
            task_data = {
                "task_name": task_name,
                "description": description,
                "files": files,
                "fixes": fixes,
                "priority": priority,
                "status": "pending",
                "created_at": datetime.now().isoformat()
            }
            
            # Task-ID generieren
            task_id = f"fix_{task_name}_{datetime.now().strftime('%Y%m%d_%H%M%S')}"
            
            # Task speichern
            task_file = self.fixes_dir / f"{task_id}.json"
            with open(task_file, 'w', encoding='utf-8') as f:
                json.dump(task_data, f, indent=2, ensure_ascii=False)
            
            logger.info(f"Fix-Task erstellt: {task_id}")
            return {
                "success": True,
                "output": f"Fix-Task erstellt: {task_id}",
                "task_id": task_id,
                "task_data": task_data,
                "logs": ""
            }
        except Exception as e:
            logger.error(f"Fehler beim Erstellen des Fix-Tasks: {e}")
            return {
                "success": False,
                "error": str(e),
                "logs": ""
            }
    
    def get_fix(self, fix_id: str) -> Dict[str, Any]:
        """
        Fix abrufen
        
        Args:
            fix_id: ID des Fixes
        
        Returns:
            Dict mit success, output, logs, error
        """
        try:
            # Fix-Datei finden
            fix_file = self.fixes_dir / f"{fix_id}.json"
            
            # Fix lesen
            with open(fix_file, 'r', encoding='utf-8') as f:
                fix_data = json.load(f)
            
            logger.info(f"Fix abgerufen: {fix_id}")
            return {
                "success": True,
                "output": fix_data,
                "fix_id": fix_id,
                "logs": ""
            }
        except Exception as e:
            logger.error(f"Fehler beim Abrufen des Fixes: {e}")
            return {
                "success": False,
                "error": str(e),
                "logs": ""
            }
    
    def list_fixes(self, status: str = None) -> Dict[str, Any]:
        """
        Fixes auflisten
        
        Args:
            status: Status filtern (pending, in_progress, completed)
        
        Returns:
            Dict mit success, output, logs, error
        """
        try:
            fixes = []
            
            # Alle Fix-Dateien auflisten
            for fix_file in self.fixes_dir.glob("*.json"):
                with open(fix_file, 'r', encoding='utf-8') as f:
                    fix_data = json.load(f)
                
                # Filter nach Status
                if status is None or fix_data.get("status") == status:
                    fixes.append(fix_data)
            
            logger.info(f"Fixes aufgelistet: {len(fixes)}")
            return {
                "success": True,
                "output": fixes,
                "count": len(fixes),
                "logs": ""
            }
        except Exception as e:
            logger.error(f"Fehler beim Auflisten der Fixes: {e}")
            return {
                "success": False,
                "error": str(e),
                "logs": ""
            }
    
    def _create_backup(self, file_path: Path) -> Path:
        """
        Backup erstellen
        
        Args:
            file_path: Pfad zur Datei
        
        Returns:
            Pfad zum Backup
        """
        timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
        backup_path = file_path.parent / f"{file_path.stem}.backup_{timestamp}{file_path.suffix}"
        
        # Backup erstellen
        import shutil
        shutil.copy2(file_path, backup_path)
        
        return backup_path
    
    def _detect_language(self, file_path: str) -> str:
        """
        Programmiersprache erkennen
        
        Args:
            file_path: Pfad zur Datei
        
        Returns:
            Programmiersprache
        """
        extension = Path(file_path).suffix.lower()
        
        language_map = {
            ".py": "python",
            ".js": "javascript",
            ".ts": "typescript",
            ".java": "java",
            ".cpp": "cpp",
            ".c": "c",
            ".go": "go",
            ".rs": "rust",
            ".rb": "ruby",
            ".php": "php",
            ".swift": "swift",
            ".kt": "kotlin",
            ".cs": "csharp",
            ".html": "html",
            ".css": "css",
            ".scss": "scss",
            ".json": "json",
            ".xml": "xml",
            ".yaml": "yaml",
            ".yml": "yaml"
        }
        
        return language_map.get(extension, "unknown")
    
    def _detect_linter(self, file_path: str) -> str:
        """
        Linter automatisch erkennen
        
        Args:
            file_path: Pfad zur Datei
        
        Returns:
            Linter-Befehl
        """
        language = self._detect_language(file_path)
        
        linter_map = {
            "python": "pylint",
            "javascript": "eslint",
            "typescript": "eslint",
            "java": "checkstyle",
            "go": "golint",
            "rust": "clippy"
        }
        
        return linter_map.get(language, "echo")
    
    def _detect_formatter(self, file_path: str) -> str:
        """
        Formatter automatisch erkennen
        
        Args:
            file_path: Pfad zur Datei
        
        Returns:
            Formatter-Befehl
        """
        language = self._detect_language(file_path)
        
        formatter_map = {
            "python": "black",
            "javascript": "prettier",
            "typescript": "prettier",
            "java": "google-java-format",
            "go": "gofmt",
            "rust": "rustfmt"
        }
        
        return formatter_map.get(language, "echo")
    
    def _detect_issues(self, content: str) -> List[str]:
        """
        Potentielle Probleme erkennen
        
        Args:
            content: Inhalt der Datei
        
        Returns:
            Liste von Problemen
        """
        issues = []
        
        # Einfache Heuristiken
        if "TODO" in content:
            issues.append("TODO-Kommentare gefunden")
        if "FIXME" in content:
            issues.append("FIXME-Kommentare gefunden")
        if "XXX" in content:
            issues.append("XXX-Kommentare gefunden")
        if "print(" in content and "def " in content:
            issues.append("Debug print-Anweisungen gefunden")
        
        return issues
    
    def _generate_suggestions(self, content: str) -> List[str]:
        """
        Vorschläge generieren
        
        Args:
            content: Inhalt der Datei
        
        Returns:
            Liste von Vorschlägen
        """
        suggestions = []
        
        # Einfache Heuristiken
        if len(content.splitlines()) > 500:
            suggestions.append("Datei ist sehr lang, erwägen Sie eine Aufteilung")
        if content.count("class ") > 10:
            suggestions.append("Viele Klassen in einer Datei, erwägen Sie eine Aufteilung")
        if content.count("def ") > 50:
            suggestions.append("Viele Funktionen in einer Datei, erwägen Sie eine Aufteilung")
        
        return suggestions
    
    def _apply_migration(self, content: str, migration_type: str, 
                        target_version: str) -> str:
        """
        Migration anwenden
        
        Args:
            content: Inhalt der Datei
            migration_type: Typ der Migration
            target_version: Zielversion
        
        Returns:
            Migrierter Inhalt
        """
        # Einfache Migrationen
        if migration_type == "python_3_to_4":
            # Python 3 zu 4 Migration (Beispiel)
            content = content.replace("print(", "print(")  # Keine Änderung
        elif migration_type == "react_17_to_18":
            # React 17 zu 18 Migration (Beispiel)
            content = content.replace("ReactDOM.render(", "ReactDOM.createRoot(")
        
        return content
    
    def _save_log(self, operation: str, file_path: str, output: str, error: str) -> str:
        """
        Log speichern
        
        Args:
            operation: Operation (analyze_code, fix_code, etc.)
            file_path: Pfad zur Datei
            output: Ausgabe
            error: Fehler
        
        Returns:
            Pfad zur Log-Datei
        """
        try:
            timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
            log_file = self.fix_migrate_dir / f"fix_migrate_{operation}_{timestamp}.log"
            
            with open(log_file, 'w', encoding='utf-8') as f:
                f.write(f"Operation: {operation}\n")
                f.write(f"File Path: {file_path}\n")
                f.write(f"Timestamp: {timestamp}\n")
                f.write("=" * 80 + "\n\n")
                f.write("Output:\n")
                f.write(output[:1000])  # Nur erste 1000 Zeichen
                f.write("\n\n")
                f.write("Error:\n")
                f.write(error)
            
            logger.info(f"Fix Migrate Log gespeichert: {log_file}")
            return str(log_file)
        except Exception as e:
            logger.error(f"Fehler beim Speichern des Fix Migrate Logs: {e}")
            return ""
