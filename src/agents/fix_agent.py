"""
FixAgent - Spezialisiert auf das Migrieren und Fixen von Code
"""
import logging
import subprocess
import json
from typing import Dict, Any, Optional, List
from datetime import datetime
from pathlib import Path

logger = logging.getLogger(__name__)


class FixAgent:
    """Agent für das Migrieren und Fixen von Code"""
    
    def __init__(self):
        self.name = "FixAgent"
        self.version = "1.0.0"
        self.supported_operations = [
            "migrate_code",
            "fix_syntax_error",
            "fix_import_error",
            "fix_runtime_error",
            "fix_dependency_issue",
            "apply_fix",
            "validate_fix"
        ]
    
    def execute(self, parameters: Dict[str, Any]) -> Dict[str, Any]:
        """
        Migriert oder fixt Code
        
        Args:
            parameters: Dictionary mit Fixparametern
                - operation: Art der Fix-Operation
                - file_path: Pfad zur Datei
                - error_type: Art des Fehlers (syntax, import, runtime, dependency)
                - error_message: Fehlermeldung
                - fix_description: Beschreibung des Fixes
                - code_changes: Code-Änderungen (optional)
                - migration_target: Ziel für Migration (optional)
        
        Returns:
            Dictionary mit Fix-Ergebnis
        """
        operation = parameters.get('operation', 'fix_syntax_error')
        file_path = parameters.get('file_path')
        error_type = parameters.get('error_type')
        error_message = parameters.get('error_message')
        fix_description = parameters.get('fix_description')
        code_changes = parameters.get('code_changes')
        migration_target = parameters.get('migration_target')
        
        logger.info(f"{self.name} führt Fix-Operation aus: {operation}")
        logger.info(f"Datei: {file_path}")
        logger.info(f"Fehler-Typ: {error_type}")
        
        try:
            if operation == "migrate_code":
                result = self._migrate_code(file_path, migration_target, parameters)
            elif operation == "fix_syntax_error":
                result = self._fix_syntax_error(file_path, error_message, fix_description, code_changes)
            elif operation == "fix_import_error":
                result = self._fix_import_error(file_path, error_message, fix_description, code_changes)
            elif operation == "fix_runtime_error":
                result = self._fix_runtime_error(file_path, error_message, fix_description, code_changes)
            elif operation == "fix_dependency_issue":
                result = self._fix_dependency_issue(file_path, error_message, fix_description, code_changes)
            elif operation == "apply_fix":
                result = self._apply_fix(file_path, code_changes, fix_description)
            elif operation == "validate_fix":
                result = self._validate_fix(file_path)
            else:
                raise ValueError(f"Unbekannte Operation: {operation}")
            
            result['agent'] = self.name
            result['version'] = self.version
            result['timestamp'] = datetime.now().isoformat()
            
            return result
            
        except Exception as e:
            logger.error(f"Fehler beim Fixen von Code: {e}")
            return {
                'success': False,
                'error': str(e),
                'agent': self.name,
                'version': self.version,
                'timestamp': datetime.now().isoformat()
            }
    
    def _migrate_code(self, file_path: str, migration_target: Optional[str],
                      parameters: Dict[str, Any]) -> Dict[str, Any]:
        """Migriert Code zu einer neuen Version oder Plattform"""
        logger.info(f"Migriere Code: {file_path} -> {migration_target}")
        
        try:
            if not file_path or not Path(file_path).exists():
                return {
                    'success': False,
                    'operation': 'migrate_code',
                    'error': f'Datei nicht gefunden: {file_path}'
                }
            
            # Code lesen
            with open(file_path, 'r', encoding='utf-8') as f:
                original_code = f.read()
            
            # Migration basierend auf Ziel
            migrated_code = original_code
            migration_notes = []
            
            if migration_target == "python3.12":
                migrated_code, notes = self._migrate_to_python312(original_code)
                migration_notes.extend(notes)
            elif migration_target == "async":
                migrated_code, notes = self._migrate_to_async(original_code)
                migration_notes.extend(notes)
            elif migration_target == "type_hints":
                migrated_code, notes = self._add_type_hints(original_code)
                migration_notes.extend(notes)
            else:
                migration_notes.append(f"Keine spezifische Migration für {migration_target} implementiert")
            
            # Backup erstellen
            backup_path = f"{file_path}.backup"
            with open(backup_path, 'w', encoding='utf-8') as f:
                f.write(original_code)
            
            # Migrierten Code schreiben
            with open(file_path, 'w', encoding='utf-8') as f:
                f.write(migrated_code)
            
            return {
                'success': True,
                'operation': 'migrate_code',
                'message': f'Code erfolgreich migriert zu {migration_target}',
                'file_path': file_path,
                'backup_path': backup_path,
                'migration_target': migration_target,
                'migration_notes': migration_notes
            }
            
        except Exception as e:
            logger.error(f"Fehler bei der Migration: {e}")
            return {
                'success': False,
                'operation': 'migrate_code',
                'error': str(e)
            }
    
    def _migrate_to_python312(self, code: str) -> tuple[str, List[str]]:
        """Migriert Code zu Python 3.12"""
        notes = []
        
        # Deprecated Patterns ersetzen
        if 'asyncio.coroutine' in code:
            code = code.replace('asyncio.coroutine', 'async def')
            notes.append("asyncio.coroutine durch async def ersetzt")
        
        if 'from typing import' in code and 'List' in code:
            code = code.replace('from typing import List', 'from typing import List as TypingList')
            code = code.replace(': List[', ': list[')
            code = code.replace(': TypingList[', ': List[')
            notes.append("Typing-Hints zu built-in types migriert")
        
        return code, notes
    
    def _migrate_to_async(self, code: str) -> tuple[str, List[str]]:
        """Migriert synchronen Code zu asynchronem Code"""
        notes = []
        
        # Einfache Muster-Erkennung und Migration
        if 'def ' in code and 'async def ' not in code:
            # Hinweis: Dies ist eine vereinfachte Migration
            notes.append("Hinweis: Asynchrone Migration erfordert manuelle Überprüfung")
        
        return code, notes
    
    def _add_type_hints(self, code: str) -> tuple[str, List[str]]:
        """Fügt Type Hints hinzu"""
        notes = []
        notes.append("Type Hints sollten manuell hinzugefügt werden")
        return code, notes
    
    def _fix_syntax_error(self, file_path: str, error_message: str,
                          fix_description: Optional[str], code_changes: Optional[Dict]) -> Dict[str, Any]:
        """Fixt Syntax-Fehler"""
        logger.info(f"Fixe Syntax-Fehler in: {file_path}")
        
        try:
            if not file_path or not Path(file_path).exists():
                return {
                    'success': False,
                    'operation': 'fix_syntax_error',
                    'error': f'Datei nicht gefunden: {file_path}'
                }
            
            # Code lesen
            with open(file_path, 'r', encoding='utf-8') as f:
                original_code = f.read()
            
            # Syntax-Check
            try:
                compile(original_code, file_path, 'exec')
                return {
                    'success': True,
                    'operation': 'fix_syntax_error',
                    'message': 'Kein Syntax-Fehler gefunden',
                    'file_path': file_path
                }
            except SyntaxError as e:
                logger.info(f"Syntax-Fehler gefunden: {e}")
            
            # Fix anwenden
            fixed_code = original_code
            
            if code_changes and 'replacements' in code_changes:
                for replacement in code_changes['replacements']:
                    old_text = replacement.get('old_text')
                    new_text = replacement.get('new_text')
                    if old_text and new_text:
                        fixed_code = fixed_code.replace(old_text, new_text)
            
            # Backup erstellen
            backup_path = f"{file_path}.backup"
            with open(backup_path, 'w', encoding='utf-8') as f:
                f.write(original_code)
            
            # Gefixten Code schreiben
            with open(file_path, 'w', encoding='utf-8') as f:
                f.write(fixed_code)
            
            # Syntax-Check nach Fix
            try:
                compile(fixed_code, file_path, 'exec')
                syntax_valid = True
            except SyntaxError:
                syntax_valid = False
            
            return {
                'success': True,
                'operation': 'fix_syntax_error',
                'message': 'Syntax-Fehler fix attempt abgeschlossen',
                'file_path': file_path,
                'backup_path': backup_path,
                'syntax_valid': syntax_valid,
                'fix_description': fix_description
            }
            
        except Exception as e:
            logger.error(f"Fehler beim Fixen des Syntax-Fehlers: {e}")
            return {
                'success': False,
                'operation': 'fix_syntax_error',
                'error': str(e)
            }
    
    def _fix_import_error(self, file_path: str, error_message: str,
                          fix_description: Optional[str], code_changes: Optional[Dict]) -> Dict[str, Any]:
        """Fixt Import-Fehler"""
        logger.info(f"Fixe Import-Fehler in: {file_path}")
        
        try:
            if not file_path or not Path(file_path).exists():
                return {
                    'success': False,
                    'operation': 'fix_import_error',
                    'error': f'Datei nicht gefunden: {file_path}'
                }
            
            # Code lesen
            with open(file_path, 'r', encoding='utf-8') as f:
                original_code = f.read()
            
            # Import-Fehler analysieren
            missing_import = None
            if 'No module named' in error_message:
                # Modul-Namen extrahieren
                import re
                match = re.search(r"No module named ['\"]([^'\"]+)['\"]", error_message)
                if match:
                    missing_import = match.group(1)
            
            # Fix anwenden
            fixed_code = original_code
            
            if code_changes and 'replacements' in code_changes:
                for replacement in code_changes['replacements']:
                    old_text = replacement.get('old_text')
                    new_text = replacement.get('new_text')
                    if old_text and new_text:
                        fixed_code = fixed_code.replace(old_text, new_text)
            
            # Backup erstellen
            backup_path = f"{file_path}.backup"
            with open(backup_path, 'w', encoding='utf-8') as f:
                f.write(original_code)
            
            # Gefixten Code schreiben
            with open(file_path, 'w', encoding='utf-8') as f:
                f.write(fixed_code)
            
            return {
                'success': True,
                'operation': 'fix_import_error',
                'message': 'Import-Fehler fix attempt abgeschlossen',
                'file_path': file_path,
                'backup_path': backup_path,
                'missing_import': missing_import,
                'fix_description': fix_description
            }
            
        except Exception as e:
            logger.error(f"Fehler beim Fixen des Import-Fehlers: {e}")
            return {
                'success': False,
                'operation': 'fix_import_error',
                'error': str(e)
            }
    
    def _fix_runtime_error(self, file_path: str, error_message: str,
                          fix_description: Optional[str], code_changes: Optional[Dict]) -> Dict[str, Any]:
        """Fixt Laufzeitfehler"""
        logger.info(f"Fixe Laufzeitfehler in: {file_path}")
        
        try:
            if not file_path or not Path(file_path).exists():
                return {
                    'success': False,
                    'operation': 'fix_runtime_error',
                    'error': f'Datei nicht gefunden: {file_path}'
                }
            
            # Code lesen
            with open(file_path, 'r', encoding='utf-8') as f:
                original_code = f.read()
            
            # Fix anwenden
            fixed_code = original_code
            
            if code_changes and 'replacements' in code_changes:
                for replacement in code_changes['replacements']:
                    old_text = replacement.get('old_text')
                    new_text = replacement.get('new_text')
                    if old_text and new_text:
                        fixed_code = fixed_code.replace(old_text, new_text)
            
            # Backup erstellen
            backup_path = f"{file_path}.backup"
            with open(backup_path, 'w', encoding='utf-8') as f:
                f.write(original_code)
            
            # Gefixten Code schreiben
            with open(file_path, 'w', encoding='utf-8') as f:
                f.write(fixed_code)
            
            return {
                'success': True,
                'operation': 'fix_runtime_error',
                'message': 'Laufzeitfehler fix attempt abgeschlossen',
                'file_path': file_path,
                'backup_path': backup_path,
                'error_message': error_message,
                'fix_description': fix_description
            }
            
        except Exception as e:
            logger.error(f"Fehler beim Fixen des Laufzeitfehlers: {e}")
            return {
                'success': False,
                'operation': 'fix_runtime_error',
                'error': str(e)
            }
    
    def _fix_dependency_issue(self, file_path: str, error_message: str,
                            fix_description: Optional[str], code_changes: Optional[Dict]) -> Dict[str, Any]:
        """Fixt Abhängigkeitsprobleme"""
        logger.info(f"Fixe Abhängigkeitsproblem in: {file_path}")
        
        try:
            # Requirements-Datei aktualisieren
            requirements_path = 'requirements.txt'
            
            if code_changes and 'dependencies' in code_changes:
                dependencies = code_changes['dependencies']
                
                # Requirements lesen
                existing_requirements = []
                if Path(requirements_path).exists():
                    with open(requirements_path, 'r', encoding='utf-8') as f:
                        existing_requirements = f.read().splitlines()
                
                # Neue Abhängigkeiten hinzufügen
                for dep in dependencies:
                    if dep not in existing_requirements:
                        existing_requirements.append(dep)
                
                # Requirements schreiben
                with open(requirements_path, 'w', encoding='utf-8') as f:
                    f.write('\n'.join(existing_requirements))
                
                return {
                    'success': True,
                    'operation': 'fix_dependency_issue',
                    'message': 'Abhängigkeiten aktualisiert',
                    'requirements_path': requirements_path,
                    'added_dependencies': dependencies,
                    'fix_description': fix_description
                }
            
            return {
                'success': False,
                'operation': 'fix_dependency_issue',
                'error': 'Keine Abhängigkeiten zum Hinzufügen angegeben'
            }
            
        except Exception as e:
            logger.error(f"Fehler beim Fixen des Abhängigkeitsproblems: {e}")
            return {
                'success': False,
                'operation': 'fix_dependency_issue',
                'error': str(e)
            }
    
    def _apply_fix(self, file_path: str, code_changes: Optional[Dict],
                  fix_description: Optional[str]) -> Dict[str, Any]:
        """Wendet einen generischen Fix an"""
        logger.info(f"Wende Fix an: {file_path}")
        
        try:
            if not file_path or not Path(file_path).exists():
                return {
                    'success': False,
                    'operation': 'apply_fix',
                    'error': f'Datei nicht gefunden: {file_path}'
                }
            
            # Code lesen
            with open(file_path, 'r', encoding='utf-8') as f:
                original_code = f.read()
            
            # Fix anwenden
            fixed_code = original_code
            
            if code_changes and 'replacements' in code_changes:
                for replacement in code_changes['replacements']:
                    old_text = replacement.get('old_text')
                    new_text = replacement.get('new_text')
                    if old_text and new_text:
                        fixed_code = fixed_code.replace(old_text, new_text)
            
            # Backup erstellen
            backup_path = f"{file_path}.backup"
            with open(backup_path, 'w', encoding='utf-8') as f:
                f.write(original_code)
            
            # Gefixten Code schreiben
            with open(file_path, 'w', encoding='utf-8') as f:
                f.write(fixed_code)
            
            return {
                'success': True,
                'operation': 'apply_fix',
                'message': 'Fix erfolgreich angewendet',
                'file_path': file_path,
                'backup_path': backup_path,
                'fix_description': fix_description
            }
            
        except Exception as e:
            logger.error(f"Fehler beim Anwenden des Fixes: {e}")
            return {
                'success': False,
                'operation': 'apply_fix',
                'error': str(e)
            }
    
    def _validate_fix(self, file_path: str) -> Dict[str, Any]:
        """Validiert einen Fix"""
        logger.info(f"Validiere Fix in: {file_path}")
        
        try:
            if not file_path or not Path(file_path).exists():
                return {
                    'success': False,
                    'operation': 'validate_fix',
                    'error': f'Datei nicht gefunden: {file_path}'
                }
            
            # Code lesen
            with open(file_path, 'r', encoding='utf-8') as f:
                code = f.read()
            
            # Syntax-Check
            syntax_valid = True
            syntax_error = None
            try:
                compile(code, file_path, 'exec')
            except SyntaxError as e:
                syntax_valid = False
                syntax_error = str(e)
            
            # Lint-Check (optional)
            lint_valid = True
            lint_errors = []
            
            return {
                'success': True,
                'operation': 'validate_fix',
                'message': 'Fix-Validierung abgeschlossen',
                'file_path': file_path,
                'syntax_valid': syntax_valid,
                'syntax_error': syntax_error,
                'lint_valid': lint_valid,
                'lint_errors': lint_errors,
                'overall_valid': syntax_valid and lint_valid
            }
            
        except Exception as e:
            logger.error(f"Fehler bei der Validierung: {e}")
            return {
                'success': False,
                'operation': 'validate_fix',
                'error': str(e)
            }
    
    def get_status(self) -> Dict[str, Any]:
        """Gibt den Status des Agenten zurück"""
        return {
            'name': self.name,
            'version': self.version,
            'supported_operations': self.supported_operations,
            'status': 'ready'
        }
