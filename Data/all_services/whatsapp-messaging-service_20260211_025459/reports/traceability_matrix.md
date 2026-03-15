# Traceability Matrix

**Generated:** 2026-02-12T17:16:27.047984

## Summary

- Requirements: 126
- User Stories: 126
- Test Cases: 1094
- API Endpoints: 418
- Screens: 0
- Entities: 48

---

## Full Traceability

| Requirement | Type | Priority | User Stories | Test Cases | API Endpoints | Screens | Entities |
|-------------|------|----------|--------------|------------|---------------|---------|----------|
| WA-AUTH-001 | functional | must | US-001 | TC-001, TC-002, TC-003, TC-004, TC-005 (+7) | POST /api/v1/phone-registrations, POST /api/v1/phone-registrations/{registrationId}/verify, POST /api/v1/phone-registrations/{registrationId}/resend-otp | - | - |
| WA-AUTH-002 | functional | must | US-002 | TC-013, TC-014, TC-015, TC-016, TC-017 (+2) | POST /api/v1/users/{userId}/2fa, DELETE /api/v1/users/{userId}/2fa, POST /api/v1/auth/2fa/verify (+1) | - | user |
| WA-AUTH-003 | functional | should | US-003 | TC-020, TC-021, TC-022, TC-023, TC-024 (+2) | POST /api/v1/biometric/registration-options, POST /api/v1/biometric/credentials, GET /api/v1/biometric/credentials (+3) | - | - |
| WA-AUTH-004 | functional | must | US-004 | TC-027, TC-028, TC-029, TC-030, TC-031 (+7) | POST /api/v1/devices, GET /api/v1/devices, GET /api/v1/devices/{deviceId} (+3) | - | - |
| WA-AUTH-005 | functional | should | US-005 | TC-039, TC-040, TC-041, TC-042, TC-043 (+5) | POST /api/v1/auth/passkeys/registration/options, POST /api/v1/auth/passkeys/registration/verify, POST /api/v1/auth/passkeys/authentication/options (+3) | - | user |
| WA-PROF-001 | functional | must | US-006 | TC-048, TC-049, TC-050, TC-051, TC-052 (+6) | POST /api/v1/users/{userId}/profile-images, GET /api/v1/users/{userId}/profile-images/current, PUT /api/v1/users/{userId}/profile-images/current (+1) | - | user |
| WA-PROF-002 | functional | must | US-007 | TC-058, TC-059, TC-060, TC-061, TC-062 (+2) | GET /api/v1/users/{userId}/profile, PUT /api/v1/users/{userId}/profile/display-name | - | user |
| WA-PROF-003 | functional | must | US-008 | TC-064, TC-065, TC-066, TC-067, TC-068 (+5) | GET /api/v1/users/{userId}/profile/info-text, PUT /api/v1/users/{userId}/profile/info-text | - | user |
| WA-PROF-004 | functional | must | US-009 | TC-073, TC-074, TC-075, TC-076, TC-077 (+4) | GET /api/v1/users/{userId}/profile | - | user |
| WA-PROF-005 | functional | should | US-010 | TC-081, TC-082, TC-083, TC-084, TC-085 (+5) | POST /api/v1/users/{userId}/qr-codes, GET /api/v1/users/{userId}/qr-codes/{qrCodeId} | - | user |
| WA-MSG-001 | functional | must | US-011 | TC-090, TC-091, TC-092, TC-093, TC-094 (+4) | POST /api/v1/conversations/{conversationId}/messages | - | message |
| WA-MSG-002 | functional | must | US-012 | TC-098, TC-099, TC-100, TC-101, TC-102 (+4) | POST /api/v1/messages/voice | - | message |
| WA-MSG-003 | functional | must | US-013 | TC-106, TC-107, TC-108, TC-109, TC-110 (+4) | DELETE /api/v1/messages/{messageId} | - | message |
| WA-MSG-004 | functional | must | US-014 | TC-114, TC-115, TC-116, TC-117, TC-118 (+3) | PUT /api/v1/messages/{messageId} | - | message |
| WA-MSG-005 | functional | must | US-015 | TC-121, TC-122, TC-123, TC-124, TC-125 (+5) | POST /api/v1/messages/{messageId}/forward | - | message |
| WA-MSG-006 | functional | must | US-016 | TC-130, TC-131, TC-132, TC-133, TC-134 (+4) | POST /api/v1/messages | - | message |
| WA-MSG-007 | functional | must | US-017 | TC-138, TC-139, TC-140, TC-141, TC-142 (+6) | POST /api/v1/messages/{messageId}/reactions, GET /api/v1/messages/{messageId}/reactions, DELETE /api/v1/messages/{messageId}/reactions/{reactionId} | - | message |
| WA-MSG-008 | functional | must | US-018 | TC-148, TC-149, TC-150, TC-151, TC-152 (+6) | POST /api/v1/messages, PATCH /api/v1/messages/{messageId}/self-destruct, DELETE /api/v1/messages/{messageId} | - | message |
| WA-MSG-009 | functional | must | US-019 | TC-158, TC-159, TC-160, TC-161, TC-162 (+4) | POST /api/v1/media, POST /api/v1/messages, GET /api/v1/media/{mediaId}/view-once | - | message |
| WA-MSG-010 | functional | should | US-020 | TC-166, TC-167, TC-168, TC-169, TC-170 (+4) | PUT /api/v1/chats/{chatId}/lock, PUT /api/v1/chats/{chatId}/unlock | - | chat |
| WA-MSG-011 | functional | must | US-021 | TC-174, TC-175, TC-176, TC-177, TC-178 (+2) | POST /api/v1/broadcast-lists, GET /api/v1/broadcast-lists, GET /api/v1/broadcast-lists/{broadcastListId} (+3) | - | message |
| WA-MSG-012 | functional | must | US-022 | TC-181, TC-182, TC-183, TC-184, TC-185 (+7) | POST /api/v1/conversations/{conversationId}/messages, GET /api/v1/conversations/{conversationId}/messages | - | message |
| WA-MSG-013 | functional | must | US-023 | TC-193, TC-194, TC-195, TC-196, TC-197 (+2) | POST /api/v1/group-chats/{groupId}/messages | - | Group, chat, message |
| WA-MSG-014 | functional | must | US-024 | TC-200, TC-201, TC-202, TC-203, TC-204 (+3) | POST /api/v1/conversations/{conversationId}/messages/location | - | message |
| WA-MSG-015 | functional | must | US-025 | TC-208, TC-209, TC-210, TC-211, TC-212 (+5) | POST /api/v1/chats/{chatId}/messages | - | chat, message |
| WA-GRP-001 | functional | must | US-026 | TC-218, TC-219, TC-220, TC-221, TC-222 (+3) | POST /api/v1/groups | - | Group |
| WA-GRP-002 | functional | must | US-027 | TC-226, TC-227, TC-228, TC-229, TC-230 (+4) | POST /api/v1/groups, GET /api/v1/groups, GET /api/v1/groups/{groupId} (+8) | - | Group |
| WA-GRP-003 | functional | must | US-028 | TC-235, TC-236, TC-237, TC-238, TC-239 (+4) | GET /api/v1/groups/{groupId}/settings, PUT /api/v1/groups/{groupId}/settings | - | Group |
| WA-GRP-004 | functional | must | US-029 | TC-244, TC-245, TC-246, TC-247, TC-248 (+7) | POST /api/v1/groups/{groupId}/invite-links, GET /api/v1/invite-links/{inviteToken}, POST /api/v1/invite-links/{inviteToken}/accept (+1) | - | Group |
| WA-GRP-005 | functional | must | US-030 | TC-256, TC-257, TC-258, TC-259, TC-260 (+3) | DELETE /api/v1/groups/{groupId}/members/me | - | Group |
| WA-GRP-006 | functional | must | US-031 | TC-264, TC-265, TC-266, TC-267, TC-268 (+2) | POST /api/v1/communities, GET /api/v1/communities, GET /api/v1/communities/{communityId} (+5) | - | Community, Group |
| WA-GRP-007 | functional | should | US-032 | TC-271, TC-272, TC-273, TC-274, TC-275 (+4) | POST /api/v1/broadcast-channels, GET /api/v1/broadcast-channels, GET /api/v1/broadcast-channels/{channelId} (+7) | - | Channel, message |
| WA-GRP-008 | functional | should | US-033 | TC-280, TC-281, TC-282, TC-283, TC-284 (+4) | POST /api/v1/chats/{chatId}/polls, GET /api/v1/chats/{chatId}/polls, GET /api/v1/chats/{chatId}/polls/{pollId} (+2) | - | Poll, chat |
| WA-GRP-009 | functional | should | US-034 | TC-289, TC-290, TC-291, TC-292, TC-293 (+2) | POST /api/v1/groups/{groupId}/events, GET /api/v1/groups/{groupId}/events, GET /api/v1/groups/{groupId}/events/{eventId} (+3) | - | Group |
| WA-CALL-001 | functional | must | US-035 | TC-296, TC-297, TC-298, TC-299, TC-300 (+3) | POST /api/v1/calls, GET /api/v1/calls, GET /api/v1/calls/{callId} (+5) | - | Call, message |
| WA-CALL-002 | functional | must | US-036 | TC-304, TC-305, TC-306, TC-307, TC-308 (+3) | POST /api/v1/calls, GET /api/v1/calls, POST /api/v1/calls/{id}/join (+2) | - | Call |
| WA-CALL-003 | functional | must | US-037 | TC-312, TC-313, TC-314, TC-315, TC-316 (+5) | POST /api/v1/group-calls, GET /api/v1/group-calls/{callId}, POST /api/v1/group-calls/{callId}/participants (+4) | - | Call, Group |
| WA-CALL-004 | functional | should | US-038 | TC-322, TC-323, TC-324, TC-325, TC-326 (+3) | POST /api/v1/calls/{callId}/screen-shares, GET /api/v1/calls/{callId}/screen-shares, DELETE /api/v1/calls/{callId}/screen-shares/{screenShareId} | - | Call |
| WA-CALL-005 | functional | should | US-039 | TC-330, TC-331, TC-332, TC-333, TC-334 (+4) | POST /api/v1/call-links, GET /api/v1/call-links, GET /api/v1/call-links/{callLinkId} (+2) | - | Call |
| WA-CALL-006 | functional | must | US-040 | TC-339, TC-340, TC-341, TC-342, TC-343 (+2) | POST /api/v1/calls/{callId}/reject | - | Call |
| WA-CALL-007 | functional | must | US-041 | TC-346, TC-347, TC-348, TC-349, TC-350 (+4) | GET /api/v1/call-logs, GET /api/v1/call-logs/{callLogId}, POST /api/v1/call-logs (+1) | - | Call |
| WA-STS-001 | functional | must | US-042 | TC-355, TC-356, TC-357, TC-358, TC-359 (+1) | POST /api/v1/statuses | - | - |
| WA-STS-002 | functional | must | US-043 | TC-361, TC-362, TC-363, TC-364, TC-365 (+5) | GET /api/v1/contacts/{contactId}/status, GET /api/v1/contacts/statuses | - | contact |
| WA-STS-003 | functional | must | US-044 | TC-371, TC-372, TC-373, TC-374, TC-375 (+3) | POST /api/v1/statuses/{statusId}/replies, GET /api/v1/statuses/{statusId}/replies, DELETE /api/v1/statuses/{statusId}/replies/{replyId} | - | - |
| WA-STS-004 | functional | must | US-045 | TC-379, TC-380, TC-381, TC-382, TC-383 (+2) | GET /api/v1/users/{userId}/status-visibility-settings, PUT /api/v1/users/{userId}/status-visibility-settings | - | user |
| WA-STS-005 | functional | should | US-046 | TC-386, TC-387, TC-388, TC-389, TC-390 (+3) | POST /api/v1/status-mutes, GET /api/v1/status-mutes, DELETE /api/v1/status-mutes/{contactId} | - | contact |
| WA-MED-001 | functional | must | US-047 | TC-394, TC-395, TC-396, TC-397, TC-398 (+4) | POST /api/v1/media/images, POST /api/v1/conversations/{conversationId}/messages | - | message |
| WA-MED-002 | functional | must | US-048 | TC-403, TC-404, TC-405, TC-406, TC-407 (+3) | POST /api/v1/media/videos, POST /api/v1/messages | - | message |
| WA-MED-003 | functional | must | US-049 | TC-411, TC-412, TC-413, TC-414, TC-415 (+1) | POST /api/v1/messages/documents | - | message |
| WA-MED-004 | functional | must | US-050 | TC-417, TC-418, TC-419, TC-420, TC-421 (+4) | POST /api/v1/media-drafts, PUT /api/v1/media-drafts/{draftId}/edits, POST /api/v1/media-drafts/{draftId}/finalize | - | - |
| WA-MED-005 | functional | must | US-051 | TC-426, TC-427, TC-428, TC-429, TC-430 (+3) | GET /api/v1/sticker-packs, GET /api/v1/sticker-packs/{packId}/stickers, POST /api/v1/chats/{chatId}/messages | - | chat, message |
| WA-MED-006 | functional | must | US-052 | TC-434, TC-435, TC-436, TC-437, TC-438 (+2) | GET /api/v1/gifs/search, POST /api/v1/messages/gifs | - | message |
| WA-MED-007 | functional | must | US-053 | TC-441, TC-442, TC-443, TC-444, TC-445 (+4) | POST /api/v1/chats/{chatId}/media, POST /api/v1/chats/{chatId}/messages, GET /api/v1/chats/{chatId}/media/{mediaId} | - | chat, message |
| WA-MED-008 | functional | must | US-054 | TC-450, TC-451, TC-452, TC-453, TC-454 (+2) | POST /api/v1/audio-messages, GET /api/v1/audio-messages/{audioMessageId}/download | - | message |
| WA-MED-009 | functional | must | US-055 | TC-457, TC-458, TC-459, TC-460, TC-461 (+4) | GET /api/v1/media/library, POST /api/v1/media/uploads | - | - |
| WA-MED-010 | functional | should | US-056 | TC-466, TC-467, TC-468, TC-469, TC-470 (+3) | POST /api/v1/media/uploads, PUT /api/v1/media/uploads/{uploadId}/parts/{partNumber}, POST /api/v1/media/uploads/{uploadId}/complete (+2) | - | message |
| WA-SEC-001 | functional | must | US-057 | TC-474, TC-475, TC-476, TC-477, TC-478 (+5) | POST /api/v1/crypto/keys, GET /api/v1/crypto/prekeys/{recipientId}, POST /api/v1/messages (+2) | - | message |
| WA-SEC-002 | functional | must | US-058 | TC-484, TC-485, TC-486, TC-487, TC-488 (+4) | POST /api/v1/security-code-verifications, GET /api/v1/security-code-verifications/{verificationId}, POST /api/v1/security-code-verifications/{verificationId}/confirm (+1) | - | - |
| WA-SEC-003 | functional | must | US-059 | TC-493, TC-494, TC-495, TC-496, TC-497 (+3) | GET /api/v1/app-lock, PUT /api/v1/app-lock, POST /api/v1/app-lock/verify | - | - |
| WA-SEC-004 | functional | must | US-060 | TC-501, TC-502, TC-503, TC-504, TC-505 (+1) | POST /api/v1/users/{userId}/blocks, GET /api/v1/users/{userId}/blocks, DELETE /api/v1/users/{userId}/blocks/{contactId} | - | contact, user |
| WA-SEC-005 | functional | must | US-061 | TC-507, TC-508, TC-509, TC-510, TC-511 (+3) | POST /api/v1/reports | - | report |
| WA-SEC-006 | functional | must | US-062 | TC-515, TC-516, TC-517, TC-518, TC-519 (+2) | POST /api/v1/users/{userId}/pin, PUT /api/v1/users/{userId}/pin, DELETE /api/v1/users/{userId}/pin (+2) | - | user |
| WA-SEC-007 | functional | should | US-063 | TC-522, TC-523, TC-524, TC-525, TC-526 (+4) | POST /api/v1/spam-checks, GET /api/v1/spam-checks/{spamCheckId} | - | - |
| WA-SEC-008 | functional | should | US-064 | TC-531, TC-532, TC-533, TC-534, TC-535 (+5) | GET /api/v1/users/{userId}/call-privacy-settings, PUT /api/v1/users/{userId}/call-privacy-settings, POST /api/v1/call-sessions | - | Call, user |
| WA-NOT-001 | functional | must | US-065 | TC-541, TC-542, TC-543, TC-544, TC-545 (+2) | POST /api/v1/push-tokens, POST /api/v1/push-notifications, GET /api/v1/push-notifications (+1) | - | - |
| WA-NOT-002 | functional | must | US-066 | TC-548, TC-549, TC-550, TC-551, TC-552 (+4) | GET /api/v1/users/{userId}/notification-preferences, PUT /api/v1/users/{userId}/notification-preferences, POST /api/v1/notification-previews | - | user |
| WA-NOT-003 | functional | must | US-067 | TC-557, TC-558, TC-559, TC-560, TC-561 (+4) | POST /api/v1/messages/{messageId}/quick-replies | - | message |
| WA-NOT-004 | functional | must | US-068 | TC-566, TC-567, TC-568, TC-569, TC-570 (+3) | GET /api/v1/users/{userId}/do-not-disturb, PUT /api/v1/users/{userId}/do-not-disturb | - | user |
| WA-NOT-005 | functional | should | US-069 | TC-574, TC-575, TC-576, TC-577, TC-578 (+5) | GET /api/v1/notifications/reactions, PUT /api/v1/notifications/reactions/{notificationId}/read | - | - |
| WA-NOT-006 | functional | must | US-070 | TC-584, TC-585, TC-586, TC-587, TC-588 (+1) | GET /api/v1/users/{userId}/call-notification-settings, PUT /api/v1/users/{userId}/call-notification-settings | - | Call, user |
| WA-CON-001 | functional | must | US-071 | TC-590, TC-591, TC-592, TC-593, TC-594 (+2) | POST /api/v1/contacts/sync, GET /api/v1/contacts/sync/{syncId} | - | contact |
| WA-CON-002 | functional | must | US-072 | TC-597, TC-598, TC-599, TC-600, TC-601 (+5) | POST /api/v1/contacts, POST /api/v1/contacts/invitations, POST /api/v1/contacts/qr | - | contact |
| WA-CON-003 | functional | should | US-073 | TC-607, TC-608, TC-609, TC-610, TC-611 (+4) | GET /api/v1/users/{userId}/favorite-contacts, POST /api/v1/users/{userId}/favorite-contacts, DELETE /api/v1/users/{userId}/favorite-contacts/{contactId} | - | contact, user |
| WA-CON-004 | functional | should | US-074 | TC-616, TC-617, TC-618, TC-619, TC-620 (+4) | POST /api/v1/contact-labels, GET /api/v1/contact-labels, GET /api/v1/contact-labels/{labelId} (+6) | - | contact, label |
| WA-CON-005 | functional | must | US-075 | TC-625, TC-626, TC-627, TC-628, TC-629 (+5) | GET /api/v1/unknown-senders, GET /api/v1/unknown-senders/{senderId}, GET /api/v1/unknown-senders/{senderId}/messages (+1) | - | message |
| WA-SRC-001 | functional | must | US-076 | TC-635, TC-636, TC-637, TC-638, TC-639 (+5) | GET /api/v1/messages/search | - | message |
| WA-SRC-002 | functional | must | US-077 | TC-645, TC-646, TC-647, TC-648, TC-649 (+3) | GET /api/v1/media | - | - |
| WA-SRC-003 | functional | must | US-078 | TC-653, TC-654, TC-655, TC-656, TC-657 (+5) | GET /api/v1/search/chats, GET /api/v1/search/contacts | - | chat, contact |
| WA-SRC-004 | functional | should | US-079 | TC-663, TC-664, TC-665, TC-666, TC-667 (+3) | GET /api/v1/conversations/{conversationId}/messages | - | message |
| WA-SET-001 | functional | must | US-080 | TC-671, TC-672, TC-673, TC-674, TC-675 (+3) | GET /api/v1/users/{userId}/presence-visibility, PUT /api/v1/users/{userId}/presence-visibility, GET /api/v1/users/{userId}/presence-visibility/allowed-users (+1) | - | user |
| WA-SET-002 | functional | must | US-081 | TC-679, TC-680, TC-681, TC-682, TC-683 (+2) | GET /api/v1/users/{userId}/settings/read-receipts, PUT /api/v1/users/{userId}/settings/read-receipts | - | user |
| WA-SET-003 | functional | must | US-082 | TC-686, TC-687, TC-688, TC-689, TC-690 (+1) | GET /api/v1/users/{userId}/settings/profile-picture-visibility, PUT /api/v1/users/{userId}/settings/profile-picture-visibility | - | user |
| WA-SET-004 | functional | must | US-083 | TC-692, TC-693, TC-694, TC-695, TC-696 (+1) | GET /api/v1/users/{userId}/privacy/infoVisibility, PUT /api/v1/users/{userId}/privacy/infoVisibility | - | user |
| WA-SET-005 | functional | must | US-084 | TC-698, TC-699, TC-700, TC-701, TC-702 (+1) | GET /api/v1/groups/{groupId}/settings/invite-policy, PUT /api/v1/groups/{groupId}/settings/invite-policy | - | Group |
| WA-SET-006 | functional | must | US-085 | TC-704, TC-705, TC-706, TC-707, TC-708 (+7) | GET /api/v1/storage/usage, GET /api/v1/storage/items, DELETE /api/v1/storage/items/{id} (+1) | - | - |
| WA-SET-007 | functional | must | US-086 | TC-716, TC-717, TC-718, TC-719, TC-720 (+5) | GET /api/v1/data-usage/settings, PUT /api/v1/data-usage/settings, GET /api/v1/data-usage/summary | - | - |
| WA-SET-008 | functional | should | US-087 | TC-726, TC-727, TC-728, TC-729, TC-730 (+3) | GET /api/v1/chat-backgrounds, POST /api/v1/chat-backgrounds, GET /api/v1/users/me/chat-background (+2) | - | chat, user |
| WA-SET-009 | functional | must | US-088 | TC-734, TC-735, TC-736, TC-737, TC-738 (+2) | GET /api/v1/users/{id}/preferences/theme, PUT /api/v1/users/{id}/preferences/theme | - | user |
| WA-SET-010 | functional | must | US-089 | TC-741, TC-742, TC-743, TC-744, TC-745 (+2) | GET /api/v1/languages, GET /api/v1/users/me/language, PUT /api/v1/users/me/language | - | user |
| WA-BAK-001 | functional | must | US-090 | TC-748, TC-749, TC-750, TC-751, TC-752 (+3) | POST /api/v1/backups, GET /api/v1/backups, GET /api/v1/backups/{backupId} (+3) | - | backup |
| WA-BAK-002 | functional | must | US-091 | TC-756, TC-757, TC-758, TC-759, TC-760 (+4) | POST /api/v1/backups, GET /api/v1/backups, GET /api/v1/backups/{backupId} (+2) | - | backup |
| WA-BAK-003 | functional | must | US-092 | TC-765, TC-766, TC-767, TC-768, TC-769 (+3) | POST /api/v1/chats/{chatId}/exports, GET /api/v1/chats/{chatId}/exports/{exportId} | - | chat |
| WA-BAK-004 | functional | must | US-093 | TC-773, TC-774, TC-775, TC-776, TC-777 (+2) | POST /api/v1/chat-history-transfer-sessions, POST /api/v1/chat-history-transfer-sessions/{sessionId}/export, GET /api/v1/chat-history-transfer-sessions/{sessionId} (+2) | - | chat |
| WA-BAK-005 | functional | must | US-094 | TC-780, TC-781, TC-782, TC-783, TC-784 (+3) | POST /api/v1/chats/{chatId}/archive | - | chat |
| WA-BAK-006 | functional | must | US-095 | TC-788, TC-789, TC-790, TC-791, TC-792 (+2) | PUT /api/v1/chats/{chatId}/pin, DELETE /api/v1/chats/{chatId}/pin, GET /api/v1/chats/pinned | - | chat |
| WA-BUS-001 | functional | must | US-096 | TC-795, TC-796, TC-797, TC-798, TC-799 (+4) | POST /api/v1/business-profiles, GET /api/v1/business-profiles, GET /api/v1/business-profiles/{id} (+3) | - | business |
| WA-BUS-002 | functional | should | US-097 | TC-804, TC-805, TC-806, TC-807, TC-808 (+4) | POST /api/v1/businesses/{businessId}/verification-requests, GET /api/v1/businesses/{businessId}/verification-status, PUT /api/v1/verification-requests/{requestId} | - | business |
| WA-BUS-003 | functional | must | US-098 | TC-813, TC-814, TC-815, TC-816, TC-817 (+5) | POST /api/v1/businesses/{businessId}/quick-replies, GET /api/v1/businesses/{businessId}/quick-replies, GET /api/v1/businesses/{businessId}/quick-replies/{quickReplyId} (+2) | - | business |
| WA-BUS-004 | functional | must | US-099 | TC-823, TC-824, TC-825, TC-826, TC-827 (+4) | GET /api/v1/users/{userId}/away-message, PUT /api/v1/users/{userId}/away-message, DELETE /api/v1/users/{userId}/away-message | - | message, user |
| WA-BUS-005 | functional | must | US-100 | TC-832, TC-833, TC-834, TC-835, TC-836 (+5) | GET /api/v1/users/{userId}/greeting-settings, PUT /api/v1/users/{userId}/greeting-settings, POST /api/v1/conversations/{conversationId}/greeting-messages (+1) | - | message, user |
| WA-BUS-006 | functional | must | US-101 | TC-842, TC-843, TC-844, TC-845, TC-846 (+5) | POST /api/v1/businesses/{businessId}/products, GET /api/v1/businesses/{businessId}/products, GET /api/v1/businesses/{businessId}/products/{productId} (+4) | - | business, product |
| WA-BUS-007 | functional | should | US-102 | TC-852, TC-853, TC-854, TC-855, TC-856 (+4) | GET /api/v1/carts/{cartId}, GET /api/v1/carts/{cartId}/items, POST /api/v1/carts/{cartId}/items (+3) | - | cart |
| WA-BUS-008 | functional | could | US-103 | TC-861, TC-862, TC-863, TC-864, TC-865 (+2) | GET /api/v1/payments/markets, POST /api/v1/payments, GET /api/v1/payments/{paymentId} (+1) | - | payment |
| WA-BUS-009 | functional | must | US-104 | TC-868, TC-869, TC-870, TC-871, TC-872 (+3) | GET /api/v1/businesses/{businessId}/statistics/messages | - | business, message |
| WA-BUS-010 | functional | must | US-105 | TC-876, TC-877, TC-878, TC-879, TC-880 (+3) | GET /api/v1/health, POST /api/v1/integrations/apps, GET /api/v1/integrations/apps (+8) | - | message |
| WA-ACC-001 | functional | must | US-106 | TC-884, TC-885, TC-886, TC-887, TC-888 (+5) | GET /api/v1/users/{id}/accessibility-settings, PUT /api/v1/users/{id}/accessibility-settings | - | user |
| WA-ACC-002 | functional | must | US-107 | TC-894, TC-895, TC-896, TC-897, TC-898 (+5) | GET /api/v1/users/{userId}/preferences/typography, PUT /api/v1/users/{userId}/preferences/typography | - | user |
| WA-ACC-003 | functional | must | US-108 | TC-904, TC-905, TC-906, TC-907, TC-908 (+5) | GET /api/v1/users/{id}/accessibility-settings, PUT /api/v1/users/{id}/accessibility-settings, GET /api/v1/app/accessibility/contrast-requirements | - | user |
| WA-ACC-004 | functional | should | US-109 | TC-914, TC-915, TC-916, TC-917, TC-918 (+5) | POST /api/v1/voice-messages/{voiceMessageId}/transcriptions, GET /api/v1/transcriptions/{transcriptionId}, GET /api/v1/voice-messages/{voiceMessageId}/transcriptions | - | message |
| WA-PERF-001 | functional | must | US-110 | TC-924, TC-925, TC-926, TC-927, TC-928 (+5) | POST /api/v1/offline-queues, POST /api/v1/offline-queues/{queueId}/messages, GET /api/v1/offline-queues/{queueId}/messages (+2) | - | message |
| WA-PERF-002 | functional | must | US-111 | TC-934, TC-935, TC-936, TC-937, TC-938 (+3) | GET /api/v1/startup-resources | - | - |
| WA-PERF-003 | functional | must | US-112 | TC-942, TC-943, TC-944, TC-945, TC-946 (+7) | GET /api/v1/messages/sync, POST /api/v1/messages/sync/ack, GET /api/v1/conversations/sync | - | message |
| WA-PERF-004 | functional | must | US-113 | TC-954, TC-955, TC-956, TC-957, TC-958 (+3) | GET /api/v1/power-policy, GET /api/v1/users/{userId}/power-settings, PUT /api/v1/users/{userId}/power-settings (+1) | - | user |
| WA-PERF-005 | functional | must | US-114 | TC-962, TC-963, TC-964, TC-965, TC-966 (+4) | GET /api/v1/storage/usage, POST /api/v1/storage/cleanup, PUT /api/v1/storage/retention-policy | - | - |
| WA-INT-001 | functional | must | US-115 | TC-971, TC-972, TC-973, TC-974, TC-975 (+2) | POST /api/v1/share-extensions, POST /api/v1/share-extensions/{shareId}/attachments, POST /api/v1/share-extensions/{shareId}/dispatch (+1) | - | - |
| WA-INT-002 | functional | should | US-116 | TC-978, TC-979, TC-980, TC-981, TC-982 (+4) | GET /api/v1/voiceAssistants, GET /api/v1/voiceAssistantLinks, POST /api/v1/voiceAssistantLinks (+3) | - | - |
| WA-INT-003 | functional | should | US-117 | TC-987, TC-988, TC-989, TC-990, TC-991 (+4) | GET /api/v1/widgets, POST /api/v1/widgets, GET /api/v1/widgets/{widgetId} (+2) | - | - |
| WA-INT-004 | functional | should | US-118 | TC-996, TC-997, TC-998, TC-999, TC-1000 (+5) | POST /api/v1/watch-devices, GET /api/v1/watch-devices, POST /api/v1/watch-devices/{id}/pair (+3) | - | - |
| WA-INT-005 | functional | must | US-119 | TC-1006, TC-1007, TC-1008, TC-1009, TC-1010 (+7) | GET /api/v1/desktop-apps, GET /api/v1/desktop-apps/{releaseId}, POST /api/v1/desktop-apps/check-update | - | - |
| WA-INT-006 | functional | must | US-120 | TC-1018, TC-1019, TC-1020, TC-1021, TC-1022 (+4) | GET /api/v1/web/clients/config, POST /api/v1/web/sessions, POST /api/v1/web/sessions/{sessionId}/websocket-tokens (+3) | - | - |
| WA-AI-001 | functional | should | US-121 | TC-1027, TC-1028, TC-1029, TC-1030, TC-1031 (+5) | POST /api/v1/ai-chats, POST /api/v1/ai-chats/{chatId}/messages, GET /api/v1/ai-chats/{chatId}/messages (+1) | - | chat, message |
| WA-AI-002 | functional | could | US-122 | TC-1037, TC-1038, TC-1039, TC-1040, TC-1041 (+3) | POST /api/v1/conversations/{conversationId}/smart-replies | - | - |
| WA-AI-003 | functional | could | US-123 | TC-1045, TC-1046, TC-1047, TC-1048, TC-1049 (+4) | POST /api/v1/sticker-suggestions | - | - |
| WA-LOC-001 | functional | must | US-124 | TC-1054, TC-1055, TC-1056, TC-1057, TC-1058 (+3) | GET /api/v1/users/{id}/preferences/localization, PUT /api/v1/users/{id}/preferences/localization, GET /api/v1/locales | - | locale, user |
| WA-LOC-002 | functional | must | US-125 | TC-1062, TC-1063, TC-1064, TC-1065, TC-1066 (+5) | GET /api/v1/regional-formats, GET /api/v1/users/{userId}/regional-formats, PUT /api/v1/users/{userId}/regional-formats | - | user |
| WA-LOC-003 | functional | could | US-126 | TC-1072, TC-1073, TC-1074, TC-1075, TC-1076 (+2) | GET /api/v1/sticker-packs, GET /api/v1/sticker-packs/{stickerPackId} | - | - |

---

## Coverage Statistics

- Requirements with User Stories: 126/126 (100.0%)
- User Stories with Test Cases: 126/126 (100.0%)
- Functional Requirements with API Endpoints: 126/126 (100.0%)

### Orphan Analysis

All functional requirements are covered by user stories. [PASS]

All user stories are covered by test cases. [PASS]

---

*Traceability matrix generated by AI-Scientist Requirements Engineering System*
