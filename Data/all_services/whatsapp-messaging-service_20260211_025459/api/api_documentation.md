# whatsapp-messaging-service API - API Documentation

**Version:** 1.0.0
**Generated:** 2026-02-11T03:53:50.429759

## Endpoints

### Accessibility

#### `GET` /api/v1/users/{id}/accessibility-settings

**Get accessibility settings**

Retrieves screenreader and accessibility preferences for a user to ensure full screenreader compatibility across clients.

*Requirement:* WA-ACC-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| id | path | string | True | User ID |

**Request Body:** `GetAccessibilitySettingsRequest`

**Responses:**

- `200`: OK - Accessibility settings retrieved
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - Access to user settings is denied
- `404`: Not Found - User or settings not found
- `500`: Internal Server Error - Failed to retrieve settings

---

#### `PUT` /api/v1/users/{id}/accessibility-settings

**Update accessibility settings**

Updates user screenreader and accessibility preferences to ensure full screenreader compatibility across clients.

*Requirement:* WA-ACC-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| id | path | string | True | User ID |

**Request Body:** `UpdateAccessibilitySettingsRequest`

**Responses:**

- `200`: OK - Accessibility settings updated
- `400`: Bad Request - Invalid accessibility settings payload
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - Access to user settings is denied
- `404`: Not Found - User not found
- `409`: Conflict - Settings update conflict detected
- `500`: Internal Server Error - Failed to update settings

---

#### `GET` /api/v1/users/{id}/accessibility-settings

**Get accessibility settings**

Retrieves the user's accessibility settings including contrast preferences to ensure sufficient color contrast in the UI.

*Requirement:* WA-ACC-003

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| id | path | string | True | User ID |

**Request Body:** `GetUserAccessibilitySettingsRequest`

**Responses:**

- `200`: OK - Accessibility settings returned
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - Access denied to user settings
- `404`: Not Found - User or settings not found
- `500`: Internal Server Error - Failed to retrieve settings

---

#### `PUT` /api/v1/users/{id}/accessibility-settings

**Update accessibility settings**

Updates the user's accessibility settings to enforce sufficient color contrast in the UI.

*Requirement:* WA-ACC-003

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| id | path | string | True | User ID |

**Request Body:** `UpdateUserAccessibilitySettingsRequest`

**Responses:**

- `200`: OK - Accessibility settings updated
- `400`: Bad Request - Invalid contrast mode or ratio
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - Access denied to user settings
- `404`: Not Found - User not found
- `409`: Conflict - Settings update conflict
- `500`: Internal Server Error - Failed to update settings

---

#### `GET` /api/v1/app/accessibility/contrast-requirements

**Get contrast requirements**

Provides the system's minimum contrast requirements to ensure sufficient color contrast across clients.

*Requirement:* WA-ACC-003

**Request Body:** `GetContrastRequirementsRequest`

**Responses:**

- `200`: OK - Contrast requirements returned
- `401`: Unauthorized - Missing or invalid token
- `500`: Internal Server Error - Failed to retrieve requirements

---

### Admin

#### `PUT` /api/v1/verification-requests/{requestId}

**Update verification request status**

Administrative endpoint to approve or reject a business verification request.

*Requirement:* WA-BUS-002

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| requestId | path | string | True | Verification request ID |

**Request Body:** `UpdateBusinessVerificationRequestStatusRequest`

**Responses:**

- `200`: OK - Verification request updated
- `400`: Bad Request - Invalid status transition or missing data
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - Insufficient privileges to update verification status
- `404`: Not Found - Verification request not found
- `500`: Internal Server Error - Unable to update verification request

---

### AiChatMessages

#### `POST` /api/v1/ai-chats/{chatId}/messages

**Send encrypted message to AI assistant**

Queues an end-to-end encrypted message to the AI assistant. Supports offline message queueing.

*Requirement:* WA-AI-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| chatId | path | string | True | AI chat session ID |

**Request Body:** `CreateAiChatMessageRequest`

**Responses:**

- `201`: Created - Message accepted and queued
- `400`: Bad Request - Missing ciphertext or invalid attachment references
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - AI chat session not found
- `409`: Conflict - Duplicate clientMessageId

---

#### `GET` /api/v1/ai-chats/{chatId}/messages

**List AI chat messages**

Retrieves encrypted messages in an AI chat session with pagination.

*Requirement:* WA-AI-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| chatId | path | string | True | AI chat session ID |
| page | query | integer | True | Page number for pagination |
| pageSize | query | integer | True | Number of items per page |

**Request Body:** `ListAiChatMessagesRequest`

**Responses:**

- `200`: OK - Messages retrieved
- `400`: Bad Request - Invalid pagination parameters
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - AI chat session not found

---

### AiChats

#### `POST` /api/v1/ai-chats

**Create AI chat session**

Creates a new AI assistant chat session for a user to exchange end-to-end encrypted messages.

*Requirement:* WA-AI-001

**Request Body:** `CreateAiChatRequest`

**Responses:**

- `201`: Created - AI chat session created
- `400`: Bad Request - Missing or invalid assistantId or signalSessionSetup
- `401`: Unauthorized - Missing or invalid token
- `409`: Conflict - AI chat session already exists

---

### AppConfig

#### `GET` /api/v1/app/accessibility/contrast-requirements

**Get contrast requirements**

Provides the system's minimum contrast requirements to ensure sufficient color contrast across clients.

*Requirement:* WA-ACC-003

**Request Body:** `GetContrastRequirementsRequest`

**Responses:**

- `200`: OK - Contrast requirements returned
- `401`: Unauthorized - Missing or invalid token
- `500`: Internal Server Error - Failed to retrieve requirements

---

### AppLock

#### `GET` /api/v1/app-lock

**Get app lock status**

Returns the current app lock configuration and whether the lock is enabled for the authenticated user.

*Requirement:* WA-SEC-003

**Responses:**

- `200`: OK - App lock status returned
- `401`: Unauthorized - Missing or invalid access token
- `403`: Forbidden - User not permitted to access app lock settings
- `500`: Internal Server Error - Failed to retrieve app lock status

---

#### `PUT` /api/v1/app-lock

**Configure app lock**

Enables or disables app lock and configures the authentication method and security settings.

*Requirement:* WA-SEC-003

**Request Body:** `UpdateAppLockRequest`

**Responses:**

- `200`: OK - App lock configuration updated
- `400`: Bad Request - Invalid lock configuration or missing required fields
- `401`: Unauthorized - Missing or invalid access token
- `409`: Conflict - Lock method not supported on device
- `500`: Internal Server Error - Failed to update app lock configuration

---

#### `POST` /api/v1/app-lock/verify

**Verify app lock authentication**

Verifies the provided app lock authentication factor (e.g., PIN) to unlock the app session.

*Requirement:* WA-SEC-003

**Request Body:** `VerifyAppLockRequest`

**Responses:**

- `200`: OK - App lock verified successfully
- `400`: Bad Request - Invalid verification payload
- `401`: Unauthorized - Missing or invalid access token
- `403`: Forbidden - Verification failed or account locked
- `429`: Too Many Requests - Too many failed attempts, temporarily locked
- `500`: Internal Server Error - Failed to verify app lock

---

### AudioMessages

#### `POST` /api/v1/audio-messages

**Send an encrypted audio message**

Uploads an audio file and creates an audio message in a direct chat, group, or broadcast list with end-to-end encrypted payload metadata. The audio file is uploaded as multipart/form-data and stored for delivery over WebSocket and offline queue.

*Requirement:* WA-MED-008

**Request Body:** `CreateAudioMessageRequest`

**Responses:**

- `201`: Created - Audio message accepted and queued for delivery
- `400`: Bad Request - Missing required fields or invalid audio metadata
- `401`: Unauthorized - Missing or invalid access token
- `413`: Payload Too Large - Audio file exceeds the allowed size limit
- `422`: Unprocessable Entity - Unsupported audio MIME type
- `409`: Conflict - Duplicate clientMessageId

---

#### `GET` /api/v1/audio-messages/{audioMessageId}/download

**Download an audio message file**

Retrieves the encrypted audio file for a given audio message. Access is restricted to participants of the thread and used for offline sync.

*Requirement:* WA-MED-008

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| audioMessageId | path | string | True | ID of the audio message to download |

**Request Body:** `DownloadAudioMessageRequest`

**Responses:**

- `200`: OK - Download URL generated
- `401`: Unauthorized - Missing or invalid access token
- `403`: Forbidden - User is not a participant of the thread
- `404`: Not Found - Audio message does not exist
- `410`: Gone - Audio message has expired or been deleted

---

### Auth

#### `POST` /api/v1/phone-registrations

**Start phone registration**

Creates a phone registration session and sends an OTP to the provided phone number for verification.

*Requirement:* WA-AUTH-001

**Request Body:** `CreatePhoneRegistrationRequest`

**Responses:**

- `201`: Created - Registration session created and OTP sent
- `400`: Bad Request - Invalid phone number or missing required fields
- `409`: Conflict - Phone number already registered

---

#### `POST` /api/v1/phone-registrations/{registrationId}/verify

**Verify phone registration**

Verifies the OTP for a phone registration session and creates/activates the user account.

*Requirement:* WA-AUTH-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| registrationId | path | string | True | Registration session identifier |

**Request Body:** `VerifyPhoneRegistrationRequest`

**Responses:**

- `201`: Created - Phone number verified and user account created
- `400`: Bad Request - Invalid or expired OTP
- `404`: Not Found - Registration session does not exist
- `409`: Conflict - Phone number already verified

---

#### `POST` /api/v1/phone-registrations/{registrationId}/resend-otp

**Resend OTP**

Resends the OTP for an existing phone registration session.

*Requirement:* WA-AUTH-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| registrationId | path | string | True | Registration session identifier |

**Request Body:** `ResendPhoneRegistrationOtpRequest`

**Responses:**

- `201`: Created - OTP resent successfully
- `400`: Bad Request - Invalid delivery channel
- `404`: Not Found - Registration session does not exist
- `429`: Too Many Requests - OTP resend rate limit exceeded

---

#### `POST` /api/v1/auth/2fa/verify

**Verify 2FA PIN during authentication**

Verifies the 6-digit PIN for users with 2FA enabled during login.

*Requirement:* WA-AUTH-002

**Request Body:** `VerifyTwoFactorRequest`

**Responses:**

- `200`: OK - 2FA verified
- `400`: Bad Request - PIN must be exactly 6 digits
- `401`: Unauthorized - Invalid login session
- `403`: Forbidden - PIN verification failed
- `404`: Not Found - User or 2FA configuration not found

---

#### `POST` /api/v1/auth/passkeys/registration/options

**Get passkey registration options**

Generates WebAuthn registration options (challenge, rp, user, params) for creating a passkey on the client.

*Requirement:* WA-AUTH-005

**Request Body:** `PasskeyRegistrationOptionsRequest`

**Responses:**

- `201`: Created - Registration options generated
- `400`: Bad Request - Missing or invalid registration input
- `429`: Too Many Requests - Rate limit exceeded
- `500`: Internal Server Error - Failed to create registration options

---

#### `POST` /api/v1/auth/passkeys/registration/verify

**Verify passkey registration**

Verifies the WebAuthn registration response and stores the passkey credential for the user.

*Requirement:* WA-AUTH-005

**Request Body:** `PasskeyRegistrationVerifyRequest`

**Responses:**

- `201`: Created - Passkey registered successfully
- `400`: Bad Request - Invalid attestation or malformed credential
- `409`: Conflict - Passkey already registered
- `422`: Unprocessable Entity - Challenge mismatch or verification failed
- `500`: Internal Server Error - Failed to store passkey

---

#### `POST` /api/v1/auth/passkeys/authentication/options

**Get passkey authentication options**

Generates WebAuthn authentication options (challenge, allowCredentials) for passkey login.

*Requirement:* WA-AUTH-005

**Request Body:** `PasskeyAuthenticationOptionsRequest`

**Responses:**

- `201`: Created - Authentication options generated
- `400`: Bad Request - Missing or invalid authentication input
- `404`: Not Found - User not found or no passkeys available
- `429`: Too Many Requests - Rate limit exceeded
- `500`: Internal Server Error - Failed to create authentication options

---

#### `POST` /api/v1/auth/passkeys/authentication/verify

**Verify passkey authentication**

Verifies the WebAuthn authentication response and issues access tokens upon success.

*Requirement:* WA-AUTH-005

**Request Body:** `PasskeyAuthenticationVerifyRequest`

**Responses:**

- `201`: Created - Authentication verified and tokens issued
- `400`: Bad Request - Invalid assertion or malformed credential
- `401`: Unauthorized - Verification failed or credential not recognized
- `422`: Unprocessable Entity - Challenge mismatch or signature invalid
- `500`: Internal Server Error - Failed to verify authentication

---

#### `POST` /api/v1/auth/pin/verify

**Verify PIN during two-step verification**

Verifies the user's PIN as part of the two-step verification flow using a temporary authentication token.

*Requirement:* WA-SEC-006

**Request Body:** `VerifyPinRequest`

**Responses:**

- `200`: OK - PIN verified and access token issued
- `400`: Bad Request - Missing or malformed tempAuthToken
- `401`: Unauthorized - PIN verification failed
- `404`: Not Found - Temporary authentication session not found

---

#### `POST` /api/v1/integrations/apps/{appId}/tokens

**Issue API token**

Issues an access token for the integration app using client credentials.

*Requirement:* WA-BUS-010

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| appId | path | string | True | Integration app ID |

**Request Body:** `IssueTokenRequest`

**Responses:**

- `201`: Created - Token issued
- `400`: Bad Request - Missing or invalid credentials
- `401`: Unauthorized - Invalid client credentials
- `404`: Not Found - App does not exist

---

### AwayMessages

#### `GET` /api/v1/users/{userId}/away-message

**Get user's automatic away message configuration**

Retrieves the current automatic away message settings for a user, including enabled state, message text, and schedule.

*Requirement:* WA-BUS-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Request Body:** `GetAwayMessageRequest`

**Responses:**

- `200`: OK - Away message configuration retrieved
- `401`: Unauthorized - Missing or invalid access token
- `403`: Forbidden - Insufficient permissions to access this user's settings
- `404`: Not Found - Away message configuration does not exist

---

#### `PUT` /api/v1/users/{userId}/away-message

**Create or update user's automatic away message configuration**

Creates or updates the automatic away message settings for a user, including enabled state, message text, and schedule.

*Requirement:* WA-BUS-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Request Body:** `UpsertAwayMessageRequest`

**Responses:**

- `200`: OK - Away message configuration updated
- `400`: Bad Request - Invalid schedule or message payload
- `401`: Unauthorized - Missing or invalid access token
- `403`: Forbidden - Insufficient permissions to update this user's settings

---

#### `DELETE` /api/v1/users/{userId}/away-message

**Disable and remove user's automatic away message configuration**

Disables automatic away messages and removes the current configuration for a user.

*Requirement:* WA-BUS-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Request Body:** `DeleteAwayMessageRequest`

**Responses:**

- `200`: OK - Away message configuration deleted
- `401`: Unauthorized - Missing or invalid access token
- `403`: Forbidden - Insufficient permissions to delete this user's settings
- `404`: Not Found - Away message configuration does not exist

---

### Backups

#### `POST` /api/v1/backups

**Create a new encrypted chat backup**

Creates a new cloud backup for a user by uploading an end-to-end encrypted archive and metadata. The payload must already be encrypted using the Signal Protocol.

*Requirement:* WA-BAK-001

**Request Body:** `CreateBackupRequest`

**Responses:**

- `201`: Created - Backup stored successfully
- `400`: Bad Request - Missing or invalid backup metadata or file
- `401`: Unauthorized - Missing or invalid access token
- `413`: Payload Too Large - Backup exceeds allowed size limits
- `415`: Unsupported Media Type - Expected multipart/form-data
- `500`: Internal Server Error - Failed to store backup

---

#### `GET` /api/v1/backups

**List backups**

Retrieves a paginated list of backups for the authenticated user.

*Requirement:* WA-BAK-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| page | query | integer | True | Page number for pagination |
| pageSize | query | integer | True | Number of items per page |

**Request Body:** `ListBackupsRequest`

**Responses:**

- `200`: OK - Backups retrieved successfully
- `400`: Bad Request - Invalid pagination parameters
- `401`: Unauthorized - Missing or invalid access token
- `500`: Internal Server Error - Failed to retrieve backups

---

#### `GET` /api/v1/backups/{backupId}

**Get backup metadata**

Retrieves metadata for a specific backup without downloading the archive.

*Requirement:* WA-BAK-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| backupId | path | string | True | Backup ID |

**Request Body:** `GetBackupRequest`

**Responses:**

- `200`: OK - Backup metadata retrieved
- `401`: Unauthorized - Missing or invalid access token
- `404`: Not Found - Backup ID does not exist
- `500`: Internal Server Error - Failed to retrieve backup

---

#### `GET` /api/v1/backups/{backupId}/download

**Request backup download**

Returns a time-limited download URL for the encrypted backup archive.

*Requirement:* WA-BAK-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| backupId | path | string | True | Backup ID |

**Request Body:** `DownloadBackupRequest`

**Responses:**

- `200`: OK - Download URL generated
- `401`: Unauthorized - Missing or invalid access token
- `404`: Not Found - Backup ID does not exist
- `500`: Internal Server Error - Failed to generate download URL

---

#### `POST` /api/v1/backups/{backupId}/restore

**Initiate backup restore**

Marks a backup as selected for restore and returns restore metadata. Actual decryption and import occur on the client.

*Requirement:* WA-BAK-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| backupId | path | string | True | Backup ID |

**Request Body:** `RestoreBackupRequest`

**Responses:**

- `201`: Created - Restore initiated
- `400`: Bad Request - Missing or invalid device ID
- `401`: Unauthorized - Missing or invalid access token
- `404`: Not Found - Backup ID does not exist
- `409`: Conflict - Restore already in progress for this backup
- `500`: Internal Server Error - Failed to initiate restore

---

#### `DELETE` /api/v1/backups/{backupId}

**Delete a backup**

Deletes a specific backup and its encrypted archive from cloud storage.

*Requirement:* WA-BAK-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| backupId | path | string | True | Backup ID |

**Request Body:** `DeleteBackupRequest`

**Responses:**

- `200`: OK - Backup deleted successfully
- `401`: Unauthorized - Missing or invalid access token
- `404`: Not Found - Backup ID does not exist
- `500`: Internal Server Error - Failed to delete backup

---

#### `POST` /api/v1/backups

**Create encrypted backup**

Uploads a client-side end-to-end encrypted backup blob and its metadata using Signal Protocol key identifiers. The server stores only ciphertext and metadata needed for retrieval.

*Requirement:* WA-BAK-002

**Request Body:** `CreateBackupRequest`

**Responses:**

- `201`: Created - Encrypted backup stored successfully
- `400`: Bad Request - Missing required fields or invalid metadata
- `401`: Unauthorized - Missing or invalid token
- `413`: Payload Too Large - Backup exceeds size limits
- `415`: Unsupported Media Type - Expected multipart/form-data
- `500`: Internal Server Error - Failed to store backup

---

#### `GET` /api/v1/backups

**List encrypted backups**

Returns a paginated list of encrypted backup metadata for the authenticated user.

*Requirement:* WA-BAK-002

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| page | query | integer | True | Page number for pagination |
| pageSize | query | integer | True | Number of items per page |

**Request Body:** `ListBackupsRequest`

**Responses:**

- `200`: OK - Backups retrieved
- `400`: Bad Request - Invalid pagination parameters
- `401`: Unauthorized - Missing or invalid token
- `500`: Internal Server Error - Failed to fetch backups

---

#### `GET` /api/v1/backups/{backupId}

**Get backup metadata**

Returns metadata for a specific encrypted backup without exposing plaintext.

*Requirement:* WA-BAK-002

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| backupId | path | string | True | Backup ID |

**Request Body:** `GetBackupRequest`

**Responses:**

- `200`: OK - Backup metadata retrieved
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Backup does not exist
- `500`: Internal Server Error - Failed to fetch backup

---

#### `GET` /api/v1/backups/{backupId}/download

**Download encrypted backup**

Provides a secure, time-limited URL to download the encrypted backup ciphertext.

*Requirement:* WA-BAK-002

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| backupId | path | string | True | Backup ID |

**Request Body:** `DownloadBackupRequest`

**Responses:**

- `200`: OK - Download URL generated
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Backup does not exist
- `500`: Internal Server Error - Failed to generate download URL

---

#### `DELETE` /api/v1/backups/{backupId}

**Delete encrypted backup**

Permanently deletes an encrypted backup and its metadata.

*Requirement:* WA-BAK-002

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| backupId | path | string | True | Backup ID |

**Request Body:** `DeleteBackupRequest`

**Responses:**

- `200`: OK - Backup deleted
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Backup does not exist
- `500`: Internal Server Error - Failed to delete backup

---

### BiometricAuth

#### `POST` /api/v1/biometric/registration-options

**Create biometric registration challenge**

Generates a WebAuthn/FIDO2 registration challenge for enrolling a biometric credential on a trusted device.

*Requirement:* WA-AUTH-003

**Request Body:** `BiometricRegistrationOptionsRequest`

**Responses:**

- `201`: Created - Registration options generated
- `400`: Bad Request - Missing or invalid device information
- `401`: Unauthorized - Missing or invalid token
- `409`: Conflict - Biometric registration already initiated for device

---

#### `POST` /api/v1/biometric/credentials

**Enroll biometric credential**

Completes biometric enrollment by submitting the attestation response from the device.

*Requirement:* WA-AUTH-003

**Request Body:** `CreateBiometricCredentialRequest`

**Responses:**

- `201`: Created - Biometric credential enrolled
- `400`: Bad Request - Invalid attestation data
- `401`: Unauthorized - Missing or invalid token
- `409`: Conflict - Credential already enrolled for device

---

#### `GET` /api/v1/biometric/credentials

**List biometric credentials**

Returns a paginated list of enrolled biometric credentials for the authenticated user.

*Requirement:* WA-AUTH-003

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| page | query | integer | True | Page number for pagination |
| pageSize | query | integer | True | Number of items per page |

**Request Body:** `ListBiometricCredentialsRequest`

**Responses:**

- `200`: OK - Credentials retrieved
- `401`: Unauthorized - Missing or invalid token

---

#### `DELETE` /api/v1/biometric/credentials/{credentialId}

**Revoke biometric credential**

Revokes an enrolled biometric credential for the authenticated user.

*Requirement:* WA-AUTH-003

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| credentialId | path | string | True | Biometric credential ID |

**Request Body:** `DeleteBiometricCredentialRequest`

**Responses:**

- `200`: OK - Credential revoked
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Credential does not exist

---

#### `POST` /api/v1/biometric/authentication-options

**Create biometric authentication challenge**

Generates a WebAuthn/FIDO2 authentication challenge for biometric login.

*Requirement:* WA-AUTH-003

**Request Body:** `BiometricAuthenticationOptionsRequest`

**Responses:**

- `201`: Created - Authentication options generated
- `400`: Bad Request - Missing or invalid user/device information
- `404`: Not Found - User or credential not found
- `409`: Conflict - Authentication already in progress for device

---

#### `POST` /api/v1/biometric/authenticate

**Authenticate with biometrics**

Validates the biometric assertion response and issues authentication tokens.

*Requirement:* WA-AUTH-003

**Request Body:** `BiometricAuthenticateRequest`

**Responses:**

- `200`: OK - Authentication successful
- `400`: Bad Request - Invalid assertion payload
- `401`: Unauthorized - Biometric verification failed
- `404`: Not Found - Credential not found
- `429`: Too Many Requests - Too many failed biometric attempts

---

### Blocks

#### `POST` /api/v1/users/{userId}/blocks

**Block a contact**

Blocks a contact for the given user. Subsequent messages and calls from the blocked contact are prevented or filtered according to policy. This operation is idempotent per contact.

*Requirement:* WA-SEC-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID who is blocking the contact |

**Request Body:** `BlockContactRequest`

**Responses:**

- `201`: Created - Contact successfully blocked
- `400`: Bad Request - contactId missing or invalid
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - User not permitted to block this contact
- `404`: Not Found - User or contact does not exist
- `409`: Conflict - Contact is already blocked

---

#### `GET` /api/v1/users/{userId}/blocks

**List blocked contacts**

Retrieves a paginated list of blocked contacts for the given user.

*Requirement:* WA-SEC-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID whose blocked contacts are retrieved |
| page | query | integer | False | Page number for pagination |
| pageSize | query | integer | False | Number of items per page |

**Request Body:** `ListBlockedContactsRequest`

**Responses:**

- `200`: OK - Blocked contacts retrieved
- `400`: Bad Request - Invalid pagination parameters
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - User does not exist
- `500`: Internal Server Error - Unable to retrieve blocked contacts

---

#### `DELETE` /api/v1/users/{userId}/blocks/{contactId}

**Unblock a contact**

Removes a block relationship so the contact can message or call the user again.

*Requirement:* WA-SEC-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID who is unblocking the contact |
| contactId | path | string | True | Blocked contact ID to remove |

**Request Body:** `UnblockContactRequest`

**Responses:**

- `200`: OK - Contact successfully unblocked
- `400`: Bad Request - Invalid userId or contactId
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - User not permitted to unblock this contact
- `404`: Not Found - Block relationship does not exist
- `500`: Internal Server Error - Unable to remove block

---

### BroadcastChannels

#### `POST` /api/v1/broadcast-channels

**Create a one-way broadcast channel**

Creates a one-way broadcast channel where only the owner can send messages. Enforces max recipients of 256.

*Requirement:* WA-GRP-007

**Request Body:** `CreateBroadcastChannelRequest`

**Responses:**

- `201`: Created - Broadcast channel created
- `400`: Bad Request - Invalid input or recipient limit exceeded
- `401`: Unauthorized - Missing or invalid token
- `409`: Conflict - Channel with same name already exists

---

#### `GET` /api/v1/broadcast-channels

**List broadcast channels**

Returns a paginated list of broadcast channels the user owns or is subscribed to.

*Requirement:* WA-GRP-007

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| page | query | integer | True | Page number |
| pageSize | query | integer | True | Page size |

**Responses:**

- `200`: OK - Broadcast channels returned
- `401`: Unauthorized - Missing or invalid token

---

#### `GET` /api/v1/broadcast-channels/{channelId}

**Get a broadcast channel**

Returns details for a specific broadcast channel.

*Requirement:* WA-GRP-007

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| channelId | path | string | True | Broadcast channel ID |

**Responses:**

- `200`: OK - Broadcast channel returned
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Broadcast channel does not exist

---

#### `PUT` /api/v1/broadcast-channels/{channelId}

**Update a broadcast channel**

Updates channel metadata (e.g., name, avatar).

*Requirement:* WA-GRP-007

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| channelId | path | string | True | Broadcast channel ID |

**Request Body:** `UpdateBroadcastChannelRequest`

**Responses:**

- `200`: OK - Broadcast channel updated
- `400`: Bad Request - Invalid input
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Broadcast channel does not exist

---

#### `DELETE` /api/v1/broadcast-channels/{channelId}

**Delete a broadcast channel**

Deletes a broadcast channel and its configuration. Messages remain governed by retention policies.

*Requirement:* WA-GRP-007

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| channelId | path | string | True | Broadcast channel ID |

**Responses:**

- `200`: OK - Broadcast channel deleted
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Broadcast channel does not exist

---

#### `POST` /api/v1/broadcast-channels/{channelId}/recipients

**Add recipients to a broadcast channel**

Adds recipients to a broadcast channel. Enforces max recipients of 256.

*Requirement:* WA-GRP-007

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| channelId | path | string | True | Broadcast channel ID |

**Request Body:** `AddBroadcastRecipientsRequest`

**Responses:**

- `200`: OK - Recipients added
- `400`: Bad Request - Recipient limit exceeded or invalid IDs
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Broadcast channel does not exist

---

#### `DELETE` /api/v1/broadcast-channels/{channelId}/recipients

**Remove recipients from a broadcast channel**

Removes recipients from a broadcast channel.

*Requirement:* WA-GRP-007

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| channelId | path | string | True | Broadcast channel ID |

**Request Body:** `RemoveBroadcastRecipientsRequest`

**Responses:**

- `200`: OK - Recipients removed
- `400`: Bad Request - Invalid IDs
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Broadcast channel does not exist

---

### BroadcastLists

#### `POST` /api/v1/broadcast-lists

**Create a broadcast list**

Creates a new broadcast list for mass messaging to multiple recipients (max 256).

*Requirement:* WA-MSG-011

**Request Body:** `CreateBroadcastListRequest`

**Responses:**

- `201`: Created - Broadcast list created successfully
- `400`: Bad Request - Recipient list exceeds limit or invalid payload
- `401`: Unauthorized - Missing or invalid token
- `409`: Conflict - Broadcast list name already exists

---

#### `GET` /api/v1/broadcast-lists

**List broadcast lists**

Returns a paginated list of broadcast lists for the authenticated user.

*Requirement:* WA-MSG-011

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| page | query | integer | True | Page number |
| pageSize | query | integer | True | Number of items per page |

**Request Body:** `ListBroadcastListsRequest`

**Responses:**

- `200`: OK - Broadcast lists returned
- `400`: Bad Request - Invalid pagination parameters
- `401`: Unauthorized - Missing or invalid token

---

#### `GET` /api/v1/broadcast-lists/{broadcastListId}

**Get broadcast list details**

Returns details of a single broadcast list including recipients.

*Requirement:* WA-MSG-011

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| broadcastListId | path | string | True | Broadcast list ID |

**Request Body:** `GetBroadcastListRequest`

**Responses:**

- `200`: OK - Broadcast list returned
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Broadcast list does not exist

---

#### `PUT` /api/v1/broadcast-lists/{broadcastListId}

**Update broadcast list**

Updates broadcast list name and recipients (max 256).

*Requirement:* WA-MSG-011

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| broadcastListId | path | string | True | Broadcast list ID |

**Request Body:** `UpdateBroadcastListRequest`

**Responses:**

- `200`: OK - Broadcast list updated
- `400`: Bad Request - Recipient list exceeds limit or invalid payload
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Broadcast list does not exist

---

#### `DELETE` /api/v1/broadcast-lists/{broadcastListId}

**Delete broadcast list**

Deletes an existing broadcast list.

*Requirement:* WA-MSG-011

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| broadcastListId | path | string | True | Broadcast list ID |

**Request Body:** `DeleteBroadcastListRequest`

**Responses:**

- `200`: OK - Broadcast list deleted
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Broadcast list does not exist

---

### BroadcastMessages

#### `POST` /api/v1/broadcast-lists/{broadcastListId}/messages

**Send broadcast message**

Sends an end-to-end encrypted message to all recipients in the broadcast list. Supports offline queuing and real-time delivery via WebSocket.

*Requirement:* WA-MSG-011

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| broadcastListId | path | string | True | Broadcast list ID |

**Request Body:** `SendBroadcastMessageRequest`

**Responses:**

- `201`: Created - Broadcast message accepted for delivery
- `400`: Bad Request - Invalid encrypted payload or message type
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Broadcast list does not exist
- `413`: Payload Too Large - Media exceeds size limits

---

#### `POST` /api/v1/broadcast-channels/{channelId}/messages

**Send a broadcast message**

Sends an E2E encrypted one-way message from the owner to all recipients. Supports offline queueing and WebSocket delivery.

*Requirement:* WA-GRP-007

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| channelId | path | string | True | Broadcast channel ID |

**Request Body:** `SendBroadcastMessageRequest`

**Responses:**

- `201`: Created - Broadcast message accepted
- `400`: Bad Request - Invalid encrypted payload or media metadata
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - Only owner can send messages
- `404`: Not Found - Broadcast channel does not exist

---

#### `GET` /api/v1/broadcast-channels/{channelId}/messages

**List broadcast messages**

Returns a paginated list of broadcast messages for the channel. Only owner and recipients can read.

*Requirement:* WA-GRP-007

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| channelId | path | string | True | Broadcast channel ID |
| page | query | integer | True | Page number |
| pageSize | query | integer | True | Page size |

**Responses:**

- `200`: OK - Broadcast messages returned
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - Not a channel participant
- `404`: Not Found - Broadcast channel does not exist

---

### BusinessProfiles

#### `POST` /api/v1/business-profiles

**Create a business profile**

Creates an extended business profile for an authenticated account.

*Requirement:* WA-BUS-001

**Request Body:** `CreateBusinessProfileRequest`

**Responses:**

- `201`: Created - Business profile created successfully
- `400`: Bad Request - Missing or invalid business profile fields
- `401`: Unauthorized - Missing or invalid access token
- `409`: Conflict - Business profile already exists for this account

---

#### `GET` /api/v1/business-profiles

**List business profiles**

Returns a paginated list of business profiles accessible to the authenticated user.

*Requirement:* WA-BUS-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| page | query | integer | True | Page number for pagination |
| pageSize | query | integer | True | Number of items per page |

**Request Body:** `ListBusinessProfilesRequest`

**Responses:**

- `200`: OK - Business profiles retrieved successfully
- `401`: Unauthorized - Missing or invalid access token
- `500`: Internal Server Error - Unexpected error while listing business profiles

---

#### `GET` /api/v1/business-profiles/{id}

**Get a business profile**

Retrieves a single business profile by ID.

*Requirement:* WA-BUS-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| id | path | string | True | Business profile ID |

**Request Body:** `GetBusinessProfileRequest`

**Responses:**

- `200`: OK - Business profile retrieved successfully
- `401`: Unauthorized - Missing or invalid access token
- `404`: Not Found - Business profile does not exist

---

#### `PUT` /api/v1/business-profiles/{id}

**Update a business profile**

Updates an existing business profile by ID.

*Requirement:* WA-BUS-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| id | path | string | True | Business profile ID |

**Request Body:** `UpdateBusinessProfileRequest`

**Responses:**

- `200`: OK - Business profile updated successfully
- `400`: Bad Request - Invalid business profile fields
- `401`: Unauthorized - Missing or invalid access token
- `404`: Not Found - Business profile does not exist

---

#### `DELETE` /api/v1/business-profiles/{id}

**Delete a business profile**

Deletes an existing business profile by ID.

*Requirement:* WA-BUS-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| id | path | string | True | Business profile ID |

**Request Body:** `DeleteBusinessProfileRequest`

**Responses:**

- `200`: OK - Business profile deleted successfully
- `401`: Unauthorized - Missing or invalid access token
- `404`: Not Found - Business profile does not exist

---

#### `POST` /api/v1/business-profiles/{id}/media

**Upload business profile media**

Uploads media (logo or cover) for a business profile. Enforce media limits (16MB images, 2GB documents).

*Requirement:* WA-BUS-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| id | path | string | True | Business profile ID |

**Request Body:** `UploadBusinessProfileMediaRequest`

**Responses:**

- `201`: Created - Media uploaded successfully
- `400`: Bad Request - Invalid media type or file
- `401`: Unauthorized - Missing or invalid access token
- `413`: Payload Too Large - Media exceeds allowed size limits

---

### BusinessStatistics

#### `GET` /api/v1/businesses/{businessId}/statistics/messages

**Retrieve basic message statistics for a business**

Provides aggregated message statistics for a business within a specified time range, including counts of sent, delivered, read, failed, and media messages. Supports optional grouping by day or hour.

*Requirement:* WA-BUS-009

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| businessId | path | string | True | Business ID |
| from | query | string | True | Start of time range in ISO 8601 format |
| to | query | string | True | End of time range in ISO 8601 format |
| groupBy | query | string | False | Optional grouping interval: hour or day |

**Responses:**

- `200`: OK - Business message statistics retrieved successfully
- `400`: Bad Request - Invalid time range or groupBy parameter
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - Not authorized to access business statistics
- `404`: Not Found - Business does not exist
- `500`: Internal Server Error - Failed to retrieve statistics

---

### BusinessVerification

#### `POST` /api/v1/businesses/{businessId}/verification-requests

**Submit a business verification request**

Creates a verification request for a business with required metadata and optional document references.

*Requirement:* WA-BUS-002

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| businessId | path | string | True | Business ID |

**Request Body:** `CreateBusinessVerificationRequest`

**Responses:**

- `201`: Created - Verification request submitted
- `400`: Bad Request - Missing or invalid verification data
- `401`: Unauthorized - Missing or invalid token
- `409`: Conflict - Active verification request already exists
- `500`: Internal Server Error - Unable to create verification request

---

#### `GET` /api/v1/businesses/{businessId}/verification-status

**Get business verification status**

Retrieves the current verification status for a business.

*Requirement:* WA-BUS-002

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| businessId | path | string | True | Business ID |

**Request Body:** `GetBusinessVerificationStatusRequest`

**Responses:**

- `200`: OK - Verification status retrieved
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Business or verification status not found
- `500`: Internal Server Error - Unable to retrieve verification status

---

#### `PUT` /api/v1/verification-requests/{requestId}

**Update verification request status**

Administrative endpoint to approve or reject a business verification request.

*Requirement:* WA-BUS-002

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| requestId | path | string | True | Verification request ID |

**Request Body:** `UpdateBusinessVerificationRequestStatusRequest`

**Responses:**

- `200`: OK - Verification request updated
- `400`: Bad Request - Invalid status transition or missing data
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - Insufficient privileges to update verification status
- `404`: Not Found - Verification request not found
- `500`: Internal Server Error - Unable to update verification request

---

### CallLinks

#### `POST` /api/v1/call-links

**Create a scheduled call link**

Creates a WebRTC call link for a planned call, including schedule, access rules, and end-to-end encryption metadata.

*Requirement:* WA-CALL-005

**Request Body:** `CreateCallLinkRequest`

**Responses:**

- `201`: Created
- `400`: Bad Request - Invalid schedule, maxParticipants exceeds limit, or missing required fields
- `401`: Unauthorized - Missing or invalid token
- `409`: Conflict - Overlapping scheduled call or duplicate link for same time window

---

#### `GET` /api/v1/call-links

**List scheduled call links**

Retrieves a paginated list of scheduled call links accessible by the user.

*Requirement:* WA-CALL-005

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| page | query | integer | True | Page number for pagination |
| pageSize | query | integer | True | Number of items per page |
| status | query | string | False | Filter by status (scheduled, active, ended, canceled) |
| hostUserId | query | string | False | Filter by host user ID |

**Request Body:** `ListCallLinksRequest`

**Responses:**

- `200`: OK - Call links retrieved
- `400`: Bad Request - Invalid pagination parameters
- `401`: Unauthorized - Missing or invalid token

---

#### `GET` /api/v1/call-links/{callLinkId}

**Get scheduled call link details**

Returns details for a specific scheduled call link including access rules and encryption metadata.

*Requirement:* WA-CALL-005

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| callLinkId | path | string | True | Call link ID |

**Request Body:** `GetCallLinkRequest`

**Responses:**

- `200`: OK - Call link details retrieved
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - User not allowed to access this call link
- `404`: Not Found - Call link does not exist

---

#### `PUT` /api/v1/call-links/{callLinkId}

**Update a scheduled call link**

Updates schedule or access rules for a planned call link prior to start time.

*Requirement:* WA-CALL-005

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| callLinkId | path | string | True | Call link ID |

**Request Body:** `UpdateCallLinkRequest`

**Responses:**

- `200`: OK - Call link updated
- `400`: Bad Request - Invalid schedule or maxParticipants exceeds limit
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - Only host can update the call link
- `409`: Conflict - Call already started or ended

---

#### `DELETE` /api/v1/call-links/{callLinkId}

**Delete a scheduled call link**

Cancels and deletes a scheduled call link before it starts.

*Requirement:* WA-CALL-005

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| callLinkId | path | string | True | Call link ID |

**Request Body:** `DeleteCallLinkRequest`

**Responses:**

- `200`: OK - Call link deleted
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - Only host can delete the call link
- `404`: Not Found - Call link does not exist
- `409`: Conflict - Call already started or ended

---

### CallLogs

#### `GET` /api/v1/call-logs

**List call history**

Retrieves a paginated list of call log entries for the authenticated user. Supports offline sync by allowing clients to request pages.

*Requirement:* WA-CALL-007

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| page | query | integer | True | Page number for pagination |
| pageSize | query | integer | True | Number of items per page |
| from | query | string | False | ISO-8601 start timestamp to filter call logs |
| to | query | string | False | ISO-8601 end timestamp to filter call logs |

**Responses:**

- `200`: OK - Call logs retrieved
- `400`: Bad Request - Invalid pagination or filter parameters
- `401`: Unauthorized - Missing or invalid token
- `500`: Internal Server Error - Unable to retrieve call logs

---

#### `GET` /api/v1/call-logs/{callLogId}

**Get call log detail**

Retrieves detailed information for a specific call log entry.

*Requirement:* WA-CALL-007

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| callLogId | path | string | True | Call log ID |

**Responses:**

- `200`: OK - Call log retrieved
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Call log does not exist
- `500`: Internal Server Error - Unable to retrieve call log

---

#### `POST` /api/v1/call-logs

**Create call log entry**

Creates a call log entry after a WebRTC call. Metadata is encrypted end-to-end using the Signal Protocol.

*Requirement:* WA-CALL-007

**Request Body:** `CreateCallLogRequest`

**Responses:**

- `201`: Created - Call log entry created
- `400`: Bad Request - Missing or invalid fields
- `401`: Unauthorized - Missing or invalid token
- `409`: Conflict - Duplicate WebRTC session ID
- `500`: Internal Server Error - Unable to create call log

---

#### `DELETE` /api/v1/call-logs/{callLogId}

**Delete call log entry**

Deletes a specific call log entry for the authenticated user.

*Requirement:* WA-CALL-007

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| callLogId | path | string | True | Call log ID |

**Responses:**

- `200`: OK - Call log deleted
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Call log does not exist
- `500`: Internal Server Error - Unable to delete call log

---

### CallNotificationSettings

#### `GET` /api/v1/users/{userId}/call-notification-settings

**Get call notification settings**

Retrieves the separate call notification settings for a user. Settings apply to incoming voice/video calls using WebRTC.

*Requirement:* WA-NOT-006

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | Unique user ID |

**Request Body:** `GetCallNotificationSettingsRequest`

**Responses:**

- `200`: OK - Call notification settings retrieved
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - User does not have access to this resource
- `404`: Not Found - User or settings do not exist
- `500`: Internal Server Error - Unexpected error while retrieving settings

---

#### `PUT` /api/v1/users/{userId}/call-notification-settings

**Update call notification settings**

Updates the separate call notification settings for a user. Changes apply to incoming voice/video calls using WebRTC.

*Requirement:* WA-NOT-006

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | Unique user ID |

**Request Body:** `UpdateCallNotificationSettingsRequest`

**Responses:**

- `200`: OK - Call notification settings updated
- `400`: Bad Request - Invalid settings payload or time format
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - User does not have access to update this resource
- `404`: Not Found - User or settings do not exist
- `409`: Conflict - Settings update conflict
- `500`: Internal Server Error - Unexpected error while updating settings

---

### CallPrivacy

#### `GET` /api/v1/users/{userId}/call-privacy-settings

**Get call privacy settings**

Retrieves the user's call privacy settings, including IP address masking preference for WebRTC calls.

*Requirement:* WA-SEC-008

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Request Body:** `GetCallPrivacySettingsRequest`

**Responses:**

- `200`: OK - Settings retrieved successfully
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - User does not exist

---

#### `PUT` /api/v1/users/{userId}/call-privacy-settings

**Update call privacy settings**

Updates the user's call privacy settings to enable or disable IP address masking for WebRTC calls.

*Requirement:* WA-SEC-008

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Request Body:** `UpdateCallPrivacySettingsRequest`

**Responses:**

- `200`: OK - Settings updated successfully
- `400`: Bad Request - ipMaskingEnabled must be a boolean
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - User does not exist
- `409`: Conflict - Settings update conflict

---

### CallSessions

#### `POST` /api/v1/call-sessions

**Create call session with IP masking**

Creates a WebRTC call session using relay servers to mask participants' IP addresses when ipMaskingEnabled is true.

*Requirement:* WA-SEC-008

**Request Body:** `CreateCallSessionRequest`

**Responses:**

- `201`: Created - Call session created successfully
- `400`: Bad Request - Invalid mediaType or missing calleeIds
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - Caller not allowed to initiate call
- `409`: Conflict - Active call session already exists

---

### Calls

#### `POST` /api/v1/calls

**Create encrypted voice call session**

Creates a new end-to-end encrypted voice call session using Signal Protocol keys and prepares WebRTC signaling. Supports 1:1 and group calls up to 1024 participants.

*Requirement:* WA-CALL-001

**Request Body:** `CreateCallRequest`

**Responses:**

- `201`: Created - Call session created
- `400`: Bad Request - Invalid call type or participant limit exceeded
- `401`: Unauthorized - Missing or invalid token
- `409`: Conflict - Duplicate clientCallId

---

#### `GET` /api/v1/calls

**List calls**

Returns a paginated list of call sessions for the authenticated user.

*Requirement:* WA-CALL-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| page | query | integer | True | Page number |
| pageSize | query | integer | True | Number of items per page |

**Request Body:** `ListCallsRequest`

**Responses:**

- `200`: OK - List of calls returned
- `401`: Unauthorized - Missing or invalid token

---

#### `GET` /api/v1/calls/{callId}

**Get call details**

Retrieves details of a specific call session including participants and status.

*Requirement:* WA-CALL-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| callId | path | string | True | Call ID |

**Request Body:** `GetCallRequest`

**Responses:**

- `200`: OK - Call details returned
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Call does not exist

---

#### `POST` /api/v1/calls/{callId}/participants

**Add participant to call**

Adds a participant to an existing group call. Enforces max group size of 1024.

*Requirement:* WA-CALL-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| callId | path | string | True | Call ID |

**Request Body:** `AddParticipantRequest`

**Responses:**

- `201`: Created - Participant added
- `400`: Bad Request - Group participant limit exceeded
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Call does not exist

---

#### `DELETE` /api/v1/calls/{callId}/participants/{participantId}

**Remove participant from call**

Removes a participant from an existing call.

*Requirement:* WA-CALL-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| callId | path | string | True | Call ID |
| participantId | path | string | True | Participant ID |

**Request Body:** `RemoveParticipantRequest`

**Responses:**

- `200`: OK - Participant removed
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Call or participant does not exist

---

#### `POST` /api/v1/calls/{callId}/end

**End call session**

Ends an active call session and notifies participants via WebSocket.

*Requirement:* WA-CALL-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| callId | path | string | True | Call ID |

**Request Body:** `EndCallRequest`

**Responses:**

- `201`: Created - Call ended and state recorded
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Call does not exist
- `409`: Conflict - Call already ended

---

#### `POST` /api/v1/calls/{callId}/signaling/messages

**Post WebRTC signaling message**

Posts encrypted WebRTC signaling messages (offer/answer/ICE) to support offline queueing and delivery via WebSocket.

*Requirement:* WA-CALL-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| callId | path | string | True | Call ID |

**Request Body:** `SignalingMessageRequest`

**Responses:**

- `201`: Created - Signaling message stored
- `400`: Bad Request - Unsupported signaling type
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Call does not exist

---

#### `GET` /api/v1/calls/{callId}/signaling/messages

**Fetch queued signaling messages**

Fetches queued encrypted signaling messages for offline clients.

*Requirement:* WA-CALL-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| callId | path | string | True | Call ID |
| page | query | integer | True | Page number |
| pageSize | query | integer | True | Number of items per page |

**Request Body:** `ListSignalingMessagesRequest`

**Responses:**

- `200`: OK - Queued signaling messages returned
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Call does not exist

---

#### `POST` /api/v1/calls

**Create a new video call session**

Creates an end-to-end encrypted WebRTC video call session and returns signaling metadata and ICE server configuration for mobile clients.

*Requirement:* WA-CALL-002

**Request Body:** `CreateCallRequest`

**Responses:**

- `201`: Created - Call session created successfully
- `400`: Bad Request - Invalid call type or participants exceed limits
- `401`: Unauthorized - Missing or invalid token
- `409`: Conflict - Call already exists or duplicate creation request

---

#### `GET` /api/v1/calls

**List video call sessions**

Returns a paginated list of video call sessions for the authenticated user.

*Requirement:* WA-CALL-002

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| page | query | integer | True | Page number for pagination |
| pageSize | query | integer | True | Number of items per page |

**Request Body:** `ListCallsRequest`

**Responses:**

- `200`: OK - Call sessions retrieved successfully
- `400`: Bad Request - Invalid pagination parameters
- `401`: Unauthorized - Missing or invalid token

---

#### `POST` /api/v1/calls/{id}/join

**Join a video call session**

Joins an existing video call session and returns WebRTC signaling details for the participant.

*Requirement:* WA-CALL-002

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| id | path | string | True | Call ID |

**Request Body:** `JoinCallRequest`

**Responses:**

- `201`: Created - Joined the call successfully
- `400`: Bad Request - Invalid call ID or encryption parameters
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Call not found
- `409`: Conflict - Call already ended or participant limit reached

---

#### `GET` /api/v1/calls/{id}

**Get video call session details**

Retrieves details for a specific video call session.

*Requirement:* WA-CALL-002

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| id | path | string | True | Call ID |

**Request Body:** `GetCallRequest`

**Responses:**

- `200`: OK - Call details retrieved successfully
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Call not found

---

#### `POST` /api/v1/calls/{id}/end

**End a video call session**

Ends an active video call session and notifies participants via WebSocket signaling.

*Requirement:* WA-CALL-002

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| id | path | string | True | Call ID |

**Request Body:** `EndCallRequest`

**Responses:**

- `201`: Created - Call ended successfully
- `400`: Bad Request - Invalid call state or reason
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Call not found

---

#### `POST` /api/v1/calls/{callId}/screen-shares

**Start screen sharing in a call**

Creates a screen sharing session for an ongoing WebRTC call and returns signaling metadata needed by clients. Screen content is transmitted via WebRTC; this endpoint only manages session metadata.

*Requirement:* WA-CALL-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| callId | path | string | True | Call ID |

**Request Body:** `CreateScreenShareRequest`

**Responses:**

- `201`: Created - Screen share session started
- `400`: Bad Request - Missing or invalid SDP offer or encryption context
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - User not allowed to share screen in this call
- `404`: Not Found - Call does not exist or is not active
- `409`: Conflict - Screen sharing already active for this publisher

---

#### `GET` /api/v1/calls/{callId}/screen-shares

**List screen sharing sessions in a call**

Returns active and recent screen sharing sessions for an ongoing call.

*Requirement:* WA-CALL-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| callId | path | string | True | Call ID |
| page | query | integer | True | Page number for pagination |
| pageSize | query | integer | True | Page size for pagination |

**Responses:**

- `200`: OK - Screen share sessions retrieved
- `400`: Bad Request - Invalid pagination parameters
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Call does not exist

---

#### `DELETE` /api/v1/calls/{callId}/screen-shares/{screenShareId}

**Stop screen sharing in a call**

Ends an active screen sharing session in a call.

*Requirement:* WA-CALL-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| callId | path | string | True | Call ID |
| screenShareId | path | string | True | Screen share session ID |

**Request Body:** `EndScreenShareRequest`

**Responses:**

- `200`: OK - Screen share session ended
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - User not allowed to end this screen share
- `404`: Not Found - Screen share session does not exist
- `409`: Conflict - Screen share session already ended

---

#### `POST` /api/v1/calls/{callId}/reject

**Reject an incoming call with a message**

Rejects a WebRTC call and optionally sends an encrypted quick-reply message to the caller. Designed for fast response and offline queuing.

*Requirement:* WA-CALL-006

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| callId | path | string | True | Unique call identifier |

**Request Body:** `RejectCallRequest`

**Responses:**

- `201`: Created - Call rejected and message queued
- `400`: Bad Request - Missing or invalid rejection reason or payload
- `401`: Unauthorized - Missing or invalid authentication token
- `404`: Not Found - Call ID does not exist or is no longer active
- `409`: Conflict - Call already ended or rejection already processed
- `500`: Internal Server Error - Failed to process rejection

---

### CartItems

#### `GET` /api/v1/carts/{cartId}/items

**List cart items**

Retrieves a paginated list of items in the cart.

*Requirement:* WA-BUS-007

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| cartId | path | string | True | Cart ID |
| page | query | integer | True | Page number |
| pageSize | query | integer | True | Number of items per page |

**Request Body:** `ListCartItemsRequest`

**Responses:**

- `200`: OK - Cart items retrieved successfully
- `401`: Unauthorized - Missing or invalid access token
- `404`: Not Found - Cart does not exist
- `500`: Internal Server Error - Failed to list cart items

---

#### `POST` /api/v1/carts/{cartId}/items

**Add item to cart**

Adds a product item to the cart with quantity.

*Requirement:* WA-BUS-007

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| cartId | path | string | True | Cart ID |

**Request Body:** `AddCartItemRequest`

**Responses:**

- `201`: Created - Cart item added successfully
- `400`: Bad Request - Invalid product or quantity
- `401`: Unauthorized - Missing or invalid access token
- `404`: Not Found - Cart does not exist
- `409`: Conflict - Product already in cart
- `500`: Internal Server Error - Failed to add cart item

---

#### `PUT` /api/v1/carts/{cartId}/items/{itemId}

**Update cart item quantity**

Updates the quantity of an existing cart item.

*Requirement:* WA-BUS-007

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| cartId | path | string | True | Cart ID |
| itemId | path | string | True | Cart item ID |

**Request Body:** `UpdateCartItemRequest`

**Responses:**

- `200`: OK - Cart item updated successfully
- `400`: Bad Request - Invalid quantity
- `401`: Unauthorized - Missing or invalid access token
- `404`: Not Found - Cart or item does not exist
- `500`: Internal Server Error - Failed to update cart item

---

#### `DELETE` /api/v1/carts/{cartId}/items/{itemId}

**Remove item from cart**

Removes a specific item from the cart.

*Requirement:* WA-BUS-007

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| cartId | path | string | True | Cart ID |
| itemId | path | string | True | Cart item ID |

**Request Body:** `RemoveCartItemRequest`

**Responses:**

- `200`: OK - Cart item removed successfully
- `401`: Unauthorized - Missing or invalid access token
- `404`: Not Found - Cart or item does not exist
- `500`: Internal Server Error - Failed to remove cart item

---

### Carts

#### `GET` /api/v1/carts/{cartId}

**Get cart details**

Retrieves cart metadata including totals and item count.

*Requirement:* WA-BUS-007

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| cartId | path | string | True | Cart ID |

**Request Body:** `GetCartRequest`

**Responses:**

- `200`: OK - Cart retrieved successfully
- `401`: Unauthorized - Missing or invalid access token
- `404`: Not Found - Cart does not exist
- `500`: Internal Server Error - Failed to retrieve cart

---

#### `DELETE` /api/v1/carts/{cartId}/items

**Clear cart**

Removes all items from the cart.

*Requirement:* WA-BUS-007

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| cartId | path | string | True | Cart ID |

**Request Body:** `ClearCartRequest`

**Responses:**

- `200`: OK - Cart cleared successfully
- `401`: Unauthorized - Missing or invalid access token
- `404`: Not Found - Cart does not exist
- `500`: Internal Server Error - Failed to clear cart

---

### ChatBackgrounds

#### `GET` /api/v1/chat-backgrounds

**List available chat backgrounds**

Returns a paginated list of available system and user-uploaded chat backgrounds.

*Requirement:* WA-SET-008

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| page | query | integer | True | Page number for pagination |
| pageSize | query | integer | True | Number of items per page |

**Request Body:** `ListChatBackgroundsRequest`

**Responses:**

- `200`: OK - List of chat backgrounds returned
- `401`: Unauthorized - Missing or invalid token
- `500`: Internal Server Error - Failed to retrieve backgrounds

---

#### `POST` /api/v1/chat-backgrounds

**Upload a custom chat background**

Uploads a user-provided image to be used as a chat background.

*Requirement:* WA-SET-008

**Request Body:** `CreateChatBackgroundRequest`

**Responses:**

- `201`: Created - Custom background uploaded
- `400`: Bad Request - Invalid file or missing required fields
- `401`: Unauthorized - Missing or invalid token
- `413`: Payload Too Large - File exceeds allowed size
- `500`: Internal Server Error - Failed to upload background

---

### ChatExports

#### `POST` /api/v1/chats/{chatId}/exports

**Create a chat export**

Creates an export job for a single chat. The export will contain messages (and optionally media) and returns an exportId to track status and retrieve the download URL.

*Requirement:* WA-BAK-003

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| chatId | path | string | True | Unique identifier of the chat to export |

**Request Body:** `CreateChatExportRequest`

**Responses:**

- `201`: Created - Export job successfully created
- `400`: Bad Request - Invalid export format or parameters
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - User does not have access to this chat
- `404`: Not Found - Chat does not exist
- `413`: Payload Too Large - Requested export exceeds size limits
- `429`: Too Many Requests - Export rate limit exceeded
- `500`: Internal Server Error - Failed to create export job

---

#### `GET` /api/v1/chats/{chatId}/exports/{exportId}

**Get chat export status and download URL**

Retrieves the status of a chat export job and provides a temporary download URL when the export is ready.

*Requirement:* WA-BAK-003

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| chatId | path | string | True | Unique identifier of the chat |
| exportId | path | string | True | Unique identifier of the export job |

**Responses:**

- `200`: OK - Export status retrieved
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - User does not have access to this chat or export
- `404`: Not Found - Export job does not exist
- `410`: Gone - Export has expired and is no longer available
- `500`: Internal Server Error - Failed to retrieve export status

---

### ChatHistoryTransfer

#### `POST` /api/v1/chat-history-transfer-sessions

**Create chat history transfer session**

Creates a transfer session to securely move encrypted chat history from a source device to a new device using Signal Protocol key bundles.

*Requirement:* WA-BAK-004

**Request Body:** `CreateChatHistoryTransferSessionRequest`

**Responses:**

- `201`: Created - Transfer session created successfully
- `400`: Bad Request - Missing or invalid Signal key bundle or transferMode
- `401`: Unauthorized - Missing or invalid access token
- `409`: Conflict - An active transfer session already exists for the source device

---

#### `POST` /api/v1/chat-history-transfer-sessions/{sessionId}/export

**Start chat history export**

Initiates export of encrypted chat history from the source device into an encrypted archive for transfer.

*Requirement:* WA-BAK-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| sessionId | path | string | True | Transfer session ID |

**Request Body:** `StartChatHistoryExportRequest`

**Responses:**

- `202`: Accepted - Export job started
- `400`: Bad Request - Invalid archive key or archive size constraints
- `401`: Unauthorized - Missing or invalid access token
- `404`: Not Found - Transfer session does not exist
- `409`: Conflict - Export already started or completed for this session

---

#### `GET` /api/v1/chat-history-transfer-sessions/{sessionId}

**Get transfer session status**

Retrieves the current status and progress of a chat history transfer session.

*Requirement:* WA-BAK-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| sessionId | path | string | True | Transfer session ID |

**Request Body:** `GetChatHistoryTransferSessionRequest`

**Responses:**

- `200`: OK - Status returned successfully
- `401`: Unauthorized - Missing or invalid access token
- `404`: Not Found - Transfer session does not exist

---

#### `GET` /api/v1/chat-history-transfer-sessions/{sessionId}/archive

**Get encrypted archive download URL**

Provides a time-limited download URL for the encrypted chat history archive once export is ready.

*Requirement:* WA-BAK-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| sessionId | path | string | True | Transfer session ID |

**Request Body:** `GetChatHistoryArchiveRequest`

**Responses:**

- `200`: OK - Download URL returned successfully
- `401`: Unauthorized - Missing or invalid access token
- `404`: Not Found - Archive not ready or session does not exist
- `410`: Gone - Archive expired or deleted

---

#### `POST` /api/v1/chat-history-transfer-sessions/{sessionId}/import

**Start chat history import**

Initiates import of the encrypted archive on the target device, supporting offline resume through checkpoints.

*Requirement:* WA-BAK-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| sessionId | path | string | True | Transfer session ID |

**Request Body:** `StartChatHistoryImportRequest`

**Responses:**

- `202`: Accepted - Import job started
- `400`: Bad Request - Invalid transfer token or checksum mismatch
- `401`: Unauthorized - Missing or invalid access token
- `404`: Not Found - Transfer session or archive does not exist
- `409`: Conflict - Import already in progress or completed

---

### ChatMedia

#### `POST` /api/v1/chats/{chatId}/media

**Upload camera-captured media to a chat**

Uploads an image or video captured directly from the device camera for use in a chat message. Enforces size limits (16MB images, 2GB documents/videos) and supports end-to-end encryption metadata.

*Requirement:* WA-MED-007

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| chatId | path | string | True | Chat ID |

**Request Body:** `UploadChatMediaRequest`

**Responses:**

- `201`: Created - Media uploaded successfully
- `400`: Bad Request - Invalid media type or missing required fields
- `401`: Unauthorized - Missing or invalid token
- `413`: Payload Too Large - Media exceeds allowed size limits
- `415`: Unsupported Media Type - MIME type not allowed
- `429`: Too Many Requests - Upload rate limit exceeded
- `500`: Internal Server Error - Media storage failure

---

#### `GET` /api/v1/chats/{chatId}/media/{mediaId}

**Get downloadable media details**

Returns a time-limited download URL and metadata for previously uploaded chat media. Used to render media in chat.

*Requirement:* WA-MED-007

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| chatId | path | string | True | Chat ID |
| mediaId | path | string | True | Media ID |

**Request Body:** `GetChatMediaRequest`

**Responses:**

- `200`: OK - Media details retrieved
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Media not found in chat
- `410`: Gone - Media no longer available
- `500`: Internal Server Error - Failed to generate download URL

---

### ChatMessages

#### `POST` /api/v1/chats/{chatId}/messages

**Send a media message in a chat**

Creates a chat message that references previously uploaded camera media and includes encrypted payloads for end-to-end encryption.

*Requirement:* WA-MED-007

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| chatId | path | string | True | Chat ID |

**Request Body:** `CreateChatMediaMessageRequest`

**Responses:**

- `201`: Created - Media message created
- `400`: Bad Request - Invalid message payload or missing fields
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Chat or media not found
- `409`: Conflict - Duplicate clientMessageId
- `500`: Internal Server Error - Message creation failed

---

### ChatSettings

#### `PUT` /api/v1/chats/{chatId}/chat-background

**Set chat-specific background**

Sets a background for a specific chat, overriding the user default for that chat.

*Requirement:* WA-SET-008

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| chatId | path | string | True | Chat ID |

**Request Body:** `UpdateChatBackgroundRequest`

**Responses:**

- `200`: OK - Chat background updated
- `400`: Bad Request - Invalid background ID
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - User is not a participant of the chat
- `404`: Not Found - Chat or background does not exist
- `500`: Internal Server Error - Failed to update chat background

---

### Chats

#### `PUT` /api/v1/chats/{chatId}/lock

**Lock a chat with additional authentication**

Locks a specific chat for the authenticated user after validating an additional authentication factor (e.g., biometric, OTP, or device PIN).

*Requirement:* WA-MSG-010

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| chatId | path | string | True | Chat ID to be locked |

**Request Body:** `LockChatRequest`

**Responses:**

- `200`: OK - Chat locked successfully
- `400`: Bad Request - Missing or invalid authentication data
- `401`: Unauthorized - Missing or invalid access token
- `403`: Forbidden - Additional authentication failed
- `404`: Not Found - Chat does not exist
- `409`: Conflict - Chat is already locked
- `423`: Locked - Chat cannot be locked due to policy restrictions

---

#### `PUT` /api/v1/chats/{chatId}/unlock

**Unlock a chat with additional authentication**

Unlocks a specific chat for the authenticated user after validating an additional authentication factor.

*Requirement:* WA-MSG-010

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| chatId | path | string | True | Chat ID to be unlocked |

**Request Body:** `UnlockChatRequest`

**Responses:**

- `200`: OK - Chat unlocked successfully
- `400`: Bad Request - Missing or invalid authentication data
- `401`: Unauthorized - Missing or invalid access token
- `403`: Forbidden - Additional authentication failed
- `404`: Not Found - Chat does not exist
- `409`: Conflict - Chat is already unlocked

---

#### `POST` /api/v1/chats/{chatId}/polls

**Create a poll in a chat**

Creates a new poll in a group or direct chat. Poll content is expected to be encrypted client-side (E2E).

*Requirement:* WA-GRP-008

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| chatId | path | string | True | Chat ID (group or direct chat) |

**Request Body:** `CreatePollRequest`

**Responses:**

- `201`: Created - Poll successfully created
- `400`: Bad Request - Invalid poll payload or missing fields
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - Not a participant of the chat
- `404`: Not Found - Chat does not exist

---

#### `GET` /api/v1/chats/{chatId}/polls

**List polls in a chat**

Retrieves a paginated list of polls for a chat. Poll content is returned as encrypted payloads.

*Requirement:* WA-GRP-008

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| chatId | path | string | True | Chat ID (group or direct chat) |
| page | query | integer | True | Page number |
| pageSize | query | integer | True | Page size |

**Responses:**

- `200`: OK - Poll list retrieved
- `400`: Bad Request - Invalid pagination parameters
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - Not a participant of the chat
- `404`: Not Found - Chat does not exist

---

#### `GET` /api/v1/chats/{chatId}/polls/{pollId}

**Get poll details**

Retrieves a specific poll with encrypted content and current tally metadata.

*Requirement:* WA-GRP-008

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| chatId | path | string | True | Chat ID (group or direct chat) |
| pollId | path | string | True | Poll ID |

**Responses:**

- `200`: OK - Poll details retrieved
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - Not a participant of the chat
- `404`: Not Found - Poll or chat does not exist

---

#### `POST` /api/v1/chats/{chatId}/polls/{pollId}/votes

**Cast or update a vote**

Submits a user's vote for a poll in a chat. Vote content is encrypted client-side.

*Requirement:* WA-GRP-008

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| chatId | path | string | True | Chat ID (group or direct chat) |
| pollId | path | string | True | Poll ID |

**Request Body:** `SubmitVoteRequest`

**Responses:**

- `201`: Created - Vote successfully submitted
- `400`: Bad Request - Invalid vote payload or selection
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - Not a participant of the chat or poll is closed
- `404`: Not Found - Poll or chat does not exist
- `409`: Conflict - Vote not allowed due to poll rules

---

#### `POST` /api/v1/chats/{chatId}/polls/{pollId}/close

**Close a poll**

Closes an active poll in a chat. Only poll creator or authorized admins may close.

*Requirement:* WA-GRP-008

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| chatId | path | string | True | Chat ID (group or direct chat) |
| pollId | path | string | True | Poll ID |

**Request Body:** `ClosePollRequest`

**Responses:**

- `200`: OK - Poll successfully closed
- `400`: Bad Request - Poll already closed
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - Insufficient permissions to close poll
- `404`: Not Found - Poll or chat does not exist

---

#### `GET` /api/v1/search/chats

**Search chats by keyword**

Searches the user's chats by name, participants, or last message preview. Supports mobile-first pagination.

*Requirement:* WA-SRC-003

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| q | query | string | True | Search query text |
| page | query | integer | True | Page number for pagination |
| pageSize | query | integer | True | Number of items per page |
| type | query | string | False | Filter by chat type (direct|group|broadcast) |

**Request Body:** `SearchChatsRequest`

**Responses:**

- `200`: OK - Search results returned
- `400`: Bad Request - Missing or invalid query parameters
- `401`: Unauthorized - Missing or invalid token
- `429`: Too Many Requests - Rate limit exceeded
- `500`: Internal Server Error - Unexpected failure

---

#### `POST` /api/v1/chats/{chatId}/archive

**Archive a chat**

Marks a chat as archived for the authenticated user to enable chat archiving functionality.

*Requirement:* WA-BAK-005

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| chatId | path | string | True | Unique identifier of the chat to archive |

**Request Body:** `ArchiveChatRequest`

**Responses:**

- `201`: Created - Chat archived successfully
- `400`: Bad Request - Invalid chatId or payload
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Chat does not exist
- `409`: Conflict - Chat is already archived

---

#### `PUT` /api/v1/chats/{chatId}/pin

**Chat anpinnen**

Pinnt einen Chat fuer den authentifizierten Benutzer an.

*Requirement:* WA-BAK-006

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| chatId | path | string | True | Eindeutige Chat-ID |

**Request Body:** `PinChatRequest`

**Responses:**

- `200`: OK - Chat erfolgreich angepinnt
- `400`: Bad Request - Ungueltige Chat-ID oder Request-Parameter
- `401`: Unauthorized - Fehlender oder ungueltiger Zugriffstoken
- `403`: Forbidden - Keine Berechtigung fuer diesen Chat
- `404`: Not Found - Chat existiert nicht
- `409`: Conflict - Chat ist bereits angepinnt
- `500`: Internal Server Error - Unerwarteter Serverfehler

---

#### `DELETE` /api/v1/chats/{chatId}/pin

**Chat lospinnen**

Entfernt das Anpinnen eines Chats fuer den authentifizierten Benutzer.

*Requirement:* WA-BAK-006

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| chatId | path | string | True | Eindeutige Chat-ID |

**Request Body:** `UnpinChatRequest`

**Responses:**

- `200`: OK - Chat erfolgreich losgepinnt
- `400`: Bad Request - Ungueltige Chat-ID oder Request-Parameter
- `401`: Unauthorized - Fehlender oder ungueltiger Zugriffstoken
- `403`: Forbidden - Keine Berechtigung fuer diesen Chat
- `404`: Not Found - Chat existiert nicht
- `409`: Conflict - Chat ist nicht angepinnt
- `500`: Internal Server Error - Unerwarteter Serverfehler

---

#### `GET` /api/v1/chats/pinned

**Angepinnte Chats abrufen**

Liefert eine paginierte Liste aller angepinnten Chats des authentifizierten Benutzers.

*Requirement:* WA-BAK-006

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| page | query | integer | True | Seitennummer fuer die Paginierung |
| pageSize | query | integer | True | Anzahl der Eintraege pro Seite |

**Request Body:** `ListPinnedChatsRequest`

**Responses:**

- `200`: OK - Liste der angepinnten Chats
- `400`: Bad Request - Ungueltige Paginierungsparameter
- `401`: Unauthorized - Fehlender oder ungueltiger Zugriffstoken
- `500`: Internal Server Error - Unerwarteter Serverfehler

---

### ClientPowerState

#### `POST` /api/v1/clients/power-state

**Report client power state**

Allows clients to report battery and power state to optimize server-side push behavior and reduce unnecessary background activity.

*Requirement:* WA-PERF-004

**Request Body:** `ClientPowerStateRequest`

**Responses:**

- `201`: Created - Client power state recorded successfully
- `400`: Bad Request - Missing or invalid power state data
- `401`: Unauthorized - Missing or invalid token
- `409`: Conflict - Duplicate power state report

---

### Communities

#### `POST` /api/v1/communities

**Create community**

Creates a new community that can contain multiple groups. Supports mobile-first clients and encrypted metadata storage references.

*Requirement:* WA-GRP-006

**Request Body:** `CreateCommunityRequest`

**Responses:**

- `201`: Created - Community created successfully
- `400`: Bad Request - Missing or invalid community fields
- `401`: Unauthorized - Missing or invalid token
- `409`: Conflict - Community with same name already exists

---

#### `GET` /api/v1/communities

**List communities**

Returns a paginated list of communities accessible to the user.

*Requirement:* WA-GRP-006

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| page | query | integer | True | Page number (1-based) |
| pageSize | query | integer | True | Number of items per page |

**Request Body:** `ListCommunitiesRequest`

**Responses:**

- `200`: OK - Communities retrieved successfully
- `400`: Bad Request - Invalid pagination parameters
- `401`: Unauthorized - Missing or invalid token

---

#### `GET` /api/v1/communities/{communityId}

**Get community**

Fetches a community by ID, including metadata.

*Requirement:* WA-GRP-006

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| communityId | path | string | True | Community ID |

**Request Body:** `GetCommunityRequest`

**Responses:**

- `200`: OK - Community retrieved successfully
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Community does not exist

---

#### `PUT` /api/v1/communities/{communityId}

**Update community**

Updates community attributes such as name and description.

*Requirement:* WA-GRP-006

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| communityId | path | string | True | Community ID |

**Request Body:** `UpdateCommunityRequest`

**Responses:**

- `200`: OK - Community updated successfully
- `400`: Bad Request - Invalid fields for update
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Community does not exist

---

#### `DELETE` /api/v1/communities/{communityId}

**Delete community**

Deletes a community and unlinks its groups. Data retention follows compliance rules.

*Requirement:* WA-GRP-006

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| communityId | path | string | True | Community ID |

**Request Body:** `DeleteCommunityRequest`

**Responses:**

- `200`: OK - Community deleted successfully
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Community does not exist
- `409`: Conflict - Community cannot be deleted due to active dependencies

---

#### `POST` /api/v1/communities/{communityId}/groups

**Add group to community**

Adds an existing group to a community. Supports up to 1024 members per group.

*Requirement:* WA-GRP-006

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| communityId | path | string | True | Community ID |

**Request Body:** `AddGroupToCommunityRequest`

**Responses:**

- `201`: Created - Group linked to community
- `400`: Bad Request - Missing or invalid groupId
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Community or group does not exist
- `409`: Conflict - Group is already linked to the community

---

#### `GET` /api/v1/communities/{communityId}/groups

**List community groups**

Returns a paginated list of groups within a community.

*Requirement:* WA-GRP-006

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| communityId | path | string | True | Community ID |
| page | query | integer | True | Page number (1-based) |
| pageSize | query | integer | True | Number of items per page |

**Request Body:** `ListCommunityGroupsRequest`

**Responses:**

- `200`: OK - Community groups retrieved successfully
- `400`: Bad Request - Invalid pagination parameters
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Community does not exist

---

#### `DELETE` /api/v1/communities/{communityId}/groups/{groupId}

**Remove group from community**

Unlinks a group from a community without deleting the group.

*Requirement:* WA-GRP-006

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| communityId | path | string | True | Community ID |
| groupId | path | string | True | Group ID |

**Request Body:** `RemoveGroupFromCommunityRequest`

**Responses:**

- `200`: OK - Group removed from community
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Community or group does not exist
- `409`: Conflict - Group is not linked to the community

---

### ContactLabels

#### `POST` /api/v1/contact-labels

**Create a contact label**

Creates a new label that can be assigned to contacts for business categorization.

*Requirement:* WA-CON-004

**Request Body:** `CreateContactLabelRequest`

**Responses:**

- `201`: Created - Label created successfully
- `400`: Bad Request - Label name is missing or invalid
- `401`: Unauthorized - Missing or invalid token
- `409`: Conflict - Label name already exists

---

#### `GET` /api/v1/contact-labels

**List contact labels**

Retrieves a paginated list of labels available to the business user.

*Requirement:* WA-CON-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| page | query | integer | True | Page number starting from 1 |
| pageSize | query | integer | True | Number of items per page |

**Request Body:** `ListContactLabelsRequest`

**Responses:**

- `200`: OK - Labels retrieved
- `400`: Bad Request - Invalid pagination parameters
- `401`: Unauthorized - Missing or invalid token

---

#### `GET` /api/v1/contact-labels/{labelId}

**Get a contact label**

Retrieves details of a specific contact label.

*Requirement:* WA-CON-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| labelId | path | string | True | Label ID |

**Request Body:** `GetContactLabelRequest`

**Responses:**

- `200`: OK - Label retrieved
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Label does not exist

---

#### `PUT` /api/v1/contact-labels/{labelId}

**Update a contact label**

Updates the name or color of an existing label.

*Requirement:* WA-CON-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| labelId | path | string | True | Label ID |

**Request Body:** `UpdateContactLabelRequest`

**Responses:**

- `200`: OK - Label updated
- `400`: Bad Request - Invalid label attributes
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Label does not exist
- `409`: Conflict - Label name already exists

---

#### `DELETE` /api/v1/contact-labels/{labelId}

**Delete a contact label**

Deletes a label and unassigns it from all contacts.

*Requirement:* WA-CON-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| labelId | path | string | True | Label ID |

**Request Body:** `DeleteContactLabelRequest`

**Responses:**

- `200`: OK - Label deleted
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Label does not exist

---

#### `GET` /api/v1/contacts/{contactId}/labels

**List labels for a contact**

Retrieves a paginated list of labels assigned to a specific contact.

*Requirement:* WA-CON-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| contactId | path | string | True | Contact ID |
| page | query | integer | True | Page number starting from 1 |
| pageSize | query | integer | True | Number of items per page |

**Request Body:** `ListContactLabelsForContactRequest`

**Responses:**

- `200`: OK - Labels retrieved
- `400`: Bad Request - Invalid pagination parameters
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Contact does not exist

---

#### `POST` /api/v1/contacts/{contactId}/labels/{labelId}

**Assign label to a contact**

Assigns an existing label to a specific contact.

*Requirement:* WA-CON-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| contactId | path | string | True | Contact ID |
| labelId | path | string | True | Label ID |

**Request Body:** `AssignLabelToContactRequest`

**Responses:**

- `201`: Created - Label assigned to contact
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Contact or label does not exist
- `409`: Conflict - Label already assigned to contact

---

#### `DELETE` /api/v1/contacts/{contactId}/labels/{labelId}

**Unassign label from a contact**

Removes a label assignment from a specific contact.

*Requirement:* WA-CON-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| contactId | path | string | True | Contact ID |
| labelId | path | string | True | Label ID |

**Request Body:** `UnassignLabelFromContactRequest`

**Responses:**

- `200`: OK - Label unassigned from contact
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Contact or label does not exist

---

#### `GET` /api/v1/contact-labels/{labelId}/contacts

**List contacts by label**

Retrieves a paginated list of contacts that have a specific label.

*Requirement:* WA-CON-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| labelId | path | string | True | Label ID |
| page | query | integer | True | Page number starting from 1 |
| pageSize | query | integer | True | Number of items per page |

**Request Body:** `ListContactsByLabelRequest`

**Responses:**

- `200`: OK - Contacts retrieved
- `400`: Bad Request - Invalid pagination parameters
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Label does not exist

---

### Contacts

#### `POST` /api/v1/contacts/sync

**Synchronize device contacts with WhatsApp users**

Submits a device contact list (e.g., hashed phone numbers) to match against registered users and returns matched users for the client. Designed for mobile-first usage and offline batching.

*Requirement:* WA-CON-001

**Request Body:** `ContactSyncRequest`

**Responses:**

- `201`: Created - Contacts sync accepted and processed
- `400`: Bad Request - Contacts payload is malformed or missing required fields
- `401`: Unauthorized - Missing or invalid authentication token
- `413`: Payload Too Large - Contact list exceeds allowed size
- `422`: Unprocessable Entity - Contact hashes are invalid or unsupported
- `500`: Internal Server Error - Failed to process contact sync

---

#### `GET` /api/v1/contacts/sync/{syncId}

**Get contact sync result by sync ID**

Retrieves the results of a previously submitted contact sync operation.

*Requirement:* WA-CON-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| syncId | path | string | True | Sync operation identifier |

**Request Body:** `EmptyRequest`

**Responses:**

- `200`: OK - Sync result retrieved
- `401`: Unauthorized - Missing or invalid authentication token
- `404`: Not Found - Sync ID does not exist
- `500`: Internal Server Error - Failed to retrieve sync result

---

#### `POST` /api/v1/contacts

**Add a contact by identifier**

Adds a new contact using a phone number, userId, or username. Supports multiple ways to add a contact.

*Requirement:* WA-CON-002

**Request Body:** `AddContactRequest`

**Responses:**

- `201`: Created - Contact added successfully
- `400`: Bad Request - Identifier type or value is invalid
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - No user matches the identifier
- `409`: Conflict - Contact already exists
- `422`: Unprocessable Entity - Identifier format not supported

---

#### `POST` /api/v1/contacts/invitations

**Invite a contact not yet registered**

Creates an invitation to add a contact via phone number or email when the user is not yet registered.

*Requirement:* WA-CON-002

**Request Body:** `InviteContactRequest`

**Responses:**

- `201`: Created - Invitation created successfully
- `400`: Bad Request - Invalid channel or destination
- `401`: Unauthorized - Missing or invalid token
- `429`: Too Many Requests - Rate limit exceeded for invitations
- `500`: Internal Server Error - Failed to create invitation

---

#### `POST` /api/v1/contacts/qr

**Add a contact via QR token**

Adds a contact using a QR code token generated by another user.

*Requirement:* WA-CON-002

**Request Body:** `AddContactByQrRequest`

**Responses:**

- `201`: Created - Contact added successfully via QR
- `400`: Bad Request - Invalid or malformed QR token
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - QR token does not map to a valid user
- `409`: Conflict - Contact already exists

---

#### `GET` /api/v1/contacts/{contactId}/labels

**List labels for a contact**

Retrieves a paginated list of labels assigned to a specific contact.

*Requirement:* WA-CON-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| contactId | path | string | True | Contact ID |
| page | query | integer | True | Page number starting from 1 |
| pageSize | query | integer | True | Number of items per page |

**Request Body:** `ListContactLabelsForContactRequest`

**Responses:**

- `200`: OK - Labels retrieved
- `400`: Bad Request - Invalid pagination parameters
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Contact does not exist

---

#### `POST` /api/v1/contacts/{contactId}/labels/{labelId}

**Assign label to a contact**

Assigns an existing label to a specific contact.

*Requirement:* WA-CON-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| contactId | path | string | True | Contact ID |
| labelId | path | string | True | Label ID |

**Request Body:** `AssignLabelToContactRequest`

**Responses:**

- `201`: Created - Label assigned to contact
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Contact or label does not exist
- `409`: Conflict - Label already assigned to contact

---

#### `DELETE` /api/v1/contacts/{contactId}/labels/{labelId}

**Unassign label from a contact**

Removes a label assignment from a specific contact.

*Requirement:* WA-CON-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| contactId | path | string | True | Contact ID |
| labelId | path | string | True | Label ID |

**Request Body:** `UnassignLabelFromContactRequest`

**Responses:**

- `200`: OK - Label unassigned from contact
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Contact or label does not exist

---

#### `GET` /api/v1/contact-labels/{labelId}/contacts

**List contacts by label**

Retrieves a paginated list of contacts that have a specific label.

*Requirement:* WA-CON-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| labelId | path | string | True | Label ID |
| page | query | integer | True | Page number starting from 1 |
| pageSize | query | integer | True | Number of items per page |

**Request Body:** `ListContactsByLabelRequest`

**Responses:**

- `200`: OK - Contacts retrieved
- `400`: Bad Request - Invalid pagination parameters
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Label does not exist

---

#### `GET` /api/v1/search/contacts

**Search contacts by keyword**

Searches the user's contacts by name, phone number, or username. Supports mobile-first pagination.

*Requirement:* WA-SRC-003

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| q | query | string | True | Search query text |
| page | query | integer | True | Page number for pagination |
| pageSize | query | integer | True | Number of items per page |

**Request Body:** `SearchContactsRequest`

**Responses:**

- `200`: OK - Search results returned
- `400`: Bad Request - Missing or invalid query parameters
- `401`: Unauthorized - Missing or invalid token
- `429`: Too Many Requests - Rate limit exceeded
- `500`: Internal Server Error - Unexpected failure

---

### Conversations

#### `GET` /api/v1/conversations/{conversationId}/messages

**Nachrichten ab bestimmtem Datum abrufen**

Ermoeglicht den Sprung zu einem bestimmten Datum in einer Konversation und liefert Nachrichten ab dem angegebenen Zeitpunkt. Unterstuetzt Offline-Nachrichten-Queue durch serverseitige Synchronisation der Historie.

*Requirement:* WA-SRC-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| conversationId | path | string | True | Eindeutige ID der Konversation |
| date | query | string | True | ISO-8601 Datum/Zeit (UTC) als Sprungziel, z. B. 2024-05-01T00:00:00Z |
| direction | query | string | False | Richtung der Suche relativ zum Datum: 'forward' oder 'backward' (Standard: forward) |
| page | query | integer | True | Seitennummer fuer die Paginierung |
| pageSize | query | integer | True | Anzahl der Eintraege pro Seite |

**Request Body:** `GetMessagesByDateRequest`

**Responses:**

- `200`: OK - Nachrichten erfolgreich abgerufen
- `400`: Bad Request - Ungueltiges Datumsformat oder Parameter
- `401`: Unauthorized - Fehlendes oder ungueltiges Token
- `403`: Forbidden - Kein Zugriff auf die Konversation
- `404`: Not Found - Konversation nicht gefunden
- `500`: Internal Server Error - Unerwarteter Serverfehler

---

#### `POST` /api/v1/conversations/{conversationId}/greeting-messages

**Create greeting message on first contact**

Creates an automatic greeting message when a first-contact event is detected in a conversation. Server-side logic ensures idempotency to avoid duplicate greetings.

*Requirement:* WA-BUS-005

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| conversationId | path | string | True | Conversation ID |

**Request Body:** `CreateGreetingMessageRequest`

**Responses:**

- `201`: Created - Greeting message created
- `400`: Bad Request - Invalid greeting message payload
- `401`: Unauthorized - Missing or invalid access token
- `403`: Forbidden - User not allowed to create greetings in this conversation
- `404`: Not Found - Conversation not found
- `409`: Conflict - Greeting already sent for this first-contact event
- `500`: Internal Server Error - Failed to create greeting message

---

#### `GET` /api/v1/conversations/{conversationId}/greeting-messages

**List greeting messages**

Returns a paginated list of greeting messages for a conversation to support client synchronization.

*Requirement:* WA-BUS-005

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| conversationId | path | string | True | Conversation ID |
| page | query | integer | False | Page number for pagination |
| pageSize | query | integer | False | Number of items per page |

**Request Body:** `ListGreetingMessagesRequest`

**Responses:**

- `200`: OK - Greeting messages retrieved
- `400`: Bad Request - Invalid pagination parameters
- `401`: Unauthorized - Missing or invalid access token
- `403`: Forbidden - User not allowed to access greetings in this conversation
- `404`: Not Found - Conversation not found
- `500`: Internal Server Error - Failed to retrieve greeting messages

---

#### `GET` /api/v1/conversations/sync

**Synchronize conversation metadata**

Returns delta updates for conversations (e.g., membership changes, titles, last message references) to keep clients in sync efficiently.

*Requirement:* WA-PERF-003

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| since | query | string | False | ISO-8601 timestamp of the last successful sync |
| cursor | query | string | False | Opaque cursor for delta pagination |
| page | query | integer | True | Page number for pagination |
| pageSize | query | integer | True | Number of records per page |

**Request Body:** `ConversationsSyncRequest`

**Responses:**

- `200`: OK - Conversation delta retrieved successfully
- `400`: Bad Request - Invalid pagination or sync parameters
- `401`: Unauthorized - Missing or invalid token
- `429`: Too Many Requests - Sync rate limit exceeded
- `500`: Internal Server Error - Unable to process sync

---

### Crypto

#### `POST` /api/v1/crypto/keys

**Register or update client encryption keys**

Registers or обновляет identity key, signed prekey, and one-time prekeys required for Signal Protocol end-to-end encryption. Used per device.

*Requirement:* WA-SEC-001

**Request Body:** `RegisterEncryptionKeysRequest`

**Responses:**

- `201`: Created - Keys registered successfully
- `400`: Bad Request - Missing or invalid key material
- `401`: Unauthorized - Missing or invalid token
- `409`: Conflict - Keys already registered for this device

---

#### `GET` /api/v1/crypto/prekeys/{recipientId}

**Fetch recipient prekeys**

Retrieves recipient identity key, signed prekey, and one-time prekey bundle to establish a Signal session.

*Requirement:* WA-SEC-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| recipientId | path | string | True | Recipient user identifier |

**Request Body:** `GetRecipientPreKeysRequest`

**Responses:**

- `200`: OK - Prekey bundle retrieved
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Recipient or prekeys not found
- `409`: Conflict - No available one-time prekeys for recipient

---

### DataUsage

#### `GET` /api/v1/data-usage/settings

**Get data usage control settings**

Retrieves the authenticated user's data usage control settings such as upload/download limits and auto-download preferences.

*Requirement:* WA-SET-007

**Request Body:** `GetDataUsageSettingsRequest`

**Responses:**

- `200`: OK - Settings retrieved
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Settings not found for user
- `500`: Internal Server Error - Failed to retrieve settings

---

#### `PUT` /api/v1/data-usage/settings

**Update data usage control settings**

Updates the authenticated user's data usage control settings, enabling control over data consumption.

*Requirement:* WA-SET-007

**Request Body:** `UpdateDataUsageSettingsRequest`

**Responses:**

- `200`: OK - Settings updated
- `400`: Bad Request - Invalid limits or preferences
- `401`: Unauthorized - Missing or invalid token
- `409`: Conflict - Settings update conflict
- `500`: Internal Server Error - Failed to update settings

---

#### `GET` /api/v1/data-usage/summary

**Get data usage summary**

Returns the authenticated user's current data usage totals and remaining quotas for the active period.

*Requirement:* WA-SET-007

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| period | query | string | False | Usage period (e.g., currentMonth, lastMonth) |

**Request Body:** `GetDataUsageSummaryRequest`

**Responses:**

- `200`: OK - Summary retrieved
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Usage data not available
- `500`: Internal Server Error - Failed to retrieve summary

---

### DesktopApps

#### `GET` /api/v1/desktop-apps

**List desktop app releases**

Returns a paginated list of available native desktop application releases for supported platforms (Windows, macOS, Linux).

*Requirement:* WA-INT-005

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| platform | query | string | False | Filter by platform (windows, macos, linux) |
| page | query | integer | True | Page number for pagination |
| pageSize | query | integer | True | Number of items per page |

**Request Body:** `ListDesktopAppReleasesRequest`

**Responses:**

- `200`: OK - Desktop app releases retrieved
- `400`: Bad Request - Invalid pagination or filter parameters
- `500`: Internal Server Error - Unable to retrieve releases

---

#### `GET` /api/v1/desktop-apps/{releaseId}

**Get desktop app release details**

Returns metadata for a specific desktop app release including download URL and checksum.

*Requirement:* WA-INT-005

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| releaseId | path | string | True | Release ID |

**Request Body:** `GetDesktopAppReleaseRequest`

**Responses:**

- `200`: OK - Desktop app release retrieved
- `404`: Not Found - Release ID does not exist
- `500`: Internal Server Error - Unable to retrieve release

---

#### `POST` /api/v1/desktop-apps/check-update

**Check for desktop app updates**

Checks whether a newer desktop app release is available for the given platform and current version.

*Requirement:* WA-INT-005

**Request Body:** `CheckDesktopAppUpdateRequest`

**Responses:**

- `201`: Created - Update check processed
- `400`: Bad Request - Missing or invalid platform or version
- `500`: Internal Server Error - Unable to check updates

---

### Devices

#### `POST` /api/v1/devices

**Register a device**

Registers a new device for the authenticated user to enable multi-device usage with end-to-end encryption metadata and push/WebSocket capabilities.

*Requirement:* WA-AUTH-004

**Request Body:** `RegisterDeviceRequest`

**Responses:**

- `201`: Created - Device registered successfully
- `400`: Bad Request - Missing or invalid device registration data
- `401`: Unauthorized - Missing or invalid token
- `409`: Conflict - Device already registered

---

#### `GET` /api/v1/devices

**List registered devices**

Returns a paginated list of devices registered for the authenticated user to manage multi-device usage.

*Requirement:* WA-AUTH-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| page | query | integer | True | Page number for pagination |
| pageSize | query | integer | True | Number of items per page |

**Request Body:** `ListDevicesRequest`

**Responses:**

- `200`: OK - Devices retrieved successfully
- `400`: Bad Request - Invalid pagination parameters
- `401`: Unauthorized - Missing or invalid token

---

#### `GET` /api/v1/devices/{deviceId}

**Get device details**

Returns details for a specific registered device of the authenticated user.

*Requirement:* WA-AUTH-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| deviceId | path | string | True | Device ID |

**Request Body:** `GetDeviceRequest`

**Responses:**

- `200`: OK - Device details retrieved successfully
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Device does not exist

---

#### `PUT` /api/v1/devices/{deviceId}

**Update device metadata**

Updates device metadata such as name, push token, and websocket capability to support multi-device sync.

*Requirement:* WA-AUTH-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| deviceId | path | string | True | Device ID |

**Request Body:** `UpdateDeviceRequest`

**Responses:**

- `200`: OK - Device updated successfully
- `400`: Bad Request - Invalid update payload
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Device does not exist

---

#### `DELETE` /api/v1/devices/{deviceId}

**Revoke a device**

Revokes a device session and removes it from the user's multi-device list.

*Requirement:* WA-AUTH-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| deviceId | path | string | True | Device ID |

**Request Body:** `RevokeDeviceRequest`

**Responses:**

- `200`: OK - Device revoked successfully
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Device does not exist

---

#### `POST` /api/v1/devices/{deviceId}/prekeys

**Upload Signal pre-keys for device**

Uploads a batch of Signal Protocol pre-keys for a specific device to enable encrypted multi-device messaging.

*Requirement:* WA-AUTH-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| deviceId | path | string | True | Device ID |

**Request Body:** `UploadPrekeysRequest`

**Responses:**

- `201`: Created - Pre-keys uploaded successfully
- `400`: Bad Request - Invalid pre-key payload
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Device does not exist

---

### DoNotDisturb

#### `GET` /api/v1/users/{userId}/do-not-disturb

**Get Do-Not-Disturb settings**

Returns the current Do-Not-Disturb mode configuration for the specified user.

*Requirement:* WA-NOT-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | Unique identifier of the user |

**Responses:**

- `200`: OK - Do-Not-Disturb settings retrieved successfully
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - User not allowed to access these settings
- `404`: Not Found - User does not exist

---

#### `PUT` /api/v1/users/{userId}/do-not-disturb

**Update Do-Not-Disturb settings**

Enables, disables, or schedules Do-Not-Disturb mode for the specified user.

*Requirement:* WA-NOT-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | Unique identifier of the user |

**Request Body:** `UpdateDoNotDisturbSettingsRequest`

**Responses:**

- `200`: OK - Do-Not-Disturb settings updated successfully
- `400`: Bad Request - Invalid schedule or timestamp format
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - User not allowed to update these settings
- `404`: Not Found - User does not exist

---

### Documents

#### `POST` /api/v1/messages/documents

**Send a document message**

Sends an arbitrary document to a user, group, or broadcast list with end-to-end encrypted metadata. Supports offline queuing and real-time delivery via WebSocket. Maximum document size is 2GB.

*Requirement:* WA-MED-003

**Request Body:** `SendDocumentMessageRequest`

**Responses:**

- `201`: Created - Document message accepted for delivery
- `400`: Bad Request - Missing or invalid fields, or file exceeds 2GB limit
- `401`: Unauthorized - Missing or invalid access token
- `403`: Forbidden - Recipient type or permissions not allowed
- `413`: Payload Too Large - Document exceeds maximum size of 2GB
- `422`: Unprocessable Entity - Encryption metadata invalid or inconsistent
- `429`: Too Many Requests - Rate limit exceeded
- `500`: Internal Server Error - Unexpected failure while processing the document

---

### Encryption

#### `POST` /api/v1/devices/{deviceId}/prekeys

**Upload Signal pre-keys for device**

Uploads a batch of Signal Protocol pre-keys for a specific device to enable encrypted multi-device messaging.

*Requirement:* WA-AUTH-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| deviceId | path | string | True | Device ID |

**Request Body:** `UploadPrekeysRequest`

**Responses:**

- `201`: Created - Pre-keys uploaded successfully
- `400`: Bad Request - Invalid pre-key payload
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Device does not exist

---

### Favorites

#### `GET` /api/v1/users/{userId}/favorite-contacts

**List favorite contacts**

Retrieves a paginated list of a user's favorite contacts.

*Requirement:* WA-CON-003

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |
| page | query | integer | True | Page number for pagination |
| pageSize | query | integer | True | Number of items per page |

**Request Body:** `ListFavoriteContactsRequest`

**Responses:**

- `200`: OK - Favorites retrieved successfully
- `400`: Bad Request - Invalid pagination parameters
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - User does not exist
- `500`: Internal Server Error - Unexpected error while retrieving favorites

---

#### `POST` /api/v1/users/{userId}/favorite-contacts

**Add favorite contact**

Adds a contact to the user's favorites list.

*Requirement:* WA-CON-003

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Request Body:** `AddFavoriteContactRequest`

**Responses:**

- `201`: Created - Contact added to favorites
- `400`: Bad Request - Missing or invalid contactId
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - User or contact does not exist
- `409`: Conflict - Contact already in favorites
- `500`: Internal Server Error - Unexpected error while adding favorite

---

#### `DELETE` /api/v1/users/{userId}/favorite-contacts/{contactId}

**Remove favorite contact**

Removes a contact from the user's favorites list.

*Requirement:* WA-CON-003

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |
| contactId | path | string | True | Contact ID |

**Request Body:** `RemoveFavoriteContactRequest`

**Responses:**

- `200`: OK - Contact removed from favorites
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Favorite contact not found
- `500`: Internal Server Error - Unexpected error while removing favorite

---

### Gifs

#### `GET` /api/v1/gifs/search

**Search GIFs**

Search for GIFs using a query string. Supports pagination for mobile-first clients.

*Requirement:* WA-MED-006

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| q | query | string | True | Search query for GIFs |
| page | query | integer | True | Page number for pagination |
| pageSize | query | integer | True | Number of items per page |
| locale | query | string | False | Locale for localized GIF search results |
| rating | query | string | False | Content rating filter (e.g., g, pg, pg-13) |

**Request Body:** `SearchGifsRequest`

**Responses:**

- `200`: OK - GIF search results returned
- `400`: Bad Request - Missing or invalid query parameters
- `401`: Unauthorized - Missing or invalid token
- `429`: Too Many Requests - Rate limit exceeded for GIF search
- `500`: Internal Server Error - GIF search failed

---

#### `POST` /api/v1/messages/gifs

**Send GIF message**

Send a GIF message to a user, group, or broadcast list. Payload is end-to-end encrypted using Signal Protocol; clients send encrypted content and metadata.

*Requirement:* WA-MED-006

**Request Body:** `SendGifMessageRequest`

**Responses:**

- `201`: Created - GIF message accepted for delivery
- `400`: Bad Request - Missing or invalid recipient or GIF data
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - Recipient not allowed or group limit exceeded
- `409`: Conflict - Duplicate clientMessageId
- `413`: Payload Too Large - GIF exceeds size limit
- `500`: Internal Server Error - Failed to send GIF message

---

### Greetings

#### `GET` /api/v1/users/{userId}/greeting-settings

**Get greeting settings**

Retrieves the automatic greeting configuration for a user. Used by clients to display or cache current greeting settings.

*Requirement:* WA-BUS-005

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Request Body:** `GetGreetingSettingsRequest`

**Responses:**

- `200`: OK - Greeting settings retrieved
- `401`: Unauthorized - Missing or invalid access token
- `403`: Forbidden - User not allowed to access these settings
- `404`: Not Found - User or greeting settings not found
- `500`: Internal Server Error - Failed to retrieve greeting settings

---

#### `PUT` /api/v1/users/{userId}/greeting-settings

**Update greeting settings**

Creates or updates the automatic greeting configuration for a user. Used to configure the message sent on first contact.

*Requirement:* WA-BUS-005

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Request Body:** `UpdateGreetingSettingsRequest`

**Responses:**

- `200`: OK - Greeting settings updated
- `400`: Bad Request - Invalid greeting settings payload
- `401`: Unauthorized - Missing or invalid access token
- `403`: Forbidden - User not allowed to update these settings
- `404`: Not Found - User not found
- `409`: Conflict - Greeting settings update conflict
- `500`: Internal Server Error - Failed to update greeting settings

---

#### `POST` /api/v1/conversations/{conversationId}/greeting-messages

**Create greeting message on first contact**

Creates an automatic greeting message when a first-contact event is detected in a conversation. Server-side logic ensures idempotency to avoid duplicate greetings.

*Requirement:* WA-BUS-005

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| conversationId | path | string | True | Conversation ID |

**Request Body:** `CreateGreetingMessageRequest`

**Responses:**

- `201`: Created - Greeting message created
- `400`: Bad Request - Invalid greeting message payload
- `401`: Unauthorized - Missing or invalid access token
- `403`: Forbidden - User not allowed to create greetings in this conversation
- `404`: Not Found - Conversation not found
- `409`: Conflict - Greeting already sent for this first-contact event
- `500`: Internal Server Error - Failed to create greeting message

---

#### `GET` /api/v1/conversations/{conversationId}/greeting-messages

**List greeting messages**

Returns a paginated list of greeting messages for a conversation to support client synchronization.

*Requirement:* WA-BUS-005

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| conversationId | path | string | True | Conversation ID |
| page | query | integer | False | Page number for pagination |
| pageSize | query | integer | False | Number of items per page |

**Request Body:** `ListGreetingMessagesRequest`

**Responses:**

- `200`: OK - Greeting messages retrieved
- `400`: Bad Request - Invalid pagination parameters
- `401`: Unauthorized - Missing or invalid access token
- `403`: Forbidden - User not allowed to access greetings in this conversation
- `404`: Not Found - Conversation not found
- `500`: Internal Server Error - Failed to retrieve greeting messages

---

### GroupCalls

#### `POST` /api/v1/group-calls

**Create a group call**

Creates a new group voice/video call and returns WebRTC negotiation data and TURN/STUN servers for real-time media setup.

*Requirement:* WA-CALL-003

**Request Body:** `CreateGroupCallRequest`

**Responses:**

- `201`: Created - Group call created successfully
- `400`: Bad Request - Missing or invalid parameters
- `401`: Unauthorized - Missing or invalid token
- `409`: Conflict - Duplicate call creation request
- `413`: Payload Too Large - Exceeds maximum request size
- `422`: Unprocessable Entity - Participant limit exceeded (max 1024)
- `500`: Internal Server Error - Failed to create group call

---

#### `GET` /api/v1/group-calls/{callId}

**Get group call details**

Retrieves metadata and current status of a group call.

*Requirement:* WA-CALL-003

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| callId | path | string | True | Group call ID |

**Request Body:** `GetGroupCallRequest`

**Responses:**

- `200`: OK - Group call details retrieved
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Group call does not exist
- `500`: Internal Server Error - Failed to retrieve group call

---

#### `POST` /api/v1/group-calls/{callId}/participants

**Invite participants to a group call**

Adds participants to an existing group call and triggers invitations via real-time channels.

*Requirement:* WA-CALL-003

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| callId | path | string | True | Group call ID |

**Request Body:** `AddGroupCallParticipantsRequest`

**Responses:**

- `201`: Created - Participants invited successfully
- `400`: Bad Request - Invalid participant list
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Group call does not exist
- `422`: Unprocessable Entity - Participant limit exceeded (max 1024)
- `500`: Internal Server Error - Failed to invite participants

---

#### `GET` /api/v1/group-calls/{callId}/participants

**List group call participants**

Retrieves a paginated list of participants in a group call.

*Requirement:* WA-CALL-003

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| callId | path | string | True | Group call ID |
| page | query | integer | True | Page number |
| pageSize | query | integer | True | Number of items per page |

**Request Body:** `ListGroupCallParticipantsRequest`

**Responses:**

- `200`: OK - Participants retrieved
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Group call does not exist
- `500`: Internal Server Error - Failed to list participants

---

#### `POST` /api/v1/group-calls/{callId}/join

**Join a group call**

Creates a participant session and returns WebRTC negotiation data for joining the call.

*Requirement:* WA-CALL-003

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| callId | path | string | True | Group call ID |

**Request Body:** `JoinGroupCallRequest`

**Responses:**

- `201`: Created - Participant joined the group call
- `400`: Bad Request - Invalid SDP or parameters
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Group call does not exist
- `409`: Conflict - Participant already joined
- `422`: Unprocessable Entity - Participant limit exceeded (max 1024)
- `500`: Internal Server Error - Failed to join group call

---

#### `DELETE` /api/v1/group-calls/{callId}/participants/{participantId}

**Leave or remove a participant from a group call**

Removes a participant from the group call and releases associated resources.

*Requirement:* WA-CALL-003

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| callId | path | string | True | Group call ID |
| participantId | path | string | True | Participant ID |

**Request Body:** `RemoveGroupCallParticipantRequest`

**Responses:**

- `200`: OK - Participant removed
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Call or participant does not exist
- `500`: Internal Server Error - Failed to remove participant

---

#### `DELETE` /api/v1/group-calls/{callId}

**End a group call**

Terminates the group call and notifies participants through real-time channels.

*Requirement:* WA-CALL-003

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| callId | path | string | True | Group call ID |

**Request Body:** `EndGroupCallRequest`

**Responses:**

- `200`: OK - Group call ended
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Group call does not exist
- `500`: Internal Server Error - Failed to end group call

---

### GroupEvents

#### `POST` /api/v1/groups/{groupId}/events

**Create a group event**

Create a new event within a group for event planning.

*Requirement:* WA-GRP-009

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| groupId | path | string | True | Group ID |

**Request Body:** `CreateGroupEventRequest`

**Responses:**

- `201`: Created - Event created successfully
- `400`: Bad Request - Invalid event payload or time range
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - User lacks permission to create events in group
- `404`: Not Found - Group does not exist
- `409`: Conflict - Duplicate event detected

---

#### `GET` /api/v1/groups/{groupId}/events

**List group events**

Retrieve a paginated list of events for a group.

*Requirement:* WA-GRP-009

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| groupId | path | string | True | Group ID |
| page | query | integer | True | Page number |
| pageSize | query | integer | True | Number of items per page |
| from | query | string | False | Filter events starting from ISO-8601 date-time |
| to | query | string | False | Filter events up to ISO-8601 date-time |

**Responses:**

- `200`: OK - Events retrieved successfully
- `400`: Bad Request - Invalid pagination or filter parameters
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - User lacks permission to view group events
- `404`: Not Found - Group does not exist

---

#### `GET` /api/v1/groups/{groupId}/events/{eventId}

**Get group event details**

Retrieve details for a specific group event.

*Requirement:* WA-GRP-009

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| groupId | path | string | True | Group ID |
| eventId | path | string | True | Event ID |

**Responses:**

- `200`: OK - Event retrieved successfully
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - User lacks permission to view event
- `404`: Not Found - Event or group does not exist

---

#### `PUT` /api/v1/groups/{groupId}/events/{eventId}

**Update a group event**

Update event details within a group.

*Requirement:* WA-GRP-009

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| groupId | path | string | True | Group ID |
| eventId | path | string | True | Event ID |

**Request Body:** `UpdateGroupEventRequest`

**Responses:**

- `200`: OK - Event updated successfully
- `400`: Bad Request - Invalid event payload or time range
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - User lacks permission to update event
- `404`: Not Found - Event or group does not exist
- `409`: Conflict - Event update conflicts with existing schedule

---

#### `DELETE` /api/v1/groups/{groupId}/events/{eventId}

**Delete a group event**

Delete an event from a group.

*Requirement:* WA-GRP-009

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| groupId | path | string | True | Group ID |
| eventId | path | string | True | Event ID |

**Responses:**

- `200`: OK - Event deleted successfully
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - User lacks permission to delete event
- `404`: Not Found - Event or group does not exist

---

#### `POST` /api/v1/groups/{groupId}/events/{eventId}/rsvps

**RSVP to a group event**

Create or update the current user's RSVP status for a group event.

*Requirement:* WA-GRP-009

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| groupId | path | string | True | Group ID |
| eventId | path | string | True | Event ID |

**Request Body:** `RsvpGroupEventRequest`

**Responses:**

- `201`: Created - RSVP recorded successfully
- `400`: Bad Request - Invalid RSVP status
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - User lacks permission to RSVP
- `404`: Not Found - Event or group does not exist
- `409`: Conflict - Event is at participant capacity

---

### GroupMembers

#### `GET` /api/v1/groups/{groupId}/members

**List group members**

Returns paginated list of group members.

*Requirement:* WA-GRP-002

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| groupId | path | string | True | Group ID |
| page | query | integer | True | Page number |
| pageSize | query | integer | True | Number of items per page |

**Request Body:** `ListGroupMembersRequest`

**Responses:**

- `200`: OK - Members retrieved
- `400`: Bad Request - Invalid pagination parameters
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Group does not exist

---

#### `POST` /api/v1/groups/{groupId}/members

**Add members to group**

Adds members to the group. Enforces max group size (1024).

*Requirement:* WA-GRP-002

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| groupId | path | string | True | Group ID |

**Request Body:** `AddGroupMembersRequest`

**Responses:**

- `201`: Created - Members added
- `400`: Bad Request - Invalid member list or member limit exceeded
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - Insufficient permissions
- `404`: Not Found - Group does not exist

---

#### `DELETE` /api/v1/groups/{groupId}/members/{memberId}

**Remove member from group**

Removes a member from the group.

*Requirement:* WA-GRP-002

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| groupId | path | string | True | Group ID |
| memberId | path | string | True | Member user ID |

**Request Body:** `RemoveGroupMemberRequest`

**Responses:**

- `200`: OK - Member removed
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - Insufficient permissions
- `404`: Not Found - Group or member does not exist

---

#### `PUT` /api/v1/groups/{groupId}/roles

**Update member roles**

Updates roles for group members (e.g., admin, member).

*Requirement:* WA-GRP-002

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| groupId | path | string | True | Group ID |

**Request Body:** `UpdateGroupRolesRequest`

**Responses:**

- `200`: OK - Roles updated
- `400`: Bad Request - Invalid role payload
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - Insufficient permissions
- `404`: Not Found - Group does not exist

---

### GroupMessages

#### `POST` /api/v1/group-chats/{groupId}/messages

**Send a group message with @mentions**

Creates a new end-to-end encrypted group message and supports @mentions by specifying mentioned user IDs. Mentions are delivered via WebSocket when online and via offline queue when recipients are offline.

*Requirement:* WA-MSG-013

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| groupId | path | string | True | Group chat ID |

**Request Body:** `CreateGroupMessageRequest`

**Responses:**

- `201`: Created - Message accepted and queued for delivery
- `400`: Bad Request - Missing ciphertext or invalid mentions format
- `401`: Unauthorized - Missing or invalid access token
- `403`: Forbidden - Sender is not a member of the group
- `404`: Not Found - Group chat does not exist
- `409`: Conflict - Duplicate clientMessageId detected
- `413`: Payload Too Large - Encrypted payload exceeds allowed size

---

### GroupSettings

#### `GET` /api/v1/groups/{groupId}/settings/invite-policy

**Get group invite policy**

Retrieves the current configuration that defines who is allowed to add members to the group.

*Requirement:* WA-SET-005

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| groupId | path | string | True | Unique group ID |

**Request Body:** `GetGroupInvitePolicyRequest`

**Responses:**

- `200`: OK - Invite policy retrieved successfully
- `401`: Unauthorized - Missing or invalid access token
- `403`: Forbidden - Insufficient permissions to view settings
- `404`: Not Found - Group does not exist

---

#### `PUT` /api/v1/groups/{groupId}/settings/invite-policy

**Update group invite policy**

Updates the configuration that defines who is allowed to add members to the group.

*Requirement:* WA-SET-005

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| groupId | path | string | True | Unique group ID |

**Request Body:** `UpdateGroupInvitePolicyRequest`

**Responses:**

- `200`: OK - Invite policy updated successfully
- `400`: Bad Request - Invalid invitePolicy value
- `401`: Unauthorized - Missing or invalid access token
- `403`: Forbidden - Only group owners or admins can update invite policy
- `404`: Not Found - Group does not exist
- `409`: Conflict - Group settings update conflict

---

### Groups

#### `POST` /api/v1/groups

**Create group chat**

Creates a new end-to-end encrypted group chat with an initial set of members (up to 1024).

*Requirement:* WA-GRP-001

**Request Body:** `CreateGroupRequest`

**Responses:**

- `201`: Created - Group successfully created
- `400`: Bad Request - Invalid input or member limit exceeded
- `401`: Unauthorized - Missing or invalid token
- `409`: Conflict - Group with the same name already exists

---

#### `POST` /api/v1/groups

**Create a new group**

Creates a new group with initial metadata. Enforces max group size (1024) and encryption metadata for Signal Protocol key distribution.

*Requirement:* WA-GRP-002

**Request Body:** `CreateGroupRequest`

**Responses:**

- `201`: Created - Group created successfully
- `400`: Bad Request - Invalid payload or member limit exceeded
- `401`: Unauthorized - Missing or invalid token
- `409`: Conflict - Duplicate group name for owner

---

#### `GET` /api/v1/groups

**List groups**

Returns groups the user belongs to, with pagination.

*Requirement:* WA-GRP-002

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| page | query | integer | True | Page number |
| pageSize | query | integer | True | Number of items per page |

**Request Body:** `ListGroupsRequest`

**Responses:**

- `200`: OK - Groups retrieved
- `400`: Bad Request - Invalid pagination parameters
- `401`: Unauthorized - Missing or invalid token

---

#### `GET` /api/v1/groups/{groupId}

**Get group details**

Returns group metadata including settings and member count.

*Requirement:* WA-GRP-002

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| groupId | path | string | True | Group ID |

**Request Body:** `GetGroupRequest`

**Responses:**

- `200`: OK - Group retrieved
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Group does not exist

---

#### `PUT` /api/v1/groups/{groupId}

**Update group metadata**

Updates group name/description and settings.

*Requirement:* WA-GRP-002

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| groupId | path | string | True | Group ID |

**Request Body:** `UpdateGroupRequest`

**Responses:**

- `200`: OK - Group updated
- `400`: Bad Request - Invalid update payload
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - Insufficient permissions
- `404`: Not Found - Group does not exist

---

#### `DELETE` /api/v1/groups/{groupId}

**Delete a group**

Deletes a group and all associated metadata.

*Requirement:* WA-GRP-002

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| groupId | path | string | True | Group ID |

**Request Body:** `DeleteGroupRequest`

**Responses:**

- `200`: OK - Group deleted
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - Insufficient permissions
- `404`: Not Found - Group does not exist

---

#### `PUT` /api/v1/groups/{groupId}/owner

**Transfer group ownership**

Transfers group ownership to another member.

*Requirement:* WA-GRP-002

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| groupId | path | string | True | Group ID |

**Request Body:** `TransferGroupOwnershipRequest`

**Responses:**

- `200`: OK - Ownership transferred
- `400`: Bad Request - New owner is not a member
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - Insufficient permissions
- `404`: Not Found - Group does not exist

---

#### `POST` /api/v1/groups/{groupId}/avatar

**Upload group avatar**

Uploads a group avatar image (max 16MB).

*Requirement:* WA-GRP-002

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| groupId | path | string | True | Group ID |

**Request Body:** `UploadGroupAvatarRequest`

**Responses:**

- `201`: Created - Avatar uploaded
- `400`: Bad Request - Invalid file type or size exceeds 16MB
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - Insufficient permissions
- `404`: Not Found - Group does not exist

---

#### `GET` /api/v1/groups/{groupId}/settings

**Get group settings**

Retrieves the configurable settings for a specific group.

*Requirement:* WA-GRP-003

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| groupId | path | string | True | Unique group ID |

**Responses:**

- `200`: OK - Group settings retrieved
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - Insufficient permissions to view settings
- `404`: Not Found - Group does not exist
- `500`: Internal Server Error - Failed to retrieve settings

---

#### `PUT` /api/v1/groups/{groupId}/settings

**Update group settings**

Updates configurable settings for a specific group. Validates constraints such as max members and encryption compatibility.

*Requirement:* WA-GRP-003

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| groupId | path | string | True | Unique group ID |

**Request Body:** `UpdateGroupSettingsRequest`

**Responses:**

- `200`: OK - Group settings updated
- `400`: Bad Request - Invalid settings or constraint violation
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - Insufficient permissions to update settings
- `404`: Not Found - Group does not exist
- `409`: Conflict - Update violates group state or constraints
- `500`: Internal Server Error - Failed to update settings

---

#### `POST` /api/v1/groups/{groupId}/invite-links

**Create a group invite link**

Creates a new invitation link for a group. The link can be shared to allow users to join the group. Enforces maximum group size of 1024 members.

*Requirement:* WA-GRP-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| groupId | path | string | True | Group ID |

**Request Body:** `CreateGroupInviteLinkRequest`

**Responses:**

- `201`: Created - Invite link created successfully
- `400`: Bad Request - Invalid expiration or maxUses
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - Not allowed to create invite links for this group
- `409`: Conflict - Active invite link already exists with same constraints

---

#### `GET` /api/v1/invite-links/{inviteToken}

**Get invite link details**

Returns basic information about an invite link to display to the user before joining. This endpoint is public so the link can be previewed without authentication.

*Requirement:* WA-GRP-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| inviteToken | path | string | True | Invite link token |

**Request Body:** `GetInviteLinkDetailsRequest`

**Responses:**

- `200`: OK - Invite link details retrieved
- `404`: Not Found - Invite link does not exist or is revoked
- `410`: Gone - Invite link has expired or max uses reached

---

#### `POST` /api/v1/invite-links/{inviteToken}/accept

**Accept a group invite link**

Joins the group using the invite link token. Enforces group size limit of 1024 members and invite constraints.

*Requirement:* WA-GRP-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| inviteToken | path | string | True | Invite link token |

**Request Body:** `AcceptInviteLinkRequest`

**Responses:**

- `201`: Created - User joined the group or request created
- `400`: Bad Request - Invalid invite token or request payload
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - User is blocked or cannot join this group
- `409`: Conflict - User is already a member or invite constraints violated
- `410`: Gone - Invite link has expired or max uses reached

---

#### `DELETE` /api/v1/groups/{groupId}/invite-links/{inviteId}

**Revoke a group invite link**

Revokes an existing group invite link so it can no longer be used.

*Requirement:* WA-GRP-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| groupId | path | string | True | Group ID |
| inviteId | path | string | True | Invite link ID |

**Request Body:** `RevokeGroupInviteLinkRequest`

**Responses:**

- `200`: OK - Invite link revoked
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - Not allowed to revoke invite links for this group
- `404`: Not Found - Invite link does not exist

---

#### `DELETE` /api/v1/groups/{groupId}/members/me

**Leave group silently**

Removes the authenticated user from the specified group without sending any notification to remaining members.

*Requirement:* WA-GRP-005

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| groupId | path | string | True | Group ID |
| silent | query | boolean | False | If true, no leave notification is sent to the group |

**Request Body:** `LeaveGroupRequest`

**Responses:**

- `200`: OK - Member left the group successfully
- `400`: Bad Request - Invalid group ID or parameters
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - Member is not allowed to leave this group
- `404`: Not Found - Group or membership not found
- `409`: Conflict - Member already left the group

---

#### `POST` /api/v1/communities/{communityId}/groups

**Add group to community**

Adds an existing group to a community. Supports up to 1024 members per group.

*Requirement:* WA-GRP-006

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| communityId | path | string | True | Community ID |

**Request Body:** `AddGroupToCommunityRequest`

**Responses:**

- `201`: Created - Group linked to community
- `400`: Bad Request - Missing or invalid groupId
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Community or group does not exist
- `409`: Conflict - Group is already linked to the community

---

#### `GET` /api/v1/communities/{communityId}/groups

**List community groups**

Returns a paginated list of groups within a community.

*Requirement:* WA-GRP-006

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| communityId | path | string | True | Community ID |
| page | query | integer | True | Page number (1-based) |
| pageSize | query | integer | True | Number of items per page |

**Request Body:** `ListCommunityGroupsRequest`

**Responses:**

- `200`: OK - Community groups retrieved successfully
- `400`: Bad Request - Invalid pagination parameters
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Community does not exist

---

#### `DELETE` /api/v1/communities/{communityId}/groups/{groupId}

**Remove group from community**

Unlinks a group from a community without deleting the group.

*Requirement:* WA-GRP-006

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| communityId | path | string | True | Community ID |
| groupId | path | string | True | Group ID |

**Request Body:** `RemoveGroupFromCommunityRequest`

**Responses:**

- `200`: OK - Group removed from community
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Community or group does not exist
- `409`: Conflict - Group is not linked to the community

---

#### `GET` /api/v1/groups/{groupId}/settings/invite-policy

**Get group invite policy**

Retrieves the current configuration that defines who is allowed to add members to the group.

*Requirement:* WA-SET-005

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| groupId | path | string | True | Unique group ID |

**Request Body:** `GetGroupInvitePolicyRequest`

**Responses:**

- `200`: OK - Invite policy retrieved successfully
- `401`: Unauthorized - Missing or invalid access token
- `403`: Forbidden - Insufficient permissions to view settings
- `404`: Not Found - Group does not exist

---

#### `PUT` /api/v1/groups/{groupId}/settings/invite-policy

**Update group invite policy**

Updates the configuration that defines who is allowed to add members to the group.

*Requirement:* WA-SET-005

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| groupId | path | string | True | Unique group ID |

**Request Body:** `UpdateGroupInvitePolicyRequest`

**Responses:**

- `200`: OK - Invite policy updated successfully
- `400`: Bad Request - Invalid invitePolicy value
- `401`: Unauthorized - Missing or invalid access token
- `403`: Forbidden - Only group owners or admins can update invite policy
- `404`: Not Found - Group does not exist
- `409`: Conflict - Group settings update conflict

---

### Integrations

#### `POST` /api/v1/integrations/apps

**Create integration app**

Creates a business integration app to access the Business API.

*Requirement:* WA-BUS-010

**Request Body:** `CreateIntegrationAppRequest`

**Responses:**

- `201`: Created - Integration app created
- `400`: Bad Request - Missing or invalid fields
- `401`: Unauthorized - Missing or invalid token
- `409`: Conflict - App already exists

---

#### `GET` /api/v1/integrations/apps

**List integration apps**

Returns paginated list of integration apps for the business account.

*Requirement:* WA-BUS-010

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| page | query | integer | True | Page number |
| pageSize | query | integer | True | Page size |

**Request Body:** `ListIntegrationAppsRequest`

**Responses:**

- `200`: OK - Apps retrieved
- `401`: Unauthorized - Missing or invalid token

---

#### `GET` /api/v1/integrations/apps/{appId}

**Get integration app**

Returns details for a specific integration app.

*Requirement:* WA-BUS-010

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| appId | path | string | True | Integration app ID |

**Request Body:** `GetIntegrationAppRequest`

**Responses:**

- `200`: OK - App retrieved
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - App does not exist

---

#### `POST` /api/v1/integrations/apps/{appId}/tokens

**Issue API token**

Issues an access token for the integration app using client credentials.

*Requirement:* WA-BUS-010

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| appId | path | string | True | Integration app ID |

**Request Body:** `IssueTokenRequest`

**Responses:**

- `201`: Created - Token issued
- `400`: Bad Request - Missing or invalid credentials
- `401`: Unauthorized - Invalid client credentials
- `404`: Not Found - App does not exist

---

#### `POST` /api/v1/integrations/keys

**Register encryption keys**

Registers Signal Protocol public keys for end-to-end encryption.

*Requirement:* WA-BUS-010

**Request Body:** `RegisterKeysRequest`

**Responses:**

- `201`: Created - Keys registered
- `400`: Bad Request - Invalid key payload
- `401`: Unauthorized - Missing or invalid token

---

### Invites

#### `POST` /api/v1/groups/{groupId}/invite-links

**Create a group invite link**

Creates a new invitation link for a group. The link can be shared to allow users to join the group. Enforces maximum group size of 1024 members.

*Requirement:* WA-GRP-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| groupId | path | string | True | Group ID |

**Request Body:** `CreateGroupInviteLinkRequest`

**Responses:**

- `201`: Created - Invite link created successfully
- `400`: Bad Request - Invalid expiration or maxUses
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - Not allowed to create invite links for this group
- `409`: Conflict - Active invite link already exists with same constraints

---

#### `GET` /api/v1/invite-links/{inviteToken}

**Get invite link details**

Returns basic information about an invite link to display to the user before joining. This endpoint is public so the link can be previewed without authentication.

*Requirement:* WA-GRP-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| inviteToken | path | string | True | Invite link token |

**Request Body:** `GetInviteLinkDetailsRequest`

**Responses:**

- `200`: OK - Invite link details retrieved
- `404`: Not Found - Invite link does not exist or is revoked
- `410`: Gone - Invite link has expired or max uses reached

---

#### `POST` /api/v1/invite-links/{inviteToken}/accept

**Accept a group invite link**

Joins the group using the invite link token. Enforces group size limit of 1024 members and invite constraints.

*Requirement:* WA-GRP-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| inviteToken | path | string | True | Invite link token |

**Request Body:** `AcceptInviteLinkRequest`

**Responses:**

- `201`: Created - User joined the group or request created
- `400`: Bad Request - Invalid invite token or request payload
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - User is blocked or cannot join this group
- `409`: Conflict - User is already a member or invite constraints violated
- `410`: Gone - Invite link has expired or max uses reached

---

#### `DELETE` /api/v1/groups/{groupId}/invite-links/{inviteId}

**Revoke a group invite link**

Revokes an existing group invite link so it can no longer be used.

*Requirement:* WA-GRP-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| groupId | path | string | True | Group ID |
| inviteId | path | string | True | Invite link ID |

**Request Body:** `RevokeGroupInviteLinkRequest`

**Responses:**

- `200`: OK - Invite link revoked
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - Not allowed to revoke invite links for this group
- `404`: Not Found - Invite link does not exist

---

### Languages

#### `GET` /api/v1/languages

**List supported languages**

Returns a paginated list of languages supported by the system for UI and content localization.

*Requirement:* WA-SET-010

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| page | query | integer | True | Page number for pagination |
| pageSize | query | integer | True | Number of items per page |

**Responses:**

- `200`: OK - Languages retrieved successfully
- `401`: Unauthorized - Missing or invalid token
- `500`: Internal Server Error - Failed to retrieve languages

---

#### `GET` /api/v1/users/me/language

**Get user language preference**

Retrieves the authenticated user's current language preference used for UI and content localization.

*Requirement:* WA-SET-010

**Responses:**

- `200`: OK - User language retrieved successfully
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - User language preference not set
- `500`: Internal Server Error - Failed to retrieve user language

---

#### `PUT` /api/v1/users/me/language

**Update user language preference**

Sets the authenticated user's preferred language used for UI and content localization.

*Requirement:* WA-SET-010

**Request Body:** `UpdateUserLanguageRequest`

**Responses:**

- `200`: OK - User language updated successfully
- `400`: Bad Request - Unsupported language code
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - User not found
- `500`: Internal Server Error - Failed to update user language

---

### Localization

#### `GET` /api/v1/users/{id}/preferences/localization

**Get user localization preferences**

Retrieves the user's localization settings including language and text direction to support full RTL rendering across clients.

*Requirement:* WA-LOC-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| id | path | string | True | User ID |

**Request Body:** `GetUserLocalizationPreferencesRequest`

**Responses:**

- `200`: OK - Preferences retrieved successfully
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - User or preferences not found

---

#### `PUT` /api/v1/users/{id}/preferences/localization

**Update user localization preferences**

Updates the user's localization settings to ensure full RTL language support across mobile and web clients.

*Requirement:* WA-LOC-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| id | path | string | True | User ID |

**Request Body:** `UpdateUserLocalizationPreferencesRequest`

**Responses:**

- `200`: OK - Preferences updated successfully
- `400`: Bad Request - Invalid language tag or text direction
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - User not found

---

#### `GET` /api/v1/locales

**List supported locales**

Returns supported locales and whether each locale is RTL or LTR for client-side rendering and layout decisions.

*Requirement:* WA-LOC-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| page | query | integer | True | Page number for pagination |
| pageSize | query | integer | True | Number of items per page |

**Request Body:** `ListSupportedLocalesRequest`

**Responses:**

- `200`: OK - Supported locales retrieved successfully
- `401`: Unauthorized - Missing or invalid token

---

### Locations

#### `POST` /api/v1/conversations/{conversationId}/messages/location

**Share location in a conversation**

Creates a new end-to-end encrypted location message within a conversation (1:1, group, or broadcast). The server stores only encrypted payload and metadata required for routing; supports offline queueing and real-time delivery via WebSocket.

*Requirement:* WA-MSG-014

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| conversationId | path | string | True | Conversation ID (direct, group, or broadcast) |

**Request Body:** `CreateLocationMessageRequest`

**Responses:**

- `201`: Created - Location message accepted for delivery
- `400`: Bad Request - Missing or invalid fields in location message
- `401`: Unauthorized - Missing or invalid access token
- `403`: Forbidden - Sender is not a participant of the conversation
- `404`: Not Found - Conversation does not exist
- `409`: Conflict - Duplicate clientMessageId for this conversation
- `413`: Payload Too Large - Encrypted payload exceeds allowed size
- `429`: Too Many Requests - Rate limit exceeded
- `500`: Internal Server Error - Failed to enqueue location message

---

### Media

#### `POST` /api/v1/media

**Upload encrypted media for view-once use**

Uploads end-to-end encrypted media and marks it as view-once eligible. Returns a mediaId to be referenced in messages. Enforces size limits (2GB documents, 16MB images).

*Requirement:* WA-MSG-009

**Request Body:** `UploadMediaRequest`

**Responses:**

- `201`: Created
- `400`: Bad Request - Missing or invalid media metadata
- `401`: Unauthorized - Missing or invalid token
- `413`: Payload Too Large - Media exceeds size limits
- `415`: Unsupported Media Type - Invalid media format
- `500`: Internal Server Error - Media upload failed

---

#### `GET` /api/v1/media/{mediaId}/view-once

**Retrieve and consume view-once media**

Returns the encrypted media content and marks it as consumed. Subsequent requests return 410 Gone.

*Requirement:* WA-MSG-009

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| mediaId | path | string | True | Media ID |

**Request Body:** `GetViewOnceMediaRequest`

**Responses:**

- `200`: OK
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - Not a recipient of the media
- `404`: Not Found - Media not found
- `410`: Gone - Media already consumed
- `500`: Internal Server Error - Media retrieval failed

---

#### `POST` /api/v1/media

**Upload media for broadcast messages**

Uploads media for broadcast messages. Supports max 2GB documents and 16MB images. Returns a mediaId for use in messages.

*Requirement:* WA-GRP-007

**Request Body:** `UploadMediaRequest`

**Responses:**

- `201`: Created - Media uploaded
- `400`: Bad Request - Unsupported media type or size limit exceeded
- `401`: Unauthorized - Missing or invalid token
- `413`: Payload Too Large - Media exceeds size limits

---

#### `POST` /api/v1/media/images

**Upload an image**

Uploads an image payload for later use in messages. Enforces 16MB max size for images. Supports end-to-end encrypted payloads (Signal Protocol) by allowing encrypted binary and metadata.

*Requirement:* WA-MED-001

**Request Body:** `UploadImageRequest`

**Responses:**

- `201`: Created - Image uploaded successfully
- `400`: Bad Request - Invalid multipart payload or missing fields
- `401`: Unauthorized - Missing or invalid token
- `413`: Payload Too Large - Image exceeds 16MB limit
- `415`: Unsupported Media Type - Invalid image MIME type
- `500`: Internal Server Error - Failed to store image

---

#### `POST` /api/v1/media/videos

**Upload video media**

Uploads an encrypted video file for later sending in a message. Supports offline queue by returning a mediaId that can be referenced when the device is back online. Max video size should be enforced according to server policy.

*Requirement:* WA-MED-002

**Request Body:** `UploadVideoRequest`

**Responses:**

- `201`: Created - Video uploaded successfully
- `400`: Bad Request - Missing file or invalid encryption metadata
- `401`: Unauthorized - Missing or invalid token
- `413`: Payload Too Large - Video exceeds allowed size limit
- `415`: Unsupported Media Type - Video MIME type not supported
- `500`: Internal Server Error - Failed to store media

---

#### `GET` /api/v1/media/library

**List user gallery items**

Returns a paginated list of media items the user has granted access to from the device gallery for selection and sharing. Metadata only; actual file is retrieved or uploaded via dedicated endpoints. Enforces max media sizes (16MB images, 2GB documents).

*Requirement:* WA-MED-009

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| page | query | integer | True | Page number for pagination |
| pageSize | query | integer | True | Number of items per page |
| type | query | string | False | Filter by media type (image, video, document) |

**Responses:**

- `200`: OK - Gallery items returned
- `400`: Bad Request - Invalid pagination parameters
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - Gallery access not granted by user
- `500`: Internal Server Error - Failed to retrieve gallery items

---

#### `POST` /api/v1/media/uploads

**Upload media from device gallery**

Uploads a media file selected from the device gallery for sharing. The client MUST encrypt media using Signal Protocol before upload. Enforces max size 16MB for images and 2GB for documents.

*Requirement:* WA-MED-009

**Request Body:** `UploadMediaRequest`

**Responses:**

- `201`: Created - Media uploaded successfully
- `400`: Bad Request - Unsupported media type or missing fields
- `401`: Unauthorized - Missing or invalid token
- `413`: Payload Too Large - Media exceeds maximum allowed size
- `500`: Internal Server Error - Upload failed

---

#### `POST` /api/v1/media/uploads

**Initialize an HD media upload session**

Creates an upload session for HD media with size and type validation for encrypted media transfer. Supports large files via multipart/chunked upload.

*Requirement:* WA-MED-010

**Request Body:** `CreateMediaUploadSessionRequest`

**Responses:**

- `201`: Created - Upload session initialized
- `400`: Bad Request - Media type or size violates limits (e.g., 16MB images, 2GB documents)
- `401`: Unauthorized - Missing or invalid token
- `413`: Payload Too Large - File size exceeds maximum allowed
- `415`: Unsupported Media Type - MIME type is not allowed

---

#### `PUT` /api/v1/media/uploads/{uploadId}/parts/{partNumber}

**Upload a media chunk**

Uploads a single encrypted chunk for an HD media upload session.

*Requirement:* WA-MED-010

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| uploadId | path | string | True | Upload session identifier |
| partNumber | path | integer | True | Chunk sequence number starting at 1 |

**Request Body:** `UploadMediaPartRequest`

**Responses:**

- `200`: OK - Chunk uploaded successfully
- `400`: Bad Request - Invalid part number or chunk size
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Upload session does not exist or is expired
- `409`: Conflict - Chunk already uploaded

---

#### `POST` /api/v1/media/uploads/{uploadId}/complete

**Complete an HD media upload**

Finalizes the multipart upload and creates the media resource for sending in messages.

*Requirement:* WA-MED-010

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| uploadId | path | string | True | Upload session identifier |

**Request Body:** `CompleteMediaUploadRequest`

**Responses:**

- `201`: Created - Media resource finalized
- `400`: Bad Request - Missing or invalid part list
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Upload session does not exist or is expired
- `409`: Conflict - Upload already completed

---

#### `GET` /api/v1/media/{mediaId}

**Retrieve encrypted media metadata and download URL**

Returns metadata for an HD media resource and a time-limited download URL for the encrypted payload.

*Requirement:* WA-MED-010

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| mediaId | path | string | True | Media resource identifier |

**Request Body:** `GetMediaRequest`

**Responses:**

- `200`: OK - Media metadata returned
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Media resource does not exist

---

#### `GET` /api/v1/media

**Search media with type filters**

Retrieve media items with optional filtering by media types. Supports pagination for mobile-first clients.

*Requirement:* WA-SRC-002

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| mediaTypes | query | string | False | Comma-separated list of media types to filter by (e.g., image, video, audio, document) |
| conversationId | query | string | False | Filter media within a specific conversation or group |
| senderId | query | string | False | Filter media by sender user ID |
| page | query | integer | True | Page number for pagination |
| pageSize | query | integer | True | Number of items per page |

**Request Body:** `ListMediaByTypeRequest`

**Responses:**

- `200`: OK - Media list retrieved successfully
- `400`: Bad Request - Invalid filter or pagination parameters
- `401`: Unauthorized - Missing or invalid access token
- `403`: Forbidden - Access to the requested media is not allowed
- `500`: Internal Server Error - Failed to retrieve media list

---

#### `POST` /api/v1/business-profiles/{id}/media

**Upload business profile media**

Uploads media (logo or cover) for a business profile. Enforce media limits (16MB images, 2GB documents).

*Requirement:* WA-BUS-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| id | path | string | True | Business profile ID |

**Request Body:** `UploadBusinessProfileMediaRequest`

**Responses:**

- `201`: Created - Media uploaded successfully
- `400`: Bad Request - Invalid media type or file
- `401`: Unauthorized - Missing or invalid access token
- `413`: Payload Too Large - Media exceeds allowed size limits

---

#### `POST` /api/v1/integrations/media

**Upload media**

Uploads encrypted media for messages. Max size: 2GB documents, 16MB images.

*Requirement:* WA-BUS-010

**Request Body:** `UploadMediaRequest`

**Responses:**

- `201`: Created - Media uploaded
- `400`: Bad Request - Invalid media type or checksum
- `401`: Unauthorized - Missing or invalid token
- `413`: Payload Too Large - Media size exceeds limits

---

#### `POST` /api/v1/share-extensions/{shareId}/attachments

**Upload share-extension media**

Uploads media for a share-extension payload. Enforces max sizes (documents 2GB, images 16MB). Media will be encrypted end-to-end by the client.

*Requirement:* WA-INT-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| shareId | path | string | True | Share payload identifier |

**Request Body:** `ShareExtensionAttachmentUploadRequest`

**Responses:**

- `201`: Created - Attachment uploaded
- `400`: Bad Request - Missing or invalid fields
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Share payload not found
- `413`: Payload Too Large - Exceeds allowed media size
- `415`: Unsupported Media Type - Invalid media type
- `500`: Internal Server Error - Failed to upload attachment

---

#### `POST` /api/v1/media

**Upload media attachment**

Uploads media for AI chat messages with size limits (2GB documents, 16MB images).

*Requirement:* WA-AI-001

**Request Body:** `UploadMediaRequest`

**Responses:**

- `201`: Created - Media uploaded
- `400`: Bad Request - Missing file or unsupported mediaType
- `401`: Unauthorized - Missing or invalid token
- `413`: Payload Too Large - Media exceeds allowed size limits

---

### MediaDrafts

#### `POST` /api/v1/media-drafts

**Create an image draft for editing**

Uploads an image as a draft to enable basic edits (crop, rotate, filters) before sending. Max image size is 16MB.

*Requirement:* WA-MED-004

**Request Body:** `CreateMediaDraftRequest`

**Responses:**

- `201`: Created - Draft uploaded successfully
- `400`: Bad Request - Missing file or invalid multipart form data
- `401`: Unauthorized - Missing or invalid token
- `413`: Payload Too Large - Image exceeds 16MB limit
- `415`: Unsupported Media Type - File is not a supported image format

---

#### `PUT` /api/v1/media-drafts/{draftId}/edits

**Apply edits to an image draft**

Applies basic image edits such as crop, rotate, and filters to a draft. Edits are stored as a transformation pipeline before finalization.

*Requirement:* WA-MED-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| draftId | path | string | True | Draft ID |

**Request Body:** `UpdateMediaDraftEditsRequest`

**Responses:**

- `200`: OK - Edits applied successfully
- `400`: Bad Request - Invalid edit parameters or ranges
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Draft ID does not exist
- `422`: Unprocessable Entity - Edit operations are incompatible

---

#### `POST` /api/v1/media-drafts/{draftId}/finalize

**Finalize an edited image draft**

Renders the edited draft into a finalized media asset ready for sending with end-to-end encryption applied on the client side.

*Requirement:* WA-MED-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| draftId | path | string | True | Draft ID |

**Request Body:** `FinalizeMediaDraftRequest`

**Responses:**

- `201`: Created - Draft finalized successfully
- `400`: Bad Request - Invalid finalize request
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Draft ID does not exist
- `409`: Conflict - Draft already finalized
- `500`: Internal Server Error - Failed to render edited image

---

### Messages

#### `POST` /api/v1/conversations/{conversationId}/messages

**Send a text message**

Sends an end-to-end encrypted text message to a conversation. The message is enqueued for offline recipients and delivered in real time via WebSocket if available.

*Requirement:* WA-MSG-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| conversationId | path | string | True | Conversation ID (1:1, group, or broadcast) |

**Request Body:** `SendTextMessageRequest`

**Responses:**

- `201`: Created - Message accepted and queued for delivery
- `400`: Bad Request - Invalid or missing encrypted payload
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - Sender is not a member of the conversation
- `404`: Not Found - Conversation does not exist
- `409`: Conflict - Duplicate clientMessageId detected
- `413`: Payload Too Large - Message exceeds size limits
- `429`: Too Many Requests - Rate limit exceeded

---

#### `POST` /api/v1/messages/voice

**Send a voice message**

Creates and sends a new end-to-end encrypted voice message to a user, group, or broadcast list. The voice payload is uploaded as a binary file and is expected to be encrypted client-side using the Signal Protocol.

*Requirement:* WA-MSG-002

**Request Body:** `CreateVoiceMessageRequest`

**Responses:**

- `201`: Created - Voice message accepted for delivery
- `400`: Bad Request - Missing or invalid fields
- `401`: Unauthorized - Missing or invalid access token
- `403`: Forbidden - Recipient not allowed or blocked
- `404`: Not Found - Recipient does not exist
- `413`: Payload Too Large - Voice message exceeds allowed size
- `415`: Unsupported Media Type - Invalid MIME type
- `429`: Too Many Requests - Rate limit exceeded
- `500`: Internal Server Error - Failed to process voice message

---

#### `DELETE` /api/v1/messages/{messageId}

**Nachricht loeschen**

Loescht eine Nachricht fuer den anfragenden Nutzer oder fuer alle Empfaenger, sofern berechtigt. Unterstuetzt Offline-Queues und E2E-Verschluesselung durch serverseitige Tombaendaten.

*Requirement:* WA-MSG-003

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| messageId | path | string | True | Eindeutige ID der Nachricht |

**Request Body:** `DeleteMessageRequest`

**Responses:**

- `200`: OK - Nachricht geloescht
- `400`: Bad Request - Ungueltiger Loeschbereich oder fehlende Pflichtfelder
- `401`: Unauthorized - Fehlendes oder ungueltiges Token
- `403`: Forbidden - Keine Berechtigung fuer Loeschung fuer alle Empfaenger
- `404`: Not Found - Nachricht nicht gefunden
- `409`: Conflict - Nachricht bereits geloescht
- `500`: Internal Server Error - Unerwarteter Fehler beim Loeschen der Nachricht

---

#### `PUT` /api/v1/messages/{messageId}

**Edit a sent message**

Allows a sender to edit an already sent message. The updated content must be provided as end-to-end encrypted payload compatible with Signal Protocol. The server stores the updated ciphertext and broadcasts the edit event via WebSocket to recipients, supporting offline queues.

*Requirement:* WA-MSG-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| messageId | path | string | True | Unique identifier of the message to edit |

**Request Body:** `EditMessageRequest`

**Responses:**

- `200`: OK - Message edited successfully
- `400`: Bad Request - Missing or invalid encrypted payload
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - User is not the sender of the message
- `404`: Not Found - Message does not exist
- `409`: Conflict - Edit version conflict or duplicate clientEditId
- `413`: Payload Too Large - Encrypted content exceeds allowed size
- `500`: Internal Server Error - Failed to process message edit

---

#### `POST` /api/v1/messages/{messageId}/forward

**Forward a message**

Forwards an existing message to one or more recipients (users, groups, or broadcast lists) with end-to-end encryption payloads and optional client-side offline queue metadata.

*Requirement:* WA-MSG-005

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| messageId | path | string | True | ID of the original message to forward |

**Request Body:** `ForwardMessageRequest`

**Responses:**

- `201`: Created - Message forwarded successfully
- `400`: Bad Request - Invalid recipients or malformed encryption envelope
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - Sender not allowed to forward to target
- `404`: Not Found - Original message or recipient not found
- `413`: Payload Too Large - Forwarded media exceeds size limits
- `422`: Unprocessable Entity - Recipient limits exceeded (group or broadcast)
- `500`: Internal Server Error - Failed to forward message

---

#### `POST` /api/v1/messages

**Send a message with optional quote**

Creates a new message and optionally links it to a specific message being quoted/replied to. Supports end-to-end encrypted payloads and offline queue delivery.

*Requirement:* WA-MSG-006

**Request Body:** `CreateMessageRequest`

**Responses:**

- `201`: Created - Message accepted and queued for delivery
- `400`: Bad Request - Missing or invalid fields (e.g., invalid quotedMessageId)
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - Sender not allowed to post in this conversation
- `404`: Not Found - Conversation or quoted message does not exist
- `409`: Conflict - Duplicate clientMessageId
- `500`: Internal Server Error - Failed to create message

---

#### `POST` /api/v1/messages/{messageId}/reactions

**Add an emoji reaction to a message**

Creates an emoji reaction for the specified message. Reaction payload should be end-to-end encrypted as per Signal Protocol client-side before submission.

*Requirement:* WA-MSG-007

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| messageId | path | string | True | Message ID to react to |

**Request Body:** `CreateReactionRequest`

**Responses:**

- `201`: Created - Reaction added
- `400`: Bad Request - Invalid emoji or missing required fields
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Message does not exist
- `409`: Conflict - Reaction already exists for this user

---

#### `GET` /api/v1/messages/{messageId}/reactions

**List emoji reactions for a message**

Returns a paginated list of emoji reactions for the specified message.

*Requirement:* WA-MSG-007

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| messageId | path | string | True | Message ID to fetch reactions for |
| page | query | integer | True | Page number |
| pageSize | query | integer | True | Number of items per page |

**Request Body:** `ListReactionsRequest`

**Responses:**

- `200`: OK - Reactions retrieved
- `400`: Bad Request - Invalid pagination parameters
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Message does not exist

---

#### `DELETE` /api/v1/messages/{messageId}/reactions/{reactionId}

**Remove an emoji reaction from a message**

Deletes a previously added reaction. The caller must be the owner of the reaction.

*Requirement:* WA-MSG-007

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| messageId | path | string | True | Message ID |
| reactionId | path | string | True | Reaction ID to remove |

**Request Body:** `DeleteReactionRequest`

**Responses:**

- `200`: OK - Reaction removed
- `400`: Bad Request - Invalid identifiers
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - Not allowed to delete this reaction
- `404`: Not Found - Reaction or message does not exist

---

#### `POST` /api/v1/messages

**Send a self-destructing message**

Creates a new message with an optional self-destruct policy (time-to-live or absolute expiration). The server stores metadata to enforce deletion while preserving end-to-end encryption payload.

*Requirement:* WA-MSG-008

**Request Body:** `CreateMessageRequest`

**Responses:**

- `201`: Created - Message accepted and queued for delivery
- `400`: Bad Request - Missing or invalid self-destruct policy
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Conversation does not exist
- `409`: Conflict - Duplicate clientMessageId

---

#### `PATCH` /api/v1/messages/{messageId}/self-destruct

**Update self-destruct policy for a message**

Updates the self-destruction policy for a pending message where allowed. Used to adjust TTL or expiration before delivery.

*Requirement:* WA-MSG-008

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| messageId | path | string | True | Message ID |

**Request Body:** `UpdateSelfDestructRequest`

**Responses:**

- `200`: OK - Self-destruct policy updated
- `400`: Bad Request - Invalid TTL or expiration timestamp
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - Policy cannot be changed after delivery
- `404`: Not Found - Message does not exist

---

#### `DELETE` /api/v1/messages/{messageId}

**Delete a message immediately**

Deletes a message for all recipients before its self-destruct timer. This is distinct from automatic self-destruction.

*Requirement:* WA-MSG-008

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| messageId | path | string | True | Message ID |

**Request Body:** `DeleteMessageRequest`

**Responses:**

- `200`: OK - Message deleted
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - User cannot delete this message
- `404`: Not Found - Message does not exist

---

#### `POST` /api/v1/messages

**Send a message with view-once media**

Creates a message referencing uploaded media and flags it as view-once. Message delivery is via WebSocket and supports offline queueing.

*Requirement:* WA-MSG-009

**Request Body:** `CreateMessageRequest`

**Responses:**

- `201`: Created
- `400`: Bad Request - Invalid conversation or media reference
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - Sender not allowed in conversation
- `404`: Not Found - Conversation or media not found
- `409`: Conflict - Duplicate clientMessageId
- `500`: Internal Server Error - Message creation failed

---

#### `POST` /api/v1/conversations/{conversationId}/messages

**Create a message with formatted text**

Creates a new message in a conversation. The message body is end-to-end encrypted and may include basic text formatting metadata (e.g., bold, italic, code). This supports offline queue submission and will be delivered via WebSocket.

*Requirement:* WA-MSG-012

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| conversationId | path | string | True | Conversation ID |

**Request Body:** `CreateFormattedMessageRequest`

**Responses:**

- `201`: Created - Message accepted for delivery
- `400`: Bad Request - Invalid formatting metadata or ciphertext
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - User not allowed to post in this conversation
- `409`: Conflict - Duplicate clientMessageId
- `413`: Payload Too Large - Message exceeds allowed size
- `422`: Unprocessable Entity - Formatting entities are out of bounds

---

#### `GET` /api/v1/conversations/{conversationId}/messages

**List messages with formatted text metadata**

Retrieves messages in a conversation. Encrypted payload and formatting metadata are returned for client-side rendering. Supports pagination for mobile-first clients.

*Requirement:* WA-MSG-012

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| conversationId | path | string | True | Conversation ID |
| page | query | integer | True | Page number |
| pageSize | query | integer | True | Page size |

**Request Body:** `ListMessagesRequest`

**Responses:**

- `200`: OK - Messages retrieved
- `400`: Bad Request - Invalid pagination parameters
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - User not allowed to access this conversation
- `404`: Not Found - Conversation does not exist

---

#### `POST` /api/v1/conversations/{conversationId}/messages/location

**Share location in a conversation**

Creates a new end-to-end encrypted location message within a conversation (1:1, group, or broadcast). The server stores only encrypted payload and metadata required for routing; supports offline queueing and real-time delivery via WebSocket.

*Requirement:* WA-MSG-014

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| conversationId | path | string | True | Conversation ID (direct, group, or broadcast) |

**Request Body:** `CreateLocationMessageRequest`

**Responses:**

- `201`: Created - Location message accepted for delivery
- `400`: Bad Request - Missing or invalid fields in location message
- `401`: Unauthorized - Missing or invalid access token
- `403`: Forbidden - Sender is not a participant of the conversation
- `404`: Not Found - Conversation does not exist
- `409`: Conflict - Duplicate clientMessageId for this conversation
- `413`: Payload Too Large - Encrypted payload exceeds allowed size
- `429`: Too Many Requests - Rate limit exceeded
- `500`: Internal Server Error - Failed to enqueue location message

---

#### `POST` /api/v1/chats/{chatId}/messages

**Share a contact in a chat**

Creates a new message that shares contact details within a chat (1:1, group, or broadcast). The contact payload is end-to-end encrypted using the Signal Protocol and can be queued for offline delivery.

*Requirement:* WA-MSG-015

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| chatId | path | string | True | Chat ID (1:1, group, or broadcast) |

**Request Body:** `CreateContactShareMessageRequest`

**Responses:**

- `201`: Created - Contact share message created and queued for delivery
- `400`: Bad Request - Missing or invalid fields for contact share
- `401`: Unauthorized - Missing or invalid access token
- `403`: Forbidden - User not allowed to post in this chat
- `404`: Not Found - Chat does not exist
- `409`: Conflict - Duplicate clientMessageId for this chat
- `413`: Payload Too Large - Encrypted payload exceeds allowed limits
- `429`: Too Many Requests - Rate limit exceeded
- `500`: Internal Server Error - Failed to create contact share message

---

#### `POST` /api/v1/conversations/{conversationId}/messages

**Send an image message**

Creates a new message with an image attachment in a conversation. Supports offline queueing by accepting client-generated messageId and idempotency key.

*Requirement:* WA-MED-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| conversationId | path | string | True | Conversation ID (1:1, group, or broadcast) |

**Request Body:** `SendImageMessageRequest`

**Responses:**

- `201`: Created - Image message sent or queued
- `400`: Bad Request - Missing or invalid fields
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - Not a member of the conversation
- `404`: Not Found - Conversation or media not found
- `409`: Conflict - Duplicate messageId
- `500`: Internal Server Error - Failed to create message

---

#### `POST` /api/v1/messages

**Send a video message**

Sends a message containing a previously uploaded encrypted video to a user, group, or broadcast list. Supports offline queueing by accepting a clientMessageId for idempotency.

*Requirement:* WA-MED-002

**Request Body:** `SendVideoMessageRequest`

**Responses:**

- `201`: Created - Video message queued for delivery
- `400`: Bad Request - Invalid recipient or missing mediaId
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - Recipient not allowed or group limit exceeded
- `404`: Not Found - Media or recipient does not exist
- `409`: Conflict - Duplicate clientMessageId
- `413`: Payload Too Large - Encrypted message too large
- `500`: Internal Server Error - Failed to queue message

---

#### `POST` /api/v1/messages/documents

**Send a document message**

Sends an arbitrary document to a user, group, or broadcast list with end-to-end encrypted metadata. Supports offline queuing and real-time delivery via WebSocket. Maximum document size is 2GB.

*Requirement:* WA-MED-003

**Request Body:** `SendDocumentMessageRequest`

**Responses:**

- `201`: Created - Document message accepted for delivery
- `400`: Bad Request - Missing or invalid fields, or file exceeds 2GB limit
- `401`: Unauthorized - Missing or invalid access token
- `403`: Forbidden - Recipient type or permissions not allowed
- `413`: Payload Too Large - Document exceeds maximum size of 2GB
- `422`: Unprocessable Entity - Encryption metadata invalid or inconsistent
- `429`: Too Many Requests - Rate limit exceeded
- `500`: Internal Server Error - Unexpected failure while processing the document

---

#### `POST` /api/v1/chats/{chatId}/messages

**Send sticker message**

Send a sticker message to a chat. The sticker reference and encrypted payload are required for end-to-end encryption (Signal Protocol). Supports offline queuing via client-generated messageId.

*Requirement:* WA-MED-005

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| chatId | path | string | True | Chat ID |

**Request Body:** `SendStickerMessageRequest`

**Responses:**

- `201`: Created - Sticker message sent
- `400`: Bad Request - Missing or invalid sticker data
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Chat or sticker not found
- `409`: Conflict - Duplicate messageId already processed
- `413`: Payload Too Large - Encrypted payload exceeds limits
- `500`: Internal Server Error - Failed to send sticker message

---

#### `POST` /api/v1/messages/gifs

**Send GIF message**

Send a GIF message to a user, group, or broadcast list. Payload is end-to-end encrypted using Signal Protocol; clients send encrypted content and metadata.

*Requirement:* WA-MED-006

**Request Body:** `SendGifMessageRequest`

**Responses:**

- `201`: Created - GIF message accepted for delivery
- `400`: Bad Request - Missing or invalid recipient or GIF data
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - Recipient not allowed or group limit exceeded
- `409`: Conflict - Duplicate clientMessageId
- `413`: Payload Too Large - GIF exceeds size limit
- `500`: Internal Server Error - Failed to send GIF message

---

#### `POST` /api/v1/messages/media

**Send an HD media message**

Sends a message referencing an HD media resource with end-to-end encryption metadata. Supports direct, group, and broadcast recipients within limits.

*Requirement:* WA-MED-010

**Request Body:** `SendMediaMessageRequest`

**Responses:**

- `201`: Created - Media message sent
- `400`: Bad Request - Missing recipients or invalid payload
- `401`: Unauthorized - Missing or invalid token
- `409`: Conflict - Duplicate messageQueueId
- `413`: Payload Too Large - Recipient list exceeds broadcast limit (256)

---

#### `POST` /api/v1/messages

**Send encrypted message**

Sends an end-to-end encrypted message payload. Server stores ciphertext for offline delivery and forwards over WebSocket when available.

*Requirement:* WA-SEC-001

**Request Body:** `SendEncryptedMessageRequest`

**Responses:**

- `201`: Created - Encrypted message accepted and queued
- `400`: Bad Request - Missing ciphertext or invalid payload
- `401`: Unauthorized - Missing or invalid token
- `413`: Payload Too Large - Encrypted payload exceeds limits
- `409`: Conflict - Duplicate clientMessageId

---

#### `GET` /api/v1/messages

**Fetch encrypted message queue**

Retrieves queued encrypted messages for the authenticated device for offline delivery.

*Requirement:* WA-SEC-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| page | query | integer | True | Page number |
| pageSize | query | integer | True | Number of items per page |

**Request Body:** `ListQueuedMessagesRequest`

**Responses:**

- `200`: OK - Queued messages returned
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - No queued messages for device

---

#### `POST` /api/v1/messages/{messageId}/ack

**Acknowledge message delivery**

Acknowledges successful decryption and delivery on the client to remove from server queue.

*Requirement:* WA-SEC-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| messageId | path | string | True | Message identifier |

**Request Body:** `AcknowledgeMessageRequest`

**Responses:**

- `201`: Created - Message acknowledged
- `400`: Bad Request - Missing deviceId
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Message not found in queue

---

#### `POST` /api/v1/messages/{messageId}/quick-replies

**Send a quick reply to a message from a notification**

Creates a quick reply to a specific message directly from a notification. Payload is end-to-end encrypted (Signal Protocol) and queued for offline delivery if necessary. Supports mobile-first clients and real-time delivery via WebSocket.

*Requirement:* WA-NOT-003

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| messageId | path | string | True | ID of the original message being replied to |

**Request Body:** `CreateQuickReplyRequest`

**Responses:**

- `201`: Created - Quick reply accepted and queued/sent
- `400`: Bad Request - Missing required fields or invalid encrypted payload
- `401`: Unauthorized - Missing or invalid authentication token
- `404`: Not Found - Original message or notification does not exist
- `409`: Conflict - Duplicate clientMessageId
- `422`: Unprocessable Entity - Payload cannot be decrypted or violates protocol constraints
- `500`: Internal Server Error - Failed to create quick reply

---

#### `GET` /api/v1/unknown-senders/{senderId}/messages

**List messages from an unknown sender**

Returns a paginated list of pending messages from a specific unknown sender.

*Requirement:* WA-CON-005

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| senderId | path | string | True | Sender ID |
| page | query | integer | True | Page number for pagination |
| pageSize | query | integer | True | Number of items per page |

**Request Body:** `ListUnknownSenderMessagesRequest`

**Responses:**

- `200`: OK - List of pending messages returned
- `400`: Bad Request - Invalid pagination parameters
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Unknown sender does not exist
- `500`: Internal Server Error - Failed to retrieve messages

---

#### `GET` /api/v1/messages/search

**Search messages by full text**

Performs a full-text search over messages accessible to the authenticated user. Supports pagination and optional filters such as chatId and senderId.

*Requirement:* WA-SRC-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| q | query | string | True | Full-text search query |
| chatId | query | string | False | Filter results to a specific chat or group |
| senderId | query | string | False | Filter results by sender user ID |
| fromTimestamp | query | string | False | Filter results from this ISO 8601 timestamp (inclusive) |
| toTimestamp | query | string | False | Filter results up to this ISO 8601 timestamp (inclusive) |
| page | query | integer | True | Page number for pagination (starting at 1) |
| pageSize | query | integer | True | Number of items per page |

**Responses:**

- `200`: OK - Search results returned successfully
- `400`: Bad Request - Missing or invalid search query or pagination parameters
- `401`: Unauthorized - Missing or invalid authentication token
- `403`: Forbidden - User does not have access to one or more requested chats
- `429`: Too Many Requests - Search rate limit exceeded
- `500`: Internal Server Error - Unexpected error during search processing

---

#### `GET` /api/v1/conversations/{conversationId}/messages

**Nachrichten ab bestimmtem Datum abrufen**

Ermoeglicht den Sprung zu einem bestimmten Datum in einer Konversation und liefert Nachrichten ab dem angegebenen Zeitpunkt. Unterstuetzt Offline-Nachrichten-Queue durch serverseitige Synchronisation der Historie.

*Requirement:* WA-SRC-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| conversationId | path | string | True | Eindeutige ID der Konversation |
| date | query | string | True | ISO-8601 Datum/Zeit (UTC) als Sprungziel, z. B. 2024-05-01T00:00:00Z |
| direction | query | string | False | Richtung der Suche relativ zum Datum: 'forward' oder 'backward' (Standard: forward) |
| page | query | integer | True | Seitennummer fuer die Paginierung |
| pageSize | query | integer | True | Anzahl der Eintraege pro Seite |

**Request Body:** `GetMessagesByDateRequest`

**Responses:**

- `200`: OK - Nachrichten erfolgreich abgerufen
- `400`: Bad Request - Ungueltiges Datumsformat oder Parameter
- `401`: Unauthorized - Fehlendes oder ungueltiges Token
- `403`: Forbidden - Kein Zugriff auf die Konversation
- `404`: Not Found - Konversation nicht gefunden
- `500`: Internal Server Error - Unerwarteter Serverfehler

---

#### `POST` /api/v1/offline-queues/{queueId}/messages

**Enqueue offline message**

Stores an end-to-end encrypted message/event in the offline queue for later delivery.

*Requirement:* WA-PERF-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| queueId | path | string | True | Offline queue ID |

**Request Body:** `EnqueueOfflineMessageRequest`

**Responses:**

- `201`: Created - Message queued for offline delivery
- `400`: Bad Request - Invalid ciphertext or metadata
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Queue does not exist

---

#### `GET` /api/v1/offline-queues/{queueId}/messages

**List queued messages**

Retrieves queued messages for a device to enable offline synchronization. Supports pagination.

*Requirement:* WA-PERF-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| queueId | path | string | True | Offline queue ID |
| page | query | integer | True | Page number for pagination |
| pageSize | query | integer | True | Number of items per page |

**Request Body:** `ListQueuedMessagesRequest`

**Responses:**

- `200`: OK - Queued messages retrieved
- `400`: Bad Request - Invalid pagination parameters
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Queue does not exist

---

#### `POST` /api/v1/offline-queues/{queueId}/messages/ack

**Acknowledge queued messages**

Acknowledges delivery of queued messages to remove them from the offline queue.

*Requirement:* WA-PERF-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| queueId | path | string | True | Offline queue ID |

**Request Body:** `AckQueuedMessagesRequest`

**Responses:**

- `200`: OK - Messages acknowledged
- `400`: Bad Request - Invalid messageIds
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Queue does not exist

---

#### `GET` /api/v1/messages/sync

**Synchronize new and updated messages**

Returns a delta of messages since the last sync, optimized for mobile clients and offline queues. Supports pagination for efficient batching.

*Requirement:* WA-PERF-003

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| since | query | string | False | ISO-8601 timestamp of the last successful sync |
| cursor | query | string | False | Opaque cursor for delta pagination |
| page | query | integer | True | Page number for pagination |
| pageSize | query | integer | True | Number of records per page |

**Request Body:** `MessagesSyncRequest`

**Responses:**

- `200`: OK - Sync delta retrieved successfully
- `400`: Bad Request - Invalid pagination or sync parameters
- `401`: Unauthorized - Missing or invalid token
- `429`: Too Many Requests - Sync rate limit exceeded
- `500`: Internal Server Error - Unable to process sync

---

#### `POST` /api/v1/messages/sync/ack

**Acknowledge synchronized messages**

Confirms receipt and processing of synchronized messages to support efficient delta sync and offline queues.

*Requirement:* WA-PERF-003

**Request Body:** `MessagesSyncAckRequest`

**Responses:**

- `201`: Created - Acknowledgment recorded
- `400`: Bad Request - Invalid message IDs or timestamp
- `401`: Unauthorized - Missing or invalid token
- `409`: Conflict - Acknowledgment state conflict
- `500`: Internal Server Error - Unable to record acknowledgment

---

### Messaging

#### `POST` /api/v1/integrations/messages

**Send message**

Sends an end-to-end encrypted message. Supports offline queueing and real-time delivery via WebSocket. Enforces max group members (1024) and max broadcast recipients (256).

*Requirement:* WA-BUS-010

**Request Body:** `SendMessageRequest`

**Responses:**

- `201`: Created - Message accepted
- `400`: Bad Request - Invalid recipient or payload
- `401`: Unauthorized - Missing or invalid token
- `413`: Payload Too Large - Encrypted message exceeds limits

---

#### `GET` /api/v1/integrations/messages

**List messages**

Retrieves paginated messages for integration tracking and reconciliation.

*Requirement:* WA-BUS-010

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| page | query | integer | True | Page number |
| pageSize | query | integer | True | Page size |
| since | query | string | False | Filter by ISO-8601 timestamp |

**Request Body:** `ListMessagesRequest`

**Responses:**

- `200`: OK - Messages retrieved
- `401`: Unauthorized - Missing or invalid token

---

### Notifications

#### `GET` /api/v1/users/{userId}/notification-preferences

**Get notification preview settings**

Returns the user's configurable notification preview settings used by mobile clients to render previews.

*Requirement:* WA-NOT-002

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Request Body:** `GetNotificationPreferencesRequest`

**Responses:**

- `200`: OK - Notification preferences returned
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - Cannot access preferences for another user
- `404`: Not Found - User not found

---

#### `PUT` /api/v1/users/{userId}/notification-preferences

**Update notification preview settings**

Updates the user's configurable notification preview settings. Settings are applied across devices and used by clients for previews.

*Requirement:* WA-NOT-002

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Request Body:** `UpdateNotificationPreferencesRequest`

**Responses:**

- `200`: OK - Preferences updated
- `400`: Bad Request - Invalid preview configuration
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - Cannot update preferences for another user
- `404`: Not Found - User not found

---

#### `POST` /api/v1/notification-previews

**Generate notification preview**

Generates a server-side notification preview payload based on encrypted metadata and user preferences. The message content remains end-to-end encrypted.

*Requirement:* WA-NOT-002

**Request Body:** `CreateNotificationPreviewRequest`

**Responses:**

- `201`: Created - Preview generated
- `400`: Bad Request - Invalid preview input or unsupported message type
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - Recipient preferences disallow previews
- `404`: Not Found - Message or user not found

---

#### `GET` /api/v1/notifications/reactions

**List reaction notifications**

Returns a paginated list of reaction notifications for the authenticated user's own messages. Notifications are generated when other users react to the user's messages. Intended for offline clients to sync missed notifications in addition to WebSocket delivery.

*Requirement:* WA-NOT-005

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| page | query | integer | True | Page number for pagination (starting at 1) |
| pageSize | query | integer | True | Number of items per page |
| since | query | string | False | ISO-8601 timestamp to fetch notifications created after this time |
| unreadOnly | query | boolean | False | If true, return only unread notifications |

**Responses:**

- `200`: OK - Reaction notifications retrieved successfully
- `400`: Bad Request - Invalid pagination parameters
- `401`: Unauthorized - Missing or invalid access token
- `403`: Forbidden - Not allowed to access these notifications
- `500`: Internal Server Error - Failed to retrieve notifications

---

#### `PUT` /api/v1/notifications/reactions/{notificationId}/read

**Mark reaction notification as read**

Marks a specific reaction notification as read for the authenticated user. Useful for syncing read state across devices when offline queues are used.

*Requirement:* WA-NOT-005

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| notificationId | path | string | True | Notification ID |

**Request Body:** `MarkReactionNotificationReadRequest`

**Responses:**

- `200`: OK - Notification marked as read
- `400`: Bad Request - Invalid readAt timestamp
- `401`: Unauthorized - Missing or invalid access token
- `403`: Forbidden - Not allowed to modify this notification
- `404`: Not Found - Notification does not exist
- `409`: Conflict - Notification already marked as read
- `500`: Internal Server Error - Failed to update notification

---

### Offline

#### `POST` /api/v1/offline-queues

**Create offline queue**

Creates a device-scoped offline message queue to store encrypted events while the client is offline.

*Requirement:* WA-PERF-001

**Request Body:** `CreateOfflineQueueRequest`

**Responses:**

- `201`: Created - Offline queue initialized
- `400`: Bad Request - Missing or invalid deviceId/clientPublicKey
- `401`: Unauthorized - Missing or invalid token
- `409`: Conflict - Queue already exists for device

---

#### `POST` /api/v1/offline-queues/{queueId}/messages

**Enqueue offline message**

Stores an end-to-end encrypted message/event in the offline queue for later delivery.

*Requirement:* WA-PERF-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| queueId | path | string | True | Offline queue ID |

**Request Body:** `EnqueueOfflineMessageRequest`

**Responses:**

- `201`: Created - Message queued for offline delivery
- `400`: Bad Request - Invalid ciphertext or metadata
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Queue does not exist

---

#### `GET` /api/v1/offline-queues/{queueId}/messages

**List queued messages**

Retrieves queued messages for a device to enable offline synchronization. Supports pagination.

*Requirement:* WA-PERF-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| queueId | path | string | True | Offline queue ID |
| page | query | integer | True | Page number for pagination |
| pageSize | query | integer | True | Number of items per page |

**Request Body:** `ListQueuedMessagesRequest`

**Responses:**

- `200`: OK - Queued messages retrieved
- `400`: Bad Request - Invalid pagination parameters
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Queue does not exist

---

#### `POST` /api/v1/offline-queues/{queueId}/messages/ack

**Acknowledge queued messages**

Acknowledges delivery of queued messages to remove them from the offline queue.

*Requirement:* WA-PERF-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| queueId | path | string | True | Offline queue ID |

**Request Body:** `AckQueuedMessagesRequest`

**Responses:**

- `200`: OK - Messages acknowledged
- `400`: Bad Request - Invalid messageIds
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Queue does not exist

---

#### `DELETE` /api/v1/offline-queues/{queueId}

**Delete offline queue**

Deletes an offline queue and all queued messages for the device.

*Requirement:* WA-PERF-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| queueId | path | string | True | Offline queue ID |

**Request Body:** `DeleteOfflineQueueRequest`

**Responses:**

- `200`: OK - Queue deleted
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Queue does not exist

---

### OfflineQueue

#### `GET` /api/v1/queues

**Fetch offline queued messages**

Retrieves messages queued while the web client was offline. Supports pagination.

*Requirement:* WA-INT-006

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| page | query | integer | True | Page number for pagination |
| pageSize | query | integer | True | Number of items per page |

**Responses:**

- `200`: OK - Queued messages returned
- `400`: Bad Request - Invalid pagination parameters
- `401`: Unauthorized - Missing or invalid token
- `503`: Service Unavailable - Queue service unavailable

---

#### `POST` /api/v1/queues/ack

**Acknowledge offline queue messages**

Acknowledges delivery of queued messages so they can be removed from the offline queue.

*Requirement:* WA-INT-006

**Request Body:** `AckOfflineQueueRequest`

**Responses:**

- `201`: Created - Acknowledgements recorded
- `400`: Bad Request - Invalid queue IDs
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - One or more queue items do not exist

---

### Participants

#### `POST` /api/v1/group-calls/{callId}/participants

**Invite participants to a group call**

Adds participants to an existing group call and triggers invitations via real-time channels.

*Requirement:* WA-CALL-003

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| callId | path | string | True | Group call ID |

**Request Body:** `AddGroupCallParticipantsRequest`

**Responses:**

- `201`: Created - Participants invited successfully
- `400`: Bad Request - Invalid participant list
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Group call does not exist
- `422`: Unprocessable Entity - Participant limit exceeded (max 1024)
- `500`: Internal Server Error - Failed to invite participants

---

#### `GET` /api/v1/group-calls/{callId}/participants

**List group call participants**

Retrieves a paginated list of participants in a group call.

*Requirement:* WA-CALL-003

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| callId | path | string | True | Group call ID |
| page | query | integer | True | Page number |
| pageSize | query | integer | True | Number of items per page |

**Request Body:** `ListGroupCallParticipantsRequest`

**Responses:**

- `200`: OK - Participants retrieved
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Group call does not exist
- `500`: Internal Server Error - Failed to list participants

---

#### `DELETE` /api/v1/group-calls/{callId}/participants/{participantId}

**Leave or remove a participant from a group call**

Removes a participant from the group call and releases associated resources.

*Requirement:* WA-CALL-003

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| callId | path | string | True | Group call ID |
| participantId | path | string | True | Participant ID |

**Request Body:** `RemoveGroupCallParticipantRequest`

**Responses:**

- `200`: OK - Participant removed
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Call or participant does not exist
- `500`: Internal Server Error - Failed to remove participant

---

### Passkeys

#### `POST` /api/v1/auth/passkeys/registration/options

**Get passkey registration options**

Generates WebAuthn registration options (challenge, rp, user, params) for creating a passkey on the client.

*Requirement:* WA-AUTH-005

**Request Body:** `PasskeyRegistrationOptionsRequest`

**Responses:**

- `201`: Created - Registration options generated
- `400`: Bad Request - Missing or invalid registration input
- `429`: Too Many Requests - Rate limit exceeded
- `500`: Internal Server Error - Failed to create registration options

---

#### `POST` /api/v1/auth/passkeys/registration/verify

**Verify passkey registration**

Verifies the WebAuthn registration response and stores the passkey credential for the user.

*Requirement:* WA-AUTH-005

**Request Body:** `PasskeyRegistrationVerifyRequest`

**Responses:**

- `201`: Created - Passkey registered successfully
- `400`: Bad Request - Invalid attestation or malformed credential
- `409`: Conflict - Passkey already registered
- `422`: Unprocessable Entity - Challenge mismatch or verification failed
- `500`: Internal Server Error - Failed to store passkey

---

#### `POST` /api/v1/auth/passkeys/authentication/options

**Get passkey authentication options**

Generates WebAuthn authentication options (challenge, allowCredentials) for passkey login.

*Requirement:* WA-AUTH-005

**Request Body:** `PasskeyAuthenticationOptionsRequest`

**Responses:**

- `201`: Created - Authentication options generated
- `400`: Bad Request - Missing or invalid authentication input
- `404`: Not Found - User not found or no passkeys available
- `429`: Too Many Requests - Rate limit exceeded
- `500`: Internal Server Error - Failed to create authentication options

---

#### `POST` /api/v1/auth/passkeys/authentication/verify

**Verify passkey authentication**

Verifies the WebAuthn authentication response and issues access tokens upon success.

*Requirement:* WA-AUTH-005

**Request Body:** `PasskeyAuthenticationVerifyRequest`

**Responses:**

- `201`: Created - Authentication verified and tokens issued
- `400`: Bad Request - Invalid assertion or malformed credential
- `401`: Unauthorized - Verification failed or credential not recognized
- `422`: Unprocessable Entity - Challenge mismatch or signature invalid
- `500`: Internal Server Error - Failed to verify authentication

---

#### `GET` /api/v1/users/{userId}/passkeys

**List user's passkeys**

Returns the list of registered passkeys for a user.

*Requirement:* WA-AUTH-005

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |
| page | query | integer | True | Page number |
| pageSize | query | integer | True | Number of items per page |

**Request Body:** `ListUserPasskeysRequest`

**Responses:**

- `200`: OK - Passkeys retrieved
- `400`: Bad Request - Invalid pagination parameters
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - User not found
- `500`: Internal Server Error - Failed to retrieve passkeys

---

#### `DELETE` /api/v1/users/{userId}/passkeys/{credentialId}

**Delete a passkey**

Removes a registered passkey credential for the user.

*Requirement:* WA-AUTH-005

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |
| credentialId | path | string | True | Credential ID |

**Request Body:** `DeleteUserPasskeyRequest`

**Responses:**

- `200`: OK - Passkey deleted
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - Not allowed to delete this passkey
- `404`: Not Found - Passkey not found
- `500`: Internal Server Error - Failed to delete passkey

---

### Payments

#### `GET` /api/v1/payments/markets

**List supported payment markets**

Returns the list of markets where in-app WhatsApp Pay is available for the authenticated user.

*Requirement:* WA-BUS-008

**Responses:**

- `200`: OK - Supported markets returned
- `401`: Unauthorized - Missing or invalid access token
- `500`: Internal Server Error - Unable to fetch markets

---

#### `POST` /api/v1/payments

**Create a payment**

Creates a new in-app payment request between two users within a supported market.

*Requirement:* WA-BUS-008

**Request Body:** `CreatePaymentRequest`

**Responses:**

- `201`: Created - Payment created successfully
- `400`: Bad Request - Missing or invalid payment fields
- `401`: Unauthorized - Missing or invalid access token
- `409`: Conflict - Duplicate idempotency key
- `422`: Unprocessable Entity - Market not supported or payment not allowed

---

#### `GET` /api/v1/payments/{paymentId}

**Get payment details**

Retrieves details and status of a specific payment.

*Requirement:* WA-BUS-008

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| paymentId | path | string | True | Payment ID |

**Responses:**

- `200`: OK - Payment details returned
- `401`: Unauthorized - Missing or invalid access token
- `404`: Not Found - Payment ID does not exist

---

#### `GET` /api/v1/payments

**List payments**

Returns a paginated list of payments for the authenticated user.

*Requirement:* WA-BUS-008

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| page | query | integer | True | Page number for pagination |
| pageSize | query | integer | True | Number of items per page |
| status | query | string | False | Filter by payment status |

**Responses:**

- `200`: OK - Payments list returned
- `400`: Bad Request - Invalid pagination parameters
- `401`: Unauthorized - Missing or invalid access token

---

### Polls

#### `POST` /api/v1/chats/{chatId}/polls

**Create a poll in a chat**

Creates a new poll in a group or direct chat. Poll content is expected to be encrypted client-side (E2E).

*Requirement:* WA-GRP-008

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| chatId | path | string | True | Chat ID (group or direct chat) |

**Request Body:** `CreatePollRequest`

**Responses:**

- `201`: Created - Poll successfully created
- `400`: Bad Request - Invalid poll payload or missing fields
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - Not a participant of the chat
- `404`: Not Found - Chat does not exist

---

#### `GET` /api/v1/chats/{chatId}/polls

**List polls in a chat**

Retrieves a paginated list of polls for a chat. Poll content is returned as encrypted payloads.

*Requirement:* WA-GRP-008

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| chatId | path | string | True | Chat ID (group or direct chat) |
| page | query | integer | True | Page number |
| pageSize | query | integer | True | Page size |

**Responses:**

- `200`: OK - Poll list retrieved
- `400`: Bad Request - Invalid pagination parameters
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - Not a participant of the chat
- `404`: Not Found - Chat does not exist

---

#### `GET` /api/v1/chats/{chatId}/polls/{pollId}

**Get poll details**

Retrieves a specific poll with encrypted content and current tally metadata.

*Requirement:* WA-GRP-008

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| chatId | path | string | True | Chat ID (group or direct chat) |
| pollId | path | string | True | Poll ID |

**Responses:**

- `200`: OK - Poll details retrieved
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - Not a participant of the chat
- `404`: Not Found - Poll or chat does not exist

---

#### `POST` /api/v1/chats/{chatId}/polls/{pollId}/votes

**Cast or update a vote**

Submits a user's vote for a poll in a chat. Vote content is encrypted client-side.

*Requirement:* WA-GRP-008

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| chatId | path | string | True | Chat ID (group or direct chat) |
| pollId | path | string | True | Poll ID |

**Request Body:** `SubmitVoteRequest`

**Responses:**

- `201`: Created - Vote successfully submitted
- `400`: Bad Request - Invalid vote payload or selection
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - Not a participant of the chat or poll is closed
- `404`: Not Found - Poll or chat does not exist
- `409`: Conflict - Vote not allowed due to poll rules

---

#### `POST` /api/v1/chats/{chatId}/polls/{pollId}/close

**Close a poll**

Closes an active poll in a chat. Only poll creator or authorized admins may close.

*Requirement:* WA-GRP-008

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| chatId | path | string | True | Chat ID (group or direct chat) |
| pollId | path | string | True | Poll ID |

**Request Body:** `ClosePollRequest`

**Responses:**

- `200`: OK - Poll successfully closed
- `400`: Bad Request - Poll already closed
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - Insufficient permissions to close poll
- `404`: Not Found - Poll or chat does not exist

---

### PowerPolicy

#### `GET` /api/v1/power-policy

**Retrieve server power policy**

Provides server-recommended battery optimization policies such as sync intervals, websocket keepalive, and background fetch limits to enable battery-efficient operation.

*Requirement:* WA-PERF-004

**Responses:**

- `200`: OK - Power policy retrieved successfully
- `401`: Unauthorized - Missing or invalid token
- `503`: Service Unavailable - Power policy temporarily unavailable

---

### Presence

#### `GET` /api/v1/users/{userId}/presence-visibility

**Get online status visibility setting**

Returns the configured visibility setting for a user's online/last seen status.

*Requirement:* WA-SET-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID whose visibility setting is requested |

**Request Body:** `GetPresenceVisibilityRequest`

**Responses:**

- `200`: OK - Visibility setting returned
- `401`: Unauthorized - Missing or invalid access token
- `403`: Forbidden - Not allowed to view this user's visibility setting
- `404`: Not Found - User does not exist
- `500`: Internal Server Error - Failed to retrieve visibility setting

---

#### `PUT` /api/v1/users/{userId}/presence-visibility

**Update online status visibility setting**

Updates the configured visibility setting for a user's online/last seen status.

*Requirement:* WA-SET-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID whose visibility setting is being updated |

**Request Body:** `UpdatePresenceVisibilityRequest`

**Responses:**

- `200`: OK - Visibility setting updated
- `400`: Bad Request - Invalid visibility value or conflicting allow/deny lists
- `401`: Unauthorized - Missing or invalid access token
- `403`: Forbidden - Not allowed to update this user's visibility setting
- `404`: Not Found - User does not exist
- `409`: Conflict - Request conflicts with current visibility rules
- `500`: Internal Server Error - Failed to update visibility setting

---

#### `GET` /api/v1/users/{userId}/presence-visibility/allowed-users

**List users allowed to see online status**

Returns a paginated list of users explicitly allowed to see status when visibility is custom.

*Requirement:* WA-SET-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID whose allow list is requested |
| page | query | integer | True | Page number for pagination |
| pageSize | query | integer | True | Page size for pagination |

**Request Body:** `ListPresenceAllowedUsersRequest`

**Responses:**

- `200`: OK - Allowed users list returned
- `401`: Unauthorized - Missing or invalid access token
- `403`: Forbidden - Not allowed to view this allow list
- `404`: Not Found - User or allow list does not exist
- `500`: Internal Server Error - Failed to retrieve allow list

---

#### `GET` /api/v1/users/{userId}/presence-visibility/denied-users

**List users denied to see online status**

Returns a paginated list of users explicitly denied to see status when visibility is custom.

*Requirement:* WA-SET-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID whose deny list is requested |
| page | query | integer | True | Page number for pagination |
| pageSize | query | integer | True | Page size for pagination |

**Request Body:** `ListPresenceDeniedUsersRequest`

**Responses:**

- `200`: OK - Denied users list returned
- `401`: Unauthorized - Missing or invalid access token
- `403`: Forbidden - Not allowed to view this deny list
- `404`: Not Found - User or deny list does not exist
- `500`: Internal Server Error - Failed to retrieve deny list

---

### Privacy

#### `GET` /api/v1/users/{userId}/privacy/infoVisibility

**Get info/status text visibility settings**

Retrieves the configurable visibility settings for a user's info/status text. These settings control who can see the user's info/status text across the system.

*Requirement:* WA-SET-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Request Body:** `GetInfoVisibilitySettingsRequest`

**Responses:**

- `200`: OK - Settings retrieved successfully
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - Access denied for requested user
- `404`: Not Found - User does not exist

---

#### `PUT` /api/v1/users/{userId}/privacy/infoVisibility

**Update info/status text visibility settings**

Updates the configurable visibility settings for a user's info/status text. Changes are applied immediately across the system.

*Requirement:* WA-SET-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Request Body:** `UpdateInfoVisibilitySettingsRequest`

**Responses:**

- `200`: OK - Settings updated successfully
- `400`: Bad Request - Invalid visibility value
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - Access denied for requested user
- `404`: Not Found - User does not exist

---

### ProductCatalog

#### `POST` /api/v1/businesses/{businessId}/products

**Create product in business catalog**

Creates a new product entry in the specified business product catalog.

*Requirement:* WA-BUS-006

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| businessId | path | string | True | Business ID |

**Request Body:** `CreateBusinessProductRequest`

**Responses:**

- `201`: Created - Product added to catalog
- `400`: Bad Request - Missing or invalid product fields
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - Insufficient permissions to manage catalog
- `409`: Conflict - Product with same SKU already exists

---

#### `GET` /api/v1/businesses/{businessId}/products

**List products in business catalog**

Retrieves a paginated list of products in the specified business product catalog.

*Requirement:* WA-BUS-006

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| businessId | path | string | True | Business ID |
| page | query | integer | True | Page number (1-based) |
| pageSize | query | integer | True | Number of items per page |
| isActive | query | boolean | False | Filter by active status |
| query | query | string | False | Search by name or SKU |

**Responses:**

- `200`: OK - Products retrieved
- `400`: Bad Request - Invalid pagination parameters
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - Insufficient permissions to view catalog

---

#### `GET` /api/v1/businesses/{businessId}/products/{productId}

**Get product details**

Retrieves the details of a specific product in the business catalog.

*Requirement:* WA-BUS-006

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| businessId | path | string | True | Business ID |
| productId | path | string | True | Product ID |

**Responses:**

- `200`: OK - Product retrieved
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - Insufficient permissions to view product
- `404`: Not Found - Product does not exist

---

#### `PUT` /api/v1/businesses/{businessId}/products/{productId}

**Update product details**

Updates a specific product in the business catalog.

*Requirement:* WA-BUS-006

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| businessId | path | string | True | Business ID |
| productId | path | string | True | Product ID |

**Request Body:** `UpdateBusinessProductRequest`

**Responses:**

- `200`: OK - Product updated
- `400`: Bad Request - Invalid product fields
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - Insufficient permissions to manage product
- `404`: Not Found - Product does not exist
- `409`: Conflict - SKU already used by another product

---

#### `DELETE` /api/v1/businesses/{businessId}/products/{productId}

**Delete product from catalog**

Removes a product from the business catalog.

*Requirement:* WA-BUS-006

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| businessId | path | string | True | Business ID |
| productId | path | string | True | Product ID |

**Responses:**

- `200`: OK - Product deleted
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - Insufficient permissions to manage catalog
- `404`: Not Found - Product does not exist

---

#### `POST` /api/v1/businesses/{businessId}/products/{productId}/media

**Upload product media**

Uploads media (image/document) for a product. Enforces max size of 16MB for images and 2GB for documents.

*Requirement:* WA-BUS-006

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| businessId | path | string | True | Business ID |
| productId | path | string | True | Product ID |

**Request Body:** `UploadBusinessProductMediaRequest`

**Responses:**

- `201`: Created - Media uploaded
- `400`: Bad Request - Invalid media type or file
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - Insufficient permissions to manage product media
- `413`: Payload Too Large - Media exceeds allowed size

---

#### `DELETE` /api/v1/businesses/{businessId}/products/{productId}/media/{mediaId}

**Delete product media**

Removes a media asset from a product.

*Requirement:* WA-BUS-006

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| businessId | path | string | True | Business ID |
| productId | path | string | True | Product ID |
| mediaId | path | string | True | Media ID |

**Responses:**

- `200`: OK - Media deleted
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - Insufficient permissions to manage product media
- `404`: Not Found - Media does not exist

---

### ProfileImages

#### `POST` /api/v1/users/{userId}/profile-images

**Upload profile image**

Uploads a new profile image for the specified user. Enforces max image size of 16MB. Overwrites existing profile image metadata with the latest version.

*Requirement:* WA-PROF-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Request Body:** `UploadProfileImageRequest`

**Responses:**

- `201`: Created - Profile image uploaded successfully
- `400`: Bad Request - Invalid file or exceeded size limit (max 16MB)
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - Not allowed to modify this user
- `415`: Unsupported Media Type - Only image files are allowed
- `500`: Internal Server Error - Failed to store profile image

---

#### `GET` /api/v1/users/{userId}/profile-images/current

**Get current profile image**

Retrieves metadata for the user's current profile image.

*Requirement:* WA-PROF-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Request Body:** `GetProfileImageRequest`

**Responses:**

- `200`: OK - Profile image retrieved
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - Not allowed to access this user
- `404`: Not Found - No profile image set for user
- `500`: Internal Server Error - Failed to retrieve profile image

---

#### `PUT` /api/v1/users/{userId}/profile-images/current

**Replace current profile image**

Replaces the user's current profile image with a new one. Enforces max image size of 16MB.

*Requirement:* WA-PROF-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Request Body:** `ReplaceProfileImageRequest`

**Responses:**

- `200`: OK - Profile image replaced
- `400`: Bad Request - Invalid file or exceeded size limit (max 16MB)
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - Not allowed to modify this user
- `415`: Unsupported Media Type - Only image files are allowed
- `500`: Internal Server Error - Failed to replace profile image

---

#### `DELETE` /api/v1/users/{userId}/profile-images/current

**Delete current profile image**

Deletes the user's current profile image.

*Requirement:* WA-PROF-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Request Body:** `DeleteProfileImageRequest`

**Responses:**

- `200`: OK - Profile image deleted
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - Not allowed to modify this user
- `404`: Not Found - No profile image set for user
- `500`: Internal Server Error - Failed to delete profile image

---

### Profiles

#### `GET` /api/v1/users/{userId}/profile/info-text

**Get profile info text**

Retrieves the short info/status text displayed in a user's profile.

*Requirement:* WA-PROF-003

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | Unique identifier of the user |

**Responses:**

- `200`: OK - Info text retrieved successfully
- `401`: Unauthorized - Missing or invalid access token
- `403`: Forbidden - Not allowed to access this user's profile
- `404`: Not Found - User or profile info text does not exist

---

#### `PUT` /api/v1/users/{userId}/profile/info-text

**Update profile info text**

Creates or updates the short info/status text displayed in a user's profile.

*Requirement:* WA-PROF-003

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | Unique identifier of the user |

**Request Body:** `UpdateUserProfileInfoTextRequest`

**Responses:**

- `200`: OK - Info text updated successfully
- `400`: Bad Request - Info text is missing, empty, or exceeds allowed length
- `401`: Unauthorized - Missing or invalid access token
- `403`: Forbidden - Not allowed to update this user's profile
- `404`: Not Found - User does not exist
- `409`: Conflict - Concurrent update conflict detected

---

### PushNotifications

#### `POST` /api/v1/push-tokens

**Register device push token**

Registers or updates a device push token for reliable delivery to iOS/Android clients.

*Requirement:* WA-NOT-001

**Request Body:** `RegisterPushTokenRequest`

**Responses:**

- `201`: Created - Push token registered
- `400`: Bad Request - Missing or invalid fields
- `401`: Unauthorized - Missing or invalid token
- `409`: Conflict - Token already registered for device

---

#### `POST` /api/v1/push-notifications

**Send push notification**

Creates a reliable push notification with end-to-end encrypted payload for a user, group, or broadcast list.

*Requirement:* WA-NOT-001

**Request Body:** `CreatePushNotificationRequest`

**Responses:**

- `201`: Created - Notification queued
- `400`: Bad Request - Invalid recipient or payload
- `401`: Unauthorized - Missing or invalid token
- `413`: Payload Too Large - Encrypted payload exceeds limits

---

#### `GET` /api/v1/push-notifications

**List push notifications**

Returns a paginated list of push notifications for the authenticated user.

*Requirement:* WA-NOT-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| page | query | integer | True | Page number |
| pageSize | query | integer | True | Number of items per page |

**Request Body:** `ListPushNotificationsRequest`

**Responses:**

- `200`: OK - Notifications retrieved
- `400`: Bad Request - Invalid pagination parameters
- `401`: Unauthorized - Missing or invalid token

---

#### `POST` /api/v1/push-notifications/{id}/ack

**Acknowledge push notification**

Acknowledges delivery or processing of a push notification to support reliability and offline queues.

*Requirement:* WA-NOT-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| id | path | string | True | Notification ID |

**Request Body:** `AckPushNotificationRequest`

**Responses:**

- `201`: Created - Acknowledgement recorded
- `400`: Bad Request - Invalid acknowledgement status
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Notification does not exist

---

### QrCodes

#### `POST` /api/v1/users/{userId}/qr-codes

**Generate a new profile QR code**

Generates a new scannable QR code that encodes a secure, time-bound invite/deeplink for adding the user profile.

*Requirement:* WA-PROF-005

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | Unique user identifier |

**Request Body:** `CreateUserQrCodeRequest`

**Responses:**

- `201`: Created - QR code generated successfully
- `400`: Bad Request - Invalid format, size, or validitySeconds
- `401`: Unauthorized - Missing or invalid access token
- `404`: Not Found - User does not exist
- `429`: Too Many Requests - QR code generation rate limit exceeded
- `500`: Internal Server Error - Unable to generate QR code

---

#### `GET` /api/v1/users/{userId}/qr-codes/{qrCodeId}

**Retrieve a profile QR code**

Retrieves a previously generated QR code for the user profile.

*Requirement:* WA-PROF-005

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | Unique user identifier |
| qrCodeId | path | string | True | Unique QR code identifier |

**Request Body:** `GetUserQrCodeRequest`

**Responses:**

- `200`: OK - QR code retrieved successfully
- `401`: Unauthorized - Missing or invalid access token
- `404`: Not Found - QR code or user does not exist
- `410`: Gone - QR code has expired
- `500`: Internal Server Error - Unable to retrieve QR code

---

### QuickReplies

#### `POST` /api/v1/messages/{messageId}/quick-replies

**Send a quick reply to a message from a notification**

Creates a quick reply to a specific message directly from a notification. Payload is end-to-end encrypted (Signal Protocol) and queued for offline delivery if necessary. Supports mobile-first clients and real-time delivery via WebSocket.

*Requirement:* WA-NOT-003

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| messageId | path | string | True | ID of the original message being replied to |

**Request Body:** `CreateQuickReplyRequest`

**Responses:**

- `201`: Created - Quick reply accepted and queued/sent
- `400`: Bad Request - Missing required fields or invalid encrypted payload
- `401`: Unauthorized - Missing or invalid authentication token
- `404`: Not Found - Original message or notification does not exist
- `409`: Conflict - Duplicate clientMessageId
- `422`: Unprocessable Entity - Payload cannot be decrypted or violates protocol constraints
- `500`: Internal Server Error - Failed to create quick reply

---

#### `POST` /api/v1/businesses/{businessId}/quick-replies

**Create quick reply**

Creates a predefined quick reply for a business to be used in messaging.

*Requirement:* WA-BUS-003

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| businessId | path | string | True | Business ID |

**Request Body:** `CreateQuickReplyRequest`

**Responses:**

- `201`: Created - Quick reply was created successfully
- `400`: Bad Request - Missing or invalid fields in request body
- `401`: Unauthorized - Missing or invalid authentication token
- `404`: Not Found - Business does not exist
- `409`: Conflict - Quick reply with same title already exists

---

#### `GET` /api/v1/businesses/{businessId}/quick-replies

**List quick replies**

Retrieves a paginated list of quick replies for a business.

*Requirement:* WA-BUS-003

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| businessId | path | string | True | Business ID |
| page | query | integer | True | Page number for pagination |
| pageSize | query | integer | True | Number of items per page |
| isActive | query | boolean | False | Filter by active status |
| language | query | string | False | Filter by language tag |

**Responses:**

- `200`: OK - Quick replies retrieved successfully
- `400`: Bad Request - Invalid pagination parameters
- `401`: Unauthorized - Missing or invalid authentication token
- `404`: Not Found - Business does not exist

---

#### `GET` /api/v1/businesses/{businessId}/quick-replies/{quickReplyId}

**Get quick reply**

Retrieves a specific quick reply by ID for a business.

*Requirement:* WA-BUS-003

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| businessId | path | string | True | Business ID |
| quickReplyId | path | string | True | Quick reply ID |

**Responses:**

- `200`: OK - Quick reply retrieved successfully
- `401`: Unauthorized - Missing or invalid authentication token
- `404`: Not Found - Business or quick reply does not exist

---

#### `PUT` /api/v1/businesses/{businessId}/quick-replies/{quickReplyId}

**Update quick reply**

Updates a predefined quick reply for a business.

*Requirement:* WA-BUS-003

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| businessId | path | string | True | Business ID |
| quickReplyId | path | string | True | Quick reply ID |

**Request Body:** `UpdateQuickReplyRequest`

**Responses:**

- `200`: OK - Quick reply updated successfully
- `400`: Bad Request - Invalid fields in request body
- `401`: Unauthorized - Missing or invalid authentication token
- `404`: Not Found - Business or quick reply does not exist
- `409`: Conflict - Quick reply with same title already exists

---

#### `DELETE` /api/v1/businesses/{businessId}/quick-replies/{quickReplyId}

**Delete quick reply**

Deletes a predefined quick reply for a business.

*Requirement:* WA-BUS-003

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| businessId | path | string | True | Business ID |
| quickReplyId | path | string | True | Quick reply ID |

**Responses:**

- `200`: OK - Quick reply deleted successfully
- `401`: Unauthorized - Missing or invalid authentication token
- `404`: Not Found - Business or quick reply does not exist

---

### RSVPs

#### `POST` /api/v1/groups/{groupId}/events/{eventId}/rsvps

**RSVP to a group event**

Create or update the current user's RSVP status for a group event.

*Requirement:* WA-GRP-009

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| groupId | path | string | True | Group ID |
| eventId | path | string | True | Event ID |

**Request Body:** `RsvpGroupEventRequest`

**Responses:**

- `201`: Created - RSVP recorded successfully
- `400`: Bad Request - Invalid RSVP status
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - User lacks permission to RSVP
- `404`: Not Found - Event or group does not exist
- `409`: Conflict - Event is at participant capacity

---

### Reactions

#### `POST` /api/v1/messages/{messageId}/reactions

**Add an emoji reaction to a message**

Creates an emoji reaction for the specified message. Reaction payload should be end-to-end encrypted as per Signal Protocol client-side before submission.

*Requirement:* WA-MSG-007

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| messageId | path | string | True | Message ID to react to |

**Request Body:** `CreateReactionRequest`

**Responses:**

- `201`: Created - Reaction added
- `400`: Bad Request - Invalid emoji or missing required fields
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Message does not exist
- `409`: Conflict - Reaction already exists for this user

---

#### `GET` /api/v1/messages/{messageId}/reactions

**List emoji reactions for a message**

Returns a paginated list of emoji reactions for the specified message.

*Requirement:* WA-MSG-007

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| messageId | path | string | True | Message ID to fetch reactions for |
| page | query | integer | True | Page number |
| pageSize | query | integer | True | Number of items per page |

**Request Body:** `ListReactionsRequest`

**Responses:**

- `200`: OK - Reactions retrieved
- `400`: Bad Request - Invalid pagination parameters
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Message does not exist

---

#### `DELETE` /api/v1/messages/{messageId}/reactions/{reactionId}

**Remove an emoji reaction from a message**

Deletes a previously added reaction. The caller must be the owner of the reaction.

*Requirement:* WA-MSG-007

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| messageId | path | string | True | Message ID |
| reactionId | path | string | True | Reaction ID to remove |

**Request Body:** `DeleteReactionRequest`

**Responses:**

- `200`: OK - Reaction removed
- `400`: Bad Request - Invalid identifiers
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - Not allowed to delete this reaction
- `404`: Not Found - Reaction or message does not exist

---

### ReadReceipts

#### `GET` /api/v1/users/{userId}/settings/read-receipts

**Get read receipt settings**

Retrieves the current read receipt configuration for a user, including global and per-conversation overrides.

*Requirement:* WA-SET-002

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Request Body:** `GetReadReceiptSettingsRequest`

**Responses:**

- `200`: OK - Read receipt settings returned
- `401`: Unauthorized - Missing or invalid access token
- `403`: Forbidden - Access to user settings denied
- `404`: Not Found - User or settings not found
- `500`: Internal Server Error - Failed to retrieve settings

---

#### `PUT` /api/v1/users/{userId}/settings/read-receipts

**Update read receipt settings**

Updates the user's read receipt configuration, including global and per-conversation overrides.

*Requirement:* WA-SET-002

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Request Body:** `UpdateReadReceiptSettingsRequest`

**Responses:**

- `200`: OK - Read receipt settings updated
- `400`: Bad Request - Invalid settings payload
- `401`: Unauthorized - Missing or invalid access token
- `403`: Forbidden - Access to user settings denied
- `404`: Not Found - User or settings not found
- `409`: Conflict - Settings update conflict detected
- `500`: Internal Server Error - Failed to update settings

---

### RegionalFormats

#### `GET` /api/v1/regional-formats

**List supported regional formats**

Retrieves a paginated list of supported regional formats (locales) including date, time, number, and timezone patterns to allow clients to render content according to regional conventions.

*Requirement:* WA-LOC-002

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| page | query | integer | True | Page number for pagination |
| pageSize | query | integer | True | Number of items per page |

**Request Body:** `ListRegionalFormatsRequest`

**Responses:**

- `200`: OK - Supported regional formats retrieved successfully
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - Insufficient permissions to view regional formats
- `500`: Internal Server Error - Failed to retrieve regional formats

---

#### `GET` /api/v1/users/{userId}/regional-formats

**Get user regional format preferences**

Retrieves the user's regional format preferences to ensure dates, times, numbers, and timezones are rendered according to the user's locale.

*Requirement:* WA-LOC-002

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Request Body:** `GetUserRegionalFormatsRequest`

**Responses:**

- `200`: OK - User regional formats retrieved successfully
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - Cannot access another user's preferences
- `404`: Not Found - User or regional formats not found
- `500`: Internal Server Error - Failed to retrieve user regional formats

---

#### `PUT` /api/v1/users/{userId}/regional-formats

**Update user regional format preferences**

Updates the user's regional format preferences to ensure consistent locale-specific rendering across devices (mobile-first).

*Requirement:* WA-LOC-002

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Request Body:** `UpdateUserRegionalFormatsRequest`

**Responses:**

- `200`: OK - User regional formats updated successfully
- `400`: Bad Request - Invalid locale or format pattern
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - Cannot update another user's preferences
- `404`: Not Found - User not found
- `409`: Conflict - Locale not supported
- `500`: Internal Server Error - Failed to update user regional formats

---

### Reports

#### `POST` /api/v1/reports

**Report a message or contact**

Creates a report for a message or contact. Reports are used to flag abusive content or users for review.

*Requirement:* WA-SEC-005

**Request Body:** `CreateReportRequest`

**Responses:**

- `201`: Created - Report submitted successfully
- `400`: Bad Request - Missing or invalid targetType, targetId, or reasonCode
- `401`: Unauthorized - Missing or invalid authentication token
- `404`: Not Found - The specified target does not exist
- `409`: Conflict - Duplicate report for the same target already exists

---

### ScreenShares

#### `POST` /api/v1/calls/{callId}/screen-shares

**Start screen sharing in a call**

Creates a screen sharing session for an ongoing WebRTC call and returns signaling metadata needed by clients. Screen content is transmitted via WebRTC; this endpoint only manages session metadata.

*Requirement:* WA-CALL-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| callId | path | string | True | Call ID |

**Request Body:** `CreateScreenShareRequest`

**Responses:**

- `201`: Created - Screen share session started
- `400`: Bad Request - Missing or invalid SDP offer or encryption context
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - User not allowed to share screen in this call
- `404`: Not Found - Call does not exist or is not active
- `409`: Conflict - Screen sharing already active for this publisher

---

#### `GET` /api/v1/calls/{callId}/screen-shares

**List screen sharing sessions in a call**

Returns active and recent screen sharing sessions for an ongoing call.

*Requirement:* WA-CALL-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| callId | path | string | True | Call ID |
| page | query | integer | True | Page number for pagination |
| pageSize | query | integer | True | Page size for pagination |

**Responses:**

- `200`: OK - Screen share sessions retrieved
- `400`: Bad Request - Invalid pagination parameters
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Call does not exist

---

#### `DELETE` /api/v1/calls/{callId}/screen-shares/{screenShareId}

**Stop screen sharing in a call**

Ends an active screen sharing session in a call.

*Requirement:* WA-CALL-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| callId | path | string | True | Call ID |
| screenShareId | path | string | True | Screen share session ID |

**Request Body:** `EndScreenShareRequest`

**Responses:**

- `200`: OK - Screen share session ended
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - User not allowed to end this screen share
- `404`: Not Found - Screen share session does not exist
- `409`: Conflict - Screen share session already ended

---

### Search

#### `GET` /api/v1/search/chats

**Search chats by keyword**

Searches the user's chats by name, participants, or last message preview. Supports mobile-first pagination.

*Requirement:* WA-SRC-003

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| q | query | string | True | Search query text |
| page | query | integer | True | Page number for pagination |
| pageSize | query | integer | True | Number of items per page |
| type | query | string | False | Filter by chat type (direct|group|broadcast) |

**Request Body:** `SearchChatsRequest`

**Responses:**

- `200`: OK - Search results returned
- `400`: Bad Request - Missing or invalid query parameters
- `401`: Unauthorized - Missing or invalid token
- `429`: Too Many Requests - Rate limit exceeded
- `500`: Internal Server Error - Unexpected failure

---

#### `GET` /api/v1/search/contacts

**Search contacts by keyword**

Searches the user's contacts by name, phone number, or username. Supports mobile-first pagination.

*Requirement:* WA-SRC-003

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| q | query | string | True | Search query text |
| page | query | integer | True | Page number for pagination |
| pageSize | query | integer | True | Number of items per page |

**Request Body:** `SearchContactsRequest`

**Responses:**

- `200`: OK - Search results returned
- `400`: Bad Request - Missing or invalid query parameters
- `401`: Unauthorized - Missing or invalid token
- `429`: Too Many Requests - Rate limit exceeded
- `500`: Internal Server Error - Unexpected failure

---

### Security

#### `POST` /api/v1/users/{userId}/pin

**Enable additional PIN security**

Creates and enables an optional additional PIN for two-step verification for the specified user.

*Requirement:* WA-SEC-006

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Request Body:** `EnablePinRequest`

**Responses:**

- `201`: Created - PIN security enabled
- `400`: Bad Request - PIN does not meet policy requirements
- `401`: Unauthorized - Missing or invalid token
- `409`: Conflict - PIN security already enabled

---

#### `PUT` /api/v1/users/{userId}/pin

**Update additional PIN**

Updates the user's existing PIN for two-step verification.

*Requirement:* WA-SEC-006

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Request Body:** `UpdatePinRequest`

**Responses:**

- `200`: OK - PIN updated
- `400`: Bad Request - New PIN does not meet policy requirements
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - Current PIN is incorrect
- `404`: Not Found - PIN security is not enabled

---

#### `DELETE` /api/v1/users/{userId}/pin

**Disable additional PIN security**

Disables the user's optional additional PIN for two-step verification.

*Requirement:* WA-SEC-006

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Request Body:** `DisablePinRequest`

**Responses:**

- `200`: OK - PIN security disabled
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - PIN is incorrect
- `404`: Not Found - PIN security is not enabled

---

#### `GET` /api/v1/users/{userId}/pin

**Get PIN security status**

Retrieves the current status of optional additional PIN security for the user.

*Requirement:* WA-SEC-006

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Request Body:** `GetPinStatusRequest`

**Responses:**

- `200`: OK - PIN status retrieved
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - User does not exist

---

#### `POST` /api/v1/auth/pin/verify

**Verify PIN during two-step verification**

Verifies the user's PIN as part of the two-step verification flow using a temporary authentication token.

*Requirement:* WA-SEC-006

**Request Body:** `VerifyPinRequest`

**Responses:**

- `200`: OK - PIN verified and access token issued
- `400`: Bad Request - Missing or malformed tempAuthToken
- `401`: Unauthorized - PIN verification failed
- `404`: Not Found - Temporary authentication session not found

---

#### `POST` /api/v1/integrations/keys

**Register encryption keys**

Registers Signal Protocol public keys for end-to-end encryption.

*Requirement:* WA-BUS-010

**Request Body:** `RegisterKeysRequest`

**Responses:**

- `201`: Created - Keys registered
- `400`: Bad Request - Invalid key payload
- `401`: Unauthorized - Missing or invalid token

---

### SecurityCodeVerification

#### `POST` /api/v1/security-code-verifications

**Initiate manual security code verification**

Creates a verification session to manually compare the end-to-end encryption safety code (e.g., numeric or QR) with a contact.

*Requirement:* WA-SEC-002

**Request Body:** `CreateSecurityCodeVerificationRequest`

**Responses:**

- `201`: Created - Verification session started
- `400`: Bad Request - Missing or invalid fields
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - Not allowed to verify this contact
- `409`: Conflict - Active verification already exists for this contact

---

#### `GET` /api/v1/security-code-verifications/{verificationId}

**Get verification session details**

Retrieves the current status and safety code details for a verification session.

*Requirement:* WA-SEC-002

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| verificationId | path | string | True | Verification session ID |

**Request Body:** `GetSecurityCodeVerificationRequest`

**Responses:**

- `200`: OK - Verification session retrieved
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - Not allowed to access this verification
- `404`: Not Found - Verification session does not exist
- `410`: Gone - Verification session has expired

---

#### `POST` /api/v1/security-code-verifications/{verificationId}/confirm

**Confirm verification result**

Submits the result of manual verification (matched or not matched) for a safety code.

*Requirement:* WA-SEC-002

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| verificationId | path | string | True | Verification session ID |

**Request Body:** `ConfirmSecurityCodeVerificationRequest`

**Responses:**

- `200`: OK - Verification status updated
- `400`: Bad Request - Invalid confirmation payload
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - Not allowed to confirm this verification
- `404`: Not Found - Verification session does not exist
- `409`: Conflict - Verification already finalized
- `410`: Gone - Verification session has expired

---

#### `GET` /api/v1/security-code-verifications

**List verification sessions**

Returns a paginated list of security code verification sessions for the authenticated user.

*Requirement:* WA-SEC-002

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| page | query | integer | True | Page number for pagination |
| pageSize | query | integer | True | Number of items per page |
| status | query | string | False | Filter by status |

**Request Body:** `ListSecurityCodeVerificationsRequest`

**Responses:**

- `200`: OK - List retrieved
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - Not allowed to list verifications

---

### ShareExtension

#### `POST` /api/v1/share-extensions

**Create share-extension payload**

Creates a share-extension payload that will be encrypted end-to-end (Signal Protocol) and queued for offline delivery if needed.

*Requirement:* WA-INT-001

**Request Body:** `CreateShareExtensionRequest`

**Responses:**

- `201`: Created - Share payload created
- `400`: Bad Request - Missing or invalid fields
- `401`: Unauthorized - Missing or invalid token
- `409`: Conflict - Target constraints violated (group/broadcast limits)
- `413`: Payload Too Large - Exceeds allowed media size
- `422`: Unprocessable Entity - E2E encryption metadata invalid
- `500`: Internal Server Error - Failed to create share payload

---

#### `POST` /api/v1/share-extensions/{shareId}/attachments

**Upload share-extension media**

Uploads media for a share-extension payload. Enforces max sizes (documents 2GB, images 16MB). Media will be encrypted end-to-end by the client.

*Requirement:* WA-INT-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| shareId | path | string | True | Share payload identifier |

**Request Body:** `ShareExtensionAttachmentUploadRequest`

**Responses:**

- `201`: Created - Attachment uploaded
- `400`: Bad Request - Missing or invalid fields
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Share payload not found
- `413`: Payload Too Large - Exceeds allowed media size
- `415`: Unsupported Media Type - Invalid media type
- `500`: Internal Server Error - Failed to upload attachment

---

#### `POST` /api/v1/share-extensions/{shareId}/dispatch

**Dispatch share-extension payload**

Dispatches the share-extension payload to the target via WebSocket when online or queue when offline.

*Requirement:* WA-INT-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| shareId | path | string | True | Share payload identifier |

**Request Body:** `DispatchShareExtensionRequest`

**Responses:**

- `201`: Created - Dispatch initiated
- `400`: Bad Request - Missing or invalid fields
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Share payload not found
- `409`: Conflict - Share payload already dispatched
- `500`: Internal Server Error - Failed to dispatch share payload

---

#### `GET` /api/v1/share-extensions/targets

**List available share targets**

Returns a paginated list of chats, groups, and broadcast lists available for sharing, respecting membership limits.

*Requirement:* WA-INT-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| page | query | integer | True | Page number |
| pageSize | query | integer | True | Number of items per page |
| type | query | string | False | Filter by target type: chat, group, broadcast |

**Request Body:** `ListShareTargetsRequest`

**Responses:**

- `200`: OK - Share targets retrieved
- `400`: Bad Request - Invalid pagination parameters
- `401`: Unauthorized - Missing or invalid token
- `500`: Internal Server Error - Failed to retrieve targets

---

### Signaling

#### `POST` /api/v1/calls/{callId}/signaling/messages

**Post WebRTC signaling message**

Posts encrypted WebRTC signaling messages (offer/answer/ICE) to support offline queueing and delivery via WebSocket.

*Requirement:* WA-CALL-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| callId | path | string | True | Call ID |

**Request Body:** `SignalingMessageRequest`

**Responses:**

- `201`: Created - Signaling message stored
- `400`: Bad Request - Unsupported signaling type
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Call does not exist

---

#### `GET` /api/v1/calls/{callId}/signaling/messages

**Fetch queued signaling messages**

Fetches queued encrypted signaling messages for offline clients.

*Requirement:* WA-CALL-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| callId | path | string | True | Call ID |
| page | query | integer | True | Page number |
| pageSize | query | integer | True | Number of items per page |

**Request Body:** `ListSignalingMessagesRequest`

**Responses:**

- `200`: OK - Queued signaling messages returned
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Call does not exist

---

### SmartReplies

#### `POST` /api/v1/conversations/{conversationId}/smart-replies

**Generate smart reply suggestions**

Generiert intelligente Antwortvorschlaege fuer eine Unterhaltung unter Beruecksichtigung der Ende-zu-Ende-Verschluesselung. Der Client uebermittelt verschluesselten Kontext; der Server liefert verschluesselte Vorschlaege zur Rueckgabe an den Client.

*Requirement:* WA-AI-002

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| conversationId | path | string | True | Eindeutige ID der Unterhaltung |

**Request Body:** `CreateSmartRepliesRequest`

**Responses:**

- `201`: Created - Smart reply suggestions generated
- `400`: Bad Request - Missing or invalid encrypted context
- `401`: Unauthorized - Missing or invalid access token
- `404`: Not Found - Conversation does not exist
- `422`: Unprocessable Entity - Context format not supported
- `429`: Too Many Requests - Rate limit exceeded for smart reply generation
- `500`: Internal Server Error - Smart reply generation failed

---

### SpamDetection

#### `POST` /api/v1/spam-checks

**Create a spam detection job**

Submits encrypted message metadata and content fingerprints for asynchronous spam analysis compatible with end-to-end encryption.

*Requirement:* WA-SEC-007

**Request Body:** `CreateSpamCheckRequest`

**Responses:**

- `201`: Created - Spam check job created
- `400`: Bad Request - Missing required fields or invalid metadata
- `401`: Unauthorized - Missing or invalid token
- `409`: Conflict - Duplicate spam check for messageId

---

#### `GET` /api/v1/spam-checks/{spamCheckId}

**Get spam detection result**

Retrieves the spam detection result for a previously submitted message.

*Requirement:* WA-SEC-007

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| spamCheckId | path | string | True | Spam check job ID |

**Request Body:** `GetSpamCheckRequest`

**Responses:**

- `200`: OK - Spam check result returned
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Spam check ID does not exist
- `410`: Gone - Spam check result expired

---

### Startup

#### `GET` /api/v1/startup-resources

**Fetch startup resources for fast app launch**

Returns a compact bootstrap payload required for a fast app start, including configuration, limits, and endpoints needed to initialize the app quickly. Supports delta updates via a sync token to minimize payload size.

*Requirement:* WA-PERF-002

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| syncToken | query | string | False | Token for fetching only changes since the last startup sync |
| locale | query | string | False | Client locale for localized configuration values |

**Request Body:** `GetStartupResourcesRequest`

**Responses:**

- `200`: OK - Startup resources returned successfully
- `400`: Bad Request - Invalid query parameters
- `401`: Unauthorized - Missing or invalid token
- `429`: Too Many Requests - Rate limit exceeded
- `500`: Internal Server Error - Unexpected error while preparing startup resources

---

### Status

#### `GET` /api/v1/contacts/{contactId}/status

**Get contact status**

Retrieves the current status of a specific contact, including text and media references. Status entries are valid for a maximum of 24 hours.

*Requirement:* WA-STS-002

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| contactId | path | string | True | Contact ID |

**Responses:**

- `200`: OK - Contact status retrieved successfully
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Contact or status not found
- `410`: Gone - Status has expired
- `500`: Internal Server Error - Unable to retrieve status

---

#### `GET` /api/v1/contacts/statuses

**List contact statuses**

Retrieves a paginated list of statuses for all contacts available to the user. Only non-expired statuses (max 24 hours) are returned.

*Requirement:* WA-STS-002

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| page | query | integer | True | Page number for pagination |
| pageSize | query | integer | True | Number of items per page |

**Responses:**

- `200`: OK - Contact statuses retrieved successfully
- `400`: Bad Request - Invalid pagination parameters
- `401`: Unauthorized - Missing or invalid token
- `500`: Internal Server Error - Unable to retrieve statuses

---

### StatusMutes

#### `POST` /api/v1/status-mutes

**Mute a contact's status**

Creates a mute setting to silence a specific contact's status updates for the requesting user.

*Requirement:* WA-STS-005

**Request Body:** `CreateStatusMuteRequest`

**Responses:**

- `201`: Created - Status mute successfully created
- `400`: Bad Request - Missing or invalid contactId or muteUntil
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Contact does not exist
- `409`: Conflict - Status mute already exists for this contact

---

#### `GET` /api/v1/status-mutes

**List muted status contacts**

Returns a paginated list of status mutes for the requesting user.

*Requirement:* WA-STS-005

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| page | query | integer | True | Page number for pagination |
| pageSize | query | integer | True | Number of items per page |

**Request Body:** `ListStatusMutesRequest`

**Responses:**

- `200`: OK - Status mutes retrieved
- `400`: Bad Request - Invalid pagination parameters
- `401`: Unauthorized - Missing or invalid token

---

#### `DELETE` /api/v1/status-mutes/{contactId}

**Unmute a contact's status**

Deletes the mute setting for a specific contact's status.

*Requirement:* WA-STS-005

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| contactId | path | string | True | ID of the contact to unmute |

**Request Body:** `DeleteStatusMuteRequest`

**Responses:**

- `200`: OK - Status mute deleted
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Status mute does not exist for this contact

---

### StatusReplies

#### `POST` /api/v1/statuses/{statusId}/replies

**Create a reply to a status**

Creates an end-to-end encrypted reply to a specific status. The reply is queued for offline delivery and can include optional media within size limits.

*Requirement:* WA-STS-003

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| statusId | path | string | True | ID of the status being replied to |

**Request Body:** `CreateStatusReplyRequest`

**Responses:**

- `201`: Created - Reply accepted for delivery
- `400`: Bad Request - Missing or invalid ciphertext or media metadata
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Status does not exist or expired (24h limit)
- `413`: Payload Too Large - Media size exceeds limits
- `422`: Unprocessable Entity - Media type not supported

---

#### `GET` /api/v1/statuses/{statusId}/replies

**List replies to a status**

Returns a paginated list of encrypted replies for a specific status.

*Requirement:* WA-STS-003

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| statusId | path | string | True | ID of the status |
| page | query | integer | True | Page number |
| pageSize | query | integer | True | Number of items per page |

**Responses:**

- `200`: OK - Replies retrieved
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Status does not exist or expired (24h limit)

---

#### `DELETE` /api/v1/statuses/{statusId}/replies/{replyId}

**Delete a reply to a status**

Deletes a reply authored by the requesting user.

*Requirement:* WA-STS-003

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| statusId | path | string | True | ID of the status |
| replyId | path | string | True | ID of the reply |

**Responses:**

- `200`: OK - Reply deleted
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - Not allowed to delete this reply
- `404`: Not Found - Reply does not exist

---

### StatusVisibility

#### `GET` /api/v1/users/{userId}/status-visibility-settings

**Get status visibility settings**

Retrieves the current user's configurable status visibility settings used to control who can view status updates.

*Requirement:* WA-STS-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Request Body:** `GetStatusVisibilitySettingsRequest`

**Responses:**

- `200`: OK - Settings retrieved
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - Access to settings denied
- `404`: Not Found - User or settings not found

---

#### `PUT` /api/v1/users/{userId}/status-visibility-settings

**Update status visibility settings**

Updates the user's configurable status visibility settings to control who can view status updates.

*Requirement:* WA-STS-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Request Body:** `UpdateStatusVisibilitySettingsRequest`

**Responses:**

- `200`: OK - Settings updated
- `400`: Bad Request - Invalid visibility mode or contact list
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - Access to settings denied
- `404`: Not Found - User not found
- `409`: Conflict - Visibility settings update conflict

---

### Statuses

#### `POST` /api/v1/statuses

**Create a 24-hour status update**

Creates a new end-to-end encrypted status update that expires after 24 hours. Supports text and/or media metadata; media is referenced via pre-uploaded mediaId. The server enforces maximum media size limits and expiration time.

*Requirement:* WA-STS-001

**Request Body:** `CreateStatusRequest`

**Responses:**

- `201`: Created - Status successfully created
- `400`: Bad Request - Invalid payload, missing required fields, or expiresInSeconds exceeds 86400
- `401`: Unauthorized - Missing or invalid access token
- `413`: Payload Too Large - Media exceeds size limits (16MB images, 2GB documents)
- `422`: Unprocessable Entity - Invalid encrypted payload format
- `500`: Internal Server Error - Failed to create status

---

### StickerPacks

#### `GET` /api/v1/sticker-packs

**List regional sticker packs**

Returns a paginated list of sticker packs available for a specific region or locale, enabling clients to surface region-specific sticker packs.

*Requirement:* WA-LOC-003

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| regionCode | query | string | True | Region or locale code (e.g., DE, AT, CH) used to filter region-specific sticker packs |
| page | query | integer | True | Page number for pagination |
| pageSize | query | integer | True | Number of items per page |

**Responses:**

- `200`: OK - Sticker packs retrieved successfully
- `400`: Bad Request - Invalid pagination or regionCode format
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - No sticker packs available for the specified region
- `500`: Internal Server Error - Unexpected error while retrieving sticker packs

---

#### `GET` /api/v1/sticker-packs/{stickerPackId}

**Get sticker pack details**

Retrieves detailed information about a specific sticker pack, including sticker metadata and asset URLs.

*Requirement:* WA-LOC-003

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| stickerPackId | path | string | True | Sticker pack ID |

**Responses:**

- `200`: OK - Sticker pack retrieved successfully
- `400`: Bad Request - Invalid stickerPackId format
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Sticker pack does not exist
- `500`: Internal Server Error - Unexpected error while retrieving the sticker pack

---

### Stickers

#### `GET` /api/v1/sticker-packs

**List sticker packs**

Retrieve available sticker packs for the authenticated user with pagination for mobile-first clients.

*Requirement:* WA-MED-005

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| page | query | integer | True | Page number for pagination |
| pageSize | query | integer | True | Number of items per page |

**Responses:**

- `200`: OK - Sticker packs retrieved successfully
- `401`: Unauthorized - Missing or invalid token
- `500`: Internal Server Error - Failed to retrieve sticker packs

---

#### `GET` /api/v1/sticker-packs/{packId}/stickers

**List stickers in a pack**

Retrieve stickers within a specific sticker pack with pagination.

*Requirement:* WA-MED-005

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| packId | path | string | True | Sticker pack ID |
| page | query | integer | True | Page number for pagination |
| pageSize | query | integer | True | Number of items per page |

**Responses:**

- `200`: OK - Stickers retrieved successfully
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Sticker pack does not exist
- `500`: Internal Server Error - Failed to retrieve stickers

---

#### `POST` /api/v1/chats/{chatId}/messages

**Send sticker message**

Send a sticker message to a chat. The sticker reference and encrypted payload are required for end-to-end encryption (Signal Protocol). Supports offline queuing via client-generated messageId.

*Requirement:* WA-MED-005

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| chatId | path | string | True | Chat ID |

**Request Body:** `SendStickerMessageRequest`

**Responses:**

- `201`: Created - Sticker message sent
- `400`: Bad Request - Missing or invalid sticker data
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Chat or sticker not found
- `409`: Conflict - Duplicate messageId already processed
- `413`: Payload Too Large - Encrypted payload exceeds limits
- `500`: Internal Server Error - Failed to send sticker message

---

#### `POST` /api/v1/sticker-suggestions

**Get context-based sticker suggestions**

Generates sticker suggestions based on encrypted conversational context, message metadata, and optional user input. Designed for mobile-first clients with offline queue support and end-to-end encrypted content.

*Requirement:* WA-AI-003

**Request Body:** `StickerSuggestionsRequest`

**Responses:**

- `200`: OK - Sticker suggestions generated successfully
- `400`: Bad Request - Missing or invalid context parameters
- `401`: Unauthorized - Missing or invalid access token
- `403`: Forbidden - Conversation access not permitted
- `429`: Too Many Requests - Rate limit exceeded for suggestions
- `500`: Internal Server Error - Failed to generate sticker suggestions

---

### Storage

#### `GET` /api/v1/storage/usage

**Get storage usage overview**

Returns aggregated storage usage metrics for the authenticated user, including totals by media type and quota limits.

*Requirement:* WA-SET-006

**Responses:**

- `200`: OK - Storage usage returned
- `401`: Unauthorized - Missing or invalid access token
- `500`: Internal Server Error - Unable to compute storage usage

---

#### `GET` /api/v1/storage/items

**List storage items**

Returns a paginated list of stored items for the authenticated user to manage storage usage.

*Requirement:* WA-SET-006

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| page | query | integer | True | Page number for pagination |
| pageSize | query | integer | True | Number of items per page |
| type | query | string | False | Filter by media type (image, document, video, audio, other) |
| sort | query | string | False | Sort by field (createdAt, sizeBytes) with optional direction (e.g., sizeBytes:desc) |

**Responses:**

- `200`: OK - Storage items returned
- `400`: Bad Request - Invalid pagination parameters
- `401`: Unauthorized - Missing or invalid access token
- `500`: Internal Server Error - Unable to list storage items

---

#### `DELETE` /api/v1/storage/items/{id}

**Delete a storage item**

Deletes a specific storage item to free up space. This action removes the item for the authenticated user.

*Requirement:* WA-SET-006

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| id | path | string | True | Storage item ID |

**Responses:**

- `200`: OK - Storage item deleted
- `401`: Unauthorized - Missing or invalid access token
- `404`: Not Found - Storage item does not exist
- `409`: Conflict - Storage item cannot be deleted due to active references
- `500`: Internal Server Error - Unable to delete storage item

---

#### `POST` /api/v1/storage/purge

**Purge storage items by criteria**

Deletes multiple storage items based on criteria such as type and age to manage storage usage.

*Requirement:* WA-SET-006

**Request Body:** `PurgeStorageItemsRequest`

**Responses:**

- `201`: Created - Purge operation executed
- `400`: Bad Request - Invalid purge criteria
- `401`: Unauthorized - Missing or invalid access token
- `500`: Internal Server Error - Unable to execute purge

---

#### `GET` /api/v1/storage/usage

**Retrieve storage usage metrics**

Returns per-scope storage usage and quotas to enable storage-efficient behavior on mobile clients.

*Requirement:* WA-PERF-005

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| scope | query | string | False | Usage scope filter: user|device|group |
| page | query | integer | False | Page number for paginated results |
| pageSize | query | integer | False | Number of items per page |

**Responses:**

- `200`: OK - Storage usage returned successfully
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - Insufficient permissions to view usage
- `500`: Internal Server Error - Failed to retrieve usage metrics

---

#### `POST` /api/v1/storage/cleanup

**Trigger storage cleanup**

Initiates server-side cleanup of expired, redundant, or cached data to improve storage efficiency.

*Requirement:* WA-PERF-005

**Request Body:** `StorageCleanupRequest`

**Responses:**

- `201`: Created - Cleanup job accepted
- `400`: Bad Request - Invalid cleanup parameters
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - Insufficient permissions to trigger cleanup
- `409`: Conflict - Cleanup already running for this scope
- `500`: Internal Server Error - Failed to schedule cleanup

---

#### `PUT` /api/v1/storage/retention-policy

**Update retention policy**

Configures retention and lifecycle policies to minimize storage usage, including maximum status duration and media retention.

*Requirement:* WA-PERF-005

**Request Body:** `RetentionPolicyRequest`

**Responses:**

- `200`: OK - Retention policy updated
- `400`: Bad Request - Invalid retention parameters
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - Insufficient permissions to update policy
- `409`: Conflict - Retention policy violates system constraints
- `500`: Internal Server Error - Failed to update retention policy

---

### System

#### `GET` /api/v1/health

**Health check**

Public health check endpoint for integration monitoring.

*Requirement:* WA-BUS-010

**Request Body:** `HealthCheckRequest`

**Responses:**

- `200`: OK - Service is healthy
- `503`: Service Unavailable - System is not ready

---

### Transcriptions

#### `POST` /api/v1/voice-messages/{voiceMessageId}/transcriptions

**Create transcription for a voice message**

Creates a transcription job for the specified voice message and returns the transcription resource in processing state.

*Requirement:* WA-ACC-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| voiceMessageId | path | string | True | Voice message ID to transcribe |

**Request Body:** `CreateTranscriptionRequest`

**Responses:**

- `201`: Created - Transcription job created
- `400`: Bad Request - Invalid voiceMessageId or parameters
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - Not allowed to access this voice message
- `404`: Not Found - Voice message does not exist
- `409`: Conflict - Transcription already exists for this voice message
- `422`: Unprocessable Entity - Audio cannot be transcribed
- `500`: Internal Server Error - Failed to create transcription job

---

#### `GET` /api/v1/transcriptions/{transcriptionId}

**Get transcription by ID**

Returns the transcription resource including status and text when available.

*Requirement:* WA-ACC-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| transcriptionId | path | string | True | Transcription ID |

**Request Body:** `GetTranscriptionRequest`

**Responses:**

- `200`: OK - Transcription retrieved
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - Not allowed to access this transcription
- `404`: Not Found - Transcription does not exist
- `500`: Internal Server Error - Failed to retrieve transcription

---

#### `GET` /api/v1/voice-messages/{voiceMessageId}/transcriptions

**List transcriptions for a voice message**

Returns a paginated list of transcriptions for the specified voice message.

*Requirement:* WA-ACC-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| voiceMessageId | path | string | True | Voice message ID |
| page | query | integer | True | Page number for pagination |
| pageSize | query | integer | True | Number of items per page |

**Request Body:** `ListTranscriptionsRequest`

**Responses:**

- `200`: OK - Transcription list retrieved
- `400`: Bad Request - Invalid pagination parameters
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - Not allowed to access this voice message
- `404`: Not Found - Voice message does not exist
- `500`: Internal Server Error - Failed to list transcriptions

---

### TwoFactorAuth

#### `POST` /api/v1/users/{userId}/2fa

**Enable 2FA with 6-digit PIN**

Enables optional two-factor authentication for the user by setting a 6-digit PIN.

*Requirement:* WA-AUTH-002

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Request Body:** `EnableTwoFactorRequest`

**Responses:**

- `201`: Created - 2FA enabled
- `400`: Bad Request - PIN must be exactly 6 digits
- `401`: Unauthorized - Missing or invalid access token
- `409`: Conflict - 2FA already enabled for user

---

#### `DELETE` /api/v1/users/{userId}/2fa

**Disable 2FA**

Disables optional two-factor authentication for the user.

*Requirement:* WA-AUTH-002

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Request Body:** `DisableTwoFactorRequest`

**Responses:**

- `200`: OK - 2FA disabled
- `400`: Bad Request - PIN must be exactly 6 digits
- `401`: Unauthorized - Missing or invalid access token
- `403`: Forbidden - PIN verification failed
- `404`: Not Found - User or 2FA configuration not found

---

#### `POST` /api/v1/auth/2fa/verify

**Verify 2FA PIN during authentication**

Verifies the 6-digit PIN for users with 2FA enabled during login.

*Requirement:* WA-AUTH-002

**Request Body:** `VerifyTwoFactorRequest`

**Responses:**

- `200`: OK - 2FA verified
- `400`: Bad Request - PIN must be exactly 6 digits
- `401`: Unauthorized - Invalid login session
- `403`: Forbidden - PIN verification failed
- `404`: Not Found - User or 2FA configuration not found

---

#### `GET` /api/v1/users/{userId}/2fa

**Get 2FA status**

Returns whether two-factor authentication is enabled for the user.

*Requirement:* WA-AUTH-002

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Request Body:** `GetTwoFactorStatusRequest`

**Responses:**

- `200`: OK - 2FA status returned
- `401`: Unauthorized - Missing or invalid access token
- `404`: Not Found - User not found

---

### UnknownSenders

#### `GET` /api/v1/unknown-senders

**List unknown senders**

Returns a paginated list of senders not in the user's contacts that have pending messages.

*Requirement:* WA-CON-005

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| page | query | integer | True | Page number for pagination |
| pageSize | query | integer | True | Number of items per page |

**Request Body:** `ListUnknownSendersRequest`

**Responses:**

- `200`: OK - List of unknown senders returned
- `400`: Bad Request - Invalid pagination parameters
- `401`: Unauthorized - Missing or invalid token
- `500`: Internal Server Error - Failed to retrieve unknown senders

---

#### `GET` /api/v1/unknown-senders/{senderId}

**Get unknown sender details**

Retrieves detailed information about a specific unknown sender and their pending message status.

*Requirement:* WA-CON-005

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| senderId | path | string | True | Sender ID |

**Request Body:** `GetUnknownSenderRequest`

**Responses:**

- `200`: OK - Unknown sender details returned
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Unknown sender does not exist
- `500`: Internal Server Error - Failed to retrieve sender details

---

#### `GET` /api/v1/unknown-senders/{senderId}/messages

**List messages from an unknown sender**

Returns a paginated list of pending messages from a specific unknown sender.

*Requirement:* WA-CON-005

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| senderId | path | string | True | Sender ID |
| page | query | integer | True | Page number for pagination |
| pageSize | query | integer | True | Number of items per page |

**Request Body:** `ListUnknownSenderMessagesRequest`

**Responses:**

- `200`: OK - List of pending messages returned
- `400`: Bad Request - Invalid pagination parameters
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Unknown sender does not exist
- `500`: Internal Server Error - Failed to retrieve messages

---

#### `POST` /api/v1/unknown-senders/{senderId}/actions

**Handle unknown sender**

Approves or blocks an unknown sender. Approval moves the sender to known contacts and releases pending messages. Blocking prevents future messages.

*Requirement:* WA-CON-005

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| senderId | path | string | True | Sender ID |

**Request Body:** `HandleUnknownSenderRequest`

**Responses:**

- `201`: Created - Action processed successfully
- `400`: Bad Request - Invalid action value
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Unknown sender does not exist
- `409`: Conflict - Sender already handled with the same action
- `500`: Internal Server Error - Failed to process action

---

### UserPowerSettings

#### `GET` /api/v1/users/{userId}/power-settings

**Get user battery settings**

Returns the user's battery efficiency preferences to minimize background activity and data usage.

*Requirement:* WA-PERF-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Responses:**

- `200`: OK - User power settings retrieved successfully
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - User does not exist

---

#### `PUT` /api/v1/users/{userId}/power-settings

**Update user battery settings**

Updates the user's battery efficiency preferences to control background activity and data usage.

*Requirement:* WA-PERF-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Request Body:** `UpdateUserPowerSettingsRequest`

**Responses:**

- `200`: OK - User power settings updated successfully
- `400`: Bad Request - Invalid settings payload
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - User does not exist

---

### UserPreferences

#### `GET` /api/v1/users/{id}/preferences/theme

**Get user theme preference**

Retrieves the user's theme preference including dark mode setting.

*Requirement:* WA-SET-009

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| id | path | string | True | User ID |

**Request Body:** `GetThemePreferenceRequest`

**Responses:**

- `200`: OK - Theme preference retrieved
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - Access to user preferences denied
- `404`: Not Found - User or preference not found
- `500`: Internal Server Error - Failed to retrieve preference

---

#### `PUT` /api/v1/users/{id}/preferences/theme

**Update user theme preference**

Updates the user's theme preference to enable dark mode or other theme options.

*Requirement:* WA-SET-009

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| id | path | string | True | User ID |

**Request Body:** `UpdateThemePreferenceRequest`

**Responses:**

- `200`: OK - Theme preference updated
- `400`: Bad Request - Invalid theme value
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - Access to user preferences denied
- `404`: Not Found - User not found
- `409`: Conflict - Preference update conflict
- `500`: Internal Server Error - Failed to update preference

---

#### `GET` /api/v1/users/{userId}/preferences/typography

**Get user typography preferences**

Retrieves the current font size settings for the specified user to support adjustable text sizes across the app.

*Requirement:* WA-ACC-002

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Responses:**

- `200`: OK - Typography preferences retrieved
- `401`: Unauthorized - Missing or invalid authentication token
- `404`: Not Found - User or preferences not found
- `500`: Internal Server Error - Failed to retrieve preferences

---

#### `PUT` /api/v1/users/{userId}/preferences/typography

**Update user typography preferences**

Updates the user's font size settings to support adjustable text sizes across the app.

*Requirement:* WA-ACC-002

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Request Body:** `UpdateTypographyPreferencesRequest`

**Responses:**

- `200`: OK - Typography preferences updated
- `400`: Bad Request - Invalid fontScale or preset value
- `401`: Unauthorized - Missing or invalid authentication token
- `404`: Not Found - User not found
- `500`: Internal Server Error - Failed to update preferences

---

#### `GET` /api/v1/users/{userId}/regional-formats

**Get user regional format preferences**

Retrieves the user's regional format preferences to ensure dates, times, numbers, and timezones are rendered according to the user's locale.

*Requirement:* WA-LOC-002

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Request Body:** `GetUserRegionalFormatsRequest`

**Responses:**

- `200`: OK - User regional formats retrieved successfully
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - Cannot access another user's preferences
- `404`: Not Found - User or regional formats not found
- `500`: Internal Server Error - Failed to retrieve user regional formats

---

#### `PUT` /api/v1/users/{userId}/regional-formats

**Update user regional format preferences**

Updates the user's regional format preferences to ensure consistent locale-specific rendering across devices (mobile-first).

*Requirement:* WA-LOC-002

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Request Body:** `UpdateUserRegionalFormatsRequest`

**Responses:**

- `200`: OK - User regional formats updated successfully
- `400`: Bad Request - Invalid locale or format pattern
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - Cannot update another user's preferences
- `404`: Not Found - User not found
- `409`: Conflict - Locale not supported
- `500`: Internal Server Error - Failed to update user regional formats

---

### UserSettings

#### `GET` /api/v1/users/{userId}/settings/read-receipts

**Get read receipt settings**

Retrieves the current read receipt configuration for a user, including global and per-conversation overrides.

*Requirement:* WA-SET-002

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Request Body:** `GetReadReceiptSettingsRequest`

**Responses:**

- `200`: OK - Read receipt settings returned
- `401`: Unauthorized - Missing or invalid access token
- `403`: Forbidden - Access to user settings denied
- `404`: Not Found - User or settings not found
- `500`: Internal Server Error - Failed to retrieve settings

---

#### `PUT` /api/v1/users/{userId}/settings/read-receipts

**Update read receipt settings**

Updates the user's read receipt configuration, including global and per-conversation overrides.

*Requirement:* WA-SET-002

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Request Body:** `UpdateReadReceiptSettingsRequest`

**Responses:**

- `200`: OK - Read receipt settings updated
- `400`: Bad Request - Invalid settings payload
- `401`: Unauthorized - Missing or invalid access token
- `403`: Forbidden - Access to user settings denied
- `404`: Not Found - User or settings not found
- `409`: Conflict - Settings update conflict detected
- `500`: Internal Server Error - Failed to update settings

---

#### `GET` /api/v1/users/{userId}/settings/profile-picture-visibility

**Get profile picture visibility setting**

Returns the current profile picture visibility configuration for the specified user.

*Requirement:* WA-SET-003

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Responses:**

- `200`: OK - Visibility setting returned
- `401`: Unauthorized - Missing or invalid access token
- `403`: Forbidden - Not allowed to access this user's settings
- `404`: Not Found - User does not exist

---

#### `PUT` /api/v1/users/{userId}/settings/profile-picture-visibility

**Update profile picture visibility setting**

Updates the profile picture visibility configuration for the specified user.

*Requirement:* WA-SET-003

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Request Body:** `UpdateProfilePictureVisibilityRequest`

**Responses:**

- `200`: OK - Visibility setting updated
- `400`: Bad Request - Visibility value is invalid
- `401`: Unauthorized - Missing or invalid access token
- `403`: Forbidden - Not allowed to update this user's settings
- `404`: Not Found - User does not exist
- `409`: Conflict - Settings update conflict detected

---

#### `GET` /api/v1/users/me/chat-background

**Get user default chat background**

Returns the current default chat background for the authenticated user.

*Requirement:* WA-SET-008

**Request Body:** `GetUserChatBackgroundRequest`

**Responses:**

- `200`: OK - User chat background returned
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - No background configured
- `500`: Internal Server Error - Failed to retrieve user background

---

#### `PUT` /api/v1/users/me/chat-background

**Set user default chat background**

Sets the default chat background for the authenticated user.

*Requirement:* WA-SET-008

**Request Body:** `UpdateUserChatBackgroundRequest`

**Responses:**

- `200`: OK - User chat background updated
- `400`: Bad Request - Invalid background ID
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Background does not exist
- `500`: Internal Server Error - Failed to update user background

---

### Users

#### `POST` /api/v1/users/{userId}/2fa

**Enable 2FA with 6-digit PIN**

Enables optional two-factor authentication for the user by setting a 6-digit PIN.

*Requirement:* WA-AUTH-002

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Request Body:** `EnableTwoFactorRequest`

**Responses:**

- `201`: Created - 2FA enabled
- `400`: Bad Request - PIN must be exactly 6 digits
- `401`: Unauthorized - Missing or invalid access token
- `409`: Conflict - 2FA already enabled for user

---

#### `DELETE` /api/v1/users/{userId}/2fa

**Disable 2FA**

Disables optional two-factor authentication for the user.

*Requirement:* WA-AUTH-002

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Request Body:** `DisableTwoFactorRequest`

**Responses:**

- `200`: OK - 2FA disabled
- `400`: Bad Request - PIN must be exactly 6 digits
- `401`: Unauthorized - Missing or invalid access token
- `403`: Forbidden - PIN verification failed
- `404`: Not Found - User or 2FA configuration not found

---

#### `GET` /api/v1/users/{userId}/2fa

**Get 2FA status**

Returns whether two-factor authentication is enabled for the user.

*Requirement:* WA-AUTH-002

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Request Body:** `GetTwoFactorStatusRequest`

**Responses:**

- `200`: OK - 2FA status returned
- `401`: Unauthorized - Missing or invalid access token
- `404`: Not Found - User not found

---

#### `GET` /api/v1/users/{userId}/passkeys

**List user's passkeys**

Returns the list of registered passkeys for a user.

*Requirement:* WA-AUTH-005

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |
| page | query | integer | True | Page number |
| pageSize | query | integer | True | Number of items per page |

**Request Body:** `ListUserPasskeysRequest`

**Responses:**

- `200`: OK - Passkeys retrieved
- `400`: Bad Request - Invalid pagination parameters
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - User not found
- `500`: Internal Server Error - Failed to retrieve passkeys

---

#### `DELETE` /api/v1/users/{userId}/passkeys/{credentialId}

**Delete a passkey**

Removes a registered passkey credential for the user.

*Requirement:* WA-AUTH-005

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |
| credentialId | path | string | True | Credential ID |

**Request Body:** `DeleteUserPasskeyRequest`

**Responses:**

- `200`: OK - Passkey deleted
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - Not allowed to delete this passkey
- `404`: Not Found - Passkey not found
- `500`: Internal Server Error - Failed to delete passkey

---

#### `GET` /api/v1/users/{userId}/profile

**Get user profile**

Returns the user profile including the configurable display name.

*Requirement:* WA-PROF-002

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | Unique identifier of the user |

**Responses:**

- `200`: OK - Profile retrieved successfully
- `401`: Unauthorized - Missing or invalid access token
- `403`: Forbidden - Insufficient permissions to access this profile
- `404`: Not Found - User does not exist
- `500`: Internal Server Error - Unexpected error while retrieving profile

---

#### `PUT` /api/v1/users/{userId}/profile/display-name

**Update display name**

Updates the configurable display name for a user profile.

*Requirement:* WA-PROF-002

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | Unique identifier of the user |

**Request Body:** `UpdateDisplayNameRequest`

**Responses:**

- `200`: OK - Display name updated successfully
- `400`: Bad Request - Display name is invalid or missing
- `401`: Unauthorized - Missing or invalid access token
- `403`: Forbidden - Insufficient permissions to update this profile
- `404`: Not Found - User does not exist
- `409`: Conflict - Display name update conflicts with current state
- `500`: Internal Server Error - Unexpected error while updating display name

---

#### `GET` /api/v1/users/{userId}/profile

**Get user profile**

Retrieves the user's profile details including the phone number for display in the profile.

*Requirement:* WA-PROF-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | Unique identifier of the user whose profile is requested |

**Request Body:** `GetUserProfileRequest`

**Responses:**

- `200`: OK - Profile retrieved successfully
- `401`: Unauthorized - Missing or invalid access token
- `403`: Forbidden - Access to the requested profile is not permitted
- `404`: Not Found - User profile does not exist
- `500`: Internal Server Error - Unexpected error while retrieving the profile

---

#### `POST` /api/v1/users/{userId}/qr-codes

**Generate a new profile QR code**

Generates a new scannable QR code that encodes a secure, time-bound invite/deeplink for adding the user profile.

*Requirement:* WA-PROF-005

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | Unique user identifier |

**Request Body:** `CreateUserQrCodeRequest`

**Responses:**

- `201`: Created - QR code generated successfully
- `400`: Bad Request - Invalid format, size, or validitySeconds
- `401`: Unauthorized - Missing or invalid access token
- `404`: Not Found - User does not exist
- `429`: Too Many Requests - QR code generation rate limit exceeded
- `500`: Internal Server Error - Unable to generate QR code

---

#### `GET` /api/v1/users/{userId}/qr-codes/{qrCodeId}

**Retrieve a profile QR code**

Retrieves a previously generated QR code for the user profile.

*Requirement:* WA-PROF-005

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | Unique user identifier |
| qrCodeId | path | string | True | Unique QR code identifier |

**Request Body:** `GetUserQrCodeRequest`

**Responses:**

- `200`: OK - QR code retrieved successfully
- `401`: Unauthorized - Missing or invalid access token
- `404`: Not Found - QR code or user does not exist
- `410`: Gone - QR code has expired
- `500`: Internal Server Error - Unable to retrieve QR code

---

#### `POST` /api/v1/users/{userId}/pin

**Enable additional PIN security**

Creates and enables an optional additional PIN for two-step verification for the specified user.

*Requirement:* WA-SEC-006

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Request Body:** `EnablePinRequest`

**Responses:**

- `201`: Created - PIN security enabled
- `400`: Bad Request - PIN does not meet policy requirements
- `401`: Unauthorized - Missing or invalid token
- `409`: Conflict - PIN security already enabled

---

#### `PUT` /api/v1/users/{userId}/pin

**Update additional PIN**

Updates the user's existing PIN for two-step verification.

*Requirement:* WA-SEC-006

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Request Body:** `UpdatePinRequest`

**Responses:**

- `200`: OK - PIN updated
- `400`: Bad Request - New PIN does not meet policy requirements
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - Current PIN is incorrect
- `404`: Not Found - PIN security is not enabled

---

#### `DELETE` /api/v1/users/{userId}/pin

**Disable additional PIN security**

Disables the user's optional additional PIN for two-step verification.

*Requirement:* WA-SEC-006

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Request Body:** `DisablePinRequest`

**Responses:**

- `200`: OK - PIN security disabled
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - PIN is incorrect
- `404`: Not Found - PIN security is not enabled

---

#### `GET` /api/v1/users/{userId}/pin

**Get PIN security status**

Retrieves the current status of optional additional PIN security for the user.

*Requirement:* WA-SEC-006

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Request Body:** `GetPinStatusRequest`

**Responses:**

- `200`: OK - PIN status retrieved
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - User does not exist

---

#### `GET` /api/v1/users/{userId}/privacy/infoVisibility

**Get info/status text visibility settings**

Retrieves the configurable visibility settings for a user's info/status text. These settings control who can see the user's info/status text across the system.

*Requirement:* WA-SET-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Request Body:** `GetInfoVisibilitySettingsRequest`

**Responses:**

- `200`: OK - Settings retrieved successfully
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - Access denied for requested user
- `404`: Not Found - User does not exist

---

#### `PUT` /api/v1/users/{userId}/privacy/infoVisibility

**Update info/status text visibility settings**

Updates the configurable visibility settings for a user's info/status text. Changes are applied immediately across the system.

*Requirement:* WA-SET-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| userId | path | string | True | User ID |

**Request Body:** `UpdateInfoVisibilitySettingsRequest`

**Responses:**

- `200`: OK - Settings updated successfully
- `400`: Bad Request - Invalid visibility value
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - Access denied for requested user
- `404`: Not Found - User does not exist

---

#### `GET` /api/v1/users/me/language

**Get user language preference**

Retrieves the authenticated user's current language preference used for UI and content localization.

*Requirement:* WA-SET-010

**Responses:**

- `200`: OK - User language retrieved successfully
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - User language preference not set
- `500`: Internal Server Error - Failed to retrieve user language

---

#### `PUT` /api/v1/users/me/language

**Update user language preference**

Sets the authenticated user's preferred language used for UI and content localization.

*Requirement:* WA-SET-010

**Request Body:** `UpdateUserLanguageRequest`

**Responses:**

- `200`: OK - User language updated successfully
- `400`: Bad Request - Unsupported language code
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - User not found
- `500`: Internal Server Error - Failed to update user language

---

#### `GET` /api/v1/users/{id}/accessibility-settings

**Get accessibility settings**

Retrieves screenreader and accessibility preferences for a user to ensure full screenreader compatibility across clients.

*Requirement:* WA-ACC-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| id | path | string | True | User ID |

**Request Body:** `GetAccessibilitySettingsRequest`

**Responses:**

- `200`: OK - Accessibility settings retrieved
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - Access to user settings is denied
- `404`: Not Found - User or settings not found
- `500`: Internal Server Error - Failed to retrieve settings

---

#### `PUT` /api/v1/users/{id}/accessibility-settings

**Update accessibility settings**

Updates user screenreader and accessibility preferences to ensure full screenreader compatibility across clients.

*Requirement:* WA-ACC-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| id | path | string | True | User ID |

**Request Body:** `UpdateAccessibilitySettingsRequest`

**Responses:**

- `200`: OK - Accessibility settings updated
- `400`: Bad Request - Invalid accessibility settings payload
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - Access to user settings is denied
- `404`: Not Found - User not found
- `409`: Conflict - Settings update conflict detected
- `500`: Internal Server Error - Failed to update settings

---

#### `GET` /api/v1/users/{id}/accessibility-settings

**Get accessibility settings**

Retrieves the user's accessibility settings including contrast preferences to ensure sufficient color contrast in the UI.

*Requirement:* WA-ACC-003

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| id | path | string | True | User ID |

**Request Body:** `GetUserAccessibilitySettingsRequest`

**Responses:**

- `200`: OK - Accessibility settings returned
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - Access denied to user settings
- `404`: Not Found - User or settings not found
- `500`: Internal Server Error - Failed to retrieve settings

---

#### `PUT` /api/v1/users/{id}/accessibility-settings

**Update accessibility settings**

Updates the user's accessibility settings to enforce sufficient color contrast in the UI.

*Requirement:* WA-ACC-003

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| id | path | string | True | User ID |

**Request Body:** `UpdateUserAccessibilitySettingsRequest`

**Responses:**

- `200`: OK - Accessibility settings updated
- `400`: Bad Request - Invalid contrast mode or ratio
- `401`: Unauthorized - Missing or invalid token
- `403`: Forbidden - Access denied to user settings
- `404`: Not Found - User not found
- `409`: Conflict - Settings update conflict
- `500`: Internal Server Error - Failed to update settings

---

#### `GET` /api/v1/users/{id}/preferences/localization

**Get user localization preferences**

Retrieves the user's localization settings including language and text direction to support full RTL rendering across clients.

*Requirement:* WA-LOC-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| id | path | string | True | User ID |

**Request Body:** `GetUserLocalizationPreferencesRequest`

**Responses:**

- `200`: OK - Preferences retrieved successfully
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - User or preferences not found

---

#### `PUT` /api/v1/users/{id}/preferences/localization

**Update user localization preferences**

Updates the user's localization settings to ensure full RTL language support across mobile and web clients.

*Requirement:* WA-LOC-001

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| id | path | string | True | User ID |

**Request Body:** `UpdateUserLocalizationPreferencesRequest`

**Responses:**

- `200`: OK - Preferences updated successfully
- `400`: Bad Request - Invalid language tag or text direction
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - User not found

---

### VoiceAssistants

#### `GET` /api/v1/voiceAssistants

**List supported voice assistants**

Returns the list of supported voice assistant providers (e.g., Siri, Google Assistant) and their integration status.

*Requirement:* WA-INT-002

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| page | query | integer | True | Page number for pagination |
| pageSize | query | integer | True | Number of items per page |

**Request Body:** `ListVoiceAssistantsRequest`

**Responses:**

- `200`: OK - Providers returned successfully
- `400`: Bad Request - Invalid pagination parameters
- `500`: Internal Server Error - Failed to retrieve providers

---

#### `GET` /api/v1/voiceAssistantLinks

**List linked voice assistant accounts**

Returns the user's linked voice assistant accounts.

*Requirement:* WA-INT-002

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| page | query | integer | True | Page number for pagination |
| pageSize | query | integer | True | Number of items per page |

**Request Body:** `ListVoiceAssistantLinksRequest`

**Responses:**

- `200`: OK - Linked accounts returned successfully
- `400`: Bad Request - Invalid pagination parameters
- `401`: Unauthorized - Missing or invalid token
- `500`: Internal Server Error - Failed to retrieve links

---

#### `POST` /api/v1/voiceAssistantLinks

**Create a voice assistant account link**

Links a user account with a voice assistant provider using OAuth authorization code.

*Requirement:* WA-INT-002

**Request Body:** `CreateVoiceAssistantLinkRequest`

**Responses:**

- `201`: Created - Account linked successfully
- `400`: Bad Request - Invalid provider or authorization code
- `401`: Unauthorized - Missing or invalid token
- `409`: Conflict - Account already linked for provider
- `502`: Bad Gateway - Provider token exchange failed

---

#### `DELETE` /api/v1/voiceAssistantLinks/{linkId}

**Remove a voice assistant account link**

Unlinks the user's account from the specified voice assistant provider.

*Requirement:* WA-INT-002

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| linkId | path | string | True | Unique link identifier |

**Request Body:** `DeleteVoiceAssistantLinkRequest`

**Responses:**

- `200`: OK - Account unlinked successfully
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Link identifier does not exist
- `500`: Internal Server Error - Failed to unlink account

---

#### `POST` /api/v1/voiceAssistantCommands

**Execute a voice assistant command**

Processes a command issued via a voice assistant to perform actions such as send message, start call, or read status.

*Requirement:* WA-INT-002

**Request Body:** `CreateVoiceAssistantCommandRequest`

**Responses:**

- `201`: Created - Command accepted for processing
- `400`: Bad Request - Invalid intent or parameters
- `401`: Unauthorized - Missing or invalid token
- `409`: Conflict - Duplicate clientRequestId
- `503`: Service Unavailable - Command processing unavailable

---

#### `POST` /api/v1/voiceAssistants/{provider}/webhooks

**Receive voice assistant webhook events**

Public webhook endpoint to receive events and intents from the specified voice assistant provider.

*Requirement:* WA-INT-002

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| provider | path | string | True | Voice assistant provider identifier |

**Request Body:** `VoiceAssistantWebhookRequest`

**Responses:**

- `200`: OK - Webhook processed successfully
- `400`: Bad Request - Invalid webhook payload
- `401`: Unauthorized - Invalid or missing signature
- `409`: Conflict - Duplicate eventId
- `500`: Internal Server Error - Webhook processing failed

---

### WatchDevices

#### `POST` /api/v1/watch-devices

**Register smartwatch device**

Registers a smartwatch for a user and establishes an encrypted integration context for mobile-first clients.

*Requirement:* WA-INT-004

**Request Body:** `CreateWatchDeviceRequest`

**Responses:**

- `201`: Created - Smartwatch registered
- `400`: Bad Request - Missing or invalid device fields
- `401`: Unauthorized - Missing or invalid token
- `409`: Conflict - Device already registered

---

#### `GET` /api/v1/watch-devices

**List registered smartwatches**

Returns paginated list of smartwatches linked to the user.

*Requirement:* WA-INT-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| page | query | integer | True | Page number |
| pageSize | query | integer | True | Number of items per page |

**Request Body:** `ListWatchDevicesRequest`

**Responses:**

- `200`: OK - List of smartwatches returned
- `401`: Unauthorized - Missing or invalid token

---

#### `POST` /api/v1/watch-devices/{id}/pair

**Pair smartwatch**

Initiates secure pairing using Signal Protocol metadata for end-to-end encryption.

*Requirement:* WA-INT-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| id | path | string | True | Smartwatch device ID |

**Request Body:** `PairWatchDeviceRequest`

**Responses:**

- `201`: Created - Pairing initiated
- `400`: Bad Request - Invalid pairing code or key bundle
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Smartwatch not found
- `409`: Conflict - Device already paired

---

#### `POST` /api/v1/watch-devices/{id}/sync

**Sync smartwatch data**

Synchronizes messages and state with offline queue support for smartwatch integration.

*Requirement:* WA-INT-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| id | path | string | True | Smartwatch device ID |

**Request Body:** `SyncWatchDeviceRequest`

**Responses:**

- `201`: Created - Sync processed
- `400`: Bad Request - Invalid sync payload
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Smartwatch not found
- `409`: Conflict - Sync version mismatch

---

#### `POST` /api/v1/watch-devices/{id}/notifications

**Send notification to smartwatch**

Sends an encrypted notification payload to the smartwatch.

*Requirement:* WA-INT-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| id | path | string | True | Smartwatch device ID |

**Request Body:** `SendWatchNotificationRequest`

**Responses:**

- `201`: Created - Notification queued
- `400`: Bad Request - Invalid encrypted payload
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Smartwatch not found
- `429`: Too Many Requests - Notification rate limit exceeded

---

#### `PUT` /api/v1/watch-devices/{id}/settings

**Update smartwatch settings**

Updates smartwatch integration preferences for notifications and call handling.

*Requirement:* WA-INT-004

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| id | path | string | True | Smartwatch device ID |

**Request Body:** `UpdateWatchDeviceSettingsRequest`

**Responses:**

- `200`: OK - Settings updated
- `400`: Bad Request - Invalid settings payload
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Smartwatch not found

---

### WebClient

#### `GET` /api/v1/web/clients/config

**Get web client configuration**

Returns configuration required for the web version including feature flags and limits for groups, broadcasts, media sizes, and status duration.

*Requirement:* WA-INT-006

**Responses:**

- `200`: OK - Configuration returned
- `401`: Unauthorized - Missing or invalid token
- `503`: Service Unavailable - Configuration service unavailable

---

### WebRTC

#### `POST` /api/v1/web/sessions/{sessionId}/webrtc-tokens

**Issue WebRTC credentials**

Issues TURN/STUN credentials required to establish WebRTC voice/video calls.

*Requirement:* WA-INT-006

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| sessionId | path | string | True | Web session ID |

**Request Body:** `CreateWebRtcTokenRequest`

**Responses:**

- `201`: Created - WebRTC credentials issued
- `400`: Bad Request - Invalid call type
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Session does not exist

---

### WebSession

#### `POST` /api/v1/web/sessions

**Create a web session**

Creates a web session for the authenticated user to use the web version on a specific browser/device.

*Requirement:* WA-INT-006

**Request Body:** `CreateWebSessionRequest`

**Responses:**

- `201`: Created - Web session created
- `400`: Bad Request - Invalid session parameters
- `401`: Unauthorized - Missing or invalid token
- `409`: Conflict - Session already exists

---

#### `POST` /api/v1/web/sessions/{sessionId}/websocket-tokens

**Issue WebSocket token**

Issues a short-lived token for establishing an authenticated WebSocket connection for real-time communication.

*Requirement:* WA-INT-006

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| sessionId | path | string | True | Web session ID |

**Request Body:** `CreateWebSocketTokenRequest`

**Responses:**

- `201`: Created - WebSocket token issued
- `400`: Bad Request - Invalid nonce
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Session does not exist

---

#### `POST` /api/v1/web/sessions/{sessionId}/webrtc-tokens

**Issue WebRTC credentials**

Issues TURN/STUN credentials required to establish WebRTC voice/video calls.

*Requirement:* WA-INT-006

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| sessionId | path | string | True | Web session ID |

**Request Body:** `CreateWebRtcTokenRequest`

**Responses:**

- `201`: Created - WebRTC credentials issued
- `400`: Bad Request - Invalid call type
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Session does not exist

---

### WebSocket

#### `POST` /api/v1/web/sessions/{sessionId}/websocket-tokens

**Issue WebSocket token**

Issues a short-lived token for establishing an authenticated WebSocket connection for real-time communication.

*Requirement:* WA-INT-006

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| sessionId | path | string | True | Web session ID |

**Request Body:** `CreateWebSocketTokenRequest`

**Responses:**

- `201`: Created - WebSocket token issued
- `400`: Bad Request - Invalid nonce
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Session does not exist

---

### Webhooks

#### `POST` /api/v1/integrations/webhooks

**Register webhook**

Registers webhook endpoints for real-time events (e.g., message status, delivery).

*Requirement:* WA-BUS-010

**Request Body:** `RegisterWebhookRequest`

**Responses:**

- `201`: Created - Webhook registered
- `400`: Bad Request - Invalid URL or events
- `401`: Unauthorized - Missing or invalid token
- `409`: Conflict - Webhook already exists

---

#### `GET` /api/v1/integrations/webhooks

**List webhooks**

Retrieves paginated list of registered webhooks.

*Requirement:* WA-BUS-010

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| page | query | integer | True | Page number |
| pageSize | query | integer | True | Page size |

**Request Body:** `ListWebhooksRequest`

**Responses:**

- `200`: OK - Webhooks retrieved
- `401`: Unauthorized - Missing or invalid token

---

### Widgets

#### `GET` /api/v1/widgets

**List home-screen widgets**

Returns a paginated list of widgets configured for the authenticated user.

*Requirement:* WA-INT-003

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| page | query | integer | True | Page number (starting at 1) |
| pageSize | query | integer | True | Number of items per page |

**Responses:**

- `200`: OK - Widgets retrieved successfully
- `401`: Unauthorized - Missing or invalid token
- `500`: Internal Server Error - Unable to retrieve widgets

---

#### `POST` /api/v1/widgets

**Create a home-screen widget**

Creates a new widget configuration for the authenticated user.

*Requirement:* WA-INT-003

**Request Body:** `CreateWidgetRequest`

**Responses:**

- `201`: Created - Widget created successfully
- `400`: Bad Request - Missing or invalid widget data
- `401`: Unauthorized - Missing or invalid token
- `409`: Conflict - Widget with same position already exists
- `500`: Internal Server Error - Unable to create widget

---

#### `GET` /api/v1/widgets/{widgetId}

**Get a widget**

Retrieves a single widget configuration by ID.

*Requirement:* WA-INT-003

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| widgetId | path | string | True | Widget ID |

**Responses:**

- `200`: OK - Widget retrieved successfully
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Widget does not exist
- `500`: Internal Server Error - Unable to retrieve widget

---

#### `PUT` /api/v1/widgets/{widgetId}

**Update a widget**

Updates an existing widget configuration by ID.

*Requirement:* WA-INT-003

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| widgetId | path | string | True | Widget ID |

**Request Body:** `UpdateWidgetRequest`

**Responses:**

- `200`: OK - Widget updated successfully
- `400`: Bad Request - Invalid widget update data
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Widget does not exist
- `409`: Conflict - Widget position already in use
- `500`: Internal Server Error - Unable to update widget

---

#### `DELETE` /api/v1/widgets/{widgetId}

**Delete a widget**

Removes a widget configuration by ID.

*Requirement:* WA-INT-003

**Parameters:**

| Name | In | Type | Required | Description |
|------|-----|------|----------|-------------|
| widgetId | path | string | True | Widget ID |

**Responses:**

- `200`: OK - Widget deleted successfully
- `401`: Unauthorized - Missing or invalid token
- `404`: Not Found - Widget does not exist
- `500`: Internal Server Error - Unable to delete widget

---

## Schemas

### AcceptInviteLinkRequest

| Property | Type | Description |
|----------|------|-------------|
| displayName | string | Optional display name to use in the group |

### AcceptInviteLinkResponse

| Property | Type | Description |
|----------|------|-------------|
| groupId | string | Group ID |
| memberId | string | Member ID of the joining user |
| status | string | Join status: joined, pendingApproval |
| joinedAt | string | ISO-8601 join timestamp (if joined) |

### AccessibilitySettingsResponse

| Property | Type | Description |
|----------|------|-------------|
| userId | string | User ID |
| screenreaderEnabled | boolean | Whether screenreader optimizations are enabled |
| preferredLabelFormat | string | Preferred aria-label format or verbosity level |
| announceMessageMetadata | boolean | Whether to announce message metadata (timestamps, sender) |
| largeTapTargets | boolean | Enable larger tap targets for accessibility |
| highContrast | boolean | Enable high contrast mode |
| updatedAt | string | ISO-8601 timestamp of last update |

### AckOfflineQueueRequest

| Property | Type | Description |
|----------|------|-------------|
| queueIds | array | List of queue item IDs to acknowledge |

### AckOfflineQueueResponse

| Property | Type | Description |
|----------|------|-------------|
| acknowledged | integer | Number of acknowledged items |

### AckPushNotificationRequest

| Property | Type | Description |
|----------|------|-------------|
| status | string | Acknowledgement status: delivered or processed |

### AckPushNotificationResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Notification ID |
| status | string | Updated status |
| updatedAt | string | ISO-8601 timestamp |

### AckQueuedMessagesRequest

| Property | Type | Description |
|----------|------|-------------|
| messageIds | array | List of message IDs to acknowledge |

### AckQueuedMessagesResponse

| Property | Type | Description |
|----------|------|-------------|
| acknowledgedCount | integer | Number of messages acknowledged |
| remainingCount | integer | Number of messages remaining in the queue |

### AcknowledgeMessageRequest

| Property | Type | Description |
|----------|------|-------------|
| deviceId | string | Client device identifier |

### AcknowledgeMessageResponse

| Property | Type | Description |
|----------|------|-------------|
| messageId | string | Message identifier |
| status | string | Acknowledgement status |

### AddBroadcastRecipientsRequest

| Property | Type | Description |
|----------|------|-------------|
| recipientIds | array | Recipient user IDs to add (max 256 total) |

### AddCartItemRequest

| Property | Type | Description |
|----------|------|-------------|
| productId | string | Product ID to add |
| quantity | integer | Quantity of the product |

### AddCartItemResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Cart item ID |
| productId | string | Product ID |
| quantity | integer | Quantity of the product |
| lineTotal | number | Line total amount |

### AddContactByQrRequest

| Property | Type | Description |
|----------|------|-------------|
| qrToken | string | QR token representing the contact to add |

### AddContactRequest

| Property | Type | Description |
|----------|------|-------------|
| identifierType | string | Type of identifier: phoneNumber, userId, or username |
| identifierValue | string | Value of the identifier |
| displayName | string | Optional local display name for the contact |

### AddFavoriteContactRequest

| Property | Type | Description |
|----------|------|-------------|
| contactId | string | Contact ID to be favorited |

### AddFavoriteContactResponse

| Property | Type | Description |
|----------|------|-------------|
| favoriteId | string | Favorite relationship ID |
| userId | string | User ID |
| contactId | string | Contact ID |
| addedAt | string | ISO-8601 timestamp when contact was favorited |

### AddGroupCallParticipantsRequest

| Property | Type | Description |
|----------|------|-------------|
| participantIds | array | Participant IDs to invite (max 1024 total) |
| e2eKeyPackage | string | Signal Protocol key package for new participants |

### AddGroupCallParticipantsResponse

| Property | Type | Description |
|----------|------|-------------|
| callId | string | Group call ID |
| invited | array | Participant IDs successfully invited |
| failed | array | Participant IDs that could not be invited |

### AddGroupMembersRequest

| Property | Type | Description |
|----------|------|-------------|
| memberIds | array | User IDs to add |

### AddGroupMembersResponse

| Property | Type | Description |
|----------|------|-------------|
| groupId | string | Group ID |
| addedCount | integer | Number of members added |

### AddGroupToCommunityRequest

| Property | Type | Description |
|----------|------|-------------|
| groupId | string | Existing group ID to link to the community |

### AddParticipantRequest

| Property | Type | Description |
|----------|------|-------------|
| participantId | string | User ID to add |

### AddParticipantResponse

| Property | Type | Description |
|----------|------|-------------|
| callId | string | Call ID |
| participantId | string | Added participant ID |
| status | string | Participant status |

### AiChatMessageListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of encrypted messages |
| page | integer | Current page number |
| pageSize | integer | Items per page |
| totalItems | integer | Total number of messages |

### AiChatMessageResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Server message ID |
| chatId | string | AI chat session ID |
| status | string | Delivery status (queued, sent, delivered) |
| createdAt | string | ISO-8601 timestamp of creation |

### AiChatResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | AI chat session ID |
| title | string | Chat title |
| assistantId | string | AI assistant profile ID |
| createdAt | string | ISO-8601 timestamp of creation |

### AppLockStatusResponse

| Property | Type | Description |
|----------|------|-------------|
| enabled | boolean | Indicates whether app lock is enabled |
| lockMethod | string | Authentication method used for app lock (e.g., pin, biometrics) |
| failedAttempts | integer | Number of consecutive failed unlock attempts |
| lockoutUntil | string | ISO-8601 timestamp until which unlock is blocked due to too many attempts |

### ArchiveChatRequest

| Property | Type | Description |
|----------|------|-------------|
| archivedAt | string | ISO-8601 timestamp when the chat is archived |

### ArchiveChatResponse

| Property | Type | Description |
|----------|------|-------------|
| chatId | string | Unique identifier of the chat |
| isArchived | boolean | Indicates whether the chat is archived |
| archivedAt | string | ISO-8601 timestamp when the chat was archived |

### AssignLabelToContactRequest

### AssignLabelToContactResponse

| Property | Type | Description |
|----------|------|-------------|
| contactId | string | Contact ID |
| labelId | string | Label ID |
| assignedAt | string | ISO-8601 assignment timestamp |

### AudioMessageDownloadResponse

| Property | Type | Description |
|----------|------|-------------|
| audioMessageId | string | ID of the audio message |
| downloadUrl | string | Pre-signed URL for downloading the encrypted audio file |
| expiresAt | string | ISO 8601 timestamp when the download URL expires |

### AudioMessageResponse

| Property | Type | Description |
|----------|------|-------------|
| audioMessageId | string | Unique ID of the created audio message |
| threadId | string | ID of the target thread |
| status | string | Message delivery status (queued, sent, delivered) |
| createdAt | string | ISO 8601 timestamp when the audio message was created |

### AwayMessageResponse

| Property | Type | Description |
|----------|------|-------------|
| userId | string | User ID |
| enabled | boolean | Whether the automatic away message is enabled |
| message | string | Away message text (end-to-end encrypted payload) |
| startsAt | string | ISO 8601 start time for the away message schedule |
| endsAt | string | ISO 8601 end time for the away message schedule |
| updatedAt | string | ISO 8601 timestamp when the configuration was last updated |

### BackupDownloadResponse

| Property | Type | Description |
|----------|------|-------------|
| backupId | string | Backup ID |
| downloadUrl | string | Time-limited URL to download the encrypted backup |
| expiresAt | string | ISO-8601 expiration timestamp |

### BackupListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of backups |
| page | integer | Current page number |
| pageSize | integer | Number of items per page |
| totalItems | integer | Total number of backups |

### BackupResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Backup ID |
| deviceId | string | Client device identifier |
| keyId | string | Signal Protocol key identifier used to encrypt the backup |
| createdAt | string | ISO-8601 creation timestamp |
| sizeBytes | integer | Size of the encrypted backup in bytes |
| checksum | string | Checksum of encrypted data |

### BiometricAuthenticateRequest

| Property | Type | Description |
|----------|------|-------------|
| credentialId | string | Base64Url-encoded credential identifier |
| authenticatorData | string | Base64Url-encoded authenticator data |
| clientDataJSON | string | Base64Url-encoded client data JSON |
| signature | string | Base64Url-encoded assertion signature |
| deviceId | string | Unique device identifier |

### BiometricAuthenticateResponse

| Property | Type | Description |
|----------|------|-------------|
| accessToken | string | JWT access token |
| refreshToken | string | Refresh token |
| expiresIn | integer | Access token expiration in seconds |

### BiometricAuthenticationOptionsRequest

| Property | Type | Description |
|----------|------|-------------|
| username | string | User identifier (e.g., phone or email) |
| deviceId | string | Unique device identifier |

### BiometricAuthenticationOptionsResponse

| Property | Type | Description |
|----------|------|-------------|
| challenge | string | Base64Url-encoded authentication challenge |
| rpId | string | Relying party identifier |
| timeoutMs | integer | Challenge timeout in milliseconds |

### BiometricRegistrationOptionsRequest

| Property | Type | Description |
|----------|------|-------------|
| deviceId | string | Unique device identifier |
| platform | string | Client platform (ios|android) |
| deviceName | string | Human-readable device name |

### BiometricRegistrationOptionsResponse

| Property | Type | Description |
|----------|------|-------------|
| challenge | string | Base64Url-encoded registration challenge |
| rpId | string | Relying party identifier |
| userId | string | User identifier for WebAuthn |
| timeoutMs | integer | Challenge timeout in milliseconds |

### BlockContactRequest

| Property | Type | Description |
|----------|------|-------------|
| contactId | string | ID of the contact to block |
| reason | string | Optional reason for blocking |

### BlockContactResponse

| Property | Type | Description |
|----------|------|-------------|
| blockId | string | Block relationship ID |
| userId | string | User ID who blocked |
| contactId | string | Blocked contact ID |
| createdAt | string | ISO-8601 timestamp when the block was created |

### BlockedContactsListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of blocked contacts |
| page | integer | Current page number |
| pageSize | integer | Number of items per page |
| totalItems | integer | Total number of blocked contacts |

### BroadcastChannelListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | Broadcast channels |
| page | integer | Current page |
| pageSize | integer | Page size |
| total | integer | Total number of channels |

### BroadcastChannelResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Broadcast channel ID |
| name | string | Channel display name |
| ownerId | string | Owner user ID |
| recipientCount | integer | Number of recipients |
| createdAt | string | Creation timestamp (ISO 8601) |

### BroadcastListCollectionResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | Broadcast lists |
| page | integer | Current page |
| pageSize | integer | Items per page |
| totalItems | integer | Total number of items |

### BroadcastListDetailResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Broadcast list ID |
| name | string | Broadcast list name |
| recipientIds | array | Recipient user IDs |
| recipientCount | integer | Number of recipients |
| createdAt | string | ISO-8601 creation timestamp |

### BroadcastListResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Broadcast list ID |
| name | string | Broadcast list name |
| recipientCount | integer | Number of recipients |
| updatedAt | string | ISO-8601 update timestamp |

### BroadcastMessageListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | Broadcast messages |
| page | integer | Current page |
| pageSize | integer | Page size |
| total | integer | Total number of messages |

### BroadcastMessageResponse

| Property | Type | Description |
|----------|------|-------------|
| messageId | string | Server message ID |
| channelId | string | Broadcast channel ID |
| queued | boolean | Indicates message queued for offline delivery |
| createdAt | string | Creation timestamp (ISO 8601) |

### BroadcastRecipientsResponse

| Property | Type | Description |
|----------|------|-------------|
| channelId | string | Broadcast channel ID |
| recipientCount | integer | Number of recipients after update |

### BusinessMessageStatisticsResponse

| Property | Type | Description |
|----------|------|-------------|
| businessId | string | Business ID |
| from | string | Start of time range in ISO 8601 format |
| to | string | End of time range in ISO 8601 format |
| totals | object | Aggregated totals for the period |
| breakdown | array | Optional time-bucketed breakdown if groupBy is provided |

### BusinessProductListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of products |
| page | integer | Current page number |
| pageSize | integer | Number of items per page |
| totalItems | integer | Total number of items |
| totalPages | integer | Total number of pages |

### BusinessProductMediaResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Media ID |
| productId | string | Product ID |
| type | string | Media type |
| url | string | Media URL |
| createdAt | string | Upload timestamp (ISO 8601) |

### BusinessProductResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Product ID |
| businessId | string | Business ID |
| name | string | Product name |
| description | string | Product description |
| price | number | Product price |
| currency | string | ISO 4217 currency code |
| sku | string | Stock keeping unit |
| isActive | boolean | Whether the product is active in the catalog |
| tags | array | Product tags |
| createdAt | string | Creation timestamp (ISO 8601) |
| updatedAt | string | Last update timestamp (ISO 8601) |

### BusinessProfileListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of business profiles |
| page | integer | Current page number |
| pageSize | integer | Number of items per page |
| total | integer | Total number of items |

### BusinessProfileMediaResponse

| Property | Type | Description |
|----------|------|-------------|
| mediaId | string | Uploaded media ID |
| mediaType | string | Media type |
| url | string | Media URL |
| sizeBytes | integer | Uploaded file size in bytes |

### BusinessProfileResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Business profile ID |
| displayName | string | Public display name of the business |
| description | string | Detailed business description |
| category | string | Business category identifier |
| contactEmail | string | Contact email address |
| contactPhone | string | Contact phone number |
| website | string | Business website URL |
| address | object | Business address |
| hours | array | Business hours by weekday |
| metadata | object | Additional profile metadata |
| createdAt | string | ISO 8601 creation timestamp |
| updatedAt | string | ISO 8601 update timestamp |

### BusinessVerificationRequestResponse

| Property | Type | Description |
|----------|------|-------------|
| requestId | string | Verification request ID |
| businessId | string | Business ID |
| status | string | Current status of the verification request |
| createdAt | string | ISO 8601 creation timestamp |

### BusinessVerificationStatusResponse

| Property | Type | Description |
|----------|------|-------------|
| businessId | string | Business ID |
| status | string | Verification status (e.g., pending, verified, rejected) |
| verifiedAt | string | ISO 8601 timestamp of verification, if verified |
| rejectionReason | string | Reason for rejection, if rejected |

### CallDetailResponse

| Property | Type | Description |
|----------|------|-------------|
| callId | string | Call ID |
| type | string | Call type |
| status | string | Current status |
| participants | array | Participant user IDs |
| createdAt | string | ISO-8601 timestamp |

### CallLinkDetailsResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Call link ID |
| title | string | Title |
| scheduledStartAt | string | Scheduled start time |
| scheduledEndAt | string | Scheduled end time |
| hostUserId | string | Host user ID |
| maxParticipants | integer | Maximum participants |
| access | object | Access configuration |
| signalProtocolSessionId | string | Signal protocol session identifier |
| webRtcConfigId | string | WebRTC configuration reference |
| linkUrl | string | Shareable call link URL |
| status | string | Status |
| createdAt | string | Creation timestamp |

### CallLinkResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Call link ID |
| title | string | Title for the scheduled call |
| scheduledStartAt | string | Scheduled start time |
| scheduledEndAt | string | Scheduled end time |
| hostUserId | string | Host user ID |
| maxParticipants | integer | Maximum number of participants |
| access | object | Access configuration |
| linkUrl | string | Shareable call link URL |
| status | string | Current status of the scheduled call link |
| createdAt | string | Creation timestamp |

### CallLinkUpdateResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Call link ID |
| title | string | Title |
| scheduledStartAt | string | Scheduled start time |
| scheduledEndAt | string | Scheduled end time |
| maxParticipants | integer | Maximum participants |
| access | object | Access configuration |
| status | string | Status |
| updatedAt | string | Last update timestamp |

### CallLinksListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of call links |
| page | integer | Current page |
| pageSize | integer | Items per page |
| totalItems | integer | Total number of items |

### CallListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of call sessions |
| page | integer | Current page number |
| pageSize | integer | Number of items per page |
| totalItems | integer | Total number of call sessions |

### CallLogListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of call logs |
| page | integer | Current page |
| pageSize | integer | Items per page |
| totalItems | integer | Total number of call logs |

### CallLogResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Call log ID |
| type | string | Call type: voice or video |
| direction | string | Direction: inbound or outbound |
| status | string | Call status: completed, missed, declined, failed |
| startedAt | string | ISO-8601 start time |
| endedAt | string | ISO-8601 end time |
| durationSeconds | integer | Call duration in seconds |
| participants | array | Participant user IDs |
| webrtcSessionId | string | WebRTC session identifier |
| encryptedMetadata | string | Signal Protocol encrypted metadata blob |

### CallNotificationSettingsResponse

| Property | Type | Description |
|----------|------|-------------|
| userId | string | Unique user ID |
| enabled | boolean | Master toggle for call notifications |
| incomingVoiceCalls | boolean | Notify for incoming voice calls |
| incomingVideoCalls | boolean | Notify for incoming video calls |
| vibrate | boolean | Vibration enabled for call notifications |
| sound | string | Selected ringtone identifier |
| quietHours | object | Quiet hours configuration |
| updatedAt | string | ISO-8601 timestamp of last update |

### CallPrivacySettingsResponse

| Property | Type | Description |
|----------|------|-------------|
| userId | string | User ID |
| ipMaskingEnabled | boolean | Whether IP address masking is enabled for calls |
| lastUpdatedAt | string | ISO-8601 timestamp of last update |

### CallResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Call ID |
| callType | string | Type of call |
| status | string | Current call status (created, active, ended) |
| iceServers | array | WebRTC ICE servers configuration |
| signalingChannel | string | WebSocket channel identifier for real-time signaling |
| createdAt | string | ISO 8601 timestamp when the call was created |

### CallSessionResponse

| Property | Type | Description |
|----------|------|-------------|
| callSessionId | string | Call session ID |
| relayRequired | boolean | Indicates if relay servers are required to mask IP addresses |
| turnServers | array | TURN server credentials for relayed connections |
| createdAt | string | ISO-8601 timestamp when the session was created |

### CartItemListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of cart items |
| page | integer | Current page |
| pageSize | integer | Page size |
| totalItems | integer | Total number of items |

### CartResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Cart ID |
| userId | string | Owner user ID |
| currency | string | Currency code |
| itemCount | integer | Total number of items |
| totalAmount | number | Total cart amount |
| updatedAt | string | Last update timestamp |

### ChatBackgroundListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of chat backgrounds |
| page | integer | Current page |
| pageSize | integer | Items per page |
| total | integer | Total number of backgrounds |

### ChatBackgroundResponse

| Property | Type | Description |
|----------|------|-------------|
| chatId | string | Chat ID |
| backgroundId | string | Selected background ID |
| previewUrl | string | Preview image URL |

### ChatExportCreatedResponse

| Property | Type | Description |
|----------|------|-------------|
| exportId | string | Unique identifier of the export job |
| chatId | string | Chat ID for which the export was created |
| status | string | Current status of the export job |
| createdAt | string | ISO 8601 timestamp when the export was created |

### ChatExportStatusResponse

| Property | Type | Description |
|----------|------|-------------|
| exportId | string | Unique identifier of the export job |
| chatId | string | Chat ID for which the export was created |
| status | string | Current status of the export job |
| downloadUrl | string | Temporary URL to download the export file when status is ready |
| expiresAt | string | ISO 8601 timestamp when the download URL expires |
| failureReason | string | Reason for failure if status is failed |

### ChatHistoryArchiveResponse

| Property | Type | Description |
|----------|------|-------------|
| downloadUrl | string | Time-limited URL to download the encrypted archive |
| expiresAt | string | ISO-8601 timestamp when the download URL expires |
| contentLength | integer | Size of the encrypted archive in bytes |
| checksum | string | Checksum of the encrypted archive for integrity verification |

### ChatHistoryTransferSessionResponse

| Property | Type | Description |
|----------|------|-------------|
| sessionId | string | Unique transfer session ID |
| status | string | Current status of the session |
| expiresAt | string | ISO-8601 timestamp when the session expires |
| transferToken | string | One-time token used by the target device to claim and import the archive |

### ChatHistoryTransferSessionStatusResponse

| Property | Type | Description |
|----------|------|-------------|
| sessionId | string | Transfer session ID |
| status | string | Session status: created, exporting, ready, importing, completed, failed, expired |
| progressPercent | integer | Progress percentage for export/import operations |
| archiveSizeBytes | integer | Size of the encrypted archive in bytes if ready |
| lastCheckpointMessageId | string | Last message ID checkpoint for resuming export |

### ChatLockResponse

| Property | Type | Description |
|----------|------|-------------|
| chatId | string | Chat ID |
| locked | boolean | Indicates whether the chat is locked |
| lockedAt | string | ISO-8601 timestamp when the chat was locked |

### ChatMediaResponse

| Property | Type | Description |
|----------|------|-------------|
| mediaId | string | Uploaded media ID |
| chatId | string | Chat ID |
| mediaType | string | Type of media (image|video|document) |
| mimeType | string | MIME type of the media |
| sizeBytes | integer | Size of the uploaded media in bytes |
| createdAt | string | Upload timestamp in ISO-8601 format |

### ChatMessageResponse

| Property | Type | Description |
|----------|------|-------------|
| messageId | string | Created message ID |
| chatId | string | Chat ID |
| mediaId | string | Referenced media ID |
| status | string | Message status (queued|sent|delivered) |
| createdAt | string | Message creation timestamp in ISO-8601 format |

### ChatUnlockResponse

| Property | Type | Description |
|----------|------|-------------|
| chatId | string | Chat ID |
| locked | boolean | Indicates whether the chat is locked |
| unlockedAt | string | ISO-8601 timestamp when the chat was unlocked |

### CheckDesktopAppUpdateRequest

| Property | Type | Description |
|----------|------|-------------|
| platform | string | Client platform (windows, macos, linux) |
| currentVersion | string | Current installed version |

### CheckDesktopAppUpdateResponse

| Property | Type | Description |
|----------|------|-------------|
| updateAvailable | boolean | Indicates if an update is available |
| latestVersion | string | Latest available version |
| downloadUrl | string | Download URL for the latest version |
| sha256 | string | SHA-256 checksum for the latest installer |

### ClearCartRequest

### ClearCartResponse

| Property | Type | Description |
|----------|------|-------------|
| cleared | boolean | Indicates if the cart was cleared |

### ClientPowerStateRequest

| Property | Type | Description |
|----------|------|-------------|
| deviceId | string | Device ID |
| batteryLevelPercent | integer | Battery level percentage |
| isCharging | boolean | Whether the device is charging |
| lowPowerMode | boolean | Whether OS low power mode is enabled |
| networkType | string | Network type (wifi, cellular, offline) |

### ClientPowerStateResponse

| Property | Type | Description |
|----------|------|-------------|
| accepted | boolean | Indicates whether the power state was accepted |
| effectivePolicyVersion | string | Policy version applied for this device |

### ClosePollRequest

| Property | Type | Description |
|----------|------|-------------|
| reason | string | Optional reason for closing the poll |

### ClosePollResponse

| Property | Type | Description |
|----------|------|-------------|
| pollId | string | Poll ID |
| status | string | Poll status (closed) |
| closedAt | string | ISO-8601 close timestamp |

### CommunityGroupLinkResponse

| Property | Type | Description |
|----------|------|-------------|
| communityId | string | Community ID |
| groupId | string | Group ID |
| linkedAt | string | ISO-8601 link timestamp |

### CommunityGroupListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of groups in the community |
| page | integer | Current page number |
| pageSize | integer | Page size |
| totalCount | integer | Total number of groups in the community |

### CommunityListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of communities |
| page | integer | Current page number |
| pageSize | integer | Page size |
| totalCount | integer | Total number of communities |

### CommunityResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Community ID |
| name | string | Community display name |
| description | string | Community description |
| metadata | object | Community metadata |
| updatedAt | string | ISO-8601 update timestamp |

### CompleteMediaUploadRequest

| Property | Type | Description |
|----------|------|-------------|
| parts | array | List of uploaded chunks with their ETags |

### CompleteMediaUploadResponse

| Property | Type | Description |
|----------|------|-------------|
| mediaId | string | Created media resource identifier |
| downloadUrl | string | URL for downloading the encrypted media |
| contentLength | integer | Total size in bytes |
| mimeType | string | MIME type of the media |
| hd | boolean | Whether the media is HD quality |

### ConfirmSecurityCodeVerificationRequest

| Property | Type | Description |
|----------|------|-------------|
| matched | boolean | Whether the safety codes matched |
| confirmedAt | string | Client confirmation timestamp (ISO-8601) |

### ContactLabelListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of labels assigned to the contact |
| page | integer | Current page number |
| pageSize | integer | Page size |
| total | integer | Total number of labels assigned to the contact |

### ContactLabelResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Label ID |
| name | string | Label name |
| color | string | Label color |
| createdAt | string | ISO-8601 creation timestamp |
| updatedAt | string | ISO-8601 update timestamp |

### ContactListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of contacts with the label |
| page | integer | Current page number |
| pageSize | integer | Page size |
| total | integer | Total number of contacts with the label |

### ContactResponse

| Property | Type | Description |
|----------|------|-------------|
| contactId | string | Unique contact ID |
| userId | string | User ID of the contact |
| displayName | string | Display name for the contact |
| createdAt | string | Creation timestamp in ISO 8601 |

### ContactStatusListResponse

| Property | Type | Description |
|----------|------|-------------|
| page | integer | Current page number |
| pageSize | integer | Number of items per page |
| totalItems | integer | Total number of available statuses |
| items | array | List of contact statuses |

### ContactStatusResponse

| Property | Type | Description |
|----------|------|-------------|
| contactId | string | Contact ID |
| statusId | string | Status ID |
| text | string | Status text |
| mediaUrl | string | Encrypted media URL |
| mediaType | string | Media type (image, video, document) |
| createdAt | string | ISO 8601 timestamp of status creation |
| expiresAt | string | ISO 8601 timestamp when status expires |

### ContactSyncRequest

| Property | Type | Description |
|----------|------|-------------|
| deviceId | string | Unique identifier for the device submitting the sync |
| contacts | array | List of contacts to be matched |
| clientTimestamp | string | ISO-8601 timestamp when the sync was initiated |

### ContactSyncResponse

| Property | Type | Description |
|----------|------|-------------|
| syncId | string | Server-generated sync operation identifier |
| matchedUsers | array | Contacts matched to WhatsApp users |
| unmatchedContactIds | array | Contact IDs that were not matched to any user |

### ContactSyncResultResponse

| Property | Type | Description |
|----------|------|-------------|
| syncId | string | Sync operation identifier |
| status | string | Processing status (e.g., pending, completed, failed) |
| matchedUsers | array | Contacts matched to WhatsApp users |
| unmatchedContactIds | array | Contact IDs not matched to any user |
| processedAt | string | ISO-8601 timestamp when processing completed |

### ContrastRequirementsResponse

| Property | Type | Description |
|----------|------|-------------|
| minContrastRatio | number | Minimum contrast ratio required |
| recommendedContrastRatio | number | Recommended contrast ratio for optimal readability |
| supportedModes | array | Supported contrast modes |

### ConversationsSyncRequest

### ConversationsSyncResponse

| Property | Type | Description |
|----------|------|-------------|
| nextCursor | string | Cursor for the next page of results |
| hasMore | boolean | Indicates if more results are available |
| conversations | array | List of conversation metadata updates |

### CreateAiChatMessageRequest

| Property | Type | Description |
|----------|------|-------------|
| ciphertext | string | Encrypted message payload (Signal Protocol) |
| clientMessageId | string | Client-generated message ID for idempotency |
| attachments | array | Optional attachment references |
| queuedAt | string | ISO-8601 timestamp when message was queued offline |

### CreateAiChatRequest

| Property | Type | Description |
|----------|------|-------------|
| title | string | Optional chat title |
| assistantId | string | Identifier of the AI assistant profile |
| signalSessionSetup | object | Signal Protocol session setup data for end-to-end encryption |

### CreateAudioMessageRequest

| Property | Type | Description |
|----------|------|-------------|
| threadId | string | ID of the target thread (direct chat, group, or broadcast list) |
| threadType | string | Type of the target thread: direct, group, or broadcast |
| clientMessageId | string | Client-generated idempotency key for offline queue and retry |
| mimeType | string | MIME type of the audio file (e.g., audio/ogg, audio/mpeg) |
| durationMs | integer | Audio duration in milliseconds |
| sizeBytes | integer | Size of the audio file in bytes |
| signalCiphertext | string | Signal Protocol encrypted payload metadata for the message |
| keyId | string | Identifier of the Signal Protocol session key |
| nonce | string | Nonce/IV used for encrypting the media |
| file | string | Binary audio file data |

### CreateBackupRequest

| Property | Type | Description |
|----------|------|-------------|
| deviceId | string | Client device identifier |
| keyId | string | Signal Protocol key identifier used to encrypt the backup |
| algorithm | string | Encryption algorithm identifier (e.g., Signal-DoubleRatchet) |
| checksum | string | Checksum of encrypted data for integrity verification |
| sizeBytes | integer | Size of the encrypted backup in bytes |
| backupFile | string | Encrypted backup file (ciphertext) |
| manifest | string | Optional encrypted manifest JSON (ciphertext) |

### CreateBiometricCredentialRequest

| Property | Type | Description |
|----------|------|-------------|
| deviceId | string | Unique device identifier |
| attestationObject | string | Base64Url-encoded WebAuthn attestation object |
| clientDataJSON | string | Base64Url-encoded client data JSON |
| credentialId | string | Base64Url-encoded credential identifier |

### CreateBiometricCredentialResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Biometric credential ID |
| deviceId | string | Associated device identifier |
| createdAt | string | ISO-8601 timestamp when the credential was created |

### CreateBroadcastChannelRequest

| Property | Type | Description |
|----------|------|-------------|
| name | string | Channel display name |
| recipientIds | array | Initial recipient user IDs (max 256) |
| encryptedChannelKey | string | Encrypted channel key for E2E (Signal Protocol) |
| metadata | object | Optional metadata (e.g., avatar, description) |

### CreateBroadcastListRequest

| Property | Type | Description |
|----------|------|-------------|
| name | string | Human-readable name of the broadcast list |
| recipientIds | array | Array of recipient user IDs (max 256) |

### CreateBusinessProductRequest

| Property | Type | Description |
|----------|------|-------------|
| name | string | Product name |
| description | string | Product description |
| price | number | Product price |
| currency | string | ISO 4217 currency code |
| sku | string | Stock keeping unit |
| isActive | boolean | Whether the product is active in the catalog |
| tags | array | Product tags |

### CreateBusinessProfileRequest

| Property | Type | Description |
|----------|------|-------------|
| displayName | string | Public display name of the business |
| description | string | Detailed business description |
| category | string | Business category identifier |
| contactEmail | string | Contact email address |
| contactPhone | string | Contact phone number |
| website | string | Business website URL |
| address | object | Business address |
| hours | array | Business hours by weekday |
| metadata | object | Additional profile metadata |

### CreateBusinessVerificationRequest

| Property | Type | Description |
|----------|------|-------------|
| legalName | string | Registered legal name of the business |
| registrationNumber | string | Official registration number |
| countryCode | string | ISO 3166-1 alpha-2 country code |
| documentIds | array | Array of previously uploaded document IDs |
| contactEmail | string | Business contact email |

### CreateCallLinkRequest

| Property | Type | Description |
|----------|------|-------------|
| title | string | Human-readable title for the scheduled call |
| scheduledStartAt | string | ISO 8601 timestamp when the call is scheduled to start |
| scheduledEndAt | string | ISO 8601 timestamp when the call is scheduled to end |
| hostUserId | string | User ID of the call host |
| maxParticipants | integer | Maximum number of participants (must be <= 1024) |
| access | object | Access configuration for the call link |
| signalProtocolSessionId | string | Signal protocol session identifier for end-to-end encryption |
| webRtcConfigId | string | Reference to preconfigured WebRTC settings |

### CreateCallLogRequest

| Property | Type | Description |
|----------|------|-------------|
| type | string | Call type: voice or video |
| direction | string | Direction: inbound or outbound |
| status | string | Call status: completed, missed, declined, failed |
| startedAt | string | ISO-8601 start time |
| endedAt | string | ISO-8601 end time |
| durationSeconds | integer | Call duration in seconds |
| participants | array | Participant user IDs |
| webrtcSessionId | string | WebRTC session identifier |
| encryptedMetadata | string | Signal Protocol encrypted metadata blob |

### CreateCallLogResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Call log ID |
| createdAt | string | ISO-8601 creation timestamp |

### CreateCallRequest

| Property | Type | Description |
|----------|------|-------------|
| callType | string | Type of call (oneToOne, group) |
| participantIds | array | List of initial participant user IDs (max 1024 for group calls) |
| e2eKeyBundleId | string | Signal Protocol key bundle ID used to establish end-to-end encryption |

### CreateCallSessionRequest

| Property | Type | Description |
|----------|------|-------------|
| callerId | string | Caller user ID |
| calleeIds | array | List of callee user IDs |
| mediaType | string | Call type: voice or video |
| ipMaskingEnabled | boolean | Whether to enforce IP address masking for this session |

### CreateChatBackgroundRequest

| Property | Type | Description |
|----------|------|-------------|
| file | string | Image file to upload |
| name | string | Custom name for the background |

### CreateChatExportRequest

| Property | Type | Description |
|----------|------|-------------|
| format | string | Export format |
| includeMedia | boolean | Whether to include media attachments in the export |
| messageLimit | integer | Maximum number of messages to include; if omitted, exports full chat history |

### CreateChatHistoryTransferSessionRequest

| Property | Type | Description |
|----------|------|-------------|
| sourceDeviceId | string | Unique identifier of the source device initiating the transfer |
| targetDeviceId | string | Optional identifier of the target device if already registered |
| targetPublicKeyBundle | string | Signal Protocol public key bundle for the target device, used to wrap the archive key |
| transferMode | string | Transfer mode: cloud or p2p |
| includeMedia | boolean | Whether to include media in the transfer archive |

### CreateChatMediaMessageRequest

| Property | Type | Description |
|----------|------|-------------|
| mediaId | string | ID of uploaded media |
| messageType | string | Message type, must be 'media' |
| encryptedPayload | string | Encrypted message payload using Signal Protocol |
| clientMessageId | string | Client-generated ID for offline queue de-duplication |

### CreateCommunityRequest

| Property | Type | Description |
|----------|------|-------------|
| name | string | Community display name |
| description | string | Community description |
| metadata | object | Optional community metadata (non-sensitive, client-encrypted if needed) |

### CreateContactLabelRequest

| Property | Type | Description |
|----------|------|-------------|
| name | string | Human-readable label name |
| color | string | Optional label color in hex format (e.g., #FF9900) |

### CreateContactShareMessageRequest

| Property | Type | Description |
|----------|------|-------------|
| messageType | string | Message type; must be 'contact' |
| recipientType | string | Recipient type: 'direct', 'group', or 'broadcast' |
| encryptedPayload | string | Signal Protocol encrypted payload containing the contact data (e.g., vCard) |
| payloadChecksum | string | Checksum for encrypted payload integrity validation |
| clientMessageId | string | Client-generated idempotency key for offline queueing |
| timestamp | string | Client timestamp in ISO 8601 |

### CreateFormattedMessageRequest

| Property | Type | Description |
|----------|------|-------------|
| clientMessageId | string | Client-generated id for deduplication in offline queue |
| ciphertext | string | End-to-end encrypted message payload |
| ciphertextFormat | string | Format of the encrypted payload, e.g., 'signal-protocol-v1' |
| formatting | object | Formatting metadata applied to the plaintext prior to encryption |

### CreateGreetingMessageRequest

| Property | Type | Description |
|----------|------|-------------|
| senderId | string | User ID of the greeting sender |
| recipientId | string | User ID of the greeting recipient |
| message | string | Greeting message content |
| clientMessageId | string | Client-generated idempotency key for offline queue support |

### CreateGroupCallRequest

| Property | Type | Description |
|----------|------|-------------|
| groupId | string | Group ID for the call |
| mediaType | string | Media type: audio or video |
| participantIds | array | Initial participant IDs (max 1024) |
| webrtcOffer | string | SDP offer for WebRTC negotiation |
| e2eKeyPackage | string | Signal Protocol key package for end-to-end encryption |
| clientNonce | string | Client-generated nonce to ensure idempotency |

### CreateGroupCallResponse

| Property | Type | Description |
|----------|------|-------------|
| callId | string | Unique group call ID |
| status | string | Call status |
| createdAt | string | ISO timestamp when the call was created |
| webrtcAnswer | string | SDP answer from server |
| iceServers | array | List of ICE servers for WebRTC connectivity |

### CreateGroupEventRequest

| Property | Type | Description |
|----------|------|-------------|
| title | string | Event title |
| description | string | Event description |
| startTime | string | ISO-8601 start date-time |
| endTime | string | ISO-8601 end date-time |
| location | string | Event location or meeting link |
| timezone | string | IANA timezone |
| visibility | string | Event visibility within group (e.g., group, organizers) |
| maxParticipants | integer | Optional cap on participants |

### CreateGroupInviteLinkRequest

| Property | Type | Description |
|----------|------|-------------|
| expiresAt | string | ISO-8601 timestamp when the invite link expires |
| maxUses | integer | Maximum number of uses for the invite link |
| requireApproval | boolean | Whether a group admin must approve the join request |

### CreateGroupMessageRequest

| Property | Type | Description |
|----------|------|-------------|
| clientMessageId | string | Client-generated idempotency key for offline queue and deduplication |
| ciphertext | string | End-to-end encrypted message payload (Signal Protocol) |
| mentions | array | List of mentioned user IDs in the message |

### CreateGroupRequest

| Property | Type | Description |
|----------|------|-------------|
| name | string | Group name |
| description | string | Group description |
| memberIds | array | Initial member user IDs (max 1024) |
| encryptionMetadata | object | Signal Protocol group encryption metadata (e.g., sender keys) |

### CreateIntegrationAppRequest

| Property | Type | Description |
|----------|------|-------------|
| name | string | App name |
| contactEmail | string | Technical contact email |
| callbackUrl | string | Default webhook callback URL |

### CreateLocationMessageRequest

| Property | Type | Description |
|----------|------|-------------|
| clientMessageId | string | Client-generated idempotency key for offline queue reconciliation |
| payloadCiphertext | string | Signal Protocol encrypted payload (location data) |
| payloadType | string | Type of encrypted payload |
| sentAt | string | Client timestamp when the location was shared |
| ttlSeconds | integer | Optional time-to-live for location sharing in seconds |

### CreateMediaDraftRequest

| Property | Type | Description |
|----------|------|-------------|
| file | string | Image file to edit (max 16MB) |
| clientDraftId | string | Client-generated draft ID for offline queue reconciliation |

### CreateMediaUploadSessionRequest

| Property | Type | Description |
|----------|------|-------------|
| mediaType | string | Type of media: image, video, audio, document |
| fileName | string | Original file name |
| fileSize | integer | Total file size in bytes |
| mimeType | string | MIME type of the media |
| checksum | string | SHA-256 checksum of the encrypted file |
| hd | boolean | Whether HD quality is requested |
| encryptionMetadata | object | Signal Protocol encryption metadata for the media key and IV |

### CreateMediaUploadSessionResponse

| Property | Type | Description |
|----------|------|-------------|
| uploadId | string | Upload session identifier |
| partSize | integer | Recommended chunk size in bytes |
| expiresAt | string | Upload session expiration timestamp |
| maxFileSize | integer | Maximum allowed file size for this media type |

### CreateMessageRequest

| Property | Type | Description |
|----------|------|-------------|
| conversationId | string | Target conversation (1:1, group, or broadcast) |
| mediaId | string | Reference to uploaded media |
| viewOnce | boolean | Whether the media is restricted to a single view |
| caption | string | Optional caption |
| clientMessageId | string | Client-generated id for idempotency |

### CreateMessageResponse

| Property | Type | Description |
|----------|------|-------------|
| messageId | string | Server-generated message id |
| status | string | Message creation status |

### CreateNotificationPreviewRequest

| Property | Type | Description |
|----------|------|-------------|
| recipientUserId | string | Recipient user ID |
| senderId | string | Sender user ID |
| messageId | string | Message ID |
| messageType | string | Type of message (text|image|video|audio|document|call|status) |
| encryptedPreviewMetadata | string | Encrypted metadata used for preview generation |

### CreateOfflineQueueRequest

| Property | Type | Description |
|----------|------|-------------|
| deviceId | string | Unique device identifier |
| clientPublicKey | string | Public key used for Signal Protocol session setup |

### CreatePaymentRequest

| Property | Type | Description |
|----------|------|-------------|
| receiverUserId | string | User ID of the payment receiver |
| amount | number | Payment amount in minor units |
| currency | string | ISO 4217 currency code |
| note | string | Optional payment note |
| market | string | Market code where payment is initiated |
| idempotencyKey | string | Unique key to prevent duplicate payments |

### CreatePhoneRegistrationRequest

| Property | Type | Description |
|----------|------|-------------|
| phoneNumber | string | Phone number in E.164 format |
| deviceId | string | Client device identifier |
| locale | string | User locale for SMS/voice messages |
| deliveryChannel | string | OTP delivery channel: sms or voice |

### CreatePhoneRegistrationResponse

| Property | Type | Description |
|----------|------|-------------|
| registrationId | string | Registration session identifier |
| expiresInSeconds | integer | Time until OTP expires |
| status | string | Registration status (pending) |

### CreatePollRequest

| Property | Type | Description |
|----------|------|-------------|
| questionCiphertext | string | Encrypted poll question (Signal Protocol payload) |
| optionsCiphertexts | array | Encrypted poll options (Signal Protocol payloads) |
| allowsMultipleChoices | boolean | Whether multiple options can be selected |
| expiresAt | string | ISO-8601 expiration timestamp; null for no expiration |
| clientMessageId | string | Client-generated id for offline queue de-duplication |

### CreatePushNotificationRequest

| Property | Type | Description |
|----------|------|-------------|
| recipientType | string | Recipient type: user, group, or broadcast |
| recipientId | string | User ID, Group ID (max 1024), or Broadcast List ID (max 256) |
| encryptedPayload | string | Signal Protocol encrypted payload |
| ttlSeconds | integer | Time-to-live in seconds |
| priority | string | Notification priority: normal or high |

### CreateQuickReplyRequest

| Property | Type | Description |
|----------|------|-------------|
| title | string | Short label for the quick reply |
| message | string | Message text to be sent |
| language | string | BCP-47 language tag for the quick reply (e.g., de-DE) |
| isActive | boolean | Whether the quick reply is active |

### CreateReactionRequest

| Property | Type | Description |
|----------|------|-------------|
| emoji | string | Emoji unicode character |
| encryptedPayload | string | End-to-end encrypted reaction metadata (Signal Protocol) |
| clientMessageId | string | Client-generated id for offline queue de-duplication |

### CreateReportRequest

| Property | Type | Description |
|----------|------|-------------|
| targetType | string | Type of target being reported. Allowed values: message, contact |
| targetId | string | ID of the message or contact being reported |
| reasonCode | string | Predefined reason code for the report (e.g., spam, harassment, fraud, impersonation) |
| details | string | Optional free-text details provided by the reporter |

### CreateScreenShareRequest

| Property | Type | Description |
|----------|------|-------------|
| publisherId | string | User ID of the screen-share publisher |
| webrtcSdpOffer | string | WebRTC SDP offer for screen sharing |
| encryptionContext | string | Signal Protocol context identifier for end-to-end encryption |

### CreateSecurityCodeVerificationRequest

| Property | Type | Description |
|----------|------|-------------|
| contactId | string | ID of the contact to verify with |
| channel | string | Verification channel |
| deviceId | string | Optional device identifier for multi-device verification |

### CreateShareExtensionRequest

| Property | Type | Description |
|----------|------|-------------|
| senderDeviceId | string | Unique device identifier used for E2E session binding |
| targetType | string | Target type: chat, group, or broadcast |
| targetId | string | Target identifier (chatId, groupId, or broadcastListId) |
| messageText | string | Optional text content to share |
| e2eCiphertext | string | Encrypted payload (Signal Protocol) |
| e2eKeyId | string | Key identifier used for encryption |
| statusExpirySeconds | integer | Optional status expiry in seconds (max 86400) |

### CreateSmartRepliesRequest

| Property | Type | Description |
|----------|------|-------------|
| contextCiphertext | string | Verschluesselter Kontext der letzten Nachrichten (Signal Protocol Payload) |
| contextNonce | string | Nonce fuer den verschluesselten Kontext |
| contextKeyId | string | Schluessel-ID zur Entschluesselung des Kontextes auf dem Server oder in einer sicheren Enklave |
| maxSuggestions | integer | Maximale Anzahl der Antwortvorschlaege |
| locale | string | Locale fuer sprachspezifische Vorschlaege, z.B. de-DE |
| deviceId | string | Eindeutige Geraete-ID fuer Offline-Queue und Personalisierung |

### CreateSpamCheckRequest

| Property | Type | Description |
|----------|------|-------------|
| messageId | string | Unique message identifier |
| senderId | string | User ID of the sender |
| conversationId | string | Chat or group ID |
| messageType | string | Type of message (text, media, status) |
| contentHash | string | Hash of plaintext content or attachment for spam fingerprinting |
| clientTimestamp | string | ISO-8601 timestamp from client |
| signalMetadata | object | Minimal metadata allowed under E2E encryption (e.g., attachment size, link count) |

### CreateSpamCheckResponse

| Property | Type | Description |
|----------|------|-------------|
| spamCheckId | string | Spam check job ID |
| status | string | Current status of the spam check (queued, processing, completed) |

### CreateStatusMuteRequest

| Property | Type | Description |
|----------|------|-------------|
| contactId | string | ID of the contact whose status should be muted |
| muteUntil | string | ISO 8601 timestamp until which the status is muted; omit for indefinite mute |

### CreateStatusReplyRequest

| Property | Type | Description |
|----------|------|-------------|
| clientMessageId | string | Client-generated idempotency key for offline queueing |
| ciphertext | string | Encrypted reply payload (Signal Protocol) |
| media | object | Optional encrypted media metadata |
| replyToMessageId | string | Optional message id being replied to within the status thread |

### CreateStatusRequest

| Property | Type | Description |
|----------|------|-------------|
| ciphertext | string | End-to-end encrypted payload containing status content |
| mediaId | string | Optional media identifier for pre-uploaded media (image/document). |
| mediaType | string | Optional media type (e.g., image/jpeg, application/pdf). |
| expiresInSeconds | integer | Expiration time in seconds; maximum 86400 (24 hours). |
| clientTimestamp | string | Client timestamp in ISO 8601 format. |

### CreateTranscriptionRequest

| Property | Type | Description |
|----------|------|-------------|
| language | string | BCP-47 language tag for transcription (e.g., de-DE, en-US) |
| enablePunctuation | boolean | Whether to include punctuation in the transcription |
| enableSpeakerDiarization | boolean | Whether to attempt speaker separation |

### CreateUserQrCodeRequest

| Property | Type | Description |
|----------|------|-------------|
| validitySeconds | integer | Validity duration of the QR code in seconds |
| format | string | QR code image format (e.g., png, svg) |
| size | integer | QR code image size in pixels |

### CreateVoiceAssistantCommandRequest

| Property | Type | Description |
|----------|------|-------------|
| provider | string | Voice assistant provider identifier |
| intent | string | Intent name (e.g., sendMessage, startCall) |
| parameters | object | Intent-specific parameters (e.g., recipientId, messageText) |
| clientRequestId | string | Client-generated id for idempotency |

### CreateVoiceAssistantLinkRequest

| Property | Type | Description |
|----------|------|-------------|
| provider | string | Voice assistant provider identifier (e.g., siri, google) |
| authorizationCode | string | OAuth authorization code from the provider |
| redirectUri | string | Redirect URI used in the OAuth flow |

### CreateVoiceMessageRequest

| Property | Type | Description |
|----------|------|-------------|
| recipientType | string | Recipient type: user, group, or broadcast |
| recipientId | string | ID of the target user, group, or broadcast list |
| clientMessageId | string | Client-generated unique identifier for idempotency |
| durationMs | integer | Duration of the voice message in milliseconds |
| mimeType | string | MIME type of the audio file (e.g., audio/ogg, audio/m4a) |
| waveform | string | Optional compact waveform representation for UI rendering |
| encryptionHeader | string | Signal Protocol header or metadata required to decrypt the payload |
| ciphertextHash | string | Hash of the encrypted payload for integrity verification |
| file | string | Encrypted voice message file |

### CreateWatchDeviceRequest

| Property | Type | Description |
|----------|------|-------------|
| deviceName | string | User-friendly name of the smartwatch |
| platform | string | Smartwatch platform (e.g., watchOS, WearOS) |
| devicePublicKey | string | Public key used for end-to-end encryption setup (Signal Protocol) |

### CreateWebRtcTokenRequest

| Property | Type | Description |
|----------|------|-------------|
| callType | string | Type of call requested (voice or video) |

### CreateWebSessionRequest

| Property | Type | Description |
|----------|------|-------------|
| deviceName | string | Name of the web client device or browser |
| userAgent | string | Browser user agent string |
| publicKey | string | Signal Protocol public key for session setup |

### CreateWebSocketTokenRequest

| Property | Type | Description |
|----------|------|-------------|
| clientNonce | string | Client-generated nonce to bind the token |

### CreateWidgetRequest

| Property | Type | Description |
|----------|------|-------------|
| type | string | Widget type identifier |
| title | string | Widget title |
| position | integer | Order on home screen |
| isEnabled | boolean | Whether widget is enabled |
| config | object | Widget configuration settings |

### DataUsageSettingsResponse

| Property | Type | Description |
|----------|------|-------------|
| userId | string | User ID |
| limits | object | Data usage limits per period |
| autoDownload | object | Auto-download preferences by network type |
| warnings | object | Usage warning thresholds |
| updatedAt | string | ISO 8601 timestamp of last update |

### DataUsageSummaryResponse

| Property | Type | Description |
|----------|------|-------------|
| userId | string | User ID |
| period | string | Usage period |
| totals | object | Total usage in bytes |
| remaining | object | Remaining quotas in bytes |
| thresholds | object | Warning and hard-block thresholds |
| updatedAt | string | ISO 8601 timestamp of last usage update |

### DeleteAwayMessageRequest

### DeleteAwayMessageResponse

| Property | Type | Description |
|----------|------|-------------|
| userId | string | User ID |
| deleted | boolean | Whether the away message configuration was deleted |
| deletedAt | string | ISO 8601 timestamp when the configuration was deleted |

### DeleteBackupRequest

### DeleteBackupResponse

| Property | Type | Description |
|----------|------|-------------|
| backupId | string | Deleted backup ID |
| deleted | boolean | Deletion result |

### DeleteBiometricCredentialRequest

### DeleteBiometricCredentialResponse

| Property | Type | Description |
|----------|------|-------------|
| deleted | boolean | Indicates whether the credential was deleted |

### DeleteBroadcastChannelResponse

| Property | Type | Description |
|----------|------|-------------|
| deleted | boolean | Deletion status |
| id | string | Broadcast channel ID |

### DeleteBroadcastListRequest

### DeleteBroadcastListResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Broadcast list ID |
| deleted | boolean | Deletion status |

### DeleteBusinessProductMediaResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Deleted media ID |
| deleted | boolean | Deletion status |

### DeleteBusinessProductResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Deleted product ID |
| deleted | boolean | Deletion status |

### DeleteBusinessProfileRequest

### DeleteBusinessProfileResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Business profile ID |
| deleted | boolean | Deletion status |

### DeleteCallLinkRequest

### DeleteCallLinkResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Call link ID |
| status | string | Deletion status |
| deletedAt | string | Deletion timestamp |

### DeleteCallLogResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Deleted call log ID |
| deleted | boolean | Deletion result |

### DeleteCommunityRequest

### DeleteCommunityResponse

| Property | Type | Description |
|----------|------|-------------|
| deleted | boolean | Indicates whether the community was deleted |

### DeleteContactLabelRequest

### DeleteContactLabelResponse

| Property | Type | Description |
|----------|------|-------------|
| deleted | boolean | Indicates whether the label was deleted |
| labelId | string | Deleted label ID |

### DeleteGroupEventResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Deleted event ID |
| deleted | boolean | Deletion status |

### DeleteGroupRequest

### DeleteGroupResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Deleted group ID |
| deleted | boolean | Deletion status |

### DeleteMessageRequest

| Property | Type | Description |
|----------|------|-------------|
| reason | string | Optional reason for deletion |

### DeleteMessageResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Deleted message ID |
| deletedAt | string | Deletion timestamp in ISO 8601 |
| status | string | Deletion status |

### DeleteOfflineQueueRequest

### DeleteOfflineQueueResponse

| Property | Type | Description |
|----------|------|-------------|
| deleted | boolean | Indicates whether the queue was deleted |

### DeleteProfileImageRequest

### DeleteProfileImageResponse

| Property | Type | Description |
|----------|------|-------------|
| deleted | boolean | Deletion status |
| userId | string | User ID |

### DeleteQuickReplyResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Quick reply ID |
| deleted | boolean | Deletion status |

### DeleteReactionRequest

| Property | Type | Description |
|----------|------|-------------|
| clientMessageId | string | Client-generated id for offline queue de-duplication |

### DeleteReactionResponse

| Property | Type | Description |
|----------|------|-------------|
| reactionId | string | Deleted reaction ID |
| messageId | string | Message ID |
| deletedAt | string | ISO-8601 timestamp when reaction was deleted |

### DeleteStatusMuteRequest

### DeleteStatusMuteResponse

| Property | Type | Description |
|----------|------|-------------|
| contactId | string | Unmuted contact ID |
| deleted | boolean | Indicates if the mute was deleted |

### DeleteStatusReplyResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Reply ID |
| deleted | boolean | Deletion result |

### DeleteStorageItemResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Deleted storage item ID |
| deleted | boolean | Deletion status |

### DeleteUserPasskeyRequest

### DeleteUserPasskeyResponse

| Property | Type | Description |
|----------|------|-------------|
| status | string | Deletion status |

### DeleteVoiceAssistantLinkRequest

### DeleteVoiceAssistantLinkResponse

| Property | Type | Description |
|----------|------|-------------|
| linkId | string | Unique link identifier |
| status | string | Deletion status |
| deletedAt | string | ISO-8601 timestamp of deletion |

### DeleteWidgetResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Widget ID |
| deleted | boolean | Deletion status |

### DesktopAppReleaseListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of desktop app releases |
| page | integer | Current page |
| pageSize | integer | Items per page |
| totalItems | integer | Total number of items |

### DesktopAppReleaseResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Release ID |
| platform | string | Target platform |
| version | string | Semantic version |
| releaseNotes | string | Release notes |
| downloadUrl | string | URL to download installer |
| sha256 | string | SHA-256 checksum |
| publishedAt | string | Release publication timestamp (ISO 8601) |

### DeviceListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of devices |
| page | integer | Current page number |
| pageSize | integer | Number of items per page |
| totalItems | integer | Total number of devices |

### DeviceResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Device ID |
| deviceName | string | Human-readable device name |
| platform | string | Device platform |
| deviceFingerprint | string | Unique device fingerprint |
| createdAt | string | Device registration timestamp (ISO 8601) |
| lastSeenAt | string | Last seen timestamp (ISO 8601) |

### DisablePinRequest

| Property | Type | Description |
|----------|------|-------------|
| pin | string | Current PIN for verification |

### DisablePinResponse

| Property | Type | Description |
|----------|------|-------------|
| userId | string | User ID |
| pinEnabled | boolean | Indicates whether PIN security is enabled |
| disabledAt | string | Timestamp when PIN was disabled |

### DisableTwoFactorRequest

| Property | Type | Description |
|----------|------|-------------|
| pin | string | 6-digit PIN to confirm disabling 2FA |

### DisableTwoFactorResponse

| Property | Type | Description |
|----------|------|-------------|
| userId | string | User ID |
| twoFactorEnabled | boolean | Indicates whether 2FA is enabled |

### DispatchShareExtensionRequest

| Property | Type | Description |
|----------|------|-------------|
| clientMessageId | string | Client-side message identifier for idempotency |

### DispatchShareExtensionResponse

| Property | Type | Description |
|----------|------|-------------|
| shareId | string | Share payload identifier |
| dispatchState | string | Dispatch state: dispatched, queued, or failed |
| dispatchedAt | string | ISO timestamp when dispatched or queued |

### DoNotDisturbSettingsResponse

| Property | Type | Description |
|----------|------|-------------|
| userId | string | Unique identifier of the user |
| enabled | boolean | Indicates whether Do-Not-Disturb mode is enabled |
| until | string | ISO-8601 timestamp when Do-Not-Disturb mode ends; null if indefinite |
| schedule | object | Optional recurring schedule for Do-Not-Disturb |
| updatedAt | string | Timestamp of the last update |

### DownloadAudioMessageRequest

### DownloadBackupRequest

### DownloadBackupResponse

| Property | Type | Description |
|----------|------|-------------|
| backupId | string | Backup ID |
| downloadUrl | string | Time-limited URL to download the encrypted archive |
| expiresAt | string | Expiration timestamp for the download URL |

### EditMessageRequest

| Property | Type | Description |
|----------|------|-------------|
| ciphertext | string | Encrypted message content (Signal Protocol ciphertext) |
| nonce | string | Nonce/IV used for encryption |
| clientEditId | string | Client-generated idempotency key for the edit |
| editedAt | string | ISO 8601 timestamp when the edit was performed on the client |

### EditMessageResponse

| Property | Type | Description |
|----------|------|-------------|
| messageId | string | Unique identifier of the edited message |
| editedAt | string | ISO 8601 timestamp when the edit was accepted by the server |
| version | integer | Incremented message version after edit |
| status | string | Edit status (e.g., accepted, queued) |

### EmptyRequest

### EnablePinRequest

| Property | Type | Description |
|----------|------|-------------|
| pin | string | User-defined PIN (4-8 digits) |
| pinHint | string | Optional hint to help the user remember the PIN |

### EnablePinResponse

| Property | Type | Description |
|----------|------|-------------|
| userId | string | User ID |
| pinEnabled | boolean | Indicates whether PIN security is enabled |
| enabledAt | string | Timestamp when PIN was enabled |

### EnableTwoFactorRequest

| Property | Type | Description |
|----------|------|-------------|
| pin | string | 6-digit PIN for 2FA |

### EnableTwoFactorResponse

| Property | Type | Description |
|----------|------|-------------|
| userId | string | User ID |
| twoFactorEnabled | boolean | Indicates whether 2FA is enabled |

### EndCallRequest

| Property | Type | Description |
|----------|------|-------------|
| reason | string | Reason for ending the call (completed, declined, error) |

### EndCallResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Call ID |
| status | string | Updated call status |
| endedAt | string | ISO 8601 timestamp when the call ended |

### EndGroupCallRequest

### EndGroupCallResponse

| Property | Type | Description |
|----------|------|-------------|
| callId | string | Group call ID |
| status | string | Termination status |
| endedAt | string | ISO timestamp when the call ended |

### EndScreenShareRequest

| Property | Type | Description |
|----------|------|-------------|
| reason | string | Reason for ending the screen share |

### EndScreenShareResponse

| Property | Type | Description |
|----------|------|-------------|
| screenShareId | string | Screen share session ID |
| status | string | Final status of the screen share session |
| endedAt | string | ISO timestamp when the session ended |

### EnqueueOfflineMessageRequest

| Property | Type | Description |
|----------|------|-------------|
| messageId | string | Client-generated message ID |
| ciphertext | string | Signal Protocol encrypted payload |
| metadata | object | Message metadata such as type, timestamp, and recipient scope |

### EnqueueOfflineMessageResponse

| Property | Type | Description |
|----------|------|-------------|
| messageId | string | Client-generated message ID |
| queuePosition | integer | Position in the offline queue |
| queuedAt | string | ISO-8601 timestamp when the message was queued |

### FavoriteContactsListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of favorite contacts |
| page | integer | Current page number |
| pageSize | integer | Items per page |
| total | integer | Total number of favorite contacts |

### FinalizeMediaDraftRequest

| Property | Type | Description |
|----------|------|-------------|
| clientFinalizeId | string | Client-generated ID for offline queue reconciliation |

### FinalizeMediaDraftResponse

| Property | Type | Description |
|----------|------|-------------|
| mediaId | string | Finalized media asset ID |
| draftId | string | Draft ID |
| status | string | Finalization status (e.g., finalized) |

### ForwardMessageRequest

| Property | Type | Description |
|----------|------|-------------|
| recipients | array | List of recipients to forward to (max 256 for broadcast lists). Each item must specify exactly one of userId, groupId, or broadcastListId. |
| forwardedText | string | Optional text to accompany the forwarded message |
| e2eEnvelope | object | Signal Protocol envelope per recipient |
| clientQueueId | string | Client-generated ID for offline queue tracking |

### ForwardMessageResponse

| Property | Type | Description |
|----------|------|-------------|
| forwardedMessageId | string | ID of the newly created forwarded message |
| status | string | Forwarding status |
| queued | boolean | Indicates if the message is queued for delivery |
| createdAt | string | ISO 8601 timestamp of creation |

### GalleryItemListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of gallery items |
| page | integer | Current page |
| pageSize | integer | Page size |
| totalItems | integer | Total number of items |

### GetAccessibilitySettingsRequest

### GetAwayMessageRequest

### GetBackupRequest

### GetBroadcastListRequest

### GetBusinessProfileRequest

### GetBusinessVerificationStatusRequest

### GetCallLinkRequest

### GetCallNotificationSettingsRequest

### GetCallPrivacySettingsRequest

### GetCallRequest

### GetCallResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Call ID |
| callType | string | Type of call |
| status | string | Current call status |
| participants | array | Current participants in the call |
| createdAt | string | ISO 8601 timestamp when the call was created |
| endedAt | string | ISO 8601 timestamp when the call ended |

### GetCartRequest

### GetChatHistoryArchiveRequest

### GetChatHistoryTransferSessionRequest

### GetChatMediaRequest

### GetChatMediaResponse

| Property | Type | Description |
|----------|------|-------------|
| mediaId | string | Media ID |
| chatId | string | Chat ID |
| downloadUrl | string | Time-limited URL to download the media |
| expiresAt | string | Download URL expiration timestamp in ISO-8601 format |
| mimeType | string | MIME type of the media |
| sizeBytes | integer | Size of the media in bytes |

### GetCommunityRequest

### GetContactLabelRequest

### GetContrastRequirementsRequest

### GetDataUsageSettingsRequest

### GetDataUsageSummaryRequest

### GetDesktopAppReleaseRequest

### GetDeviceRequest

### GetGreetingSettingsRequest

### GetGroupCallRequest

### GetGroupCallResponse

| Property | Type | Description |
|----------|------|-------------|
| callId | string | Group call ID |
| groupId | string | Group ID |
| mediaType | string | Media type: audio or video |
| status | string | Call status |
| createdAt | string | ISO timestamp |
| participantCount | integer | Current number of participants |

### GetGroupInvitePolicyRequest

### GetGroupRequest

### GetInfoVisibilitySettingsRequest

### GetIntegrationAppRequest

### GetInviteLinkDetailsRequest

### GetMediaRequest

### GetMediaResponse

| Property | Type | Description |
|----------|------|-------------|
| mediaId | string | Media resource identifier |
| downloadUrl | string | URL for downloading the encrypted media |
| mimeType | string | MIME type of the media |
| contentLength | integer | Total size in bytes |
| hd | boolean | Whether the media is HD quality |
| expiresAt | string | Download URL expiration timestamp |

### GetMessagesByDateRequest

### GetNotificationPreferencesRequest

### GetPinStatusRequest

### GetPinStatusResponse

| Property | Type | Description |
|----------|------|-------------|
| userId | string | User ID |
| pinEnabled | boolean | Indicates whether PIN security is enabled |
| enabledAt | string | Timestamp when PIN was enabled |

### GetPresenceVisibilityRequest

### GetProfileImageRequest

### GetReadReceiptSettingsRequest

### GetRecipientPreKeysRequest

### GetSecurityCodeVerificationRequest

### GetSpamCheckRequest

### GetSpamCheckResponse

| Property | Type | Description |
|----------|------|-------------|
| spamCheckId | string | Spam check job ID |
| status | string | Status of the spam check (queued, processing, completed) |
| isSpam | boolean | Spam classification result |
| score | number | Spam score between 0 and 1 |
| reasonCodes | array | List of rule or model signals that contributed to the decision |
| evaluatedAt | string | ISO-8601 timestamp when evaluation completed |

### GetStartupResourcesRequest

### GetStatusVisibilitySettingsRequest

### GetThemePreferenceRequest

### GetTranscriptionRequest

### GetTwoFactorStatusRequest

### GetTwoFactorStatusResponse

| Property | Type | Description |
|----------|------|-------------|
| userId | string | User ID |
| twoFactorEnabled | boolean | Indicates whether 2FA is enabled |

### GetUnknownSenderRequest

### GetUserAccessibilitySettingsRequest

### GetUserChatBackgroundRequest

### GetUserLocalizationPreferencesRequest

### GetUserProfileRequest

### GetUserQrCodeRequest

### GetUserRegionalFormatsRequest

### GetViewOnceMediaRequest

### GifSearchResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of GIF results |
| page | integer | Current page number |
| pageSize | integer | Number of items per page |
| total | integer | Total number of matching GIFs |

### GreetingMessageListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of greeting messages |
| page | integer | Current page number |
| pageSize | integer | Number of items per page |
| totalItems | integer | Total number of greeting messages |

### GreetingMessageResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Greeting message ID |
| conversationId | string | Conversation ID |
| senderId | string | User ID of the greeting sender |
| recipientId | string | User ID of the greeting recipient |
| message | string | Greeting message content |
| createdAt | string | ISO-8601 timestamp when the greeting was created |
| status | string | Message delivery status (queued|sent|delivered) |

### GreetingSettingsResponse

| Property | Type | Description |
|----------|------|-------------|
| userId | string | User ID |
| enabled | boolean | Whether automatic greetings are enabled |
| message | string | Greeting message content |
| language | string | ISO language code for the greeting message |
| updatedAt | string | ISO-8601 timestamp of last update |

### GroupEventListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of group events |
| page | integer | Current page number |
| pageSize | integer | Number of items per page |
| totalItems | integer | Total number of events |
| totalPages | integer | Total number of pages |

### GroupEventResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Event ID |
| groupId | string | Group ID |
| title | string | Event title |
| description | string | Event description |
| startTime | string | ISO-8601 start date-time |
| endTime | string | ISO-8601 end date-time |
| location | string | Event location or meeting link |
| timezone | string | IANA timezone |
| visibility | string | Event visibility within group |
| maxParticipants | integer | Optional cap on participants |
| createdAt | string | ISO-8601 creation timestamp |
| updatedAt | string | ISO-8601 last update timestamp |

### GroupInviteLinkResponse

| Property | Type | Description |
|----------|------|-------------|
| inviteId | string | Invite link ID |
| inviteToken | string | Opaque token embedded in the invite link |
| inviteUrl | string | Full invite URL to share |
| groupId | string | Group ID |
| expiresAt | string | ISO-8601 expiration timestamp |
| maxUses | integer | Maximum number of uses |
| uses | integer | Current number of uses |
| requireApproval | boolean | Whether approval is required |
| createdAt | string | ISO-8601 creation timestamp |

### GroupInvitePolicyResponse

| Property | Type | Description |
|----------|------|-------------|
| groupId | string | Unique group ID |
| invitePolicy | string | Policy defining who can add members |
| updatedAt | string | Timestamp of last update |

### GroupListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of groups |
| page | integer | Current page |
| pageSize | integer | Items per page |
| total | integer | Total items |

### GroupMemberListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of members |
| page | integer | Current page |
| pageSize | integer | Items per page |
| total | integer | Total items |

### GroupMessageResponse

| Property | Type | Description |
|----------|------|-------------|
| messageId | string | Server-assigned message ID |
| groupId | string | Group chat ID |
| createdAt | string | ISO-8601 timestamp of creation |
| mentions | array | List of mentioned user IDs acknowledged by server |

### GroupResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Group ID |
| name | string | Group name |
| description | string | Group description |
| settings | object | Group settings |

### GroupSettingsResponse

| Property | Type | Description |
|----------|------|-------------|
| groupId | string | Unique group ID |
| name | string | Group display name |
| description | string | Group description |
| isPublic | boolean | Whether the group is discoverable |
| joinPolicy | string | Join policy (open, approval, inviteOnly) |
| memberPostingPolicy | string | Who can post messages (all, adminsOnly) |
| mediaSharingEnabled | boolean | Whether media sharing is allowed |
| maxMembers | integer | Maximum members allowed (max 1024) |
| encryptionEnabled | boolean | End-to-end encryption enabled |
| ephemeralMessagesEnabled | boolean | Whether ephemeral messages are enabled |
| ephemeralMessageTTLSeconds | integer | TTL for ephemeral messages in seconds |
| updatedAt | string | Last update timestamp in ISO 8601 |

### HandleUnknownSenderRequest

| Property | Type | Description |
|----------|------|-------------|
| action | string | Action to perform (approve or block) |

### HandleUnknownSenderResponse

| Property | Type | Description |
|----------|------|-------------|
| senderId | string | Sender ID |
| status | string | Updated handling status (approved or blocked) |
| processedAt | string | Timestamp when the action was processed (ISO 8601) |

### HealthCheckRequest

### HealthCheckResponse

| Property | Type | Description |
|----------|------|-------------|
| status | string | Service status |
| timestamp | string | ISO-8601 timestamp |

### InfoVisibilitySettingsResponse

| Property | Type | Description |
|----------|------|-------------|
| userId | string | User ID |
| infoTextVisibility | string | Visibility of the user's info text |
| statusTextVisibility | string | Visibility of the user's status text |
| updatedAt | string | Last update timestamp (ISO 8601) |

### IntegrationAppListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of integration apps |
| page | integer | Current page |
| pageSize | integer | Page size |
| total | integer | Total items |

### IntegrationAppResponse

| Property | Type | Description |
|----------|------|-------------|
| appId | string | Integration app ID |
| name | string | App name |
| status | string | App status |
| callbackUrl | string | Default webhook callback URL |
| createdAt | string | ISO-8601 creation time |

### InviteContactRequest

| Property | Type | Description |
|----------|------|-------------|
| channel | string | Invitation channel: sms or email |
| destination | string | Phone number or email address to send the invite to |
| message | string | Optional custom invitation message |

### InviteContactResponse

| Property | Type | Description |
|----------|------|-------------|
| invitationId | string | Invitation ID |
| status | string | Invitation status: sent, queued |
| expiresAt | string | Expiration timestamp in ISO 8601 |

### InviteLinkDetailsResponse

| Property | Type | Description |
|----------|------|-------------|
| inviteToken | string | Invite token |
| groupId | string | Group ID |
| groupName | string | Group name |
| groupAvatarUrl | string | Group avatar URL |
| memberCount | integer | Current number of group members |
| maxMembers | integer | Maximum allowed group members |
| expiresAt | string | ISO-8601 expiration timestamp |
| requireApproval | boolean | Whether approval is required |
| status | string | Invite link status: active, expired, revoked, maxUsesReached |

### IssueTokenRequest

| Property | Type | Description |
|----------|------|-------------|
| clientId | string | Client ID |
| clientSecret | string | Client secret |

### JoinCallRequest

| Property | Type | Description |
|----------|------|-------------|
| e2eKeyBundleId | string | Signal Protocol key bundle ID for E2E encryption setup |
| deviceId | string | Joining device identifier |

### JoinCallResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Call ID |
| participantId | string | Joined participant ID |
| iceServers | array | WebRTC ICE servers configuration |
| signalingChannel | string | WebSocket channel identifier for real-time signaling |
| status | string | Current call status |

### JoinGroupCallRequest

| Property | Type | Description |
|----------|------|-------------|
| participantId | string | Participant ID joining the call |
| webrtcOffer | string | SDP offer for WebRTC negotiation |
| e2eKeyPackage | string | Signal Protocol key package for end-to-end encryption |

### JoinGroupCallResponse

| Property | Type | Description |
|----------|------|-------------|
| sessionId | string | Participant session ID |
| webrtcAnswer | string | SDP answer for WebRTC negotiation |
| iceServers | array | List of ICE servers for WebRTC connectivity |

### LanguagesListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of supported languages |
| page | integer | Current page number |
| pageSize | integer | Number of items per page |
| totalItems | integer | Total number of supported languages |

### LeaveGroupRequest

### LeaveGroupResponse

| Property | Type | Description |
|----------|------|-------------|
| groupId | string | Group ID |
| memberId | string | ID of the member who left |
| leftAt | string | ISO 8601 timestamp when the member left |
| notificationSent | boolean | Indicates whether a notification was sent |

### ListAiChatMessagesRequest

### ListBackupsRequest

### ListBiometricCredentialsRequest

### ListBiometricCredentialsResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of biometric credentials |
| page | integer | Current page number |
| pageSize | integer | Number of items per page |
| totalItems | integer | Total number of credentials |

### ListBlockedContactsRequest

### ListBroadcastListsRequest

### ListBusinessProfilesRequest

### ListCallLinksRequest

### ListCallsRequest

### ListCartItemsRequest

### ListChatBackgroundsRequest

### ListCommunitiesRequest

### ListCommunityGroupsRequest

### ListContactLabelsForContactRequest

### ListContactLabelsRequest

### ListContactsByLabelRequest

### ListDesktopAppReleasesRequest

### ListDevicesRequest

### ListFavoriteContactsRequest

### ListGreetingMessagesRequest

### ListGroupCallParticipantsRequest

### ListGroupCallParticipantsResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | Participant list |
| page | integer | Current page number |
| pageSize | integer | Items per page |
| totalItems | integer | Total number of participants |
| totalPages | integer | Total number of pages |

### ListGroupMembersRequest

### ListGroupsRequest

### ListIntegrationAppsRequest

### ListMediaByTypeRequest

### ListMessagesRequest

### ListPinnedChatsRequest

### ListPresenceAllowedUsersRequest

### ListPresenceDeniedUsersRequest

### ListPushNotificationsRequest

### ListQueuedMessagesRequest

### ListQueuedMessagesResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of queued encrypted messages |
| page | integer | Current page number |
| pageSize | integer | Number of items per page |
| totalItems | integer | Total number of queued messages |

### ListReactionsRequest

### ListRegionalFormatsRequest

### ListSecurityCodeVerificationsRequest

### ListShareTargetsRequest

### ListShareTargetsResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of share targets |
| page | integer | Current page |
| pageSize | integer | Items per page |
| totalItems | integer | Total number of available targets |

### ListSignalingMessagesRequest

### ListStatusMutesRequest

### ListSupportedLocalesRequest

### ListSupportedLocalesResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of supported locales |
| page | integer | Current page number |
| pageSize | integer | Items per page |
| totalItems | integer | Total number of supported locales |

### ListTranscriptionsRequest

### ListUnknownSenderMessagesRequest

### ListUnknownSendersRequest

### ListUserPasskeysRequest

### ListVoiceAssistantLinksRequest

### ListVoiceAssistantsRequest

### ListWatchDevicesRequest

### ListWebhooksRequest

### LocationMessageResponse

| Property | Type | Description |
|----------|------|-------------|
| messageId | string | Server-assigned message ID |
| conversationId | string | Conversation ID |
| clientMessageId | string | Client-generated idempotency key |
| status | string | Delivery status |
| createdAt | string | Server timestamp when message was created |

### LockChatRequest

| Property | Type | Description |
|----------|------|-------------|
| authMethod | string | Additional authentication method used (e.g., biometric, otp, devicePin) |
| authToken | string | Proof of additional authentication (e.g., OTP code or signed device assertion) |
| deviceId | string | Identifier of the client device used for authentication |

### MarkReactionNotificationReadRequest

| Property | Type | Description |
|----------|------|-------------|
| readAt | string | ISO-8601 timestamp when the notification was read |

### MediaDraftEditsResponse

| Property | Type | Description |
|----------|------|-------------|
| draftId | string | Draft ID |
| status | string | Edit status (e.g., updated) |
| appliedEdits | object | Echo of applied edits |

### MediaDraftResponse

| Property | Type | Description |
|----------|------|-------------|
| draftId | string | Server-generated draft ID |
| status | string | Draft status (e.g., created) |
| sizeBytes | integer | Size of the uploaded image in bytes |

### MediaListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of media items matching the filters |
| page | integer | Current page number |
| pageSize | integer | Number of items per page |
| totalItems | integer | Total number of matching items |
| totalPages | integer | Total number of pages |

### MediaResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Media ID |
| url | string | Download URL for the media |
| sizeBytes | integer | Size of the uploaded file in bytes |

### MessageListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of message metadata |
| page | integer | Current page |
| pageSize | integer | Page size |
| total | integer | Total items |

### MessageResponse

| Property | Type | Description |
|----------|------|-------------|
| messageId | string | Message ID |
| chatId | string | Chat ID |
| type | string | Message type |
| status | string | Message status (queued, sent, delivered) |
| serverTimestamp | string | Server timestamp in ISO 8601 |

### MessageSearchResponse

| Property | Type | Description |
|----------|------|-------------|
| page | integer | Current page number |
| pageSize | integer | Number of items per page |
| total | integer | Total number of matching messages |
| results | array | List of matching messages |

### MessagesByDateResponse

| Property | Type | Description |
|----------|------|-------------|
| conversationId | string | Eindeutige ID der Konversation |
| anchorDate | string | Das verwendete Sprungdatum (ISO-8601) |
| direction | string | Tatsaechlich verwendete Richtung |
| messages | array | Liste der Nachrichten |
| page | integer | Aktuelle Seite |
| pageSize | integer | Seitengroesse |
| totalCount | integer | Gesamtanzahl der Nachrichten im Zeitraum |

### MessagesSyncAckRequest

| Property | Type | Description |
|----------|------|-------------|
| messageIds | array | List of message IDs that were successfully processed |
| lastSyncTimestamp | string | Client's last processed timestamp in ISO-8601 |

### MessagesSyncAckResponse

| Property | Type | Description |
|----------|------|-------------|
| acknowledgedCount | integer | Number of messages acknowledged |
| serverTimestamp | string | Server timestamp confirming acknowledgment |

### MessagesSyncRequest

### MessagesSyncResponse

| Property | Type | Description |
|----------|------|-------------|
| nextCursor | string | Cursor for the next page of results |
| hasMore | boolean | Indicates if more results are available |
| messages | array | List of encrypted message envelopes |

### NotificationPreferencesResponse

| Property | Type | Description |
|----------|------|-------------|
| userId | string | User ID |
| previewEnabled | boolean | Whether notification previews are enabled |
| previewMode | string | Preview mode (none|senderOnly|senderAndMessage) |
| showMediaThumbnails | boolean | Whether to show media thumbnails in notifications |
| updatedAt | string | Last update timestamp (ISO 8601) |

### NotificationPreviewResponse

| Property | Type | Description |
|----------|------|-------------|
| messageId | string | Message ID |
| previewTitle | string | Preview title (e.g., sender name) |
| previewBody | string | Preview body based on user preferences |
| hasThumbnail | boolean | Whether a thumbnail is included |
| thumbnailUrl | string | URL to thumbnail if available |

### OfflineQueueListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | Queued messages |
| page | integer | Current page number |
| pageSize | integer | Number of items per page |
| totalItems | integer | Total number of queued items |

### OfflineQueueResponse

| Property | Type | Description |
|----------|------|-------------|
| queueId | string | Offline queue ID |
| deviceId | string | Unique device identifier |
| createdAt | string | ISO-8601 timestamp of queue creation |

### PairWatchDeviceRequest

| Property | Type | Description |
|----------|------|-------------|
| pairingCode | string | One-time pairing code |
| devicePreKeyBundle | string | Signal Protocol pre-key bundle for secure session |

### PairWatchDeviceResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Smartwatch device ID |
| paired | boolean | Pairing status |
| pairedAt | string | Pairing timestamp |

### PasskeyAuthenticationOptionsRequest

| Property | Type | Description |
|----------|------|-------------|
| username | string | Unique username or handle for allowCredentials lookup |
| deviceId | string | Client device identifier |
| platform | string | Client platform (ios, android, web) |

### PasskeyAuthenticationOptionsResponse

| Property | Type | Description |
|----------|------|-------------|
| challenge | string | Base64URL-encoded challenge |
| allowCredentials | array | Allowed credentials for the user |
| timeout | integer | Timeout in milliseconds |
| userVerification | string | User verification requirement |

### PasskeyAuthenticationVerifyRequest

| Property | Type | Description |
|----------|------|-------------|
| username | string | Unique username or handle |
| credential | object | WebAuthn credential assertion from the client |
| deviceId | string | Client device identifier |
| platform | string | Client platform (ios, android, web) |

### PasskeyAuthenticationVerifyResponse

| Property | Type | Description |
|----------|------|-------------|
| accessToken | string | JWT access token |
| refreshToken | string | Refresh token |
| expiresIn | integer | Access token lifetime in seconds |
| userId | string | Authenticated user ID |

### PasskeyRegistrationOptionsRequest

| Property | Type | Description |
|----------|------|-------------|
| username | string | Unique username or handle for the user |
| displayName | string | Human-readable display name |
| deviceId | string | Client device identifier for risk checks and allow-listing |
| platform | string | Client platform (ios, android, web) |

### PasskeyRegistrationOptionsResponse

| Property | Type | Description |
|----------|------|-------------|
| challenge | string | Base64URL-encoded challenge |
| rp | object | Relying party information |
| user | object | User information |
| pubKeyCredParams | array | Supported public key credential parameters |
| timeout | integer | Timeout in milliseconds |
| attestation | string | Attestation conveyance preference |

### PasskeyRegistrationVerifyRequest

| Property | Type | Description |
|----------|------|-------------|
| username | string | Unique username or handle |
| credential | object | WebAuthn credential response from the client |
| deviceId | string | Client device identifier |
| platform | string | Client platform (ios, android, web) |

### PasskeyRegistrationVerifyResponse

| Property | Type | Description |
|----------|------|-------------|
| userId | string | User ID |
| credentialId | string | Stored credential ID |
| status | string | Verification status |

### PaymentDetailsResponse

| Property | Type | Description |
|----------|------|-------------|
| paymentId | string | Unique payment identifier |
| senderUserId | string | User ID of the payment sender |
| receiverUserId | string | User ID of the payment receiver |
| amount | number | Payment amount in minor units |
| currency | string | ISO 4217 currency code |
| market | string | Market code where payment is processed |
| status | string | Payment status (pending, completed, failed) |
| note | string | Optional payment note |
| createdAt | string | ISO 8601 timestamp when payment was created |

### PaymentListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of payments |
| page | integer | Current page number |
| pageSize | integer | Number of items per page |
| totalItems | integer | Total number of payments |

### PaymentMarketsResponse

| Property | Type | Description |
|----------|------|-------------|
| markets | array | List of supported market codes |

### PaymentResponse

| Property | Type | Description |
|----------|------|-------------|
| paymentId | string | Unique payment identifier |
| status | string | Payment status (pending, completed, failed) |
| amount | number | Payment amount in minor units |
| currency | string | ISO 4217 currency code |
| market | string | Market code where payment is processed |
| createdAt | string | ISO 8601 timestamp when payment was created |

### PinChatRequest

| Property | Type | Description |
|----------|------|-------------|
| clientTimestamp | string | Clientzeitpunkt (ISO 8601) fuer Offline-Queue und Konfliktaufloesung |

### PinChatResponse

| Property | Type | Description |
|----------|------|-------------|
| chatId | string | Eindeutige Chat-ID |
| isPinned | boolean | Pin-Status des Chats |
| pinnedAt | string | Zeitpunkt des Anpinnens (ISO 8601) |

### PinnedChatsListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | Liste der angepinnten Chats |
| page | integer | Aktuelle Seite |
| pageSize | integer | Groesse der Seite |
| totalItems | integer | Gesamtanzahl der angepinnten Chats |

### PollDetailResponse

| Property | Type | Description |
|----------|------|-------------|
| pollId | string | Poll ID |
| chatId | string | Chat ID |
| questionCiphertext | string | Encrypted poll question |
| optionsCiphertexts | array | Encrypted poll options |
| allowsMultipleChoices | boolean | Whether multiple options can be selected |
| status | string | Poll status (active|closed) |
| tallyCiphertext | string | Encrypted tally snapshot for clients |
| createdAt | string | ISO-8601 creation timestamp |
| expiresAt | string | ISO-8601 expiration timestamp |

### PollListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of polls |
| page | integer | Current page |
| pageSize | integer | Current page size |
| total | integer | Total number of polls |

### PollResponse

| Property | Type | Description |
|----------|------|-------------|
| pollId | string | Poll ID |
| chatId | string | Chat ID |
| createdAt | string | ISO-8601 creation timestamp |
| status | string | Poll status (active|closed) |

### PowerPolicyResponse

| Property | Type | Description |
|----------|------|-------------|
| policyVersion | string | Version of the power policy |
| syncIntervalSeconds | integer | Recommended minimum sync interval in seconds |
| websocketKeepaliveSeconds | integer | Recommended websocket keepalive interval in seconds |
| backgroundFetchWindowSeconds | integer | Recommended background fetch window in seconds |
| maxConcurrentTransfers | integer | Recommended maximum concurrent media transfers |

### PresenceAllowedUsersResponse

| Property | Type | Description |
|----------|------|-------------|
| userId | string | User ID |
| items | array | Allowed users |
| page | integer | Current page number |
| pageSize | integer | Number of items per page |
| total | integer | Total number of items |

### PresenceDeniedUsersResponse

| Property | Type | Description |
|----------|------|-------------|
| userId | string | User ID |
| items | array | Denied users |
| page | integer | Current page number |
| pageSize | integer | Number of items per page |
| total | integer | Total number of items |

### PresenceVisibilityResponse

| Property | Type | Description |
|----------|------|-------------|
| userId | string | User ID |
| visibility | string | Visibility scope for online/last seen status |
| customAllowListCount | integer | Count of users explicitly allowed when visibility is custom |
| customDenyListCount | integer | Count of users explicitly denied when visibility is custom |
| updatedAt | string | ISO 8601 timestamp when the setting was last updated |

### ProfileImageResponse

| Property | Type | Description |
|----------|------|-------------|
| imageId | string | Profile image ID |
| userId | string | User ID |
| url | string | URL to access the profile image |
| updatedAt | string | Update timestamp (ISO 8601) |

### ProfilePictureVisibilityResponse

| Property | Type | Description |
|----------|------|-------------|
| userId | string | User ID |
| visibility | string | Visibility setting for profile picture |
| updatedAt | string | ISO-8601 timestamp of last update |

### PurgeStorageItemsRequest

| Property | Type | Description |
|----------|------|-------------|
| type | string | Media type to purge (image, document, video, audio, other) |
| olderThanDays | integer | Purge items older than the specified number of days |
| maxItems | integer | Maximum number of items to delete |

### PurgeStorageItemsResponse

| Property | Type | Description |
|----------|------|-------------|
| deletedCount | integer | Number of items deleted |
| requestedAt | string | ISO 8601 timestamp of purge request |

### PushNotificationListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of notifications |
| page | integer | Current page |
| pageSize | integer | Items per page |
| total | integer | Total items |

### PushNotificationResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Notification ID |
| recipientType | string | Recipient type |
| recipientId | string | Recipient ID |
| status | string | Notification status: queued, sent, delivered |
| createdAt | string | ISO-8601 timestamp |

### PushTokenResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Push token registration ID |
| platform | string | Device platform |
| deviceId | string | Unique device identifier |
| pushToken | string | Platform push token |
| createdAt | string | ISO-8601 timestamp |

### QueuedMessagesResponse

| Property | Type | Description |
|----------|------|-------------|
| page | integer | Current page |
| pageSize | integer | Items per page |
| total | integer | Total queued messages |
| items | array | Queued encrypted messages |

### QuickReplyListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of quick replies |
| page | integer | Current page number |
| pageSize | integer | Number of items per page |
| totalItems | integer | Total number of items |
| totalPages | integer | Total number of pages |

### QuickReplyResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Quick reply ID |
| businessId | string | Business ID |
| title | string | Short label for the quick reply |
| message | string | Message text to be sent |
| language | string | BCP-47 language tag for the quick reply |
| isActive | boolean | Whether the quick reply is active |
| createdAt | string | ISO 8601 creation timestamp |
| updatedAt | string | ISO 8601 last update timestamp |

### ReactionListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of reactions |
| page | integer | Current page |
| pageSize | integer | Items per page |
| totalItems | integer | Total number of reactions |

### ReactionNotificationListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of reaction notifications |
| page | integer | Current page number |
| pageSize | integer | Number of items per page |
| totalItems | integer | Total number of notifications |
| totalPages | integer | Total number of pages |

### ReactionNotificationReadResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Notification ID |
| readAt | string | ISO-8601 timestamp when the notification was read |
| status | string | Read status |

### ReactionResponse

| Property | Type | Description |
|----------|------|-------------|
| reactionId | string | Reaction ID |
| messageId | string | Message ID |
| emoji | string | Emoji unicode character |
| userId | string | User ID who reacted |
| createdAt | string | ISO-8601 timestamp when reaction was created |

### ReadReceiptSettingsResponse

| Property | Type | Description |
|----------|------|-------------|
| userId | string | User ID |
| globalEnabled | boolean | Whether read receipts are enabled globally |
| conversationOverrides | array | Per-conversation overrides |
| updatedAt | string | ISO-8601 timestamp of last update |

### RecipientPreKeysResponse

| Property | Type | Description |
|----------|------|-------------|
| recipientId | string | Recipient user identifier |
| deviceId | string | Recipient device identifier |
| identityKey | string | Base64-encoded identity public key |
| signedPreKey | string | Base64-encoded signed prekey public key |
| signedPreKeySignature | string | Base64-encoded signature of the signed prekey |
| oneTimePreKey | string | Base64-encoded one-time prekey |

### RegionalFormatsListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of supported regional formats |
| page | integer | Current page number |
| pageSize | integer | Current page size |
| totalItems | integer | Total number of supported regional formats |

### RegisterDeviceRequest

| Property | Type | Description |
|----------|------|-------------|
| deviceName | string | Human-readable device name |
| platform | string | Device platform (ios, android, web) |
| deviceFingerprint | string | Unique device fingerprint |
| identityKey | string | Signal Protocol identity key (base64) |
| registrationId | integer | Signal Protocol registration ID |
| pushToken | string | Push notification token for the device |
| websocketCapable | boolean | Whether device supports WebSocket connectivity |

### RegisterEncryptionKeysRequest

| Property | Type | Description |
|----------|------|-------------|
| deviceId | string | Client device identifier |
| identityKey | string | Base64-encoded identity public key |
| signedPreKey | string | Base64-encoded signed prekey public key |
| signedPreKeySignature | string | Base64-encoded signature of the signed prekey |
| oneTimePreKeys | array | Array of base64-encoded one-time prekeys |

### RegisterEncryptionKeysResponse

| Property | Type | Description |
|----------|------|-------------|
| deviceId | string | Client device identifier |
| status | string | Registration status |

### RegisterKeysRequest

| Property | Type | Description |
|----------|------|-------------|
| identityKey | string | Signal identity public key |
| signedPreKey | string | Signal signed pre-key |
| oneTimePreKeys | array | List of one-time pre-keys |

### RegisterKeysResponse

| Property | Type | Description |
|----------|------|-------------|
| status | string | Registration status |
| registeredAt | string | ISO-8601 registration time |

### RegisterPushTokenRequest

| Property | Type | Description |
|----------|------|-------------|
| platform | string | Device platform: ios or android |
| deviceId | string | Unique device identifier |
| pushToken | string | Platform push token |
| appVersion | string | Client app version |

### RegisterWebhookRequest

| Property | Type | Description |
|----------|------|-------------|
| url | string | Webhook URL |
| events | array | Subscribed events |
| secret | string | Signing secret |

### RejectCallRequest

| Property | Type | Description |
|----------|------|-------------|
| reason | string | Reason for rejection (e.g., busy, declined, unavailable) |
| messageCiphertext | string | End-to-end encrypted message payload (Signal Protocol) |
| messageType | string | Message type (e.g., text, quickReply) |
| clientMessageId | string | Client-generated idempotency key for offline queueing |
| timestamp | string | Client timestamp in ISO-8601 format |

### RejectCallResponse

| Property | Type | Description |
|----------|------|-------------|
| callId | string | Unique call identifier |
| status | string | Rejection status (e.g., rejected) |
| messageQueued | boolean | Indicates whether the message was queued for delivery |
| serverTimestamp | string | Server timestamp in ISO-8601 format |

### RemoveBroadcastRecipientsRequest

| Property | Type | Description |
|----------|------|-------------|
| recipientIds | array | Recipient user IDs to remove |

### RemoveCartItemRequest

### RemoveCartItemResponse

| Property | Type | Description |
|----------|------|-------------|
| removed | boolean | Indicates if the item was removed |

### RemoveFavoriteContactRequest

### RemoveFavoriteContactResponse

| Property | Type | Description |
|----------|------|-------------|
| userId | string | User ID |
| contactId | string | Contact ID |
| removed | boolean | Indicates whether the favorite was removed |

### RemoveGroupCallParticipantRequest

### RemoveGroupCallParticipantResponse

| Property | Type | Description |
|----------|------|-------------|
| callId | string | Group call ID |
| participantId | string | Participant ID removed |
| status | string | Removal status |

### RemoveGroupFromCommunityRequest

### RemoveGroupFromCommunityResponse

| Property | Type | Description |
|----------|------|-------------|
| communityId | string | Community ID |
| groupId | string | Group ID |
| removed | boolean | Indicates whether the group link was removed |

### RemoveGroupMemberRequest

### RemoveGroupMemberResponse

| Property | Type | Description |
|----------|------|-------------|
| groupId | string | Group ID |
| memberId | string | Removed member ID |
| removed | boolean | Removal status |

### RemoveParticipantRequest

### RemoveParticipantResponse

| Property | Type | Description |
|----------|------|-------------|
| callId | string | Call ID |
| participantId | string | Removed participant ID |
| status | string | Removal status |

### ReplaceProfileImageRequest

| Property | Type | Description |
|----------|------|-------------|
| file | string | Profile image file (max 16MB) |

### ReportResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Report ID |
| status | string | Current status of the report (e.g., submitted, under_review) |
| createdAt | string | ISO 8601 timestamp when the report was created |

### ResendPhoneRegistrationOtpRequest

| Property | Type | Description |
|----------|------|-------------|
| deliveryChannel | string | OTP delivery channel: sms or voice |

### ResendPhoneRegistrationOtpResponse

| Property | Type | Description |
|----------|------|-------------|
| expiresInSeconds | integer | Time until OTP expires |
| status | string | Resend status (pending) |

### RestoreBackupRequest

| Property | Type | Description |
|----------|------|-------------|
| deviceId | string | Target device ID requesting restore |

### RestoreBackupResponse

| Property | Type | Description |
|----------|------|-------------|
| backupId | string | Backup ID |
| deviceId | string | Target device ID |
| restoreToken | string | Server-generated token to authorize restore download |
| status | string | Restore status (e.g., INITIATED) |

### RetentionPolicyRequest

| Property | Type | Description |
|----------|------|-------------|
| statusMaxHours | integer | Maximum status duration in hours (max 24) |
| messageMaxDays | integer | Maximum message retention in days |
| mediaMaxDays | integer | Maximum media retention in days |
| purgeOnDeliveryAck | boolean | Remove server copies after delivery acknowledgment |

### RetentionPolicyResponse

| Property | Type | Description |
|----------|------|-------------|
| statusMaxHours | integer | Configured maximum status duration |
| messageMaxDays | integer | Configured message retention |
| mediaMaxDays | integer | Configured media retention |
| purgeOnDeliveryAck | boolean | Configured purge behavior |

### RevokeDeviceRequest

### RevokeDeviceResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Revoked device ID |
| revokedAt | string | Revocation timestamp (ISO 8601) |

### RevokeGroupInviteLinkRequest

### RevokeGroupInviteLinkResponse

| Property | Type | Description |
|----------|------|-------------|
| inviteId | string | Invite link ID |
| status | string | Revocation status: revoked |
| revokedAt | string | ISO-8601 revocation timestamp |

### RsvpGroupEventRequest

| Property | Type | Description |
|----------|------|-------------|
| status | string | RSVP status (going, maybe, notGoing) |

### RsvpGroupEventResponse

| Property | Type | Description |
|----------|------|-------------|
| eventId | string | Event ID |
| userId | string | User ID |
| status | string | RSVP status |
| updatedAt | string | ISO-8601 last update timestamp |

### ScreenShareListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of screen share sessions |
| page | integer | Current page number |
| pageSize | integer | Page size |
| totalItems | integer | Total number of items |

### ScreenShareResponse

| Property | Type | Description |
|----------|------|-------------|
| screenShareId | string | Screen share session ID |
| callId | string | Call ID |
| publisherId | string | User ID of the screen-share publisher |
| webrtcSdpAnswer | string | WebRTC SDP answer for screen sharing |
| status | string | Current status of the screen share session |
| createdAt | string | ISO timestamp when the session was created |

### SearchChatsRequest

### SearchChatsResponse

| Property | Type | Description |
|----------|------|-------------|
| total | integer | Total number of matching chats |
| page | integer | Current page number |
| pageSize | integer | Number of items per page |
| results | array | List of matching chats |

### SearchContactsRequest

### SearchContactsResponse

| Property | Type | Description |
|----------|------|-------------|
| total | integer | Total number of matching contacts |
| page | integer | Current page number |
| pageSize | integer | Number of items per page |
| results | array | List of matching contacts |

### SearchGifsRequest

### SecurityCodeVerificationConfirmResponse

| Property | Type | Description |
|----------|------|-------------|
| verificationId | string | Verification session ID |
| status | string | Updated verification status |
| updatedAt | string | Server update timestamp (ISO-8601) |

### SecurityCodeVerificationListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of verification sessions |
| page | integer | Current page number |
| pageSize | integer | Number of items per page |
| totalItems | integer | Total number of items |
| totalPages | integer | Total number of pages |

### SecurityCodeVerificationResponse

| Property | Type | Description |
|----------|------|-------------|
| verificationId | string | Verification session ID |
| contactId | string | ID of the contact being verified |
| safetyCode | string | Human-readable safety code for manual comparison |
| qrPayload | string | QR payload for scanning (present when channel=qr) |
| status | string | Current verification status |
| expiresAt | string | Expiration timestamp (ISO-8601) |

### SendBroadcastMessageRequest

| Property | Type | Description |
|----------|------|-------------|
| encryptedPayload | string | Signal Protocol encrypted message payload |
| ciphertextType | string | Ciphertext type (e.g., preKeySignalMessage, signalMessage) |
| clientMessageId | string | Client-generated message ID for de-duplication |
| media | object | Optional media metadata if message includes media |

### SendDocumentMessageRequest

| Property | Type | Description |
|----------|------|-------------|
| recipientType | string | Target type: 'user', 'group', or 'broadcastList' |
| recipientId | string | ID of the target user, group, or broadcast list |
| clientMessageId | string | Client-generated idempotency key for offline queue reconciliation |
| caption | string | Optional caption for the document |
| encryptedPayload | string | Base64-encoded Signal Protocol encrypted message payload |
| attachmentKey | string | Base64-encoded key for encrypting the document attachment |
| attachmentIv | string | Base64-encoded IV for attachment encryption |
| attachmentSha256 | string | Base64-encoded SHA-256 hash of the encrypted attachment |
| file | string | Document file content (max 2GB) |
| fileName | string | Original file name |
| mimeType | string | MIME type of the document |
| sizeBytes | integer | File size in bytes |

### SendDocumentMessageResponse

| Property | Type | Description |
|----------|------|-------------|
| messageId | string | Server-generated message ID |
| documentId | string | Server-generated document attachment ID |
| status | string | Delivery status: 'queued', 'sent', or 'delivered' |
| createdAt | string | ISO-8601 timestamp of message creation |

### SendEncryptedMessageRequest

| Property | Type | Description |
|----------|------|-------------|
| conversationId | string | Conversation identifier |
| recipientId | string | Recipient user identifier (for 1:1 or broadcast) |
| ciphertext | string | Base64-encoded encrypted message payload |
| messageType | string | Type of message (text, media, status, signal) |
| clientMessageId | string | Client-generated idempotency key |

### SendEncryptedMessageResponse

| Property | Type | Description |
|----------|------|-------------|
| messageId | string | Server-assigned message identifier |
| status | string | Delivery state (queued, delivered) |

### SendGifMessageRequest

| Property | Type | Description |
|----------|------|-------------|
| recipientType | string | Target type: user, group, or broadcast |
| recipientId | string | ID of the target user, group, or broadcast list |
| gifId | string | Identifier of the selected GIF from search results |
| mediaUrl | string | Resolved URL to the GIF media (if required by client) |
| caption | string | Optional caption for the GIF |
| encryptedPayload | string | End-to-end encrypted message payload using Signal Protocol |
| clientMessageId | string | Client-generated id for offline queue de-duplication |

### SendGifMessageResponse

| Property | Type | Description |
|----------|------|-------------|
| messageId | string | Server-assigned message identifier |
| status | string | Delivery status: queued or sent |
| timestamp | string | Server timestamp in ISO-8601 format |

### SendImageMessageRequest

| Property | Type | Description |
|----------|------|-------------|
| messageId | string | Client-generated message ID for offline queueing and deduplication |
| mediaId | string | ID of the uploaded image to attach |
| caption | string | Optional caption text |
| encryptionInfo | string | Signal Protocol encryption metadata for the message payload encoded as JSON string |

### SendImageMessageResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Server-generated message ID |
| messageId | string | Client-generated message ID |
| conversationId | string | Conversation ID |
| mediaId | string | Attached image media ID |
| status | string | Delivery status (e.g., queued, sent) |
| createdAt | string | ISO-8601 timestamp of creation |

### SendMediaMessageRequest

| Property | Type | Description |
|----------|------|-------------|
| conversationId | string | Conversation or group ID |
| recipientIds | array | Recipient user IDs for direct or broadcast |
| mediaId | string | Media resource identifier |
| caption | string | Optional caption text |
| encryptionPayload | object | Signal Protocol encrypted message payload |
| messageQueueId | string | Client offline queue ID for deduplication |

### SendMediaMessageResponse

| Property | Type | Description |
|----------|------|-------------|
| messageId | string | Created message identifier |
| status | string | Delivery status |
| createdAt | string | Message creation timestamp |

### SendMessageRequest

| Property | Type | Description |
|----------|------|-------------|
| recipientType | string | Recipient type: user, group, broadcast |
| recipientId | string | Recipient ID |
| ciphertext | string | Signal Protocol encrypted payload |
| messageId | string | Client-generated message ID for offline queueing |
| timestamp | string | Client timestamp |

### SendMessageResponse

| Property | Type | Description |
|----------|------|-------------|
| messageId | string | Message ID |
| status | string | Delivery status |
| queued | boolean | Indicates if message was queued for offline delivery |

### SendStickerMessageRequest

| Property | Type | Description |
|----------|------|-------------|
| messageId | string | Client-generated message ID for offline queue deduplication |
| type | string | Message type, must be 'sticker' |
| stickerId | string | Sticker ID to send |
| encryptedPayload | string | End-to-end encrypted payload (Signal Protocol) |
| sentAt | string | Client timestamp in ISO 8601 |

### SendTextMessageRequest

| Property | Type | Description |
|----------|------|-------------|
| clientMessageId | string | Client-generated idempotency key for deduplication |
| ciphertext | string | Encrypted message payload using Signal Protocol |
| senderDeviceId | string | Sender device identifier |
| sentAt | string | ISO 8601 timestamp when the message was created on the client |

### SendVideoMessageRequest

| Property | Type | Description |
|----------|------|-------------|
| clientMessageId | string | Client-generated id for offline queueing and idempotency |
| recipientType | string | Recipient type: user, group, or broadcast |
| recipientId | string | Target userId, groupId, or broadcastId |
| mediaId | string | Reference to the uploaded video media |
| caption | string | Optional caption text |
| encryption | object | Signal Protocol message encryption metadata |

### SendVideoMessageResponse

| Property | Type | Description |
|----------|------|-------------|
| messageId | string | Server-generated message ID |
| status | string | Message delivery status |
| queuedAt | string | Timestamp when the message was queued/sent |

### SendWatchNotificationRequest

| Property | Type | Description |
|----------|------|-------------|
| ciphertext | string | Encrypted notification payload |
| messageType | string | Type of notification (message, call, status, system) |

### SendWatchNotificationResponse

| Property | Type | Description |
|----------|------|-------------|
| notificationId | string | Notification ID |
| delivered | boolean | Delivery status |

### ShareExtensionAttachmentResponse

| Property | Type | Description |
|----------|------|-------------|
| attachmentId | string | Attachment identifier |
| shareId | string | Associated share payload identifier |
| sizeBytes | integer | Uploaded file size |
| createdAt | string | ISO timestamp of upload |

### ShareExtensionAttachmentUploadRequest

| Property | Type | Description |
|----------|------|-------------|
| file | string | Encrypted media file |
| mediaType | string | Media type: image, video, audio, document |
| originalFileName | string | Original file name |
| e2eKeyId | string | Key identifier used for encryption |

### ShareExtensionResponse

| Property | Type | Description |
|----------|------|-------------|
| shareId | string | Share payload identifier |
| queueState | string | Queue state: queued, dispatched, or failed |
| createdAt | string | ISO timestamp of creation |

### SignalingMessageListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | Queued signaling messages |
| page | integer | Current page |
| pageSize | integer | Page size |
| total | integer | Total queued messages |

### SignalingMessageRequest

| Property | Type | Description |
|----------|------|-------------|
| type | string | Message type: 'offer', 'answer', or 'iceCandidate' |
| payload | string | Encrypted signaling payload (E2EE) |
| senderId | string | Sender user ID |

### SignalingMessageResponse

| Property | Type | Description |
|----------|------|-------------|
| messageId | string | Stored message ID |
| callId | string | Call ID |
| queued | boolean | Whether message is queued for offline delivery |

### SmartRepliesResponse

| Property | Type | Description |
|----------|------|-------------|
| conversationId | string | Eindeutige ID der Unterhaltung |
| suggestionsCiphertext | string | Verschluesselte Antwortvorschlaege (Signal Protocol Payload) |
| suggestionsNonce | string | Nonce fuer die verschluesselten Vorschlaege |
| suggestionsCount | integer | Anzahl der gelieferten Vorschlaege |
| generatedAt | string | Zeitstempel der Generierung im ISO-8601-Format |

### StartChatHistoryExportRequest

| Property | Type | Description |
|----------|------|-------------|
| cursorMessageId | string | Optional message ID to resume export from |
| maxArchiveSizeBytes | integer | Maximum archive size in bytes to enforce device/storage constraints |
| encryptedArchiveKey | string | Archive key wrapped for the target device using Signal Protocol |

### StartChatHistoryExportResponse

| Property | Type | Description |
|----------|------|-------------|
| sessionId | string | Transfer session ID |
| exportJobId | string | Asynchronous export job ID |
| status | string | Export job status |

### StartChatHistoryImportRequest

| Property | Type | Description |
|----------|------|-------------|
| targetDeviceId | string | Identifier of the target device performing the import |
| transferToken | string | One-time token to authorize import on the target device |
| archiveChecksum | string | Checksum of the downloaded archive for integrity verification |
| lastAppliedMessageId | string | Optional last applied message ID to resume import |

### StartChatHistoryImportResponse

| Property | Type | Description |
|----------|------|-------------|
| sessionId | string | Transfer session ID |
| importJobId | string | Asynchronous import job ID |
| status | string | Import job status |

### StartupResourcesResponse

| Property | Type | Description |
|----------|------|-------------|
| syncToken | string | Token to be used for the next delta sync |
| serverTime | string | Current server time in ISO 8601 format |
| limits | object | Application limits used to validate client behavior |
| realtime | object | Realtime communication endpoints and parameters |
| security | object | Security-related startup information |
| offline | object | Offline queue configuration |

### StatusMuteListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of status mutes |
| page | integer | Current page number |
| pageSize | integer | Number of items per page |
| totalItems | integer | Total number of muted contacts |

### StatusMuteResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Mute resource ID |
| contactId | string | Muted contact ID |
| mutedAt | string | ISO 8601 timestamp when mute was created |
| muteUntil | string | ISO 8601 timestamp until which the status is muted; null if indefinite |

### StatusReplyListResponse

| Property | Type | Description |
|----------|------|-------------|
| page | integer | Current page |
| pageSize | integer | Items per page |
| total | integer | Total number of replies |
| items | array | List of replies |

### StatusReplyResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Reply ID |
| statusId | string | ID of the status |
| senderId | string | ID of the sender |
| createdAt | string | ISO-8601 timestamp of creation |
| deliveryState | string | Delivery state for offline queueing |

### StatusResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Status ID |
| createdAt | string | Creation timestamp in ISO 8601 format |
| expiresAt | string | Expiration timestamp in ISO 8601 format |
| mediaId | string | Optional media identifier if attached |
| status | string | Status state (e.g., created) |

### StatusVisibilitySettingsResponse

| Property | Type | Description |
|----------|------|-------------|
| userId | string | User ID |
| visibilityMode | string | Visibility mode: everyone, contacts, contactsExcept, onlyShareWith |
| contactsExcept | array | List of contact IDs excluded from viewing status |
| onlyShareWith | array | List of contact IDs allowed to view status |
| updatedAt | string | Last update timestamp in ISO 8601 format |

### StickerListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of stickers |
| page | integer | Current page |
| pageSize | integer | Page size |
| total | integer | Total number of stickers |

### StickerPackListResponse

| Property | Type | Description |
|----------|------|-------------|
| page | integer | Current page number |
| pageSize | integer | Number of items per page |
| totalItems | integer | Total number of sticker packs available |
| items | array | List of sticker packs |

### StickerPackResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Sticker pack ID |
| name | string | Sticker pack name |
| regionCode | string | Region or locale code for which the pack is available |
| description | string | Sticker pack description |
| thumbnailUrl | string | URL of the pack thumbnail |
| stickers | array | List of stickers in the pack |

### StickerSuggestionsRequest

| Property | Type | Description |
|----------|------|-------------|
| conversationId | string | Unique identifier of the conversation |
| messageContextCiphertext | string | End-to-end encrypted message context used for generating suggestions |
| contextType | string | Type of context (e.g., message, status, reply) |
| language | string | BCP-47 language tag for localization |
| limit | integer | Maximum number of sticker suggestions to return |
| clientTimestamp | string | Client-side ISO-8601 timestamp for context alignment |

### StickerSuggestionsResponse

| Property | Type | Description |
|----------|------|-------------|
| suggestions | array | List of suggested stickers |

### StorageCleanupRequest

| Property | Type | Description |
|----------|------|-------------|
| scopeType | string | user|device|group |
| scopeId | string | Target scope identifier |
| maxAgeDays | integer | Delete items older than this many days |
| includeMedia | boolean | Whether to include media files |
| includeCaches | boolean | Whether to include cached data |

### StorageCleanupResponse

| Property | Type | Description |
|----------|------|-------------|
| cleanupId | string | Cleanup job identifier |
| status | string | queued|running|completed |
| estimatedReclaimedBytes | integer | Estimated bytes to be reclaimed |

### StorageItemListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of storage items |
| page | integer | Current page number |
| pageSize | integer | Items per page |
| totalItems | integer | Total number of items |

### StorageUsageResponse

| Property | Type | Description |
|----------|------|-------------|
| totalBytes | integer | Total bytes used |
| quotaBytes | integer | Maximum allowed bytes |
| items | array | Detailed usage by scope |
| page | integer | Current page number |
| pageSize | integer | Items per page |
| totalItems | integer | Total number of items |

### SubmitVoteRequest

| Property | Type | Description |
|----------|------|-------------|
| selectedOptionIndexes | array | Selected option indexes |
| voteCiphertext | string | Encrypted vote payload (Signal Protocol) |
| clientMessageId | string | Client-generated id for offline queue de-duplication |

### SubmitVoteResponse

| Property | Type | Description |
|----------|------|-------------|
| pollId | string | Poll ID |
| status | string | Poll status (active|closed) |
| updatedAt | string | ISO-8601 update timestamp |

### SyncWatchDeviceRequest

| Property | Type | Description |
|----------|------|-------------|
| lastSyncAt | string | Timestamp of last successful sync |
| queuedMessageIds | array | IDs of messages queued on the watch while offline |

### SyncWatchDeviceResponse

| Property | Type | Description |
|----------|------|-------------|
| serverMessages | array | Messages to deliver to the smartwatch |
| acknowledgedMessageIds | array | Messages acknowledged by the server |
| syncAt | string | Sync completion timestamp |

### ThemePreferenceResponse

| Property | Type | Description |
|----------|------|-------------|
| userId | string | User ID |
| theme | string | Theme preference: light, dark, or system |
| updatedAt | string | ISO 8601 timestamp of last update |

### TokenResponse

| Property | Type | Description |
|----------|------|-------------|
| accessToken | string | Bearer token |
| expiresIn | integer | Token lifetime in seconds |
| tokenType | string | Token type |

### TranscriptionListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of transcription resources |
| page | integer | Current page number |
| pageSize | integer | Number of items per page |
| totalItems | integer | Total number of transcriptions |
| totalPages | integer | Total number of pages |

### TranscriptionResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Transcription ID |
| voiceMessageId | string | Voice message ID |
| status | string | Transcription status (processing, completed, failed) |
| text | string | Transcribed text when completed |
| language | string | Detected or specified language |
| createdAt | string | ISO-8601 creation timestamp |
| updatedAt | string | ISO-8601 last update timestamp |

### TransferGroupOwnershipRequest

| Property | Type | Description |
|----------|------|-------------|
| newOwnerId | string | New owner user ID |

### TransferGroupOwnershipResponse

| Property | Type | Description |
|----------|------|-------------|
| groupId | string | Group ID |
| ownerId | string | New owner user ID |

### TypographyPreferencesResponse

| Property | Type | Description |
|----------|------|-------------|
| userId | string | User ID |
| fontScale | number | Font scaling factor (e.g., 0.8 to 1.6) |
| preset | string | Named preset (e.g., small, default, large, extraLarge) |
| updatedAt | string | ISO-8601 timestamp of last update |

### UnassignLabelFromContactRequest

### UnassignLabelFromContactResponse

| Property | Type | Description |
|----------|------|-------------|
| contactId | string | Contact ID |
| labelId | string | Label ID |
| removed | boolean | Indicates whether the label was unassigned |

### UnblockContactRequest

### UnblockContactResponse

| Property | Type | Description |
|----------|------|-------------|
| userId | string | User ID who unblocked |
| contactId | string | Contact ID unblocked |
| deleted | boolean | Whether the block was removed |
| deletedAt | string | ISO-8601 timestamp when the block was removed |

### UnknownSenderMessagesResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of pending messages |
| page | integer | Current page number |
| pageSize | integer | Number of items per page |
| totalItems | integer | Total number of pending messages |
| totalPages | integer | Total number of pages |

### UnknownSenderResponse

| Property | Type | Description |
|----------|------|-------------|
| senderId | string | Sender ID |
| displayName | string | Sender display name if available |
| pendingMessageCount | integer | Number of pending messages from this sender |
| lastMessageAt | string | Timestamp of last pending message (ISO 8601) |
| status | string | Current handling status (e.g., pending, approved, blocked) |

### UnknownSendersListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of unknown senders |
| page | integer | Current page number |
| pageSize | integer | Number of items per page |
| totalItems | integer | Total number of unknown senders |
| totalPages | integer | Total number of pages |

### UnlockChatRequest

| Property | Type | Description |
|----------|------|-------------|
| authMethod | string | Additional authentication method used (e.g., biometric, otp, devicePin) |
| authToken | string | Proof of additional authentication (e.g., OTP code or signed device assertion) |
| deviceId | string | Identifier of the client device used for authentication |

### UnpinChatRequest

| Property | Type | Description |
|----------|------|-------------|
| clientTimestamp | string | Clientzeitpunkt (ISO 8601) fuer Offline-Queue und Konfliktaufloesung |

### UnpinChatResponse

| Property | Type | Description |
|----------|------|-------------|
| chatId | string | Eindeutige Chat-ID |
| isPinned | boolean | Pin-Status des Chats |
| unpinnedAt | string | Zeitpunkt des Lospinnens (ISO 8601) |

### UpdateAccessibilitySettingsRequest

| Property | Type | Description |
|----------|------|-------------|
| screenreaderEnabled | boolean | Whether screenreader optimizations are enabled |
| preferredLabelFormat | string | Preferred aria-label format or verbosity level |
| announceMessageMetadata | boolean | Whether to announce message metadata (timestamps, sender) |
| largeTapTargets | boolean | Enable larger tap targets for accessibility |
| highContrast | boolean | Enable high contrast mode |

### UpdateAppLockRequest

| Property | Type | Description |
|----------|------|-------------|
| enabled | boolean | Enable or disable app lock |
| lockMethod | string | Authentication method for app lock (e.g., pin, biometrics) |
| pin | string | PIN code used when lockMethod is pin; must be encrypted client-side |
| lockTimeoutSeconds | integer | Auto-lock timeout in seconds |

### UpdateAppLockResponse

| Property | Type | Description |
|----------|------|-------------|
| enabled | boolean | Indicates whether app lock is enabled after update |
| lockMethod | string | Configured authentication method |
| lockTimeoutSeconds | integer | Configured auto-lock timeout in seconds |

### UpdateBroadcastChannelRequest

| Property | Type | Description |
|----------|------|-------------|
| name | string | Channel display name |
| metadata | object | Optional metadata (e.g., avatar, description) |

### UpdateBroadcastListRequest

| Property | Type | Description |
|----------|------|-------------|
| name | string | Updated broadcast list name |
| recipientIds | array | Updated recipient user IDs (max 256) |

### UpdateBusinessProductRequest

| Property | Type | Description |
|----------|------|-------------|
| name | string | Product name |
| description | string | Product description |
| price | number | Product price |
| currency | string | ISO 4217 currency code |
| sku | string | Stock keeping unit |
| isActive | boolean | Whether the product is active in the catalog |
| tags | array | Product tags |

### UpdateBusinessProfileRequest

| Property | Type | Description |
|----------|------|-------------|
| displayName | string | Public display name of the business |
| description | string | Detailed business description |
| category | string | Business category identifier |
| contactEmail | string | Contact email address |
| contactPhone | string | Contact phone number |
| website | string | Business website URL |
| address | object | Business address |
| hours | array | Business hours by weekday |
| metadata | object | Additional profile metadata |

### UpdateBusinessVerificationRequestStatusRequest

| Property | Type | Description |
|----------|------|-------------|
| status | string | New status (verified or rejected) |
| rejectionReason | string | Reason for rejection if status is rejected |

### UpdateBusinessVerificationRequestStatusResponse

| Property | Type | Description |
|----------|------|-------------|
| requestId | string | Verification request ID |
| businessId | string | Business ID |
| status | string | Updated status |
| updatedAt | string | ISO 8601 update timestamp |

### UpdateCallLinkRequest

| Property | Type | Description |
|----------|------|-------------|
| title | string | Updated title |
| scheduledStartAt | string | Updated start time |
| scheduledEndAt | string | Updated end time |
| maxParticipants | integer | Updated maximum participants (<= 1024) |
| access | object | Updated access configuration |

### UpdateCallNotificationSettingsRequest

| Property | Type | Description |
|----------|------|-------------|
| enabled | boolean | Master toggle for call notifications |
| incomingVoiceCalls | boolean | Notify for incoming voice calls |
| incomingVideoCalls | boolean | Notify for incoming video calls |
| vibrate | boolean | Vibration enabled for call notifications |
| sound | string | Selected ringtone identifier |
| quietHours | object | Quiet hours configuration |

### UpdateCallPrivacySettingsRequest

| Property | Type | Description |
|----------|------|-------------|
| ipMaskingEnabled | boolean | Enable or disable IP address masking for calls |

### UpdateCartItemRequest

| Property | Type | Description |
|----------|------|-------------|
| quantity | integer | Updated quantity |

### UpdateCartItemResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Cart item ID |
| productId | string | Product ID |
| quantity | integer | Updated quantity |
| lineTotal | number | Updated line total amount |

### UpdateChatBackgroundRequest

| Property | Type | Description |
|----------|------|-------------|
| backgroundId | string | Background ID to set for this chat |

### UpdateCommunityRequest

| Property | Type | Description |
|----------|------|-------------|
| name | string | Community display name |
| description | string | Community description |
| metadata | object | Community metadata |

### UpdateContactLabelRequest

| Property | Type | Description |
|----------|------|-------------|
| name | string | Updated label name |
| color | string | Updated label color |

### UpdateDataUsageSettingsRequest

| Property | Type | Description |
|----------|------|-------------|
| limits | object | Data usage limits per period |
| autoDownload | object | Auto-download preferences by network type |
| warnings | object | Usage warning thresholds |

### UpdateDataUsageSettingsResponse

| Property | Type | Description |
|----------|------|-------------|
| userId | string | User ID |
| limits | object | Data usage limits per period |
| autoDownload | object | Auto-download preferences by network type |
| warnings | object | Usage warning thresholds |
| updatedAt | string | ISO 8601 timestamp of last update |

### UpdateDeviceRequest

| Property | Type | Description |
|----------|------|-------------|
| deviceName | string | Updated device name |
| pushToken | string | Updated push notification token |
| websocketCapable | boolean | Updated WebSocket capability flag |

### UpdateDisplayNameRequest

| Property | Type | Description |
|----------|------|-------------|
| displayName | string | New display name for the user |

### UpdateDisplayNameResponse

| Property | Type | Description |
|----------|------|-------------|
| userId | string | Unique identifier of the user |
| displayName | string | Updated display name |
| updatedAt | string | ISO 8601 timestamp of the update |

### UpdateDoNotDisturbSettingsRequest

| Property | Type | Description |
|----------|------|-------------|
| enabled | boolean | Enable or disable Do-Not-Disturb mode |
| until | string | ISO-8601 timestamp when Do-Not-Disturb mode ends; omit or null for indefinite |
| schedule | object | Optional recurring schedule for Do-Not-Disturb |

### UpdateGreetingSettingsRequest

| Property | Type | Description |
|----------|------|-------------|
| enabled | boolean | Enable or disable automatic greetings |
| message | string | Greeting message content |
| language | string | ISO language code for the greeting message |

### UpdateGroupEventRequest

| Property | Type | Description |
|----------|------|-------------|
| title | string | Event title |
| description | string | Event description |
| startTime | string | ISO-8601 start date-time |
| endTime | string | ISO-8601 end date-time |
| location | string | Event location or meeting link |
| timezone | string | IANA timezone |
| visibility | string | Event visibility within group |
| maxParticipants | integer | Optional cap on participants |

### UpdateGroupInvitePolicyRequest

| Property | Type | Description |
|----------|------|-------------|
| invitePolicy | string | Policy defining who can add members |

### UpdateGroupRequest

| Property | Type | Description |
|----------|------|-------------|
| name | string | Group name |
| description | string | Group description |
| settings | object | Group settings |

### UpdateGroupRolesRequest

| Property | Type | Description |
|----------|------|-------------|
| roles | array | Role updates |

### UpdateGroupRolesResponse

| Property | Type | Description |
|----------|------|-------------|
| groupId | string | Group ID |
| updatedCount | integer | Number of roles updated |

### UpdateGroupSettingsRequest

| Property | Type | Description |
|----------|------|-------------|
| name | string | Group display name |
| description | string | Group description |
| isPublic | boolean | Whether the group is discoverable |
| joinPolicy | string | Join policy (open, approval, inviteOnly) |
| memberPostingPolicy | string | Who can post messages (all, adminsOnly) |
| mediaSharingEnabled | boolean | Whether media sharing is allowed |
| maxMembers | integer | Maximum members allowed (max 1024) |
| encryptionEnabled | boolean | End-to-end encryption enabled |
| ephemeralMessagesEnabled | boolean | Whether ephemeral messages are enabled |
| ephemeralMessageTTLSeconds | integer | TTL for ephemeral messages in seconds |

### UpdateInfoVisibilitySettingsRequest

| Property | Type | Description |
|----------|------|-------------|
| infoTextVisibility | string | Visibility of the user's info text |
| statusTextVisibility | string | Visibility of the user's status text |

### UpdateMediaDraftEditsRequest

| Property | Type | Description |
|----------|------|-------------|
| crop | object | Crop rectangle in pixels |
| rotate | integer | Rotation in degrees (e.g., 0, 90, 180, 270) |
| filter | string | Filter name (e.g., none, mono, vivid) |
| adjustments | object | Basic adjustments |

### UpdateNotificationPreferencesRequest

| Property | Type | Description |
|----------|------|-------------|
| previewEnabled | boolean | Whether notification previews are enabled |
| previewMode | string | Preview mode (none|senderOnly|senderAndMessage) |
| showMediaThumbnails | boolean | Whether to show media thumbnails in notifications |

### UpdatePinRequest

| Property | Type | Description |
|----------|------|-------------|
| currentPin | string | Current PIN for verification |
| newPin | string | New PIN (4-8 digits) |
| pinHint | string | Optional hint to help the user remember the PIN |

### UpdatePinResponse

| Property | Type | Description |
|----------|------|-------------|
| userId | string | User ID |
| pinEnabled | boolean | Indicates whether PIN security is enabled |
| updatedAt | string | Timestamp when PIN was updated |

### UpdatePresenceVisibilityRequest

| Property | Type | Description |
|----------|------|-------------|
| visibility | string | Visibility scope for online/last seen status |
| customAllowList | array | List of user IDs explicitly allowed to see status when visibility is custom |
| customDenyList | array | List of user IDs explicitly denied when visibility is custom |

### UpdateProfilePictureVisibilityRequest

| Property | Type | Description |
|----------|------|-------------|
| visibility | string | New visibility setting for profile picture |

### UpdateQuickReplyRequest

| Property | Type | Description |
|----------|------|-------------|
| title | string | Short label for the quick reply |
| message | string | Message text to be sent |
| language | string | BCP-47 language tag for the quick reply |
| isActive | boolean | Whether the quick reply is active |

### UpdateReadReceiptSettingsRequest

| Property | Type | Description |
|----------|------|-------------|
| globalEnabled | boolean | Whether read receipts are enabled globally |
| conversationOverrides | array | Per-conversation overrides |

### UpdateSelfDestructRequest

| Property | Type | Description |
|----------|------|-------------|
| ttlSeconds | integer | Time-to-live in seconds after delivery |
| expiresAt | string | Absolute expiration timestamp in ISO 8601 |

### UpdateSelfDestructResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Message ID |
| selfDestruct | object | Updated self-destruction policy |
| updatedAt | string | Update timestamp in ISO 8601 |

### UpdateStatusVisibilitySettingsRequest

| Property | Type | Description |
|----------|------|-------------|
| visibilityMode | string | Visibility mode: everyone, contacts, contactsExcept, onlyShareWith |
| contactsExcept | array | List of contact IDs excluded from viewing status (required when visibilityMode=contactsExcept) |
| onlyShareWith | array | List of contact IDs allowed to view status (required when visibilityMode=onlyShareWith) |

### UpdateThemePreferenceRequest

| Property | Type | Description |
|----------|------|-------------|
| theme | string | Theme preference: light, dark, or system |

### UpdateTypographyPreferencesRequest

| Property | Type | Description |
|----------|------|-------------|
| fontScale | number | Font scaling factor (e.g., 0.8 to 1.6) |
| preset | string | Named preset (e.g., small, default, large, extraLarge) |

### UpdateUserAccessibilitySettingsRequest

| Property | Type | Description |
|----------|------|-------------|
| contrastMode | string | Selected contrast mode (e.g., standard, high) |
| minContrastRatio | number | Minimum contrast ratio to enforce |

### UpdateUserChatBackgroundRequest

| Property | Type | Description |
|----------|------|-------------|
| backgroundId | string | Background ID to set as default |

### UpdateUserLanguageRequest

| Property | Type | Description |
|----------|------|-------------|
| languageCode | string | Preferred language code in BCP-47 format (e.g., en, de, fr) |

### UpdateUserLocalizationPreferencesRequest

| Property | Type | Description |
|----------|------|-------------|
| language | string | IETF BCP 47 language tag, e.g., ar, he, fa-IR |
| textDirection | string | Text direction preference: ltr or rtl |
| numeralSystem | string | Optional numeral system, e.g., latn, arab |
| timezone | string | IANA timezone, e.g., Asia/Riyadh |

### UpdateUserLocalizationPreferencesResponse

| Property | Type | Description |
|----------|------|-------------|
| userId | string | User ID |
| language | string | IETF BCP 47 language tag, e.g., ar, he, fa-IR |
| textDirection | string | Text direction preference: ltr or rtl |
| numeralSystem | string | Optional numeral system, e.g., latn, arab |
| timezone | string | IANA timezone, e.g., Asia/Riyadh |
| updatedAt | string | ISO 8601 timestamp of update |

### UpdateUserPowerSettingsRequest

| Property | Type | Description |
|----------|------|-------------|
| lowPowerModeEnabled | boolean | Whether low power mode is enabled |
| reduceBackgroundSync | boolean | Whether background sync is reduced |
| wifiOnlyMediaUpload | boolean | Whether media uploads are limited to Wi-Fi |
| deferLargeDownloads | boolean | Whether large downloads are deferred to charging or Wi-Fi |

### UpdateUserProfileInfoTextRequest

| Property | Type | Description |
|----------|------|-------------|
| infoText | string | Short info/status text to display in the profile |

### UpdateUserRegionalFormatsRequest

| Property | Type | Description |
|----------|------|-------------|
| locale | string | IETF BCP 47 locale identifier (e.g., de-DE) |
| dateFormat | string | Preferred date format pattern |
| timeFormat | string | Preferred time format pattern |
| numberFormat | string | Preferred number format pattern |
| timeZone | string | Default timezone identifier |

### UpdateUserRegionalFormatsResponse

| Property | Type | Description |
|----------|------|-------------|
| userId | string | User ID |
| locale | string | IETF BCP 47 locale identifier (e.g., de-DE) |
| dateFormat | string | Preferred date format pattern |
| timeFormat | string | Preferred time format pattern |
| numberFormat | string | Preferred number format pattern |
| timeZone | string | Default timezone identifier |
| updatedAt | string | ISO 8601 timestamp of last update |

### UpdateWatchDeviceSettingsRequest

| Property | Type | Description |
|----------|------|-------------|
| notificationsEnabled | boolean | Enable or disable notifications on the watch |
| callNotificationsEnabled | boolean | Enable or disable call notifications on the watch |
| syncIntervalSeconds | integer | Preferred background sync interval |

### UpdateWatchDeviceSettingsResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Smartwatch device ID |
| notificationsEnabled | boolean | Notification setting |
| callNotificationsEnabled | boolean | Call notification setting |
| syncIntervalSeconds | integer | Background sync interval |

### UpdateWidgetRequest

| Property | Type | Description |
|----------|------|-------------|
| title | string | Widget title |
| position | integer | Order on home screen |
| isEnabled | boolean | Whether widget is enabled |
| config | object | Widget configuration settings |

### UploadBusinessProductMediaRequest

| Property | Type | Description |
|----------|------|-------------|
| mediaType | string | Media type (image, document) |
| file | string | Media file to upload |

### UploadBusinessProfileMediaRequest

| Property | Type | Description |
|----------|------|-------------|
| mediaType | string | Media type: logo, cover, document |
| file | string | Media file to upload |

### UploadChatMediaRequest

| Property | Type | Description |
|----------|------|-------------|
| file | string | Media file captured by camera |
| mediaType | string | Type of media (image|video|document) |
| mimeType | string | MIME type of the media |
| captureSource | string | Capture source, must be 'camera' for direct camera integration |
| encryptedMediaKey | string | Encrypted media key for Signal Protocol E2E encryption |
| encryptedThumbnail | string | Optional encrypted thumbnail data (base64) |
| width | integer | Image/video width in pixels |
| height | integer | Image/video height in pixels |
| durationMs | integer | Video duration in milliseconds (if mediaType=video) |

### UploadGroupAvatarRequest

| Property | Type | Description |
|----------|------|-------------|
| file | string | Avatar image file (max 16MB) |

### UploadGroupAvatarResponse

| Property | Type | Description |
|----------|------|-------------|
| groupId | string | Group ID |
| avatarUrl | string | Avatar URL |

### UploadImageRequest

| Property | Type | Description |
|----------|------|-------------|
| file | string | Image file (max 16MB) |
| encryptionInfo | string | Signal Protocol encryption metadata (e.g., key, IV, MAC) encoded as JSON string |
| mimeType | string | MIME type of the image (e.g., image/jpeg, image/png) |

### UploadImageResponse

| Property | Type | Description |
|----------|------|-------------|
| mediaId | string | Unique ID of the uploaded image |
| sizeBytes | integer | Size of the uploaded image in bytes |
| mimeType | string | MIME type of the uploaded image |
| createdAt | string | ISO-8601 timestamp of upload |

### UploadMediaPartRequest

| Property | Type | Description |
|----------|------|-------------|
| file | string | Encrypted media chunk |

### UploadMediaPartResponse

| Property | Type | Description |
|----------|------|-------------|
| uploadId | string | Upload session identifier |
| partNumber | integer | Uploaded chunk number |
| etag | string | ETag for the uploaded chunk |

### UploadMediaRequest

| Property | Type | Description |
|----------|------|-------------|
| file | string | Media file to upload |
| mediaType | string | Type of media (image, document, audio, video) |

### UploadMediaResponse

| Property | Type | Description |
|----------|------|-------------|
| mediaId | string | Media ID |
| status | string | Upload status |
| sizeBytes | integer | Uploaded size in bytes |

### UploadPrekeysRequest

| Property | Type | Description |
|----------|------|-------------|
| signedPreKey | string | Signed pre-key (base64) |
| signedPreKeySignature | string | Signature for signed pre-key (base64) |
| oneTimePreKeys | array | Array of one-time pre-keys (base64) |

### UploadPrekeysResponse

| Property | Type | Description |
|----------|------|-------------|
| deviceId | string | Device ID |
| uploadedOneTimePreKeys | integer | Number of one-time pre-keys uploaded |

### UploadProfileImageRequest

| Property | Type | Description |
|----------|------|-------------|
| file | string | Profile image file (max 16MB) |

### UploadVideoRequest

| Property | Type | Description |
|----------|------|-------------|
| file | string | Encrypted video file payload |
| mimeType | string | MIME type of the video, e.g., video/mp4 |
| fileSize | integer | Size of the encrypted video in bytes |
| encryption | object | Signal Protocol encryption metadata for end-to-end encryption |

### UploadVideoResponse

| Property | Type | Description |
|----------|------|-------------|
| mediaId | string | Identifier of the uploaded video media |
| uploadUrl | string | Optional resumable upload URL for large files |
| expiresAt | string | Expiration timestamp for the media reference |

### UpsertAwayMessageRequest

| Property | Type | Description |
|----------|------|-------------|
| enabled | boolean | Whether the automatic away message is enabled |
| message | string | Away message text (end-to-end encrypted payload) |
| startsAt | string | ISO 8601 start time for the away message schedule |
| endsAt | string | ISO 8601 end time for the away message schedule |

### UserAccessibilitySettingsResponse

| Property | Type | Description |
|----------|------|-------------|
| userId | string | User ID |
| contrastMode | string | Selected contrast mode (e.g., standard, high) |
| minContrastRatio | number | Minimum contrast ratio enforced by the client |
| updatedAt | string | ISO-8601 timestamp of last update |

### UserChatBackgroundResponse

| Property | Type | Description |
|----------|------|-------------|
| backgroundId | string | Selected background ID |
| previewUrl | string | Preview image URL |

### UserLanguageResponse

| Property | Type | Description |
|----------|------|-------------|
| userId | string | User ID |
| languageCode | string | Preferred language code in BCP-47 format |
| updatedAt | string | Timestamp of the last update in ISO 8601 format |

### UserLocalizationPreferencesResponse

| Property | Type | Description |
|----------|------|-------------|
| userId | string | User ID |
| language | string | IETF BCP 47 language tag, e.g., ar, he, fa-IR |
| textDirection | string | Text direction preference: ltr or rtl |
| numeralSystem | string | Optional numeral system, e.g., latn, arab |
| timezone | string | IANA timezone, e.g., Asia/Riyadh |

### UserPasskeysResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of passkeys |
| page | integer | Current page |
| pageSize | integer | Items per page |
| total | integer | Total items |

### UserPowerSettingsResponse

| Property | Type | Description |
|----------|------|-------------|
| userId | string | User ID |
| lowPowerModeEnabled | boolean | Whether low power mode is enabled |
| reduceBackgroundSync | boolean | Whether background sync is reduced |
| wifiOnlyMediaUpload | boolean | Whether media uploads are limited to Wi-Fi |
| deferLargeDownloads | boolean | Whether large downloads are deferred to charging or Wi-Fi |

### UserProfileInfoTextResponse

| Property | Type | Description |
|----------|------|-------------|
| userId | string | Unique identifier of the user |
| infoText | string | Short info/status text displayed in the profile |
| updatedAt | string | Last update timestamp of the info text |

### UserProfileResponse

| Property | Type | Description |
|----------|------|-------------|
| userId | string | Unique identifier of the user |
| displayName | string | User's display name |
| phoneNumber | string | User's phone number in E.164 format |
| avatarUrl | string | URL to the user's profile picture |
| statusMessage | string | User's status message |

### UserQrCodeResponse

| Property | Type | Description |
|----------|------|-------------|
| qrCodeId | string | Unique QR code identifier |
| userId | string | User identifier |
| imageBase64 | string | Base64-encoded QR code image |
| deepLink | string | Deeplink encoded in the QR code |
| expiresAt | string | Expiration timestamp in ISO 8601 format |
| createdAt | string | Creation timestamp in ISO 8601 format |

### UserRegionalFormatsResponse

| Property | Type | Description |
|----------|------|-------------|
| userId | string | User ID |
| locale | string | IETF BCP 47 locale identifier (e.g., de-DE) |
| dateFormat | string | Preferred date format pattern |
| timeFormat | string | Preferred time format pattern |
| numberFormat | string | Preferred number format pattern |
| timeZone | string | Default timezone identifier |
| updatedAt | string | ISO 8601 timestamp of last update |

### VerifyAppLockRequest

| Property | Type | Description |
|----------|------|-------------|
| lockMethod | string | Authentication method used for verification (e.g., pin, biometrics) |
| pin | string | PIN code used for verification; must be encrypted client-side |
| deviceNonce | string | Client-generated nonce to prevent replay attacks |

### VerifyAppLockResponse

| Property | Type | Description |
|----------|------|-------------|
| verified | boolean | Indicates whether verification succeeded |
| sessionUnlockedUntil | string | ISO-8601 timestamp until which the session remains unlocked |

### VerifyPhoneRegistrationRequest

| Property | Type | Description |
|----------|------|-------------|
| otp | string | One-time verification code |
| devicePublicKey | string | Client device public key for E2E encryption initialization |

### VerifyPhoneRegistrationResponse

| Property | Type | Description |
|----------|------|-------------|
| userId | string | Created user identifier |
| accessToken | string | JWT access token |
| refreshToken | string | Refresh token |
| status | string | Verification status (verified) |

### VerifyPinRequest

| Property | Type | Description |
|----------|------|-------------|
| tempAuthToken | string | Temporary token issued after primary authentication |
| pin | string | User PIN for verification |

### VerifyPinResponse

| Property | Type | Description |
|----------|------|-------------|
| accessToken | string | Access token issued after successful PIN verification |
| refreshToken | string | Refresh token issued after successful PIN verification |
| expiresIn | integer | Access token expiration time in seconds |

### VerifyTwoFactorRequest

| Property | Type | Description |
|----------|------|-------------|
| userId | string | User ID |
| pin | string | 6-digit PIN for 2FA verification |
| loginSessionId | string | Login session ID issued after primary authentication |

### VerifyTwoFactorResponse

| Property | Type | Description |
|----------|------|-------------|
| userId | string | User ID |
| verified | boolean | Indicates whether 2FA verification succeeded |
| accessToken | string | Access token issued after successful 2FA verification |

### ViewOnceMediaResponse

| Property | Type | Description |
|----------|------|-------------|
| file | string | Encrypted media file content |
| encryptionMetadata | object | Signal Protocol metadata required for decryption |

### VoiceAssistantCommandResponse

| Property | Type | Description |
|----------|------|-------------|
| commandId | string | Unique command identifier |
| status | string | Processing status (e.g., accepted, completed, failed) |
| result | object | Command execution result |

### VoiceAssistantLinkResponse

| Property | Type | Description |
|----------|------|-------------|
| linkId | string | Unique link identifier |
| provider | string | Voice assistant provider identifier |
| status | string | Link status |
| linkedAt | string | ISO-8601 timestamp of linking |

### VoiceAssistantLinksListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of linked voice assistant accounts |
| page | integer | Current page number |
| pageSize | integer | Page size |
| totalItems | integer | Total number of linked accounts |

### VoiceAssistantWebhookRequest

| Property | Type | Description |
|----------|------|-------------|
| eventId | string | Unique event identifier |
| signature | string | Provider signature for webhook verification |
| payload | object | Provider-specific webhook payload |

### VoiceAssistantWebhookResponse

| Property | Type | Description |
|----------|------|-------------|
| received | boolean | Indicates if the webhook was received successfully |
| processedAt | string | ISO-8601 timestamp of processing |

### VoiceAssistantsListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of supported voice assistants |
| page | integer | Current page number |
| pageSize | integer | Page size |
| totalItems | integer | Total number of providers |

### VoiceMessageResponse

| Property | Type | Description |
|----------|------|-------------|
| messageId | string | Server-generated message ID |
| clientMessageId | string | Client-generated unique identifier for idempotency |
| recipientType | string | Recipient type: user, group, or broadcast |
| recipientId | string | ID of the target user, group, or broadcast list |
| serverTimestamp | string | ISO-8601 timestamp when the server accepted the message |
| status | string | Message status (e.g., queued, sent) |

### WatchDeviceListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of smartwatches |
| page | integer | Current page |
| pageSize | integer | Items per page |
| total | integer | Total items |

### WatchDeviceResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Smartwatch device ID |
| deviceName | string | User-friendly name of the smartwatch |
| platform | string | Smartwatch platform |
| status | string | Registration status |

### WebClientConfigResponse

| Property | Type | Description |
|----------|------|-------------|
| maxGroupMembers | integer | Maximum number of group members |
| maxBroadcastRecipients | integer | Maximum number of recipients in a broadcast list |
| maxDocumentSizeBytes | integer | Maximum document size in bytes |
| maxImageSizeBytes | integer | Maximum image size in bytes |
| maxStatusDurationHours | integer | Maximum status duration in hours |
| supportsWebRTC | boolean | Indicates if WebRTC is enabled |
| supportsWebSocket | boolean | Indicates if WebSocket is enabled |
| supportsOfflineQueue | boolean | Indicates if offline queue is enabled |
| encryptionProtocol | string | End-to-end encryption protocol |

### WebRtcTokenResponse

| Property | Type | Description |
|----------|------|-------------|
| username | string | TURN username |
| credential | string | TURN credential |
| ttlSeconds | integer | Credential time-to-live in seconds |
| uris | array | List of TURN/STUN server URIs |

### WebSessionResponse

| Property | Type | Description |
|----------|------|-------------|
| sessionId | string | Web session ID |
| createdAt | string | Session creation timestamp |
| expiresAt | string | Session expiration timestamp |

### WebSocketTokenResponse

| Property | Type | Description |
|----------|------|-------------|
| token | string | WebSocket access token |
| expiresAt | string | Token expiration timestamp |

### WebhookListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of webhooks |
| page | integer | Current page |
| pageSize | integer | Page size |
| total | integer | Total items |

### WebhookResponse

| Property | Type | Description |
|----------|------|-------------|
| webhookId | string | Webhook ID |
| status | string | Webhook status |
| createdAt | string | ISO-8601 creation time |

### WidgetListResponse

| Property | Type | Description |
|----------|------|-------------|
| items | array | List of widgets |
| page | integer | Current page number |
| pageSize | integer | Number of items per page |
| totalItems | integer | Total number of widgets |

### WidgetResponse

| Property | Type | Description |
|----------|------|-------------|
| id | string | Widget ID |
| type | string | Widget type identifier |
| title | string | Widget title |
| position | integer | Order on home screen |
| isEnabled | boolean | Whether widget is enabled |
| config | object | Widget configuration settings |
| updatedAt | string | Last update timestamp (ISO 8601) |

