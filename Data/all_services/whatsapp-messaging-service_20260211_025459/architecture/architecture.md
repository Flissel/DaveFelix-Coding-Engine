# Architecture - whatsapp-messaging-service

## Overview

| Property | Value |
|----------|-------|
| Architecture Pattern | **Microservices** |
| Communication Patterns | REST, WebSocket, Event-Driven |
| Total Services | 17 |

---

## Services

### api-gateway

| Property | Value |
|----------|-------|
| Type | gateway |
| Technology | Kong 3.7.1 |
| Ports | 8000, 8001 |

**Responsibilities:**
- Request Routing
- Rate Limiting
- Authentication
- Load Balancing

### auth-service

| Property | Value |
|----------|-------|
| Type | api |
| Technology | NestJS 10.3.2 |
| Ports | 3001 |
| Dependencies | postgres-auth, redis-cache |

**Responsibilities:**
- Phone Number Registration
- 2FA Management
- Biometric Auth
- Multi-Device Support
- Passkey Management

### user-profile-service

| Property | Value |
|----------|-------|
| Type | api |
| Technology | NestJS 10.3.2 |
| Ports | 3002 |
| Dependencies | postgres-profiles, redis-cache, s3-storage |

**Responsibilities:**
- Profile Management
- Profile Picture Upload
- Display Name
- Status Text
- QR Code Generation

### messaging-service

| Property | Value |
|----------|-------|
| Type | api |
| Technology | NestJS 10.3.2 |
| Ports | 3003 |
| Dependencies | postgres-messages, redis-cache, kafka-queue, websocket-service |

**Responsibilities:**
- Text Messages
- Voice Messages
- Message Operations
- Message Forwarding
- Message Reactions

### chat-service

| Property | Value |
|----------|-------|
| Type | api |
| Technology | NestJS 10.3.2 |
| Ports | 3004 |
| Dependencies | postgres-chats, redis-cache, kafka-queue |

**Responsibilities:**
- Chat Management
- Chat Locking
- Disappearing Messages
- View-Once Media

### websocket-service

| Property | Value |
|----------|-------|
| Type | api |
| Technology | NestJS 10.3.2 |
| Ports | 3005 |
| Dependencies | redis-cache, kafka-queue |

**Responsibilities:**
- Real-time Communication
- WebSocket Connections
- Live Message Delivery
- Presence Management

### media-service

| Property | Value |
|----------|-------|
| Type | api |
| Technology | NestJS 10.3.2 |
| Ports | 3006 |
| Dependencies | s3-storage, postgres-media, redis-cache |

**Responsibilities:**
- Media Upload
- Media Processing
- Media Storage
- View-Once Media Management

### notification-worker

| Property | Value |
|----------|-------|
| Type | worker |
| Technology | NestJS 10.3.2 |
| Ports | 3007 |
| Dependencies | kafka-queue, postgres-notifications |

**Responsibilities:**
- Push Notifications
- Email Notifications
- SMS Notifications
- Notification Templates

### postgres-auth

| Property | Value |
|----------|-------|
| Type | database |
| Technology | PostgreSQL 16.3 |
| Ports | 5432 |

**Responsibilities:**
- User Authentication Data
- Device Registration
- 2FA Settings
- Passkey Storage

### postgres-profiles

| Property | Value |
|----------|-------|
| Type | database |
| Technology | PostgreSQL 16.3 |
| Ports | 5433 |

**Responsibilities:**
- User Profiles
- Profile Pictures Metadata
- Display Names
- Status Information

### postgres-messages

| Property | Value |
|----------|-------|
| Type | database |
| Technology | PostgreSQL 16.3 |
| Ports | 5434 |

**Responsibilities:**
- Message Storage
- Message History
- Message Metadata
- Reactions

### postgres-chats

| Property | Value |
|----------|-------|
| Type | database |
| Technology | PostgreSQL 16.3 |
| Ports | 5435 |

**Responsibilities:**
- Chat Metadata
- Chat Settings
- Chat Participants
- Chat Security

### postgres-media

| Property | Value |
|----------|-------|
| Type | database |
| Technology | PostgreSQL 16.3 |
| Ports | 5436 |

**Responsibilities:**
- Media Metadata
- Media References
- Media Access Control

### postgres-notifications

| Property | Value |
|----------|-------|
| Type | database |
| Technology | PostgreSQL 16.3 |
| Ports | 5437 |

**Responsibilities:**
- Notification Queue
- Notification History
- Notification Settings

### redis-cache

| Property | Value |
|----------|-------|
| Type | cache |
| Technology | Redis 7.2.5 |
| Ports | 6379 |

**Responsibilities:**
- Session Storage
- Message Cache
- Profile Cache
- Real-time Data

### kafka-queue

| Property | Value |
|----------|-------|
| Type | queue |
| Technology | Kafka 3.7.1 |
| Ports | 9092 |

**Responsibilities:**
- Message Events
- Notification Events
- User Events
- System Events

### s3-storage

