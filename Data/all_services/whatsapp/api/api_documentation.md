# unnamed_project API - API Documentation

**Version:** 1.0.0
**Generated:** 2026-02-04T17:36:24.413247

## Endpoints

### AbsenceMessages

#### `GET` /api/v1/users/{userId}/absence-messages

**List absence messages**

Retrieve a paginated list of automatic absence messages for a user.

*Requirement:* WA-BUS-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |
| page | query | integer | False | Page number (starting at 1) |
| pageSize | query | integer | False | Number of items per page |

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `404`: User Not Found

---

#### `POST` /api/v1/users/{userId}/absence-messages

**Create absence message**

Create a new automatic absence message for a user.

*Requirement:* WA-BUS-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Request Body:** `CreateAbsenceMessageRequest`

**Responses:**

- `201`: Created
- `400`: Bad Request
- `401`: Unauthorized
- `404`: User Not Found
- `409`: Conflict

---

#### `GET` /api/v1/users/{userId}/absence-messages/{messageId}

**Get absence message**

Retrieve a specific automatic absence message.

*Requirement:* WA-BUS-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |
| messageId | path | string | True | Absence message ID |

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `404`: Not Found

---

#### `PUT` /api/v1/users/{userId}/absence-messages/{messageId}

**Update absence message**

Update an existing automatic absence message.

*Requirement:* WA-BUS-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |
| messageId | path | string | True | Absence message ID |

**Request Body:** `UpdateAbsenceMessageRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Not Found
- `409`: Conflict

---

#### `DELETE` /api/v1/users/{userId}/absence-messages/{messageId}

**Delete absence message**

Delete an automatic absence message.

*Requirement:* WA-BUS-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |
| messageId | path | string | True | Absence message ID |

**Responses:**

- `204`: No Content
- `401`: Unauthorized
- `404`: Not Found

---

### Accessibility

#### `POST` /api/v1/accessibility/contrast-checks

**Check color contrast compliance**

Validates provided foreground/background color pairs against required contrast ratios and returns compliance results.

*Requirement:* WA-ACC-003

**Request Body:** `ContrastCheckRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `422`: Unprocessable Entity

---

### AccessibilitySettings

#### `GET` /api/v1/users/{userId}/accessibility-settings

**Get accessibility settings**

Retrieve the accessibility settings required to ensure full screenreader compatibility for a specific user.

*Requirement:* WA-ACC-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Not Found
- `500`: Internal Server Error

---

#### `PUT` /api/v1/users/{userId}/accessibility-settings

**Update accessibility settings**

Update the accessibility settings to ensure full screenreader compatibility for a specific user.

*Requirement:* WA-ACC-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Request Body:** `UpdateAccessibilitySettingsRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Not Found
- `500`: Internal Server Error

---

### AiChatMessages

#### `POST` /api/v1/ai-chats/{chatId}/messages

**Send message to AI assistant**

Sends a user message to the AI assistant and returns the assistant response.

*Requirement:* WA-AI-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| chatId | path | string | True | Chat session ID |

**Request Body:** `CreateAiChatMessageRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Not Found
- `500`: Internal Server Error

---

#### `GET` /api/v1/ai-chats/{chatId}/messages

**List chat messages**

Retrieves a paginated list of messages for a chat session.

*Requirement:* WA-AI-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| chatId | path | string | True | Chat session ID |
| page | query | integer | False | Page number for pagination |
| pageSize | query | integer | False | Number of items per page |

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Not Found
- `500`: Internal Server Error

---

### AiChats

#### `POST` /api/v1/ai-chats

**Create AI chat session**

Creates a new AI chat session for interacting with the assistant.

*Requirement:* WA-AI-001

**Request Body:** `CreateAiChatRequest`

**Responses:**

- `201`: Created
- `400`: Bad Request
- `401`: Unauthorized
- `500`: Internal Server Error

---

#### `GET` /api/v1/ai-chats

**List AI chat sessions**

Retrieves a paginated list of AI chat sessions.

*Requirement:* WA-AI-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| page | query | integer | False | Page number for pagination |
| pageSize | query | integer | False | Number of items per page |

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `500`: Internal Server Error

---

#### `GET` /api/v1/ai-chats/{chatId}

**Get AI chat session**

Retrieves details of a specific AI chat session.

*Requirement:* WA-AI-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| chatId | path | string | True | Chat session ID |

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `404`: Not Found
- `500`: Internal Server Error

---

#### `DELETE` /api/v1/ai-chats/{chatId}

**Delete AI chat session**

Deletes an AI chat session and its messages.

*Requirement:* WA-AI-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| chatId | path | string | True | Chat session ID |

**Responses:**

- `204`: No Content
- `401`: Unauthorized
- `404`: Not Found
- `500`: Internal Server Error

---

### AppLock

#### `GET` /api/v1/app-lock/status

**Get app lock status**

Returns whether the app lock is enabled and the configured authentication method.

*Requirement:* WA-SEC-003

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `403`: Forbidden

---

#### `PUT` /api/v1/app-lock

**Configure app lock**

Enable or disable app lock and set the authentication method.

*Requirement:* WA-SEC-003

**Request Body:** `AppLockConfigRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `403`: Forbidden
- `422`: Unprocessable Entity

---

#### `POST` /api/v1/app-lock/unlock

**Unlock app**

Validates user authentication to unlock the app when app lock is enabled.

*Requirement:* WA-SEC-003

**Request Body:** `AppUnlockRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `403`: Forbidden
- `429`: Too Many Requests

---

### AppStartup

#### `GET` /api/v1/app-startup

**Fetch minimal bootstrap data for fast app start**

Returns lightweight, cacheable data required to initialize the app quickly (e.g., feature flags, minimal user context, configuration hashes). Designed to minimize payload size and latency.

*Requirement:* WA-PERF-002

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| clientVersion | query | string | False | Client app version to tailor bootstrap data |
| locale | query | string | False | Locale for localized startup strings |

**Responses:**

- `200`: Success
- `304`: Not Modified
- `400`: Bad Request
- `401`: Unauthorized
- `500`: Internal Server Error

---

### AudioFiles

#### `POST` /api/v1/audio-files

**Upload an audio file**

Allows clients to send (upload) an audio file to the system using multipart/form-data.

*Requirement:* WA-MED-008

**Request Body:** `UploadAudioFileRequest`

**Responses:**

- `201`: Created
- `400`: Bad Request
- `401`: Unauthorized
- `413`: Payload Too Large
- `415`: Unsupported Media Type
- `500`: Internal Server Error

---

### Auth

#### `POST` /api/v1/auth/2fa/setup

**Enable 2FA for the current user**

Enables optional two-factor authentication using a 6-digit PIN and returns setup details for the user.

*Requirement:* WA-AUTH-002

**Request Body:** `EnableTwoFactorRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `409`: Conflict

---

#### `POST` /api/v1/auth/2fa/verify

**Verify 2FA PIN**

Verifies the 6-digit PIN for an active 2FA challenge to complete authentication.

*Requirement:* WA-AUTH-002

**Request Body:** `VerifyTwoFactorRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `403`: Forbidden

---

#### `DELETE` /api/v1/auth/2fa

**Disable 2FA for the current user**

Disables optional two-factor authentication for the current user.

*Requirement:* WA-AUTH-002

**Request Body:** `DisableTwoFactorRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `403`: Forbidden

---

#### `POST` /api/v1/auth/pin/verify

**Verify PIN**

Verifies the user's PIN as an additional step after primary authentication.

*Requirement:* WA-SEC-006

**Request Body:** `VerifyPinRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `403`: Forbidden
- `423`: Locked

---

### Authentication

#### `POST` /api/v1/users/phone-registrations

**Register user by phone number**

Initiates user registration using a phone number and sends a verification code (OTP) to the provided phone number.

*Requirement:* WA-AUTH-001

**Request Body:** `CreatePhoneRegistrationRequest`

**Responses:**

- `201`: Created
- `400`: Bad Request
- `409`: Conflict
- `429`: Too Many Requests
- `500`: Internal Server Error

---

#### `POST` /api/v1/users/phone-verifications

**Verify phone number registration**

Verifies a user's phone number by validating the OTP sent during registration.

*Requirement:* WA-AUTH-001

**Request Body:** `VerifyPhoneRegistrationRequest`

**Responses:**

- `200`: OK
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Not Found
- `409`: Conflict
- `500`: Internal Server Error

---

#### `POST` /api/v1/auth/biometric/verify

**Verify biometric authentication**

Verifies biometric authentication to unlock a session or obtain a token.

*Requirement:* WA-AUTH-003

**Request Body:** `VerifyBiometricRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `403`: Forbidden

---

### Backups

#### `POST` /api/v1/backups

**Create encrypted backup**

Creates a new end-to-end encrypted backup by storing only client-encrypted data and related metadata.

*Requirement:* WA-BAK-002

**Request Body:** `CreateBackupRequest`

**Responses:**

- `201`: Created
- `400`: Bad Request
- `401`: Unauthorized
- `413`: Payload Too Large
- `422`: Unprocessable Entity

---

#### `GET` /api/v1/backups

**List encrypted backups**

Returns a paginated list of encrypted backups for the authenticated client.

*Requirement:* WA-BAK-002

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| page | query | integer | False | Page number (starting at 1) |
| pageSize | query | integer | False | Number of items per page |

**Responses:**

- `200`: Success
- `401`: Unauthorized

---

#### `GET` /api/v1/backups/{backupId}

**Get encrypted backup metadata**

Retrieves metadata for a specific encrypted backup without exposing any encryption keys.

*Requirement:* WA-BAK-002

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| backupId | path | string | True | Backup identifier |

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `404`: Not Found

---

#### `POST` /api/v1/backups/{backupId}/restore

**Initiate encrypted backup restore**

Initiates restore by returning the encrypted backup payload so the client can decrypt it locally.

*Requirement:* WA-BAK-002

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| backupId | path | string | True | Backup identifier |

**Request Body:** `RestoreBackupRequest`

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `404`: Not Found
- `409`: Conflict

---

#### `DELETE` /api/v1/backups/{backupId}

**Delete encrypted backup**

Deletes a specific encrypted backup and its encrypted payload.

*Requirement:* WA-BAK-002

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| backupId | path | string | True | Backup identifier |

**Responses:**

- `204`: No Content
- `401`: Unauthorized
- `404`: Not Found

---

### Biometrics

#### `POST` /api/v1/users/{userId}/biometrics

**Register biometric credential**

Enrolls a biometric credential (e.g., fingerprint or Face ID token) for a user.

*Requirement:* WA-AUTH-003

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Request Body:** `RegisterBiometricRequest`

**Responses:**

- `201`: Created
- `400`: Bad Request
- `401`: Unauthorized
- `409`: Conflict

---

#### `POST` /api/v1/auth/biometric/verify

**Verify biometric authentication**

Verifies biometric authentication to unlock a session or obtain a token.

*Requirement:* WA-AUTH-003

**Request Body:** `VerifyBiometricRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `403`: Forbidden

---

#### `GET` /api/v1/users/{userId}/biometrics

**List biometric credentials**

Returns a paginated list of enrolled biometric credentials for a user.

*Requirement:* WA-AUTH-003

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |
| page | query | integer | False | Page number |
| pageSize | query | integer | False | Number of items per page |

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `404`: Not Found

---

#### `DELETE` /api/v1/users/{userId}/biometrics/{biometricId}

**Delete biometric credential**

Removes an enrolled biometric credential from a user.

*Requirement:* WA-AUTH-003

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |
| biometricId | path | string | True | Biometric credential ID |

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `404`: Not Found

---

### BroadcastChannels

#### `POST` /api/v1/broadcast-channels

**Create a broadcast channel**

Creates a one-way broadcast channel where only authorized senders can publish messages.

*Requirement:* WA-GRP-007

**Request Body:** `CreateBroadcastChannelRequest`

**Responses:**

- `201`: Created
- `400`: Bad Request
- `401`: Unauthorized
- `409`: Conflict

---

#### `GET` /api/v1/broadcast-channels

**List broadcast channels**

Returns a paginated list of broadcast channels.

*Requirement:* WA-GRP-007

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| page | query | integer | False | Page number (starts at 1) |
| pageSize | query | integer | False | Number of items per page |

**Responses:**

- `200`: Success
- `401`: Unauthorized

---

#### `GET` /api/v1/broadcast-channels/{channelId}

**Get a broadcast channel**

Retrieves details of a specific broadcast channel.

*Requirement:* WA-GRP-007

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| channelId | path | string | True | Channel ID |

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `404`: Not Found

---

#### `PUT` /api/v1/broadcast-channels/{channelId}

**Update a broadcast channel**

Updates metadata of a broadcast channel.

*Requirement:* WA-GRP-007

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| channelId | path | string | True | Channel ID |

**Request Body:** `UpdateBroadcastChannelRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Not Found

---

#### `DELETE` /api/v1/broadcast-channels/{channelId}

**Delete a broadcast channel**

Deletes a broadcast channel.

*Requirement:* WA-GRP-007

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| channelId | path | string | True | Channel ID |

**Responses:**

- `204`: No Content
- `401`: Unauthorized
- `404`: Not Found

---

### BroadcastLists

#### `POST` /api/v1/broadcast-lists

**Create broadcast list**

Creates a new broadcast list used to send mass messages to multiple recipients.

*Requirement:* WA-MSG-011

**Request Body:** `CreateBroadcastListRequest`

**Responses:**

- `201`: Created
- `400`: Bad Request
- `401`: Unauthorized
- `409`: Conflict

---

#### `GET` /api/v1/broadcast-lists

**List broadcast lists**

Returns paginated broadcast lists.

*Requirement:* WA-MSG-011

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| page | query | integer | False | Page number (default 1) |
| pageSize | query | integer | False | Page size (default 20) |

**Responses:**

- `200`: Success
- `401`: Unauthorized

---

#### `GET` /api/v1/broadcast-lists/{listId}

**Get broadcast list**

Retrieves a specific broadcast list by ID.

*Requirement:* WA-MSG-011

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| listId | path | string | True | Broadcast list ID |

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `404`: Not Found

---

#### `PUT` /api/v1/broadcast-lists/{listId}

**Update broadcast list**

Updates an existing broadcast list.

*Requirement:* WA-MSG-011

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| listId | path | string | True | Broadcast list ID |

**Request Body:** `UpdateBroadcastListRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Not Found

---

#### `DELETE` /api/v1/broadcast-lists/{listId}

**Delete broadcast list**

Deletes a broadcast list.

*Requirement:* WA-MSG-011

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| listId | path | string | True | Broadcast list ID |

**Responses:**

- `204`: No Content
- `401`: Unauthorized
- `404`: Not Found

---

#### `POST` /api/v1/broadcast-lists/{listId}/recipients

**Add recipients to broadcast list**

Adds one or more recipients to a broadcast list.

*Requirement:* WA-MSG-011

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| listId | path | string | True | Broadcast list ID |

**Request Body:** `AddRecipientsRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Not Found

---

#### `DELETE` /api/v1/broadcast-lists/{listId}/recipients/{recipientId}

**Remove recipient from broadcast list**

Removes a specific recipient from a broadcast list.

*Requirement:* WA-MSG-011

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| listId | path | string | True | Broadcast list ID |
| recipientId | path | string | True | Recipient ID |

**Responses:**

- `204`: No Content
- `401`: Unauthorized
- `404`: Not Found

---

### BroadcastMessages

#### `POST` /api/v1/broadcast-lists/{listId}/messages

**Send broadcast message**

Sends a mass message to all recipients in the broadcast list.

*Requirement:* WA-MSG-011

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| listId | path | string | True | Broadcast list ID |

**Request Body:** `SendBroadcastMessageRequest`

**Responses:**

- `202`: Accepted
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Not Found

---

#### `POST` /api/v1/broadcast-channels/{channelId}/messages

**Publish a broadcast message**

Publishes a message to a one-way broadcast channel by an authorized sender.

*Requirement:* WA-GRP-007

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| channelId | path | string | True | Channel ID |

**Request Body:** `PublishBroadcastMessageRequest`

**Responses:**

- `201`: Created
- `400`: Bad Request
- `401`: Unauthorized
- `403`: Forbidden
- `404`: Not Found

---

#### `GET` /api/v1/broadcast-channels/{channelId}/messages

**List broadcast messages**

Returns a paginated list of messages for a broadcast channel.

*Requirement:* WA-GRP-007

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| channelId | path | string | True | Channel ID |
| page | query | integer | False | Page number (starts at 1) |
| pageSize | query | integer | False | Number of items per page |

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `404`: Not Found

---

### BusinessProfiles

#### `POST` /api/v1/business-profiles

**Create business profile**

Creates an extended business profile.

*Requirement:* WA-BUS-001

**Request Body:** `CreateBusinessProfileRequest`

**Responses:**

- `201`: Created
- `400`: Bad Request
- `401`: Unauthorized
- `409`: Conflict
- `500`: Internal Server Error

---

#### `GET` /api/v1/business-profiles

**List business profiles**

Retrieves a paginated list of extended business profiles.

*Requirement:* WA-BUS-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| page | query | integer | False | Page number |
| pageSize | query | integer | False | Number of items per page |
| search | query | string | False | Search term for business name or registration number |

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `500`: Internal Server Error

---

#### `GET` /api/v1/business-profiles/{id}

**Get business profile**

Retrieves a specific extended business profile by ID.

*Requirement:* WA-BUS-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| id | path | string | True | Business profile ID |

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `404`: Not Found
- `500`: Internal Server Error

---

#### `PUT` /api/v1/business-profiles/{id}

**Update business profile**

Updates an existing extended business profile.

*Requirement:* WA-BUS-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| id | path | string | True | Business profile ID |

**Request Body:** `UpdateBusinessProfileRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Not Found
- `409`: Conflict
- `500`: Internal Server Error

---

#### `DELETE` /api/v1/business-profiles/{id}

**Delete business profile**

Deletes an extended business profile by ID.

*Requirement:* WA-BUS-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| id | path | string | True | Business profile ID |

**Responses:**

- `204`: No Content
- `401`: Unauthorized
- `404`: Not Found
- `500`: Internal Server Error

---

### BusinessStats

#### `GET` /api/v1/businesses/{businessId}/message-stats

**Get business message statistics**

Retrieve basic message statistics for a specific business over an optional time range.

*Requirement:* WA-BUS-009

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| businessId | path | string | True | Business ID |
| from | query | string | False | Start of time range (ISO 8601) |
| to | query | string | False | End of time range (ISO 8601) |
| granularity | query | string | False | Aggregation granularity (hour|day|week|month) |

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `403`: Forbidden
- `404`: Not Found

---

### BusinessVerification

#### `POST` /api/v1/businesses/{businessId}/verifications

**Submit business verification**

Creates a verification request for a business, including required documents and metadata.

*Requirement:* WA-BUS-002

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| businessId | path | string | True | Business ID |

**Request Body:** `CreateBusinessVerificationRequest`

**Responses:**

- `201`: Created
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Business Not Found
- `409`: Verification Already Exists
- `422`: Unprocessable Entity

---

#### `GET` /api/v1/businesses/{businessId}/verifications/{verificationId}

**Get business verification status**

Retrieves the details and status of a specific business verification request.

*Requirement:* WA-BUS-002

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| businessId | path | string | True | Business ID |
| verificationId | path | string | True | Verification request ID |

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `404`: Not Found

---

#### `GET` /api/v1/businesses/{businessId}/verifications

**List business verifications**

Lists verification requests for a business with pagination.

*Requirement:* WA-BUS-002

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| businessId | path | string | True | Business ID |
| page | query | integer | False | Page number (default: 1) |
| pageSize | query | integer | False | Items per page (default: 20) |
| status | query | string | False | Filter by status (pending, approved, rejected) |

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `404`: Business Not Found

---

### BusinessVerificationAdmin

#### `PUT` /api/v1/admin/verifications/{verificationId}

**Review business verification**

Approves or rejects a business verification request (admin or reviewer action).

*Requirement:* WA-BUS-002

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| verificationId | path | string | True | Verification request ID |

**Request Body:** `ReviewBusinessVerificationRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `403`: Forbidden
- `404`: Not Found
- `409`: Conflict

---

### CallHistory

#### `POST` /api/v1/call-history

**Create call history record**

Creates a new call history entry for a call.

*Requirement:* WA-CALL-007

**Request Body:** `CreateCallHistoryRequest`

**Responses:**

- `201`: Created
- `400`: Bad Request
- `401`: Unauthorized
- `422`: Unprocessable Entity

---

#### `GET` /api/v1/call-history

**List call history records**

Retrieves a paginated list of call history records with optional filters.

*Requirement:* WA-CALL-007

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| page | query | integer | False | Page number (default: 1) |
| pageSize | query | integer | False | Number of records per page (default: 20) |
| callerId | query | string | False | Filter by caller ID |
| calleeId | query | string | False | Filter by callee ID |
| from | query | string | False | Filter calls starting from timestamp (ISO 8601) |
| to | query | string | False | Filter calls up to timestamp (ISO 8601) |
| status | query | string | False | Filter by call status |

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized

---

#### `GET` /api/v1/call-history/{id}

**Get call history record**

Retrieves a single call history record by ID.

*Requirement:* WA-CALL-007

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| id | path | string | True | Call history record ID |

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `404`: Not Found

---

### CallLinks

#### `POST` /api/v1/calls/{callId}/link

**Create call link for a scheduled call**

Generates an access link for a planned/scheduled call. If a link already exists, a new link may be generated or the existing link returned based on implementation rules.

*Requirement:* WA-CALL-005

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| callId | path | string | True | Scheduled call ID |

**Request Body:** `CreateCallLinkRequest`

**Responses:**

- `201`: Created
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Call Not Found
- `409`: Conflict
- `500`: Internal Server Error

---

#### `GET` /api/v1/calls/{callId}/link

**Get call link for a scheduled call**

Returns the existing call link for a planned/scheduled call.

*Requirement:* WA-CALL-005

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| callId | path | string | True | Scheduled call ID |

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `404`: Call Link Not Found
- `500`: Internal Server Error

---

#### `DELETE` /api/v1/calls/{callId}/link

**Delete call link for a scheduled call**

Revokes the call link associated with a planned/scheduled call.

*Requirement:* WA-CALL-005

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| callId | path | string | True | Scheduled call ID |

**Responses:**

- `204`: No Content
- `401`: Unauthorized
- `404`: Call Link Not Found
- `500`: Internal Server Error

---

### CallNotificationSettings

#### `GET` /api/v1/users/{userId}/call-notification-settings

**Get call notification settings**

Retrieves the separate call notification settings for a specific user.

*Requirement:* WA-NOT-006

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `403`: Forbidden
- `404`: Not Found
- `500`: Internal Server Error

---

#### `PUT` /api/v1/users/{userId}/call-notification-settings

**Update call notification settings**

Updates the separate call notification settings for a specific user.

*Requirement:* WA-NOT-006

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Request Body:** `UpdateCallNotificationSettingsRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `403`: Forbidden
- `404`: Not Found
- `409`: Conflict
- `500`: Internal Server Error

---

### Calls

#### `POST` /api/v1/calls/{callId}/link

**Create call link for a scheduled call**

Generates an access link for a planned/scheduled call. If a link already exists, a new link may be generated or the existing link returned based on implementation rules.

*Requirement:* WA-CALL-005

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| callId | path | string | True | Scheduled call ID |

**Request Body:** `CreateCallLinkRequest`

**Responses:**

- `201`: Created
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Call Not Found
- `409`: Conflict
- `500`: Internal Server Error

---

#### `GET` /api/v1/calls/{callId}/link

**Get call link for a scheduled call**

Returns the existing call link for a planned/scheduled call.

*Requirement:* WA-CALL-005

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| callId | path | string | True | Scheduled call ID |

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `404`: Call Link Not Found
- `500`: Internal Server Error

---

#### `DELETE` /api/v1/calls/{callId}/link

**Delete call link for a scheduled call**

Revokes the call link associated with a planned/scheduled call.

*Requirement:* WA-CALL-005

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| callId | path | string | True | Scheduled call ID |

**Responses:**

- `204`: No Content
- `401`: Unauthorized
- `404`: Call Link Not Found
- `500`: Internal Server Error

---

#### `POST` /api/v1/calls/{callId}/reject

**Reject a call with a message**

Rejects an active incoming call and optionally sends a predefined or custom rejection message to the caller. Designed for fast response handling.

*Requirement:* WA-CALL-006

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| callId | path | string | True | Unique identifier of the call to reject |

**Request Body:** `RejectCallRequest`

**Responses:**

- `200`: Call rejected successfully
- `202`: Call rejection accepted and being processed
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Call Not Found
- `409`: Call Not in Rejectable State
- `500`: Internal Server Error

---

#### `POST` /api/v1/calls

**Create a call session with IP masking**

Creates a new call session and applies IP masking based on settings or explicit request flag.

*Requirement:* WA-SEC-008

**Request Body:** `CreateCallRequest`

**Responses:**

- `201`: Created
- `400`: Bad Request
- `401`: Unauthorized
- `403`: Forbidden
- `409`: Conflict
- `500`: Internal Server Error

---

### Camera

#### `POST` /api/v1/chats/{chatId}/camera-sessions

**Create camera access session for a chat**

Creates a short-lived camera session to enable direct camera access within the chat and returns upload configuration for captured media.

*Requirement:* WA-MED-007

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| chatId | path | string | True | Chat ID |

**Request Body:** `CreateCameraSessionRequest`

**Responses:**

- `201`: Created
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Chat Not Found
- `429`: Too Many Requests

---

### CartItems

#### `POST` /api/v1/carts/{cartId}/items

**Add item to cart**

Adds a product item to the shopping cart.

*Requirement:* WA-BUS-007

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| cartId | path | string | True | Cart ID |

**Request Body:** `AddCartItemRequest`

**Responses:**

- `201`: Created
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Not Found

---

#### `GET` /api/v1/carts/{cartId}/items

**List cart items**

Lists items in the shopping cart with pagination.

*Requirement:* WA-BUS-007

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| cartId | path | string | True | Cart ID |
| page | query | integer | False | Page number |
| pageSize | query | integer | False | Number of items per page |

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `404`: Not Found

---

#### `PUT` /api/v1/carts/{cartId}/items/{itemId}

**Update cart item**

Updates the quantity of a cart item.

*Requirement:* WA-BUS-007

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| cartId | path | string | True | Cart ID |
| itemId | path | string | True | Cart item ID |

**Request Body:** `UpdateCartItemRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Not Found

---

#### `DELETE` /api/v1/carts/{cartId}/items/{itemId}

**Remove cart item**

Removes an item from the shopping cart.

*Requirement:* WA-BUS-007

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| cartId | path | string | True | Cart ID |
| itemId | path | string | True | Cart item ID |

**Responses:**

- `204`: No Content
- `401`: Unauthorized
- `404`: Not Found

---

### Carts

#### `POST` /api/v1/carts

**Create cart**

Creates a new shopping cart for a customer or anonymous session.

*Requirement:* WA-BUS-007

**Request Body:** `CreateCartRequest`

**Responses:**

- `201`: Created
- `400`: Bad Request
- `401`: Unauthorized

---

#### `GET` /api/v1/carts/{cartId}

**Get cart**

Retrieves a shopping cart by ID.

*Requirement:* WA-BUS-007

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| cartId | path | string | True | Cart ID |

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `404`: Not Found

---

### ChatBackgrounds

#### `GET` /api/v1/chat-backgrounds

**List available chat backgrounds**

Returns a paginated list of available chat backgrounds that users can choose from.

*Requirement:* WA-SET-008

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| page | query | integer | False | Page number for pagination |
| pageSize | query | integer | False | Number of items per page |

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `500`: Internal Server Error

---

#### `GET` /api/v1/chats/{chatId}/background

**Get chat-specific background**

Retrieves the background settings for a specific chat, if customized.

*Requirement:* WA-SET-008

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| chatId | path | string | True | Chat ID |

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `404`: Not Found
- `500`: Internal Server Error

---

#### `PUT` /api/v1/chats/{chatId}/background

**Set chat-specific background**

Updates the background settings for a specific chat.

*Requirement:* WA-SET-008

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| chatId | path | string | True | Chat ID |

**Request Body:** `UpdateChatBackgroundRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Not Found
- `500`: Internal Server Error

---

#### `DELETE` /api/v1/chats/{chatId}/background

**Remove chat-specific background**

