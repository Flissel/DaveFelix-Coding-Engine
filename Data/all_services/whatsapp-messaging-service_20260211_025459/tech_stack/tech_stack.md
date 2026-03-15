# Technology Stack - whatsapp-messaging-service

## Overview

| Category | Technology |
|----------|------------|
| Architecture | Microservices |
| Deployment | Cloud-native |

---

## Frontend

| Component | Technology |
|-----------|------------|
| Framework | **React Native 0.74.1** |
| Languages | TypeScript 5.5.4, JavaScript ES2023 |
| UI Library | React Native Paper 5.12.3 |
| State Management | Redux Toolkit 2.2.6 |

**Rationale:** React Native bietet Mobile-First Entwicklung fuer iOS/Android mit gemeinsamer Codebasis, gutem WebSocket-Support und starker Community, passend fuer Echtzeit-Messaging und Offline-Queue.

---

## Backend

| Component | Technology |
|-----------|------------|
| Language | **Node.js 20.15.1** |
| Framework | **NestJS 10.3.2** |
| API Style | REST + WebSocket |

**Rationale:** NestJS liefert modulare Architektur, integrierte WebSocket-Gateways und gute Skalierbarkeit fuer Microservices, ideal fuer E2E-verschluesselte Messaging-Workloads.

---

## Data Layer

| Component | Technology |
|-----------|------------|
| Primary Database | **PostgreSQL 16.3** |
| Cache | Redis 7.2.5 |
| Search Engine | none |

**Rationale:** PostgreSQL bietet starke Konsistenz, ACID-Transaktionen, JSONB fuer flexible Payloads und ist bewaehrt fuer User/Message-Daten in DSGVO-konformen Systemen.

---

## Infrastructure

| Component | Technology |
|-----------|------------|
| Cloud Provider | **AWS** |
| Container Runtime | Docker 26.1.4 |
| Orchestration | Kubernetes 1.30.3 |
| CI/CD | GitHub Actions |

---

## Integration

| Component | Technology |
|-----------|------------|
| Message Queue | Kafka 3.7.1 |
| API Gateway | Kong 3.7.1 |

---

## Alternatives Considered

### Frontend Framework
- Flutter 3.22.2
- Kotlin Multiplatform 2.0.20

### Backend Framework
- Spring Boot 3.3.2
- Go Fiber 2.52.5

---

## Pinned Versions

| Technology | Version | Package Name |
|------------|---------|--------------|
| Docker | `26.1.4` | `` |
| Kafka | `3.7.1` | `` |
| Kong | `3.7.1` | `` |
| Kubernetes | `1.30.3` | `` |
| NestJS | `10.3.2` | `@nestjs/core` |
| Node.js | `20.15.1` | `` |
| PostgreSQL | `16.3` | `` |
| React | `18.3.1` | `react` |
| React Native | `0.74.1` | `react-native` |
| React Native Paper | `5.12.3` | `react-native-paper` |
| Redis | `7.2.5` | `` |
| Redux Toolkit | `2.2.6` | `@reduxjs/toolkit` |
| TypeScript | `5.5.4` | `typescript` |

---

## Architecture Diagram

See `architecture_diagram.mmd` for the C4 Context diagram.
