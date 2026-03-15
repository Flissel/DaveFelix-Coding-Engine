# whatsapp-messaging-service Realtime API - WebSocket API

**Version:** 1.0.0
**Protocol:** WebSocket

**Server:** `wss://api.example.com/ws`

## Channels

### `profile/info-text`

Real-time profile info/status text updates

**Subscribe (Server -> Client):** `ProfileInfoTextUpdated`

| Field | Type | Description |
|-------|------|-------------|
| `user_id` | `string` | User ID whose info text changed |
| `info_text` | `string` | Updated short info/status text |
| `updated_at` | `string` | Update timestamp |

**Publish (Client -> Server):** `UpdateProfileInfoText`

| Field | Type | Description |
|-------|------|-------------|
| `user_id` | `string` | User ID making the update |
| `info_text` | `string` | New short info/status text |

---

### `chat/messages`

End-to-end encrypted chat message delivery

**Subscribe (Server -> Client):** `EncryptedMessageReceived`

| Field | Type | Description |
|-------|------|-------------|
| `message_id` | `string` | Unique message ID |
| `sender_id` | `string` | Sender user ID |
| `conversation_id` | `string` | Conversation ID |
| `ciphertext` | `string` | Encrypted payload (base64) |
| `nonce` | `string` | Nonce/IV used for encryption (base64) |
| `algorithm` | `string` | Content encryption algorithm, e.g., AES-GCM |
| `key_id` | `string` | Key identifier used for encryption |
| `timestamp` | `string` |  |
| `signature` | `string` | Optional message signature (base64) |

**Publish (Client -> Server):** `SendEncryptedMessage`

| Field | Type | Description |
|-------|------|-------------|
| `conversation_id` | `string` | Conversation ID |
| `ciphertext` | `string` | Encrypted payload (base64) |
| `nonce` | `string` | Nonce/IV used for encryption (base64) |
| `algorithm` | `string` | Content encryption algorithm, e.g., AES-GCM |
| `key_id` | `string` | Key identifier used for encryption |
| `type` | `string` | Encrypted content type |
| `signature` | `string` | Optional message signature (base64) |

---

### `chat/acks`

End-to-end encrypted message acknowledgments

**Subscribe (Server -> Client):** `EncryptedMessageAck`

| Field | Type | Description |
|-------|------|-------------|
| `message_id` | `string` | Acknowledged message ID |
| `conversation_id` | `string` | Conversation ID |
| `status` | `string` | Ack status |
| `ack_timestamp` | `string` |  |
| `signature` | `string` | Optional acknowledgment signature (base64) |

**Publish (Client -> Server):** `SendEncryptedAck`

| Field | Type | Description |
|-------|------|-------------|
| `message_id` | `string` | Acknowledged message ID |
| `conversation_id` | `string` | Conversation ID |
| `status` | `string` | Ack status |
| `signature` | `string` | Optional acknowledgment signature (base64) |

---

### `chat/voice`

Real-time voice message delivery for conversations

**Subscribe (Server -> Client):** `VoiceMessageReceived`

| Field | Type | Description |
|-------|------|-------------|
| `message_id` | `string` | Unique voice message ID |
| `conversation_id` | `string` | Conversation ID |
| `sender_id` | `string` | Sender user ID |
| `audio_url` | `string` | URL to the stored audio blob |
| `duration_ms` | `number` | Audio duration in milliseconds |
| `mime_type` | `string` | Audio MIME type (e.g., audio/ogg) |
| `timestamp` | `string` |  |

**Publish (Client -> Server):** `SendVoiceMessage`

| Field | Type | Description |
|-------|------|-------------|
| `conversation_id` | `string` |  |
| `audio_payload` | `string` | Base64-encoded audio data |
| `duration_ms` | `number` |  |
| `mime_type` | `string` |  |
| `client_message_id` | `string` | Client-generated ID for de-duplication |

---

### `chat/voice/ack`

Acknowledgments for voice message delivery

**Subscribe (Server -> Client):** `VoiceMessageAck`

| Field | Type | Description |
|-------|------|-------------|
| `client_message_id` | `string` | Client-generated ID |
| `message_id` | `string` | Server-assigned message ID |
| `status` | `string` |  |
| `reason` | `string` | Rejection reason if status is rejected |
| `timestamp` | `string` |  |

**Publish (Client -> Server):** `VoiceMessageDelivered`

| Field | Type | Description |
|-------|------|-------------|
| `message_id` | `string` |  |
| `conversation_id` | `string` |  |
| `received_at` | `string` |  |

---

### `chat/messages/ack`

Acknowledgments for message creation with self-destruct metadata

**Subscribe (Server -> Client):** `ChatMessageAccepted`

| Field | Type | Description |
|-------|------|-------------|
| `client_message_id` | `string` | Client-generated temporary ID |
| `message_id` | `string` | Server-assigned message ID |
| `timestamp` | `string` |  |
| `self_destruct` | `boolean` |  |
| `expires_at` | `string` | Computed expiration time if self_destruct=true |

**Publish (Client -> Server):** `SendChatMessageWithClientId`

| Field | Type | Description |
|-------|------|-------------|
| `client_message_id` | `string` | Client-generated temporary ID |
| `conversation_id` | `string` |  |
| `content` | `string` |  |
| `type` | `string` |  |
| `self_destruct` | `boolean` |  |
| `ttl_seconds` | `integer` | Time-to-live in seconds before deletion if self_destruct=true |

---

### `chat/forward`

Forwarding of existing messages to other recipients or conversations

**Subscribe (Server -> Client):** `MessageForwarded`

| Field | Type | Description |
|-------|------|-------------|
| `forward_id` | `string` | Unique forward operation ID |
| `original_message_id` | `string` | ID of the original message |
| `from_conversation_id` | `string` | Source conversation ID |
| `to_conversation_id` | `string` | Target conversation ID |
| `forwarded_by` | `string` | User ID who forwarded the message |
| `timestamp` | `string` | Forward timestamp |

**Publish (Client -> Server):** `ForwardMessage`

| Field | Type | Description |
|-------|------|-------------|
| `original_message_id` | `string` | ID of the message to forward |
| `from_conversation_id` | `string` | Source conversation ID |
| `to_conversation_id` | `string` | Target conversation ID |
| `note` | `string` | Optional annotation for the forwarded message |

---

### `chat/forward/ack`

Acknowledgment for forwarding requests

**Subscribe (Server -> Client):** `ForwardMessageAck`

| Field | Type | Description |
|-------|------|-------------|
| `forward_id` | `string` | Unique forward operation ID |
| `status` | `string` | Forward request status |
| `reason` | `string` | Failure reason if rejected |
| `timestamp` | `string` | Acknowledgment timestamp |

---

### `chat/reactions`

Real-time reaction updates for messages

**Subscribe (Server -> Client):** `ReactionOnOwnMessage`

| Field | Type | Description |
|-------|------|-------------|
| `message_id` | `string` | ID of the message that received the reaction |
| `reactor_id` | `string` | User ID of the reactor |
| `reaction` | `string` | Reaction type, e.g., emoji shortcode |
| `timestamp` | `string` | Time when the reaction was applied |

**Publish (Client -> Server):** `AddReaction`

| Field | Type | Description |
|-------|------|-------------|
| `message_id` | `string` | ID of the message to react to |
| `reaction` | `string` | Reaction type, e.g., emoji shortcode |

---

### `chat/reactions/ack`

Acknowledgment for reaction requests

**Subscribe (Server -> Client):** `ReactionAck`

| Field | Type | Description |
|-------|------|-------------|
| `client_request_id` | `string` | Client-generated id for correlation |
| `status` | `string` |  |
| `error` | `string` | Error message if rejected |
| `timestamp` | `string` |  |

---

### `chat/messages/expired`

Notifications when self-destructing messages are deleted

**Subscribe (Server -> Client):** `ChatMessageExpired`

| Field | Type | Description |
|-------|------|-------------|
| `message_id` | `string` | Unique message ID |
| `conversation_id` | `string` | Conversation ID |
| `expired_at` | `string` | Timestamp of deletion |
| `reason` | `string` | Reason for deletion |

---

### `chat/lock`

Real-time chat lock state and authentication flow

**Subscribe (Server -> Client):** `ChatLockStatusChanged`

| Field | Type | Description |
|-------|------|-------------|
| `conversation_id` | `string` | Chat/conversation ID |
| `locked` | `boolean` | Current lock state |
| `locked_by` | `string` | User ID who initiated the change |
| `reason` | `string` | Optional reason for lock/unlock |
| `timestamp` | `string` |  |

**Publish (Client -> Server):** `RequestChatLock`

| Field | Type | Description |
|-------|------|-------------|
| `conversation_id` | `string` |  |
| `client_request_id` | `string` | Idempotency token |

---

### `chat/lock/auth`

Additional authentication challenge/response for locking chats

**Subscribe (Server -> Client):** `ChatLockAuthChallenge`

| Field | Type | Description |
|-------|------|-------------|
| `conversation_id` | `string` |  |
| `challenge_id` | `string` |  |
| `auth_method` | `string` |  |
| `expires_at` | `string` |  |