Deletes chat-specific background customization and reverts to the user's default background.

*Requirement:* WA-SET-008

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| chatId | path | string | True | Chat ID |

**Responses:**

- `204`: No Content
- `401`: Unauthorized
- `404`: Not Found
- `500`: Internal Server Error

---

### ChatBackups

#### `POST` /api/v1/chat-backups

**Create a chat backup**

Initiates a cloud backup for a chat. Creates a backup job and returns its metadata.

*Requirement:* WA-BAK-001

**Request Body:** `CreateChatBackupRequest`

**Responses:**

- `201`: Created
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Chat Not Found
- `500`: Internal Server Error

---

#### `GET` /api/v1/chat-backups

**List chat backups**

Retrieves a paginated list of chat backups, optionally filtered by chatId.

*Requirement:* WA-BAK-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| chatId | query | string | False | Filter backups by chat identifier |
| page | query | integer | False | Page number for pagination |
| pageSize | query | integer | False | Number of items per page |

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `500`: Internal Server Error

---

#### `GET` /api/v1/chat-backups/{backupId}

**Get a chat backup**

Retrieves details for a specific chat backup.

*Requirement:* WA-BAK-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| backupId | path | string | True | Backup identifier |

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `404`: Not Found
- `500`: Internal Server Error

---

#### `DELETE` /api/v1/chat-backups/{backupId}

**Delete a chat backup**

Deletes a specific chat backup from the cloud.

*Requirement:* WA-BAK-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| backupId | path | string | True | Backup identifier |

**Responses:**

- `204`: No Content
- `401`: Unauthorized
- `404`: Not Found
- `500`: Internal Server Error

---

#### `POST` /api/v1/chat-backups/{backupId}/restore

**Restore a chat backup**

Initiates restoration of a specific chat backup into the user's account.

*Requirement:* WA-BAK-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| backupId | path | string | True | Backup identifier |

**Request Body:** `RestoreChatBackupRequest`

**Responses:**

- `202`: Accepted
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Not Found
- `500`: Internal Server Error

---

### ChatMessages

#### `POST` /api/v1/chats/{chatId}/messages/stickers

**Send a sticker message in a chat**

Creates a new chat message containing a sticker in the specified chat.

*Requirement:* WA-MED-005

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| chatId | path | string | True | Chat ID |

**Request Body:** `SendStickerMessageRequest`

**Responses:**

- `201`: Created
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Chat or sticker not found
- `422`: Unprocessable Entity

---

### ChatTransfers

#### `POST` /api/v1/chat-transfers

**Start chat history transfer**

Initiates a transfer session to export chat history from the current device and generates a transfer token.

*Requirement:* WA-BAK-004

**Request Body:** `CreateChatTransferRequest`

**Responses:**

- `201`: Created
- `400`: Bad Request
- `401`: Unauthorized
- `500`: Internal Server Error

---

#### `GET` /api/v1/chat-transfers/{transferId}

**Get chat transfer status**

Retrieves the status and metadata of a chat transfer session.

*Requirement:* WA-BAK-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| transferId | path | string | True | Transfer session identifier |

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `404`: Not Found
- `500`: Internal Server Error

---

#### `POST` /api/v1/chat-transfers/{transferId}/import

**Import chat history to new device**

Uses the transfer token to import chat history onto a new device.

*Requirement:* WA-BAK-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| transferId | path | string | True | Transfer session identifier |

**Request Body:** `ImportChatHistoryRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `403`: Forbidden
- `404`: Not Found
- `409`: Conflict
- `500`: Internal Server Error

---

### Chats

#### `POST` /api/v1/chats/{chatId}/lock

**Lock a chat**

Locks an individual chat. Requires additional authentication (e.g., password re-entry or MFA token) to confirm the lock action.

*Requirement:* WA-MSG-010

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| chatId | path | string | True | Chat ID |

**Request Body:** `LockChatRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `403`: Forbidden
- `404`: Not Found
- `409`: Conflict
- `422`: Unprocessable Entity

---

#### `POST` /api/v1/chats/{chatId}/gifs

**Send a GIF to a chat**

Send a selected GIF to a specified chat.

*Requirement:* WA-MED-006

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| chatId | path | string | True | Chat ID |

**Request Body:** `SendGifRequest`

**Responses:**

- `201`: Created
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Not Found
- `500`: Internal Server Error

---

#### `POST` /api/v1/chats/{chatId}/camera-sessions

**Create camera access session for a chat**

Creates a short-lived camera session to enable direct camera access within the chat and returns upload configuration for captured media.

*Requirement:* WA-MED-007

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| chatId | path | string | True | Chat ID |

**Request Body:** `CreateCameraSessionRequest`

**Responses:**

- `201`: Created
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Chat Not Found
- `429`: Too Many Requests

---

#### `POST` /api/v1/chats/{chatId}/messages

**Send a camera-captured media message**

Creates a chat message referencing the media uploaded via a camera session.

*Requirement:* WA-MED-007

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| chatId | path | string | True | Chat ID |

**Request Body:** `CreateChatMediaMessageRequest`

**Responses:**

- `201`: Created
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Chat Not Found
- `409`: Conflict
- `429`: Too Many Requests

---

#### `GET` /api/v1/chats/{chatId}/export

**Export a single chat**

Exports a single chat in the requested format and returns a downloadable file or export metadata.

*Requirement:* WA-BAK-003

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| chatId | path | string | True | Unique identifier of the chat to export |
| format | query | string | False | Export format (e.g., json, txt, pdf) |

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `403`: Forbidden
- `404`: Not Found
- `500`: Internal Server Error

---

#### `POST` /api/v1/chats/{chatId}/archive

**Archive chat**

Archives a chat so it is moved to the archived state and no longer appears in the active chat list.

*Requirement:* WA-BAK-005

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| chatId | path | string | True | Chat ID |

**Request Body:** `ArchiveChatRequest`

**Responses:**

- `200`: Archived Successfully
- `400`: Bad Request
- `401`: Unauthorized
- `403`: Forbidden
- `404`: Chat Not Found
- `409`: Conflict

---

#### `POST` /api/v1/chats/{chatId}/pin

**Pin a chat**

Marks a chat as pinned for the current user.

*Requirement:* WA-BAK-006

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| chatId | path | string | True | Chat ID |

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Chat Not Found
- `409`: Already Pinned

---

#### `DELETE` /api/v1/chats/{chatId}/pin

**Unpin a chat**

Removes the pinned status from a chat for the current user.

*Requirement:* WA-BAK-006

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| chatId | path | string | True | Chat ID |

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Chat Not Found
- `409`: Not Pinned

---

### Communities

#### `POST` /api/v1/communities

**Create community**

Creates a new community that can contain multiple groups.

*Requirement:* WA-GRP-006

**Request Body:** `CreateCommunityRequest`

**Responses:**

- `201`: Created
- `400`: Bad Request
- `401`: Unauthorized

---

#### `GET` /api/v1/communities

**List communities**

Retrieves a paginated list of communities.

*Requirement:* WA-GRP-006

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| page | query | integer | False | Page number (default 1) |
| pageSize | query | integer | False | Items per page (default 20) |

**Responses:**

- `200`: Success
- `401`: Unauthorized

---

#### `GET` /api/v1/communities/{communityId}

**Get community**

Retrieves a community by ID.

*Requirement:* WA-GRP-006

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| communityId | path | string | True | Community ID |

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `404`: Not Found

---

#### `PUT` /api/v1/communities/{communityId}

**Update community**

Updates community details.

*Requirement:* WA-GRP-006

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| communityId | path | string | True | Community ID |

**Request Body:** `UpdateCommunityRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Not Found

---

#### `DELETE` /api/v1/communities/{communityId}

**Delete community**

Deletes a community.

*Requirement:* WA-GRP-006

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| communityId | path | string | True | Community ID |

**Responses:**

- `204`: No Content
- `401`: Unauthorized
- `404`: Not Found

---

### ContactLabels

#### `GET` /api/v1/contact-labels

**List contact labels**

Retrieve a paginated list of contact labels available for business contacts.

*Requirement:* WA-CON-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| page | query | integer | False | Page number (1-based) |
| pageSize | query | integer | False | Number of items per page |
| search | query | string | False | Optional search term for label name |

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized

---

#### `POST` /api/v1/contact-labels

**Create a contact label**

Create a new label that can be applied to contacts.

*Requirement:* WA-CON-004

**Request Body:** `CreateContactLabelRequest`

**Responses:**

- `201`: Created
- `400`: Bad Request
- `401`: Unauthorized
- `409`: Conflict

---

#### `GET` /api/v1/contact-labels/{labelId}

**Get a contact label**

Retrieve a specific contact label by ID.

*Requirement:* WA-CON-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| labelId | path | string | True | Label ID |

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `404`: Not Found

---

#### `PUT` /api/v1/contact-labels/{labelId}

**Update a contact label**

Update the name or properties of an existing contact label.

*Requirement:* WA-CON-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| labelId | path | string | True | Label ID |

**Request Body:** `UpdateContactLabelRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Not Found
- `409`: Conflict

---

#### `DELETE` /api/v1/contact-labels/{labelId}

**Delete a contact label**

Remove a contact label from the system.

*Requirement:* WA-CON-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| labelId | path | string | True | Label ID |

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `404`: Not Found
- `409`: Conflict

---

#### `GET` /api/v1/contacts/{contactId}/labels

**List labels for a contact**

Retrieve a paginated list of labels assigned to a specific contact.

*Requirement:* WA-CON-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| contactId | path | string | True | Contact ID |
| page | query | integer | False | Page number (1-based) |
| pageSize | query | integer | False | Number of items per page |

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Not Found

---

#### `POST` /api/v1/contacts/{contactId}/labels

**Assign labels to a contact**

Assign one or more existing labels to a contact.

*Requirement:* WA-CON-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| contactId | path | string | True | Contact ID |

**Request Body:** `AssignContactLabelsRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Not Found

---

#### `DELETE` /api/v1/contacts/{contactId}/labels/{labelId}

**Remove a label from a contact**

Unassign a specific label from a contact.

*Requirement:* WA-CON-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| contactId | path | string | True | Contact ID |
| labelId | path | string | True | Label ID |

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `404`: Not Found

---

### Contacts

#### `POST` /api/v1/contacts/{contactId}/shares

**Share contact details**

Shares a contact's details with one or more recipients using specified channels.

*Requirement:* WA-MSG-015

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| contactId | path | string | True | Contact ID to be shared |

**Request Body:** `ShareContactRequest`

**Responses:**

- `201`: Created
- `400`: Bad Request
- `401`: Unauthorized
- `403`: Forbidden
- `404`: Not Found
- `500`: Internal Server Error

---

#### `GET` /api/v1/contacts/{contactId}/status

**Get contact status**

Retrieves the current status information for a specific contact.

*Requirement:* WA-STS-002

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| contactId | path | string | True | Unique identifier of the contact |

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Not Found
- `500`: Internal Server Error

---

#### `POST` /api/v1/contacts/{contactId}/status/mute

**Mute contact status**

Mutes the status of a contact to prevent status visibility or notifications as defined by the system.

*Requirement:* WA-STS-005

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| contactId | path | string | True | Contact ID |

**Request Body:** `MuteContactStatusRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Contact Not Found
- `409`: Conflict
- `500`: Internal Server Error

---

#### `POST` /api/v1/contacts/{contactId}/block

**Block a contact**

Blocks the specified contact for the authenticated user.

*Requirement:* WA-SEC-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| contactId | path | string | True | Contact ID to block |

**Request Body:** `BlockContactRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Contact Not Found
- `409`: Already Blocked

---

#### `POST` /api/v1/contacts/sync

**Synchronize device contacts with WhatsApp users**

Accepts a list of device contacts and returns which contacts are registered WhatsApp users along with optional matching metadata.

*Requirement:* WA-CON-001

**Request Body:** `ContactsSyncRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `413`: Payload Too Large
- `422`: Unprocessable Entity
- `500`: Internal Server Error

---

#### `POST` /api/v1/contacts

**Create a contact**

Creates a new contact manually.

*Requirement:* WA-CON-002

**Request Body:** `CreateContactRequest`

**Responses:**

- `201`: Created
- `400`: Bad Request
- `401`: Unauthorized
- `409`: Conflict
- `500`: Internal Server Error

---

#### `POST` /api/v1/contacts/import

**Bulk import contacts**

Adds multiple contacts in bulk from provided data.

*Requirement:* WA-CON-002

**Request Body:** `ImportContactsRequest`

**Responses:**

- `202`: Accepted
- `400`: Bad Request
- `401`: Unauthorized
- `413`: Payload Too Large
- `500`: Internal Server Error

---

#### `GET` /api/v1/contacts/{contactId}/labels

**List labels for a contact**

Retrieve a paginated list of labels assigned to a specific contact.

*Requirement:* WA-CON-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| contactId | path | string | True | Contact ID |
| page | query | integer | False | Page number (1-based) |
| pageSize | query | integer | False | Number of items per page |

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Not Found

---

#### `POST` /api/v1/contacts/{contactId}/labels

**Assign labels to a contact**

Assign one or more existing labels to a contact.

*Requirement:* WA-CON-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| contactId | path | string | True | Contact ID |

**Request Body:** `AssignContactLabelsRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Not Found

---

#### `DELETE` /api/v1/contacts/{contactId}/labels/{labelId}

**Remove a label from a contact**

Unassign a specific label from a contact.

*Requirement:* WA-CON-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| contactId | path | string | True | Contact ID |
| labelId | path | string | True | Label ID |

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `404`: Not Found

---

#### `POST` /api/v1/contacts/{contactId}/greetings

**Send automatic greeting on first contact**

Triggers an automatic greeting for the specified contact if this is the first contact; subsequent calls return a no-op status.

*Requirement:* WA-BUS-005

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| contactId | path | string | True | Contact ID |

**Request Body:** `FirstContactGreetingRequest`

**Responses:**

- `201`: Created
- `200`: Already Greeted
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Contact Not Found
- `500`: Internal Server Error

---

### DataUsage

#### `GET` /api/v1/data-usage

**Get current data usage**

Retrieves the current data consumption for the authenticated tenant/user.

*Requirement:* WA-SET-007

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `500`: Internal Server Error

---

#### `GET` /api/v1/data-usage/history

**List historical data usage**

Lists historical data usage entries with pagination.

*Requirement:* WA-SET-007

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| page | query | integer | False | Page number (starting at 1) |
| pageSize | query | integer | False | Number of items per page |
| from | query | string | False | ISO-8601 start datetime filter |
| to | query | string | False | ISO-8601 end datetime filter |

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `500`: Internal Server Error

---

#### `PUT` /api/v1/data-usage/limits

**Set data usage limits**

Configures limits and thresholds to control data consumption.

*Requirement:* WA-SET-007

**Request Body:** `DataUsageLimitsRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `409`: Conflict
- `500`: Internal Server Error

---

### DesktopApps

#### `GET` /api/v1/desktop-apps

**List available desktop apps**

Returns a paginated list of native desktop applications available for download, including supported OS and versions.

*Requirement:* WA-INT-005

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| page | query | integer | False | Page number for pagination |
| pageSize | query | integer | False | Number of items per page |
| platform | query | string | False | Filter by platform (e.g., windows, macos, linux) |

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `500`: Internal Server Error

---

#### `GET` /api/v1/desktop-apps/{id}

**Get desktop app details**

Returns detailed information for a specific native desktop application.

*Requirement:* WA-INT-005

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| id | path | string | True | Desktop app ID |

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Not Found
- `500`: Internal Server Error

---

### Devices

#### `POST` /api/v1/devices

**Register a device for push notifications**

Registers a client device and its push token to enable reliable delivery.

*Requirement:* WA-NOT-001

**Request Body:** `RegisterDeviceRequest`

**Responses:**

- `201`: Created
- `400`: Bad Request
- `401`: Unauthorized
- `409`: Conflict
- `500`: Internal Server Error

---

#### `PUT` /api/v1/devices/{id}

**Update a device push token**

Updates device registration to maintain reliable delivery.

*Requirement:* WA-NOT-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| id | path | string | True | Device registration ID |

**Request Body:** `UpdateDeviceRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Not Found
- `500`: Internal Server Error

---

### DoNotDisturb

#### `GET` /api/v1/users/{userId}/do-not-disturb

**Get do-not-disturb mode**

Retrieves the current do-not-disturb status for a user.

*Requirement:* WA-NOT-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `404`: Not Found

---

#### `PUT` /api/v1/users/{userId}/do-not-disturb

**Update do-not-disturb mode**

Enables or disables do-not-disturb mode for a user.

*Requirement:* WA-NOT-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Request Body:** `UpdateDoNotDisturbRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Not Found

---

### Documents

#### `POST` /api/v1/documents

**Send a document**

Sends an arbitrary document to a specified recipient. Supports binary content via base64 encoding or multipart upload abstraction.

*Requirement:* WA-MED-003

**Request Body:** `SendDocumentRequest`

**Responses:**

- `201`: Created
- `400`: Bad Request
- `401`: Unauthorized
- `413`: Payload Too Large
- `415`: Unsupported Media Type
- `500`: Internal Server Error

---

### EncryptionVerification

#### `POST` /api/v1/encryption-verifications

**Manuelle Verifizierung der Verschlüsselung durchführen**

Ermöglicht eine manuelle Prüfung/Verifizierung eines Verschlüsselungscodes und speichert das Ergebnis.

*Requirement:* WA-SEC-002

**Request Body:** `CreateEncryptionVerificationRequest`

**Responses:**

- `201`: Created
- `400`: Bad Request
- `401`: Unauthorized
- `409`: Conflict
- `500`: Internal Server Error

---

### Favorites

#### `GET` /api/v1/favorites

**List favorite contacts**

Retrieves a paginated list of favorite contacts for the authenticated user.

*Requirement:* WA-CON-003

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| page | query | integer | False | Page number (starting at 1) |
| pageSize | query | integer | False | Number of items per page |

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized

---

#### `POST` /api/v1/contacts/{contactId}/favorite

**Add contact to favorites**

Marks the specified contact as a favorite for the authenticated user.

*Requirement:* WA-CON-003

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| contactId | path | string | True | Contact ID |

**Responses:**

- `201`: Created
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Not Found
- `409`: Conflict

---

#### `DELETE` /api/v1/contacts/{contactId}/favorite

**Remove contact from favorites**

Unmarks the specified contact as a favorite for the authenticated user.

*Requirement:* WA-CON-003

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| contactId | path | string | True | Contact ID |

**Responses:**

- `204`: No Content
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Not Found

---

### Gallery

#### `GET` /api/v1/gallery/items

**List gallery items**

Retrieves a paginated list of media items available from the device gallery.

*Requirement:* WA-MED-009

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| page | query | integer | False | Page number (starting at 1) |
| pageSize | query | integer | False | Number of items per page |
| mediaType | query | string | False | Filter by media type (e.g., image, video) |

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `500`: Internal Server Error

---

#### `GET` /api/v1/gallery/items/{id}

**Get gallery item details**

Retrieves metadata for a single gallery item by ID.

*Requirement:* WA-MED-009

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| id | path | string | True | Gallery item ID |

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Not Found
- `500`: Internal Server Error

---

#### `GET` /api/v1/gallery/items/{id}/content

**Get gallery item content**

Retrieves the binary content of a gallery item by ID.

*Requirement:* WA-MED-009

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| id | path | string | True | Gallery item ID |

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `404`: Not Found
- `416`: Range Not Satisfiable
- `500`: Internal Server Error

---

### Gifs

#### `GET` /api/v1/gifs

**Search GIFs**

Search for GIFs by query term with pagination support.

*Requirement:* WA-MED-006

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| q | query | string | True | Search query term |
| page | query | integer | False | Page number for pagination |
| pageSize | query | integer | False | Number of items per page |

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `500`: Internal Server Error

---

#### `POST` /api/v1/chats/{chatId}/gifs

**Send a GIF to a chat**

Send a selected GIF to a specified chat.

*Requirement:* WA-MED-006

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| chatId | path | string | True | Chat ID |

**Request Body:** `SendGifRequest`

**Responses:**

- `201`: Created
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Not Found
- `500`: Internal Server Error

---

### Greetings

#### `GET` /api/v1/greeting-settings

**Get greeting configuration**

Retrieves the current automatic greeting configuration used for first-contact greetings.

*Requirement:* WA-BUS-005

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `404`: Not Found
- `500`: Internal Server Error

---

#### `PUT` /api/v1/greeting-settings

**Update greeting configuration**

Updates the automatic greeting configuration for first-contact greetings.

*Requirement:* WA-BUS-005

**Request Body:** `GreetingSettingsRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `500`: Internal Server Error

---

#### `POST` /api/v1/contacts/{contactId}/greetings

**Send automatic greeting on first contact**

Triggers an automatic greeting for the specified contact if this is the first contact; subsequent calls return a no-op status.

*Requirement:* WA-BUS-005

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| contactId | path | string | True | Contact ID |

**Request Body:** `FirstContactGreetingRequest`

**Responses:**

- `201`: Created
- `200`: Already Greeted
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Contact Not Found
- `500`: Internal Server Error

---

### GroupCalls

#### `POST` /api/v1/group-calls

**Create group call**

Create a new group voice/video call session.

*Requirement:* WA-CALL-003

**Request Body:** `CreateGroupCallRequest`

**Responses:**

- `201`: Created
- `400`: Bad Request
- `401`: Unauthorized
- `409`: Conflict
- `500`: Internal Server Error

---

#### `GET` /api/v1/group-calls

**List group calls**

Retrieve a paginated list of group calls.

*Requirement:* WA-CALL-003

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| page | query | integer | False | Page number (default 1) |
| pageSize | query | integer | False | Items per page (default 20) |
| status | query | string | False | Filter by call status |

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `500`: Internal Server Error

---

#### `GET` /api/v1/group-calls/{callId}

**Get group call**

Retrieve details of a specific group call.

*Requirement:* WA-CALL-003

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| callId | path | string | True | Group call ID |

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `404`: Not Found
- `500`: Internal Server Error

---

#### `POST` /api/v1/group-calls/{callId}/participants

**Add participants**

Add one or more participants to a group call.

*Requirement:* WA-CALL-003

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| callId | path | string | True | Group call ID |

**Request Body:** `AddParticipantsRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Not Found
- `409`: Conflict
- `500`: Internal Server Error

---

#### `DELETE` /api/v1/group-calls/{callId}/participants/{participantId}

**Remove participant**

Remove a participant from a group call.

*Requirement:* WA-CALL-003

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| callId | path | string | True | Group call ID |
| participantId | path | string | True | Participant user ID |

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `404`: Not Found
- `500`: Internal Server Error

---

#### `POST` /api/v1/group-calls/{callId}/end

**End group call**

End an active group call.

*Requirement:* WA-CALL-003

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| callId | path | string | True | Group call ID |

**Request Body:** `EndGroupCallRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Not Found
- `409`: Conflict
- `500`: Internal Server Error

---

### GroupChats

#### `POST` /api/v1/group-chats/{groupChatId}/messages

**Create message with @mentions in a group chat**

Creates a new message in the specified group chat and supports @-mentions by providing a list of mentioned user IDs.

*Requirement:* WA-MSG-013

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| groupChatId | path | string | True | Group chat ID |

**Request Body:** `CreateGroupChatMessageRequest`

**Responses:**

- `201`: Created
- `400`: Bad Request
- `401`: Unauthorized
- `403`: Forbidden
- `404`: Group Chat Not Found
- `422`: Unprocessable Entity

---

### GroupEvents

#### `POST` /api/v1/groups/{groupId}/events

**Create group event**

Plan a new event within a specific group.

*Requirement:* WA-GRP-009

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| groupId | path | string | True | Group ID |

**Request Body:** `CreateGroupEventRequest`

**Responses:**

- `201`: Created
- `400`: Bad Request
- `401`: Unauthorized
- `403`: Forbidden
- `404`: Group Not Found

---

#### `GET` /api/v1/groups/{groupId}/events

**List group events**

Retrieve a paginated list of events for a specific group.

*Requirement:* WA-GRP-009

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| groupId | path | string | True | Group ID |
| page | query | integer | False | Page number for pagination |
| pageSize | query | integer | False | Page size for pagination |

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `403`: Forbidden
- `404`: Group Not Found

---

#### `GET` /api/v1/groups/{groupId}/events/{eventId}

**Get group event**

Retrieve details of a specific event within a group.

*Requirement:* WA-GRP-009

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| groupId | path | string | True | Group ID |
| eventId | path | string | True | Event ID |

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `403`: Forbidden
- `404`: Event Not Found

---

#### `PUT` /api/v1/groups/{groupId}/events/{eventId}

**Update group event**

Update details of a specific event within a group.

*Requirement:* WA-GRP-009

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| groupId | path | string | True | Group ID |
| eventId | path | string | True | Event ID |

**Request Body:** `UpdateGroupEventRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `403`: Forbidden
- `404`: Event Not Found

---

#### `DELETE` /api/v1/groups/{groupId}/events/{eventId}

**Delete group event**

Remove a specific event from a group.

*Requirement:* WA-GRP-009

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| groupId | path | string | True | Group ID |
| eventId | path | string | True | Event ID |

**Responses:**

- `204`: No Content
- `401`: Unauthorized
- `403`: Forbidden
- `404`: Event Not Found

---

### GroupInvites

#### `POST` /api/v1/groups/{groupId}/invite-links

**Create group invite link**

Generates a new invitation link for a group that can be shared with others.

*Requirement:* WA-GRP-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| groupId | path | string | True | Group ID |

**Request Body:** `CreateGroupInviteLinkRequest`

**Responses:**

- `201`: Created
- `400`: Bad Request
- `401`: Unauthorized
- `403`: Forbidden
- `404`: Group Not Found

---

#### `GET` /api/v1/invite-links/{token}

**Get invite link details**

Retrieves information about an invitation link by token, including group details and validity.

*Requirement:* WA-GRP-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| token | path | string | True | Invite link token |

**Responses:**

- `200`: Success
- `404`: Invite Link Not Found
- `410`: Invite Link Expired

---

#### `POST` /api/v1/invite-links/{token}/accept

**Accept invite link**

Accepts an invitation link and adds the authenticated user to the group.

*Requirement:* WA-GRP-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| token | path | string | True | Invite link token |

**Request Body:** `AcceptInviteLinkRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Invite Link Not Found
- `409`: Already a Member
- `410`: Invite Link Expired

---

### Groups

#### `POST` /api/v1/groups

**Create group chat**

Creates a new group chat with the specified name and initial members.

*Requirement:* WA-GRP-001

**Request Body:** `CreateGroupRequest`

**Responses:**

- `201`: Created
- `400`: Bad Request
- `401`: Unauthorized
- `409`: Conflict
- `500`: Internal Server Error

---

#### `GET` /api/v1/groups/{groupId}/settings

**Get group settings**

Retrieves the configurable settings for a specific group.

*Requirement:* WA-GRP-003

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| groupId | path | string | True | Group ID |

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Group Not Found
- `500`: Internal Server Error

---

#### `PUT` /api/v1/groups/{groupId}/settings

**Replace group settings**

Replaces the configurable settings for a specific group.

*Requirement:* WA-GRP-003

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| groupId | path | string | True | Group ID |

**Request Body:** `ReplaceGroupSettingsRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Group Not Found
- `409`: Conflict
- `500`: Internal Server Error

---

#### `PATCH` /api/v1/groups/{groupId}/settings

**Update group settings**

Partially updates configurable settings for a specific group.

*Requirement:* WA-GRP-003

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| groupId | path | string | True | Group ID |

