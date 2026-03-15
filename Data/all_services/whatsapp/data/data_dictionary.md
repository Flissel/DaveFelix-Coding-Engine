# Data Dictionary: unnamed_project Data Dictionary

**Generated:** 2026-02-04T17:36:24.430998

## Summary

- Entities: 50
- Relationships: 42
- Glossary Terms: 34

---

## Entities

### AIAssistantIntegration

Integration of an AI assistant feature

*Source Requirements:* WA-AI-001

| Attribute | Type | Required | Description |
|-----------|------|----------|-------------|
| integration_id | uuid | Yes |  |
| name | string | Yes |  |
| enabled | boolean | Yes |  |

### ApplicationPlatform

Bereitgestellte Plattform/Client

*Source Requirements:* WA-INT-005, WA-INT-006

| Attribute | Type | Required | Description |
|-----------|------|----------|-------------|
| platform_id | string | Yes |  |
| type | string | Yes |  |

### AuthMethod

Authentication method available for a user

*Source Requirements:* WA-AUTH-002, WA-AUTH-003, WA-AUTH-005

| Attribute | Type | Required | Description |
|-----------|------|----------|-------------|
| method_id | uuid | Yes |  |
| type | string | Yes |  |
| enabled | boolean | Yes |  |

### Backup

End-to-end encrypted backup of chat data

*Source Requirements:* WA-BAK-002

| Attribute | Type | Required | Description |
|-----------|------|----------|-------------|
| backupId | uuid | Yes |  |
| isEndToEndEncrypted | boolean | Yes |  |
| createdAt | date | Yes |  |

### BlockedContact

Record of a blocked contact

*Source Requirements:* WA-SEC-004

| Attribute | Type | Required | Description |
|-----------|------|----------|-------------|
| block_id | uuid | Yes |  |
| contact_identifier | string | Yes |  |

### Broadcast

Broadcast message to multiple recipients

*Source Requirements:* WA-MSG-011

| Attribute | Type | Required | Description |
|-----------|------|----------|-------------|
| broadcast_id | uuid | Yes |  |
| message_id | uuid | Yes |  |

### Business

Business account using the system

*Source Requirements:* WA-BUS-006, WA-BUS-009, WA-BUS-010

| Attribute | Type | Required | Description |
|-----------|------|----------|-------------|
| business_id | uuid | Yes |  |
| name | string | Yes |  |

### BusinessProfile

Enhanced business profile with automation features

*Source Requirements:* WA-BUS-001, WA-BUS-002, WA-BUS-003, WA-BUS-004, WA-BUS-005

| Attribute | Type | Required | Description |
|-----------|------|----------|-------------|
| businessProfileId | uuid | Yes |  |
| isVerified | boolean | Yes |  |
| hasQuickReplies | boolean | Yes |  |
| hasAwayMessage | boolean | Yes |  |
| hasGreetingMessage | boolean | Yes |  |

### BusinessStatistic

Message statistics for a business

*Source Requirements:* WA-BUS-009

| Attribute | Type | Required | Description |
|-----------|------|----------|-------------|
| stat_id | uuid | Yes |  |
| metric_name | string | Yes |  |
| metric_value | integer | Yes |  |

### Call

Encrypted voice/video call, including group calls.

*Source Requirements:* WA-CALL-001, WA-CALL-002, WA-CALL-003

| Attribute | Type | Required | Description |
|-----------|------|----------|-------------|
| call_id | uuid | Yes |  |
| call_type | string | Yes |  |
| is_encrypted | boolean | Yes |  |

### CallHistory

Log of calls for a user

*Source Requirements:* WA-CALL-007

| Attribute | Type | Required | Description |
|-----------|------|----------|-------------|
| call_history_id | uuid | Yes |  |

### Channel

One-way broadcast channel.

*Source Requirements:* WA-GRP-007

| Attribute | Type | Required | Description |
|-----------|------|----------|-------------|
| channel_id | uuid | Yes |  |
| is_broadcast | boolean | Yes |  |

### Chat

Conversation container for messages

*Source Requirements:* WA-MSG-010

