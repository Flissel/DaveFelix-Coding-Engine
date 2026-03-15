# Data Dictionary: whatsapp-messaging-service

**Generated:** 2026-02-12T17:14:32.656612

## Summary

- Entities: 48
- Relationships: 48
- Glossary Terms: 43

---

## Entities

### Call

An encrypted voice or video call, optionally group-based

*Source Requirements:* WA-CALL-001, WA-CALL-002, WA-CALL-003, WA-CALL-004, WA-CALL-005, WA-CALL-006

| Attribute | Type | MaxLen | Required | FK Target | Indexed | Enum Values | Description |
|-----------|------|--------|----------|-----------|---------|-------------|-------------|
| call_id | uuid | 36 | Yes | - | Yes | - | Unique identifier for the call |
| call_type | enum | 20 | Yes | - | Yes | voice, video | Type of call |
| is_group_call | boolean | 5 | Yes | - | Yes | - | Indicates if the call involves multiple participants |
| is_encrypted | boolean | 5 | Yes | - | Yes | - | Indicates the call is end-to-end encrypted |
| screen_share_enabled | boolean | 5 | No | - | - | - | Indicates whether screen sharing is enabled for the call |
| scheduled_at | datetime | 30 | No | - | Yes | - | Scheduled start time for planned calls |
| call_link_url | string | 255 | No | - | Yes | - | Shareable link URL for a planned call |
| quick_reject_message | string | 255 | No | - | - | - | Optional quick reply message when rejecting a call |
| created_at | datetime | 30 | Yes | - | - | - | Timestamp when the call was created |
| updated_at | datetime | 30 | Yes | - | - | - | Timestamp when the call was last updated |

### Channel

A one-way broadcast channel within a group

*Source Requirements:* WA-GRP-007

| Attribute | Type | MaxLen | Required | FK Target | Indexed | Enum Values | Description |
|-----------|------|--------|----------|-----------|---------|-------------|-------------|
| channel_id | uuid | 36 | Yes | - | Yes | - | Unique identifier for the channel |
| group_id | uuid | 36 | Yes | Group.group_id | Yes | - | Reference to the group hosting the channel |
| name | string | 50 | Yes | - | Yes | - | Display name of the channel |
| is_one_way_broadcast | boolean | 5 | Yes | - | - | - | Indicates the channel supports one-way broadcast |
| created_at | datetime | 30 | Yes | - | - | - | Timestamp when the channel was created |
| updated_at | datetime | 30 | Yes | - | - | - | Timestamp when the channel was last updated |

### Community

A community that aggregates multiple groups

*Source Requirements:* WA-GRP-006

| Attribute | Type | MaxLen | Required | FK Target | Indexed | Enum Values | Description |
|-----------|------|--------|----------|-----------|---------|-------------|-------------|
| community_id | uuid | 36 | Yes | - | Yes | - | Unique identifier for the community |
| name | string | 50 | Yes | - | Yes | - | Display name of the community |
| created_at | datetime | 30 | Yes | - | - | - | Timestamp when the community was created |
| updated_at | datetime | 30 | Yes | - | - | - | Timestamp when the community was last updated |

### Group

A chat group that can belong to a community

*Source Requirements:* WA-GRP-006, WA-GRP-009

| Attribute | Type | MaxLen | Required | FK Target | Indexed | Enum Values | Description |
|-----------|------|--------|----------|-----------|---------|-------------|-------------|
| group_id | uuid | 36 | Yes | - | Yes | - | Unique identifier for the group |
| community_id | uuid | 36 | No | Community.community_id | Yes | - | Reference to the parent community |
| name | string | 50 | Yes | - | Yes | - | Display name of the group |
| created_at | datetime | 30 | Yes | - | - | - | Timestamp when the group was created |
| updated_at | datetime | 30 | Yes | - | - | - | Timestamp when the group was last updated |

### Poll

A poll created in a group or individual chat

*Source Requirements:* WA-GRP-008

| Attribute | Type | MaxLen | Required | FK Target | Indexed | Enum Values | Description |
|-----------|------|--------|----------|-----------|---------|-------------|-------------|
| poll_id | uuid | 36 | Yes | - | Yes | - | Unique identifier for the poll |
| chat_context_type | enum | 20 | Yes | - | Yes | group, individual | Type of chat where the poll is posted |
| chat_context_id | uuid | 36 | Yes | - | Yes | - | Identifier of the group or individual chat |
| question_text | text | 2000 | Yes | - | - | - | Question text shown to participants |
| created_at | datetime | 30 | Yes | - | - | - | Timestamp when the poll was created |
| updated_at | datetime | 30 | Yes | - | - | - | Timestamp when the poll was last updated |

### UserAppearanceSetting

User interface and localization preferences

*Source Requirements:* WA-SET-008, WA-SET-009, WA-SET-010

| Attribute | Type | MaxLen | Required | FK Target | Indexed | Enum Values | Description |
|-----------|------|--------|----------|-----------|---------|-------------|-------------|
| appearance_setting_id | uuid | - | Yes | - | Yes | - | Unique identifier for the appearance setting record |
| user_id | uuid | - | Yes | User.user_id | Yes | - | User to whom these appearance settings apply |
| chat_background | string | 255 | No | - | - | - | Selected chat background identifier or URI |
| dark_mode_enabled | boolean | - | Yes | - | - | - | Whether dark mode is enabled |
| language_code | string | 10 | Yes | - | Yes | - | Preferred language code for the user |
| created_at | datetime | - | Yes | - | - | - | Timestamp when the appearance setting record was created |
| updated_at | datetime | - | Yes | - | - | - | Timestamp when the appearance setting record was last updated |

### UserBackupSetting

Cloud backup configuration for user chats

*Source Requirements:* WA-BAK-001

| Attribute | Type | MaxLen | Required | FK Target | Indexed | Enum Values | Description |
|-----------|------|--------|----------|-----------|---------|-------------|-------------|
| backup_setting_id | uuid | - | Yes | - | Yes | - | Unique identifier for the backup setting record |
| user_id | uuid | - | Yes | User.user_id | Yes | - | User to whom the backup settings apply |
| cloud_backup_enabled | boolean | - | Yes | - | - | - | Whether cloud backup is enabled for chats |
| last_backup_at | datetime | - | No | - | Yes | - | Timestamp of the most recent successful backup |
| created_at | datetime | - | Yes | - | - | - | Timestamp when the backup setting record was created |
| updated_at | datetime | - | Yes | - | - | - | Timestamp when the backup setting record was last updated |