**Request Body:** `UpdateGroupSettingsRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Group Not Found
- `409`: Conflict
- `500`: Internal Server Error

---

#### `DELETE` /api/v1/groups/{groupId}/memberships/me

**Leave group**

Removes the authenticated user from the specified group without sending any notifications.

*Requirement:* WA-GRP-005

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| groupId | path | string | True | Group ID |

**Responses:**

- `204`: No Content
- `400`: Bad Request
- `401`: Unauthorized
- `403`: Forbidden
- `404`: Group or membership not found
- `409`: Conflict
- `500`: Internal Server Error

---

#### `POST` /api/v1/communities/{communityId}/groups

**Create group in community**

Creates a new group within a community.

*Requirement:* WA-GRP-006

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| communityId | path | string | True | Community ID |

**Request Body:** `CreateGroupRequest`

**Responses:**

- `201`: Created
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Not Found

---

#### `GET` /api/v1/communities/{communityId}/groups

**List groups in community**

Retrieves a paginated list of groups in a community.

*Requirement:* WA-GRP-006

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| communityId | path | string | True | Community ID |
| page | query | integer | False | Page number (default 1) |
| pageSize | query | integer | False | Items per page (default 20) |

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `404`: Not Found

---

#### `DELETE` /api/v1/communities/{communityId}/groups/{groupId}

**Remove group from community**

Deletes a group within a community.

*Requirement:* WA-GRP-006

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| communityId | path | string | True | Community ID |
| groupId | path | string | True | Group ID |

**Responses:**

- `204`: No Content
- `401`: Unauthorized
- `404`: Not Found

---

#### `GET` /api/v1/groups/{groupId}/invitation-policy

**Get group invitation policy**

Retrieves the current configuration that defines who is allowed to add members to the group.

*Requirement:* WA-SET-005

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| groupId | path | string | True | Group ID |

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `403`: Forbidden
- `404`: Not Found
- `500`: Internal Server Error

---

#### `PUT` /api/v1/groups/{groupId}/invitation-policy

**Update group invitation policy**

Configures who is allowed to add members to the group.

*Requirement:* WA-SET-005

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| groupId | path | string | True | Group ID |

**Request Body:** `UpdateGroupInvitationPolicyRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `403`: Forbidden
- `404`: Not Found
- `422`: Unprocessable Entity
- `500`: Internal Server Error

---

#### `GET` /api/v1/groups/{groupId}/invitation-policy/allowed-users

**List allowed users for group invitations**

Lists users explicitly allowed to add members to the group when policyType is custom.

*Requirement:* WA-SET-005

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| groupId | path | string | True | Group ID |
| page | query | integer | False | Page number |
| pageSize | query | integer | False | Number of items per page |

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `403`: Forbidden
- `404`: Not Found
- `500`: Internal Server Error

---

#### `POST` /api/v1/groups/{groupId}/invitation-policy/allowed-users

**Add allowed users for group invitations**

Adds users explicitly allowed to add members to the group when policyType is custom.

*Requirement:* WA-SET-005

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| groupId | path | string | True | Group ID |

**Request Body:** `AddAllowedUsersRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `403`: Forbidden
- `404`: Not Found
- `409`: Conflict
- `500`: Internal Server Error

---

#### `DELETE` /api/v1/groups/{groupId}/invitation-policy/allowed-users/{userId}

**Remove allowed user for group invitations**

Removes a user from the explicit allow list for adding members to the group.

*Requirement:* WA-SET-005

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| groupId | path | string | True | Group ID |
| userId | path | string | True | User ID |

**Responses:**

- `204`: No Content
- `401`: Unauthorized
- `403`: Forbidden
- `404`: Not Found
- `500`: Internal Server Error

---

### Images

#### `POST` /api/v1/images

**Send an image**

Uploads and sends an image to the system. Supports multipart form data with image file and optional metadata.

*Requirement:* WA-MED-001

**Request Body:** `SendImageRequest`

**Responses:**

- `201`: Created
- `400`: Bad Request
- `401`: Unauthorized
- `413`: Payload Too Large
- `415`: Unsupported Media Type
- `500`: Internal Server Error

---

#### `POST` /api/v1/images/{imageId}/edits

**Apply basic edits to an image before sending**

Creates an edited version of the specified image using basic operations such as crop, rotate, resize, and filter adjustments prior to sending.

*Requirement:* WA-MED-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| imageId | path | string | True | ID of the source image to edit |

**Request Body:** `CreateImageEditRequest`

**Responses:**

- `201`: Created
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Image Not Found
- `422`: Unprocessable Entity

---

### InfoVisibility

#### `GET` /api/v1/info-visibility-settings

**Get info/status text visibility settings**

Retrieves the current configuration that controls visibility of info and status texts.

*Requirement:* WA-SET-004

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `403`: Forbidden
- `500`: Internal Server Error

---

#### `PUT` /api/v1/info-visibility-settings

**Update info/status text visibility settings**

Updates the configuration that controls visibility of info and status texts.

*Requirement:* WA-SET-004

**Request Body:** `UpdateInfoVisibilitySettingsRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `403`: Forbidden
- `409`: Conflict
- `500`: Internal Server Error

---

### Integrations

#### `GET` /api/v1/integrations

**List integration API clients**

Returns a paginated list of API clients for business integrations.

*Requirement:* WA-BUS-010

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| page | query | integer | False | Page number (starting at 1) |
| pageSize | query | integer | False | Number of items per page |

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `500`: Internal Server Error

---

#### `POST` /api/v1/integrations

**Create integration API client**

Creates a new API client for business integrations and returns credentials.

*Requirement:* WA-BUS-010

**Request Body:** `CreateIntegrationRequest`

**Responses:**

- `201`: Created
- `400`: Bad Request
- `401`: Unauthorized
- `409`: Conflict
- `500`: Internal Server Error

---

#### `GET` /api/v1/integrations/{integrationId}

**Get integration API client**

Retrieves details of a specific integration API client.

*Requirement:* WA-BUS-010

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| integrationId | path | string | True | Integration client ID |

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `404`: Not Found
- `500`: Internal Server Error

---

#### `PUT` /api/v1/integrations/{integrationId}

**Update integration API client**

Updates metadata or scopes for an existing integration API client.

*Requirement:* WA-BUS-010

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| integrationId | path | string | True | Integration client ID |

**Request Body:** `UpdateIntegrationRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Not Found
- `500`: Internal Server Error

---

#### `DELETE` /api/v1/integrations/{integrationId}

**Delete integration API client**

Revokes and deletes an integration API client.

*Requirement:* WA-BUS-010

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| integrationId | path | string | True | Integration client ID |

**Responses:**

- `204`: No Content
- `401`: Unauthorized
- `404`: Not Found
- `500`: Internal Server Error

---

### Invitations

#### `GET` /api/v1/groups/{groupId}/invitation-policy

**Get group invitation policy**

Retrieves the current configuration that defines who is allowed to add members to the group.

*Requirement:* WA-SET-005

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| groupId | path | string | True | Group ID |

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `403`: Forbidden
- `404`: Not Found
- `500`: Internal Server Error

---

#### `PUT` /api/v1/groups/{groupId}/invitation-policy

**Update group invitation policy**

Configures who is allowed to add members to the group.

*Requirement:* WA-SET-005

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| groupId | path | string | True | Group ID |

**Request Body:** `UpdateGroupInvitationPolicyRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `403`: Forbidden
- `404`: Not Found
- `422`: Unprocessable Entity
- `500`: Internal Server Error

---

#### `GET` /api/v1/groups/{groupId}/invitation-policy/allowed-users

**List allowed users for group invitations**

Lists users explicitly allowed to add members to the group when policyType is custom.

*Requirement:* WA-SET-005

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| groupId | path | string | True | Group ID |
| page | query | integer | False | Page number |
| pageSize | query | integer | False | Number of items per page |

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `403`: Forbidden
- `404`: Not Found
- `500`: Internal Server Error

---

#### `POST` /api/v1/groups/{groupId}/invitation-policy/allowed-users

**Add allowed users for group invitations**

Adds users explicitly allowed to add members to the group when policyType is custom.

*Requirement:* WA-SET-005

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| groupId | path | string | True | Group ID |

**Request Body:** `AddAllowedUsersRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `403`: Forbidden
- `404`: Not Found
- `409`: Conflict
- `500`: Internal Server Error

---

#### `DELETE` /api/v1/groups/{groupId}/invitation-policy/allowed-users/{userId}

**Remove allowed user for group invitations**

Removes a user from the explicit allow list for adding members to the group.

*Requirement:* WA-SET-005

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| groupId | path | string | True | Group ID |
| userId | path | string | True | User ID |

**Responses:**

- `204`: No Content
- `401`: Unauthorized
- `403`: Forbidden
- `404`: Not Found
- `500`: Internal Server Error

---

### Keys

#### `POST` /api/v1/keys

**Register public key**

Registers or updates the user's public key used for end-to-end encryption.

*Requirement:* WA-SEC-001

**Request Body:** `RegisterPublicKeyRequest`

**Responses:**

- `201`: Created
- `400`: Bad Request
- `401`: Unauthorized
- `409`: Conflict

---

#### `GET` /api/v1/keys/{userId}

**Get public key**

Retrieves the public key for a given user to enable end-to-end encryption.

*Requirement:* WA-SEC-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User identifier |

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `404`: Not Found

---

### Languages

#### `GET` /api/v1/languages

**List supported languages**

Returns a paginated list of languages supported by the system.

*Requirement:* WA-SET-010

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| page | query | integer | False | Page number (starting from 1) |
| pageSize | query | integer | False | Number of items per page |

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized

---

#### `GET` /api/v1/users/{userId}/language

**Get user language preference**

Returns the current language preference for the specified user.

*Requirement:* WA-SET-010

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Not Found

---

#### `PUT` /api/v1/users/{userId}/language

**Update user language preference**

Sets or updates the language preference for the specified user.

*Requirement:* WA-SET-010

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Request Body:** `UpdateUserLanguageRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Not Found
- `409`: Conflict

---

### Localization

#### `GET` /api/v1/locales

**List supported locales**

Returns the list of supported locales and their text direction (LTR/RTL).

*Requirement:* WA-LOC-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| page | query | integer | False | Page number for pagination |
| pageSize | query | integer | False | Number of items per page |

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `500`: Internal Server Error

---

#### `GET` /api/v1/users/{userId}/preferences/locale

**Get user locale preference**

Retrieves the user's locale and text direction to ensure RTL support where applicable.

*Requirement:* WA-LOC-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `404`: Not Found
- `500`: Internal Server Error

---

#### `PUT` /api/v1/users/{userId}/preferences/locale

**Update user locale preference**

Sets the user's locale preference to ensure correct RTL/LTR rendering.

*Requirement:* WA-LOC-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Request Body:** `UpdateUserLocalePreferenceRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Not Found
- `409`: Conflict
- `500`: Internal Server Error

---

### LocationShares

#### `POST` /api/v1/location-shares

**Share a location**

Creates a new location share so a user's location can be shared with specified recipients.

*Requirement:* WA-MSG-014

**Request Body:** `CreateLocationShareRequest`

**Responses:**

- `201`: Created
- `400`: Bad Request
- `401`: Unauthorized
- `403`: Forbidden
- `404`: Not Found
- `409`: Conflict
- `422`: Unprocessable Entity
- `500`: Internal Server Error

---

### Markets

#### `GET` /api/v1/markets

**List supported payment markets**

Retrieve markets where WhatsApp Pay is available.

*Requirement:* WA-BUS-008

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| feature | query | string | False | Filter by feature, e.g., whatsappPay |
| page | query | integer | False | Page number |
| pageSize | query | integer | False | Number of items per page |

**Responses:**

- `200`: Success
- `401`: Unauthorized

---

### Media

#### `POST` /api/v1/media

**Create media with optional view-once behavior**

Uploads media and optionally marks it as view-once. Returns media metadata and access information.

*Requirement:* WA-MSG-009

**Request Body:** `CreateMediaRequest`

**Responses:**

- `201`: Created
- `400`: Bad Request
- `401`: Unauthorized
- `413`: Payload Too Large
- `500`: Internal Server Error

---

#### `GET` /api/v1/media/{mediaId}/view

**View media content (consumes view-once)**

Retrieves media content. For view-once media, the first successful retrieval consumes access; subsequent requests return 410 Gone.

*Requirement:* WA-MSG-009

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| mediaId | path | string | True | Media ID |

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `404`: Not Found
- `410`: Gone (view-once already consumed)
- `500`: Internal Server Error

---

#### `GET` /api/v1/media/{mediaId}

**Get media metadata**

Retrieves metadata for media including view-once status and whether it has been viewed.

*Requirement:* WA-MSG-009

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| mediaId | path | string | True | Media ID |

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `404`: Not Found
- `500`: Internal Server Error

---

#### `POST` /api/v1/media

**Upload media in HD quality**

Creates a new media resource and uploads the media payload with HD quality settings.

*Requirement:* WA-MED-010

**Request Body:** `CreateMediaRequest`

**Responses:**

- `201`: Created
- `400`: Bad Request
- `401`: Unauthorized
- `415`: Unsupported Media Type
- `422`: Unprocessable Entity

---

#### `GET` /api/v1/media/{mediaId}

**Get media details**

Retrieves metadata for a media resource including quality information.

*Requirement:* WA-MED-010

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| mediaId | path | string | True | Media ID |

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `404`: Not Found

---

#### `GET` /api/v1/media

**Search media with filters**

Retrieves a paginated list of media items, supporting filtering by media types.

*Requirement:* WA-SRC-002

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| type | query | array | False | Filter by one or more media types (e.g., image, video, audio, document) |
| page | query | integer | False | Page number (starting from 1) |
| pageSize | query | integer | False | Number of items per page |

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `403`: Forbidden
- `500`: Internal Server Error

---

### Memberships

#### `DELETE` /api/v1/groups/{groupId}/memberships/me

**Leave group**

Removes the authenticated user from the specified group without sending any notifications.

*Requirement:* WA-GRP-005

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| groupId | path | string | True | Group ID |

**Responses:**

- `204`: No Content
- `400`: Bad Request
- `401`: Unauthorized
- `403`: Forbidden
- `404`: Group or membership not found
- `409`: Conflict
- `500`: Internal Server Error

---

### Mentions

#### `GET` /api/v1/users/{userId}/mentions

**List mentions for a user**

Returns a paginated list of messages in which the user was mentioned.

*Requirement:* WA-MSG-013

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |
| page | query | integer | False | Page number (starting at 1) |
| pageSize | query | integer | False | Number of items per page |

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `403`: Forbidden
- `404`: User Not Found

---

### Messages

#### `POST` /api/v1/messages

**Send a text message**

Sends a text message in real time to a recipient or conversation.

*Requirement:* WA-MSG-001

**Request Body:** `SendMessageRequest`

**Responses:**

- `201`: Created
- `400`: Bad Request
- `401`: Unauthorized
- `403`: Forbidden
- `409`: Conflict
- `500`: Internal Server Error

---

#### `POST` /api/v1/conversations/{conversationId}/messages

**Send voice message**

Creates a new voice message in the specified conversation.

*Requirement:* WA-MSG-002

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| conversationId | path | string | True | Conversation ID |

**Request Body:** `SendVoiceMessageRequest`

**Responses:**

- `201`: Created
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Conversation Not Found
- `415`: Unsupported Media Type
- `422`: Unprocessable Entity

---

#### `DELETE` /api/v1/messages/{messageId}

**Delete a message**

Deletes an existing message identified by its ID.

*Requirement:* WA-MSG-003

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| messageId | path | string | True | Unique identifier of the message to delete |

**Responses:**

- `204`: No Content
- `400`: Bad Request
- `401`: Unauthorized
- `403`: Forbidden
- `404`: Not Found
- `409`: Conflict
- `500`: Internal Server Error

---

#### `PUT` /api/v1/messages/{messageId}

**Edit a sent message**

Updates the content of a previously sent message identified by messageId.

*Requirement:* WA-MSG-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| messageId | path | string | True | Message ID |

**Request Body:** `UpdateMessageRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `403`: Forbidden
- `404`: Not Found
- `409`: Conflict
- `422`: Unprocessable Entity

---

#### `POST` /api/v1/messages/{messageId}/forward

**Forward a message**

Forwards an existing message to one or more recipients.

*Requirement:* WA-MSG-005

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| messageId | path | string | True | ID of the message to forward |

**Request Body:** `ForwardMessageRequest`

**Responses:**

- `201`: Created
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Not Found
- `422`: Unprocessable Entity

---

#### `POST` /api/v1/messages/{messageId}/replies

**Reply to a specific message**

Creates a new message that replies to (quotes) an existing message.

*Requirement:* WA-MSG-006

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| messageId | path | string | True | ID of the message being quoted/replied to |

**Request Body:** `CreateMessageReplyRequest`

**Responses:**

- `201`: Created
- `400`: Bad Request
- `401`: Unauthorized
- `403`: Forbidden
- `404`: Message Not Found
- `409`: Conflict
- `500`: Internal Server Error

---

#### `POST` /api/v1/messages

**Create a self-destructing message**

Creates a new message with an expiration time or time-to-live after which the system automatically deletes it.

*Requirement:* WA-MSG-008

**Request Body:** `CreateMessageRequest`

**Responses:**

- `201`: Created
- `400`: Bad Request
- `401`: Unauthorized
- `422`: Unprocessable Entity

---

#### `GET` /api/v1/messages/{messageId}

**Retrieve a message**

Retrieves a message if it has not expired. Reading the message can optionally trigger immediate deletion.

*Requirement:* WA-MSG-008

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| messageId | path | string | True | Message ID |
| deleteOnRead | query | boolean | False | If true, deletes the message after successful retrieval |

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `404`: Not Found
- `410`: Gone

---

#### `GET` /api/v1/messages

**List messages**

Lists messages visible to the requester, excluding expired messages by default.

*Requirement:* WA-MSG-008

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| page | query | integer | False | Page number |
| pageSize | query | integer | False | Number of items per page |
| includeExpired | query | boolean | False | Include expired messages if true |

**Responses:**

- `200`: Success
- `401`: Unauthorized

---

#### `DELETE` /api/v1/messages/{messageId}

**Delete a message**

Deletes a message immediately before its expiration.

*Requirement:* WA-MSG-008

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| messageId | path | string | True | Message ID |

**Responses:**

- `204`: No Content
- `401`: Unauthorized
- `404`: Not Found

---

#### `POST` /api/v1/messages

**Create a message with formatted text**

Creates a new message supporting basic text formatting (e.g., markdown).

*Requirement:* WA-MSG-012

**Request Body:** `CreateMessageRequest`

**Responses:**

- `201`: Created
- `400`: Bad Request
- `401`: Unauthorized
- `415`: Unsupported Media Type

---

#### `PUT` /api/v1/messages/{id}

**Update message formatted text**

Updates an existing message and its basic text formatting.

*Requirement:* WA-MSG-012

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| id | path | string | True | Message ID |

**Request Body:** `UpdateMessageRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Not Found
- `415`: Unsupported Media Type

---

#### `GET` /api/v1/messages/{id}

**Get message with formatted text**

Retrieves a message and its formatting metadata.

*Requirement:* WA-MSG-012

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| id | path | string | True | Message ID |

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `404`: Not Found

---

#### `POST` /api/v1/group-chats/{groupChatId}/messages

**Create message with @mentions in a group chat**

Creates a new message in the specified group chat and supports @-mentions by providing a list of mentioned user IDs.

*Requirement:* WA-MSG-013

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| groupChatId | path | string | True | Group chat ID |

**Request Body:** `CreateGroupChatMessageRequest`

**Responses:**

- `201`: Created
- `400`: Bad Request
- `401`: Unauthorized
- `403`: Forbidden
- `404`: Group Chat Not Found
- `422`: Unprocessable Entity

---

#### `POST` /api/v1/messages/videos

**Send a video message**

Sends a video message to one or more recipients.

*Requirement:* WA-MED-002

**Request Body:** `SendVideoMessageRequest`

**Responses:**

- `201`: Created
- `400`: Bad Request
- `401`: Unauthorized
- `403`: Forbidden
- `404`: Not Found
- `413`: Payload Too Large
- `415`: Unsupported Media Type
- `500`: Internal Server Error

---

#### `POST` /api/v1/chats/{chatId}/messages

**Send a camera-captured media message**

Creates a chat message referencing the media uploaded via a camera session.

*Requirement:* WA-MED-007

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| chatId | path | string | True | Chat ID |

**Request Body:** `CreateChatMediaMessageRequest`

**Responses:**

- `201`: Created
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Chat Not Found
- `409`: Conflict
- `429`: Too Many Requests

---

#### `POST` /api/v1/messages

**Send encrypted message**

Sends an end-to-end encrypted message. The server stores only encrypted payload and metadata.

*Requirement:* WA-SEC-001

**Request Body:** `SendEncryptedMessageRequest`

**Responses:**

- `201`: Created
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Not Found

---

#### `GET` /api/v1/messages

**List encrypted messages**

Lists encrypted messages for a user. Only metadata and encrypted payload are returned.

*Requirement:* WA-SEC-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | query | string | True | User identifier |
| page | query | integer | False | Page number |
| pageSize | query | integer | False | Number of items per page |

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized

---

#### `GET` /api/v1/messages/{messageId}

**Get encrypted message**

Retrieves a single encrypted message payload and metadata.

*Requirement:* WA-SEC-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| messageId | path | string | True | Message identifier |

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `404`: Not Found

---

#### `POST` /api/v1/messages

**Ingest message with sender classification**

Creates a message and classifies the sender as known or unknown. Unknown senders are flagged for separate handling.

*Requirement:* WA-CON-005

**Request Body:** `CreateMessageRequest`

**Responses:**

- `201`: Created
- `400`: Bad Request
- `401`: Unauthorized
- `422`: Unprocessable Entity

---

#### `GET` /api/v1/messages/search

**Search messages**

Performs full-text search over messages using the provided query string.

*Requirement:* WA-SRC-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| q | query | string | True | Full-text search query |
| page | query | integer | False | Page number for pagination (default: 1) |
| pageSize | query | integer | False | Number of items per page (default: 20) |

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `500`: Internal Server Error

---

#### `GET` /api/v1/messages/sync

**Synchronize messages efficiently**

Returns messages changed since a given cursor or timestamp using incremental synchronization with pagination.

*Requirement:* WA-PERF-003

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| cursor | query | string | False | Opaque cursor from a previous sync response |
| since | query | string | False | ISO-8601 timestamp to fetch changes since a point in time |
| limit | query | integer | False | Maximum number of messages to return (pagination) |

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `429`: Too Many Requests
- `500`: Internal Server Error

---

#### `POST` /api/v1/messages/ack

**Acknowledge synchronized messages**

Confirms receipt of synchronized messages to optimize subsequent sync operations.

*Requirement:* WA-PERF-003

**Request Body:** `MessageAckRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `409`: Conflict
- `500`: Internal Server Error

---

### NotificationPreviewConfigs

#### `GET` /api/v1/notification-preview-configs

**List notification preview configurations**

Retrieve a paginated list of configurable notification preview settings.

*Requirement:* WA-NOT-002

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| page | query | integer | False | Page number for pagination |
| pageSize | query | integer | False | Number of items per page |

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized

---

#### `POST` /api/v1/notification-preview-configs

**Create a notification preview configuration**

Create a configurable notification preview setting.

*Requirement:* WA-NOT-002

**Request Body:** `CreateNotificationPreviewConfigRequest`

**Responses:**

- `201`: Created
- `400`: Bad Request
- `401`: Unauthorized
- `409`: Conflict

---

#### `GET` /api/v1/notification-preview-configs/{configId}

**Get notification preview configuration**

Retrieve a specific notification preview configuration by ID.

*Requirement:* WA-NOT-002

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| configId | path | string | True | Configuration ID |

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `404`: Not Found

---

#### `PUT` /api/v1/notification-preview-configs/{configId}

**Update notification preview configuration**

Update an existing notification preview configuration.

*Requirement:* WA-NOT-002

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| configId | path | string | True | Configuration ID |

**Request Body:** `UpdateNotificationPreviewConfigRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Not Found

---

#### `DELETE` /api/v1/notification-preview-configs/{configId}

**Delete notification preview configuration**

Delete a notification preview configuration by ID.

*Requirement:* WA-NOT-002

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| configId | path | string | True | Configuration ID |

**Responses:**

- `204`: No Content
- `401`: Unauthorized
- `404`: Not Found

---

### NotificationPreviews

#### `POST` /api/v1/notification-previews

**Generate notification preview**

Generate a preview for a notification based on a configuration and input data.

*Requirement:* WA-NOT-002

**Request Body:** `CreateNotificationPreviewRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Not Found
- `422`: Unprocessable Entity

---

### Notifications

#### `POST` /api/v1/notifications

**Send a push notification**

Creates and dispatches a push notification with reliability controls.

*Requirement:* WA-NOT-001

**Request Body:** `SendNotificationRequest`

**Responses:**

- `202`: Accepted
- `400`: Bad Request
- `401`: Unauthorized
- `409`: Conflict
- `429`: Too Many Requests
- `500`: Internal Server Error

---

#### `GET` /api/v1/notifications/{id}

**Get notification status**

Retrieves delivery status and metadata for a notification.

*Requirement:* WA-NOT-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| id | path | string | True | Notification ID |

**Request Body:** `GetNotificationRequest`

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `404`: Not Found
- `500`: Internal Server Error

---

#### `GET` /api/v1/notifications

**List notifications**

Lists notifications with pagination for monitoring reliability.

*Requirement:* WA-NOT-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | query | string | False | Filter by user identifier |
| status | query | string | False | Filter by delivery status |
| page | query | integer | False | Page number |
| pageSize | query | integer | False | Page size |

**Request Body:** `ListNotificationsRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `500`: Internal Server Error

---

#### `POST` /api/v1/notifications/{id}/acknowledgements

**Acknowledge notification delivery**

Client acknowledges receipt to support reliable delivery tracking.

*Requirement:* WA-NOT-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| id | path | string | True | Notification ID |

**Request Body:** `AcknowledgeNotificationRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Not Found
- `500`: Internal Server Error

---

#### `POST` /api/v1/notifications/{notificationId}/quick-replies

**Create a quick reply for a notification**

Allows the user to send a response directly from a notification.

*Requirement:* WA-NOT-003

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| notificationId | path | string | True | Notification ID |

**Request Body:** `CreateQuickReplyRequest`

**Responses:**

- `201`: Created
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Notification Not Found
- `422`: Unprocessable Entity

---

#### `GET` /api/v1/notifications

**List reaction notifications**

Returns a paginated list of notifications for reactions to the authenticated user's messages.

*Requirement:* WA-NOT-005

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| type | query | string | False | Filter by notification type (e.g., reaction) |
| page | query | integer | False | Page number for pagination |
| pageSize | query | integer | False | Number of items per page |

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `500`: Internal Server Error

---

#### `PATCH` /api/v1/notifications/{id}

**Update notification status**

Marks a notification as read to acknowledge reaction alerts.

*Requirement:* WA-NOT-005

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| id | path | string | True | Notification ID |

**Request Body:** `UpdateNotificationRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Not Found
- `500`: Internal Server Error

---

### Offline

#### `GET` /api/v1/offline/manifests

**Get offline sync manifest**

Returns metadata and versions required to support offline mode and determine which resources need syncing.

*Requirement:* WA-PERF-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| clientId | query | string | True | Unique identifier of the client instance |
| lastSyncAt | query | string | False | ISO-8601 timestamp of the last successful sync |

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `500`: Internal Server Error

---

#### `POST` /api/v1/offline/changes

**Upload offline changes**

Submits client-side changes collected while offline for server reconciliation.

*Requirement:* WA-PERF-001

**Request Body:** `OfflineChangesRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `409`: Conflict
- `500`: Internal Server Error

---

#### `GET` /api/v1/offline/changes

**Download server changes**

Retrieves server-side changes since the last sync for offline caching.

*Requirement:* WA-PERF-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| clientId | query | string | True | Unique identifier of the client instance |
| since | query | string | True | ISO-8601 timestamp of last sync |
| page | query | integer | False | Page number for pagination |
| pageSize | query | integer | False | Page size for pagination |

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `500`: Internal Server Error

---

### Participants

#### `POST` /api/v1/group-calls/{callId}/participants

**Add participants**

Add one or more participants to a group call.

*Requirement:* WA-CALL-003

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| callId | path | string | True | Group call ID |

**Request Body:** `AddParticipantsRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Not Found
- `409`: Conflict
- `500`: Internal Server Error

---

#### `DELETE` /api/v1/group-calls/{callId}/participants/{participantId}

**Remove participant**

Remove a participant from a group call.

*Requirement:* WA-CALL-003

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| callId | path | string | True | Group call ID |
| participantId | path | string | True | Participant user ID |

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `404`: Not Found
- `500`: Internal Server Error

---

### Passkeys

#### `POST` /api/v1/passkeys/registration/options

**Create passkey registration options**

Generates WebAuthn registration (attestation) options for a user to begin passkey enrollment.

*Requirement:* WA-AUTH-005

**Request Body:** `PasskeyRegistrationOptionsRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `409`: Conflict

---

#### `POST` /api/v1/passkeys/registration/verify

