# Technology Stack - unnamed_project

## Overview

| Category | Technology |
|----------|------------|
| Architecture | Modular Monolith |
| Deployment | Cloud-native |

---

## Frontend

| Component | Technology |
|-----------|------------|
| Framework | **React** |
| Languages | TypeScript, JavaScript |
| UI Library | Material-UI |
| State Management | Redux Toolkit |

**Rationale:** React bietet ein breites Ökosystem, große Community und eignet sich für hochinteraktive Echtzeit-UIs wie Chat-Anwendungen. TypeScript verbessert Wartbarkeit und Team-Produktivität.

---

## Backend

| Component | Technology |
|-----------|------------|
| Language | **Node.js** |
| Framework | **NestJS** |
| API Style | REST |

**Rationale:** NestJS auf Node.js ermöglicht schnelle Entwicklung, starke Strukturierung, WebSocket-Support für Echtzeit-Messaging und passt gut zu TypeScript auf Frontend und Backend.

---

## Data Layer

| Component | Technology |
|-----------|------------|
| Primary Database | **PostgreSQL** |
| Cache | Redis |
| Search Engine | none |

**Rationale:** PostgreSQL bietet starke Konsistenz, relationale Modellierung für Nutzer/Chats/Nachrichten und Skalierbarkeit mit Replikation.

---

## Infrastructure

| Component | Technology |
|-----------|------------|
| Cloud Provider | **AWS** |
| Container Runtime | Docker |
| Orchestration | Kubernetes |
| CI/CD | GitHub Actions |

---

## Integration

| Component | Technology |
|-----------|------------|
| Message Queue | Kafka |
| API Gateway | Kong |

---

## Alternatives Considered

### Frontend Framework
- Vue
- Angular

### Backend Framework
- FastAPI
- Spring Boot

---

## Architecture Diagram

See `architecture_diagram.mmd` for the C4 Context diagram.