### UserPrivacySetting

Configurable privacy and visibility settings per user

*Source Requirements:* WA-SET-002, WA-SET-003, WA-SET-004, WA-SET-005

| Attribute | Type | MaxLen | Required | FK Target | Indexed | Enum Values | Description |
|-----------|------|--------|----------|-----------|---------|-------------|-------------|
| privacy_setting_id | uuid | - | Yes | - | Yes | - | Unique identifier for the privacy setting record |
| user_id | uuid | - | Yes | User.user_id | Yes | - | User to whom these privacy settings apply |
| read_receipt_enabled | boolean | - | Yes | - | - | - | Whether read receipts are enabled |
| profile_photo_visibility | enum | - | Yes | - | Yes | everyone, contacts, nobody | Who can see the user's profile photo |
| status_text_visibility | enum | - | Yes | - | Yes | everyone, contacts, nobody | Who can see the user's info/status text |
| group_invite_permission | enum | - | Yes | - | Yes | everyone, contacts, nobody | Who can add the user to groups |
| created_at | datetime | - | Yes | - | - | - | Timestamp when the privacy setting record was created |
| updated_at | datetime | - | Yes | - | - | - | Timestamp when the privacy setting record was last updated |

### UserUsageSetting

Storage and data usage configuration and overview per user

*Source Requirements:* WA-SET-006, WA-SET-007

| Attribute | Type | MaxLen | Required | FK Target | Indexed | Enum Values | Description |
|-----------|------|--------|----------|-----------|---------|-------------|-------------|
| usage_setting_id | uuid | - | Yes | - | Yes | - | Unique identifier for the usage setting record |
| user_id | uuid | - | Yes | User.user_id | Yes | - | User to whom these usage settings apply |
| storage_used_mb | decimal | - | Yes | - | - | - | Total storage used by the user in megabytes |
| storage_limit_mb | decimal | - | No | - | - | - | Configured storage limit in megabytes |
| data_usage_control_enabled | boolean | - | Yes | - | - | - | Whether data usage controls are enabled |
| created_at | datetime | - | Yes | - | - | - | Timestamp when the usage setting record was created |
| updated_at | datetime | - | Yes | - | - | - | Timestamp when the usage setting record was last updated |

### ai_assistant

Configuration for AI assistant integration in messaging

*Source Requirements:* WA-AI-001

| Attribute | Type | MaxLen | Required | FK Target | Indexed | Enum Values | Description |
|-----------|------|--------|----------|-----------|---------|-------------|-------------|
| ai_assistant_id | uuid | 36 | Yes | - | Yes | - | Unique identifier for the AI assistant integration |
| name | string | 100 | Yes | - | Yes | - | Display name of the AI assistant |
| provider | string | 100 | Yes | - | - | - | Provider or vendor of the AI assistant |
| is_enabled | boolean | 5 | Yes | - | Yes | - | Indicates whether the AI assistant integration is enabled |
| created_at | datetime | 30 | Yes | - | - | - | Timestamp when the record was created |
| updated_at | datetime | 30 | Yes | - | - | - | Timestamp when the record was last updated |

### auth_credential

Authentication methods configured for a user

*Source Requirements:* WA-AUTH-002, WA-AUTH-003, WA-AUTH-005

| Attribute | Type | MaxLen | Required | FK Target | Indexed | Enum Values | Description |
|-----------|------|--------|----------|-----------|---------|-------------|-------------|
| credential_id | uuid | 36 | Yes | - | Yes | - | Unique identifier for the authentication credential |
| user_id | uuid | 36 | Yes | user.user_id | Yes | - | Reference to the owning user |
| credential_type | enum | - | Yes | - | Yes | pin_2fa, biometric, passkey | Type of authentication credential |
| credential_data | text | 2000 | No | - | - | - | Stored credential data such as PIN hash or passkey public key |
| is_enabled | boolean | - | Yes | - | Yes | - | Indicates whether the credential is enabled |
| created_at | datetime | - | Yes | - | - | - | Timestamp when the credential was created |
| updated_at | datetime | - | Yes | - | - | - | Timestamp when the credential was last updated |

### auto_message

Automated business message such as away or greeting

*Source Requirements:* WA-BUS-004, WA-BUS-005

| Attribute | Type | MaxLen | Required | FK Target | Indexed | Enum Values | Description |
|-----------|------|--------|----------|-----------|---------|-------------|-------------|
| auto_message_id | uuid | - | Yes | - | Yes | - | Unique identifier for the automated message |
| business_profile_id | uuid | - | Yes | business_profile.business_profile_id | Yes | - | Identifier of the owning business profile |
| message_type | enum | - | Yes | - | Yes | away, greeting | Type of automated message |
| message_text | text | 2000 | Yes | - | - | - | Content of the automated message |
| is_active | boolean | - | Yes | - | Yes | - | Indicates whether the automated message is active |
| created_at | datetime | - | Yes | - | - | - | Timestamp when the automated message was created |
| updated_at | datetime | - | Yes | - | - | - | Timestamp when the automated message was last updated |

### backup

Encrypted backup of chat data

*Source Requirements:* WA-BAK-002

| Attribute | Type | MaxLen | Required | FK Target | Indexed | Enum Values | Description |
|-----------|------|--------|----------|-----------|---------|-------------|-------------|
| backup_id | uuid | - | Yes | - | Yes | - | Unique identifier for the backup |
| chat_id | uuid | - | Yes | chat.chat_id | Yes | - | Identifier of the chat being backed up |
| is_end_to_end_encrypted | boolean | - | Yes | - | Yes | - | Indicates whether the backup is end-to-end encrypted |
| created_at | datetime | - | Yes | - | - | - | Timestamp when the backup was created |
| updated_at | datetime | - | Yes | - | - | - | Timestamp when the backup was last updated |

### business

Business account using messaging features

*Source Requirements:* WA-BUS-006, WA-BUS-010

| Attribute | Type | MaxLen | Required | FK Target | Indexed | Enum Values | Description |
|-----------|------|--------|----------|-----------|---------|-------------|-------------|
| business_id | uuid | 36 | Yes | - | Yes | - | Unique identifier for the business |
| business_name | string | 100 | Yes | - | Yes | - | Display name of the business |
| api_access_enabled | boolean | 1 | Yes | - | - | - | Indicates if business API access is enabled |
| created_at | datetime | - | Yes | - | - | - | Timestamp when the business was created |
| updated_at | datetime | - | Yes | - | - | - | Timestamp when the business was last updated |