**Verify passkey registration**

Verifies the WebAuthn attestation response and registers the passkey.

*Requirement:* WA-AUTH-005

**Request Body:** `PasskeyRegistrationVerifyRequest`

**Responses:**

- `201`: Created
- `400`: Bad Request
- `401`: Unauthorized
- `409`: Conflict

---

#### `POST` /api/v1/passkeys/authentication/options

**Create passkey authentication options**

Generates WebAuthn assertion options for a user to authenticate with a passkey.

*Requirement:* WA-AUTH-005

**Request Body:** `PasskeyAuthenticationOptionsRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Not Found

---

#### `POST` /api/v1/passkeys/authentication/verify

**Verify passkey authentication**

Verifies the WebAuthn assertion response and issues an authenticated session/token.

*Requirement:* WA-AUTH-005

**Request Body:** `PasskeyAuthenticationVerifyRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized

---

#### `GET` /api/v1/passkeys

**List passkeys**

Returns a paginated list of passkeys for the authenticated user.

*Requirement:* WA-AUTH-005

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| page | query | integer | False | Page number |
| pageSize | query | integer | False | Number of items per page |

**Responses:**

- `200`: Success
- `401`: Unauthorized

---

#### `DELETE` /api/v1/passkeys/{passkeyId}

**Delete passkey**

Revokes a registered passkey for the authenticated user.

*Requirement:* WA-AUTH-005

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| passkeyId | path | string | True | Passkey ID |

**Responses:**

- `204`: No Content
- `401`: Unauthorized
- `404`: Not Found

---

### Payments

#### `POST` /api/v1/payments

**Create a WhatsApp Pay payment**

Initiate an in-app payment in supported markets.

*Requirement:* WA-BUS-008

**Request Body:** `CreatePaymentRequest`

**Responses:**

- `201`: Created
- `400`: Bad Request
- `401`: Unauthorized
- `409`: Conflict
- `422`: Unprocessable Entity

---

#### `GET` /api/v1/payments/{paymentId}

**Get payment details**

Retrieve a specific payment by ID.

*Requirement:* WA-BUS-008

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| paymentId | path | string | True | Payment ID |

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `404`: Not Found

---

#### `GET` /api/v1/payments

**List payments**

List payments with optional filters and pagination.

*Requirement:* WA-BUS-008

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| market | query | string | False | Filter by market/region code |
| status | query | string | False | Filter by payment status |
| page | query | integer | False | Page number |
| pageSize | query | integer | False | Number of items per page |

**Responses:**

- `200`: Success
- `401`: Unauthorized

---

#### `POST` /api/v1/payments/{paymentId}/cancel

**Cancel a payment**

Cancel a pending payment.

*Requirement:* WA-BUS-008

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| paymentId | path | string | True | Payment ID |

**Request Body:** `CancelPaymentRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Not Found
- `409`: Conflict

---

### Polls

#### `POST` /api/v1/chats/{chatId}/polls

**Create a poll in a chat**

Creates a poll in a group or direct chat.

*Requirement:* WA-GRP-008

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| chatId | path | string | True | Chat ID (group or direct) |

**Request Body:** `CreatePollRequest`

**Responses:**

- `201`: Created
- `400`: Bad Request
- `401`: Unauthorized
- `403`: Forbidden

---

#### `GET` /api/v1/chats/{chatId}/polls

**List polls in a chat**

Retrieves polls for a group or direct chat with pagination.

*Requirement:* WA-GRP-008

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| chatId | path | string | True | Chat ID (group or direct) |
| page | query | integer | False | Page number |
| pageSize | query | integer | False | Number of items per page |

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `403`: Forbidden

---

#### `GET` /api/v1/chats/{chatId}/polls/{pollId}

**Get poll details**

Retrieves details and current results of a poll in a chat.

*Requirement:* WA-GRP-008

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| chatId | path | string | True | Chat ID (group or direct) |
| pollId | path | string | True | Poll ID |

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `403`: Forbidden
- `404`: Not Found

---

#### `POST` /api/v1/chats/{chatId}/polls/{pollId}/votes

**Cast or update a vote**

Casts or updates a user's vote for a poll in a chat.

*Requirement:* WA-GRP-008

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| chatId | path | string | True | Chat ID (group or direct) |
| pollId | path | string | True | Poll ID |

**Request Body:** `VotePollRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `403`: Forbidden
- `404`: Not Found
- `409`: Conflict

---

#### `PUT` /api/v1/chats/{chatId}/polls/{pollId}/status

**Close or reopen a poll**

Updates the status of a poll (open or closed) in a chat.

*Requirement:* WA-GRP-008

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| chatId | path | string | True | Chat ID (group or direct) |
| pollId | path | string | True | Poll ID |

**Request Body:** `UpdatePollStatusRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `403`: Forbidden
- `404`: Not Found

---

#### `DELETE` /api/v1/chats/{chatId}/polls/{pollId}

**Delete a poll**

Deletes a poll from a chat.

*Requirement:* WA-GRP-008

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| chatId | path | string | True | Chat ID (group or direct) |
| pollId | path | string | True | Poll ID |

**Responses:**

- `204`: No Content
- `401`: Unauthorized
- `403`: Forbidden
- `404`: Not Found

---

### Products

#### `GET` /api/v1/businesses/{businessId}/products

**List products in business catalog**

Retrieves a paginated list of products for the specified business catalog.

*Requirement:* WA-BUS-006

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| businessId | path | string | True | Business ID |
| page | query | integer | False | Page number (starting from 1) |
| pageSize | query | integer | False | Number of items per page |
| search | query | string | False | Search term to filter products |
| category | query | string | False | Filter by category |

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Business Not Found

---

#### `POST` /api/v1/businesses/{businessId}/products

**Create product in business catalog**

Creates a new product entry in the specified business catalog.

*Requirement:* WA-BUS-006

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| businessId | path | string | True | Business ID |

**Request Body:** `CreateProductRequest`

**Responses:**

- `201`: Created
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Business Not Found
- `409`: Conflict

---

#### `GET` /api/v1/businesses/{businessId}/products/{productId}

**Get product details**

Retrieves details of a specific product in the business catalog.

*Requirement:* WA-BUS-006

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| businessId | path | string | True | Business ID |
| productId | path | string | True | Product ID |

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `404`: Not Found

---

#### `PUT` /api/v1/businesses/{businessId}/products/{productId}

**Update product**

Updates an existing product in the business catalog.

*Requirement:* WA-BUS-006

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| businessId | path | string | True | Business ID |
| productId | path | string | True | Product ID |

**Request Body:** `UpdateProductRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Not Found
- `409`: Conflict

---

#### `DELETE` /api/v1/businesses/{businessId}/products/{productId}

**Delete product**

Deletes a product from the business catalog.

*Requirement:* WA-BUS-006

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| businessId | path | string | True | Business ID |
| productId | path | string | True | Product ID |

**Responses:**

- `204`: No Content
- `401`: Unauthorized
- `404`: Not Found

---

### ProfileImage

#### `GET` /api/v1/users/{userId}/profile-image

**Get user profile image metadata**

Retrieves metadata and access URL for the user's profile image.

*Requirement:* WA-PROF-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `403`: Forbidden
- `404`: Not Found

---

#### `PUT` /api/v1/users/{userId}/profile-image

**Upload or replace user profile image**

Uploads a new profile image or replaces the existing one for the user.

*Requirement:* WA-PROF-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Request Body:** `UpsertUserProfileImageRequest`

**Responses:**

- `200`: Success
- `201`: Created
- `400`: Bad Request
- `401`: Unauthorized
- `403`: Forbidden
- `413`: Payload Too Large
- `415`: Unsupported Media Type

---

#### `DELETE` /api/v1/users/{userId}/profile-image

**Delete user profile image**

Removes the user's profile image.

*Requirement:* WA-PROF-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Responses:**

- `204`: No Content
- `401`: Unauthorized
- `403`: Forbidden
- `404`: Not Found

---

### ProfileSettings

#### `GET` /api/v1/users/{userId}/profile-picture-visibility

**Get profile picture visibility setting**

Retrieves the current profile picture visibility configuration for a user.

*Requirement:* WA-SET-003

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `403`: Forbidden
- `404`: Not Found
- `500`: Internal Server Error

---

#### `PUT` /api/v1/users/{userId}/profile-picture-visibility

**Update profile picture visibility setting**

Updates the profile picture visibility configuration for a user.

*Requirement:* WA-SET-003

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Request Body:** `UpdateProfilePictureVisibilityRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `403`: Forbidden
- `404`: Not Found
- `409`: Conflict
- `500`: Internal Server Error

---

### Profiles

#### `GET` /api/v1/profiles/{profileId}/info-text

**Get profile info text**

Retrieves the short info/status text associated with a user profile.

*Requirement:* WA-PROF-003

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| profileId | path | string | True | Profile ID |

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `404`: Not Found
- `500`: Internal Server Error

---

#### `PUT` /api/v1/profiles/{profileId}/info-text

**Update profile info text**

Creates or updates the short info/status text for a user profile.

*Requirement:* WA-PROF-003

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| profileId | path | string | True | Profile ID |

**Request Body:** `UpdateProfileInfoTextRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Not Found
- `500`: Internal Server Error

---

#### `GET` /api/v1/users/{userId}/profile

**Get user profile**

Retrieves the user's profile including the phone number for display purposes.

*Requirement:* WA-PROF-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `403`: Forbidden
- `404`: Not Found
- `500`: Internal Server Error

---

#### `GET` /api/v1/profiles/{profileId}/qr-codes

**Get profile QR code**

Generates and returns a scannable QR code for the specified profile to enable easy adding.

*Requirement:* WA-PROF-005

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| profileId | path | string | True | Unique profile identifier |
| format | query | string | False | QR code output format (png, svg) |
| size | query | integer | False | Size of the QR code in pixels (applies to raster formats) |

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Not Found
- `500`: Internal Server Error

---

### PushNotifications

#### `POST` /api/v1/devices

**Register a device for push notifications**

Registers a client device and its push token to enable reliable delivery.

*Requirement:* WA-NOT-001

**Request Body:** `RegisterDeviceRequest`

**Responses:**

- `201`: Created
- `400`: Bad Request
- `401`: Unauthorized
- `409`: Conflict
- `500`: Internal Server Error

---

#### `PUT` /api/v1/devices/{id}

**Update a device push token**

Updates device registration to maintain reliable delivery.

*Requirement:* WA-NOT-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| id | path | string | True | Device registration ID |

**Request Body:** `UpdateDeviceRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Not Found
- `500`: Internal Server Error

---

#### `POST` /api/v1/notifications

**Send a push notification**

Creates and dispatches a push notification with reliability controls.

*Requirement:* WA-NOT-001

**Request Body:** `SendNotificationRequest`

**Responses:**

- `202`: Accepted
- `400`: Bad Request
- `401`: Unauthorized
- `409`: Conflict
- `429`: Too Many Requests
- `500`: Internal Server Error

---

#### `GET` /api/v1/notifications/{id}

**Get notification status**

Retrieves delivery status and metadata for a notification.

*Requirement:* WA-NOT-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| id | path | string | True | Notification ID |

**Request Body:** `GetNotificationRequest`

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `404`: Not Found
- `500`: Internal Server Error

---

#### `GET` /api/v1/notifications

**List notifications**

Lists notifications with pagination for monitoring reliability.

*Requirement:* WA-NOT-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | query | string | False | Filter by user identifier |
| status | query | string | False | Filter by delivery status |
| page | query | integer | False | Page number |
| pageSize | query | integer | False | Page size |

**Request Body:** `ListNotificationsRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `500`: Internal Server Error

---

#### `POST` /api/v1/notifications/{id}/acknowledgements

**Acknowledge notification delivery**

Client acknowledges receipt to support reliable delivery tracking.

*Requirement:* WA-NOT-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| id | path | string | True | Notification ID |

**Request Body:** `AcknowledgeNotificationRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Not Found
- `500`: Internal Server Error

---

### QrCodes

#### `GET` /api/v1/profiles/{profileId}/qr-codes

**Get profile QR code**

Generates and returns a scannable QR code for the specified profile to enable easy adding.

*Requirement:* WA-PROF-005

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| profileId | path | string | True | Unique profile identifier |
| format | query | string | False | QR code output format (png, svg) |
| size | query | integer | False | Size of the QR code in pixels (applies to raster formats) |

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Not Found
- `500`: Internal Server Error

---

### QuickReplies

#### `GET` /api/v1/businesses/{businessId}/quick-replies

**List quick replies**

Retrieve a paginated list of predefined quick replies for a business.

*Requirement:* WA-BUS-003

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| businessId | path | string | True | Business ID |
| page | query | integer | False | Page number (starting from 1) |
| pageSize | query | integer | False | Number of items per page |

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Not Found

---

#### `POST` /api/v1/businesses/{businessId}/quick-replies

**Create quick reply**

Create a predefined quick reply for a business.

*Requirement:* WA-BUS-003

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| businessId | path | string | True | Business ID |

**Request Body:** `CreateQuickReplyRequest`

**Responses:**

- `201`: Created
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Not Found
- `409`: Conflict

---

#### `GET` /api/v1/businesses/{businessId}/quick-replies/{quickReplyId}

**Get quick reply**

Retrieve a specific quick reply for a business.

*Requirement:* WA-BUS-003

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| businessId | path | string | True | Business ID |
| quickReplyId | path | string | True | Quick reply ID |

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `404`: Not Found

---

#### `PUT` /api/v1/businesses/{businessId}/quick-replies/{quickReplyId}

**Update quick reply**

Update a predefined quick reply for a business.

*Requirement:* WA-BUS-003

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| businessId | path | string | True | Business ID |
| quickReplyId | path | string | True | Quick reply ID |

**Request Body:** `UpdateQuickReplyRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Not Found
- `409`: Conflict

---

#### `DELETE` /api/v1/businesses/{businessId}/quick-replies/{quickReplyId}

**Delete quick reply**

Delete a predefined quick reply for a business.

*Requirement:* WA-BUS-003

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| businessId | path | string | True | Business ID |
| quickReplyId | path | string | True | Quick reply ID |

**Responses:**

- `204`: No Content
- `401`: Unauthorized
- `404`: Not Found

---

### Reactions

#### `POST` /api/v1/messages/{messageId}/reactions

**Add emoji reaction to a message**

Adds an emoji reaction to the specified message by the authenticated user.

*Requirement:* WA-MSG-007

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| messageId | path | string | True | Message ID |

**Request Body:** `AddReactionRequest`

**Responses:**

- `201`: Created
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Message Not Found
- `409`: Conflict

---

#### `GET` /api/v1/messages/{messageId}/reactions

**List reactions for a message**

Returns a paginated list of emoji reactions for the specified message.

*Requirement:* WA-MSG-007

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| messageId | path | string | True | Message ID |
| page | query | integer | False | Page number for pagination |
| pageSize | query | integer | False | Number of items per page |

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `404`: Message Not Found

---

#### `DELETE` /api/v1/messages/{messageId}/reactions/{reactionId}

**Remove emoji reaction from a message**

Removes a specific emoji reaction from the message. Typically allowed for the reacting user or moderators.

*Requirement:* WA-MSG-007

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| messageId | path | string | True | Message ID |
| reactionId | path | string | True | Reaction ID |

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `403`: Forbidden
- `404`: Message or Reaction Not Found

---

### ReadReceipts

#### `GET` /api/v1/read-receipt-config

**Get read receipt configuration**

Retrieves the current user's configurable read receipt settings.

*Requirement:* WA-SET-002

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `404`: Not Found

---

#### `PUT` /api/v1/read-receipt-config

**Update read receipt configuration**

Updates the current user's configurable read receipt settings.

*Requirement:* WA-SET-002

**Request Body:** `UpdateReadReceiptConfigRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized

---

#### `POST` /api/v1/messages/{messageId}/read-receipts

**Create read receipt**

Creates a read receipt for a specific message, honoring the user's configuration.

*Requirement:* WA-SET-002

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| messageId | path | string | True | Message ID |

**Request Body:** `CreateReadReceiptRequest`

**Responses:**

- `201`: Created
- `400`: Bad Request
- `401`: Unauthorized
- `403`: Forbidden
- `404`: Not Found

---

#### `GET` /api/v1/messages/{messageId}/read-receipts

**List read receipts**

Lists read receipts for a specific message with pagination.

*Requirement:* WA-SET-002

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| messageId | path | string | True | Message ID |
| page | query | integer | False | Page number |
| pageSize | query | integer | False | Number of items per page |

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `404`: Not Found

---

### Recipients

#### `POST` /api/v1/broadcast-lists/{listId}/recipients

**Add recipients to broadcast list**

Adds one or more recipients to a broadcast list.

*Requirement:* WA-MSG-011

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| listId | path | string | True | Broadcast list ID |

**Request Body:** `AddRecipientsRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Not Found

---

#### `DELETE` /api/v1/broadcast-lists/{listId}/recipients/{recipientId}

**Remove recipient from broadcast list**

Removes a specific recipient from a broadcast list.

*Requirement:* WA-MSG-011

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| listId | path | string | True | Broadcast list ID |
| recipientId | path | string | True | Recipient ID |

**Responses:**

- `204`: No Content
- `401`: Unauthorized
- `404`: Not Found

---

### Records

#### `GET` /api/v1/records

**Get records by date**

Enables jumping to records for a specific date using a date filter and optional pagination.

*Requirement:* WA-SRC-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| date | query | string | True | Target date in ISO-8601 format (YYYY-MM-DD) |
| page | query | integer | False | Page number for pagination (starting at 1) |
| pageSize | query | integer | False | Number of items per page |

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Not Found

---

### RegionalFormats

#### `GET` /api/v1/regional-formats

**List supported regional formats**

Returns a paginated list of supported regional formats (locales) the system can respect for formatting dates, numbers, and currencies.

*Requirement:* WA-LOC-002

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| page | query | integer | False | Page number for pagination |
| pageSize | query | integer | False | Number of items per page |

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `500`: Internal Server Error

---

#### `GET` /api/v1/regional-formats/{locale}

**Get regional format details**

Returns formatting details for a specific locale to ensure the system respects regional formats.

*Requirement:* WA-LOC-002

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| locale | path | string | True | Locale identifier (e.g., de-DE, en-US) |

**Responses:**

- `200`: Success
- `400`: Bad Request
- `404`: Not Found
- `401`: Unauthorized
- `500`: Internal Server Error

---

#### `GET` /api/v1/users/{userId}/regional-format

**Get user regional format preference**

Returns the user's regional format preference used for rendering dates, numbers, and currencies.

*Requirement:* WA-LOC-002

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Responses:**

- `200`: Success
- `400`: Bad Request
- `404`: Not Found
- `401`: Unauthorized
- `500`: Internal Server Error

---

#### `PUT` /api/v1/users/{userId}/regional-format

**Update user regional format preference**

Sets the user's preferred regional format so the system can respect regional formatting.

*Requirement:* WA-LOC-002

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Request Body:** `UpdateUserRegionalFormatRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `404`: Not Found
- `401`: Unauthorized
- `500`: Internal Server Error

---

### Reports

#### `POST` /api/v1/reports

**Report a message or contact**

Creates a report for a message or contact to enable moderation and review.

*Requirement:* WA-SEC-005

**Request Body:** `CreateReportRequest`

**Responses:**

- `201`: Created
- `400`: Bad Request
- `401`: Unauthorized
- `403`: Forbidden
- `404`: Target Not Found
- `409`: Conflict
- `500`: Internal Server Error

---

### ScreenShares

#### `POST` /api/v1/calls/{callId}/screenShares

**Start screen sharing in a call**

Initiates a screen sharing session for the specified call.

*Requirement:* WA-CALL-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| callId | path | string | True | Call ID |

**Request Body:** `StartScreenShareRequest`

**Responses:**

- `201`: Created
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Call Not Found
- `409`: Conflict
- `500`: Internal Server Error

---

#### `GET` /api/v1/calls/{callId}/screenShares

**List screen sharing sessions for a call**

Retrieves screen sharing sessions for the specified call with pagination.

*Requirement:* WA-CALL-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| callId | path | string | True | Call ID |
| page | query | integer | False | Page number (starting at 1) |
| pageSize | query | integer | False | Number of items per page |
| status | query | string | False | Filter by status |

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Call Not Found
- `500`: Internal Server Error

---

#### `GET` /api/v1/screenShares/{screenShareId}

**Get screen sharing session**

Retrieves details of a screen sharing session.

*Requirement:* WA-CALL-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| screenShareId | path | string | True | Screen share session ID |

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `404`: Not Found
- `500`: Internal Server Error

---

#### `DELETE` /api/v1/screenShares/{screenShareId}

**Stop screen sharing session**

Stops an active screen sharing session.

*Requirement:* WA-CALL-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| screenShareId | path | string | True | Screen share session ID |

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `404`: Not Found
- `409`: Conflict
- `500`: Internal Server Error

---

### Search

#### `GET` /api/v1/search/chats-contacts

**Search chats and contacts**

Performs a search across chats and contacts by query string with pagination.

*Requirement:* WA-SRC-003

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| query | query | string | True | Search term for chats and contacts |
| page | query | integer | False | Page number for pagination (1-based) |
| pageSize | query | integer | False | Number of items per page |

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `500`: Internal Server Error

---

### Security

#### `POST` /api/v1/users/{userId}/pin

**Enable PIN security**

Enables optional additional PIN protection for the specified user.

*Requirement:* WA-SEC-006

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Request Body:** `EnablePinRequest`

**Responses:**

- `201`: Created
- `400`: Bad Request
- `401`: Unauthorized
- `409`: Conflict

---

#### `PUT` /api/v1/users/{userId}/pin

**Update PIN**

Updates the PIN for a user who has PIN security enabled.

*Requirement:* WA-SEC-006

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Request Body:** `UpdatePinRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `403`: Forbidden

---

#### `DELETE` /api/v1/users/{userId}/pin

**Disable PIN security**

Disables the optional PIN security for the specified user.

*Requirement:* WA-SEC-006

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Request Body:** `DisablePinRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `403`: Forbidden

---

#### `POST` /api/v1/auth/pin/verify

**Verify PIN**

Verifies the user's PIN as an additional step after primary authentication.

*Requirement:* WA-SEC-006

**Request Body:** `VerifyPinRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `403`: Forbidden
- `423`: Locked

---

#### `GET` /api/v1/users/{userId}/pin

**Get PIN status**

Retrieves whether the user has optional PIN security enabled.

*Requirement:* WA-SEC-006

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `404`: Not Found

---

#### `GET` /api/v1/security/ip-masking-settings

**Get IP masking settings**

Retrieves the current configuration that controls whether IP addresses are masked during calls.

*Requirement:* WA-SEC-008

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `403`: Forbidden
- `500`: Internal Server Error

---

#### `PUT` /api/v1/security/ip-masking-settings

**Update IP masking settings**

Enables or disables IP masking and defines the masking strategy for calls.

*Requirement:* WA-SEC-008

**Request Body:** `UpdateIpMaskingSettingsRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `403`: Forbidden
- `409`: Conflict
- `500`: Internal Server Error

---

### Sessions

#### `POST` /api/v1/sessions

**Create a new session for a device**

Creates an authenticated session for a specific device, enabling concurrent usage across multiple devices.

*Requirement:* WA-AUTH-004

**Request Body:** `CreateSessionRequest`

**Responses:**

- `201`: Created
- `400`: Bad Request
- `401`: Unauthorized
- `429`: Too Many Requests

---

#### `GET` /api/v1/sessions

**List active sessions for a user**

Returns a paginated list of active sessions across devices for the authenticated user.

*Requirement:* WA-AUTH-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| page | query | integer | False | Page number for pagination |
| pageSize | query | integer | False | Number of items per page |

**Responses:**

- `200`: Success
- `401`: Unauthorized

---

#### `DELETE` /api/v1/sessions/{sessionId}

**Revoke a specific session**

Revokes a specific device session for the authenticated user.

*Requirement:* WA-AUTH-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| sessionId | path | string | True | Session ID to revoke |

**Responses:**

- `204`: No Content
- `401`: Unauthorized
- `404`: Not Found

---

#### `DELETE` /api/v1/sessions/current

**Logout current session**

Revokes the current session on the device.

*Requirement:* WA-AUTH-004

**Responses:**

- `204`: No Content
- `401`: Unauthorized

---

### Settings

#### `GET` /api/v1/groups/{groupId}/settings

**Get group settings**

Retrieves the configurable settings for a specific group.

*Requirement:* WA-GRP-003

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| groupId | path | string | True | Group ID |

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Group Not Found
- `500`: Internal Server Error

---

#### `PUT` /api/v1/groups/{groupId}/settings

**Replace group settings**

Replaces the configurable settings for a specific group.

*Requirement:* WA-GRP-003

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| groupId | path | string | True | Group ID |

**Request Body:** `ReplaceGroupSettingsRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Group Not Found
- `409`: Conflict
- `500`: Internal Server Error

---

#### `PATCH` /api/v1/groups/{groupId}/settings

**Update group settings**

Partially updates configurable settings for a specific group.

*Requirement:* WA-GRP-003

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| groupId | path | string | True | Group ID |

**Request Body:** `UpdateGroupSettingsRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Group Not Found
- `409`: Conflict
- `500`: Internal Server Error

---

### ShareTargets

#### `GET` /api/v1/share-targets

**List available share targets**

Retrieves a paginated list of available system share targets (apps/services) for integration.

*Requirement:* WA-INT-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| page | query | integer | False | Page number for pagination |
| pageSize | query | integer | False | Number of items per page |

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `500`: Internal Server Error

---

### Shares

#### `POST` /api/v1/shares

**Create a share request**

Creates a share request that triggers system sharing integration for the given content and recipients.

*Requirement:* WA-INT-001

**Request Body:** `CreateShareRequest`

**Responses:**

- `201`: Created
- `400`: Bad Request
- `401`: Unauthorized
- `422`: Unprocessable Entity
- `500`: Internal Server Error

---

#### `GET` /api/v1/shares/{id}

**Get share request status**

Retrieves the details and status of a share request.

*Requirement:* WA-INT-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| id | path | string | True | Share request ID |

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `404`: Not Found
- `500`: Internal Server Error

---

### SmartReplies

#### `POST` /api/v1/smart-replies

**Generate smart reply suggestions**

Generates intelligent reply suggestions based on the provided message and optional conversation context.

*Requirement:* WA-AI-002

**Request Body:** `SmartReplyRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `422`: Unprocessable Entity
- `500`: Internal Server Error

---

### SpamDetection

#### `POST` /api/v1/spam-detections

**Submit content for spam detection**

Analyzes provided content and returns spam classification and score.

*Requirement:* WA-SEC-007

**Request Body:** `CreateSpamDetectionRequest`

**Responses:**

- `201`: Created
- `400`: Bad Request
- `401`: Unauthorized
- `422`: Unprocessable Entity
- `500`: Internal Server Error

---

#### `GET` /api/v1/spam-detections/{id}

**Get spam detection result**

Retrieves a previously created spam detection result by ID.

*Requirement:* WA-SEC-007

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| id | path | string | True | Spam detection result ID |

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `404`: Not Found
- `500`: Internal Server Error

---

### Status

#### `POST` /api/v1/statuses

**Create 24-hour status update**

Creates a new status update that expires automatically after 24 hours.

*Requirement:* WA-STS-001

**Request Body:** `CreateStatusRequest`

**Responses:**

- `201`: Created
- `400`: Bad Request
- `401`: Unauthorized
- `409`: Conflict
- `500`: Internal Server Error

---

#### `GET` /api/v1/status

**Get system status**

Returns current system status and health information.

*Requirement:* WA-STS-003

**Responses:**

- `200`: Success
- `503`: Service Unavailable

---

#### `POST` /api/v1/contacts/{contactId}/status/mute

**Mute contact status**

Mutes the status of a contact to prevent status visibility or notifications as defined by the system.

*Requirement:* WA-STS-005

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| contactId | path | string | True | Contact ID |