| Attribute | Type | Required | Description |
|-----------|------|----------|-------------|
| chat_id | uuid | Yes |  |
| name | string | No |  |
| is_locked | boolean | Yes |  |

### ChatExport

Export of a single chat

*Source Requirements:* WA-BAK-003

| Attribute | Type | Required | Description |
|-----------|------|----------|-------------|
| exportId | uuid | Yes |  |
| exportedAt | date | Yes |  |

### ChatTransfer

Transfer of chat history to a new device

*Source Requirements:* WA-BAK-004

| Attribute | Type | Required | Description |
|-----------|------|----------|-------------|
| transferId | uuid | Yes |  |
| targetDeviceId | string | Yes |  |
| transferredAt | date | Yes |  |

### CloudBackup

Cloud-based chat backup configuration.

*Source Requirements:* WA-BAK-001

| Attribute | Type | Required | Description |
|-----------|------|----------|-------------|
| backup_id | uuid | Yes |  |
| enabled | boolean | Yes |  |
| last_backup_on | date | No |  |

### Community

Container for multiple groups.

*Source Requirements:* WA-GRP-006

| Attribute | Type | Required | Description |
|-----------|------|----------|-------------|
| community_id | uuid | Yes |  |
| name | string | Yes |  |

### Contact

A communication counterpart that can be reported.

*Source Requirements:* WA-SEC-005

| Attribute | Type | Required | Description |
|-----------|------|----------|-------------|
| contact_id | uuid | Yes |  |
| display_name | string | Yes |  |

### DataUsage

Data consumption control metrics.

*Source Requirements:* WA-SET-007

| Attribute | Type | Required | Description |
|-----------|------|----------|-------------|
| data_usage_id | uuid | Yes |  |
| consumed_mb | decimal | Yes |  |
| period_start | date | Yes |  |

### Device

User device for multi-device access

*Source Requirements:* WA-AUTH-004

| Attribute | Type | Required | Description |
|-----------|------|----------|-------------|
| device_id | uuid | Yes |  |
| device_name | string | No |  |

### Forwarding

Link between original and forwarded messages

*Source Requirements:* WA-MSG-005

| Attribute | Type | Required | Description |
|-----------|------|----------|-------------|
| forward_id | uuid | Yes |  |
| original_message_id | uuid | Yes |  |
| forwarded_message_id | uuid | Yes |  |
| forwarded_at | date | Yes |  |

### Group

Chat group within a community.

*Source Requirements:* WA-GRP-006, WA-GRP-008, WA-GRP-009

| Attribute | Type | Required | Description |
|-----------|------|----------|-------------|
| group_id | uuid | Yes |  |
| name | string | Yes |  |

### GroupChat

Group conversation with settings and admins

*Source Requirements:* WA-GRP-001, WA-GRP-002, WA-GRP-003

| Attribute | Type | Required | Description |
|-----------|------|----------|-------------|
| group_id | uuid | Yes |  |
| name | string | Yes |  |
| settings | string | No |  |
| admin_functions | string | No |  |

### IntegrationFeature

Integrationsfunktion des Systems

*Source Requirements:* WA-INT-001, WA-INT-002, WA-INT-003, WA-INT-004

| Attribute | Type | Required | Description |
|-----------|------|----------|-------------|
| feature_id | string | Yes |  |
| name | string | Yes |  |
| mandatory | boolean | Yes |  |

### InvitationLink

Link used to invite users to a group

*Source Requirements:* WA-GRP-004

| Attribute | Type | Required | Description |
|-----------|------|----------|-------------|
| link_id | uuid | Yes |  |
| group_id | uuid | Yes |  |
| url | string | Yes |  |

### Label

Business contact label/tag

*Source Requirements:* WA-CON-004

| Attribute | Type | Required | Description |
|-----------|------|----------|-------------|
| label_id | uuid | Yes |  |
| name | string | Yes |  |

### Locale

Localization settings for language direction and formats

*Source Requirements:* WA-LOC-001, WA-LOC-002

| Attribute | Type | Required | Description |
|-----------|------|----------|-------------|
| locale_id | uuid | Yes |  |
| language_code | string | Yes |  |
| rtl_supported | boolean | Yes |  |
| regional_format | string | No |  |