### business_profile

Enhanced profile for a business account

*Source Requirements:* WA-BUS-001, WA-BUS-002

| Attribute | Type | MaxLen | Required | FK Target | Indexed | Enum Values | Description |
|-----------|------|--------|----------|-----------|---------|-------------|-------------|
| business_profile_id | uuid | - | Yes | - | Yes | - | Unique identifier for the business profile |
| display_name | string | 255 | Yes | - | Yes | - | Public display name of the business |
| verification_status | enum | - | Yes | - | Yes | unverified, pending, verified | Verification status of the business |
| created_at | datetime | - | Yes | - | - | - | Timestamp when the business profile was created |
| updated_at | datetime | - | Yes | - | - | - | Timestamp when the business profile was last updated |

### business_statistic

Aggregated messaging statistics for a business

*Source Requirements:* WA-BUS-009

| Attribute | Type | MaxLen | Required | FK Target | Indexed | Enum Values | Description |
|-----------|------|--------|----------|-----------|---------|-------------|-------------|
| stat_id | uuid | 36 | Yes | - | Yes | - | Unique identifier for the statistic record |
| business_id | uuid | 36 | Yes | business.business_id | Yes | - | Identifier of the related business |
| period_start | date | - | Yes | - | Yes | - | Start date of the statistics period |
| period_end | date | - | Yes | - | Yes | - | End date of the statistics period |
| messages_sent_count | integer | - | Yes | - | - | - | Number of messages sent in the period |
| messages_received_count | integer | - | Yes | - | - | - | Number of messages received in the period |
| created_at | datetime | - | Yes | - | - | - | Timestamp when the statistic record was created |
| updated_at | datetime | - | Yes | - | - | - | Timestamp when the statistic record was last updated |

### call_log

A record in the call history

*Source Requirements:* WA-CALL-007

| Attribute | Type | MaxLen | Required | FK Target | Indexed | Enum Values | Description |
|-----------|------|--------|----------|-----------|---------|-------------|-------------|
| call_log_id | uuid | 36 | Yes | - | Yes | - | Unique identifier for the call log entry |
| contact_id | uuid | 36 | Yes | contact.contact_id | Yes | - | Reference to the contact involved in the call |
| started_at | datetime | 30 | Yes | - | Yes | - | Timestamp when the call started |
| ended_at | datetime | 30 | No | - | - | - | Timestamp when the call ended |
| duration_seconds | integer | 10 | No | - | - | - | Duration of the call in seconds |
| created_at | datetime | 30 | Yes | - | - | - | Timestamp when the call log entry was created |
| updated_at | datetime | 30 | Yes | - | - | - | Timestamp when the call log entry was last updated |

### cart

Shopping cart for a business order

*Source Requirements:* WA-BUS-007

| Attribute | Type | MaxLen | Required | FK Target | Indexed | Enum Values | Description |
|-----------|------|--------|----------|-----------|---------|-------------|-------------|
| cart_id | uuid | 36 | Yes | - | Yes | - | Unique identifier for the cart |
| business_id | uuid | 36 | Yes | business.business_id | Yes | - | Identifier of the owning business |
| status | enum | - | Yes | - | Yes | open, ordered, abandoned | Lifecycle status of the cart |
| total_amount | decimal | - | Yes | - | - | - | Total monetary amount of the cart |
| currency_code | string | 3 | Yes | - | Yes | - | ISO currency code for cart totals |
| created_at | datetime | - | Yes | - | - | - | Timestamp when the cart was created |
| updated_at | datetime | - | Yes | - | - | - | Timestamp when the cart was last updated |

### chat

Conversation container for messages

*Source Requirements:* WA-MSG-010

| Attribute | Type | MaxLen | Required | FK Target | Indexed | Enum Values | Description |
|-----------|------|--------|----------|-----------|---------|-------------|-------------|
| chat_id | uuid | 36 | Yes | - | Yes | - | Unique identifier for the chat |
| chat_name | string | 100 | No | - | Yes | - | Display name of the chat |
| is_locked | boolean | 5 | Yes | - | Yes | - | Indicates whether the chat is locked with additional authentication |
| lock_method | enum | 50 | No | - | - | pin, biometric, password, none | Authentication method required to unlock the chat |
| created_at | datetime | 30 | Yes | - | - | - | Timestamp when the chat was created |
| updated_at | datetime | 30 | Yes | - | - | - | Timestamp when the chat was last updated |

### contact

A communication contact whose status and calls are tracked

*Source Requirements:* WA-STS-002, WA-STS-005, WA-CALL-007

| Attribute | Type | MaxLen | Required | FK Target | Indexed | Enum Values | Description |
|-----------|------|--------|----------|-----------|---------|-------------|-------------|
| contact_id | uuid | 36 | Yes | - | Yes | - | Unique identifier for the contact |
| display_name | string | 100 | Yes | - | Yes | - | Human-readable name of the contact |
| phone_number | string | 30 | Yes | - | Yes | - | Contact phone number for identification and lookup |
| status_muted | boolean | 5 | Yes | - | Yes | - | Indicates whether the contact's status updates are muted |
| created_at | datetime | 30 | Yes | - | - | - | Timestamp when the contact was created |
| updated_at | datetime | 30 | Yes | - | - | - | Timestamp when the contact was last updated |

### contact_block

Represents a block relationship between users

*Source Requirements:* WA-SEC-004

| Attribute | Type | MaxLen | Required | FK Target | Indexed | Enum Values | Description |
|-----------|------|--------|----------|-----------|---------|-------------|-------------|
| block_id | uuid | - | Yes | - | Yes | - | Unique identifier for the block record |
| blocker_user_id | uuid | - | Yes | user.user_id | Yes | - | User who initiated the block |
| blocked_user_id | uuid | - | Yes | user.user_id | Yes | - | User who is blocked |
| created_at | datetime | - | Yes | - | - | - | Timestamp when the block was created |
| updated_at | datetime | - | Yes | - | - | - | Timestamp when the block was last updated |

### encryption_session

End-to-end encryption context for a chat

*Source Requirements:* WA-SEC-001, WA-SEC-002

