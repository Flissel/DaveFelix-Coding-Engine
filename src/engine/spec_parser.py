"""Structured Spec Parser — Prio 1 of Pipeline Improvements.

Replaces DocumentationLoader. Parses service specification artifacts
(api docs, architecture, data dictionary, user stories, state machines)
into machine-readable dataclasses.

Spec: docs/superpowers/specs/2026-03-16-pipeline-improvements-design.md
"""
from __future__ import annotations

import json
import re
import logging
from dataclasses import dataclass, field
from pathlib import Path
from typing import Any

import yaml

logger = logging.getLogger(__name__)


# ---------------------------------------------------------------------------
# Data Models
# ---------------------------------------------------------------------------

@dataclass
class Field:
    name: str
    type: str
    nullable: bool = False
    unique: bool = False
    default: str | None = None


@dataclass
class Relation:
    target: str
    type: str           # one-to-one, one-to-many, many-to-many
    field: str           # FK field name
    inverse: str | None = None


@dataclass
class StateTransition:
    from_state: str
    to_state: str
    trigger: str
    guard: str | None = None


@dataclass
class StateMachine:
    name: str
    entity: str
    states: list[str]
    initial_state: str
    terminal_states: list[str]
    transitions: list[StateTransition]


@dataclass
class ParsedEndpoint:
    method: str
    path: str
    service: str
    request_dto: str = ""
    response_dto: str = ""
    auth_required: bool = True
    linked_stories: list[str] = field(default_factory=list)
    status_codes: dict[int, str] = field(default_factory=dict)


@dataclass
class ParsedEntity:
    name: str
    fields: list[Field]
    relations: list[Relation]
    service: str


@dataclass
class ParsedUserStory:
    id: str
    epic: str
    title: str
    acceptance_criteria: list[str]
    linked_requirements: list[str] = field(default_factory=list)
    linked_endpoints: list[str] = field(default_factory=list)


@dataclass
class ParsedService:
    name: str
    port: int
    technology: str
    dependencies: list[str]            # infra deps (postgres, redis)
    service_dependencies: list[str]    # other API services
    endpoints: list[ParsedEndpoint]
    entities: list[ParsedEntity]
    stories: list[ParsedUserStory]
    state_machines: list[StateMachine]


@dataclass
class ParsedSpec:
    services: dict[str, ParsedService]
    shared_entities: list[ParsedEntity]
    dependency_graph: dict[str, list[str]]
    generation_order: list[str]
    openapi_version: str = "3.0.3"


# ---------------------------------------------------------------------------
# Parser
# ---------------------------------------------------------------------------

class SpecParser:
    """Parses service specification directory into ParsedSpec."""

    def __init__(self, project_dir: str | Path):
        self.project_dir = Path(project_dir)
        if not self.project_dir.exists():
            raise FileNotFoundError(f"Project directory not found: {self.project_dir}")

    def _parse_architecture(self) -> dict[str, ParsedService]:
        """Parse architecture/architecture.md into ParsedService dict."""
        arch_file = self.project_dir / "architecture" / "architecture.md"
        if not arch_file.exists():
            logger.warning("architecture.md not found at %s", arch_file)
            return {}

        text = arch_file.read_text(encoding="utf-8")
        services: dict[str, ParsedService] = {}
        # Split by ### headers (service definitions)
        service_blocks = re.split(r"^### ", text, flags=re.MULTILINE)

        for block in service_blocks[1:]:  # skip preamble
            lines = block.strip().split("\n")
            service_name = lines[0].strip()
            # Extract table rows: | Property | Value |
            props: dict[str, str] = {}
            for line in lines:
                m = re.match(r"\|\s*(\w[\w\s]*?)\s*\|\s*\*{0,2}(.*?)\*{0,2}\s*\|", line)
                if m and m.group(1).strip().lower() not in ("property", "---"):
                    props[m.group(1).strip().lower()] = m.group(2).strip()

            port_str = props.get("ports", "0")
            port = int(re.search(r"\d+", port_str).group()) if re.search(r"\d+", port_str) else 0
            tech = props.get("technology", "unknown")

            deps_str = props.get("dependencies", "")
            all_deps = [d.strip() for d in deps_str.split(",") if d.strip()]

            # Separate infra deps from service deps
            infra_prefixes = ("postgres", "redis", "kafka", "s3", "kong", "websocket")
            infra_deps = [d for d in all_deps if any(d.startswith(p) for p in infra_prefixes)]
            service_deps = [d for d in all_deps if d not in infra_deps]

            services[service_name] = ParsedService(
                name=service_name,
                port=port,
                technology=tech,
                dependencies=infra_deps,
                service_dependencies=service_deps,
                endpoints=[],
                entities=[],
                stories=[],
                state_machines=[],
            )

        return services

    def _parse_data_dictionary(self) -> list[ParsedEntity]:
        """Parse data/data_dictionary.md into ParsedEntity list."""
        dd_file = self.project_dir / "data" / "data_dictionary.md"
        if not dd_file.exists():
            logger.warning("data_dictionary.md not found")
            return []

        text = dd_file.read_text(encoding="utf-8")
        entities: list[ParsedEntity] = []
        entity_blocks = re.split(r"^### ", text, flags=re.MULTILINE)

        for block in entity_blocks[1:]:
            lines = block.strip().split("\n")
            entity_name = lines[0].strip()
            if not entity_name or entity_name.startswith("|") or entity_name.startswith("#"):
                continue

            fields: list[Field] = []
            relations: list[Relation] = []

            for line in lines:
                cols = [c.strip() for c in line.split("|")]
                if len(cols) < 9:
                    continue
                attr, ftype, _maxlen, required, fk_target, _indexed, _enum_vals, _desc = cols[1:9]
                if attr.lower() in ("attribute", "---", ""):
                    continue
                if "---" in ftype:
                    continue

                type_map = {
                    "uuid": "uuid", "string": "string", "text": "text",
                    "integer": "int", "int": "int", "boolean": "boolean",
                    "datetime": "datetime", "decimal": "decimal", "enum": "enum",
                    "json": "json", "float": "float",
                }
                mapped_type = type_map.get(ftype.lower().strip(), ftype.lower().strip())

                fields.append(Field(
                    name=attr.strip(),
                    type=mapped_type,
                    nullable=required.strip().lower() != "yes",
                    unique=False,
                    default=None,
                ))

                if fk_target.strip() not in ("-", "", "—"):
                    parts = fk_target.strip().split(".")
                    if len(parts) == 2:
                        relations.append(Relation(
                            target=parts[0],
                            type="many-to-one",
                            field=attr.strip(),
                            inverse=None,
                        ))

            if fields:
                entities.append(ParsedEntity(
                    name=entity_name,
                    fields=fields,
                    relations=relations,
                    service="",
                ))

        return entities