**Publish (Client -> Server):** `SubmitChatLockAuth`

| Field | Type | Description |
|-------|------|-------------|
| `conversation_id` | `string` |  |
| `challenge_id` | `string` |  |
| `auth_payload` | `string` | Opaque auth response (e.g., OTP, signed assertion) |
| `client_request_id` | `string` |  |

---

### `chat/lock/ack`

Acknowledgments for lock/unlock requests

**Subscribe (Server -> Client):** `ChatLockRequestAck`

| Field | Type | Description |
|-------|------|-------------|
| `conversation_id` | `string` |  |
| `client_request_id` | `string` |  |
| `status` | `string` |  |
| `error_code` | `string` |  |
| `error_message` | `string` |  |
| `timestamp` | `string` |  |

**Publish (Client -> Server):** `RequestChatUnlock`

| Field | Type | Description |
|-------|------|-------------|
| `conversation_id` | `string` |  |
| `client_request_id` | `string` |  |

---

### `broadcast/messages`

Real-time broadcast delivery to multiple recipients

**Subscribe (Server -> Client):** `BroadcastMessageReceived`

| Field | Type | Description |
|-------|------|-------------|
| `message_id` | `string` | Unique broadcast message ID |
| `sender_id` | `string` | Originator ID (system or user) |
| `title` | `string` | Broadcast message title |
| `content` | `string` | Broadcast message content |
| `priority` | `string` | Delivery priority |
| `timestamp` | `string` | Time of broadcast emission |
| `expires_at` | `string` | Optional expiration timestamp |

**Publish (Client -> Server):** `AcknowledgeBroadcastMessage`

| Field | Type | Description |
|-------|------|-------------|
| `message_id` | `string` | Broadcast message ID being acknowledged |
| `received_at` | `string` | Client receipt timestamp |
| `status` | `string` | Acknowledgment status |

---

### `chat/mentions`

Real-time @mention notifications in group chats

**Subscribe (Server -> Client):** `MentionNotification`

| Field | Type | Description |
|-------|------|-------------|
| `notification_id` | `string` | Unique notification ID |
| `conversation_id` | `string` | Group chat ID |
| `message_id` | `string` | Message containing the @mention |
| `mentioning_user_id` | `string` | User who mentioned |
| `mentioned_user_id` | `string` | User who was mentioned |
| `content_preview` | `string` | Preview of message content |
| `timestamp` | `string` | Mention time |

**Publish (Client -> Server):** `AcknowledgeMention`

| Field | Type | Description |
|-------|------|-------------|
| `notification_id` | `string` | Notification ID being acknowledged |
| `ack_timestamp` | `string` | Acknowledgment time |

---

### `chat/groups`

Group chat creation and lifecycle events

**Subscribe (Server -> Client):** `GroupCreated`

| Field | Type | Description |
|-------|------|-------------|
| `group_id` | `string` | Unique group chat ID |
| `name` | `string` | Group name |
| `creator_id` | `string` | User ID of the creator |
| `member_ids` | `array` | Initial member user IDs |
| `created_at` | `string` | Creation timestamp |

**Publish (Client -> Server):** `CreateGroup`

| Field | Type | Description |
|-------|------|-------------|
| `name` | `string` | Desired group name |
| `member_ids` | `array` | User IDs to add to the group |
| `client_request_id` | `string` | Client-generated id for idempotency and tracking |

---

### `chat/groups/ack`

Acknowledgments for group creation requests

**Subscribe (Server -> Client):** `CreateGroupAck`

| Field | Type | Description |
|-------|------|-------------|
| `client_request_id` | `string` | Client-generated id to correlate the request |
| `status` | `string` | Result of the request |
| `group_id` | `string` | Created group ID when accepted |
| `error_code` | `string` | Error code when rejected |
| `error_message` | `string` | Human-readable error message |
| `timestamp` | `string` | Acknowledgment time |

**Publish (Client -> Server):** `AcknowledgeGroupCreate`

| Field | Type | Description |
|-------|------|-------------|
| `client_request_id` | `string` | Client-generated id to correlate the request |
| `received_at` | `string` | Client receipt time |

---

### `group/membership`

Group membership management

**Subscribe (Server -> Client):** `LeaveGroupAck`

| Field | Type | Description |
|-------|------|-------------|
| `request_id` | `string` | Client-generated request correlation ID |
| `group_id` | `string` | Group ID that was left |
| `user_id` | `string` | User ID that left the group |
| `status` | `string` | Result of the leave request |
| `timestamp` | `string` | Server timestamp of processing |
| `reason` | `string` | Optional error reason if rejected |

**Publish (Client -> Server):** `LeaveGroup`

| Field | Type | Description |
|-------|------|-------------|
| `request_id` | `string` | Client-generated request correlation ID |
| `group_id` | `string` | Group ID to leave |

---

### `broadcast/{channel_id}`

One-way broadcast channel delivering server-originated messages to all subscribed clients

**Subscribe (Server -> Client):** `BroadcastMessage`

| Field | Type | Description |
|-------|------|-------------|
| `message_id` | `string` | Unique broadcast message ID |
| `channel_id` | `string` | Broadcast channel identifier |
| `title` | `string` | Message title or topic |
| `payload` | `object` | Broadcast payload data |
| `timestamp` | `string` | Time of broadcast |
| `priority` | `string` | Delivery priority |

---

### `chat/polls`

Real-time poll features in group and direct chats

**Subscribe (Server -> Client):** `PollCreated`

| Field | Type | Description |
|-------|------|-------------|
| `poll_id` | `string` | Unique poll ID |
| `conversation_id` | `string` | Conversation ID |
| `creator_id` | `string` | User who created the poll |
| `question` | `string` | Poll question |
| `options` | `array` |  |
| `multi_select` | `boolean` | Whether multiple options can be selected |
| `expires_at` | `string` | Poll expiration time |
| `created_at` | `string` | Creation time |

**Publish (Client -> Server):** `CreatePoll`

| Field | Type | Description |
|-------|------|-------------|
| `conversation_id` | `string` | Conversation ID |
| `question` | `string` | Poll question |
| `options` | `array` |  |
| `multi_select` | `boolean` | Allow multiple selections |
| `expires_at` | `string` | Poll expiration time |

---

### `chat/polls/votes`

Real-time poll voting updates

**Subscribe (Server -> Client):** `PollVoteUpdated`

| Field | Type | Description |
|-------|------|-------------|
| `poll_id` | `string` | Poll ID |
| `conversation_id` | `string` | Conversation ID |
| `option_id` | `string` | Option ID |
| `vote_count` | `integer` | Updated vote count |
| `voter_id` | `string` | User who voted |
| `updated_at` | `string` | Update time |

**Publish (Client -> Server):** `VotePoll`

| Field | Type | Description |
|-------|------|-------------|
| `poll_id` | `string` | Poll ID |
| `conversation_id` | `string` | Conversation ID |
| `selected_option_ids` | `array` |  |

---

### `chat/polls/status`

Poll lifecycle updates

**Subscribe (Server -> Client):** `PollClosed`

| Field | Type | Description |
|-------|------|-------------|
| `poll_id` | `string` | Poll ID |
| `conversation_id` | `string` | Conversation ID |
| `closed_by` | `string` | User who closed the poll or system |
| `closed_at` | `string` | Closure time |
| `final_results` | `array` |  |

**Publish (Client -> Server):** `ClosePoll`

| Field | Type | Description |
|-------|------|-------------|
| `poll_id` | `string` | Poll ID |
| `conversation_id` | `string` | Conversation ID |

---

### `group/events`

Real-time event planning updates within a group

**Subscribe (Server -> Client):** `GroupEventUpdated`

| Field | Type | Description |
|-------|------|-------------|
| `event_id` | `string` | Unique event ID |
| `group_id` | `string` | Group ID |
| `title` | `string` | Event title |
| `description` | `string` | Event description |
| `start_time` | `string` |  |
| `end_time` | `string` |  |
| `location` | `string` | Event location or virtual link |
| `organizer_id` | `string` | Organizer user ID |
| `updated_at` | `string` |  |
| `version` | `integer` | Event version for concurrency control |

**Publish (Client -> Server):** `UpsertGroupEvent`

| Field | Type | Description |
|-------|------|-------------|
| `event_id` | `string` | Event ID for update; omit for create |
| `group_id` | `string` |  |
| `title` | `string` |  |
| `description` | `string` |  |
| `start_time` | `string` |  |
| `end_time` | `string` |  |
| `location` | `string` |  |
| `expected_version` | `integer` | Last known version to prevent conflicts |
| `request_id` | `string` | Client-generated idempotency key |

---

### `group/events/ack`

Acknowledgments for event create/update/delete operations

**Subscribe (Server -> Client):** `GroupEventAck`

| Field | Type | Description |
|-------|------|-------------|
| `request_id` | `string` | Client request ID |
| `status` | `string` |  |
| `event_id` | `string` |  |
| `reason` | `string` | Error reason if rejected |
| `current_version` | `integer` | Current event version |

**Publish (Client -> Server):** `DeleteGroupEvent`