| Attribute | Type | MaxLen | Required | FK Target | Indexed | Enum Values | Description |
|-----------|------|--------|----------|-----------|---------|-------------|-------------|
| encryption_session_id | uuid | - | Yes | - | Yes | - | Unique identifier for the encryption session |
| chat_id | uuid | - | Yes | - | Yes | - | Chat to which the encryption session applies |
| security_code | string | 64 | Yes | - | - | - | Verification code used for manual encryption verification |
| verification_status | enum | - | Yes | - | Yes | unverified, verified | Manual verification status of the encryption |
| verified_at | datetime | - | No | - | - | - | Timestamp when encryption was verified |
| created_at | datetime | - | Yes | - | - | - | Timestamp when the encryption session was created |
| updated_at | datetime | - | Yes | - | - | - | Timestamp when the encryption session was last updated |

### group_chat

Group chat container with settings and invite link

*Source Requirements:* WA-GRP-001, WA-GRP-003, WA-GRP-004

| Attribute | Type | MaxLen | Required | FK Target | Indexed | Enum Values | Description |
|-----------|------|--------|----------|-----------|---------|-------------|-------------|
| group_chat_id | uuid | 36 | Yes | - | Yes | - | Unique identifier for the group chat |
| group_name | string | 100 | Yes | - | Yes | - | Name of the group chat |
| group_description | text | 2000 | No | - | - | - | Description of the group chat |
| invite_link_url | string | 255 | No | - | Yes | - | URL used to invite users to the group |
| invite_link_enabled | boolean | - | Yes | - | - | - | Indicates if invite link is active |
| setting_admin_only_posting | boolean | - | Yes | - | - | - | Restricts posting to admins only |
| setting_allow_member_invite | boolean | - | Yes | - | - | - | Allows members to invite others |
| created_at | datetime | - | Yes | - | - | - | Timestamp when the group chat was created |
| updated_at | datetime | - | Yes | - | - | - | Timestamp when the group chat was last updated |

### group_member

Membership of a user in a group chat with roles and leave behavior

*Source Requirements:* WA-GRP-001, WA-GRP-002, WA-GRP-005

| Attribute | Type | MaxLen | Required | FK Target | Indexed | Enum Values | Description |
|-----------|------|--------|----------|-----------|---------|-------------|-------------|
| group_member_id | uuid | 36 | Yes | - | Yes | - | Unique identifier for the group membership |
| group_chat_id | uuid | 36 | Yes | group_chat.group_chat_id | Yes | - | Identifier of the related group chat |
| user_id | uuid | 36 | Yes | user.user_id | Yes | - | Identifier of the member user |
| role | enum | - | Yes | - | Yes | admin, member | Role of the member in the group |
| left_silently | boolean | - | Yes | - | - | - | Indicates if the user left without notification |
| left_at | datetime | - | No | - | - | - | Timestamp when the user left the group |
| created_at | datetime | - | Yes | - | - | - | Timestamp when the membership was created |
| updated_at | datetime | - | Yes | - | - | - | Timestamp when the membership was last updated |

### integration_feature

Integration capability provided by the messaging system

*Source Requirements:* WA-INT-001, WA-INT-002, WA-INT-003, WA-INT-004, WA-INT-005, WA-INT-006

| Attribute | Type | MaxLen | Required | FK Target | Indexed | Enum Values | Description |
|-----------|------|--------|----------|-----------|---------|-------------|-------------|
| integration_feature_id | uuid | 36 | Yes | - | Yes | - | Unique identifier for the integration feature |
| feature_type | enum | 50 | Yes | - | Yes | share_extension, voice_assistant, widget, watch_app, desktop_app, web_version | Type of integration capability |
| requirement_level | enum | 10 | Yes | - | Yes | must, should | Requirement strength for the feature |
| description | text | 2000 | No | - | - | - | Narrative description of the integration feature |
| created_at | datetime | 30 | Yes | - | - | - | Timestamp when the record was created |
| updated_at | datetime | 30 | Yes | - | - | - | Timestamp when the record was last updated |

### label

Business label/tag applied to contacts

*Source Requirements:* WA-CON-004

| Attribute | Type | MaxLen | Required | FK Target | Indexed | Enum Values | Description |
|-----------|------|--------|----------|-----------|---------|-------------|-------------|
| label_id | uuid | 36 | Yes | - | Yes | - | Unique identifier for the label |
| owner_user_id | uuid | 36 | Yes | whatsapp_user.user_id | Yes | - | WhatsApp user who owns the label |
| label_name | string | 50 | Yes | - | Yes | - | Name of the label |
| color | string | 20 | No | - | - | - | Display color for the label |
| created_at | datetime | 30 | Yes | - | - | - | Timestamp when the label record was created |
| updated_at | datetime | 30 | Yes | - | - | - | Timestamp when the label record was last updated |

### locale

Localization settings for language direction and regional formats

*Source Requirements:* WA-LOC-001, WA-LOC-002

| Attribute | Type | MaxLen | Required | FK Target | Indexed | Enum Values | Description |
|-----------|------|--------|----------|-----------|---------|-------------|-------------|
| locale_id | uuid | 36 | Yes | - | Yes | - | Unique identifier for the locale |
| locale_code | string | 10 | Yes | - | Yes | - | Locale code such as en-US or ar-SA |
| rtl_supported | boolean | 5 | Yes | - | Yes | - | Indicates whether right-to-left layout is supported |
| regional_date_format | string | 50 | Yes | - | - | - | Preferred regional date format pattern |
| regional_number_format | string | 50 | Yes | - | - | - | Preferred regional number format pattern |
| created_at | datetime | 30 | Yes | - | - | - | Timestamp when the record was created |
| updated_at | datetime | 30 | Yes | - | - | - | Timestamp when the record was last updated |

### media_attachment

Media attached to a message, including stickers, GIFs, and audio

*Source Requirements:* WA-MED-005, WA-MED-006, WA-MED-007, WA-MED-008, WA-MED-009, WA-MED-010

| Attribute | Type | MaxLen | Required | FK Target | Indexed | Enum Values | Description |
|-----------|------|--------|----------|-----------|---------|-------------|-------------|
| attachment_id | uuid | - | Yes | - | Yes | - | Unique identifier for the media attachment |
| message_id | uuid | - | Yes | message.message_id | Yes | - | Message to which this media is attached |
| media_type | enum | - | Yes | - | Yes | sticker, gif, audio, image, video | Type of media content |
| file_url | string | 2048 | Yes | - | - | - | Location of the media file |
| source_library | enum | - | Yes | - | Yes | camera, gallery, external | Source used to obtain the media |
| is_hd | boolean | - | Yes | - | Yes | - | Indicates whether the media was sent in HD quality |
| duration_seconds | integer | - | No | - | - | - | Length of audio or video media in seconds |
| created_at | datetime | - | Yes | - | - | - | Timestamp when the attachment was created |
| updated_at | datetime | - | Yes | - | - | - | Timestamp when the attachment was last updated |