### Media

Media attached to a message (e.g., voice)

*Source Requirements:* WA-MSG-002, WA-MSG-009

| Attribute | Type | Required | Description |
|-----------|------|----------|-------------|
| media_id | uuid | Yes |  |
| message_id | uuid | Yes |  |
| media_type | string | Yes |  |
| uri | string | Yes |  |

### MediaItem

Media content sent in messages

*Source Requirements:* WA-MED-001, WA-MED-002, WA-MED-003, WA-MED-004

| Attribute | Type | Required | Description |
|-----------|------|----------|-------------|
| media_id | uuid | Yes |  |
| media_type | string | Yes |  |

### Message

A user-sent message in a chat

*Source Requirements:* WA-MSG-001, WA-MSG-002, WA-MSG-003, WA-MSG-004, WA-MSG-005, WA-MSG-006, WA-MSG-008, WA-MSG-009

| Attribute | Type | Required | Description |
|-----------|------|----------|-------------|
| message_id | uuid | Yes |  |
| chat_id | uuid | Yes |  |
| sender_id | uuid | Yes |  |
| message_type | string | Yes |  |
| content | string | No |  |
| sent_at | date | Yes |  |
| is_deleted | boolean | Yes |  |
| is_edited | boolean | Yes |  |
| is_view_once | boolean | Yes |  |
| expires_at | date | No |  |

### Notification

A push notification delivered to a user.

*Source Requirements:* WA-NOT-001, WA-NOT-002, WA-NOT-003, WA-NOT-005

| Attribute | Type | Required | Description |
|-----------|------|----------|-------------|
| notification_id | uuid | Yes |  |
| type | string | Yes |  |
| preview_text | string | No |  |

### Payment

In-app payment transaction

*Source Requirements:* WA-BUS-008

| Attribute | Type | Required | Description |
|-----------|------|----------|-------------|
| payment_id | uuid | Yes |  |
| amount | decimal | Yes |  |

### PerformanceRequirement

Nicht-funktionale Leistungsanforderung

*Source Requirements:* WA-PERF-002, WA-PERF-003, WA-PERF-004, WA-PERF-005

| Attribute | Type | Required | Description |
|-----------|------|----------|-------------|
| requirement_id | string | Yes |  |
| name | string | Yes |  |
| category | string | Yes |  |

### PhoneVerification

Phone number verification record

*Source Requirements:* WA-AUTH-001

| Attribute | Type | Required | Description |
|-----------|------|----------|-------------|
| verification_id | uuid | Yes |  |
| phone_number | string | Yes |  |
| verified | boolean | Yes |  |

### Poll

Poll created in a group or single chat.

*Source Requirements:* WA-GRP-008

| Attribute | Type | Required | Description |
|-----------|------|----------|-------------|
| poll_id | uuid | Yes |  |
| question | string | Yes |  |

### PrivacySetting

Visibility and invitation controls.

*Source Requirements:* WA-SET-003, WA-SET-004, WA-SET-005

| Attribute | Type | Required | Description |
|-----------|------|----------|-------------|
| privacy_id | uuid | Yes |  |
| profile_photo_visibility | string | Yes |  |
| info_status_visibility | string | Yes |  |
| group_invite_permission | string | Yes |  |

### ProductCatalog

Catalog of products for a business

*Source Requirements:* WA-BUS-006

| Attribute | Type | Required | Description |
|-----------|------|----------|-------------|
| catalog_id | uuid | Yes |  |
| title | string | Yes |  |

### Profile

User profile details and media

*Source Requirements:* WA-PROF-001, WA-PROF-002, WA-PROF-003, WA-PROF-005, WA-PROF-004

| Attribute | Type | Required | Description |
|-----------|------|----------|-------------|
| profile_id | uuid | Yes |  |
| display_name | string | No |  |
| status_text | string | No |  |
| profile_image_url | string | No |  |
| qr_code_value | string | No |  |

### Reaction

Emoji reaction to a message

*Source Requirements:* WA-MSG-007