| Field | Type | Description |
|-------|------|-------------|
| `event_id` | `string` |  |
| `group_id` | `string` |  |
| `expected_version` | `integer` |  |
| `request_id` | `string` |  |

---

### `group/events/rsvp`

Real-time RSVP updates for group events

**Subscribe (Server -> Client):** `GroupEventRsvpUpdated`

| Field | Type | Description |
|-------|------|-------------|
| `event_id` | `string` |  |
| `group_id` | `string` |  |
| `user_id` | `string` |  |
| `status` | `string` |  |
| `updated_at` | `string` |  |

**Publish (Client -> Server):** `SetGroupEventRsvp`

| Field | Type | Description |
|-------|------|-------------|
| `event_id` | `string` |  |
| `group_id` | `string` |  |
| `status` | `string` |  |
| `request_id` | `string` |  |

---

### `group/events/reminders`

Real-time event reminders for group events

**Subscribe (Server -> Client):** `GroupEventReminder`

| Field | Type | Description |
|-------|------|-------------|
| `event_id` | `string` |  |
| `group_id` | `string` |  |
| `title` | `string` |  |
| `start_time` | `string` |  |
| `reminder_time` | `string` |  |

**Publish (Client -> Server):** `SetGroupEventReminder`

| Field | Type | Description |
|-------|------|-------------|
| `event_id` | `string` |  |
| `group_id` | `string` |  |
| `reminder_time` | `string` |  |
| `request_id` | `string` |  |

---

### `call/signaling`

Signaling for encrypted voice calls (SDP/ICE exchange and call control)

**Subscribe (Server -> Client):** `CallSignalReceived`

| Field | Type | Description |
|-------|------|-------------|
| `call_id` | `string` | Call identifier |
| `from_user_id` | `string` | Sender user ID |
| `type` | `string` | Signal type |
| `payload` | `object` | SDP/ICE payload with server-masked candidates |
| `timestamp` | `string` |  |

**Publish (Client -> Server):** `SendCallSignal`

| Field | Type | Description |
|-------|------|-------------|
| `call_id` | `string` |  |
| `to_user_id` | `string` |  |
| `type` | `string` |  |
| `payload` | `object` | SDP/ICE payload without exposing client IP to peer |

---

### `call/crypto`

End-to-end encryption key exchange metadata for video calls

**Subscribe (Server -> Client):** `CryptoSignalReceived`

| Field | Type | Description |
|-------|------|-------------|
| `call_id` | `string` |  |
| `from_user_id` | `string` |  |
| `type` | `string` |  |
| `key_id` | `string` | Identifier for the negotiated key |
| `payload` | `string` | Encrypted key exchange payload |
| `timestamp` | `string` |  |

**Publish (Client -> Server):** `SendCryptoSignal`

| Field | Type | Description |
|-------|------|-------------|
| `call_id` | `string` |  |
| `type` | `string` |  |
| `key_id` | `string` |  |
| `payload` | `string` |  |
| `timestamp` | `string` |  |

---

### `call/ack`

Acknowledgements for call actions to ensure fast response

**Subscribe (Server -> Client):** `CallActionAck`

| Field | Type | Description |
|-------|------|-------------|
| `client_request_id` | `string` | Client-generated id being acknowledged |
| `call_id` | `string` | Unique call ID |
| `status` | `string` | Ack status |
| `timestamp` | `string` |  |

**Publish (Client -> Server):** `RequestAck`

| Field | Type | Description |
|-------|------|-------------|
| `client_request_id` | `string` | Client-generated id to track |
| `action` | `string` |  |
| `call_id` | `string` | Unique call ID |

---

### `call/session`

Call session lifecycle and encrypted call setup

**Subscribe (Server -> Client):** `CallSessionEvent`

| Field | Type | Description |
|-------|------|-------------|
| `call_id` | `string` | Unique call session ID |
| `event` | `string` |  |
| `from_user_id` | `string` | Caller user ID |
| `to_user_id` | `string` | Callee user ID |
| `timestamp` | `string` |  |
| `reason` | `string` | Failure or end reason |

**Publish (Client -> Server):** `CallSessionCommand`

| Field | Type | Description |
|-------|------|-------------|
| `action` | `string` |  |
| `call_id` | `string` | Call session ID |
| `to_user_id` | `string` | Target user ID |
| `timestamp` | `string` |  |

---

### `call/signal`

Signaling exchange routed via server to avoid exposing peer IPs

**Subscribe (Server -> Client):** `CallSignalReceived`

| Field | Type | Description |
|-------|------|-------------|
| `call_id` | `string` | Call identifier |
| `from_user_id` | `string` | Sender user ID |
| `type` | `string` | Signal type |
| `payload` | `object` | SDP/ICE payload with server-masked candidates |
| `timestamp` | `string` |  |

**Publish (Client -> Server):** `SendCallSignal`

| Field | Type | Description |
|-------|------|-------------|
| `call_id` | `string` |  |
| `to_user_id` | `string` |  |
| `type` | `string` |  |
| `payload` | `object` | SDP/ICE payload without exposing client IP to peer |

---

### `call/groups/{call_id}/control`

Group call lifecycle and participant management

**Subscribe (Server -> Client):** `GroupCallEvent`

| Field | Type | Description |
|-------|------|-------------|
| `event` | `string` |  |
| `call_id` | `string` |  |
| `participant_id` | `string` |  |
| `timestamp` | `string` |  |
| `reason` | `string` |  |

**Publish (Client -> Server):** `GroupCallCommand`

| Field | Type | Description |
|-------|------|-------------|
| `command` | `string` |  |
| `call_id` | `string` |  |
| `participants` | `array` |  |
| `device_id` | `string` |  |

---

### `call/groups/{call_id}/signal`

WebRTC signaling for group call media negotiation

**Subscribe (Server -> Client):** `SignalReceived`

| Field | Type | Description |
|-------|------|-------------|
| `call_id` | `string` |  |
| `from_participant_id` | `string` |  |
| `type` | `string` |  |
| `sdp` | `string` |  |
| `candidate` | `object` |  |
| `timestamp` | `string` |  |

**Publish (Client -> Server):** `SendSignal`

| Field | Type | Description |
|-------|------|-------------|
| `call_id` | `string` |  |
| `to_participant_id` | `string` |  |
| `type` | `string` |  |
| `sdp` | `string` |  |
| `candidate` | `object` |  |

---

### `call/groups/{call_id}/ack`

Acknowledgments for critical group call actions

**Subscribe (Server -> Client):** `CommandAck`

| Field | Type | Description |
|-------|------|-------------|
| `command_id` | `string` |  |
| `call_id` | `string` |  |
| `status` | `string` |  |
| `reason` | `string` |  |
| `timestamp` | `string` |  |

**Publish (Client -> Server):** `AckRequest`

| Field | Type | Description |
|-------|------|-------------|
| `command_id` | `string` |  |
| `call_id` | `string` |  |
| `command` | `string` |  |

---

### `call/screen-share`

Screen sharing control and signaling during a call

**Subscribe (Server -> Client):** `ScreenShareEvent`

| Field | Type | Description |
|-------|------|-------------|
| `event_type` | `string` | Type of screen share event |
| `call_id` | `string` | Call identifier |
| `share_id` | `string` | Screen share session identifier |
| `owner_id` | `string` | User ID of the screen share owner |
| `timestamp` | `string` | Event time |
| `sdp` | `string` | SDP payload for offer/answer |
| `candidate` | `object` | ICE candidate payload |
| `error_code` | `string` |  |
| `error_message` | `string` |  |

**Publish (Client -> Server):** `ScreenShareCommand`

| Field | Type | Description |
|-------|------|-------------|
| `command` | `string` | Command type |
| `call_id` | `string` | Call identifier |
| `share_id` | `string` | Screen share session identifier |
| `sdp` | `string` | SDP payload for offer/answer |
| `candidate` | `object` | ICE candidate payload |
| `request_id` | `string` | Client-generated id for acknowledgment |

---

### `call/screen-share/ack`

Acknowledgments for screen share commands

**Subscribe (Server -> Client):** `ScreenShareAck`

| Field | Type | Description |
|-------|------|-------------|
| `request_id` | `string` | Client-generated id from the command |
| `status` | `string` |  |
| `reason` | `string` |  |
| `timestamp` | `string` |  |

---

### `call/link`

Real-time updates for scheduled call access links

**Subscribe (Server -> Client):** `CallLinkUpdated`

| Field | Type | Description |
|-------|------|-------------|
| `call_id` | `string` | Scheduled call ID |
| `link_url` | `string` | Shareable call link URL |
| `action` | `string` | Type of link change |
| `expires_at` | `string` | Link expiration timestamp |
| `updated_at` | `string` | Update timestamp |

**Publish (Client -> Server):** `RequestCallLink`

| Field | Type | Description |
|-------|------|-------------|
| `call_id` | `string` | Scheduled call ID |
| `action` | `string` | Requested link action |
| `request_id` | `string` | Client-generated idempotency/trace ID |

---

### `call/link/ack`

Acknowledgment of call link requests