### media_item

A media item sent by a contact, optionally attached to a status update

*Source Requirements:* WA-MED-001, WA-MED-002, WA-MED-003, WA-MED-004

| Attribute | Type | MaxLen | Required | FK Target | Indexed | Enum Values | Description |
|-----------|------|--------|----------|-----------|---------|-------------|-------------|
| media_item_id | uuid | 36 | Yes | - | Yes | - | Unique identifier for the media item |
| sender_contact_id | uuid | 36 | Yes | contact.contact_id | Yes | - | Reference to the contact who sent the media |
| status_update_id | uuid | 36 | No | status_update.status_update_id | Yes | - | Reference to the status update the media is attached to, if any |
| media_type | enum | 20 | Yes | - | Yes | image, video, document | Type of media being sent |
| file_name | string | 255 | Yes | - | - | - | Original file name of the media item |
| file_url | string | 2000 | Yes | - | - | - | Storage location of the media file |
| size_bytes | integer | 10 | Yes | - | - | - | Size of the media file in bytes |
| edited_flag | boolean | 5 | Yes | - | Yes | - | Indicates whether basic editing was applied before sending |
| edit_notes | text | 2000 | No | - | - | - | Notes describing the edits applied to the media |
| created_at | datetime | 30 | Yes | - | - | - | Timestamp when the media item was created |
| updated_at | datetime | 30 | Yes | - | - | - | Timestamp when the media item was last updated |

### message

Message sent within a chat

*Source Requirements:* WA-MSG-001, WA-MSG-002, WA-MSG-003, WA-MSG-004, WA-MSG-005, WA-MSG-006, WA-MSG-008

| Attribute | Type | MaxLen | Required | FK Target | Indexed | Enum Values | Description |
|-----------|------|--------|----------|-----------|---------|-------------|-------------|
| message_id | uuid | 36 | Yes | - | Yes | - | Unique identifier for the message |
| chat_id | uuid | 36 | Yes | chat.chat_id | Yes | - | Identifier of the chat where the message is posted |
| sender_user_id | string | 64 | Yes | - | Yes | - | Identifier of the user who sent the message |
| message_type | enum | 20 | Yes | - | Yes | text, voice, media | Type of message content |
| content_text | text | 2000 | No | - | - | - | Text body of the message when applicable |
| parent_message_id | uuid | 36 | No | message.message_id | Yes | - | Referenced message for replies, quotes, or forwards |
| is_forwarded | boolean | 5 | Yes | - | Yes | - | Indicates whether the message is a forwarded message |
| is_deleted | boolean | 5 | Yes | - | Yes | - | Indicates whether the message is deleted |
| is_edited | boolean | 5 | Yes | - | Yes | - | Indicates whether the message has been edited |
| edited_at | datetime | 30 | No | - | - | - | Timestamp when the message was last edited |
| expires_at | datetime | 30 | No | - | Yes | - | Timestamp when the message should self-delete |
| created_at | datetime | 30 | Yes | - | - | - | Timestamp when the message was created |
| updated_at | datetime | 30 | Yes | - | - | - | Timestamp when the message was last updated |

### message_media

Media attachments associated with a message

*Source Requirements:* WA-MSG-002, WA-MSG-009

| Attribute | Type | MaxLen | Required | FK Target | Indexed | Enum Values | Description |
|-----------|------|--------|----------|-----------|---------|-------------|-------------|
| media_id | uuid | 36 | Yes | - | Yes | - | Unique identifier for the media item |
| message_id | uuid | 36 | Yes | message.message_id | Yes | - | Identifier of the message the media belongs to |
| media_type | enum | 20 | Yes | - | Yes | voice, image, video, file | Type of the media content |
| media_url | string | 255 | Yes | - | - | - | Location of the stored media file |
| is_view_once | boolean | 5 | Yes | - | Yes | - | Indicates whether the media can be viewed only once |
| created_at | datetime | 30 | Yes | - | - | - | Timestamp when the media item was created |
| updated_at | datetime | 30 | Yes | - | - | - | Timestamp when the media item was last updated |

### message_mention

Mention of a user within a group chat message

*Source Requirements:* WA-MSG-013

| Attribute | Type | MaxLen | Required | FK Target | Indexed | Enum Values | Description |
|-----------|------|--------|----------|-----------|---------|-------------|-------------|
| mention_id | uuid | 36 | Yes | - | Yes | - | Unique identifier for the mention |
| message_id | uuid | 36 | Yes | message.message_id | Yes | - | Identifier of the message containing the mention |
| mentioned_user_id | uuid | 36 | Yes | user.user_id | Yes | - | Identifier of the mentioned user |
| position_start | integer | - | Yes | - | - | - | Start position of the mention in the message text |
| position_end | integer | - | Yes | - | - | - | End position of the mention in the message text |
| created_at | datetime | - | Yes | - | - | - | Timestamp when the mention was created |
| updated_at | datetime | - | Yes | - | - | - | Timestamp when the mention was last updated |

### message_reaction

Emoji reaction applied to a message

*Source Requirements:* WA-MSG-007

| Attribute | Type | MaxLen | Required | FK Target | Indexed | Enum Values | Description |
|-----------|------|--------|----------|-----------|---------|-------------|-------------|
| reaction_id | uuid | 36 | Yes | - | Yes | - | Unique identifier for the reaction |
| message_id | uuid | 36 | Yes | message.message_id | Yes | - | Identifier of the reacted message |
| reacting_user_id | string | 64 | Yes | - | Yes | - | Identifier of the user who reacted |
| emoji | string | 10 | Yes | - | - | - | Emoji used as the reaction |
| created_at | datetime | 30 | Yes | - | - | - | Timestamp when the reaction was created |
| updated_at | datetime | 30 | Yes | - | - | - | Timestamp when the reaction was last updated |

### notification_setting

Per-user configuration for notifications

*Source Requirements:* WA-NOT-001, WA-NOT-002, WA-NOT-003, WA-NOT-004, WA-NOT-005, WA-NOT-006

