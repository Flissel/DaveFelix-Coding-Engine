-- Seed data for development database (postgresql)
-- Generated: 2026-02-12T17:14:33.283286
-- Insert 3 sample rows per entity

-- user
INSERT INTO user (user_id, phone_number, phone_verified_at, status, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000001', 'sample_phone_number_1', '2026-01-01 12:00:00+00', 'value_1', '2026-01-01 12:00:00+00', '2026-01-01 12:00:00+00');
INSERT INTO user (user_id, phone_number, phone_verified_at, status, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000002', 'sample_phone_number_2', '2026-01-02 12:00:00+00', 'value_2', '2026-01-02 12:00:00+00', '2026-01-02 12:00:00+00');
INSERT INTO user (user_id, phone_number, phone_verified_at, status, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000003', 'sample_phone_number_3', '2026-01-03 12:00:00+00', 'value_3', '2026-01-03 12:00:00+00', '2026-01-03 12:00:00+00');

-- user_profile
INSERT INTO user_profile (profile_id, display_name, status_text, profile_image_url, show_phone_number, qr_code_value, qr_code_generated_at, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000001', 'sample_display_name_1', 'sample_status_text_1', 'sample_profile_image_url_1', FALSE, 'sample_qr_code_value_1', '2026-01-01 12:00:00+00', '2026-01-01 12:00:00+00', '2026-01-01 12:00:00+00');
INSERT INTO user_profile (profile_id, display_name, status_text, profile_image_url, show_phone_number, qr_code_value, qr_code_generated_at, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000002', 'sample_display_name_2', 'sample_status_text_2', 'sample_profile_image_url_2', TRUE, 'sample_qr_code_value_2', '2026-01-02 12:00:00+00', '2026-01-02 12:00:00+00', '2026-01-02 12:00:00+00');
INSERT INTO user_profile (profile_id, display_name, status_text, profile_image_url, show_phone_number, qr_code_value, qr_code_generated_at, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000003', 'sample_display_name_3', 'sample_status_text_3', 'sample_profile_image_url_3', FALSE, 'sample_qr_code_value_3', '2026-01-03 12:00:00+00', '2026-01-03 12:00:00+00', '2026-01-03 12:00:00+00');

-- user_device
INSERT INTO user_device (device_id, device_name, device_platform, last_active_at, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000001', 'sample_device_name_1', 'value_1', '2026-01-01 12:00:00+00', '2026-01-01 12:00:00+00', '2026-01-01 12:00:00+00');
INSERT INTO user_device (device_id, device_name, device_platform, last_active_at, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000002', 'sample_device_name_2', 'value_2', '2026-01-02 12:00:00+00', '2026-01-02 12:00:00+00', '2026-01-02 12:00:00+00');
INSERT INTO user_device (device_id, device_name, device_platform, last_active_at, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000003', 'sample_device_name_3', 'value_3', '2026-01-03 12:00:00+00', '2026-01-03 12:00:00+00', '2026-01-03 12:00:00+00');

-- auth_credential
INSERT INTO auth_credential (credential_id, credential_type, credential_data, is_enabled, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000001', 'value_1', 'sample_credential_data_1', FALSE, '2026-01-01 12:00:00+00', '2026-01-01 12:00:00+00');
INSERT INTO auth_credential (credential_id, credential_type, credential_data, is_enabled, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000002', 'value_2', 'sample_credential_data_2', TRUE, '2026-01-02 12:00:00+00', '2026-01-02 12:00:00+00');
INSERT INTO auth_credential (credential_id, credential_type, credential_data, is_enabled, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000003', 'value_3', 'sample_credential_data_3', FALSE, '2026-01-03 12:00:00+00', '2026-01-03 12:00:00+00');

-- chat
INSERT INTO chat (chat_id, chat_name, is_locked, lock_method, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000001', 'sample_chat_name_1', FALSE, 'value_1', '2026-01-01 12:00:00+00', '2026-01-01 12:00:00+00');
INSERT INTO chat (chat_id, chat_name, is_locked, lock_method, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000002', 'sample_chat_name_2', TRUE, 'value_2', '2026-01-02 12:00:00+00', '2026-01-02 12:00:00+00');
INSERT INTO chat (chat_id, chat_name, is_locked, lock_method, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000003', 'sample_chat_name_3', FALSE, 'value_3', '2026-01-03 12:00:00+00', '2026-01-03 12:00:00+00');

-- message
INSERT INTO message (message_id, sender_user_id, message_type, content_text, is_forwarded, is_deleted, is_edited, edited_at, expires_at, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000001', 'sample_sender_user_id_1', 'value_1', 'sample_content_text_1', FALSE, FALSE, FALSE, '2026-01-01 12:00:00+00', '2026-01-01 12:00:00+00', '2026-01-01 12:00:00+00', '2026-01-01 12:00:00+00');
INSERT INTO message (message_id, sender_user_id, message_type, content_text, is_forwarded, is_deleted, is_edited, edited_at, expires_at, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000002', 'sample_sender_user_id_2', 'value_2', 'sample_content_text_2', TRUE, TRUE, TRUE, '2026-01-02 12:00:00+00', '2026-01-02 12:00:00+00', '2026-01-02 12:00:00+00', '2026-01-02 12:00:00+00');
INSERT INTO message (message_id, sender_user_id, message_type, content_text, is_forwarded, is_deleted, is_edited, edited_at, expires_at, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000003', 'sample_sender_user_id_3', 'value_3', 'sample_content_text_3', FALSE, FALSE, FALSE, '2026-01-03 12:00:00+00', '2026-01-03 12:00:00+00', '2026-01-03 12:00:00+00', '2026-01-03 12:00:00+00');

-- message_media
INSERT INTO message_media (media_id, media_type, media_url, is_view_once, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000001', 'value_1', 'sample_media_url_1', FALSE, '2026-01-01 12:00:00+00', '2026-01-01 12:00:00+00');
INSERT INTO message_media (media_id, media_type, media_url, is_view_once, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000002', 'value_2', 'sample_media_url_2', TRUE, '2026-01-02 12:00:00+00', '2026-01-02 12:00:00+00');
INSERT INTO message_media (media_id, media_type, media_url, is_view_once, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000003', 'value_3', 'sample_media_url_3', FALSE, '2026-01-03 12:00:00+00', '2026-01-03 12:00:00+00');

-- message_reaction
INSERT INTO message_reaction (reaction_id, reacting_user_id, emoji, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000001', 'sample_reacting_user_id_1', 'sample_emoji_1', '2026-01-01 12:00:00+00', '2026-01-01 12:00:00+00');
INSERT INTO message_reaction (reaction_id, reacting_user_id, emoji, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000002', 'sample_reacting_user_id_2', 'sample_emoji_2', '2026-01-02 12:00:00+00', '2026-01-02 12:00:00+00');
INSERT INTO message_reaction (reaction_id, reacting_user_id, emoji, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000003', 'sample_reacting_user_id_3', 'sample_emoji_3', '2026-01-03 12:00:00+00', '2026-01-03 12:00:00+00');

-- group_chat
INSERT INTO group_chat (group_chat_id, group_name, group_description, invite_link_url, invite_link_enabled, setting_admin_only_posting, setting_allow_member_invite, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000001', 'sample_group_name_1', 'sample_group_description_1', 'sample_invite_link_url_1', FALSE, FALSE, FALSE, '2026-01-01 12:00:00+00', '2026-01-01 12:00:00+00');
INSERT INTO group_chat (group_chat_id, group_name, group_description, invite_link_url, invite_link_enabled, setting_admin_only_posting, setting_allow_member_invite, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000002', 'sample_group_name_2', 'sample_group_description_2', 'sample_invite_link_url_2', TRUE, TRUE, TRUE, '2026-01-02 12:00:00+00', '2026-01-02 12:00:00+00');
INSERT INTO group_chat (group_chat_id, group_name, group_description, invite_link_url, invite_link_enabled, setting_admin_only_posting, setting_allow_member_invite, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000003', 'sample_group_name_3', 'sample_group_description_3', 'sample_invite_link_url_3', FALSE, FALSE, FALSE, '2026-01-03 12:00:00+00', '2026-01-03 12:00:00+00');

-- group_member
INSERT INTO group_member (group_member_id, role, left_silently, left_at, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000001', 'value_1', FALSE, '2026-01-01 12:00:00+00', '2026-01-01 12:00:00+00', '2026-01-01 12:00:00+00');
INSERT INTO group_member (group_member_id, role, left_silently, left_at, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000002', 'value_2', TRUE, '2026-01-02 12:00:00+00', '2026-01-02 12:00:00+00', '2026-01-02 12:00:00+00');
INSERT INTO group_member (group_member_id, role, left_silently, left_at, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000003', 'value_3', FALSE, '2026-01-03 12:00:00+00', '2026-01-03 12:00:00+00', '2026-01-03 12:00:00+00');

-- message_mention
INSERT INTO message_mention (mention_id, position_start, position_end, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000001', 100, 100, '2026-01-01 12:00:00+00', '2026-01-01 12:00:00+00');
INSERT INTO message_mention (mention_id, position_start, position_end, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000002', 200, 200, '2026-01-02 12:00:00+00', '2026-01-02 12:00:00+00');
INSERT INTO message_mention (mention_id, position_start, position_end, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000003', 300, 300, '2026-01-03 12:00:00+00', '2026-01-03 12:00:00+00');

-- Community
INSERT INTO community (community_id, name, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000001', 'sample_name_1', '2026-01-01 12:00:00+00', '2026-01-01 12:00:00+00');
INSERT INTO community (community_id, name, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000002', 'sample_name_2', '2026-01-02 12:00:00+00', '2026-01-02 12:00:00+00');
INSERT INTO community (community_id, name, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000003', 'sample_name_3', '2026-01-03 12:00:00+00', '2026-01-03 12:00:00+00');

-- Group
INSERT INTO group (group_id, name, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000001', 'sample_name_1', '2026-01-01 12:00:00+00', '2026-01-01 12:00:00+00');
INSERT INTO group (group_id, name, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000002', 'sample_name_2', '2026-01-02 12:00:00+00', '2026-01-02 12:00:00+00');
INSERT INTO group (group_id, name, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000003', 'sample_name_3', '2026-01-03 12:00:00+00', '2026-01-03 12:00:00+00');

-- Channel
INSERT INTO channel (channel_id, name, is_one_way_broadcast, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000001', 'sample_name_1', FALSE, '2026-01-01 12:00:00+00', '2026-01-01 12:00:00+00');
INSERT INTO channel (channel_id, name, is_one_way_broadcast, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000002', 'sample_name_2', TRUE, '2026-01-02 12:00:00+00', '2026-01-02 12:00:00+00');
INSERT INTO channel (channel_id, name, is_one_way_broadcast, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000003', 'sample_name_3', FALSE, '2026-01-03 12:00:00+00', '2026-01-03 12:00:00+00');

-- Poll
INSERT INTO poll (poll_id, chat_context_type, chat_context_id, question_text, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000001', 'value_1', '00000000-0000-0000-0000-000000000001', 'sample_question_text_1', '2026-01-01 12:00:00+00', '2026-01-01 12:00:00+00');
INSERT INTO poll (poll_id, chat_context_type, chat_context_id, question_text, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000002', 'value_2', '00000000-0000-0000-0000-000000000002', 'sample_question_text_2', '2026-01-02 12:00:00+00', '2026-01-02 12:00:00+00');
INSERT INTO poll (poll_id, chat_context_type, chat_context_id, question_text, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000003', 'value_3', '00000000-0000-0000-0000-000000000003', 'sample_question_text_3', '2026-01-03 12:00:00+00', '2026-01-03 12:00:00+00');

-- Call
INSERT INTO call (call_id, call_type, is_group_call, is_encrypted, screen_share_enabled, scheduled_at, call_link_url, quick_reject_message, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000001', 'value_1', FALSE, FALSE, FALSE, '2026-01-01 12:00:00+00', 'sample_call_link_url_1', 'sample_quick_reject_message_1', '2026-01-01 12:00:00+00', '2026-01-01 12:00:00+00');
INSERT INTO call (call_id, call_type, is_group_call, is_encrypted, screen_share_enabled, scheduled_at, call_link_url, quick_reject_message, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000002', 'value_2', TRUE, TRUE, TRUE, '2026-01-02 12:00:00+00', 'sample_call_link_url_2', 'sample_quick_reject_message_2', '2026-01-02 12:00:00+00', '2026-01-02 12:00:00+00');
INSERT INTO call (call_id, call_type, is_group_call, is_encrypted, screen_share_enabled, scheduled_at, call_link_url, quick_reject_message, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000003', 'value_3', FALSE, FALSE, FALSE, '2026-01-03 12:00:00+00', 'sample_call_link_url_3', 'sample_quick_reject_message_3', '2026-01-03 12:00:00+00', '2026-01-03 12:00:00+00');

-- contact
INSERT INTO contact (contact_id, display_name, phone_number, status_muted, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000001', 'sample_display_name_1', 'sample_phone_number_1', FALSE, '2026-01-01 12:00:00+00', '2026-01-01 12:00:00+00');
INSERT INTO contact (contact_id, display_name, phone_number, status_muted, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000002', 'sample_display_name_2', 'sample_phone_number_2', TRUE, '2026-01-02 12:00:00+00', '2026-01-02 12:00:00+00');
INSERT INTO contact (contact_id, display_name, phone_number, status_muted, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000003', 'sample_display_name_3', 'sample_phone_number_3', FALSE, '2026-01-03 12:00:00+00', '2026-01-03 12:00:00+00');

-- call_log
INSERT INTO call_log (call_log_id, started_at, ended_at, duration_seconds, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000001', '2026-01-01 12:00:00+00', '2026-01-01 12:00:00+00', 100, '2026-01-01 12:00:00+00', '2026-01-01 12:00:00+00');
INSERT INTO call_log (call_log_id, started_at, ended_at, duration_seconds, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000002', '2026-01-02 12:00:00+00', '2026-01-02 12:00:00+00', 200, '2026-01-02 12:00:00+00', '2026-01-02 12:00:00+00');
INSERT INTO call_log (call_log_id, started_at, ended_at, duration_seconds, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000003', '2026-01-03 12:00:00+00', '2026-01-03 12:00:00+00', 300, '2026-01-03 12:00:00+00', '2026-01-03 12:00:00+00');

-- status_update
INSERT INTO status_update (status_update_id, content_text, expires_at, visibility, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000001', 'sample_content_text_1', '2026-01-01 12:00:00+00', 'value_1', '2026-01-01 12:00:00+00', '2026-01-01 12:00:00+00');
INSERT INTO status_update (status_update_id, content_text, expires_at, visibility, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000002', 'sample_content_text_2', '2026-01-02 12:00:00+00', 'value_2', '2026-01-02 12:00:00+00', '2026-01-02 12:00:00+00');
INSERT INTO status_update (status_update_id, content_text, expires_at, visibility, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000003', 'sample_content_text_3', '2026-01-03 12:00:00+00', 'value_3', '2026-01-03 12:00:00+00', '2026-01-03 12:00:00+00');

-- status_reply
INSERT INTO status_reply (status_reply_id, reply_text, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000001', 'sample_reply_text_1', '2026-01-01 12:00:00+00', '2026-01-01 12:00:00+00');
INSERT INTO status_reply (status_reply_id, reply_text, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000002', 'sample_reply_text_2', '2026-01-02 12:00:00+00', '2026-01-02 12:00:00+00');
INSERT INTO status_reply (status_reply_id, reply_text, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000003', 'sample_reply_text_3', '2026-01-03 12:00:00+00', '2026-01-03 12:00:00+00');

-- media_item
INSERT INTO media_item (media_item_id, media_type, file_name, file_url, size_bytes, edited_flag, edit_notes, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000001', 'value_1', 'sample_file_name_1', 'sample_file_url_1', 100, FALSE, 'sample_edit_notes_1', '2026-01-01 12:00:00+00', '2026-01-01 12:00:00+00');
INSERT INTO media_item (media_item_id, media_type, file_name, file_url, size_bytes, edited_flag, edit_notes, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000002', 'value_2', 'sample_file_name_2', 'sample_file_url_2', 200, TRUE, 'sample_edit_notes_2', '2026-01-02 12:00:00+00', '2026-01-02 12:00:00+00');
INSERT INTO media_item (media_item_id, media_type, file_name, file_url, size_bytes, edited_flag, edit_notes, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000003', 'value_3', 'sample_file_name_3', 'sample_file_url_3', 300, FALSE, 'sample_edit_notes_3', '2026-01-03 12:00:00+00', '2026-01-03 12:00:00+00');

-- media_attachment
INSERT INTO media_attachment (attachment_id, media_type, file_url, source_library, is_hd, duration_seconds, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000001', 'value_1', 'sample_file_url_1', 'value_1', FALSE, 100, '2026-01-01 12:00:00+00', '2026-01-01 12:00:00+00');
INSERT INTO media_attachment (attachment_id, media_type, file_url, source_library, is_hd, duration_seconds, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000002', 'value_2', 'sample_file_url_2', 'value_2', TRUE, 200, '2026-01-02 12:00:00+00', '2026-01-02 12:00:00+00');
INSERT INTO media_attachment (attachment_id, media_type, file_url, source_library, is_hd, duration_seconds, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000003', 'value_3', 'sample_file_url_3', 'value_3', FALSE, 300, '2026-01-03 12:00:00+00', '2026-01-03 12:00:00+00');

-- encryption_session
INSERT INTO encryption_session (encryption_session_id, chat_id, security_code, verification_status, verified_at, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000001', 'sample_security_code_1', 'value_1', '2026-01-01 12:00:00+00', '2026-01-01 12:00:00+00', '2026-01-01 12:00:00+00');
INSERT INTO encryption_session (encryption_session_id, chat_id, security_code, verification_status, verified_at, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000002', '00000000-0000-0000-0000-000000000002', 'sample_security_code_2', 'value_2', '2026-01-02 12:00:00+00', '2026-01-02 12:00:00+00', '2026-01-02 12:00:00+00');
INSERT INTO encryption_session (encryption_session_id, chat_id, security_code, verification_status, verified_at, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000003', '00000000-0000-0000-0000-000000000003', 'sample_security_code_3', 'value_3', '2026-01-03 12:00:00+00', '2026-01-03 12:00:00+00', '2026-01-03 12:00:00+00');

-- contact_block
INSERT INTO contact_block (block_id, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000001', '2026-01-01 12:00:00+00', '2026-01-01 12:00:00+00');
INSERT INTO contact_block (block_id, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000002', '2026-01-02 12:00:00+00', '2026-01-02 12:00:00+00');
INSERT INTO contact_block (block_id, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000003', '2026-01-03 12:00:00+00', '2026-01-03 12:00:00+00');

-- report
INSERT INTO report (report_id, reason, status, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000001', 'sample_reason_1', 'value_1', '2026-01-01 12:00:00+00', '2026-01-01 12:00:00+00');
INSERT INTO report (report_id, reason, status, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000002', 'sample_reason_2', 'value_2', '2026-01-02 12:00:00+00', '2026-01-02 12:00:00+00');
INSERT INTO report (report_id, reason, status, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000003', 'sample_reason_3', 'value_3', '2026-01-03 12:00:00+00', '2026-01-03 12:00:00+00');

-- notification_setting
INSERT INTO notification_setting (notification_setting_id, push_enabled, preview_enabled, quick_reply_enabled, do_not_disturb_enabled, reaction_notifications_enabled, call_notification_mode, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000001', FALSE, FALSE, FALSE, FALSE, FALSE, 'value_1', '2026-01-01 12:00:00+00', '2026-01-01 12:00:00+00');
INSERT INTO notification_setting (notification_setting_id, push_enabled, preview_enabled, quick_reply_enabled, do_not_disturb_enabled, reaction_notifications_enabled, call_notification_mode, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000002', TRUE, TRUE, TRUE, TRUE, TRUE, 'value_2', '2026-01-02 12:00:00+00', '2026-01-02 12:00:00+00');
INSERT INTO notification_setting (notification_setting_id, push_enabled, preview_enabled, quick_reply_enabled, do_not_disturb_enabled, reaction_notifications_enabled, call_notification_mode, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000003', FALSE, FALSE, FALSE, FALSE, FALSE, 'value_3', '2026-01-03 12:00:00+00', '2026-01-03 12:00:00+00');

-- whatsapp_user
INSERT INTO whatsapp_user (user_id, phone_number, display_name, online_status_visibility, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000001', 'sample_phone_number_1', 'sample_display_name_1', 'value_1', '2026-01-01 12:00:00+00', '2026-01-01 12:00:00+00');
INSERT INTO whatsapp_user (user_id, phone_number, display_name, online_status_visibility, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000002', 'sample_phone_number_2', 'sample_display_name_2', 'value_2', '2026-01-02 12:00:00+00', '2026-01-02 12:00:00+00');
INSERT INTO whatsapp_user (user_id, phone_number, display_name, online_status_visibility, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000003', 'sample_phone_number_3', 'sample_display_name_3', 'value_3', '2026-01-03 12:00:00+00', '2026-01-03 12:00:00+00');

-- label
INSERT INTO label (label_id, label_name, color, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000001', 'sample_label_name_1', 'sample_color_1', '2026-01-01 12:00:00+00', '2026-01-01 12:00:00+00');
INSERT INTO label (label_id, label_name, color, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000002', 'sample_label_name_2', 'sample_color_2', '2026-01-02 12:00:00+00', '2026-01-02 12:00:00+00');
INSERT INTO label (label_id, label_name, color, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000003', 'sample_label_name_3', 'sample_color_3', '2026-01-03 12:00:00+00', '2026-01-03 12:00:00+00');

-- UserPrivacySetting
INSERT INTO user_privacy_setting (privacy_setting_id, read_receipt_enabled, profile_photo_visibility, status_text_visibility, group_invite_permission, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000001', FALSE, 'value_1', 'value_1', 'value_1', '2026-01-01 12:00:00+00', '2026-01-01 12:00:00+00');
INSERT INTO user_privacy_setting (privacy_setting_id, read_receipt_enabled, profile_photo_visibility, status_text_visibility, group_invite_permission, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000002', TRUE, 'value_2', 'value_2', 'value_2', '2026-01-02 12:00:00+00', '2026-01-02 12:00:00+00');
INSERT INTO user_privacy_setting (privacy_setting_id, read_receipt_enabled, profile_photo_visibility, status_text_visibility, group_invite_permission, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000003', FALSE, 'value_3', 'value_3', 'value_3', '2026-01-03 12:00:00+00', '2026-01-03 12:00:00+00');

-- UserAppearanceSetting
INSERT INTO user_appearance_setting (appearance_setting_id, chat_background, dark_mode_enabled, language_code, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000001', 'sample_chat_background_1', FALSE, 'sample_language_code_1', '2026-01-01 12:00:00+00', '2026-01-01 12:00:00+00');
INSERT INTO user_appearance_setting (appearance_setting_id, chat_background, dark_mode_enabled, language_code, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000002', 'sample_chat_background_2', TRUE, 'sample_language_code_2', '2026-01-02 12:00:00+00', '2026-01-02 12:00:00+00');
INSERT INTO user_appearance_setting (appearance_setting_id, chat_background, dark_mode_enabled, language_code, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000003', 'sample_chat_background_3', FALSE, 'sample_language_code_3', '2026-01-03 12:00:00+00', '2026-01-03 12:00:00+00');

-- UserUsageSetting
INSERT INTO user_usage_setting (usage_setting_id, storage_used_mb, storage_limit_mb, data_usage_control_enabled, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000001', 10.5, 10.5, FALSE, '2026-01-01 12:00:00+00', '2026-01-01 12:00:00+00');
INSERT INTO user_usage_setting (usage_setting_id, storage_used_mb, storage_limit_mb, data_usage_control_enabled, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000002', 21.0, 21.0, TRUE, '2026-01-02 12:00:00+00', '2026-01-02 12:00:00+00');
INSERT INTO user_usage_setting (usage_setting_id, storage_used_mb, storage_limit_mb, data_usage_control_enabled, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000003', 31.5, 31.5, FALSE, '2026-01-03 12:00:00+00', '2026-01-03 12:00:00+00');

-- UserBackupSetting
INSERT INTO user_backup_setting (backup_setting_id, cloud_backup_enabled, last_backup_at, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000001', FALSE, '2026-01-01 12:00:00+00', '2026-01-01 12:00:00+00', '2026-01-01 12:00:00+00');
INSERT INTO user_backup_setting (backup_setting_id, cloud_backup_enabled, last_backup_at, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000002', TRUE, '2026-01-02 12:00:00+00', '2026-01-02 12:00:00+00', '2026-01-02 12:00:00+00');
INSERT INTO user_backup_setting (backup_setting_id, cloud_backup_enabled, last_backup_at, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000003', FALSE, '2026-01-03 12:00:00+00', '2026-01-03 12:00:00+00', '2026-01-03 12:00:00+00');

-- backup
INSERT INTO backup (backup_id, is_end_to_end_encrypted, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000001', FALSE, '2026-01-01 12:00:00+00', '2026-01-01 12:00:00+00');
INSERT INTO backup (backup_id, is_end_to_end_encrypted, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000002', TRUE, '2026-01-02 12:00:00+00', '2026-01-02 12:00:00+00');
INSERT INTO backup (backup_id, is_end_to_end_encrypted, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000003', FALSE, '2026-01-03 12:00:00+00', '2026-01-03 12:00:00+00');

-- business_profile
INSERT INTO business_profile (business_profile_id, display_name, verification_status, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000001', 'sample_display_name_1', 'value_1', '2026-01-01 12:00:00+00', '2026-01-01 12:00:00+00');
INSERT INTO business_profile (business_profile_id, display_name, verification_status, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000002', 'sample_display_name_2', 'value_2', '2026-01-02 12:00:00+00', '2026-01-02 12:00:00+00');
INSERT INTO business_profile (business_profile_id, display_name, verification_status, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000003', 'sample_display_name_3', 'value_3', '2026-01-03 12:00:00+00', '2026-01-03 12:00:00+00');

-- quick_reply
INSERT INTO quick_reply (quick_reply_id, shortcut, message_text, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000001', 'sample_shortcut_1', 'sample_message_text_1', '2026-01-01 12:00:00+00', '2026-01-01 12:00:00+00');
INSERT INTO quick_reply (quick_reply_id, shortcut, message_text, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000002', 'sample_shortcut_2', 'sample_message_text_2', '2026-01-02 12:00:00+00', '2026-01-02 12:00:00+00');
INSERT INTO quick_reply (quick_reply_id, shortcut, message_text, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000003', 'sample_shortcut_3', 'sample_message_text_3', '2026-01-03 12:00:00+00', '2026-01-03 12:00:00+00');

-- auto_message
INSERT INTO auto_message (auto_message_id, message_type, message_text, is_active, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000001', 'value_1', 'sample_message_text_1', FALSE, '2026-01-01 12:00:00+00', '2026-01-01 12:00:00+00');
INSERT INTO auto_message (auto_message_id, message_type, message_text, is_active, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000002', 'value_2', 'sample_message_text_2', TRUE, '2026-01-02 12:00:00+00', '2026-01-02 12:00:00+00');
INSERT INTO auto_message (auto_message_id, message_type, message_text, is_active, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000003', 'value_3', 'sample_message_text_3', FALSE, '2026-01-03 12:00:00+00', '2026-01-03 12:00:00+00');

-- business
INSERT INTO business (business_id, business_name, api_access_enabled, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000001', 'sample_business_name_1', FALSE, '2026-01-01 12:00:00+00', '2026-01-01 12:00:00+00');
INSERT INTO business (business_id, business_name, api_access_enabled, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000002', 'sample_business_name_2', TRUE, '2026-01-02 12:00:00+00', '2026-01-02 12:00:00+00');
INSERT INTO business (business_id, business_name, api_access_enabled, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000003', 'sample_business_name_3', FALSE, '2026-01-03 12:00:00+00', '2026-01-03 12:00:00+00');

-- product
INSERT INTO product (product_id, product_name, description, price_amount, currency_code, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000001', 'sample_product_name_1', 'sample_description_1', 10.5, 'sample_currency_code_1', '2026-01-01 12:00:00+00', '2026-01-01 12:00:00+00');
INSERT INTO product (product_id, product_name, description, price_amount, currency_code, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000002', 'sample_product_name_2', 'sample_description_2', 21.0, 'sample_currency_code_2', '2026-01-02 12:00:00+00', '2026-01-02 12:00:00+00');
INSERT INTO product (product_id, product_name, description, price_amount, currency_code, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000003', 'sample_product_name_3', 'sample_description_3', 31.5, 'sample_currency_code_3', '2026-01-03 12:00:00+00', '2026-01-03 12:00:00+00');

-- cart
INSERT INTO cart (cart_id, status, total_amount, currency_code, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000001', 'value_1', 10.5, 'sample_currency_code_1', '2026-01-01 12:00:00+00', '2026-01-01 12:00:00+00');
INSERT INTO cart (cart_id, status, total_amount, currency_code, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000002', 'value_2', 21.0, 'sample_currency_code_2', '2026-01-02 12:00:00+00', '2026-01-02 12:00:00+00');
INSERT INTO cart (cart_id, status, total_amount, currency_code, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000003', 'value_3', 31.5, 'sample_currency_code_3', '2026-01-03 12:00:00+00', '2026-01-03 12:00:00+00');

-- payment
INSERT INTO payment (payment_id, payment_status, amount, currency_code, market_code, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000001', 'value_1', 10.5, 'sample_currency_code_1', 'sample_market_code_1', '2026-01-01 12:00:00+00', '2026-01-01 12:00:00+00');
INSERT INTO payment (payment_id, payment_status, amount, currency_code, market_code, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000002', 'value_2', 21.0, 'sample_currency_code_2', 'sample_market_code_2', '2026-01-02 12:00:00+00', '2026-01-02 12:00:00+00');
INSERT INTO payment (payment_id, payment_status, amount, currency_code, market_code, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000003', 'value_3', 31.5, 'sample_currency_code_3', 'sample_market_code_3', '2026-01-03 12:00:00+00', '2026-01-03 12:00:00+00');

-- business_statistic
INSERT INTO business_statistic (stat_id, period_start, period_end, messages_sent_count, messages_received_count, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000001', '2026-01-01', '2026-01-01', 100, 100, '2026-01-01 12:00:00+00', '2026-01-01 12:00:00+00');
INSERT INTO business_statistic (stat_id, period_start, period_end, messages_sent_count, messages_received_count, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000002', '2026-01-02', '2026-01-02', 200, 200, '2026-01-02 12:00:00+00', '2026-01-02 12:00:00+00');
INSERT INTO business_statistic (stat_id, period_start, period_end, messages_sent_count, messages_received_count, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000003', '2026-01-03', '2026-01-03', 300, 300, '2026-01-03 12:00:00+00', '2026-01-03 12:00:00+00');

-- integration_feature
INSERT INTO integration_feature (integration_feature_id, feature_type, requirement_level, description, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000001', 'value_1', 'value_1', 'sample_description_1', '2026-01-01 12:00:00+00', '2026-01-01 12:00:00+00');
INSERT INTO integration_feature (integration_feature_id, feature_type, requirement_level, description, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000002', 'value_2', 'value_2', 'sample_description_2', '2026-01-02 12:00:00+00', '2026-01-02 12:00:00+00');
INSERT INTO integration_feature (integration_feature_id, feature_type, requirement_level, description, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000003', 'value_3', 'value_3', 'sample_description_3', '2026-01-03 12:00:00+00', '2026-01-03 12:00:00+00');

-- performance_requirement
INSERT INTO performance_requirement (performance_requirement_id, metric_type, requirement_level, description, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000001', 'value_1', 'value_1', 'sample_description_1', '2026-01-01 12:00:00+00', '2026-01-01 12:00:00+00');
INSERT INTO performance_requirement (performance_requirement_id, metric_type, requirement_level, description, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000002', 'value_2', 'value_2', 'sample_description_2', '2026-01-02 12:00:00+00', '2026-01-02 12:00:00+00');
INSERT INTO performance_requirement (performance_requirement_id, metric_type, requirement_level, description, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000003', 'value_3', 'value_3', 'sample_description_3', '2026-01-03 12:00:00+00', '2026-01-03 12:00:00+00');

-- ai_assistant
INSERT INTO ai_assistant (ai_assistant_id, name, provider, is_enabled, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000001', 'sample_name_1', 'sample_provider_1', FALSE, '2026-01-01 12:00:00+00', '2026-01-01 12:00:00+00');
INSERT INTO ai_assistant (ai_assistant_id, name, provider, is_enabled, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000002', 'sample_name_2', 'sample_provider_2', TRUE, '2026-01-02 12:00:00+00', '2026-01-02 12:00:00+00');
INSERT INTO ai_assistant (ai_assistant_id, name, provider, is_enabled, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000003', 'sample_name_3', 'sample_provider_3', FALSE, '2026-01-03 12:00:00+00', '2026-01-03 12:00:00+00');

-- smart_reply
INSERT INTO smart_reply (smart_reply_id, language_code, reply_text, context_key, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000001', 'sample_language_code_1', 'sample_reply_text_1', 'sample_context_key_1', '2026-01-01 12:00:00+00', '2026-01-01 12:00:00+00');
INSERT INTO smart_reply (smart_reply_id, language_code, reply_text, context_key, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000002', 'sample_language_code_2', 'sample_reply_text_2', 'sample_context_key_2', '2026-01-02 12:00:00+00', '2026-01-02 12:00:00+00');
INSERT INTO smart_reply (smart_reply_id, language_code, reply_text, context_key, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000003', 'sample_language_code_3', 'sample_reply_text_3', 'sample_context_key_3', '2026-01-03 12:00:00+00', '2026-01-03 12:00:00+00');

-- locale
INSERT INTO locale (locale_id, locale_code, rtl_supported, regional_date_format, regional_number_format, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000001', 'sample_locale_code_1', FALSE, 'sample_regional_date_format_1', 'sample_regional_number_format_1', '2026-01-01 12:00:00+00', '2026-01-01 12:00:00+00');
INSERT INTO locale (locale_id, locale_code, rtl_supported, regional_date_format, regional_number_format, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000002', 'sample_locale_code_2', TRUE, 'sample_regional_date_format_2', 'sample_regional_number_format_2', '2026-01-02 12:00:00+00', '2026-01-02 12:00:00+00');
INSERT INTO locale (locale_id, locale_code, rtl_supported, regional_date_format, regional_number_format, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000003', 'sample_locale_code_3', FALSE, 'sample_regional_date_format_3', 'sample_regional_number_format_3', '2026-01-03 12:00:00+00', '2026-01-03 12:00:00+00');

-- sticker_pack
INSERT INTO sticker_pack (sticker_pack_id, name, description, is_active, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000001', 'sample_name_1', 'sample_description_1', FALSE, '2026-01-01 12:00:00+00', '2026-01-01 12:00:00+00');
INSERT INTO sticker_pack (sticker_pack_id, name, description, is_active, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000002', 'sample_name_2', 'sample_description_2', TRUE, '2026-01-02 12:00:00+00', '2026-01-02 12:00:00+00');
INSERT INTO sticker_pack (sticker_pack_id, name, description, is_active, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000003', 'sample_name_3', 'sample_description_3', FALSE, '2026-01-03 12:00:00+00', '2026-01-03 12:00:00+00');

-- sticker_suggestion
INSERT INTO sticker_suggestion (sticker_suggestion_id, context_keyword, confidence_score, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000001', 'sample_context_keyword_1', 10.5, '2026-01-01 12:00:00+00', '2026-01-01 12:00:00+00');
INSERT INTO sticker_suggestion (sticker_suggestion_id, context_keyword, confidence_score, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000002', 'sample_context_keyword_2', 21.0, '2026-01-02 12:00:00+00', '2026-01-02 12:00:00+00');
INSERT INTO sticker_suggestion (sticker_suggestion_id, context_keyword, confidence_score, created_at, updated_at) VALUES ('00000000-0000-0000-0000-000000000003', 'sample_context_keyword_3', 31.5, '2026-01-03 12:00:00+00', '2026-01-03 12:00:00+00');