**Subscribe (Server -> Client):** `CallLinkRequestAck`

| Field | Type | Description |
|-------|------|-------------|
| `request_id` | `string` | Client-generated idempotency/trace ID |
| `status` | `string` | Result of the request |
| `reason` | `string` | Rejection reason if any |
| `processed_at` | `string` | Processing timestamp |

**Publish (Client -> Server):** `AckReceipt`

| Field | Type | Description |
|-------|------|-------------|
| `call_id` | `string` | Scheduled call ID |
| `event_id` | `string` | Server event ID |
| `received_at` | `string` | Client receipt timestamp |

---

### `call/decision`

Real-time call decision signaling

**Subscribe (Server -> Client):** `CallDeclined`

| Field | Type | Description |
|-------|------|-------------|
| `call_id` | `string` | Unique call ID |
| `decliner_id` | `string` | User ID who declined the call |
| `message` | `string` | Optional decline message |
| `timestamp` | `string` |  |

**Publish (Client -> Server):** `DeclineCallWithMessage`

| Field | Type | Description |
|-------|------|-------------|
| `call_id` | `string` | Unique call ID |
| `message` | `string` | Optional decline message |
| `client_request_id` | `string` | Client-generated id for fast acknowledgement |

---

### `call/history`

Real-time call history updates for a user

**Subscribe (Server -> Client):** `CallHistoryEntryAdded`

| Field | Type | Description |
|-------|------|-------------|
| `entry_id` | `string` | Unique call history entry ID |
| `call_id` | `string` | Unique call session ID |
| `direction` | `string` |  |
| `status` | `string` |  |
| `counterparty_id` | `string` | Other participant user ID |
| `started_at` | `string` |  |
| `ended_at` | `string` |  |
| `duration_ms` | `integer` | Call duration in milliseconds |

**Publish (Client -> Server):** `CallHistoryRequest`

| Field | Type | Description |
|-------|------|-------------|
| `since` | `string` | Return entries updated since this timestamp |
| `limit` | `integer` | Maximum number of entries to return |

---

### `call/history/snapshot`

Snapshot delivery of call history for a user

**Subscribe (Server -> Client):** `CallHistorySnapshot`

| Field | Type | Description |
|-------|------|-------------|
| `entries` | `array` | List of call history entries |

**Publish (Client -> Server):** `CallHistoryAck`

| Field | Type | Description |
|-------|------|-------------|
| `snapshot_id` | `string` | Snapshot correlation ID |
| `received_at` | `string` |  |

---

### `status/updates`

Real-time 24-hour status update creation and delivery

**Subscribe (Server -> Client):** `StatusCreated`

| Field | Type | Description |
|-------|------|-------------|
| `status_id` | `string` | Unique status ID |
| `author_id` | `string` | User who created the status |
| `content_type` | `string` | Status content type |
| `content_url` | `string` | URL to media content if applicable |
| `text` | `string` | Text content if applicable |
| `created_at` | `string` |  |
| `expires_at` | `string` |  |

**Publish (Client -> Server):** `CreateStatus`

| Field | Type | Description |
|-------|------|-------------|
| `content_type` | `string` |  |
| `content_url` | `string` | URL to media content if applicable |
| `text` | `string` | Text content if applicable |
| `client_request_id` | `string` | Client-generated idempotency key |

---

### `status/ack`

Acknowledgment for status creation requests

**Subscribe (Server -> Client):** `CreateStatusAck`

| Field | Type | Description |
|-------|------|-------------|
| `client_request_id` | `string` | Client-generated idempotency key |
| `status` | `string` |  |
| `status_id` | `string` | Created status ID if accepted |
| `error_code` | `string` | Error code if rejected |
| `error_message` | `string` | Human-readable error if rejected |

---

### `user/presence`

Real-time online status updates with visibility rules applied

**Subscribe (Server -> Client):** `PresenceStatusUpdated`

| Field | Type | Description |
|-------|------|-------------|
| `user_id` | `string` | User whose status changed |
| `status` | `string` | Current presence status |
| `last_seen_at` | `string` | Last seen timestamp (only if visibility allows) |
| `visibility_applied` | `string` | Visibility rule used to determine what is shown |
| `timestamp` | `string` | Event emission time |

---

### `status/response`

Real-time status request and response handling

**Subscribe (Server -> Client):** `StatusResponseReceived`

| Field | Type | Description |
|-------|------|-------------|
| `request_id` | `string` | Correlation ID for the status request |
| `status` | `string` | Status value returned by the system |
| `details` | `string` | Optional human-readable status details |
| `timestamp` | `string` | Time the status response was generated |

**Publish (Client -> Server):** `RequestStatus`

| Field | Type | Description |
|-------|------|-------------|
| `request_id` | `string` | Client-generated correlation ID |
| `target` | `string` | Optional target subsystem or component |

---

### `user/status/visibility`

Manage and receive updates to status visibility settings

**Subscribe (Server -> Client):** `StatusVisibilityUpdated`

| Field | Type | Description |
|-------|------|-------------|
| `user_id` | `string` | User whose settings changed |
| `visibility` | `string` | Current visibility level |
| `allowed_user_ids` | `array` | Explicitly allowed users (if visibility=custom) |
| `blocked_user_ids` | `array` | Explicitly blocked users (optional) |
| `timestamp` | `string` |  |

**Publish (Client -> Server):** `SetStatusVisibility`

| Field | Type | Description |
|-------|------|-------------|
| `visibility` | `string` |  |
| `allowed_user_ids` | `array` | Required if visibility=custom |
| `blocked_user_ids` | `array` | Optional list of blocked users |

---

### `user/status`

Real-time delivery of status changes honoring visibility rules

**Subscribe (Server -> Client):** `UserStatusChanged`

| Field | Type | Description |
|-------|------|-------------|
| `user_id` | `string` | User whose status changed |
| `status` | `string` |  |
| `last_active_at` | `string` | Last active timestamp when permitted by visibility |
| `visibility_applied` | `string` | Indicates whether status details are visible or redacted |
| `timestamp` | `string` |  |

**Publish (Client -> Server):** `SetUserStatus`

| Field | Type | Description |
|-------|------|-------------|
| `status` | `string` |  |
| `last_active_at` | `string` |  |

---

### `user/status/visibility/ack`

Acknowledgments for status visibility updates

**Subscribe (Server -> Client):** `SetStatusVisibilityAck`

| Field | Type | Description |
|-------|------|-------------|
| `request_id` | `string` | Client-generated request ID |
| `success` | `boolean` |  |
| `error_code` | `string` |  |
| `error_message` | `string` |  |
| `timestamp` | `string` |  |

**Publish (Client -> Server):** `SetStatusVisibilityAckRequest`

| Field | Type | Description |
|-------|------|-------------|
| `request_id` | `string` |  |

---

### `contacts/status-mute`

Manage muting of contact status updates

**Subscribe (Server -> Client):** `ContactStatusMuteChanged`

| Field | Type | Description |
|-------|------|-------------|
| `contact_id` | `string` | Contact user ID |
| `muted` | `boolean` | Whether status updates are muted for this contact |
| `changed_by` | `string` | User ID who performed the change |
| `timestamp` | `string` | Change time |

**Publish (Client -> Server):** `SetContactStatusMute`

| Field | Type | Description |
|-------|------|-------------|
| `contact_id` | `string` | Contact user ID |
| `muted` | `boolean` | Set true to mute, false to unmute |
| `request_id` | `string` | Client-generated id for acknowledgment correlation |

---

### `contacts/status-mute/ack`

Acknowledgment for contact status mute requests

**Subscribe (Server -> Client):** `ContactStatusMuteAck`

| Field | Type | Description |
|-------|------|-------------|
| `request_id` | `string` | Client request id |
| `success` | `boolean` | Whether the operation succeeded |
| `error_code` | `string` | Error code if failed |
| `error_message` | `string` | Error message if failed |
| `timestamp` | `string` | Acknowledgment time |

**Publish (Client -> Server):** `AckContactStatusMute`

| Field | Type | Description |
|-------|------|-------------|
| `event_id` | `string` | Server event id |
| `received_at` | `string` | Client receipt time |

---

### `chat/stickers`

Real-time sticker delivery in chats

**Subscribe (Server -> Client):** `StickerMessageReceived`

| Field | Type | Description |
|-------|------|-------------|
| `message_id` | `string` | Unique message ID |
| `conversation_id` | `string` | Conversation ID |
| `sender_id` | `string` | Sender user ID |
| `sticker_id` | `string` | Sticker asset ID |
| `sticker_pack_id` | `string` | Sticker pack ID |
| `timestamp` | `string` | Server timestamp |

**Publish (Client -> Server):** `SendStickerMessage`

| Field | Type | Description |
|-------|------|-------------|
| `conversation_id` | `string` |  |
| `sticker_id` | `string` |  |
| `sticker_pack_id` | `string` |  |
| `client_message_id` | `string` | Client-generated ID for idempotency |

---

### `chat/camera/session`

Control and state events for camera usage within a chat

**Subscribe (Server -> Client):** `CameraSessionStatus`