| Attribute | Type | MaxLen | Required | FK Target | Indexed | Enum Values | Description |
|-----------|------|--------|----------|-----------|---------|-------------|-------------|
| notification_setting_id | uuid | 36 | Yes | - | Yes | - | Unique identifier for the notification settings record |
| user_id | uuid | 36 | Yes | user.user_id | Yes | - | User who owns these notification settings |
| push_enabled | boolean | 5 | Yes | - | Yes | - | Indicates whether push notifications are enabled |
| preview_enabled | boolean | 5 | Yes | - | - | - | Indicates whether notification previews are shown |
| quick_reply_enabled | boolean | 5 | Yes | - | - | - | Indicates whether quick replies from notifications are allowed |
| do_not_disturb_enabled | boolean | 5 | Yes | - | Yes | - | Indicates whether do-not-disturb mode is enabled |
| reaction_notifications_enabled | boolean | 5 | Yes | - | - | - | Indicates whether reactions to own messages trigger notifications |
| call_notification_mode | enum | 20 | Yes | - | Yes | all, missed_only, none | Mode for call notifications |
| created_at | datetime | 30 | Yes | - | Yes | - | Timestamp when the settings were created |
| updated_at | datetime | 30 | Yes | - | - | - | Timestamp when the settings were last updated |

### payment

In-app payment transaction for a cart

*Source Requirements:* WA-BUS-008

| Attribute | Type | MaxLen | Required | FK Target | Indexed | Enum Values | Description |
|-----------|------|--------|----------|-----------|---------|-------------|-------------|
| payment_id | uuid | 36 | Yes | - | Yes | - | Unique identifier for the payment |
| cart_id | uuid | 36 | Yes | cart.cart_id | Yes | - | Identifier of the related cart |
| payment_status | enum | - | Yes | - | Yes | pending, completed, failed, refunded | Current status of the payment |
| amount | decimal | - | Yes | - | - | - | Payment amount |
| currency_code | string | 3 | Yes | - | Yes | - | ISO currency code for the payment |
| market_code | string | 5 | No | - | Yes | - | Market where the payment feature is offered |
| created_at | datetime | - | Yes | - | - | - | Timestamp when the payment was created |
| updated_at | datetime | - | Yes | - | - | - | Timestamp when the payment was last updated |

### performance_requirement

Performance expectation for the messaging system

*Source Requirements:* WA-PERF-002, WA-PERF-003, WA-PERF-004, WA-PERF-005

| Attribute | Type | MaxLen | Required | FK Target | Indexed | Enum Values | Description |
|-----------|------|--------|----------|-----------|---------|-------------|-------------|
| performance_requirement_id | uuid | 36 | Yes | - | Yes | - | Unique identifier for the performance requirement |
| metric_type | enum | 50 | Yes | - | Yes | app_start_speed, sync_efficiency, battery_efficiency, storage_efficiency | Type of performance metric |
| requirement_level | enum | 10 | Yes | - | Yes | must | Requirement strength for the performance metric |
| description | text | 2000 | No | - | - | - | Narrative description of the performance requirement |
| created_at | datetime | 30 | Yes | - | - | - | Timestamp when the record was created |
| updated_at | datetime | 30 | Yes | - | - | - | Timestamp when the record was last updated |

### product

Catalog product offered by a business

*Source Requirements:* WA-BUS-006

| Attribute | Type | MaxLen | Required | FK Target | Indexed | Enum Values | Description |
|-----------|------|--------|----------|-----------|---------|-------------|-------------|
| product_id | uuid | 36 | Yes | - | Yes | - | Unique identifier for the product |
| business_id | uuid | 36 | Yes | business.business_id | Yes | - | Identifier of the owning business |
| product_name | string | 120 | Yes | - | Yes | - | Name of the product |
| description | text | 2000 | No | - | - | - | Detailed product description |
| price_amount | decimal | - | Yes | - | - | - | Unit price of the product |
| currency_code | string | 3 | Yes | - | Yes | - | ISO currency code for pricing |
| created_at | datetime | - | Yes | - | - | - | Timestamp when the product was created |
| updated_at | datetime | - | Yes | - | - | - | Timestamp when the product was last updated |

### quick_reply

Predefined response template for business messaging

*Source Requirements:* WA-BUS-003

| Attribute | Type | MaxLen | Required | FK Target | Indexed | Enum Values | Description |
|-----------|------|--------|----------|-----------|---------|-------------|-------------|
| quick_reply_id | uuid | - | Yes | - | Yes | - | Unique identifier for the quick reply |
| business_profile_id | uuid | - | Yes | business_profile.business_profile_id | Yes | - | Identifier of the owning business profile |
| shortcut | string | 50 | Yes | - | Yes | - | Short trigger text for the quick reply |
| message_text | text | 2000 | Yes | - | - | - | Content of the quick reply message |
| created_at | datetime | - | Yes | - | - | - | Timestamp when the quick reply was created |
| updated_at | datetime | - | Yes | - | - | - | Timestamp when the quick reply was last updated |

### report

Report of a message or contact for review

*Source Requirements:* WA-SEC-005

| Attribute | Type | MaxLen | Required | FK Target | Indexed | Enum Values | Description |
|-----------|------|--------|----------|-----------|---------|-------------|-------------|
| report_id | uuid | 36 | Yes | - | Yes | - | Unique identifier for the report |
| reporter_user_id | uuid | 36 | Yes | user.user_id | Yes | - | User who created the report |
| target_message_id | uuid | 36 | No | message.message_id | Yes | - | Reported message identifier, if applicable |
| target_user_id | uuid | 36 | No | user.user_id | Yes | - | Reported user identifier, if applicable |
| reason | text | 2000 | No | - | - | - | Explanation provided for the report |
| status | enum | 20 | Yes | - | Yes | open, reviewed, resolved, rejected | Current processing status of the report |
| created_at | datetime | 30 | Yes | - | Yes | - | Timestamp when the report was created |
| updated_at | datetime | 30 | Yes | - | - | - | Timestamp when the report was last updated |

### smart_reply

Intelligent reply suggestions generated for messaging

*Source Requirements:* WA-AI-002, WA-AI-001

| Attribute | Type | MaxLen | Required | FK Target | Indexed | Enum Values | Description |
|-----------|------|--------|----------|-----------|---------|-------------|-------------|
| smart_reply_id | uuid | 36 | Yes | - | Yes | - | Unique identifier for the smart reply |
| ai_assistant_id | uuid | 36 | Yes | ai_assistant.ai_assistant_id | Yes | - | Reference to the AI assistant generating the reply |
| language_code | string | 10 | Yes | - | Yes | - | Language code for the reply suggestion |
| reply_text | text | 2000 | Yes | - | - | - | Suggested reply text content |
| context_key | string | 255 | No | - | Yes | - | Context key used to derive the suggestion |
| created_at | datetime | 30 | Yes | - | - | - | Timestamp when the record was created |
| updated_at | datetime | 30 | Yes | - | - | - | Timestamp when the record was last updated |

