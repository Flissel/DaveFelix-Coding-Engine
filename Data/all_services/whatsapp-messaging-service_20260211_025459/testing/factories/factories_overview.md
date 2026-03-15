# Test Data Factories

**Generated:** 2026-02-12T17:14:33.284286

**Language:** TypeScript (@faker-js/faker)

**Database:** postgresql

**Total Factories:** 48

## Factory Summary

| Entity | Table | Fields | Dependencies |
|--------|-------|--------|-------------|
| user | `user` | 6 | - |
| user_profile | `user_profile` | 10 | user |
| user_device | `user_device` | 7 | user |
| auth_credential | `auth_credential` | 7 | user |
| chat | `chat` | 6 | - |
| message | `message` | 13 | chat |
| message_media | `message_media` | 7 | message |
| message_reaction | `message_reaction` | 6 | message |
| group_chat | `group_chat` | 9 | - |
| group_member | `group_member` | 8 | user, group_chat |
| message_mention | `message_mention` | 7 | message, user |
| Community | `community` | 4 | - |
| Group | `group` | 5 | Community |
| Channel | `channel` | 6 | Group |
| Poll | `poll` | 6 | - |
| Call | `call` | 10 | - |
| contact | `contact` | 6 | - |
| call_log | `call_log` | 7 | contact |
| status_update | `status_update` | 7 | contact |
| status_reply | `status_reply` | 5 | status_update |
| media_item | `media_item` | 11 | contact, status_update |
| media_attachment | `media_attachment` | 9 | message |
| encryption_session | `encryption_session` | 7 | - |
| contact_block | `contact_block` | 5 | user |
| report | `report` | 8 | message, user |
| notification_setting | `notification_setting` | 10 | user |
| whatsapp_user | `whatsapp_user` | 6 | - |
| label | `label` | 6 | whatsapp_user |
| UserPrivacySetting | `user_privacy_setting` | 8 | User |
| UserAppearanceSetting | `user_appearance_setting` | 7 | User |
| UserUsageSetting | `user_usage_setting` | 7 | User |
| UserBackupSetting | `user_backup_setting` | 6 | User |
| backup | `backup` | 5 | chat |
| business_profile | `business_profile` | 5 | - |
| quick_reply | `quick_reply` | 6 | business_profile |
| auto_message | `auto_message` | 7 | business_profile |
| business | `business` | 5 | - |
| product | `product` | 8 | business |
| cart | `cart` | 7 | business |
| payment | `payment` | 8 | cart |
| business_statistic | `business_statistic` | 8 | business |
| integration_feature | `integration_feature` | 6 | - |
| performance_requirement | `performance_requirement` | 6 | - |
| ai_assistant | `ai_assistant` | 6 | - |
| smart_reply | `smart_reply` | 7 | ai_assistant |
| locale | `locale` | 7 | - |
| sticker_pack | `sticker_pack` | 7 | locale |
| sticker_suggestion | `sticker_suggestion` | 7 | sticker_pack, locale |

## Usage

```typescript
import { createUser, createBatch } from './factories';

// Create a single user
const user = createUser();

// Create with overrides
const admin = createUser({ email: 'admin@example.com' });

// Create batch
const users = createBatch(createUser, 10);
```