| Field | Type | Description |
|-------|------|-------------|
| `session_id` | `string` | Unique camera session ID |
| `conversation_id` | `string` | Chat conversation ID |
| `user_id` | `string` | User whose camera state changed |
| `state` | `string` |  |
| `reason` | `string` | Optional failure reason |
| `timestamp` | `string` |  |

**Publish (Client -> Server):** `RequestCameraSession`

| Field | Type | Description |
|-------|------|-------------|
| `conversation_id` | `string` |  |
| `device_id` | `string` | Selected camera device ID |
| `resolution` | `object` |  |
| `fps` | `integer` | Requested frames per second |

---

### `chat/camera/control`

Client control actions for an active camera session

**Subscribe (Server -> Client):** `CameraControlAck`

| Field | Type | Description |
|-------|------|-------------|
| `action_id` | `string` | Client-generated action ID |
| `session_id` | `string` |  |
| `status` | `string` |  |
| `reason` | `string` |  |
| `timestamp` | `string` |  |

**Publish (Client -> Server):** `CameraControlAction`

| Field | Type | Description |
|-------|------|-------------|
| `action_id` | `string` |  |
| `session_id` | `string` |  |
| `action` | `string` |  |
| `device_id` | `string` | New device for switch_device |

---

### `chat/camera/signal`

WebRTC signaling for direct camera streaming in chat

**Subscribe (Server -> Client):** `CameraSignal`

| Field | Type | Description |
|-------|------|-------------|
| `session_id` | `string` |  |
| `from_user_id` | `string` |  |
| `signal_type` | `string` |  |
| `payload` | `object` | SDP or ICE candidate payload |
| `timestamp` | `string` |  |

**Publish (Client -> Server):** `SendCameraSignal`

| Field | Type | Description |
|-------|------|-------------|
| `session_id` | `string` |  |
| `signal_type` | `string` |  |
| `payload` | `object` |  |

---

### `crypto/keys`

End-to-end encryption key exchange and rotation

**Subscribe (Server -> Client):** `PublicKeyReceived`

| Field | Type | Description |
|-------|------|-------------|
| `user_id` | `string` | Recipient user ID |
| `key_id` | `string` | Public key identifier |
| `public_key` | `string` | Recipient public key (base64) |
| `algorithm` | `string` | Key algorithm, e.g., X25519 |
| `timestamp` | `string` |  |

**Publish (Client -> Server):** `PublishPublicKey`

| Field | Type | Description |
|-------|------|-------------|
| `user_id` | `string` | Sender user ID |
| `key_id` | `string` | Public key identifier |
| `public_key` | `string` | Sender public key (base64) |
| `algorithm` | `string` | Key algorithm, e.g., X25519 |

---

### `app/lock`

Real-time app lock state management

**Subscribe (Server -> Client):** `AppLockStateChanged`

| Field | Type | Description |
|-------|------|-------------|
| `state` | `string` | Current app lock state |
| `reason` | `string` | Reason for state change |
| `timestamp` | `string` | Event time |

**Publish (Client -> Server):** `RequestAppLock`

| Field | Type | Description |
|-------|------|-------------|
| `reason` | `string` | Reason for locking |

---

### `app/lock/auth`

Authentication flow for app unlock

**Subscribe (Server -> Client):** `AuthChallenge`

| Field | Type | Description |
|-------|------|-------------|
| `challenge_id` | `string` | Unique challenge identifier |
| `method` | `string` | Authentication method |
| `timestamp` | `string` | Challenge time |

**Publish (Client -> Server):** `SubmitAuthResponse`

| Field | Type | Description |
|-------|------|-------------|
| `challenge_id` | `string` | Challenge identifier being پاسخ to |
| `method` | `string` | Authentication method used |
| `credential` | `string` | Credential payload (e.g., PIN/password token) |

---

### `app/lock/ack`

Acknowledgments for lock/auth operations

**Subscribe (Server -> Client):** `AppLockAck`

| Field | Type | Description |
|-------|------|-------------|
| `request_id` | `string` | Client request ID |
| `status` | `string` | Result of the request |
| `error_code` | `string` | Error code if rejected |
| `message` | `string` | Human-readable status message |
| `timestamp` | `string` | Ack time |

**Publish (Client -> Server):** `ClientRequestWithId`

| Field | Type | Description |
|-------|------|-------------|
| `request_id` | `string` | Client-generated request identifier |
| `type` | `string` | Request type |

---

### `moderation/reports`

Real-time reporting of messages and contacts

**Subscribe (Server -> Client):** `ReportStatusUpdate`

| Field | Type | Description |
|-------|------|-------------|
| `report_id` | `string` | Unique report ID |
| `status` | `string` | Current report status |
| `updated_at` | `string` | Status update timestamp |

**Publish (Client -> Server):** `SubmitReport`

| Field | Type | Description |
|-------|------|-------------|
| `report_type` | `string` | Type of entity being reported |
| `target_id` | `string` | ID of the message or contact being reported |
| `reason` | `string` | Reason for reporting |
| `details` | `string` | Additional report details |
| `timestamp` | `string` | Client-side submission time |

---

### `moderation/reports/ack`

Acknowledgment for report submission

**Subscribe (Server -> Client):** `ReportSubmitted`

| Field | Type | Description |
|-------|------|-------------|
| `report_id` | `string` | Unique report ID |
| `received_at` | `string` | Server receipt timestamp |

**Publish (Client -> Server):** `SubmitReportAckRequest`

| Field | Type | Description |
|-------|------|-------------|
| `client_request_id` | `string` | Client-generated request ID for idempotency |

---

### `call/privacy`

Privacy and relay status events to confirm IP masking

**Subscribe (Server -> Client):** `IpMaskingStatus`

| Field | Type | Description |
|-------|------|-------------|
| `call_id` | `string` |  |
| `status` | `string` | Masking status |
| `relay_region` | `string` | Relay region identifier |
| `timestamp` | `string` |  |

**Publish (Client -> Server):** `RequestIpMasking`

| Field | Type | Description |
|-------|------|-------------|
| `call_id` | `string` |  |
| `preferred_region` | `string` | Preferred relay region |

---

### `call/acks`

Acknowledgments for signaling/relay operations

**Subscribe (Server -> Client):** `SignalAck`

| Field | Type | Description |
|-------|------|-------------|
| `call_id` | `string` |  |
| `message_id` | `string` |  |
| `status` | `string` |  |
| `error_code` | `string` |  |
| `error_message` | `string` |  |

**Publish (Client -> Server):** `AckSignalReceived`

| Field | Type | Description |
|-------|------|-------------|
| `call_id` | `string` |  |
| `message_id` | `string` |  |
| `received_at` | `string` |  |

---

### `notifications/push`

Reliable push notification delivery

**Subscribe (Server -> Client):** `PushNotificationReceived`

| Field | Type | Description |
|-------|------|-------------|
| `notification_id` | `string` | Unique notification ID |
| `title` | `string` | Notification title |
| `body` | `string` | Notification body text |
| `category` | `string` | Notification category or type |
| `payload` | `object` | Additional notification data |
| `priority` | `string` | Delivery priority |
| `timestamp` | `string` | Server send time |
| `ttl_seconds` | `integer` | Time-to-live in seconds |

**Publish (Client -> Server):** `PushNotificationAck`

| Field | Type | Description |
|-------|------|-------------|
| `notification_id` | `string` | Acknowledged notification ID |
| `received_at` | `string` | Client receive timestamp |
| `status` | `string` | Receipt status |
| `failure_reason` | `string` | Reason for failure if status=failed |

---

### `notifications/push/acks`

Server confirms acknowledgment processing

**Subscribe (Server -> Client):** `PushNotificationAckConfirmed`

| Field | Type | Description |
|-------|------|-------------|
| `notification_id` | `string` | Notification ID |
| `ack_id` | `string` | Acknowledgment ID |
| `processed_at` | `string` | Server processing timestamp |

---

### `user/notifications/preview`

Real-time delivery of notification previews

**Subscribe (Server -> Client):** `NotificationPreviewReceived`

| Field | Type | Description |
|-------|------|-------------|
| `notification_id` | `string` | Unique notification ID |
| `preview_id` | `string` | Unique preview ID |
| `title` | `string` | Preview title |
| `body` | `string` | Preview body content |
| `sender` | `string` | Originator of the notification |
| `category` | `string` | Notification category |
| `priority` | `string` | Notification priority |
| `timestamp` | `string` | Time the preview was generated |
| `config_version` | `string` | Applied preview configuration version |

**Publish (Client -> Server):** `AcknowledgeNotificationPreview`

| Field | Type | Description |
|-------|------|-------------|
| `preview_id` | `string` | Preview ID being acknowledged |
| `received_at` | `string` | Client receipt timestamp |

---

### `user/notifications/preview/config`

Real-time configuration of notification preview settings

**Subscribe (Server -> Client):** `NotificationPreviewConfigUpdated`