### status_reply

A reply made to a status update

*Source Requirements:* WA-STS-003

| Attribute | Type | MaxLen | Required | FK Target | Indexed | Enum Values | Description |
|-----------|------|--------|----------|-----------|---------|-------------|-------------|
| status_reply_id | uuid | 36 | Yes | - | Yes | - | Unique identifier for the status reply |
| status_update_id | uuid | 36 | Yes | status_update.status_update_id | Yes | - | Reference to the status update being replied to |
| reply_text | text | 2000 | Yes | - | - | - | Text content of the reply |
| created_at | datetime | 30 | Yes | - | - | - | Timestamp when the status reply was created |
| updated_at | datetime | 30 | Yes | - | - | - | Timestamp when the status reply was last updated |

### status_update

A 24-hour status update created by a contact

*Source Requirements:* WA-STS-001, WA-STS-002, WA-STS-004

| Attribute | Type | MaxLen | Required | FK Target | Indexed | Enum Values | Description |
|-----------|------|--------|----------|-----------|---------|-------------|-------------|
| status_update_id | uuid | 36 | Yes | - | Yes | - | Unique identifier for the status update |
| contact_id | uuid | 36 | Yes | contact.contact_id | Yes | - | Reference to the contact who created the status update |
| content_text | text | 2000 | No | - | - | - | Text content of the status update |
| expires_at | datetime | 30 | Yes | - | Yes | - | Timestamp when the status update expires after 24 hours |
| visibility | enum | 20 | Yes | - | Yes | public, contacts_only, custom | Visibility setting for the status update |
| created_at | datetime | 30 | Yes | - | - | - | Timestamp when the status update was created |
| updated_at | datetime | 30 | Yes | - | - | - | Timestamp when the status update was last updated |

### sticker_pack

Collection of stickers, possibly tailored to a region

*Source Requirements:* WA-LOC-003

| Attribute | Type | MaxLen | Required | FK Target | Indexed | Enum Values | Description |
|-----------|------|--------|----------|-----------|---------|-------------|-------------|
| sticker_pack_id | uuid | 36 | Yes | - | Yes | - | Unique identifier for the sticker pack |
| locale_id | uuid | 36 | No | locale.locale_id | Yes | - | Reference to the locale for regional sticker packs |
| name | string | 100 | Yes | - | Yes | - | Name of the sticker pack |
| description | text | 2000 | No | - | - | - | Description of the sticker pack contents |
| is_active | boolean | 5 | Yes | - | Yes | - | Indicates whether the sticker pack is active |
| created_at | datetime | 30 | Yes | - | - | - | Timestamp when the record was created |
| updated_at | datetime | 30 | Yes | - | - | - | Timestamp when the record was last updated |

### sticker_suggestion

Context-based sticker suggestions for messaging

*Source Requirements:* WA-AI-003, WA-LOC-003

| Attribute | Type | MaxLen | Required | FK Target | Indexed | Enum Values | Description |
|-----------|------|--------|----------|-----------|---------|-------------|-------------|
| sticker_suggestion_id | uuid | 36 | Yes | - | Yes | - | Unique identifier for the sticker suggestion |
| sticker_pack_id | uuid | 36 | Yes | sticker_pack.sticker_pack_id | Yes | - | Reference to the sticker pack providing the suggestion |
| locale_id | uuid | 36 | No | locale.locale_id | Yes | - | Reference to the locale for regional context |
| context_keyword | string | 255 | Yes | - | Yes | - | Keyword or phrase extracted from conversation context |
| confidence_score | decimal | 10 | No | - | Yes | - | Confidence score for the suggestion relevance |
| created_at | datetime | 30 | Yes | - | - | - | Timestamp when the record was created |
| updated_at | datetime | 30 | Yes | - | - | - | Timestamp when the record was last updated |

### user

Registered messaging user with phone-based identity

*Source Requirements:* WA-AUTH-001

| Attribute | Type | MaxLen | Required | FK Target | Indexed | Enum Values | Description |
|-----------|------|--------|----------|-----------|---------|-------------|-------------|
| user_id | uuid | 36 | Yes | - | Yes | - | Unique identifier for the user |
| phone_number | string | 20 | Yes | - | Yes | - | User phone number used for registration and login |
| phone_verified_at | datetime | - | No | - | - | - | Timestamp when the phone number was verified |
| status | enum | - | Yes | - | Yes | active, disabled, pending_verification | Lifecycle status of the user account |
| created_at | datetime | - | Yes | - | - | - | Timestamp when the user was created |
| updated_at | datetime | - | Yes | - | - | - | Timestamp when the user was last updated |

### user_device

Device registered for multi-device usage

*Source Requirements:* WA-AUTH-004

| Attribute | Type | MaxLen | Required | FK Target | Indexed | Enum Values | Description |
|-----------|------|--------|----------|-----------|---------|-------------|-------------|
| device_id | uuid | 36 | Yes | - | Yes | - | Unique identifier for the device |
| user_id | uuid | 36 | Yes | user.user_id | Yes | - | Reference to the owning user |
| device_name | string | 100 | No | - | - | - | Human-readable name of the device |
| device_platform | enum | - | Yes | - | Yes | ios, android, web, desktop, other | Platform of the device |
| last_active_at | datetime | - | No | - | - | - | Timestamp of last device activity |
| created_at | datetime | - | Yes | - | - | - | Timestamp when the device was registered |
| updated_at | datetime | - | Yes | - | - | - | Timestamp when the device was last updated |

### user_profile

User profile data visible to others

*Source Requirements:* WA-PROF-001, WA-PROF-002, WA-PROF-003, WA-PROF-004, WA-PROF-005

| Attribute | Type | MaxLen | Required | FK Target | Indexed | Enum Values | Description |
|-----------|------|--------|----------|-----------|---------|-------------|-------------|
| profile_id | uuid | 36 | Yes | - | Yes | - | Unique identifier for the user profile |
| user_id | uuid | 36 | Yes | user.user_id | Yes | - | Reference to the owning user |
| display_name | string | 50 | Yes | - | Yes | - | Configurable display name |
| status_text | string | 200 | No | - | - | - | Short info/status text shown in profile |
| profile_image_url | string | 255 | No | - | - | - | URL to the uploaded profile image |
| show_phone_number | boolean | - | Yes | - | - | - | Indicates whether the phone number is shown in profile |
| qr_code_value | string | 255 | No | - | Yes | - | Encoded QR code value for easy adding |
| qr_code_generated_at | datetime | - | No | - | - | - | Timestamp when the QR code was generated |
| created_at | datetime | - | Yes | - | - | - | Timestamp when the profile was created |
| updated_at | datetime | - | Yes | - | - | - | Timestamp when the profile was last updated |