**Request Body:** `MuteContactStatusRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Contact Not Found
- `409`: Conflict
- `500`: Internal Server Error

---

### StatusVisibility

#### `GET` /api/v1/status-visibilities

**List status visibility configurations**

Retrieve a paginated list of status visibility configurations.

*Requirement:* WA-STS-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| page | query | integer | False | Page number (starting at 1) |
| pageSize | query | integer | False | Number of items per page |
| statusId | query | string | False | Filter by status ID |
| audienceType | query | string | False | Filter by audience type (e.g., role, group, user) |

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `500`: Internal Server Error

---

#### `POST` /api/v1/status-visibilities

**Create status visibility configuration**

Create a new configuration that defines visibility rules for a status.

*Requirement:* WA-STS-004

**Request Body:** `CreateStatusVisibilityRequest`

**Responses:**

- `201`: Created
- `400`: Bad Request
- `401`: Unauthorized
- `409`: Conflict
- `500`: Internal Server Error

---

#### `GET` /api/v1/status-visibilities/{id}

**Get status visibility configuration**

Retrieve a specific status visibility configuration by ID.

*Requirement:* WA-STS-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| id | path | string | True | Configuration ID |

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `404`: Not Found
- `500`: Internal Server Error

---

#### `PUT` /api/v1/status-visibilities/{id}

**Update status visibility configuration**

Update an existing status visibility configuration.

*Requirement:* WA-STS-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| id | path | string | True | Configuration ID |

**Request Body:** `UpdateStatusVisibilityRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Not Found
- `409`: Conflict
- `500`: Internal Server Error

---

#### `DELETE` /api/v1/status-visibilities/{id}

**Delete status visibility configuration**

Delete a status visibility configuration by ID.

*Requirement:* WA-STS-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| id | path | string | True | Configuration ID |

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `404`: Not Found
- `500`: Internal Server Error

---

#### `GET` /api/v1/statuses/{statusId}/visibility

**Get effective visibility for a status**

Retrieve the effective visibility setting for a status for the current user or specified audience.

*Requirement:* WA-STS-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| statusId | path | string | True | Status ID |
| audienceType | query | string | False | Audience type to evaluate (e.g., role, group, user) |
| audienceId | query | string | False | Audience identifier to evaluate |

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Not Found
- `500`: Internal Server Error

---

### StickerPacks

#### `GET` /api/v1/sticker-packs

**List regional sticker packs**

Returns a paginated list of sticker packs, optionally filtered by region or locale.

*Requirement:* WA-LOC-003

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| region | query | string | False | Region code to filter sticker packs (e.g., DE, AT, CH). |
| locale | query | string | False | Locale to filter sticker packs (e.g., de-DE). |
| page | query | integer | False | Page number for pagination. |
| pageSize | query | integer | False | Number of items per page. |

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `500`: Internal Server Error

---

#### `GET` /api/v1/sticker-packs/{id}

**Get sticker pack details**

Returns details of a specific sticker pack including its regional metadata.

*Requirement:* WA-LOC-003

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| id | path | string | True | Sticker pack ID |

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Not Found
- `500`: Internal Server Error

---

### Stickers

#### `POST` /api/v1/chats/{chatId}/messages/stickers

**Send a sticker message in a chat**

Creates a new chat message containing a sticker in the specified chat.

*Requirement:* WA-MED-005

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| chatId | path | string | True | Chat ID |

**Request Body:** `SendStickerMessageRequest`

**Responses:**

- `201`: Created
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Chat or sticker not found
- `422`: Unprocessable Entity

---

#### `GET` /api/v1/sticker-packs

**List available sticker packs**

Returns a paginated list of sticker packs available to the user.

*Requirement:* WA-MED-005

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| page | query | integer | False | Page number for pagination |
| pageSize | query | integer | False | Number of items per page |

**Responses:**

- `200`: Success
- `401`: Unauthorized

---

#### `GET` /api/v1/sticker-packs/{packId}/stickers

**List stickers in a pack**

Returns a paginated list of stickers within the specified pack.

*Requirement:* WA-MED-005

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| packId | path | string | True | Sticker pack ID |
| page | query | integer | False | Page number for pagination |
| pageSize | query | integer | False | Number of items per page |

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `404`: Sticker pack not found

---

#### `POST` /api/v1/stickers/suggestions

**Get context-based sticker suggestions**

Generates sticker suggestions based on provided context such as text, language, and metadata.

*Requirement:* WA-AI-003

**Request Body:** `CreateStickerSuggestionsRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `422`: Unprocessable Entity
- `500`: Internal Server Error

---

### StorageManagement

#### `GET` /api/v1/storage-quotas

**List storage quotas**

Returns a paginated list of storage quotas by scope.

*Requirement:* WA-SET-006

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| page | query | integer | False | Page number for pagination (starts at 1) |
| pageSize | query | integer | False | Number of items per page |
| scope | query | string | False | Filter by scope (e.g., user, project, bucket) |

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `403`: Forbidden
- `500`: Internal Server Error

---

#### `PUT` /api/v1/storage-quotas/{scopeId}

**Set storage quota**

Creates or updates the storage quota for a specific scope.

*Requirement:* WA-SET-006

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| scopeId | path | string | True | Scope identifier |

**Request Body:** `SetStorageQuotaRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `403`: Forbidden
- `404`: Not Found
- `409`: Conflict
- `500`: Internal Server Error

---

#### `POST` /api/v1/storage-usage/cleanup

**Trigger storage cleanup**

Initiates a cleanup operation to manage storage usage according to policy (e.g., delete expired or orphaned items).

*Requirement:* WA-SET-006

**Request Body:** `StorageCleanupRequest`

**Responses:**

- `202`: Accepted
- `400`: Bad Request
- `401`: Unauthorized
- `403`: Forbidden
- `500`: Internal Server Error

---

### StorageSettings

#### `GET` /api/v1/storage-settings

**Get storage efficiency settings**

Retrieves current storage efficiency configuration such as compression and retention settings to ensure memory-efficient operation.

*Requirement:* WA-PERF-005

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `500`: Internal Server Error

---

#### `PUT` /api/v1/storage-settings

**Update storage efficiency settings**

Updates storage efficiency configuration to ensure memory-efficient operation.

*Requirement:* WA-PERF-005

**Request Body:** `UpdateStorageSettingsRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `422`: Unprocessable Entity
- `500`: Internal Server Error

---

### StorageUsage

#### `GET` /api/v1/storage-usage

**Get storage usage summary**

Returns an overview of total, used, and available storage across the system.

*Requirement:* WA-SET-006

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `403`: Forbidden
- `500`: Internal Server Error

---

#### `GET` /api/v1/storage-usage/items

**List storage usage by item**

Returns a paginated list of storage usage by item (e.g., files, buckets, or namespaces).

*Requirement:* WA-SET-006

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| page | query | integer | False | Page number for pagination (starts at 1) |
| pageSize | query | integer | False | Number of items per page |
| scope | query | string | False | Filter by scope (e.g., user, project, bucket) |

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `403`: Forbidden
- `500`: Internal Server Error

---

#### `GET` /api/v1/storage-usage/items/{itemId}

**Get storage usage item details**

Returns detailed storage usage information for a specific item.

*Requirement:* WA-SET-006

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| itemId | path | string | True | Storage usage item ID |

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `403`: Forbidden
- `404`: Not Found
- `500`: Internal Server Error

---

### UnknownSenders

#### `GET` /api/v1/unknown-senders

**List unknown senders**

Returns a paginated list of senders classified as unknown for separate handling.

*Requirement:* WA-CON-005

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| page | query | integer | False | Page number for pagination |
| pageSize | query | integer | False | Number of items per page |

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized

---

### UserChatSettings

#### `GET` /api/v1/users/{userId}/chat-settings/background

**Get user's default chat background**

Retrieves the user's default chat background settings applied across chats.

*Requirement:* WA-SET-008

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `404`: Not Found
- `500`: Internal Server Error

---

#### `PUT` /api/v1/users/{userId}/chat-settings/background

**Set user's default chat background**

Updates the user's default chat background settings applied across chats.

*Requirement:* WA-SET-008

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Request Body:** `UpdateUserChatBackgroundRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Not Found
- `500`: Internal Server Error

---

### UserPreferences

#### `GET` /api/v1/users/{userId}/preferences/theme

**Get user theme preference**

Retrieves the current theme preference (light or dark) for a specific user.

*Requirement:* WA-SET-009

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `404`: Not Found
- `500`: Internal Server Error

---

#### `PUT` /api/v1/users/{userId}/preferences/theme

**Update user theme preference**

Updates the theme preference (light or dark) for a specific user.

*Requirement:* WA-SET-009

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Request Body:** `ThemePreferenceUpdateRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Not Found
- `500`: Internal Server Error

---

#### `GET` /api/v1/users/{userId}/preferences/typography

**Get user typography preferences**

Retrieves the current typography preferences, including configurable font size, for a specific user.

*Requirement:* WA-ACC-002

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `404`: Not Found
- `500`: Internal Server Error

---

#### `PUT` /api/v1/users/{userId}/preferences/typography

**Update user typography preferences**

Updates the user's configurable font size preferences.

*Requirement:* WA-ACC-002

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Request Body:** `UpdateTypographyPreferencesRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Not Found
- `422`: Unprocessable Entity
- `500`: Internal Server Error

---

#### `GET` /api/v1/users/{userId}/preferences/locale

**Get user locale preference**

Retrieves the user's locale and text direction to ensure RTL support where applicable.

*Requirement:* WA-LOC-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `404`: Not Found
- `500`: Internal Server Error

---

#### `PUT` /api/v1/users/{userId}/preferences/locale

**Update user locale preference**

Sets the user's locale preference to ensure correct RTL/LTR rendering.

*Requirement:* WA-LOC-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Request Body:** `UpdateUserLocalePreferenceRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Not Found
- `409`: Conflict
- `500`: Internal Server Error

---

#### `GET` /api/v1/users/{userId}/regional-format

**Get user regional format preference**

Returns the user's regional format preference used for rendering dates, numbers, and currencies.

*Requirement:* WA-LOC-002

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Responses:**

- `200`: Success
- `400`: Bad Request
- `404`: Not Found
- `401`: Unauthorized
- `500`: Internal Server Error

---

#### `PUT` /api/v1/users/{userId}/regional-format

**Update user regional format preference**

Sets the user's preferred regional format so the system can respect regional formatting.

*Requirement:* WA-LOC-002

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Request Body:** `UpdateUserRegionalFormatRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `404`: Not Found
- `401`: Unauthorized
- `500`: Internal Server Error

---

### UserSettings

#### `GET` /api/v1/users/{userId}/settings/online-status-visibility

**Get online status visibility setting**

Retrieves the current configuration for the user's online status (last online) visibility.

*Requirement:* WA-SET-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `403`: Forbidden
- `404`: Not Found

---

#### `PUT` /api/v1/users/{userId}/settings/online-status-visibility

**Update online status visibility setting**

Updates the user's configuration for online status (last online) visibility.

*Requirement:* WA-SET-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Request Body:** `UpdateOnlineStatusVisibilitySettingRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `403`: Forbidden
- `404`: Not Found

---

### UserWidgets

#### `GET` /api/v1/users/{userId}/widgets

**List user's home screen widgets**

Returns a paginated list of widgets configured for a user's home screen.

*Requirement:* WA-INT-003

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |
| page | query | integer | False | Page number for pagination |
| pageSize | query | integer | False | Number of items per page |

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `404`: User Not Found

---

#### `POST` /api/v1/users/{userId}/widgets

**Add widget to user's home screen**

Adds a widget to a user's home screen configuration.

*Requirement:* WA-INT-003

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Request Body:** `CreateUserWidgetRequest`

**Responses:**

- `201`: Created
- `400`: Bad Request
- `401`: Unauthorized
- `404`: User Not Found

---

#### `PUT` /api/v1/users/{userId}/widgets/{userWidgetId}

**Update user's home screen widget**

Updates a user's home screen widget configuration.

*Requirement:* WA-INT-003

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |
| userWidgetId | path | string | True | User widget ID |

**Request Body:** `UpdateUserWidgetRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `404`: User Widget Not Found

---

#### `DELETE` /api/v1/users/{userId}/widgets/{userWidgetId}

**Remove widget from user's home screen**

Removes a widget from a user's home screen configuration.

*Requirement:* WA-INT-003

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |
| userWidgetId | path | string | True | User widget ID |

**Responses:**

- `204`: No Content
- `401`: Unauthorized
- `404`: User Widget Not Found

---

### Users

#### `POST` /api/v1/users/phone-registrations

**Register user by phone number**

Initiates user registration using a phone number and sends a verification code (OTP) to the provided phone number.

*Requirement:* WA-AUTH-001

**Request Body:** `CreatePhoneRegistrationRequest`

**Responses:**

- `201`: Created
- `400`: Bad Request
- `409`: Conflict
- `429`: Too Many Requests
- `500`: Internal Server Error

---

#### `POST` /api/v1/users/phone-verifications

**Verify phone number registration**

Verifies a user's phone number by validating the OTP sent during registration.

*Requirement:* WA-AUTH-001

**Request Body:** `VerifyPhoneRegistrationRequest`

**Responses:**

- `200`: OK
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Not Found
- `409`: Conflict
- `500`: Internal Server Error

---

#### `GET` /api/v1/users/{userId}/profile-image

**Get user profile image metadata**

Retrieves metadata and access URL for the user's profile image.

*Requirement:* WA-PROF-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `403`: Forbidden
- `404`: Not Found

---

#### `PUT` /api/v1/users/{userId}/profile-image

**Upload or replace user profile image**

Uploads a new profile image or replaces the existing one for the user.

*Requirement:* WA-PROF-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Request Body:** `UpsertUserProfileImageRequest`

**Responses:**

- `200`: Success
- `201`: Created
- `400`: Bad Request
- `401`: Unauthorized
- `403`: Forbidden
- `413`: Payload Too Large
- `415`: Unsupported Media Type

---

#### `DELETE` /api/v1/users/{userId}/profile-image

**Delete user profile image**

Removes the user's profile image.

*Requirement:* WA-PROF-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Responses:**

- `204`: No Content
- `401`: Unauthorized
- `403`: Forbidden
- `404`: Not Found

---

#### `GET` /api/v1/users/{userId}/profile

**Get user profile**

Retrieves the user's profile including the configurable display name.

*Requirement:* WA-PROF-002

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `403`: Forbidden
- `404`: Not Found
- `500`: Internal Server Error

---

#### `PUT` /api/v1/users/{userId}/profile

**Update user profile display name**

Updates the configurable display name for the user.

*Requirement:* WA-PROF-002

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Request Body:** `UpdateUserProfileRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `403`: Forbidden
- `404`: Not Found
- `409`: Conflict
- `422`: Unprocessable Entity
- `500`: Internal Server Error

---

#### `GET` /api/v1/users/{userId}/mentions

**List mentions for a user**

Returns a paginated list of messages in which the user was mentioned.

*Requirement:* WA-MSG-013

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |
| page | query | integer | False | Page number (starting at 1) |
| pageSize | query | integer | False | Number of items per page |

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `403`: Forbidden
- `404`: User Not Found

---

#### `POST` /api/v1/users/{userId}/pin

**Enable PIN security**

Enables optional additional PIN protection for the specified user.

*Requirement:* WA-SEC-006

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Request Body:** `EnablePinRequest`

**Responses:**

- `201`: Created
- `400`: Bad Request
- `401`: Unauthorized
- `409`: Conflict

---

#### `PUT` /api/v1/users/{userId}/pin

**Update PIN**

Updates the PIN for a user who has PIN security enabled.

*Requirement:* WA-SEC-006

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Request Body:** `UpdatePinRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `403`: Forbidden

---

#### `DELETE` /api/v1/users/{userId}/pin

**Disable PIN security**

Disables the optional PIN security for the specified user.

*Requirement:* WA-SEC-006

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Request Body:** `DisablePinRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `403`: Forbidden

---

#### `GET` /api/v1/users/{userId}/pin

**Get PIN status**

Retrieves whether the user has optional PIN security enabled.

*Requirement:* WA-SEC-006

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `404`: Not Found

---

#### `GET` /api/v1/users/{userId}/profile-picture-visibility

**Get profile picture visibility setting**

Retrieves the current profile picture visibility configuration for a user.

*Requirement:* WA-SET-003

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `403`: Forbidden
- `404`: Not Found
- `500`: Internal Server Error

---

#### `PUT` /api/v1/users/{userId}/profile-picture-visibility

**Update profile picture visibility setting**

Updates the profile picture visibility configuration for a user.

*Requirement:* WA-SET-003

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Request Body:** `UpdateProfilePictureVisibilityRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `403`: Forbidden
- `404`: Not Found
- `409`: Conflict
- `500`: Internal Server Error

---

#### `GET` /api/v1/users/{userId}/language

**Get user language preference**

Returns the current language preference for the specified user.

*Requirement:* WA-SET-010

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Not Found

---

#### `PUT` /api/v1/users/{userId}/language

**Update user language preference**

Sets or updates the language preference for the specified user.

*Requirement:* WA-SET-010

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Request Body:** `UpdateUserLanguageRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Not Found
- `409`: Conflict

---

### VideoCalls

#### `POST` /api/v1/videoCalls

**Create encrypted video call**

Creates a new encrypted video call session and returns signaling details required to establish the call.

*Requirement:* WA-CALL-002

**Request Body:** `CreateVideoCallRequest`

**Responses:**

- `201`: Created
- `400`: Bad Request
- `401`: Unauthorized
- `409`: Conflict
- `500`: Internal Server Error

---

#### `GET` /api/v1/videoCalls

**List video calls**

Returns a paginated list of video calls for the authenticated user.

*Requirement:* WA-CALL-002

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| page | query | integer | False | Page number |
| pageSize | query | integer | False | Number of items per page |
| status | query | string | False | Filter by call status |

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `500`: Internal Server Error

---

#### `GET` /api/v1/videoCalls/{id}

**Get video call details**

Retrieves details of a specific encrypted video call session.

*Requirement:* WA-CALL-002

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| id | path | string | True | Video call ID |

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `404`: Not Found
- `500`: Internal Server Error

---

#### `POST` /api/v1/videoCalls/{id}/join

**Join video call**

Joins an existing encrypted video call and returns signaling and encryption handshake data.

*Requirement:* WA-CALL-002

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| id | path | string | True | Video call ID |

**Request Body:** `JoinVideoCallRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Not Found
- `409`: Conflict
- `500`: Internal Server Error

---

#### `POST` /api/v1/videoCalls/{id}/end

**End video call**

Ends an active encrypted video call session.

*Requirement:* WA-CALL-002

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| id | path | string | True | Video call ID |

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `404`: Not Found
- `409`: Conflict
- `500`: Internal Server Error

---

### VoiceAssistants

#### `GET` /api/v1/voice-assistants

**List available voice assistants**

Returns supported voice assistants (e.g., Siri, Google Assistant) for integration.

*Requirement:* WA-INT-002

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| page | query | integer | False | Page number for pagination |
| pageSize | query | integer | False | Number of items per page |

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `500`: Internal Server Error

---

#### `POST` /api/v1/voice-assistants/{assistantId}/links

**Link a voice assistant account**

Creates a link between a user account and a supported voice assistant using an OAuth authorization code.

*Requirement:* WA-INT-002

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| assistantId | path | string | True | Voice assistant ID |

**Request Body:** `CreateVoiceAssistantLinkRequest`

**Responses:**

- `201`: Created
- `400`: Bad Request
- `401`: Unauthorized
- `409`: Conflict
- `500`: Internal Server Error

---

#### `DELETE` /api/v1/voice-assistants/{assistantId}/links/{linkId}

**Unlink a voice assistant account**

Removes the link between a user account and a voice assistant.

*Requirement:* WA-INT-002

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| assistantId | path | string | True | Voice assistant ID |
| linkId | path | string | True | Link ID |

**Responses:**

- `204`: No Content
- `401`: Unauthorized
- `404`: Not Found
- `500`: Internal Server Error

---

#### `POST` /api/v1/voice-assistants/{assistantId}/intents

**Handle voice assistant intent**

Endpoint for processing incoming intents/commands from the voice assistant platform.

*Requirement:* WA-INT-002

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| assistantId | path | string | True | Voice assistant ID |

**Request Body:** `VoiceAssistantIntentRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `422`: Unprocessable Entity
- `500`: Internal Server Error

---

### VoiceCalls

#### `POST` /api/v1/voice-calls

**Initiate encrypted voice call**

Creates a new encrypted voice call session and returns connection details and server keying material.

*Requirement:* WA-CALL-001

**Request Body:** `CreateVoiceCallRequest`

**Responses:**

- `201`: Created
- `400`: Bad Request
- `401`: Unauthorized
- `403`: Forbidden
- `409`: Conflict

---

#### `GET` /api/v1/voice-calls

**List voice calls**

Returns a paginated list of voice calls for the authenticated user.

*Requirement:* WA-CALL-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| page | query | integer | False | Page number for pagination |
| pageSize | query | integer | False | Number of items per page |
| status | query | string | False | Filter by call status |

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `403`: Forbidden

---

#### `GET` /api/v1/voice-calls/{callId}

**Get voice call details**

Fetches details of a specific encrypted voice call session.

*Requirement:* WA-CALL-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| callId | path | string | True | Voice call identifier |

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `403`: Forbidden
- `404`: Not Found

---

#### `PUT` /api/v1/voice-calls/{callId}

**Update voice call state**

Updates the status of an encrypted voice call (e.g., accept, decline, end) and optionally provides keying material from the callee.

*Requirement:* WA-CALL-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| callId | path | string | True | Voice call identifier |

**Request Body:** `UpdateVoiceCallRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `403`: Forbidden
- `404`: Not Found
- `409`: Conflict

---

#### `DELETE` /api/v1/voice-calls/{callId}

**Terminate voice call**

Ends an encrypted voice call session and releases associated resources.

*Requirement:* WA-CALL-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| callId | path | string | True | Voice call identifier |

**Responses:**

- `204`: No Content
- `401`: Unauthorized
- `403`: Forbidden
- `404`: Not Found

---

### VoiceMessages

#### `POST` /api/v1/voice-messages/transcriptions

**Transcribe a voice message**

Accepts an audio payload and returns the transcription result.

*Requirement:* WA-ACC-004

**Request Body:** `CreateTranscriptionRequest`

**Responses:**

- `201`: Created
- `400`: Bad Request
- `401`: Unauthorized
- `413`: Payload Too Large
- `415`: Unsupported Media Type
- `500`: Internal Server Error

---

### WatchApp

#### `POST` /api/v1/watch-app/devices

**Register smartwatch device**

Registers a smartwatch device for the authenticated user.

*Requirement:* WA-INT-004

**Request Body:** `RegisterWatchDeviceRequest`

**Responses:**

- `201`: Created
- `400`: Bad Request
- `401`: Unauthorized
- `409`: Conflict

---

#### `GET` /api/v1/watch-app/devices

**List registered smartwatch devices**

Returns a paginated list of registered smartwatch devices for the authenticated user.

*Requirement:* WA-INT-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| page | query | integer | False | Page number (default 1) |
| pageSize | query | integer | False | Number of items per page (default 20) |

**Responses:**

- `200`: Success
- `401`: Unauthorized

---

#### `GET` /api/v1/watch-app/devices/{deviceId}

**Get smartwatch device**

Retrieves details for a specific smartwatch device.

*Requirement:* WA-INT-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| deviceId | path | string | True | Device ID |

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `404`: Not Found

---

#### `PUT` /api/v1/watch-app/devices/{deviceId}

**Update smartwatch device**

Updates metadata for a smartwatch device.

*Requirement:* WA-INT-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| deviceId | path | string | True | Device ID |

**Request Body:** `UpdateWatchDeviceRequest`

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Not Found

---

#### `DELETE` /api/v1/watch-app/devices/{deviceId}

**Delete smartwatch device**

Removes a smartwatch device registration.

*Requirement:* WA-INT-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| deviceId | path | string | True | Device ID |

**Responses:**

- `204`: No Content
- `401`: Unauthorized
- `404`: Not Found

---

#### `POST` /api/v1/watch-app/pairings

**Pair smartwatch device**

Creates a pairing between the user and a smartwatch device.

*Requirement:* WA-INT-004

**Request Body:** `PairWatchDeviceRequest`

**Responses:**

- `201`: Created
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Not Found

---

#### `DELETE` /api/v1/watch-app/pairings/{pairingId}

**Unpair smartwatch device**

Removes a pairing between the user and a smartwatch device.

*Requirement:* WA-INT-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| pairingId | path | string | True | Pairing ID |

**Responses:**

- `204`: No Content
- `401`: Unauthorized
- `404`: Not Found

---

#### `POST` /api/v1/watch-app/sync

**Initiate smartwatch data sync**

Triggers a data synchronization for a paired smartwatch device.

*Requirement:* WA-INT-004

**Request Body:** `SyncWatchDataRequest`

**Responses:**

- `202`: Accepted
- `400`: Bad Request
- `401`: Unauthorized
- `404`: Not Found

---

#### `GET` /api/v1/watch-app/data

**Get smartwatch data**

Retrieves synchronized smartwatch data for the authenticated user.

*Requirement:* WA-INT-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| type | query | string | False | Data type filter (e.g., steps, heartRate, sleep) |
| fromTimestamp | query | string | False | Start time filter (ISO 8601) |
| toTimestamp | query | string | False | End time filter (ISO 8601) |
| page | query | integer | False | Page number (default 1) |
| pageSize | query | integer | False | Number of items per page (default 50) |

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized

---

### WebVersion

#### `GET` /api/v1/web-version

**Get web version information**

Returns metadata about the available web version to ensure the system provides a web interface.

*Requirement:* WA-INT-006

**Responses:**

- `200`: Success
- `401`: Unauthorized
- `500`: Internal Server Error

---

### Widgets

#### `GET` /api/v1/widgets

**List available widgets**

Returns a paginated list of widgets available for the home screen.

*Requirement:* WA-INT-003

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| page | query | integer | False | Page number for pagination |
| pageSize | query | integer | False | Number of items per page |

**Responses:**

- `200`: Success
- `400`: Bad Request
- `401`: Unauthorized

---

## Schemas

### AbsenceMessageListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of absence messages |
| page | integer | Current page number |
| pageSize | integer | Items per page |
| totalItems | integer | Total number of items |
| totalPages | integer | Total number of pages |

### AbsenceMessageResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Absence message ID |
| message | string | Automatic reply message |
| startDate | string | Start date in ISO 8601 |
| endDate | string | End date in ISO 8601 |
| active | boolean | Whether the message is active |

### AcceptInviteLinkRequest

### AcceptInviteLinkResponse

| Property | Type | Description |
|----------|------|-------------|
| groupId | string | Group ID |
| memberId | string | New member ID |
| role | string | Assigned role in the group |

### AccessibilitySettingsResponse

| Property | Type | Description |
|----------|------|-------------|
| userId | string | User ID |
| screenReaderEnabled | boolean | Whether screenreader support is enabled |
| ariaHintsEnabled | boolean | Whether ARIA hinting is enabled |
| highContrastEnabled | boolean | Whether high contrast mode is enabled |
| textAlternativesEnabled | boolean | Whether text alternatives for non-text content are enabled |

### AcknowledgeNotificationRequest

| Property | Type | Description |
|----------|------|-------------|
| deviceId | string | Device registration ID |
| receivedAt | string | Client receipt timestamp |

### AcknowledgeNotificationResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Acknowledgement ID |
| status | string | Acknowledgement status |

### AddAllowedUsersRequest

| Property | Type | Description |
|----------|------|-------------|
| userIds | array | User IDs to allow |

### AddCartItemRequest

| Property | Type | Description |
|----------|------|-------------|
| productId | string | Product identifier |
| quantity | integer | Quantity of the product |

### AddParticipantsRequest

| Property | Type | Description |
|----------|------|-------------|
| participantIds | array | Participant user IDs to add |

### AddReactionRequest

| Property | Type | Description |
|----------|------|-------------|
| emoji | string | Unicode emoji character to add as reaction |

### AddRecipientsRequest

| Property | Type | Description |
|----------|------|-------------|
| recipientIds | array | Array of recipient IDs |

### AddRecipientsResponse

| Property | Type | Description |
|----------|------|-------------|
| listId | string | Broadcast list ID |
| addedCount | integer | Number of recipients added |

### AiChatListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of chat sessions |
| page | integer | Current page number |
| pageSize | integer | Number of items per page |
| totalItems | integer | Total number of items |

### AiChatMessageListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of messages |
| page | integer | Current page number |
| pageSize | integer | Number of items per page |
| totalItems | integer | Total number of items |

### AiChatMessageResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Message ID |
| chatId | string | Chat session ID |
| role | string | Role of the message sender (user or assistant) |
| message | string | Message content |
| createdAt | string | Timestamp (ISO 8601) |

### AiChatResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Chat session ID |
| title | string | Chat session title |
| assistantId | string | AI assistant identifier |
| createdAt | string | Creation timestamp (ISO 8601) |

### AllowedUsersListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of allowed users |

### AppLockConfigRequest

| Property | Type | Description |
|----------|------|-------------|
| enabled | boolean | Enable or disable app lock |
| authMethod | string | Authentication method (e.g., pin, biometric) |
| pin | string | PIN code if authMethod is pin |

### AppLockConfigResponse

| Property | Type | Description |
|----------|------|-------------|
| enabled | boolean | Indicates if app lock is enabled |
| authMethod | string | Authentication method |

### AppLockStatusResponse

| Property | Type | Description |
|----------|------|-------------|
| enabled | boolean | Indicates if app lock is enabled |
| authMethod | string | Authentication method (e.g., pin, biometric) |

### AppStartupResponse

| Property | Type | Description |
|----------|------|-------------|
| startupToken | string | Token indicating bootstrap payload version for caching |
| featureFlags | object | Key-value map of enabled features |
| configHash | string | Hash of configuration for cache validation |
| minimalUserContext | object | Minimal user context needed at startup |
| serverTime | string | Server time in ISO-8601 format |

### AppUnlockRequest

| Property | Type | Description |
|----------|------|-------------|
| authMethod | string | Authentication method used (e.g., pin, biometric) |
| pin | string | PIN code if authMethod is pin |
| biometricToken | string | Biometric assertion token if authMethod is biometric |

### AppUnlockResponse

| Property | Type | Description |
|----------|------|-------------|
| unlocked | boolean | Indicates if the app is unlocked |
| sessionToken | string | Session token for unlocked state |

### ArchiveChatRequest

### AssignContactLabelsRequest

| Property | Type | Description |
|----------|------|-------------|
| labelIds | array | List of label IDs to assign |

### AssignContactLabelsResponse

| Property | Type | Description |
|----------|------|-------------|
| contactId | string | Contact ID |
| assignedLabelIds | array | Labels assigned to the contact |

### AudioFileResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Audio file ID |
| fileName | string | Stored file name |
| contentType | string | MIME type of the stored audio file |
| sizeBytes | integer | Size of the audio file in bytes |
| createdAt | string | Creation timestamp in ISO 8601 format |

### BackupListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of backup summaries |
| page | integer | Current page number |
| pageSize | integer | Number of items per page |
| totalItems | integer | Total number of backups |

### BackupMetadataResponse

| Property | Type | Description |
|----------|------|-------------|
| backupId | string | Backup identifier |
| sourceId | string | Identifier of the client/source |
| createdAt | string | ISO 8601 timestamp of creation |
| sizeBytes | integer | Size of encrypted payload in bytes |
| encryptionScheme | string | Encryption algorithm and mode used by the client |
| encryptionContext | object | Opaque client-defined context for decryption (non-secret metadata) |

### BackupResponse

| Property | Type | Description |
|----------|------|-------------|
| backupId | string | Backup identifier |
| sourceId | string | Identifier of the client/source |
| createdAt | string | ISO 8601 timestamp of creation |
| sizeBytes | integer | Size of encrypted payload in bytes |

### BinaryContent

| Property | Type | Description |
|----------|------|-------------|
| content | string | Binary stream |

### BlockContactRequest

| Property | Type | Description |
|----------|------|-------------|
| reason | string | Optional reason for blocking the contact |

### BlockContactResponse

| Property | Type | Description |
|----------|------|-------------|
| contactId | string | Blocked contact ID |
| blockedAt | string | Timestamp when the contact was blocked |
| status | string | Block status |

### BroadcastChannelListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of channels |
| page | integer | Current page |
| pageSize | integer | Items per page |
| totalItems | integer | Total number of items |
| totalPages | integer | Total pages |

### BroadcastChannelResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Channel ID |
| name | string | Human-readable channel name |
| description | string | Channel description |
| isPrivate | boolean | Whether the channel is private |
| createdAt | string | Creation timestamp (ISO 8601) |

### BroadcastListPage

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of broadcast lists |
| page | integer | Current page |
| pageSize | integer | Page size |
| totalItems | integer | Total items |
| totalPages | integer | Total pages |

### BroadcastListResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Broadcast list ID |
| name | string | Broadcast list name |
| description | string | Optional description |
| updatedAt | string | Update timestamp (ISO 8601) |

### BroadcastMessageListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of messages |
| page | integer | Current page |
| pageSize | integer | Items per page |
| totalItems | integer | Total number of items |
| totalPages | integer | Total pages |

### BroadcastMessageResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Message ID |
| channelId | string | Channel ID |
| content | string | Message content |
| contentType | string | Content type |
| createdAt | string | Creation timestamp (ISO 8601) |

### BusinessMessageStatsResponse

| Property | Type | Description |
|----------|------|-------------|
| businessId | string | Business ID |
| from | string | Start of time range (ISO 8601) |
| to | string | End of time range (ISO 8601) |
| totalMessages | integer | Total messages in range |
| inboundMessages | integer | Inbound messages count |
| outboundMessages | integer | Outbound messages count |
| failedMessages | integer | Failed messages count |
| timeSeries | array | Aggregated statistics by time bucket |

### BusinessProfileListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of business profiles |
| page | integer | Current page |
| pageSize | integer | Items per page |
| totalItems | integer | Total number of items |
| totalPages | integer | Total number of pages |

### BusinessProfileResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Business profile ID |
| name | string | Business name |
| legalName | string | Registered legal name |
| registrationNumber | string | Business registration number |
| taxId | string | Tax identification number |
| industry | string | Industry classification |
| website | string | Business website URL |
| phone | string | Primary contact phone |
| email | string | Primary contact email |
| address | object | Business address |
| metadata | object | Additional profile attributes |
| createdAt | string | Creation timestamp |
| updatedAt | string | Last update timestamp |

### BusinessVerificationListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of verification requests |
| page | integer | Current page |
| pageSize | integer | Items per page |
| totalItems | integer | Total number of items |
| totalPages | integer | Total number of pages |

### BusinessVerificationResponse

| Property | Type | Description |
|----------|------|-------------|
| verificationId | string | Verification request ID |
| businessId | string | Business ID |
| status | string | Verification status (pending, approved, rejected) |
| rejectionReason | string | Reason for rejection, if applicable |
| reviewedAt | string | Review timestamp (ISO 8601) |

### BusinessVerificationReviewResponse

| Property | Type | Description |
|----------|------|-------------|
| verificationId | string | Verification request ID |
| status | string | Updated status |
| reviewedAt | string | Review timestamp (ISO 8601) |

### CallHistoryListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of call history records |
| page | integer | Current page number |
| pageSize | integer | Page size |
| totalItems | integer | Total number of records |
| totalPages | integer | Total number of pages |

### CallHistoryResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Call history record ID |
| callerId | string | Identifier of the caller |
| calleeId | string | Identifier of the callee |
| startedAt | string | Call start timestamp (ISO 8601) |
| endedAt | string | Call end timestamp (ISO 8601) |
| durationSeconds | integer | Call duration in seconds |
| direction | string | Call direction (inbound|outbound) |
| status | string | Call status (completed|missed|failed) |
| createdAt | string | Record creation timestamp (ISO 8601) |

### CallLinkResponse

| Property | Type | Description |
|----------|------|-------------|
| callId | string | Scheduled call ID |
| linkId | string | Call link ID |
| url | string | Call link URL |
| expiresAt | string | Expiration timestamp in ISO 8601 format |
| createdAt | string | Creation timestamp in ISO 8601 format |

### CallNotificationSettingsResponse

| Property | Type | Description |
|----------|------|-------------|
| userId | string | User ID |
| enabled | boolean | Whether call notifications are enabled |
| channels | array | Notification channels to use for calls |
| quietHours | object | Quiet hours configuration for call notifications |

### CallResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Call session ID |
| status | string | Call status |
| ipMasked | boolean | Whether IP addresses are masked for this call |

### CameraSessionResponse

| Property | Type | Description |
|----------|------|-------------|
| sessionId | string | Camera session ID |
| uploadUrl | string | Pre-signed URL for direct upload of captured media |
| uploadHeaders | object | Headers required for upload |
| expiresAt | string | ISO-8601 timestamp when the session expires |

### CancelPaymentRequest

| Property | Type | Description |
|----------|------|-------------|
| reason | string | Cancellation reason |

### CancelPaymentResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Payment ID |
| status | string | Updated status |

### CartItemListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of cart items |
| page | integer | Current page |
| pageSize | integer | Items per page |
| totalItems | integer | Total number of items |

### CartItemResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Cart item ID |
| productId | string | Product identifier |
| quantity | integer | Quantity of the product |

### CartResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Cart ID |
| customerId | string | Customer identifier |
| currency | string | ISO currency code |
| status | string | Cart status |

### ChatArchiveResponse

| Property | Type | Description |
|----------|------|-------------|
| chatId | string | Chat ID |
| archived | boolean | Indicates whether the chat is archived |
| archivedAt | string | Timestamp when the chat was archived |

### ChatBackgroundListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of chat backgrounds |
| page | integer | Current page number |
| pageSize | integer | Items per page |
| totalItems | integer | Total number of items |
| totalPages | integer | Total number of pages |

### ChatBackgroundResponse

| Property | Type | Description |
|----------|------|-------------|
| backgroundId | string | Selected background ID |
| customImageUrl | string | Custom image URL if uploaded for chat |
| type | string | Background type (image, color, gradient) |
| color | string | Color value if type is color |
| inheritsUserDefault | boolean | Whether chat uses user's default background |

### ChatBackupListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of chat backups |
| page | integer | Current page number |
| pageSize | integer | Number of items per page |
| totalItems | integer | Total number of items |

### ChatBackupResponse

| Property | Type | Description |
|----------|------|-------------|
| backupId | string | Backup identifier |
| chatId | string | Identifier of the chat backed up |
| status | string | Backup status |
| createdAt | string | ISO-8601 timestamp when backup was created |

### ChatExportResponse

| Property | Type | Description |
|----------|------|-------------|
| chatId | string | Unique identifier of the exported chat |
| format | string | Format of the exported chat |
| exportUrl | string | URL to download the exported chat file |
| expiresAt | string | Expiration timestamp for the export URL |

### ChatMessageResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Message ID |
| chatId | string | Chat ID |
| mediaId | string | Media ID |
| mediaType | string | Type of media (image or video) |
| caption | string | Caption |
| createdAt | string | ISO-8601 timestamp when the message was created |

### ChatTransferResponse

| Property | Type | Description |
|----------|------|-------------|
| transferId | string | Transfer session identifier |
| transferToken | string | Token to be used by the new device to import chat history |
| status | string | Current status of the transfer session |
| expiresAt | string | Expiration timestamp for the transfer token (ISO 8601) |

### ChatTransferStatusResponse

| Property | Type | Description |
|----------|------|-------------|
| transferId | string | Transfer session identifier |
| status | string | Current status (e.g., pending, inProgress, completed, failed) |
| expiresAt | string | Expiration timestamp for the transfer token (ISO 8601) |

### CommunityListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of communities |
| page | integer | Current page |
| pageSize | integer | Items per page |
| totalItems | integer | Total number of communities |
| totalPages | integer | Total number of pages |

### CommunityResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Community ID |
| name | string | Community name |
| description | string | Community description |
| updatedAt | string | Update timestamp (ISO 8601) |

### ContactLabelListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of contact labels |
| page | integer | Current page |
| pageSize | integer | Items per page |
| total | integer | Total number of items |

### ContactLabelResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Label ID |
| name | string | Label name |
| color | string | Optional color code |

### ContactResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Contact ID |
| firstName | string | First name |
| lastName | string | Last name |
| email | string | Email address |
| phone | string | Phone number |
| source | string | Contact source identifier |
| createdAt | string | Creation timestamp |

### ContactStatusResponse

| Property | Type | Description |
|----------|------|-------------|
| contactId | string | Unique identifier of the contact |
| status | string | Current status of the contact (e.g., online, offline, busy) |
| lastUpdated | string | ISO 8601 timestamp of the last status update |

### ContactsSyncRequest

| Property | Type | Description |
|----------|------|-------------|
| deviceId | string | Unique identifier of the device performing the sync |
| contacts | array | List of device contacts to be synchronized |

### ContactsSyncResponse

| Property | Type | Description |
|----------|------|-------------|
| matchedContacts | array | Contacts that are WhatsApp users |
| unmatchedContacts | array | Contacts that are not WhatsApp users |

### ContrastCheckRequest

| Property | Type | Description |
|----------|------|-------------|
| pairs | array | List of color pairs to validate |

### ContrastCheckResponse

| Property | Type | Description |
|----------|------|-------------|
| results | array | Validation results per color pair |

### CreateAbsenceMessageRequest

| Property | Type | Description |
|----------|------|-------------|
| message | string | Automatic reply message |
| startDate | string | Start date in ISO 8601 |
| endDate | string | End date in ISO 8601 |
| active | boolean | Whether the message is active |

### CreateAiChatMessageRequest

| Property | Type | Description |
|----------|------|-------------|
| message | string | User message content |
| context | object | Optional context to provide to the assistant |

### CreateAiChatRequest

| Property | Type | Description |
|----------|------|-------------|
| title | string | Optional user-defined title for the chat session |
| assistantId | string | Identifier of the AI assistant to use |
| metadata | object | Optional metadata for the chat session |

### CreateBackupRequest

| Property | Type | Description |
|----------|------|-------------|
| sourceId | string | Identifier of the client/source creating the backup |
| encryptedData | string | Base64-encoded encrypted backup payload |
| encryptionScheme | string | Encryption algorithm and mode used by the client (e.g., XChaCha20-Poly1305) |
| encryptionContext | object | Opaque client-defined context for decryption (non-secret metadata) |
| checksum | string | Checksum of the encrypted payload for integrity verification |

### CreateBroadcastChannelRequest

| Property | Type | Description |
|----------|------|-------------|
| name | string | Human-readable channel name |
| description | string | Channel description |
| isPrivate | boolean | Whether the channel is private |

### CreateBroadcastListRequest

| Property | Type | Description |
|----------|------|-------------|
| name | string | Broadcast list name |
| description | string | Optional description |

### CreateBusinessProfileRequest

| Property | Type | Description |
|----------|------|-------------|
| name | string | Business name |
| legalName | string | Registered legal name |
| registrationNumber | string | Business registration number |
| taxId | string | Tax identification number |
| industry | string | Industry classification |
| website | string | Business website URL |
| phone | string | Primary contact phone |
| email | string | Primary contact email |
| address | object | Business address |
| metadata | object | Additional profile attributes |

### CreateBusinessVerificationRequest

| Property | Type | Description |
|----------|------|-------------|
| legalName | string | Registered legal name of the business |
| registrationNumber | string | Official registration number |
| country | string | Country of registration (ISO 3166-1 alpha-2) |
| documents | array | List of verification documents |

### CreateCallHistoryRequest

| Property | Type | Description |
|----------|------|-------------|
| callerId | string | Identifier of the caller |
| calleeId | string | Identifier of the callee |
| startedAt | string | Call start timestamp (ISO 8601) |
| endedAt | string | Call end timestamp (ISO 8601) |
| durationSeconds | integer | Call duration in seconds |
| direction | string | Call direction (inbound|outbound) |
| status | string | Call status (completed|missed|failed) |

### CreateCallLinkRequest

| Property | Type | Description |
|----------|------|-------------|
| expiresAt | string | Optional expiration timestamp for the link in ISO 8601 format |
| reuseExisting | boolean | If true, returns existing link when available instead of creating a new one |

### CreateCallRequest

| Property | Type | Description |
|----------|------|-------------|
| callerId | string | Identifier of the caller |
| calleeId | string | Identifier of the callee |
| maskIp | boolean | Overrides default setting to mask IP addresses for this call |

### CreateCameraSessionRequest

| Property | Type | Description |
|----------|------|-------------|
| mediaType | string | Type of media to capture (image or video) |
| expiresInSeconds | integer | Optional session expiration in seconds |

### CreateCartRequest

| Property | Type | Description |
|----------|------|-------------|
| customerId | string | Customer identifier (optional for anonymous carts) |
| currency | string | ISO currency code |

### CreateChatBackupRequest

| Property | Type | Description |
|----------|------|-------------|
| chatId | string | Identifier of the chat to back up |
| includeMedia | boolean | Whether to include media attachments in the backup |

### CreateChatMediaMessageRequest

| Property | Type | Description |
|----------|------|-------------|
| mediaId | string | ID of the uploaded media |
| mediaType | string | Type of media (image or video) |
| caption | string | Optional caption for the media |

### CreateChatTransferRequest

| Property | Type | Description |
|----------|------|-------------|
| deviceId | string | Identifier of the current device |
| expiresInSeconds | integer | Optional expiry for the transfer token |

### CreateCommunityRequest

| Property | Type | Description |
|----------|------|-------------|
| name | string | Community name |
| description | string | Community description |

### CreateContactLabelRequest

| Property | Type | Description |
|----------|------|-------------|
| name | string | Label name |
| color | string | Optional color code |

### CreateContactRequest

| Property | Type | Description |
|----------|------|-------------|
| firstName | string | First name |
| lastName | string | Last name |
| email | string | Email address |
| phone | string | Phone number |
| source | string | Contact source identifier |

### CreateEncryptionVerificationRequest

| Property | Type | Description |
|----------|------|-------------|
| verificationCode | string | Der manuell zu verifizierende Sicherheits-/Verschlüsselungscode |
| context | string | Optionaler Kontext der Verifizierung (z. B. System, Vorgang) |
| verifierUserId | string | ID des Benutzers, der die manuelle Verifizierung durchführt |

### CreateGroupCallRequest

| Property | Type | Description |
|----------|------|-------------|
| title | string | Human-readable call title |
| type | string | Call type: voice or video |
| initiatorId | string | User ID of the call initiator |
| participantIds | array | Initial participant user IDs |

### CreateGroupChatMessageRequest

| Property | Type | Description |
|----------|------|-------------|
| content | string | Message content |
| mentionedUserIds | array | List of user IDs mentioned in the message |

### CreateGroupEventRequest

| Property | Type | Description |
|----------|------|-------------|
| title | string | Event title |
| description | string | Event description |
| startTime | string | Event start time in ISO 8601 |
| endTime | string | Event end time in ISO 8601 |
| location | string | Event location |

### CreateGroupInviteLinkRequest

| Property | Type | Description |
|----------|------|-------------|
| expiresAt | string | Optional ISO-8601 expiration timestamp for the invite link |
| maxUses | integer | Optional maximum number of times the link can be used |

### CreateGroupRequest

| Property | Type | Description |
|----------|------|-------------|
| name | string | Group name |
| description | string | Group description |

### CreateImageEditRequest

| Property | Type | Description |
|----------|------|-------------|
| crop | object | Crop rectangle in pixels |
| rotate | integer | Rotation angle in degrees (e.g., 0, 90, 180, 270) |
| resize | object | Resize dimensions in pixels |
| filter | string | Basic filter to apply |
| quality | integer | Output quality percentage (1-100) |
| format | string | Output image format |

### CreateIntegrationRequest

| Property | Type | Description |
|----------|------|-------------|
| name | string | Integration client name |
| scopes | array | Permissions granted to the client |

### CreateLocationShareRequest

| Property | Type | Description |
|----------|------|-------------|
| senderUserId | string | ID of the user sharing the location |
| recipientUserIds | array | IDs of users who will receive the shared location |
| location | object | Geographic location data |
| message | string | Optional message to accompany the location share |
| expiresAt | string | Optional expiration timestamp (ISO 8601) |

### CreateMediaRequest

| Property | Type | Description |
|----------|------|-------------|
| fileName | string | Original file name |
| contentType | string | MIME type of the media |
| quality | string | Requested media quality (e.g., HD) |
| uploadUrl | string | Pre-signed URL or reference to upload the media content |

### CreateMessageReplyRequest

| Property | Type | Description |
|----------|------|-------------|
| conversationId | string | ID of the conversation/thread where the reply is posted |
| content | string | Text content of the reply |
| attachments | array | Optional list of attachment IDs |

### CreateMessageRequest

| Property | Type | Description |
|----------|------|-------------|
| senderId | string | Identifier of the sender if known |
| senderAddress | string | Address or identifier of the sender when senderId is not available |
| content | string | Message content |

### CreateNotificationPreviewConfigRequest

| Property | Type | Description |
|----------|------|-------------|
| name | string | Configuration name |
| channel | string | Notification channel (e.g., email, sms, push) |
| template | string | Preview template content |
| locale | string | Locale for preview rendering |
| placeholders | array | Supported placeholder keys |

### CreateNotificationPreviewRequest

| Property | Type | Description |
|----------|------|-------------|
| configId | string | Configuration ID to use for preview |
| data | object | Dynamic data for placeholder substitution |
| channel | string | Override notification channel (optional) |
| locale | string | Override locale (optional) |

### CreatePaymentRequest

| Property | Type | Description |
|----------|------|-------------|
| amount | number | Payment amount |
| currency | string | ISO 4217 currency code |
| payerId | string | WhatsApp user ID of payer |
| payeeId | string | WhatsApp user ID of payee |
| market | string | Market/region code |
| reference | string | Client reference for idempotency |

### CreatePhoneRegistrationRequest

| Property | Type | Description |
|----------|------|-------------|
| phoneNumber | string | E.164 formatted phone number |
| locale | string | Locale for OTP message (e.g., de-DE) |

### CreatePollRequest

| Property | Type | Description |
|----------|------|-------------|
| question | string | Poll question |
| options | array | List of poll options |
| multipleChoice | boolean | Whether multiple selections are allowed |
| expiresAt | string | ISO-8601 expiration timestamp (optional) |

### CreateProductRequest

| Property | Type | Description |
|----------|------|-------------|
| name | string | Product name |
| description | string | Product description |
| price | number | Product price |
| currency | string | Currency code |
| sku | string | Stock keeping unit |
| category | string | Product category |
| status | string | Product status |

### CreateQuickReplyRequest

| Property | Type | Description |
|----------|------|-------------|
| title | string | Short label for the quick reply |
| message | string | Quick reply message text |
| language | string | Language code (e.g., de, en) |
| isActive | boolean | Whether the quick reply is active |

### CreateReadReceiptRequest

| Property | Type | Description |
|----------|------|-------------|
| readAt | string | ISO-8601 timestamp of when the message was read |

### CreateReportRequest

| Property | Type | Description |
|----------|------|-------------|
| targetType | string | Type of target being reported (e.g., message, contact) |
| targetId | string | ID of the message or contact being reported |
| reason | string | Reason for reporting |
| details | string | Optional additional details for the report |

### CreateSessionRequest

| Property | Type | Description |
|----------|------|-------------|
| username | string | User login name |
| password | string | User password |
| deviceId | string | Unique device identifier |
| deviceName | string | Human-readable device name |
| deviceType | string | Device type (e.g., mobile, desktop, tablet) |

### CreateShareRequest

| Property | Type | Description |
|----------|------|-------------|
| contentType | string | Type of content to share (e.g., text, url, file) |
| content | string | Content payload or URL to be shared |
| title | string | Optional title for the shared content |
| recipients | array | Optional list of recipient identifiers |
| metadata | object | Optional metadata for the share request |

### CreateSpamDetectionRequest

| Property | Type | Description |
|----------|------|-------------|
| content | string | Text content to analyze for spam |
| contentType | string | Type of content (e.g., text, comment, message) |
| source | string | Origin or context of the content (e.g., forum, email, chat) |
| language | string | Language code of the content (e.g., de, en) |

### CreateStatusRequest

| Property | Type | Description |
|----------|------|-------------|
| text | string | Text content of the status update |
| mediaUrls | array | Optional list of media URLs attached to the status update |
| visibility | string | Visibility of the status update (e.g., public, friends, private) |

### CreateStatusVisibilityRequest

| Property | Type | Description |
|----------|------|-------------|
| statusId | string | Status ID |
| audienceType | string | Audience type (e.g., role, group, user) |
| audienceId | string | Audience identifier |
| visibility | string | Visibility setting (e.g., visible, hidden) |

### CreateStickerSuggestionsRequest

| Property | Type | Description |
|----------|------|-------------|
| text | string | User message or context text used to derive sticker suggestions |
| language | string | BCP-47 language tag of the context text |
| context | object | Additional contextual metadata |
| limit | integer | Maximum number of suggestions to return |

### CreateTranscriptionRequest

| Property | Type | Description |
|----------|------|-------------|
| audioBase64 | string | Base64-encoded audio content |
| audioUrl | string | URL to the audio file; provide either audioBase64 or audioUrl |
| language | string | BCP-47 language tag for transcription (e.g., de-DE) |

### CreateUserWidgetRequest

| Property | Type | Description |
|----------|------|-------------|
| widgetId | string | Widget ID |
| position | integer | Widget position on home screen |
| settings | object | Widget settings |

### CreateVideoCallRequest

| Property | Type | Description |
|----------|------|-------------|
| participants | array | List of participant user IDs |
| encryption | object | Encryption configuration for the call |

### CreateVoiceAssistantLinkRequest

| Property | Type | Description |
|----------|------|-------------|
| authorizationCode | string | OAuth authorization code from the assistant provider |
| redirectUri | string | Redirect URI used in the OAuth flow |

### CreateVoiceCallRequest

| Property | Type | Description |
|----------|------|-------------|
| callerId | string | Identifier of the calling user |
| calleeId | string | Identifier of the called user |
| encryption | object | Encryption preferences for the call |

### DataUsageHistoryResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | Usage records |
| page | integer | Current page number |
| pageSize | integer | Items per page |
| totalItems | integer | Total number of items |
| totalPages | integer | Total number of pages |

### DataUsageLimitsRequest

| Property | Type | Description |
|----------|------|-------------|
| hardLimitBytes | integer | Maximum allowed bytes before blocking |
| softLimitBytes | integer | Threshold for warnings |
| period | string | Limit period (e.g., DAILY, MONTHLY) |

### DataUsageLimitsResponse

| Property | Type | Description |
|----------|------|-------------|
| hardLimitBytes | integer | Maximum allowed bytes before blocking |
| softLimitBytes | integer | Threshold for warnings |
| period | string | Limit period (e.g., DAILY, MONTHLY) |
| updatedAt | string | ISO-8601 update timestamp |

### DataUsageResponse

| Property | Type | Description |
|----------|------|-------------|
| periodStart | string | ISO-8601 period start |
| periodEnd | string | ISO-8601 period end |
| totalBytes | integer | Total data used in bytes |
| currency | string | Unit for billing or display |

### DeleteBiometricResponse

| Property | Type | Description |
|----------|------|-------------|
| status | string | Deletion status |

### DeleteChatBackgroundResponse

| Property | Type | Description |
|----------|------|-------------|
| message | string | Result message |

### DeleteContactLabelResponse

| Property | Type | Description |
|----------|------|-------------|
| deleted | boolean | Whether the label was deleted |

### DeleteReactionResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Reaction ID |
| deleted | boolean | Indicates whether the reaction was deleted |

### DeleteStatusVisibilityResponse

| Property | Type | Description |
|----------|------|-------------|
| deleted | boolean | Indicates whether the configuration was deleted |

### DesktopAppListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of desktop apps |
| page | integer | Current page number |
| pageSize | integer | Items per page |
| totalItems | integer | Total number of items |

### DesktopAppResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Desktop app ID |
| name | string | Desktop app name |
| platform | string | Supported platform |
| latestVersion | string | Latest available version |
| releaseNotes | string | Latest release notes |
| downloadUrl | string | Direct download URL |

### DeviceRegistrationResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Device registration ID |
| userId | string | User identifier |
| platform | string | Device platform |
| status | string | Registration status |
| createdAt | string | Creation timestamp |

### DeviceResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Device registration ID |
| status | string | Registration status |
| updatedAt | string | Update timestamp |

### DisablePinRequest

| Property | Type | Description |
|----------|------|-------------|
| currentPin | string | Current PIN |

### DisableTwoFactorRequest

| Property | Type | Description |
|----------|------|-------------|
| pin | string | 6-digit PIN to confirm disabling 2FA |

### DisableTwoFactorResponse

| Property | Type | Description |
|----------|------|-------------|
| twoFactorEnabled | boolean | Indicates whether 2FA is enabled |