| Field | Type | Description |
|-------|------|-------------|
| `config_version` | `string` | New configuration version |
| `show_sender` | `boolean` | Whether sender information is shown |
| `show_body` | `boolean` | Whether body text is shown |
| `max_body_length` | `integer` | Maximum length of preview body |
| `allowed_categories` | `array` | Categories allowed for preview display |
| `updated_at` | `string` | Time configuration was updated |

**Publish (Client -> Server):** `UpdateNotificationPreviewConfig`

| Field | Type | Description |
|-------|------|-------------|
| `show_sender` | `boolean` | Whether to show sender information |
| `show_body` | `boolean` | Whether to show body text |
| `max_body_length` | `integer` | Maximum length of preview body |
| `allowed_categories` | `array` | Categories allowed for preview display |

---

### `notifications/messages`

Benachrichtigungen zu eingehenden Nachrichten inkl. Schnellantwort

**Subscribe (Server -> Client):** `NotificationMessageReceived`

| Field | Type | Description |
|-------|------|-------------|
| `notification_id` | `string` | Eindeutige ID der Benachrichtigung |
| `message_id` | `string` | Eindeutige ID der Nachricht |
| `conversation_id` | `string` | Zugehörige Konversation |
| `sender_id` | `string` | Absender der Nachricht |
| `preview` | `string` | Kurzvorschau des Inhalts |
| `timestamp` | `string` |  |
| `quick_reply_allowed` | `boolean` | Gibt an, ob Schnellantwort möglich ist |

**Publish (Client -> Server):** `SendQuickReply`

| Field | Type | Description |
|-------|------|-------------|
| `notification_id` | `string` | Referenz auf die Benachrichtigung |
| `conversation_id` | `string` | Zugehörige Konversation |
| `content` | `string` | Inhalt der Schnellantwort |
| `client_msg_id` | `string` | Client-seitige Nachricht-ID zur Idempotenz |

---

### `notifications/acks`

Bestätigungen für Schnellantworten

**Subscribe (Server -> Client):** `QuickReplyAcknowledged`

| Field | Type | Description |
|-------|------|-------------|
| `client_msg_id` | `string` | Client-seitige Nachricht-ID |
| `message_id` | `string` | Server-seitige Nachricht-ID |
| `status` | `string` |  |
| `reason` | `string` | Fehlergrund bei Ablehnung |
| `timestamp` | `string` |  |

**Publish (Client -> Server):** `AckQuickReplyReceived`

| Field | Type | Description |
|-------|------|-------------|
| `message_id` | `string` |  |
| `received_at` | `string` |  |

---

### `call/notifications/settings`

Real-time call notification settings updates per user

**Subscribe (Server -> Client):** `CallNotificationSettingsUpdated`

| Field | Type | Description |
|-------|------|-------------|
| `user_id` | `string` | User whose settings were updated |
| `call_notifications_enabled` | `boolean` | Master toggle for call notifications |
| `ringtone_enabled` | `boolean` | Whether ringtone sound is enabled |
| `vibration_enabled` | `boolean` | Whether vibration is enabled |
| `do_not_disturb` | `boolean` | Whether call notifications are suppressed |
| `updated_at` | `string` | Timestamp of last update |

**Publish (Client -> Server):** `UpdateCallNotificationSettings`

| Field | Type | Description |
|-------|------|-------------|
| `call_notifications_enabled` | `boolean` |  |
| `ringtone_enabled` | `boolean` |  |
| `vibration_enabled` | `boolean` |  |
| `do_not_disturb` | `boolean` |  |
| `client_request_id` | `string` | Idempotency token for update requests |

---

### `contacts/sync`

Real-time contact synchronization control and status

**Subscribe (Server -> Client):** `ContactSyncStatus`

| Field | Type | Description |
|-------|------|-------------|
| `sync_id` | `string` | Unique sync operation ID |
| `status` | `string` |  |
| `processed` | `integer` | Number of contacts processed |
| `matched` | `integer` | Number of contacts matched to WhatsApp users |
| `failed` | `integer` | Number of contacts that failed processing |
| `timestamp` | `string` |  |
| `error_code` | `string` | Error code if failed |

**Publish (Client -> Server):** `StartContactSync`

| Field | Type | Description |
|-------|------|-------------|
| `sync_id` | `string` | Client-generated sync ID for idempotency |
| `device_id` | `string` | Device identifier |
| `contacts` | `array` | Contacts to be matched |

---

### `contacts/matches`

Real-time delivery of matched contacts

**Subscribe (Server -> Client):** `ContactMatchFound`

| Field | Type | Description |
|-------|------|-------------|
| `sync_id` | `string` | Associated sync operation ID |
| `matches` | `array` |  |
| `timestamp` | `string` |  |

**Publish (Client -> Server):** `AcknowledgeContactMatches`

| Field | Type | Description |
|-------|------|-------------|
| `sync_id` | `string` | Associated sync operation ID |
| `received_count` | `integer` | Number of matches received |

---

### `message/search`

Real-time Volltext-Suche in Nachrichten

**Subscribe (Server -> Client):** `MessageSearchResults`

| Field | Type | Description |
|-------|------|-------------|
| `search_id` | `string` | Eindeutige ID der Suchanfrage |
| `conversation_id` | `string` | Konversation, in der gesucht wurde |
| `query` | `string` | Suchbegriff(e) |
| `results` | `array` |  |
| `page` | `integer` | Seitennummer |
| `page_size` | `integer` | Anzahl pro Seite |
| `total_results` | `integer` | Gesamtanzahl Treffer |
| `has_more` | `boolean` | Weitere Treffer verfügbar |

**Publish (Client -> Server):** `SearchMessages`

| Field | Type | Description |
|-------|------|-------------|
| `search_id` | `string` | Client-seitig generierte Such-ID zur Korrelation |
| `conversation_id` | `string` | Konversation, in der gesucht wird |
| `query` | `string` | Suchbegriff(e) |
| `page` | `integer` | Seitennummer |
| `page_size` | `integer` | Anzahl pro Seite |
| `highlight` | `boolean` | Ob Treffer hervorgehoben werden sollen |

---

### `search/chats`

Real-time search for chats and contacts

**Subscribe (Server -> Client):** `SearchResults`

| Field | Type | Description |
|-------|------|-------------|
| `request_id` | `string` | Client-generated request ID to correlate results |
| `results` | `array` | Matched chats and contacts |
| `next_offset` | `integer` | Offset for pagination, if more results are available |
| `is_final` | `boolean` | Indicates whether this is the final result set |

**Publish (Client -> Server):** `SearchRequest`

| Field | Type | Description |
|-------|------|-------------|
| `request_id` | `string` | Client-generated request ID |
| `query` | `string` | Search string |
| `filters` | `object` | Optional filters |

---

### `search/ack`

Acknowledgment for search requests

**Subscribe (Server -> Client):** `SearchAck`

| Field | Type | Description |
|-------|------|-------------|
| `request_id` | `string` | Client-generated request ID |
| `status` | `string` | Processing status |
| `error` | `string` | Error message if rejected |

**Publish (Client -> Server):** `SearchAckRequest`

| Field | Type | Description |
|-------|------|-------------|
| `request_id` | `string` | Client-generated request ID |

---

### `user/presence-settings`

Manage configurable visibility of online status

**Subscribe (Server -> Client):** `PresenceVisibilityUpdated`

| Field | Type | Description |
|-------|------|-------------|
| `user_id` | `string` | User who changed settings |
| `visibility` | `string` | New visibility setting |
| `allowed_user_ids` | `array` | Explicitly allowed users (only for custom) |
| `blocked_user_ids` | `array` | Explicitly blocked users (optional) |
| `updated_at` | `string` |  |

**Publish (Client -> Server):** `UpdatePresenceVisibility`

| Field | Type | Description |
|-------|------|-------------|
| `visibility` | `string` | Desired visibility setting |
| `allowed_user_ids` | `array` | Users allowed to see status (required for custom) |
| `blocked_user_ids` | `array` | Users blocked from seeing status (optional) |

---

### `user/presence-ack`

Acknowledgments for presence settings updates

**Subscribe (Server -> Client):** `PresenceVisibilityUpdateAck`

| Field | Type | Description |
|-------|------|-------------|
| `request_id` | `string` | Client-generated request ID |
| `status` | `string` | Result of the update |
| `error_code` | `string` | Error code if rejected |
| `error_message` | `string` | Human-readable error message if rejected |
| `timestamp` | `string` |  |

**Publish (Client -> Server):** `PresenceVisibilityUpdateRequest`

| Field | Type | Description |
|-------|------|-------------|
| `request_id` | `string` | Client-generated request ID |
| `visibility` | `string` |  |
| `allowed_user_ids` | `array` |  |
| `blocked_user_ids` | `array` |  |

---

### `user/info-visibility`

Real-time updates for configurable info/status text visibility settings

**Subscribe (Server -> Client):** `InfoVisibilityUpdated`

| Field | Type | Description |
|-------|------|-------------|
| `user_id` | `string` | User whose settings changed |
| `visibility` | `object` | Visibility settings for info/status texts |
| `updated_at` | `string` | Time of update |

**Publish (Client -> Server):** `SetInfoVisibility`