### whatsapp_user

Registered WhatsApp user profile

*Source Requirements:* WA-CON-001, WA-SET-001

| Attribute | Type | MaxLen | Required | FK Target | Indexed | Enum Values | Description |
|-----------|------|--------|----------|-----------|---------|-------------|-------------|
| user_id | uuid | 36 | Yes | - | Yes | - | Unique identifier for the WhatsApp user |
| phone_number | string | 20 | Yes | - | Yes | - | User phone number in international format |
| display_name | string | 50 | Yes | - | - | - | User-visible name shown in chats |
| online_status_visibility | enum | 20 | Yes | - | Yes | public, contacts_only, nobody | Visibility setting for last seen/online status |
| created_at | datetime | 30 | Yes | - | - | - | Timestamp when the user record was created |
| updated_at | datetime | 30 | Yes | - | - | - | Timestamp when the user record was last updated |

---

## Relationships

| Relationship | Source | Target | Cardinality | Description |
|--------------|--------|--------|-------------|-------------|
| has_profile | user | user_profile | 1:1 |  |
| has_devices | user | user_device | 1:N |  |
| has_credentials | user | auth_credential | 1:N |  |
| has_messages | chat | message | 1:N |  |
| references_message | message | message | 1:N |  |
| has_media | message | message_media | 1:N |  |
| has_reactions | message | message_reaction | 1:N |  |
| sends | user | message | 1:N |  |
| contains | group_chat | message | 1:N |  |
| has_members | group_chat | group_member | 1:N |  |
| member_of | user | group_member | 1:N |  |
| has_mentions | message | message_mention | 1:N |  |
| is_mentioned_in | user | message_mention | 1:N |  |
| has_groups | Community | Group | 1:N |  |
| has_channels | Group | Channel | 1:N |  |
| has_call_history | contact | call_log | 1:N |  |
| creates_status | contact | status_update | 1:N |  |
| has_replies | status_update | status_reply | 1:N |  |
| sends_media | contact | media_item | 1:N |  |
| includes_media | status_update | media_item | 1:N |  |
| has | message | media_attachment | 1:N |  |
| secures | encryption_session | message | 1:N |  |
| blocks | user | contact_block | 1:N |  |
| creates | user | report | 1:N |  |
| is_reported_in | message | report | 1:N |  |
| has | user | notification_setting | 1:1 |  |
| initiates | user | call | 1:N |  |
| owns_contacts | whatsapp_user | contact | 1:N |  |
| matches_user | contact | whatsapp_user | N:1 |  |
| owns_labels | whatsapp_user | label | 1:N |  |
| contact_labels | contact | label | N:M |  |
| sends_messages | contact | message | 1:N |  |
| has_privacy_settings | User | UserPrivacySetting | 1:1 |  |
| has_appearance_settings | User | UserAppearanceSetting | 1:1 |  |
| has_usage_settings | User | UserUsageSetting | 1:1 |  |
| has_backup_settings | User | UserBackupSetting | 1:1 |  |
| has_backups | chat | backup | 1:N |  |
| has_quick_replies | business_profile | quick_reply | 1:N |  |
| has_auto_messages | business_profile | auto_message | 1:N |  |
| offers | business | product | 1:N |  |
| creates | business | cart | 1:N |  |
| contains | cart | product | N:M |  |
| has | cart | payment | 1:N |  |
| reports | business | business_statistic | 1:N |  |
| generates | ai_assistant | smart_reply | 1:N |  |
| localizes | locale | sticker_pack | 1:N |  |
| provides | sticker_pack | sticker_suggestion | 1:N |  |
| contextualizes | locale | sticker_suggestion | 1:N |  |

---

## Glossary

### 2FA

Two-factor authentication using an additional verification method such as a PIN

### App lock

Authentication gate required to open the messaging app

### Auto message

Automatically sent business message, such as away or greeting

### Broadcast

A message sent to multiple recipients in a single action

### Call link

Shareable URL to join a scheduled call

### Cloud-Backup

Backup of chat data to a cloud storage provider

### Community

Container that organizes multiple groups under a shared umbrella

### Contact block

Restriction that prevents a user from contacting another user

### End-to-end encrypted backup

Backup data encrypted such that only the endpoints can decrypt it

### End-to-end encryption

Encryption where only communicating users can read messages

### GIF

Short looping animation file format used as media

### Group chat

A conversation space with multiple users and configurable settings

### Info/Status-Text-Sichtbarkeit

Visibility control for a user's status or info text

### Lesebestaetigung

Read receipt indicating a message has been read

### Mention

A reference to a user in a message using @ syntax

### One-way broadcast channel

Channel where only designated senders can post messages

### Passkey

Passwordless authentication using public-key credentials

### Profilbild-Sichtbarkeit

Visibility control for a user's profile photo

### QR code profile

Encoded value that can be scanned to quickly add a user

### Quick reply

Predefined response template used by businesses to answer faster

### RTL

Right-to-left script direction used by languages such as Arabic and Hebrew

### Smart Reply

AI-generated response suggestion presented to a user

### Sticker

Static or animated graphical element sent in chat

### Sticker Pack

A set of stickers grouped for thematic or regional use

### business_statistiken

Aggregated message metrics for a business

### call_history

A log of calls made or received by a contact

### disappearing_message

Message that self-deletes after a defined expiration time

### do_not_disturb

Mode that suppresses notifications

### integration_feature

A system capability that integrates messaging with platform services or form factors.

### ip_masking

Concealment of IP addresses during calls

### label

A business tag used to categorize contacts

### media_item

A file such as an image, video, or document sent in messaging

### online_status_visibility

Setting that controls who can see last seen/online status

### performance_requirement

A non-functional expectation defining efficiency or speed characteristics.

### produktkatalog

Business-managed list of products offered in messaging

### push_notification

Device-delivered notification for new events

### spam_detection

Automated classification of messages as spam or not spam

### status_update

A temporary 24-hour update published by a contact

### two_step_verification

Optional PIN-based additional security step during access

### unknown_sender

A sender not present in the user's contact list

### view_once

Media that can be viewed a single time before becoming inaccessible

### warenkorb

Temporary collection of products selected for ordering

### whatsapp_pay

In-app payment capability for selected markets

