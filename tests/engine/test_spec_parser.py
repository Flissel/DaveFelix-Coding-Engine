# tests/engine/test_spec_parser.py
import pytest
from pathlib import Path
from src.engine.spec_parser import (
    Field, Relation, StateTransition, StateMachine,
    ParsedEndpoint, ParsedEntity, ParsedUserStory,
    ParsedService, ParsedSpec,
)


class TestDataModels:
    def test_field_defaults(self):
        f = Field(name="id", type="uuid")
        assert f.nullable is False
        assert f.unique is False
        assert f.default is None

    def test_relation_creation(self):
        r = Relation(target="Message", type="one-to-many", field="userId", inverse="messages")
        assert r.target == "Message"

    def test_state_machine_has_transitions(self):
        t = StateTransition(from_state="draft", to_state="sending", trigger="send", guard="content_valid")
        sm = StateMachine(
            name="Message", entity="Message",
            states=["draft", "sending", "sent"],
            initial_state="draft", terminal_states=["deleted"],
            transitions=[t],
        )
        assert len(sm.transitions) == 1
        assert sm.initial_state == "draft"

    def test_parsed_spec_generation_order(self):
        spec = ParsedSpec(
            services={}, shared_entities=[],
            dependency_graph={}, generation_order=["auth-service"],
            openapi_version="3.0.3",
        )
        assert spec.generation_order == ["auth-service"]


from src.engine.spec_parser import SpecParser


class TestArchitectureParser:
    WHATSAPP_DIR = Path("Data/all_services/whatsapp-messaging-service_20260211_025459")

    def test_parse_services_from_architecture(self):
        parser = SpecParser(self.WHATSAPP_DIR)
        services = parser._parse_architecture()
        assert "auth-service" in services
        assert "messaging-service" in services
        auth = services["auth-service"]
        assert auth.port == 3001
        assert "NestJS" in auth.technology
        assert "postgres-auth" in auth.dependencies

    def test_parse_service_dependencies(self):
        parser = SpecParser(self.WHATSAPP_DIR)
        services = parser._parse_architecture()
        msg = services["messaging-service"]
        assert any("websocket" in d for d in msg.dependencies) or any("websocket" in d for d in msg.service_dependencies)

    def test_total_services_count(self):
        parser = SpecParser(self.WHATSAPP_DIR)
        services = parser._parse_architecture()
        api_services = {k: v for k, v in services.items() if v.port > 0}
        assert len(api_services) >= 7


class TestDataDictionaryParser:
    WHATSAPP_DIR = Path("Data/all_services/whatsapp-messaging-service_20260211_025459")

    def test_parse_entities(self):
        parser = SpecParser(self.WHATSAPP_DIR)
        entities = parser._parse_data_dictionary()
        assert len(entities) >= 40
        names = [e.name for e in entities]
        assert "User" in names or "user" in [n.lower() for n in names]

    def test_entity_has_fields(self):
        parser = SpecParser(self.WHATSAPP_DIR)
        entities = parser._parse_data_dictionary()
        for entity in entities:
            if entity.name.lower() == "user" or "user" in entity.name.lower():
                assert len(entity.fields) > 0
                field_names = [f.name for f in entity.fields]
                assert any("id" in fn.lower() for fn in field_names)
                break

    def test_entity_relations(self):
        parser = SpecParser(self.WHATSAPP_DIR)
        entities = parser._parse_data_dictionary()
        has_relations = [e for e in entities if len(e.relations) > 0]
        assert len(has_relations) > 0