| Property | Value |
|----------|-------|
| Type | api |
| Technology | AWS S3 |
| Ports | 443 |

**Responsibilities:**
- Media Storage
- Profile Pictures
- Voice Messages
- File Attachments

---

## C4 Context Diagram

```mermaid
C4Context
    title System Context - WhatsApp Messaging Service
    Person(user, "User", "Mobile app user")
    Person(contact, "Contact", "Other users")
    System(whatsapp, "WhatsApp Messaging Service", "Real-time messaging platform")
    System_Ext(sms, "SMS Gateway", "Phone verification")
    System_Ext(push, "Push Service", "Mobile notifications")
    System_Ext(biometric, "Biometric Service", "Device authentication")
    
    Rel(user, whatsapp, "Sends messages, manages profile")
    Rel(contact, whatsapp, "Receives messages, interacts")
    Rel(whatsapp, sms, "Sends verification codes")
    Rel(whatsapp, push, "Sends push notifications")
    Rel(whatsapp, biometric, "Validates biometric auth")
```

## C4 Container Diagram

```mermaid
graph TB
    subgraph "Mobile Device"
        A[React Native App]
    end
    
    subgraph "API Layer"
        B[Kong API Gateway]
    end
    
    subgraph "Microservices"
        C[Auth Service]
        D[User Profile Service]
        E[Messaging Service]
        F[Chat Service]
        G[WebSocket Service]
        H[Media Service]
        I[Notification Worker]
    end
    
    subgraph "Data Layer"
        J[(PostgreSQL Auth)]
        K[(PostgreSQL Profiles)]
        L[(PostgreSQL Messages)]
        M[(PostgreSQL Chats)]
        N[(PostgreSQL Media)]
        O[(PostgreSQL Notifications)]
        P[(Redis Cache)]
    end
    
    subgraph "Infrastructure"
        Q[Kafka Queue]
        R[AWS S3 Storage]
    end
    
    A --> B
    B --> C
    B --> D
    B --> E
    B --> F
    B --> G
    B --> H
    C --> J
    C --> P
    D --> K
    D --> P
    D --> R
    E --> L
    E --> P
    E --> Q
    F --> M
    F --> P
    F --> Q
    G --> P
    G --> Q
    H --> N
    H --> R
    H --> P
    I --> O
    I --> Q
```

## Deployment Diagram

```mermaid
graph TB
    subgraph "AWS Cloud"
        subgraph "EKS Cluster"
            subgraph "API Gateway Namespace"
                A[Kong Gateway Pod]
            end
            
            subgraph "Services Namespace"
                B[Auth Service Pods]
                C[Profile Service Pods]
                D[Messaging Service Pods]
                E[Chat Service Pods]
                F[WebSocket Service Pods]
                G[Media Service Pods]
                H[Notification Worker Pods]
            end
            
            subgraph "Data Namespace"
                I[PostgreSQL StatefulSet]
                J[Redis StatefulSet]
                K[Kafka StatefulSet]
            end
        end
        
        subgraph "AWS Services"
            L[S3 Bucket]
            M[Application Load Balancer]
            N[CloudWatch]
            O[Route 53]
        end
        
        subgraph "External"
            P[GitHub Actions]
            Q[Docker Registry]
        end
    end
    
    O --> M
    M --> A
    A --> B
    A --> C
    A --> D
    A --> E
    A --> F
    A --> G
    B --> I
    C --> I
    D --> I
    E --> I
    F --> J
    G --> L
    H --> K
    P --> Q
    Q --> EKS
```

## Data Flow Diagram

```mermaid
flowchart LR
    A[Mobile Client] -->|HTTPS/WSS| B[API Gateway]
    B -->|Route Auth| C[Auth Service]
    B -->|Route Profile| D[Profile Service]
    B -->|Route Messages| E[Messaging Service]
    B -->|Route Chat| F[Chat Service]
    B -->|WebSocket| G[WebSocket Service]
    B -->|Route Media| H[Media Service]
    
    C -->|Store Auth| I[(Auth DB)]
    C -->|Cache Session| J[(Redis)]
    
    D -->|Store Profile| K[(Profile DB)]
    D -->|Upload Media| L[S3 Storage]
    D -->|Cache Profile| J
    
    E -->|Store Messages| M[(Message DB)]
    E -->|Publish Event| N[Kafka]
    E -->|Cache Messages| J
    E -->|Real-time| G
    
    F -->|Store Chat Data| O[(Chat DB)]
    F -->|Publish Event| N
    F -->|Cache Chat| J
    
    G -->|Cache Connections| J
    G -->|Subscribe Events| N
    G -->|Push to Client| A
    
    H -->|Store Media Meta| P[(Media DB)]
    H -->|Store Files| L
    H -->|Cache Meta| J
    
    N -->|Consume Events| Q[Notification Worker]
    Q -->|Store Notifications| R[(Notification DB)]
    Q -->|Send Push| S[External Push Service]
```

---

See `architecture/` directory for individual `.mmd` diagram files.