### DoNotDisturbResponse

| Property | Type | Description |
|----------|------|-------------|
| userId | string | User ID |
| enabled | boolean | Whether do-not-disturb is enabled |
| updatedAt | string | ISO 8601 timestamp of last update |

### EffectiveVisibilityResponse

| Property | Type | Description |
|----------|------|-------------|
| statusId | string | Status ID |
| visibility | string | Effective visibility setting |

### EnablePinRequest

| Property | Type | Description |
|----------|------|-------------|
| pin | string | User-defined PIN |
| pinConfirmation | string | Confirmation of the PIN |

### EnableTwoFactorRequest

| Property | Type | Description |
|----------|------|-------------|
| deliveryMethod | string | Preferred delivery method for the 6-digit PIN (e.g., sms, email, app) |

### EnableTwoFactorResponse

| Property | Type | Description |
|----------|------|-------------|
| twoFactorEnabled | boolean | Indicates whether 2FA is enabled |
| challengeId | string | Identifier for the 2FA challenge |

### EncryptedMessageListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of encrypted messages |
| page | integer | Current page |
| pageSize | integer | Items per page |
| total | integer | Total number of items |

### EncryptedMessageResponse

| Property | Type | Description |
|----------|------|-------------|
| messageId | string | Message identifier |
| senderId | string | Sender identifier |
| recipientId | string | Recipient identifier |
| ciphertext | string | Encrypted message payload (base64) |
| nonce | string | Nonce or IV used for encryption |
| algorithm | string | Encryption algorithm |
| createdAt | string | ISO-8601 timestamp |

### EncryptionVerificationResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Eindeutige ID der Verifizierung |
| verificationCode | string | Der verifizierte Sicherheits-/Verschlüsselungscode |
| status | string | Ergebnis der Verifizierung (z. B. VERIFIED, FAILED) |
| verifiedAt | string | Zeitpunkt der Verifizierung (ISO 8601) |
| verifierUserId | string | ID des verifizierenden Benutzers |

### EndGroupCallRequest

| Property | Type | Description |
|----------|------|-------------|
| endedBy | string | User ID who ended the call |

### EndVideoCallResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string |  |
| status | string | Final call status |
| endedAt | string | End timestamp |

### FavoriteContactListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of favorite contacts |
| page | integer | Current page number |
| pageSize | integer | Number of items per page |
| totalItems | integer | Total number of favorite contacts |

### FavoriteContactResponse

| Property | Type | Description |
|----------|------|-------------|
| contactId | string | Contact ID |
| isFavorite | boolean | Indicates if the contact is a favorite |

### FirstContactGreetingRequest

| Property | Type | Description |
|----------|------|-------------|
| channel | string | Override channel for this greeting (optional) |

### FirstContactGreetingResponse

| Property | Type | Description |
|----------|------|-------------|
| greetingSent | boolean | Indicates whether a greeting was sent |
| messageId | string | Identifier of the sent greeting message |
| reason | string | Reason if greeting not sent (e.g., already greeted) |

### ForwardMessageRequest

| Property | Type | Description |
|----------|------|-------------|
| recipientIds | array | List of recipient user IDs |
| comment | string | Optional comment to include with the forwarded message |

### ForwardMessageResponse

| Property | Type | Description |
|----------|------|-------------|
| forwardedMessageId | string | ID of the newly created forwarded message |
| originalMessageId | string | ID of the original message |
| recipientsCount | integer | Number of recipients the message was forwarded to |

### GalleryItemListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of gallery items |
| page | integer | Current page |
| pageSize | integer | Items per page |
| totalItems | integer | Total number of items |
| totalPages | integer | Total number of pages |

### GalleryItemResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Gallery item ID |
| name | string | File name |
| mediaType | string | Media type |
| mimeType | string | MIME type |
| sizeBytes | integer | File size in bytes |
| createdAt | string | Creation timestamp (ISO 8601) |
| uri | string | Content URI or download URL |

### GetNotificationRequest

### GifSearchResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of GIFs |
| page | integer | Current page |
| pageSize | integer | Items per page |
| totalItems | integer | Total items |

### GreetingSettingsRequest

| Property | Type | Description |
|----------|------|-------------|
| enabled | boolean | Whether automatic greetings are enabled |
| template | string | Greeting message template |
| channel | string | Communication channel for greetings (e.g., email, sms, chat) |

### GreetingSettingsResponse

| Property | Type | Description |
|----------|------|-------------|
| enabled | boolean | Whether automatic greetings are enabled |
| template | string | Greeting message template |
| channel | string | Communication channel for greetings (e.g., email, sms, chat) |

### GroupCallListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of group calls |
| page | integer | Current page |
| pageSize | integer | Items per page |
| totalItems | integer | Total items |

### GroupCallResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Group call ID |
| status | string | Call status: ended |
| endedAt | string | ISO 8601 timestamp |

### GroupChatMessageResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Message ID |
| groupChatId | string | Group chat ID |
| content | string | Message content |
| mentionedUserIds | array | List of mentioned user IDs |
| createdAt | string | Creation timestamp (ISO 8601) |

### GroupEventListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of events |
| page | integer | Current page number |
| pageSize | integer | Number of items per page |
| totalItems | integer | Total number of items |
| totalPages | integer | Total number of pages |

### GroupEventResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Event ID |
| groupId | string | Group ID |
| title | string | Event title |
| description | string | Event description |
| startTime | string | Event start time in ISO 8601 |
| endTime | string | Event end time in ISO 8601 |
| location | string | Event location |
| updatedAt | string | Update timestamp in ISO 8601 |

### GroupInvitationPolicyResponse

| Property | Type | Description |
|----------|------|-------------|
| groupId | string | Group ID |
| policyType | string | Who can add members to the group (e.g., owners, admins, members, custom) |
| allowedUserIds | array | Explicit list of user IDs allowed to add members when policyType is custom |
| allowedRoleIds | array | Explicit list of role IDs allowed to add members when policyType is custom |
| updatedAt | string | Last update timestamp (ISO 8601) |

### GroupInviteLinkResponse

| Property | Type | Description |
|----------|------|-------------|
| inviteId | string | Invite link ID |
| inviteUrl | string | Shareable invite URL |
| expiresAt | string | Expiration timestamp |
| maxUses | integer | Maximum number of uses |
| uses | integer | Current number of uses |

### GroupListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of groups |
| page | integer | Current page |
| pageSize | integer | Items per page |
| totalItems | integer | Total number of groups |
| totalPages | integer | Total number of pages |

### GroupResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Group ID |
| communityId | string | Community ID |
| name | string | Group name |
| description | string | Group description |
| createdAt | string | Creation timestamp (ISO 8601) |

### GroupSettingsResponse

| Property | Type | Description |
|----------|------|-------------|
| groupId | string | Group ID |
| settings | object | Key-value map of group settings |
| updatedAt | string | Last update timestamp in ISO 8601 format |

### ImageEditResponse

| Property | Type | Description |
|----------|------|-------------|
| editedImageId | string | ID of the edited image version |
| sourceImageId | string | ID of the original image |
| previewUrl | string | URL to preview the edited image |
| downloadUrl | string | URL to download the edited image |
| appliedEdits | object | Summary of applied edits |

### ImageResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Image ID |
| status | string | Send status |
| createdAt | string | Creation timestamp in ISO 8601 |

### ImportChatHistoryRequest

| Property | Type | Description |
|----------|------|-------------|
| deviceId | string | Identifier of the new device |
| transferToken | string | Token generated by the transfer session |

### ImportChatHistoryResponse

| Property | Type | Description |
|----------|------|-------------|
| transferId | string | Transfer session identifier |
| status | string | Result status of the import |
| importedMessages | integer | Number of messages imported |

### ImportContactsRequest

| Property | Type | Description |
|----------|------|-------------|
| contacts | array | List of contacts to import |

### ImportContactsResponse

| Property | Type | Description |
|----------|------|-------------|
| importedCount | integer | Number of contacts imported |
| failedCount | integer | Number of contacts failed |
| errors | array | Errors for failed records |

### InfoVisibilitySettingsResponse

| Property | Type | Description |
|----------|------|-------------|
| showInfoText | boolean | Whether informational texts are visible |
| showStatusText | boolean | Whether status texts are visible |
| scope | string | Scope of the setting (e.g., global, tenant, user) |
| updatedAt | string | Last update timestamp in ISO 8601 format |

### IntegrationResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Integration client ID |
| name | string | Integration client name |
| clientId | string | API client identifier |
| clientSecret | string | API client secret (returned only on creation) |
| scopes | array | Granted scopes |

### InviteLinkDetailsResponse

| Property | Type | Description |
|----------|------|-------------|
| groupId | string | Group ID |
| groupName | string | Group name |
| expiresAt | string | Expiration timestamp |
| maxUses | integer | Maximum number of uses |
| uses | integer | Current number of uses |
| valid | boolean | Indicates whether the invite link is valid |

### IpMaskingSettingsResponse

| Property | Type | Description |
|----------|------|-------------|
| enabled | boolean | Indicates whether IP masking is enabled for calls |
| maskingStrategy | string | Masking strategy used for IP addresses (e.g., tokenization, proxy) |
| updatedAt | string | Timestamp of the last update in ISO 8601 format |

### JoinVideoCallRequest

| Property | Type | Description |
|----------|------|-------------|
| participantId | string | User ID of the joining participant |
| publicKey | string | Participant public key for key exchange |

### JoinVideoCallResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string |  |
| signalingUrl | string |  |
| serverPublicKey | string | Server public key for key exchange |
| encryption | object |  |

### LanguagesResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of supported languages |
| page | integer | Current page number |
| pageSize | integer | Number of items per page |
| totalItems | integer | Total number of supported languages |
| totalPages | integer | Total number of pages |

### ListBiometricsResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of biometric credentials |
| page | integer | Current page number |
| pageSize | integer | Items per page |
| totalItems | integer | Total number of items |

### ListNotificationsRequest

### LocaleListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of locales |
| page | integer | Current page |
| pageSize | integer | Items per page |
| total | integer | Total number of locales |

### LocationShareResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Location share ID |
| senderUserId | string | ID of the user sharing the location |
| recipientUserIds | array | IDs of users who received the shared location |
| location | object | Geographic location data |
| message | string | Optional message to accompany the location share |
| expiresAt | string | Optional expiration timestamp (ISO 8601) |
| createdAt | string | Creation timestamp (ISO 8601) |
| status | string | Share status (e.g., active, expired) |

### LockChatRequest

| Property | Type | Description |
|----------|------|-------------|
| authType | string | Type of additional authentication (e.g., password, mfa, biometric) |
| authToken | string | Additional authentication proof (e.g., password, MFA code, signed token) |
| reason | string | Optional reason for locking the chat |

### LockChatResponse

| Property | Type | Description |
|----------|------|-------------|
| chatId | string | Chat ID |
| status | string | Lock status |
| lockedAt | string | Timestamp when the chat was locked (ISO 8601) |

### MarketListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of markets |
| page | integer | Current page |
| pageSize | integer | Items per page |
| total | integer | Total items |

### MediaContentResponse

| Property | Type | Description |
|----------|------|-------------|
| contentType | string | MIME type of the media |
| contentBase64 | string | Base64-encoded media content |

### MediaListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of media items |
| page | integer | Current page |
| pageSize | integer | Items per page |
| totalItems | integer | Total number of items |
| totalPages | integer | Total number of pages |

### MediaMetadataResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Media ID |
| fileName | string | Original file name |
| contentType | string | MIME type of the media |
| viewOnce | boolean | View-once flag |
| viewedAt | string | Timestamp when first viewed (null if not viewed) |
| expiresAt | string | Expiration timestamp if set |

### MediaResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Media ID |
| status | string | Processing status |
| quality | string | Stored media quality |
| playbackUrl | string | URL to access the media |

### MessageAckRequest

| Property | Type | Description |
|----------|------|-------------|
| messageIds | array | List of message IDs acknowledged by the client |
| lastCursor | string | Last processed sync cursor |

### MessageAckResponse

| Property | Type | Description |
|----------|------|-------------|
| acknowledgedCount | integer | Number of messages acknowledged |

### MessageListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of messages |
| page | integer | Current page number |
| pageSize | integer | Items per page |
| total | integer | Total number of messages |

### MessageResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Message ID |
| senderStatus | string | Classification of sender: known|unknown |
| handledAsUnknown | boolean | Indicates whether the message was treated as from an unknown sender |

### MessageSearchResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of matching messages |
| page | integer | Current page number |
| pageSize | integer | Number of items per page |
| totalItems | integer | Total number of matching messages |
| totalPages | integer | Total number of pages |

### MessageSyncResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of messages and their change metadata |
| nextCursor | string | Cursor for the next page of results |
| hasMore | boolean | Indicates if more results are available |
| serverTime | string | Server time at which the sync was generated |

### MuteContactStatusRequest

| Property | Type | Description |
|----------|------|-------------|
| mute | boolean | Whether the contact status should be muted |
| durationSeconds | integer | Optional mute duration in seconds; omit for indefinite mute |
| reason | string | Optional reason for muting |

### MuteContactStatusResponse

| Property | Type | Description |
|----------|------|-------------|
| contactId | string | Contact ID |
| muted | boolean | Indicates if the contact status is muted |
| mutedUntil | string | ISO-8601 timestamp when mute expires; null if indefinite |

### NotificationListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of notifications |
| page | integer | Current page number |
| pageSize | integer | Number of items per page |
| totalItems | integer | Total number of items |

### NotificationPreviewConfigListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of notification preview configurations |
| page | integer | Current page |
| pageSize | integer | Items per page |
| totalItems | integer | Total number of items |

### NotificationPreviewConfigResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Configuration ID |
| name | string | Configuration name |
| channel | string | Notification channel |
| template | string | Preview template content |
| locale | string | Locale for preview rendering |
| placeholders | array | Supported placeholder keys |

### NotificationPreviewResponse

| Property | Type | Description |
|----------|------|-------------|
| configId | string | Configuration ID used |
| renderedPreview | string | Rendered notification preview |
| channel | string | Notification channel used |
| locale | string | Locale used |

### NotificationResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Notification ID |
| read | boolean | Read status |
| updatedAt | string | Timestamp when the notification was updated |

### NotificationStatusResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Notification ID |
| status | string | Delivery status (queued, sent, delivered, failed) |
| deliveredAt | string | Delivery timestamp |
| failureReason | string | Failure reason if any |

### OfflineChangesDownloadResponse

| Property | Type | Description |
|----------|------|-------------|
| changes | array | List of server-side create/update/delete operations |
| nextPage | integer | Next page number if more results exist |

### OfflineChangesRequest

| Property | Type | Description |
|----------|------|-------------|
| clientId | string | Unique identifier of the client instance |
| changes | array | List of create/update/delete operations performed offline |

### OfflineChangesResponse

| Property | Type | Description |
|----------|------|-------------|
| accepted | array | List of successfully applied changes |
| conflicts | array | List of changes that resulted in conflicts |

### OfflineManifestResponse

| Property | Type | Description |
|----------|------|-------------|
| serverTime | string | ISO-8601 server time |
| resources | array | List of resources with version and sync requirements |

### OnlineStatusVisibilitySettingResponse

| Property | Type | Description |
|----------|------|-------------|
| userId | string | User ID |
| visibility | string | Visibility level for online status (e.g., everyone, contacts, nobody) |
| updatedAt | string | ISO-8601 timestamp of last update |

### PairWatchDeviceRequest

| Property | Type | Description |
|----------|------|-------------|
| deviceId | string | Device ID to pair |
| pairingToken | string | Pairing token or code |

### PairingResponse

| Property | Type | Description |
|----------|------|-------------|
| pairingId | string | Pairing ID |
| deviceId | string | Device ID |
| status | string | Pairing status |
| pairedAt | string | Pairing timestamp (ISO 8601) |

### ParticipantsResponse

| Property | Type | Description |
|----------|------|-------------|
| callId | string | Group call ID |
| participantIds | array | Updated participant user IDs |

### PasskeyAuthenticationOptionsRequest

| Property | Type | Description |
|----------|------|-------------|
| userId | string | User ID to authenticate (optional for usernameless flow) |
| userHandle | string | Optional user handle for discoverable credentials |

### PasskeyAuthenticationOptionsResponse

| Property | Type | Description |
|----------|------|-------------|
| challenge | string | Base64url-encoded challenge |
| timeout | integer | Timeout in milliseconds |
| allowCredentials | array | Allowed credentials for assertion |
| rpId | string | Relying party ID |

### PasskeyAuthenticationVerifyRequest

| Property | Type | Description |
|----------|------|-------------|
| credential | object | WebAuthn assertion response from client |

### PasskeyAuthenticationVerifyResponse

| Property | Type | Description |
|----------|------|-------------|
| accessToken | string | Access token |
| refreshToken | string | Refresh token |
| userId | string | Authenticated user ID |
| expiresIn | integer | Access token expiry in seconds |

### PasskeyListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of passkeys |
| page | integer | Current page |
| pageSize | integer | Page size |
| total | integer | Total number of items |

### PasskeyRegistrationOptionsRequest

| Property | Type | Description |
|----------|------|-------------|
| userId | string | User ID for which to create registration options |
| displayName | string | User-friendly name displayed by authenticators |
| attestation | string | Attestation conveyance preference (e.g., none, indirect, direct) |

### PasskeyRegistrationOptionsResponse

| Property | Type | Description |
|----------|------|-------------|
| challenge | string | Base64url-encoded challenge |
| rp | object | Relying party information |
| user | object | User identity information |
| pubKeyCredParams | array | Supported public key credential parameters |
| timeout | integer | Timeout in milliseconds |
| excludeCredentials | array | Credentials to exclude |

### PasskeyRegistrationVerifyRequest

| Property | Type | Description |
|----------|------|-------------|
| userId | string | User ID completing registration |
| credential | object | WebAuthn attestation response from client |
| deviceName | string | Optional label for the passkey device |

### PasskeyRegistrationVerifyResponse

| Property | Type | Description |
|----------|------|-------------|
| passkeyId | string | Registered passkey ID |
| createdAt | string | Creation timestamp |

### PaymentListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of payments |
| page | integer | Current page |
| pageSize | integer | Items per page |
| total | integer | Total items |

### PaymentResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Payment ID |
| status | string | Payment status |
| amount | number | Payment amount |
| currency | string | ISO 4217 currency code |
| market | string | Market/region code |
| createdAt | string | Creation timestamp |

### PhoneRegistrationResponse

| Property | Type | Description |
|----------|------|-------------|
| registrationId | string | Registration transaction ID |
| phoneNumber | string | Registered phone number |
| status | string | Current status (e.g., PENDING_VERIFICATION) |
| expiresAt | string | OTP expiration timestamp (ISO 8601) |

### PhoneVerificationResponse

| Property | Type | Description |
|----------|------|-------------|
| userId | string | Created user ID |
| phoneNumber | string | Verified phone number |
| status | string | Current status (e.g., VERIFIED) |
| verifiedAt | string | Verification timestamp (ISO 8601) |

### PinChatResponse

| Property | Type | Description |
|----------|------|-------------|
| chatId | string | Chat ID |
| pinned | boolean | Indicates if the chat is pinned |
| pinnedAt | string | Timestamp when the chat was pinned |

### PinStatusResponse

| Property | Type | Description |
|----------|------|-------------|
| userId | string | User ID |
| pinEnabled | boolean | Indicates whether PIN security is enabled |

### PollDetailResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Poll ID |
| chatId | string | Chat ID |
| question | string | Poll question |
| options | array | Poll options with counts |
| multipleChoice | boolean | Multiple choice enabled |
| expiresAt | string | Expiration timestamp |
| status | string | Poll status |

### PollListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of polls |
| page | integer | Current page |
| pageSize | integer | Page size |
| totalItems | integer | Total number of polls |

### PollResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Poll ID |
| chatId | string | Chat ID |
| question | string | Poll question |
| options | array | Poll options |
| multipleChoice | boolean | Multiple choice enabled |
| expiresAt | string | Expiration timestamp |
| status | string | Poll status (open/closed) |

### ProductListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of products |
| page | integer | Current page |
| pageSize | integer | Items per page |
| totalItems | integer | Total number of items |
| totalPages | integer | Total number of pages |

### ProductResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Product ID |
| name | string | Product name |
| description | string | Product description |
| price | number | Product price |
| currency | string | Currency code |
| sku | string | Stock keeping unit |
| category | string | Product category |
| status | string | Product status |
| createdAt | string | Creation timestamp |
| updatedAt | string | Last update timestamp |

### ProfileInfoTextResponse

| Property | Type | Description |
|----------|------|-------------|
| profileId | string | Profile ID |
| infoText | string | Short info/status text |
| updatedAt | string | ISO-8601 timestamp of last update |

### ProfilePictureVisibilityResponse

| Property | Type | Description |
|----------|------|-------------|
| userId | string | User ID |
| visibility | string | Visibility level |
| updatedAt | string | Last update timestamp (ISO 8601) |

### PublicKeyResponse

| Property | Type | Description |
|----------|------|-------------|
| userId | string | User identifier |
| publicKey | string | User public key in base64 or PEM format |
| keyAlgorithm | string | Key algorithm (e.g., X25519, RSA) |
| keyId | string | Public key identifier |

### PublishBroadcastMessageRequest

| Property | Type | Description |
|----------|------|-------------|
| content | string | Message content |
| contentType | string | Content type (e.g., text/plain, text/markdown) |

### QrCodeResponse

| Property | Type | Description |
|----------|------|-------------|
| profileId | string | Unique profile identifier |
| format | string | QR code output format |
| contentType | string | MIME type of the QR code content |
| data | string | Base64-encoded QR code image or SVG content |

### QuickReplyListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of quick replies |
| page | integer | Current page number |
| pageSize | integer | Items per page |
| totalItems | integer | Total number of items |
| totalPages | integer | Total number of pages |

### QuickReplyResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Quick reply ID |
| title | string | Short label for the quick reply |
| message | string | Quick reply message text |
| language | string | Language code (e.g., de, en) |
| isActive | boolean | Whether the quick reply is active |
| createdAt | string | Creation timestamp (ISO 8601) |
| updatedAt | string | Last update timestamp (ISO 8601) |

### ReactionListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of reactions |
| page | integer | Current page number |
| pageSize | integer | Items per page |
| totalItems | integer | Total number of reactions |
| totalPages | integer | Total number of pages |

### ReactionResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Reaction ID |
| messageId | string | Message ID |
| emoji | string | Emoji character |
| userId | string | User ID who reacted |
| createdAt | string | ISO-8601 timestamp when reaction was created |

### ReadReceiptConfigResponse

| Property | Type | Description |
|----------|------|-------------|
| enabled | boolean | Whether read receipts are enabled for the user |
| mode | string | Read receipt mode (e.g., 'always', 'never', 'ask') |

### ReadReceiptListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of read receipts |
| page | integer | Current page number |
| pageSize | integer | Number of items per page |
| totalItems | integer | Total number of items |
| totalPages | integer | Total number of pages |

### ReadReceiptResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Read receipt ID |
| messageId | string | Message ID |
| userId | string | User ID who read the message |
| readAt | string | ISO-8601 timestamp of when the message was read |

### RecordsByDateResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of records for the specified date |
| page | integer | Current page number |
| pageSize | integer | Number of items per page |
| totalItems | integer | Total number of items for the specified date |

### RegionalFormatResponse

| Property | Type | Description |
|----------|------|-------------|
| locale | string | Locale identifier |
| dateFormat | string | Date format pattern |
| numberFormat | string | Number format pattern |
| currencyFormat | string | Currency format pattern |

### RegionalFormatsListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of supported regional formats |
| page | integer | Current page number |
| pageSize | integer | Items per page |
| totalItems | integer | Total number of items |

### RegisterBiometricRequest

| Property | Type | Description |
|----------|------|-------------|
| biometricType | string | Type of biometric credential (e.g., FINGERPRINT, FACE_ID) |
| biometricToken | string | Device-generated biometric token or public key reference |
| deviceId | string | Device identifier |
| deviceName | string | Human-readable device name |

### RegisterBiometricResponse

| Property | Type | Description |
|----------|------|-------------|
| biometricId | string | Biometric credential ID |
| status | string | Enrollment status |

### RegisterDeviceRequest

| Property | Type | Description |
|----------|------|-------------|
| userId | string | User identifier associated with the device |
| platform | string | Device platform (ios, android, web) |
| pushToken | string | Push provider token |
| deviceId | string | Client-generated device identifier |

### RegisterPublicKeyRequest

| Property | Type | Description |
|----------|------|-------------|
| userId | string | User identifier |
| publicKey | string | User public key in base64 or PEM format |
| keyAlgorithm | string | Key algorithm (e.g., X25519, RSA) |

### RegisterPublicKeyResponse

| Property | Type | Description |
|----------|------|-------------|
| userId | string | User identifier |
| keyId | string | Public key identifier |
| createdAt | string | ISO-8601 timestamp |

### RegisterWatchDeviceRequest

| Property | Type | Description |
|----------|------|-------------|
| deviceName | string | User-friendly device name |
| platform | string | Smartwatch platform (e.g., wearOS, watchOS) |
| manufacturer | string | Device manufacturer |
| model | string | Device model |
| osVersion | string | Operating system version |

### RejectCallRequest

| Property | Type | Description |
|----------|------|-------------|
| message | string | Message to send to the caller upon rejection |
| messageTemplateId | string | Optional template ID for a predefined rejection message |

### RejectCallResponse

| Property | Type | Description |
|----------|------|-------------|
| callId | string | Unique identifier of the rejected call |
| status | string | Resulting status of the call after rejection |
| messageSent | boolean | Indicates whether a rejection message was sent to the caller |
| timestamp | string | ISO 8601 timestamp of the rejection |

### RemoveContactLabelResponse

| Property | Type | Description |
|----------|------|-------------|
| removed | boolean | Whether the label was removed |
| contactId | string | Contact ID |
| labelId | string | Label ID |

### ReplaceGroupSettingsRequest

| Property | Type | Description |
|----------|------|-------------|
| settings | object | Complete key-value map of group settings to replace existing settings |

### ReportResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Report ID |
| targetType | string | Type of target reported |
| targetId | string | ID of the reported message or contact |
| status | string | Current status of the report |
| createdAt | string | ISO 8601 timestamp when the report was created |

### RestoreBackupRequest

| Property | Type | Description |
|----------|------|-------------|
| targetId | string | Identifier of the target client/device |

### RestoreBackupResponse

| Property | Type | Description |
|----------|------|-------------|
| backupId | string | Backup identifier |
| encryptedData | string | Base64-encoded encrypted backup payload |
| encryptionScheme | string | Encryption algorithm and mode used by the client |
| encryptionContext | object | Opaque client-defined context for decryption (non-secret metadata) |
| checksum | string | Checksum of the encrypted payload for integrity verification |

### RestoreChatBackupRequest

| Property | Type | Description |
|----------|------|-------------|
| targetChatId | string | Optional target chat identifier for restoration |

### RestoreChatBackupResponse

| Property | Type | Description |
|----------|------|-------------|
| restoreId | string | Restore job identifier |
| status | string | Restore status (e.g., pending, completed, failed) |

### ReviewBusinessVerificationRequest

| Property | Type | Description |
|----------|------|-------------|
| status | string | New status (approved, rejected) |
| rejectionReason | string | Reason for rejection, required if status is rejected |

### ScreenShareListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of screen share sessions |
| page | integer | Current page number |
| pageSize | integer | Number of items per page |
| totalItems | integer | Total number of items |
| totalPages | integer | Total number of pages |

### ScreenShareResponse

| Property | Type | Description |
|----------|------|-------------|
| screenShareId | string | Screen share session ID |
| callId | string | Call ID |
| status | string | Current status of the screen share |
| startedAt | string | ISO 8601 timestamp when sharing started |
| endedAt | string | ISO 8601 timestamp when sharing ended |

### SearchChatsContactsResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | Matched chats and contacts |
| page | integer | Current page number |
| pageSize | integer | Items per page |
| totalItems | integer | Total number of matched items |
| totalPages | integer | Total number of pages |

### SendBroadcastMessageRequest

| Property | Type | Description |
|----------|------|-------------|
| subject | string | Message subject |
| body | string | Message body content |
| channel | string | Delivery channel (e.g., email, sms, inApp) |