| Field | Type | Description |
|-------|------|-------------|
| `user_id` | `string` | User updating settings |
| `visibility` | `object` | New visibility settings |
| `request_id` | `string` | Client request correlation ID |

---

### `user/info-visibility/ack`

Acknowledgment for visibility setting updates

**Subscribe (Server -> Client):** `InfoVisibilityUpdateAck`

| Field | Type | Description |
|-------|------|-------------|
| `request_id` | `string` | Client request correlation ID |
| `status` | `string` |  |
| `reason` | `string` | Reason for rejection, if any |
| `processed_at` | `string` |  |

---

### `chat/background`

Real-time synchronization of chat background settings

**Subscribe (Server -> Client):** `ChatBackgroundUpdated`

| Field | Type | Description |
|-------|------|-------------|
| `conversation_id` | `string` | Chat or conversation ID |
| `background_id` | `string` | Selected background identifier |
| `background_type` | `string` | Type of background |
| `value` | `string` | Color code, image URL, or gradient definition |
| `updated_by` | `string` | User ID who made the change |
| `timestamp` | `string` | Update time |

**Publish (Client -> Server):** `SetChatBackground`

| Field | Type | Description |
|-------|------|-------------|
| `conversation_id` | `string` | Chat or conversation ID |
| `background_id` | `string` | Selected background identifier |
| `background_type` | `string` | Type of background |
| `value` | `string` | Color code, image URL, or gradient definition |

---

### `chat/background/ack`

Acknowledgment for background change requests

**Subscribe (Server -> Client):** `SetChatBackgroundAck`

| Field | Type | Description |
|-------|------|-------------|
| `conversation_id` | `string` | Chat or conversation ID |
| `request_id` | `string` | Client-generated request ID |
| `status` | `string` | Result of the request |
| `reason` | `string` | Reason for rejection if any |
| `timestamp` | `string` | Acknowledgment time |

**Publish (Client -> Server):** `SetChatBackgroundWithAck`

| Field | Type | Description |
|-------|------|-------------|
| `conversation_id` | `string` | Chat or conversation ID |
| `request_id` | `string` | Client-generated request ID |
| `background_id` | `string` | Selected background identifier |
| `background_type` | `string` | Type of background |
| `value` | `string` | Color code, image URL, or gradient definition |

---

### `backup/chat`

Real-time chat backup and restore operations in the cloud

**Subscribe (Server -> Client):** `ChatBackupStatus`

| Field | Type | Description |
|-------|------|-------------|
| `job_id` | `string` | Backup or restore job ID |
| `conversation_id` | `string` | Conversation being processed |
| `operation` | `string` | Type of operation |
| `status` | `string` | Current job status |
| `progress_percent` | `number` | Progress percentage from 0 to 100 |
| `timestamp` | `string` | Status timestamp |
| `error_code` | `string` | Error code if failed |
| `error_message` | `string` | Error message if failed |

**Publish (Client -> Server):** `StartChatBackup`

| Field | Type | Description |
|-------|------|-------------|
| `conversation_id` | `string` | Conversation to back up |
| `include_media` | `boolean` | Whether to include media in backup |
| `scope` | `string` | Backup scope |

---

### `backup/chat/ack`

Acknowledgment for backup or restore requests

**Subscribe (Server -> Client):** `ChatBackupAck`

| Field | Type | Description |
|-------|------|-------------|
| `request_id` | `string` | Client-generated request ID |
| `job_id` | `string` | Assigned job ID |
| `accepted` | `boolean` | Whether the request was accepted |
| `timestamp` | `string` | Acknowledgment time |
| `reason` | `string` | Reason if not accepted |

**Publish (Client -> Server):** `StartChatRestore`

| Field | Type | Description |
|-------|------|-------------|
| `conversation_id` | `string` | Conversation to restore |
| `backup_id` | `string` | Backup snapshot ID to restore from |
| `request_id` | `string` | Client-generated request ID for acknowledgment tracking |

---

### `chat/export`

Real-time export of a single chat conversation

**Subscribe (Server -> Client):** `ExportChatProgress`

| Field | Type | Description |
|-------|------|-------------|
| `export_id` | `string` | Unique export job ID |
| `conversation_id` | `string` | Chat conversation ID |
| `status` | `string` | Current export status |
| `progress_pct` | `number` | Progress percentage from 0 to 100 |
| `timestamp` | `string` | Status update time |

**Publish (Client -> Server):** `ExportChatRequest`

| Field | Type | Description |
|-------|------|-------------|
| `conversation_id` | `string` | Chat conversation ID |
| `format` | `string` | Desired export format |
| `include_attachments` | `boolean` | Whether to include attachments |

---

### `chat/export/ack`

Acknowledgments and completion notifications for chat export

**Subscribe (Server -> Client):** `ExportChatReady`

| Field | Type | Description |
|-------|------|-------------|
| `export_id` | `string` | Unique export job ID |
| `conversation_id` | `string` | Chat conversation ID |
| `download_url` | `string` | Signed URL for downloading the export |
| `expires_at` | `string` | Download URL expiration time |
| `timestamp` | `string` | Completion time |

**Publish (Client -> Server):** `ExportChatCancel`

| Field | Type | Description |
|-------|------|-------------|
| `export_id` | `string` | Unique export job ID |
| `conversation_id` | `string` | Chat conversation ID |
| `reason` | `string` | Optional cancellation reason |

---

### `chat/export/errors`

Error notifications for chat export

**Subscribe (Server -> Client):** `ExportChatFailed`

| Field | Type | Description |
|-------|------|-------------|
| `export_id` | `string` | Unique export job ID |
| `conversation_id` | `string` | Chat conversation ID |
| `error_code` | `string` | Machine-readable error code |
| `error_message` | `string` | Human-readable error details |
| `timestamp` | `string` | Failure time |

**Publish (Client -> Server):** `ExportChatAck`

| Field | Type | Description |
|-------|------|-------------|
| `export_id` | `string` | Unique export job ID |
| `conversation_id` | `string` | Chat conversation ID |
| `ack_type` | `string` | Acknowledged event type |
| `timestamp` | `string` | Acknowledgment time |

---

### `chat/history`

Transfer chat history to a newly registered device

**Subscribe (Server -> Client):** `ChatHistoryChunk`

| Field | Type | Description |
|-------|------|-------------|
| `transfer_id` | `string` | Unique transfer session ID |
| `conversation_id` | `string` | Conversation identifier |
| `chunk_index` | `integer` | Zero-based chunk index |
| `total_chunks` | `integer` | Total number of chunks |
| `messages` | `array` | Messages in this chunk |

**Publish (Client -> Server):** `RequestChatHistory`

| Field | Type | Description |
|-------|------|-------------|
| `device_id` | `string` | New device identifier |
| `conversation_id` | `string` | Conversation identifier |
| `since_timestamp` | `string` | Optional lower bound for history sync |
| `page_size` | `integer` | Preferred messages per chunk |

---

### `chat/history/ack`

Acknowledgment and completion events for chat history transfer

**Subscribe (Server -> Client):** `ChatHistoryTransferComplete`

| Field | Type | Description |
|-------|------|-------------|
| `transfer_id` | `string` |  |
| `conversation_id` | `string` |  |
| `message_count` | `integer` |  |
| `completed_at` | `string` |  |

**Publish (Client -> Server):** `AckChatHistoryChunk`

| Field | Type | Description |
|-------|------|-------------|
| `transfer_id` | `string` |  |
| `conversation_id` | `string` |  |
| `chunk_index` | `integer` |  |
| `received_at` | `string` |  |

---

### `chat/archive`

Real-time chat archiving actions and status updates

**Subscribe (Server -> Client):** `ChatArchiveStatusChanged`

| Field | Type | Description |
|-------|------|-------------|
| `conversation_id` | `string` | Unique chat/conversation ID |
| `archived` | `boolean` | Whether the chat is archived |
| `changed_by` | `string` | User ID who performed the action |
| `timestamp` | `string` | When the status changed |

**Publish (Client -> Server):** `SetChatArchiveStatus`

| Field | Type | Description |
|-------|------|-------------|
| `conversation_id` | `string` | Unique chat/conversation ID |
| `archived` | `boolean` | true to archive, false to unarchive |
| `request_id` | `string` | Client-generated id for acknowledgment |

---

### `chat/archive/ack`

Acknowledgment for archive requests

**Subscribe (Server -> Client):** `ChatArchiveStatusAck`

| Field | Type | Description |
|-------|------|-------------|
| `request_id` | `string` | Client-generated id from request |
| `conversation_id` | `string` | Unique chat/conversation ID |
| `status` | `string` | Result of the request |
| `reason` | `string` | Rejection reason if any |
| `timestamp` | `string` | When the acknowledgment was generated |

---

### `chat/pins`

Real-time updates for pinned chats

**Subscribe (Server -> Client):** `ChatPinnedUpdated`

| Field | Type | Description |
|-------|------|-------------|
| `conversation_id` | `string` | ID of the conversation |
| `pinned` | `boolean` | Whether the chat is pinned |
| `pinned_by` | `string` | User ID who performed the pin action |
| `timestamp` | `string` |  |