| Attribute | Type | Required | Description |
|-----------|------|----------|-------------|
| reaction_id | uuid | Yes |  |
| message_id | uuid | Yes |  |
| user_id | uuid | Yes |  |
| emoji | string | Yes |  |
| created_at | date | Yes |  |

### Report

A report of a message or contact.

*Source Requirements:* WA-SEC-005

| Attribute | Type | Required | Description |
|-----------|------|----------|-------------|
| report_id | uuid | Yes |  |
| reported_type | string | Yes |  |
| reason | string | No |  |

### SecuritySetting

Security capabilities enabled for chats and app

*Source Requirements:* WA-SEC-001, WA-SEC-002, WA-SEC-003

| Attribute | Type | Required | Description |
|-----------|------|----------|-------------|
| security_id | uuid | Yes |  |
| e2e_enabled | boolean | Yes |  |
| verification_enabled | boolean | Yes |  |
| app_lock_enabled | boolean | Yes |  |

### ShoppingCart

Cart for orders

*Source Requirements:* WA-BUS-007

| Attribute | Type | Required | Description |
|-----------|------|----------|-------------|
| cart_id | uuid | Yes |  |
| status | string | Yes |  |

### SmartReplySuggestion

Intelligent reply suggestion provided by the system

*Source Requirements:* WA-AI-002

| Attribute | Type | Required | Description |
|-----------|------|----------|-------------|
| suggestion_id | uuid | Yes |  |
| text | string | Yes |  |
| confidence | decimal | No |  |

### Status

24-hour status update

*Source Requirements:* WA-STS-001, WA-STS-002, WA-STS-003

| Attribute | Type | Required | Description |
|-----------|------|----------|-------------|
| status_id | uuid | Yes |  |
| expires_at | date | Yes |  |

### StatusVisibilitySetting

Configurable visibility rules for status

*Source Requirements:* WA-STS-004, WA-STS-005

| Attribute | Type | Required | Description |
|-----------|------|----------|-------------|
| visibility_id | uuid | Yes |  |
| visibility_level | string | Yes |  |

### StickerPack

Region-specific collection of stickers

*Source Requirements:* WA-LOC-003

| Attribute | Type | Required | Description |
|-----------|------|----------|-------------|
| pack_id | uuid | Yes |  |
| name | string | Yes |  |
| region | string | No |  |

### StickerSuggestion

Context-based sticker suggestion

*Source Requirements:* WA-AI-003

| Attribute | Type | Required | Description |
|-----------|------|----------|-------------|
| suggestion_id | uuid | Yes |  |
| context | string | No |  |
| sticker_id | uuid | Yes |  |

### StorageUsage

Storage usage overview and management data.

*Source Requirements:* WA-SET-006

| Attribute | Type | Required | Description |
|-----------|------|----------|-------------|
| storage_id | uuid | Yes |  |
| used_mb | decimal | Yes |  |
| managed_on | date | No |  |

### User

Registered system user

*Source Requirements:* WA-AUTH-001

| Attribute | Type | Required | Description |
|-----------|------|----------|-------------|
| user_id | uuid | Yes |  |
| phone_number | string | Yes |  |

### UserSettings

User-configurable application settings.

*Source Requirements:* WA-SET-002, WA-SET-008, WA-SET-009, WA-SET-010

| Attribute | Type | Required | Description |
|-----------|------|----------|-------------|
| settings_id | uuid | Yes |  |
| read_receipts_enabled | boolean | Yes |  |
| chat_background | string | No |  |
| dark_mode_enabled | boolean | Yes |  |
| language | string | Yes |  |

---

## Relationships