### SendBroadcastMessageResponse

| Property | Type | Description |
|----------|------|-------------|
| messageId | string | Broadcast message ID |
| listId | string | Broadcast list ID |
| queuedCount | integer | Number of recipients queued |
| status | string | Message status |

### SendDocumentRequest

| Property | Type | Description |
|----------|------|-------------|
| recipientId | string | Identifier of the recipient |
| filename | string | Original document filename |
| mimeType | string | MIME type of the document |
| contentBase64 | string | Base64-encoded document content |
| metadata | object | Optional metadata for routing or classification |

### SendDocumentResponse

| Property | Type | Description |
|----------|------|-------------|
| documentId | string | Unique identifier of the sent document |
| status | string | Delivery status |
| createdAt | string | Timestamp of sending |

### SendEncryptedMessageRequest

| Property | Type | Description |
|----------|------|-------------|
| senderId | string | Sender identifier |
| recipientId | string | Recipient identifier |
| ciphertext | string | Encrypted message payload (base64) |
| nonce | string | Nonce or IV used for encryption |
| algorithm | string | Encryption algorithm (e.g., XChaCha20-Poly1305) |
| keyId | string | Recipient public key identifier used for encryption |

### SendEncryptedMessageResponse

| Property | Type | Description |
|----------|------|-------------|
| messageId | string | Message identifier |
| createdAt | string | ISO-8601 timestamp |
| status | string | Message status |

### SendGifRequest

| Property | Type | Description |
|----------|------|-------------|
| gifId | string | GIF ID from search results |
| contentUrl | string | Direct GIF URL if not using gifId |
| caption | string | Optional caption |

### SendGifResponse

| Property | Type | Description |
|----------|------|-------------|
| messageId | string | Message ID |
| chatId | string | Chat ID |
| gifId | string | GIF ID |
| contentUrl | string | GIF URL |
| sentAt | string | Timestamp of sending |

### SendImageRequest

| Property | Type | Description |
|----------|------|-------------|
| file | file | Image file to be sent (e.g., JPEG, PNG) |
| caption | string | Optional caption for the image |
| recipientId | string | Optional recipient identifier |

### SendMessageRequest

| Property | Type | Description |
|----------|------|-------------|
| conversationId | string | Conversation or chat thread ID |
| recipientId | string | Recipient user ID (required if conversationId is not provided) |
| content | string | Text message content |
| clientMessageId | string | Client-generated idempotency key for the message |

### SendNotificationRequest

| Property | Type | Description |
|----------|------|-------------|
| userId | string | Target user identifier |
| deviceIds | array | Optional list of device registration IDs |
| title | string | Notification title |
| body | string | Notification body |
| data | object | Custom payload data |
| priority | string | Delivery priority (normal, high) |
| ttlSeconds | integer | Time to live in seconds |
| idempotencyKey | string | Idempotency key to prevent duplicates |

### SendStickerMessageRequest

| Property | Type | Description |
|----------|------|-------------|
| stickerId | string | ID of the sticker to send |
| caption | string | Optional text caption for the sticker message |

### SendVideoMessageRequest

| Property | Type | Description |
|----------|------|-------------|
| recipientIds | array | List of recipient user IDs |
| videoUrl | string | URL of the video to send |
| caption | string | Optional caption for the video |

### SendVoiceMessageRequest

| Property | Type | Description |
|----------|------|-------------|
| messageType | string | Type of message. Must be 'voice'. |
| audioUrl | string | URL to the uploaded audio file |
| audioData | string | Base64-encoded audio payload (alternative to audioUrl) |
| contentType | string | MIME type of the audio, e.g. audio/ogg |
| durationSeconds | integer | Duration of the voice message in seconds |

### SessionListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of active sessions |
| page | integer | Current page number |
| pageSize | integer | Items per page |
| totalItems | integer | Total number of sessions |

### SessionResponse

| Property | Type | Description |
|----------|------|-------------|
| sessionId | string | Session identifier |
| accessToken | string | Access token |
| refreshToken | string | Refresh token |
| expiresIn | integer | Access token expiration in seconds |
| deviceId | string | Unique device identifier |
| createdAt | string | Session creation timestamp |

### SetStorageQuotaRequest

| Property | Type | Description |
|----------|------|-------------|
| scopeType | string | Scope type (e.g., user, project, bucket) |
| quotaBytes | integer | Quota limit in bytes |

### ShareContactRequest

| Property | Type | Description |
|----------|------|-------------|
| recipients | array | List of recipient identifiers (e.g., user IDs or emails) |
| channel | string | Sharing channel (e.g., email, link, sms) |
| message | string | Optional message to include with the share |
| expiresAt | string | Optional expiration timestamp for shared access in ISO 8601 format |

### ShareContactResponse

| Property | Type | Description |
|----------|------|-------------|
| shareId | string | Share operation ID |
| contactId | string | Shared contact ID |
| status | string | Share status |
| createdAt | string | Creation timestamp in ISO 8601 format |

### ShareDetailResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Share request ID |
| contentType | string | Type of content shared |
| content | string | Content payload or URL |
| title | string | Title for the shared content |
| recipients | array | Recipient identifiers |
| status | string | Current share status |
| createdAt | string | Creation timestamp in ISO 8601 format |
| updatedAt | string | Last update timestamp in ISO 8601 format |

### ShareResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Share request ID |
| status | string | Current share status (e.g., created, dispatched, completed, failed) |
| createdAt | string | Creation timestamp in ISO 8601 format |

### ShareTargetsResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of share targets |
| page | integer | Current page number |
| pageSize | integer | Number of items per page |
| totalItems | integer | Total number of share targets |

### SmartReplyRequest

| Property | Type | Description |
|----------|------|-------------|
| conversationId | string | Identifier of the conversation |
| message | string | Latest message text to respond to |
| contextMessages | array | Optional prior messages for context |
| maxSuggestions | integer | Maximum number of suggestions to generate |
| language | string | Language code for suggestions (e.g., de, en) |

### SmartReplyResponse

| Property | Type | Description |
|----------|------|-------------|
| suggestions | array | List of suggested replies |
| conversationId | string | Identifier of the conversation |

### SpamDetectionResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Spam detection result ID |
| isSpam | boolean | Indicates whether the content is classified as spam |
| spamScore | number | Spam confidence score between 0 and 1 |
| reasons | array | List of reasons or signals contributing to the classification |
| createdAt | string | Timestamp of analysis in ISO 8601 format |

### StartScreenShareRequest

| Property | Type | Description |
|----------|------|-------------|
| sourceType | string | Type of source being shared (e.g., screen, window) |
| sourceId | string | Client-specific identifier of the source |

### StatusResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Status ID |
| text | string | Text content of the status update |
| mediaUrls | array | List of media URLs attached to the status update |
| visibility | string | Visibility of the status update |
| createdAt | string | Creation timestamp in ISO 8601 format |
| expiresAt | string | Expiration timestamp (24 hours after creation) in ISO 8601 format |

### StatusVisibilityListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of status visibility configurations |
| page | integer | Current page number |
| pageSize | integer | Items per page |
| totalItems | integer | Total number of items |
| totalPages | integer | Total number of pages |

### StatusVisibilityResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Configuration ID |
| statusId | string | Status ID |
| audienceType | string | Audience type |
| audienceId | string | Audience identifier |
| visibility | string | Visibility setting |
| createdAt | string | Creation timestamp (ISO 8601) |
| updatedAt | string | Last update timestamp (ISO 8601) |

### StickerListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of stickers |
| page | integer | Current page |
| pageSize | integer | Page size |
| totalItems | integer | Total number of items |
| totalPages | integer | Total number of pages |

### StickerPackListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of sticker packs. |
| page | integer | Current page number |
| pageSize | integer | Items per page |
| totalItems | integer | Total number of items |
| totalPages | integer | Total number of pages |

### StickerPackResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Sticker pack ID |
| name | string | Sticker pack name |
| description | string | Sticker pack description |
| region | string | Region code |
| locale | string | Locale |
| thumbnailUrl | string | Thumbnail URL |
| stickerCount | integer | Number of stickers in the pack |
| isActive | boolean | Whether the pack is active |

### StickerSuggestionsResponse

| Property | Type | Description |
|----------|------|-------------|
| suggestions | array | List of suggested stickers |

### StopScreenShareResponse

| Property | Type | Description |
|----------|------|-------------|
| screenShareId | string | Screen share session ID |
| status | string | Current status of the screen share |
| endedAt | string | ISO 8601 timestamp when sharing ended |

### StorageCleanupRequest

| Property | Type | Description |
|----------|------|-------------|
| scopeId | string | Optional scope identifier for targeted cleanup |
| scopeType | string | Optional scope type (e.g., user, project, bucket) |
| dryRun | boolean | If true, returns what would be deleted without performing deletion |

### StorageCleanupResponse

| Property | Type | Description |
|----------|------|-------------|
| jobId | string | Identifier for the cleanup job |
| status | string | Current job status |
| estimatedReclaimedBytes | integer | Estimated bytes to be reclaimed |

### StorageQuotaListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of storage quotas |
| page | integer | Current page number |
| pageSize | integer | Number of items per page |
| totalItems | integer | Total number of items available |
| totalPages | integer | Total number of pages available |

### StorageQuotaResponse

| Property | Type | Description |
|----------|------|-------------|
| scopeId | string | Scope identifier |
| scopeType | string | Scope type (e.g., user, project, bucket) |
| quotaBytes | integer | Quota limit in bytes |
| usedBytes | integer | Current used bytes in scope |

### StorageSettingsResponse

| Property | Type | Description |
|----------|------|-------------|
| compressionEnabled | boolean | Indicates whether compression is enabled |
| deduplicationEnabled | boolean | Indicates whether deduplication is enabled |
| retentionDays | integer | Number of days data is retained |
| archivalEnabled | boolean | Indicates whether archival is enabled |

### StorageUsageItemListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of storage usage items |
| page | integer | Current page number |
| pageSize | integer | Number of items per page |
| totalItems | integer | Total number of items available |
| totalPages | integer | Total number of pages available |

### StorageUsageItemResponse

| Property | Type | Description |
|----------|------|-------------|
| itemId | string | Item identifier |
| itemType | string | Type of item (e.g., file, bucket, namespace) |
| usedBytes | integer | Used storage for the item in bytes |
| createdAt | string | ISO-8601 timestamp of creation |
| lastModified | string | ISO-8601 timestamp of last modification |
| metadata | object | Additional metadata for the item |

### StorageUsageSummaryResponse

| Property | Type | Description |
|----------|------|-------------|
| totalBytes | integer | Total storage capacity in bytes |
| usedBytes | integer | Used storage in bytes |
| freeBytes | integer | Available storage in bytes |
| usagePercent | number | Used storage as a percentage of total capacity |
| timestamp | string | ISO-8601 timestamp of the measurement |

### SyncResponse

| Property | Type | Description |
|----------|------|-------------|
| syncId | string | Sync job ID |
| status | string | Sync status (queued, inProgress, completed) |

### SyncWatchDataRequest

| Property | Type | Description |
|----------|------|-------------|
| deviceId | string | Device ID to sync |
| fromTimestamp | string | Start time for sync window (ISO 8601) |
| toTimestamp | string | End time for sync window (ISO 8601) |

### SystemStatusResponse

| Property | Type | Description |
|----------|------|-------------|
| status | string | Overall system status (e.g., OK, DEGRADED, DOWN) |
| timestamp | string | ISO 8601 timestamp of the status check |
| details | object | Optional component status details |

### ThemePreferenceResponse

| Property | Type | Description |
|----------|------|-------------|
| theme | string | Theme preference |

### ThemePreferenceUpdateRequest

| Property | Type | Description |
|----------|------|-------------|
| theme | string | Theme preference |

### TranscriptionResponse

| Property | Type | Description |
|----------|------|-------------|
| transcriptionId | string | Unique transcription job ID |
| text | string | Transcribed text |
| language | string | Detected or provided language |
| status | string | Transcription status (e.g., completed) |

### TypographyPreferencesResponse

| Property | Type | Description |
|----------|------|-------------|
| userId | string | User ID |
| fontSize | string | Font size setting (e.g., small, medium, large, x-large) |
| fontScale | number | Optional numeric scale multiplier (e.g., 1.0, 1.25, 1.5) |

### UnknownSendersListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of unknown senders |
| page | integer | Current page number |
| pageSize | integer | Items per page |
| totalItems | integer | Total number of items |

### UnpinChatResponse

| Property | Type | Description |
|----------|------|-------------|
| chatId | string | Chat ID |
| pinned | boolean | Indicates if the chat is pinned |

### UpdateAbsenceMessageRequest

| Property | Type | Description |
|----------|------|-------------|
| message | string | Automatic reply message |
| startDate | string | Start date in ISO 8601 |
| endDate | string | End date in ISO 8601 |
| active | boolean | Whether the message is active |

### UpdateAccessibilitySettingsRequest

| Property | Type | Description |
|----------|------|-------------|
| screenReaderEnabled | boolean | Whether screenreader support is enabled |
| ariaHintsEnabled | boolean | Whether ARIA hinting is enabled |
| highContrastEnabled | boolean | Whether high contrast mode is enabled |
| textAlternativesEnabled | boolean | Whether text alternatives for non-text content are enabled |

### UpdateBroadcastChannelRequest

| Property | Type | Description |
|----------|------|-------------|
| name | string | Human-readable channel name |
| description | string | Channel description |
| isPrivate | boolean | Whether the channel is private |

### UpdateBroadcastListRequest

| Property | Type | Description |
|----------|------|-------------|
| name | string | Broadcast list name |
| description | string | Optional description |

### UpdateBusinessProfileRequest

| Property | Type | Description |
|----------|------|-------------|
| name | string | Business name |
| legalName | string | Registered legal name |
| registrationNumber | string | Business registration number |
| taxId | string | Tax identification number |
| industry | string | Industry classification |
| website | string | Business website URL |
| phone | string | Primary contact phone |
| email | string | Primary contact email |
| address | object | Business address |
| metadata | object | Additional profile attributes |

### UpdateCallNotificationSettingsRequest

| Property | Type | Description |
|----------|------|-------------|
| enabled | boolean | Whether call notifications are enabled |
| channels | array | Notification channels to use for calls |
| quietHours | object | Quiet hours configuration for call notifications |

### UpdateCartItemRequest

| Property | Type | Description |
|----------|------|-------------|
| quantity | integer | Updated quantity |

### UpdateChatBackgroundRequest

| Property | Type | Description |
|----------|------|-------------|
| backgroundId | string | Selected background ID |
| customImageUrl | string | Custom image URL if uploaded for chat |
| type | string | Background type (image, color, gradient) |
| color | string | Color value if type is color |
| inheritsUserDefault | boolean | Whether to use user's default background |

### UpdateCommunityRequest

| Property | Type | Description |
|----------|------|-------------|
| name | string | Community name |
| description | string | Community description |

### UpdateContactLabelRequest

| Property | Type | Description |
|----------|------|-------------|
| name | string | Label name |
| color | string | Optional color code |

### UpdateDeviceRequest

| Property | Type | Description |
|----------|------|-------------|
| pushToken | string | New push provider token |
| status | string | Registration status (active, inactive) |

### UpdateDoNotDisturbRequest

| Property | Type | Description |
|----------|------|-------------|
| enabled | boolean | Set to true to enable, false to disable |

### UpdateGroupEventRequest

| Property | Type | Description |
|----------|------|-------------|
| title | string | Event title |
| description | string | Event description |
| startTime | string | Event start time in ISO 8601 |
| endTime | string | Event end time in ISO 8601 |
| location | string | Event location |

### UpdateGroupInvitationPolicyRequest

| Property | Type | Description |
|----------|------|-------------|
| policyType | string | Who can add members to the group (e.g., owners, admins, members, custom) |
| allowedUserIds | array | Explicit list of user IDs allowed to add members when policyType is custom |
| allowedRoleIds | array | Explicit list of role IDs allowed to add members when policyType is custom |

### UpdateGroupSettingsRequest

| Property | Type | Description |
|----------|------|-------------|
| settings | object | Key-value map of settings to update |

### UpdateInfoVisibilitySettingsRequest

| Property | Type | Description |
|----------|------|-------------|
| showInfoText | boolean | Whether informational texts are visible |
| showStatusText | boolean | Whether status texts are visible |
| scope | string | Scope of the setting (e.g., global, tenant, user) |

### UpdateIntegrationRequest

| Property | Type | Description |
|----------|------|-------------|
| name | string | Integration client name |
| scopes | array | Permissions granted to the client |

### UpdateIpMaskingSettingsRequest

| Property | Type | Description |
|----------|------|-------------|
| enabled | boolean | Enable or disable IP masking for calls |
| maskingStrategy | string | Masking strategy to use for IP addresses |

### UpdateMessageRequest

| Property | Type | Description |
|----------|------|-------------|
| content | string | Message content |
| format | string | Formatting type (e.g., plain, markdown) |

### UpdateNotificationPreviewConfigRequest

| Property | Type | Description |
|----------|------|-------------|
| name | string | Configuration name |
| channel | string | Notification channel |
| template | string | Preview template content |
| locale | string | Locale for preview rendering |
| placeholders | array | Supported placeholder keys |

### UpdateNotificationRequest

| Property | Type | Description |
|----------|------|-------------|
| read | boolean | Set to true to mark as read |

### UpdateOnlineStatusVisibilitySettingRequest

| Property | Type | Description |
|----------|------|-------------|
| visibility | string | Visibility level for online status (e.g., everyone, contacts, nobody) |

### UpdatePinRequest

| Property | Type | Description |
|----------|------|-------------|
| currentPin | string | Current PIN |
| newPin | string | New PIN |
| newPinConfirmation | string | Confirmation of the new PIN |

### UpdatePollStatusRequest

| Property | Type | Description |
|----------|------|-------------|
| status | string | New status (open or closed) |

### UpdatePollStatusResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Poll ID |
| status | string | Updated status |

### UpdateProductRequest

| Property | Type | Description |
|----------|------|-------------|
| name | string | Product name |
| description | string | Product description |
| price | number | Product price |
| currency | string | Currency code |
| sku | string | Stock keeping unit |
| category | string | Product category |
| status | string | Product status |

### UpdateProfileInfoTextRequest

| Property | Type | Description |
|----------|------|-------------|
| infoText | string | Short info/status text |

### UpdateProfilePictureVisibilityRequest

| Property | Type | Description |
|----------|------|-------------|
| visibility | string | Visibility level |

### UpdateQuickReplyRequest

| Property | Type | Description |
|----------|------|-------------|
| title | string | Short label for the quick reply |
| message | string | Quick reply message text |
| language | string | Language code (e.g., de, en) |
| isActive | boolean | Whether the quick reply is active |

### UpdateReadReceiptConfigRequest

| Property | Type | Description |
|----------|------|-------------|
| enabled | boolean | Whether read receipts are enabled for the user |
| mode | string | Read receipt mode (e.g., 'always', 'never', 'ask') |

### UpdateStatusVisibilityRequest

| Property | Type | Description |
|----------|------|-------------|
| audienceType | string | Audience type (e.g., role, group, user) |
| audienceId | string | Audience identifier |
| visibility | string | Visibility setting (e.g., visible, hidden) |

### UpdateStorageSettingsRequest

| Property | Type | Description |
|----------|------|-------------|
| compressionEnabled | boolean | Enable or disable compression |
| deduplicationEnabled | boolean | Enable or disable deduplication |
| retentionDays | integer | Set data retention period in days |
| archivalEnabled | boolean | Enable or disable archival |

### UpdateTypographyPreferencesRequest

| Property | Type | Description |
|----------|------|-------------|
| fontSize | string | Font size setting (e.g., small, medium, large, x-large) |
| fontScale | number | Optional numeric scale multiplier (e.g., 1.0, 1.25, 1.5) |

### UpdateUserChatBackgroundRequest

| Property | Type | Description |
|----------|------|-------------|
| backgroundId | string | Selected background ID |
| customImageUrl | string | Custom image URL if user uploaded one |
| type | string | Background type (image, color, gradient) |
| color | string | Color value if type is color |

### UpdateUserLanguageRequest

| Property | Type | Description |
|----------|------|-------------|
| languageCode | string | Desired language code (IETF tag) |

### UpdateUserLocalePreferenceRequest

| Property | Type | Description |
|----------|------|-------------|
| locale | string | Preferred locale, e.g., ar-SA |

### UpdateUserProfileRequest

| Property | Type | Description |
|----------|------|-------------|
| displayName | string | New display name |

### UpdateUserRegionalFormatRequest

| Property | Type | Description |
|----------|------|-------------|
| locale | string | Preferred locale identifier (e.g., de-DE, en-US) |

### UpdateUserWidgetRequest

| Property | Type | Description |
|----------|------|-------------|
| position | integer | Widget position on home screen |
| settings | object | Widget settings |

### UpdateVoiceCallRequest

| Property | Type | Description |
|----------|------|-------------|
| action | string | Action to perform (accept, decline, end) |
| encryption | object | Optional keying material for call acceptance |

### UpdateVoiceCallResponse

| Property | Type | Description |
|----------|------|-------------|
| callId | string | Unique call identifier |
| status | string | Updated call status |

### UpdateWatchDeviceRequest

| Property | Type | Description |
|----------|------|-------------|
| deviceName | string | User-friendly device name |
| osVersion | string | Operating system version |

### UploadAudioFileRequest

| Property | Type | Description |
|----------|------|-------------|
| file | file | Audio file binary (e.g., audio/mpeg, audio/wav) |
| fileName | string | Original file name |
| contentType | string | MIME type of the audio file |
| metadata | object | Optional metadata associated with the audio file |

### UpsertUserProfileImageRequest

| Property | Type | Description |
|----------|------|-------------|
| file | string | Binary image file (multipart/form-data) |
| contentType | string | MIME type of the image |

### UserChatBackgroundResponse

| Property | Type | Description |
|----------|------|-------------|
| backgroundId | string | Selected background ID |
| customImageUrl | string | Custom image URL if user uploaded one |
| type | string | Background type (image, color, gradient) |
| color | string | Color value if type is color |

### UserLanguageResponse

| Property | Type | Description |
|----------|------|-------------|
| userId | string | User ID |
| languageCode | string | Selected language code (IETF tag) |

### UserLocalePreferenceResponse

| Property | Type | Description |
|----------|------|-------------|
| locale | string | User preferred locale |
| direction | string | Text direction: rtl or ltr |

### UserMentionsResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of mention entries |
| page | integer | Current page |
| pageSize | integer | Items per page |
| totalItems | integer | Total number of items |
| totalPages | integer | Total number of pages |

### UserProfileImageResponse

| Property | Type | Description |
|----------|------|-------------|
| userId | string | User ID |
| imageUrl | string | Public or signed URL to the profile image |
| contentType | string | MIME type of the image |
| sizeBytes | integer | Size of the image in bytes |
| updatedAt | string | ISO-8601 timestamp of last update |

### UserProfileResponse

| Property | Type | Description |
|----------|------|-------------|
| userId | string | User ID |
| firstName | string | First name |
| lastName | string | Last name |
| phoneNumber | string | Phone number |

### UserRegionalFormatResponse

| Property | Type | Description |
|----------|------|-------------|
| userId | string | User ID |
| locale | string | Preferred locale identifier |

### UserWidgetListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of user's widgets |
| page | integer | Current page |
| pageSize | integer | Items per page |
| totalItems | integer | Total number of items |

### UserWidgetResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | User widget ID |
| widgetId | string | Widget ID |
| position | integer | Widget position on home screen |
| settings | object | Widget settings |

### VerifyBiometricRequest

| Property | Type | Description |
|----------|------|-------------|
| biometricId | string | Biometric credential ID |
| biometricAssertion | string | Signed biometric assertion from device |
| deviceId | string | Device identifier |

### VerifyBiometricResponse

| Property | Type | Description |
|----------|------|-------------|
| accessToken | string | Access token issued after successful verification |
| expiresIn | integer | Token expiration in seconds |

### VerifyPhoneRegistrationRequest

| Property | Type | Description |
|----------|------|-------------|
| registrationId | string | Registration transaction ID |
| otpCode | string | One-time verification code |

### VerifyPinRequest

| Property | Type | Description |
|----------|------|-------------|
| userId | string | User ID |
| pin | string | PIN to verify |
| sessionId | string | Authentication session identifier |

### VerifyPinResponse

| Property | Type | Description |
|----------|------|-------------|
| verified | boolean | Indicates whether PIN verification succeeded |
| sessionId | string | Authentication session identifier |

### VerifyTwoFactorRequest

| Property | Type | Description |
|----------|------|-------------|
| challengeId | string | Identifier for the 2FA challenge |
| pin | string | 6-digit PIN |

### VerifyTwoFactorResponse

| Property | Type | Description |
|----------|------|-------------|
| verified | boolean | Indicates whether the PIN was verified |
| accessToken | string | Access token issued after successful verification |
| refreshToken | string | Refresh token issued after successful verification |

### VideoCallDetailResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string |  |
| status | string |  |
| participants | array |  |
| encryption | object |  |
| signalingUrl | string |  |
| createdAt | string |  |

### VideoCallListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | Video call list |
| page | integer |  |
| pageSize | integer |  |
| total | integer |  |

### VideoCallResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Video call ID |
| status | string | Call status |
| signalingUrl | string | Signaling server URL |
| encryption | object | Negotiated encryption settings |
| createdAt | string | Creation timestamp |

### VideoMessageResponse

| Property | Type | Description |
|----------|------|-------------|
| messageId | string | Created message ID |
| status | string | Delivery status |
| sentAt | string | ISO-8601 timestamp when the message was sent |

### VoiceAssistantIntentRequest

| Property | Type | Description |
|----------|------|-------------|
| userId | string | User ID associated with the assistant account |
| intentName | string | Name of the intent |
| parameters | object | Intent parameters |

### VoiceAssistantIntentResponse

| Property | Type | Description |
|----------|------|-------------|
| message | string | Response to be spoken/displayed by the assistant |
| data | object | Optional structured data for the assistant |

### VoiceAssistantLinkResponse

| Property | Type | Description |
|----------|------|-------------|
| linkId | string | Link ID |
| assistantId | string | Voice assistant ID |
| status | string | Link status |

### VoiceAssistantListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of supported voice assistants |
| page | integer | Current page |
| pageSize | integer | Page size |
| total | integer | Total number of items |

### VoiceCallDetailResponse

| Property | Type | Description |
|----------|------|-------------|
| callId | string | Unique call identifier |
| status | string | Call status |
| mediaEndpoint | string | Media relay endpoint for the call |
| encryption | object | Encryption details |

### VoiceCallListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of calls |
| page | integer | Current page number |
| pageSize | integer | Items per page |
| totalItems | integer | Total number of items |

### VoiceCallResponse

| Property | Type | Description |
|----------|------|-------------|
| callId | string | Unique call identifier |
| status | string | Call status (e.g., ringing) |
| mediaEndpoint | string | Media relay endpoint for the call |
| encryption | object | Negotiated encryption details |

### VotePollRequest

| Property | Type | Description |
|----------|------|-------------|
| selectedOptions | array | Selected options |

### VotePollResponse

| Property | Type | Description |
|----------|------|-------------|
| pollId | string | Poll ID |
| userId | string | User ID |
| selectedOptions | array | Selected options |

### WatchDataListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of data points |
| page | integer | Current page |
| pageSize | integer | Items per page |
| totalItems | integer | Total number of data points |
| totalPages | integer | Total pages |

### WatchDeviceListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of devices |
| page | integer | Current page |
| pageSize | integer | Items per page |
| totalItems | integer | Total number of devices |
| totalPages | integer | Total pages |

### WatchDeviceResponse

| Property | Type | Description |
|----------|------|-------------|
| deviceId | string | Device ID |
| deviceName | string | User-friendly device name |
| platform | string | Smartwatch platform |
| manufacturer | string | Device manufacturer |
| model | string | Device model |
| osVersion | string | Operating system version |
| status | string | Device status |

### WebVersionResponse

| Property | Type | Description |
|----------|------|-------------|
| version | string | Semantic version of the web application |
| build | string | Build identifier or hash |
| releaseDate | string | Release date in ISO 8601 format |
| status | string | Availability status of the web version |

### WidgetListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of widgets |
| page | integer | Current page |
| pageSize | integer | Items per page |
| totalItems | integer | Total number of items |