**Publish (Client -> Server):** `SetChatPinned`

| Field | Type | Description |
|-------|------|-------------|
| `conversation_id` | `string` | ID of the conversation |
| `pinned` | `boolean` | Desired pin state |
| `request_id` | `string` | Client-generated request ID for acknowledgment |

---

### `chat/pins/ack`

Acknowledgments for pin/unpin requests

**Subscribe (Server -> Client):** `SetChatPinnedAck`

| Field | Type | Description |
|-------|------|-------------|
| `request_id` | `string` | Client-generated request ID |
| `status` | `string` |  |
| `error_code` | `string` | Error code when rejected |
| `error_message` | `string` | Error details when rejected |
| `timestamp` | `string` |  |

---

### `user/away`

Manage and receive updates for automatic away messages

**Subscribe (Server -> Client):** `AwayMessageUpdated`

| Field | Type | Description |
|-------|------|-------------|
| `user_id` | `string` | User ID whose away message was updated |
| `enabled` | `boolean` | Whether automatic away messages are enabled |
| `message` | `string` | Away message text |
| `updated_at` | `string` | Timestamp of the update |

**Publish (Client -> Server):** `SetAwayMessage`

| Field | Type | Description |
|-------|------|-------------|
| `enabled` | `boolean` | Enable or disable automatic away messages |
| `message` | `string` | Away message text |

---

### `chat/auto-reply`

Automatic away reply events generated by the system

**Subscribe (Server -> Client):** `AutoReplySent`

| Field | Type | Description |
|-------|------|-------------|
| `auto_reply_id` | `string` | Unique auto-reply ID |
| `conversation_id` | `string` | Conversation where the auto-reply was sent |
| `sender_id` | `string` | User who triggered the auto-reply by messaging |
| `away_user_id` | `string` | User whose away message was sent |
| `message` | `string` | Auto-reply content |
| `timestamp` | `string` |  |

---

### `chat/greetings`

Automatic greeting messages on first contact

**Subscribe (Server -> Client):** `GreetingMessageReceived`

| Field | Type | Description |
|-------|------|-------------|
| `greeting_id` | `string` | Unique greeting message ID |
| `conversation_id` | `string` | Conversation ID where the greeting is delivered |
| `sender_id` | `string` | System or bot sender ID |
| `content` | `string` | Greeting text content |
| `timestamp` | `string` | Time the greeting was sent |
| `first_contact` | `boolean` | Indicates this greeting is for first contact |

**Publish (Client -> Server):** `AcknowledgeGreetingReceived`

| Field | Type | Description |
|-------|------|-------------|
| `greeting_id` | `string` | Greeting message ID being acknowledged |
| `conversation_id` | `string` | Conversation ID |
| `timestamp` | `string` | Client receipt time |

---

### `business/stats`

Real-time business message statistics

**Subscribe (Server -> Client):** `BusinessStatsUpdated`

| Field | Type | Description |
|-------|------|-------------|
| `business_id` | `string` | Unique business ID |
| `window` | `string` | Aggregation window |
| `messages_total` | `integer` | Total number of messages in the window |
| `messages_inbound` | `integer` | Number of inbound messages |
| `messages_outbound` | `integer` | Number of outbound messages |
| `active_conversations` | `integer` | Active conversations in the window |
| `timestamp` | `string` | Time the statistics snapshot was generated |

**Publish (Client -> Server):** `RequestBusinessStats`

| Field | Type | Description |
|-------|------|-------------|
| `business_id` | `string` | Unique business ID |
| `window` | `string` | Aggregation window |

---

### `business/stats/ack`

Acknowledgments for statistics requests

**Subscribe (Server -> Client):** `BusinessStatsRequestAck`

| Field | Type | Description |
|-------|------|-------------|
| `request_id` | `string` | Client-generated request ID |
| `status` | `string` | Acknowledgment status |
| `reason` | `string` | Reason if rejected |
| `timestamp` | `string` |  |

**Publish (Client -> Server):** `BusinessStatsRequestWithId`

| Field | Type | Description |
|-------|------|-------------|
| `request_id` | `string` | Client-generated request ID |
| `business_id` | `string` | Unique business ID |
| `window` | `string` |  |

---

### `voice/transcription`

Real-time transcription lifecycle for voice messages

**Subscribe (Server -> Client):** `TranscriptionCompleted`

| Field | Type | Description |
|-------|------|-------------|
| `message_id` | `string` | Unique voice message ID |
| `transcript` | `string` | Full transcribed text |
| `language` | `string` | Detected language (BCP-47) |
| `confidence` | `number` | Overall confidence score (0-1) |
| `timestamp` | `string` |  |

**Publish (Client -> Server):** `StartTranscription`

| Field | Type | Description |
|-------|------|-------------|
| `message_id` | `string` | Unique voice message ID |
| `audio_url` | `string` | URL to the audio file |
| `language_hint` | `string` | Optional language hint (BCP-47) |

---

### `voice/transcription/status`

Status and progress updates for transcription jobs

**Subscribe (Server -> Client):** `TranscriptionProgress`

| Field | Type | Description |
|-------|------|-------------|
| `message_id` | `string` | Unique voice message ID |
| `status` | `string` | Current processing state |
| `progress` | `number` | Progress percentage (0-100) |
| `partial_transcript` | `string` | Optional partial transcript |
| `timestamp` | `string` |  |

**Publish (Client -> Server):** `AcknowledgeTranscription`

| Field | Type | Description |
|-------|------|-------------|
| `message_id` | `string` | Unique voice message ID |
| `received_at` | `string` |  |

---

### `voice/transcription/errors`

Failure notifications for transcription jobs

**Subscribe (Server -> Client):** `TranscriptionFailed`

| Field | Type | Description |
|-------|------|-------------|
| `message_id` | `string` | Unique voice message ID |
| `error_code` | `string` | Machine-readable error code |
| `error_message` | `string` | Human-readable error details |
| `timestamp` | `string` |  |

**Publish (Client -> Server):** `RetryTranscription`

| Field | Type | Description |
|-------|------|-------------|
| `message_id` | `string` | Unique voice message ID |
| `reason` | `string` | Optional reason for retry |

---

### `sync/changes`

Efficient delivery of incremental state changes

**Subscribe (Server -> Client):** `SyncChangesReceived`

| Field | Type | Description |
|-------|------|-------------|
| `sync_id` | `string` | Unique synchronization batch ID |
| `sequence` | `integer` | Monotonic sequence number for ordering |
| `changes` | `array` | List of change operations |
| `timestamp` | `string` | Server timestamp of the batch |

**Publish (Client -> Server):** `SyncAck`

| Field | Type | Description |
|-------|------|-------------|
| `sync_id` | `string` | Acknowledged synchronization batch ID |
| `sequence` | `integer` | Last processed sequence number |
| `received_at` | `string` | Client receipt timestamp |

---

### `sync/request`

Client-initiated sync requests for missing or initial data

**Subscribe (Server -> Client):** `SyncResponse`

| Field | Type | Description |
|-------|------|-------------|
| `request_id` | `string` | Correlation ID for the request |
| `from_sequence` | `integer` | Sequence number start of returned changes |
| `to_sequence` | `integer` | Sequence number end of returned changes |
| `changes` | `array` | Returned change operations |

**Publish (Client -> Server):** `SyncRequest`

| Field | Type | Description |
|-------|------|-------------|
| `request_id` | `string` | Client-generated request correlation ID |
| `since_sequence` | `integer` | Last known sequence number; omit for full sync |
| `full_sync` | `boolean` | Whether to request a full state sync |

---

### `ai/chat/{conversation_id}/messages`

Real-time AI assistant chat messages

**Subscribe (Server -> Client):** `AIChatMessageReceived`

| Field | Type | Description |
|-------|------|-------------|
| `message_id` | `string` | Unique message ID |
| `conversation_id` | `string` | Conversation ID |
| `sender` | `string` | Message sender type |
| `content` | `string` | Message content |
| `timestamp` | `string` |  |
| `status` | `string` | Streaming status |

**Publish (Client -> Server):** `SendAIChatMessage`

| Field | Type | Description |
|-------|------|-------------|
| `conversation_id` | `string` | Conversation ID |
| `message_id` | `string` | Client-generated message ID for idempotency |
| `content` | `string` | User message content |
| `timestamp` | `string` |  |

---

### `ai/chat/{conversation_id}/events`

Real-time AI assistant status and control events

**Subscribe (Server -> Client):** `AIChatEvent`

| Field | Type | Description |
|-------|------|-------------|
| `event_id` | `string` | Unique event ID |
| `conversation_id` | `string` | Conversation ID |
| `event_type` | `string` | Event type |
| `message_id` | `string` | Related message ID |
| `detail` | `string` | Optional details or error message |
| `timestamp` | `string` |  |

**Publish (Client -> Server):** `AcknowledgeMessage`

| Field | Type | Description |
|-------|------|-------------|
| `conversation_id` | `string` | Conversation ID |
| `message_id` | `string` | Message ID being acknowledged |
| `status` | `string` | Acknowledgment status |
| `timestamp` | `string` |  |

---