| Relationship | Source | Target | Cardinality | Description |
|--------------|--------|--------|-------------|-------------|
| verifies | User | PhoneVerification | 1:1 |  |
| uses | User | AuthMethod | 1:N |  |
| has | User | Device | 1:N |  |
| has | User | Profile | 1:1 |  |
| contains | Chat | Message | 1:N |  |
| has | Message | Reaction | 1:N |  |
| has | Message | Media | 1:N |  |
| quotes | Message | Message | 1:1 |  |
| is_forwarded_via | Message | Forwarding | 1:N |  |
| sends | User | Message | 1:N |  |
| mentions | Message | User | N:N |  |
| members | GroupChat | User | N:N |  |
| has | GroupChat | InvitationLink | 1:N |  |
| recipients | Broadcast | User | N:N |  |
| contains | Community | Group | 1:N |  |
| has | Group | Channel | 1:N |  |
| hosts | Group | Poll | 1:N |  |
| contains | CallHistory | Call | 1:N |  |
| has | Status | StatusVisibilitySetting | 1:1 |  |
| includes | Status | MediaItem | 0:N |  |
| secured_by | Chat | SecuritySetting | 1:1 |  |
| reports | Report | Message | N:1 |  |
| reports | Report | Contact | N:1 |  |
| about | Notification | Message | N:1 |  |
| about | Notification | Call | N:1 |  |
| manages | User | Contact | 1:N |  |
| tagged_with | Contact | Label | M:N |  |
| participates_in | User | Chat | 1:N |  |
| includes | UserSettings | PrivacySetting | 1:1 |  |
| tracks | UserSettings | StorageUsage | 1:1 |  |
| tracks | UserSettings | DataUsage | 1:1 |  |
| configures | UserSettings | CloudBackup | 1:1 |  |
| hasBackups | Chat | Backup | 1:N |  |
| hasExports | Chat | ChatExport | 1:N |  |
| hasTransfers | Chat | ChatTransfer | 1:N |  |
| owns | Business | ProductCatalog | 1:1 |  |
| receives | Business | ShoppingCart | 1:N |  |
| paid_by | ShoppingCart | Payment | 1:1 |  |
| has | Business | BusinessStatistic | 1:N |  |
| applies_to | PerformanceRequirement | ApplicationPlatform | N:N |  |
| available_on | IntegrationFeature | ApplicationPlatform | N:N |  |
| offers | Locale | StickerPack | 1:N |  |

---

## Glossary

### 2FA

Two-factor authentication using a 6-digit PIN

### @mention

Reference to a user within a group message.

### Biometric

Authentication using fingerprint or Face ID

### Broadcast-Listen

Send one message to multiple recipients.

### Call link

Link to join or schedule a call.

### Chat Lock

Additional authentication required to access a chat.

### Cloud Backup

Storing chat backups in a cloud service.

### End-to-End Encryption

Encryption where only communicating users can read messages

### End-to-End verschluesseltes Backup

Backup, das nur von den Endpunkten entschluesselt werden kann

### Event planning

Scheduling of events within groups.

### GIF

Animated image format used as a message attachment

### Group Invite Permission

Rule defining who may add users to groups.

### Gruppeneinstellungen

Configurable settings for a group chat.

### In-App-Zahlungen

Payments executed within the application.

### Integration

Anbindung an Systemfunktionen wie Sharing, Sprachassistenten, Widgets, Smartwatch

### Media type

Category of message content such as image, video, or document

### Nicht-Stoeren-Modus

A mode that suppresses notifications.

### Online status visibility

User-configurable setting controlling who can see last online status

### Passkey

Passwordless authentication credential

### Performance

Leistungseigenschaften wie Startzeit, Synchronisation, Batterie- und Speichereffizienz

### Produktkatalog

Structured list of products offered by a business.

### Push-Benachrichtigung

Server-initiated message delivered to a user device.

### Quick reply

Predefined message when rejecting a call.

### RTL

Right-to-left language support

### Regional format

Locale-specific formatting for dates, numbers, and related conventions

### Schnellantworten

Vordefinierte Antworten fuer Businesses

### Screen sharing

Sharing screen during a call.

### Status

A 24-hour ephemeral update shared with contacts

### Status mute

Suppress viewing notifications for a contact's status

### Sticker

Static or animated graphic used in chat messages

### Unknown sender

A sender not matched to a known contact

### View-Once Media

Media that can be viewed a single time before becoming unavailable.

### Visibility

Who can see profile photo or status info.

### Zwei-Schritte-Verifizierung

Optional additional PIN-based protection.

