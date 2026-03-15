-- PostgreSQL Schema: whatsapp-messaging-service
-- Generated: 2026-02-12T17:14:32.706046
-- Entities: 48, Relationships: 48

-- ============================================
-- ENUM TYPES
-- ============================================

CREATE TYPE call_notification_mode_type AS ENUM ('all', 'missed_only', 'none');
CREATE TYPE call_type_type AS ENUM ('voice', 'video');
CREATE TYPE chat_context_type_type AS ENUM ('group', 'individual');
CREATE TYPE credential_type_type AS ENUM ('pin_2fa', 'biometric', 'passkey');
CREATE TYPE device_platform_type AS ENUM ('ios', 'android', 'web', 'desktop', 'other');
CREATE TYPE feature_type_type AS ENUM ('share_extension', 'voice_assistant', 'widget', 'watch_app', 'desktop_app', 'web_version');
CREATE TYPE group_invite_permission_type AS ENUM ('everyone', 'contacts', 'nobody');
CREATE TYPE lock_method_type AS ENUM ('pin', 'biometric', 'password', 'none');
CREATE TYPE media_type_type AS ENUM ('voice', 'image', 'video', 'file');
CREATE TYPE message_type_type AS ENUM ('text', 'voice', 'media');
CREATE TYPE metric_type_type AS ENUM ('app_start_speed', 'sync_efficiency', 'battery_efficiency', 'storage_efficiency');
CREATE TYPE online_status_visibility_type AS ENUM ('public', 'contacts_only', 'nobody');
CREATE TYPE payment_status_type AS ENUM ('pending', 'completed', 'failed', 'refunded');
CREATE TYPE profile_photo_visibility_type AS ENUM ('everyone', 'contacts', 'nobody');
CREATE TYPE requirement_level_type AS ENUM ('must', 'should');
CREATE TYPE role_type AS ENUM ('admin', 'member');
CREATE TYPE source_library_type AS ENUM ('camera', 'gallery', 'external');
CREATE TYPE status_text_visibility_type AS ENUM ('everyone', 'contacts', 'nobody');
CREATE TYPE status_type AS ENUM ('active', 'disabled', 'pending_verification');
CREATE TYPE verification_status_type AS ENUM ('unverified', 'verified');
CREATE TYPE visibility_type AS ENUM ('public', 'contacts_only', 'custom');

-- ============================================
-- TABLES
-- ============================================

-- Registered messaging user with phone-based identity
CREATE TABLE user (
    user_id UUID NOT NULL,
    phone_number VARCHAR(20) NOT NULL,
    phone_verified_at TIMESTAMP WITH TIME ZONE,
    status status_type NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL
);

-- Conversation container for messages
CREATE TABLE chat (
    chat_id UUID NOT NULL,
    chat_name VARCHAR(100),
    is_locked BOOLEAN NOT NULL,
    lock_method lock_method_type,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL
);

-- Group chat container with settings and invite link
CREATE TABLE group_chat (
    group_chat_id UUID NOT NULL,
    group_name VARCHAR(100) NOT NULL,
    group_description TEXT,
    invite_link_url VARCHAR(255),
    invite_link_enabled BOOLEAN NOT NULL,
    setting_admin_only_posting BOOLEAN NOT NULL,
    setting_allow_member_invite BOOLEAN NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL
);

-- A community that aggregates multiple groups
CREATE TABLE community (
    community_id UUID NOT NULL,
    name VARCHAR(50) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL
);

-- A poll created in a group or individual chat
CREATE TABLE poll (
    poll_id UUID NOT NULL,
    chat_context_type chat_context_type_type NOT NULL,
    chat_context_id UUID NOT NULL,
    question_text TEXT NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL
);

-- An encrypted voice or video call, optionally group-based
CREATE TABLE call (
    call_id UUID NOT NULL,
    call_type call_type_type NOT NULL,
    is_group_call BOOLEAN NOT NULL,
    is_encrypted BOOLEAN NOT NULL,
    screen_share_enabled BOOLEAN,
    scheduled_at TIMESTAMP WITH TIME ZONE,
    call_link_url VARCHAR(255),
    quick_reject_message VARCHAR(255),
    created_at TIMESTAMP WITH TIME ZONE NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL
);

-- A communication contact whose status and calls are tracked
CREATE TABLE contact (
    contact_id UUID NOT NULL,
    display_name VARCHAR(100) NOT NULL,
    phone_number VARCHAR(30) NOT NULL,
    status_muted BOOLEAN NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL
);

-- End-to-end encryption context for a chat
CREATE TABLE encryption_session (
    encryption_session_id UUID NOT NULL,
    chat_id UUID NOT NULL,
    security_code VARCHAR(64) NOT NULL,
    verification_status verification_status_type NOT NULL,
    verified_at TIMESTAMP WITH TIME ZONE,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL
);

-- Registered WhatsApp user profile
CREATE TABLE whatsapp_user (
    user_id UUID NOT NULL,
    phone_number VARCHAR(20) NOT NULL,
    display_name VARCHAR(50) NOT NULL,
    online_status_visibility online_status_visibility_type NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL
);

-- Configurable privacy and visibility settings per user
CREATE TABLE user_privacy_setting (
    privacy_setting_id UUID NOT NULL,
    user_id UUID NOT NULL,
    read_receipt_enabled BOOLEAN NOT NULL,
    profile_photo_visibility profile_photo_visibility_type NOT NULL,
    status_text_visibility status_text_visibility_type NOT NULL,
    group_invite_permission group_invite_permission_type NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL
);

-- User interface and localization preferences
CREATE TABLE user_appearance_setting (
    appearance_setting_id UUID NOT NULL,
    user_id UUID NOT NULL,
    chat_background VARCHAR(255),
    dark_mode_enabled BOOLEAN NOT NULL,
    language_code VARCHAR(10) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL
);

-- Storage and data usage configuration and overview per user
CREATE TABLE user_usage_setting (
    usage_setting_id UUID NOT NULL,
    user_id UUID NOT NULL,
    storage_used_mb DECIMAL(10, 2) NOT NULL,
    storage_limit_mb DECIMAL(10, 2),
    data_usage_control_enabled BOOLEAN NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL
);

-- Cloud backup configuration for user chats
CREATE TABLE user_backup_setting (
    backup_setting_id UUID NOT NULL,
    user_id UUID NOT NULL,
    cloud_backup_enabled BOOLEAN NOT NULL,
    last_backup_at TIMESTAMP WITH TIME ZONE,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL
);

-- Enhanced profile for a business account
CREATE TABLE business_profile (
    business_profile_id UUID NOT NULL,
    display_name VARCHAR(255) NOT NULL,
    verification_status verification_status_type NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL
);

-- Business account using messaging features
CREATE TABLE business (
    business_id UUID NOT NULL,
    business_name VARCHAR(100) NOT NULL,
    api_access_enabled BOOLEAN NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL
);

-- Integration capability provided by the messaging system
CREATE TABLE integration_feature (
    integration_feature_id UUID NOT NULL,
    feature_type feature_type_type NOT NULL,
    requirement_level requirement_level_type NOT NULL,
    description TEXT,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL
);

-- Performance expectation for the messaging system
CREATE TABLE performance_requirement (
    performance_requirement_id UUID NOT NULL,
    metric_type metric_type_type NOT NULL,
    requirement_level requirement_level_type NOT NULL,
    description TEXT,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL
);

-- Configuration for AI assistant integration in messaging
CREATE TABLE ai_assistant (
    ai_assistant_id UUID NOT NULL,
    name VARCHAR(100) NOT NULL,
    provider VARCHAR(100) NOT NULL,
    is_enabled BOOLEAN NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL
);

-- Localization settings for language direction and regional formats
CREATE TABLE locale (
    locale_id UUID NOT NULL,
    locale_code VARCHAR(10) NOT NULL,
    rtl_supported BOOLEAN NOT NULL,
    regional_date_format VARCHAR(50) NOT NULL,
    regional_number_format VARCHAR(50) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL
);

-- User profile data visible to others
CREATE TABLE user_profile (
    profile_id UUID NOT NULL,
    user_id UUID NOT NULL,
    display_name VARCHAR(50) NOT NULL,
    status_text VARCHAR(200),
    profile_image_url VARCHAR(255),
    show_phone_number BOOLEAN NOT NULL,
    qr_code_value VARCHAR(255),
    qr_code_generated_at TIMESTAMP WITH TIME ZONE,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL
);

-- Device registered for multi-device usage
CREATE TABLE user_device (
    device_id UUID NOT NULL,
    user_id UUID NOT NULL,
    device_name VARCHAR(100),
    device_platform device_platform_type NOT NULL,
    last_active_at TIMESTAMP WITH TIME ZONE,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL
);

-- Authentication methods configured for a user
CREATE TABLE auth_credential (
    credential_id UUID NOT NULL,
    user_id UUID NOT NULL,
    credential_type credential_type_type NOT NULL,
    credential_data TEXT,
    is_enabled BOOLEAN NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL
);

-- Represents a block relationship between users
CREATE TABLE contact_block (
    block_id UUID NOT NULL,
    blocker_user_id UUID NOT NULL,
    blocked_user_id UUID NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL
);

-- Per-user configuration for notifications
CREATE TABLE notification_setting (
    notification_setting_id UUID NOT NULL,
    user_id UUID NOT NULL,
    push_enabled BOOLEAN NOT NULL,
    preview_enabled BOOLEAN NOT NULL,
    quick_reply_enabled BOOLEAN NOT NULL,
    do_not_disturb_enabled BOOLEAN NOT NULL,
    reaction_notifications_enabled BOOLEAN NOT NULL,
    call_notification_mode call_notification_mode_type NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL
);

-- Message sent within a chat
CREATE TABLE message (
    message_id UUID NOT NULL,
    chat_id UUID NOT NULL,
    sender_user_id VARCHAR(64) NOT NULL,
    message_type message_type_type NOT NULL,
    content_text TEXT,
    parent_message_id UUID,
    is_forwarded BOOLEAN NOT NULL,
    is_deleted BOOLEAN NOT NULL,
    is_edited BOOLEAN NOT NULL,
    edited_at TIMESTAMP WITH TIME ZONE,
    expires_at TIMESTAMP WITH TIME ZONE,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL
);

-- Encrypted backup of chat data
CREATE TABLE backup (
    backup_id UUID NOT NULL,
    chat_id UUID NOT NULL,
    is_end_to_end_encrypted BOOLEAN NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL
);

-- Membership of a user in a group chat with roles and leave behavior
CREATE TABLE group_member (
    group_member_id UUID NOT NULL,
    group_chat_id UUID NOT NULL,
    user_id UUID NOT NULL,
    role role_type NOT NULL,
    left_silently BOOLEAN NOT NULL,
    left_at TIMESTAMP WITH TIME ZONE,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL
);

-- A chat group that can belong to a community
CREATE TABLE group (
    group_id UUID NOT NULL,
    community_id UUID,
    name VARCHAR(50) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL
);

-- A record in the call history
CREATE TABLE call_log (
    call_log_id UUID NOT NULL,
    contact_id UUID NOT NULL,
    started_at TIMESTAMP WITH TIME ZONE NOT NULL,
    ended_at TIMESTAMP WITH TIME ZONE,
    duration_seconds INTEGER,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL
);

-- A 24-hour status update created by a contact
CREATE TABLE status_update (
    status_update_id UUID NOT NULL,
    contact_id UUID NOT NULL,
    content_text TEXT,
    expires_at TIMESTAMP WITH TIME ZONE NOT NULL,
    visibility visibility_type NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL
);

-- Business label/tag applied to contacts
CREATE TABLE label (
    label_id UUID NOT NULL,
    owner_user_id UUID NOT NULL,
    label_name VARCHAR(50) NOT NULL,
    color VARCHAR(20),
    created_at TIMESTAMP WITH TIME ZONE NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL
);

-- Predefined response template for business messaging
CREATE TABLE quick_reply (
    quick_reply_id UUID NOT NULL,
    business_profile_id UUID NOT NULL,
    shortcut VARCHAR(50) NOT NULL,
    message_text TEXT NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL
);

-- Automated business message such as away or greeting
CREATE TABLE auto_message (
    auto_message_id UUID NOT NULL,
    business_profile_id UUID NOT NULL,
    message_type message_type_type NOT NULL,
    message_text TEXT NOT NULL,
    is_active BOOLEAN NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL
);

-- Catalog product offered by a business
CREATE TABLE product (
    product_id UUID NOT NULL,
    business_id UUID NOT NULL,
    product_name VARCHAR(120) NOT NULL,
    description TEXT,
    price_amount DECIMAL(10, 2) NOT NULL,
    currency_code VARCHAR(3) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL
);

-- Shopping cart for a business order
CREATE TABLE cart (
    cart_id UUID NOT NULL,
    business_id UUID NOT NULL,
    status status_type NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    currency_code VARCHAR(3) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL
);

-- Aggregated messaging statistics for a business
CREATE TABLE business_statistic (
    stat_id UUID NOT NULL,
    business_id UUID NOT NULL,
    period_start DATE NOT NULL,
    period_end DATE NOT NULL,
    messages_sent_count INTEGER NOT NULL,
    messages_received_count INTEGER NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL
);

-- Intelligent reply suggestions generated for messaging
CREATE TABLE smart_reply (
    smart_reply_id UUID NOT NULL,
    ai_assistant_id UUID NOT NULL,
    language_code VARCHAR(10) NOT NULL,
    reply_text TEXT NOT NULL,
    context_key VARCHAR(255),
    created_at TIMESTAMP WITH TIME ZONE NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL
);

-- Collection of stickers, possibly tailored to a region
CREATE TABLE sticker_pack (
    sticker_pack_id UUID NOT NULL,
    locale_id UUID,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    is_active BOOLEAN NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL
);

-- Media attachments associated with a message
CREATE TABLE message_media (
    media_id UUID NOT NULL,
    message_id UUID NOT NULL,
    media_type media_type_type NOT NULL,
    media_url VARCHAR(255) NOT NULL,
    is_view_once BOOLEAN NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL
);

-- Emoji reaction applied to a message
CREATE TABLE message_reaction (
    reaction_id UUID NOT NULL,
    message_id UUID NOT NULL,
    reacting_user_id VARCHAR(64) NOT NULL,
    emoji VARCHAR(10) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL
);

-- Mention of a user within a group chat message
CREATE TABLE message_mention (
    mention_id UUID NOT NULL,
    message_id UUID NOT NULL,
    mentioned_user_id UUID NOT NULL,
    position_start INTEGER NOT NULL,
    position_end INTEGER NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL
);

-- Media attached to a message, including stickers, GIFs, and audio
CREATE TABLE media_attachment (
    attachment_id UUID NOT NULL,
    message_id UUID NOT NULL,
    media_type media_type_type NOT NULL,
    file_url VARCHAR(2048) NOT NULL,
    source_library source_library_type NOT NULL,
    is_hd BOOLEAN NOT NULL,
    duration_seconds INTEGER,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL
);

-- Report of a message or contact for review
CREATE TABLE report (
    report_id UUID NOT NULL,
    reporter_user_id UUID NOT NULL,
    target_message_id UUID,
    target_user_id UUID,
    reason TEXT,
    status status_type NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL
);

-- A one-way broadcast channel within a group
CREATE TABLE channel (
    channel_id UUID NOT NULL,
    group_id UUID NOT NULL,
    name VARCHAR(50) NOT NULL,
    is_one_way_broadcast BOOLEAN NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL
);

-- A reply made to a status update
CREATE TABLE status_reply (
    status_reply_id UUID NOT NULL,
    status_update_id UUID NOT NULL,
    reply_text TEXT NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL
);

-- A media item sent by a contact, optionally attached to a status update
CREATE TABLE media_item (
    media_item_id UUID NOT NULL,
    sender_contact_id UUID NOT NULL,
    status_update_id UUID,
    media_type media_type_type NOT NULL,
    file_name VARCHAR(255) NOT NULL,
    file_url VARCHAR(2000) NOT NULL,
    size_bytes INTEGER NOT NULL,
    edited_flag BOOLEAN NOT NULL,
    edit_notes TEXT,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL
);

-- In-app payment transaction for a cart
CREATE TABLE payment (
    payment_id UUID NOT NULL,
    cart_id UUID NOT NULL,
    payment_status payment_status_type NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    currency_code VARCHAR(3) NOT NULL,
    market_code VARCHAR(5),
    created_at TIMESTAMP WITH TIME ZONE NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL
);

-- Context-based sticker suggestions for messaging
CREATE TABLE sticker_suggestion (
    sticker_suggestion_id UUID NOT NULL,
    sticker_pack_id UUID NOT NULL,
    locale_id UUID,
    context_keyword VARCHAR(255) NOT NULL,
    confidence_score DECIMAL(10, 2),
    created_at TIMESTAMP WITH TIME ZONE NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL
);

-- ============================================
-- JUNCTION TABLES
-- ============================================

-- Junction table: contact <-> label
CREATE TABLE contact_labels (
    contact_labels.contact_id UUID NOT NULL REFERENCES contact(id) ON DELETE CASCADE,
    contact_labels.label_id UUID NOT NULL REFERENCES label(id) ON DELETE CASCADE,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    PRIMARY KEY (contact_labels.contact_id, contact_labels.label_id)
);

-- Junction table: cart <-> product
CREATE TABLE cart_products (
    cart_products.cart_id UUID NOT NULL REFERENCES cart(id) ON DELETE CASCADE,
    cart_products.product_id UUID NOT NULL REFERENCES product(id) ON DELETE CASCADE,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    PRIMARY KEY (cart_products.cart_id, cart_products.product_id)
);

-- ============================================
-- FOREIGN KEY CONSTRAINTS
-- ============================================

ALTER TABLE user_privacy_setting ADD CONSTRAINT fk_user_privacy_setting_user_id FOREIGN KEY (user_id) REFERENCES user(user_id) ON DELETE CASCADE;
ALTER TABLE user_appearance_setting ADD CONSTRAINT fk_user_appearance_setting_user_id FOREIGN KEY (user_id) REFERENCES user(user_id) ON DELETE CASCADE;
ALTER TABLE user_usage_setting ADD CONSTRAINT fk_user_usage_setting_user_id FOREIGN KEY (user_id) REFERENCES user(user_id) ON DELETE CASCADE;
ALTER TABLE user_backup_setting ADD CONSTRAINT fk_user_backup_setting_user_id FOREIGN KEY (user_id) REFERENCES user(user_id) ON DELETE CASCADE;
ALTER TABLE user_profile ADD CONSTRAINT fk_user_profile_user_id FOREIGN KEY (user_id) REFERENCES user(user_id) ON DELETE CASCADE;
ALTER TABLE user_device ADD CONSTRAINT fk_user_device_user_id FOREIGN KEY (user_id) REFERENCES user(user_id) ON DELETE CASCADE;
ALTER TABLE auth_credential ADD CONSTRAINT fk_auth_credential_user_id FOREIGN KEY (user_id) REFERENCES user(user_id) ON DELETE CASCADE;
ALTER TABLE contact_block ADD CONSTRAINT fk_contact_block_blocker_user_id FOREIGN KEY (blocker_user_id) REFERENCES user(user_id) ON DELETE CASCADE;
ALTER TABLE contact_block ADD CONSTRAINT fk_contact_block_blocked_user_id FOREIGN KEY (blocked_user_id) REFERENCES user(user_id) ON DELETE CASCADE;
ALTER TABLE notification_setting ADD CONSTRAINT fk_notification_setting_user_id FOREIGN KEY (user_id) REFERENCES user(user_id) ON DELETE CASCADE;
ALTER TABLE message ADD CONSTRAINT fk_message_chat_id FOREIGN KEY (chat_id) REFERENCES chat(chat_id) ON DELETE CASCADE;
ALTER TABLE message ADD CONSTRAINT fk_message_parent_message_id FOREIGN KEY (parent_message_id) REFERENCES message(message_id) ON DELETE SET NULL;
ALTER TABLE backup ADD CONSTRAINT fk_backup_chat_id FOREIGN KEY (chat_id) REFERENCES chat(chat_id) ON DELETE CASCADE;
ALTER TABLE group_member ADD CONSTRAINT fk_group_member_group_chat_id FOREIGN KEY (group_chat_id) REFERENCES group_chat(group_chat_id) ON DELETE CASCADE;
ALTER TABLE group_member ADD CONSTRAINT fk_group_member_user_id FOREIGN KEY (user_id) REFERENCES user(user_id) ON DELETE CASCADE;
ALTER TABLE group ADD CONSTRAINT fk_group_community_id FOREIGN KEY (community_id) REFERENCES community(community_id) ON DELETE SET NULL;
ALTER TABLE call_log ADD CONSTRAINT fk_call_log_contact_id FOREIGN KEY (contact_id) REFERENCES contact(contact_id) ON DELETE CASCADE;
ALTER TABLE status_update ADD CONSTRAINT fk_status_update_contact_id FOREIGN KEY (contact_id) REFERENCES contact(contact_id) ON DELETE CASCADE;
ALTER TABLE label ADD CONSTRAINT fk_label_owner_user_id FOREIGN KEY (owner_user_id) REFERENCES whatsapp_user(user_id) ON DELETE CASCADE;
ALTER TABLE quick_reply ADD CONSTRAINT fk_quick_reply_business_profile_id FOREIGN KEY (business_profile_id) REFERENCES business_profile(business_profile_id) ON DELETE CASCADE;
ALTER TABLE auto_message ADD CONSTRAINT fk_auto_message_business_profile_id FOREIGN KEY (business_profile_id) REFERENCES business_profile(business_profile_id) ON DELETE CASCADE;
ALTER TABLE product ADD CONSTRAINT fk_product_business_id FOREIGN KEY (business_id) REFERENCES business(business_id) ON DELETE CASCADE;
ALTER TABLE cart ADD CONSTRAINT fk_cart_business_id FOREIGN KEY (business_id) REFERENCES business(business_id) ON DELETE CASCADE;
ALTER TABLE business_statistic ADD CONSTRAINT fk_business_statistic_business_id FOREIGN KEY (business_id) REFERENCES business(business_id) ON DELETE CASCADE;
ALTER TABLE smart_reply ADD CONSTRAINT fk_smart_reply_ai_assistant_id FOREIGN KEY (ai_assistant_id) REFERENCES ai_assistant(ai_assistant_id) ON DELETE CASCADE;
ALTER TABLE sticker_pack ADD CONSTRAINT fk_sticker_pack_locale_id FOREIGN KEY (locale_id) REFERENCES locale(locale_id) ON DELETE SET NULL;
ALTER TABLE message_media ADD CONSTRAINT fk_message_media_message_id FOREIGN KEY (message_id) REFERENCES message(message_id) ON DELETE CASCADE;
ALTER TABLE message_reaction ADD CONSTRAINT fk_message_reaction_message_id FOREIGN KEY (message_id) REFERENCES message(message_id) ON DELETE CASCADE;
ALTER TABLE message_mention ADD CONSTRAINT fk_message_mention_message_id FOREIGN KEY (message_id) REFERENCES message(message_id) ON DELETE CASCADE;
ALTER TABLE message_mention ADD CONSTRAINT fk_message_mention_mentioned_user_id FOREIGN KEY (mentioned_user_id) REFERENCES user(user_id) ON DELETE CASCADE;
ALTER TABLE media_attachment ADD CONSTRAINT fk_media_attachment_message_id FOREIGN KEY (message_id) REFERENCES message(message_id) ON DELETE CASCADE;
ALTER TABLE report ADD CONSTRAINT fk_report_reporter_user_id FOREIGN KEY (reporter_user_id) REFERENCES user(user_id) ON DELETE CASCADE;
ALTER TABLE report ADD CONSTRAINT fk_report_target_message_id FOREIGN KEY (target_message_id) REFERENCES message(message_id) ON DELETE SET NULL;
ALTER TABLE report ADD CONSTRAINT fk_report_target_user_id FOREIGN KEY (target_user_id) REFERENCES user(user_id) ON DELETE SET NULL;
ALTER TABLE channel ADD CONSTRAINT fk_channel_group_id FOREIGN KEY (group_id) REFERENCES group(group_id) ON DELETE CASCADE;
ALTER TABLE status_reply ADD CONSTRAINT fk_status_reply_status_update_id FOREIGN KEY (status_update_id) REFERENCES status_update(status_update_id) ON DELETE CASCADE;
ALTER TABLE media_item ADD CONSTRAINT fk_media_item_sender_contact_id FOREIGN KEY (sender_contact_id) REFERENCES contact(contact_id) ON DELETE CASCADE;
ALTER TABLE media_item ADD CONSTRAINT fk_media_item_status_update_id FOREIGN KEY (status_update_id) REFERENCES status_update(status_update_id) ON DELETE SET NULL;
ALTER TABLE payment ADD CONSTRAINT fk_payment_cart_id FOREIGN KEY (cart_id) REFERENCES cart(cart_id) ON DELETE CASCADE;
ALTER TABLE sticker_suggestion ADD CONSTRAINT fk_sticker_suggestion_sticker_pack_id FOREIGN KEY (sticker_pack_id) REFERENCES sticker_pack(sticker_pack_id) ON DELETE CASCADE;
ALTER TABLE sticker_suggestion ADD CONSTRAINT fk_sticker_suggestion_locale_id FOREIGN KEY (locale_id) REFERENCES locale(locale_id) ON DELETE SET NULL;

-- ============================================
-- INDEXES
-- ============================================

CREATE INDEX idx_user_user_id ON user(user_id);
CREATE INDEX idx_user_phone_number ON user(phone_number);
CREATE INDEX idx_user_status ON user(status);
CREATE INDEX idx_chat_chat_id ON chat(chat_id);
CREATE INDEX idx_chat_chat_name ON chat(chat_name);
CREATE INDEX idx_chat_is_locked ON chat(is_locked);
CREATE INDEX idx_group_chat_group_chat_id ON group_chat(group_chat_id);
CREATE INDEX idx_group_chat_group_name ON group_chat(group_name);
CREATE INDEX idx_group_chat_invite_link_url ON group_chat(invite_link_url);
CREATE INDEX idx_community_community_id ON community(community_id);
CREATE INDEX idx_community_name ON community(name);
CREATE INDEX idx_poll_poll_id ON poll(poll_id);
CREATE INDEX idx_poll_chat_context_type ON poll(chat_context_type);
CREATE INDEX idx_poll_chat_context_id ON poll(chat_context_id);
CREATE INDEX idx_call_call_id ON call(call_id);
CREATE INDEX idx_call_call_type ON call(call_type);
CREATE INDEX idx_call_is_group_call ON call(is_group_call);
CREATE INDEX idx_call_is_encrypted ON call(is_encrypted);
CREATE INDEX idx_call_scheduled_at ON call(scheduled_at);
CREATE INDEX idx_call_call_link_url ON call(call_link_url);
CREATE INDEX idx_contact_contact_id ON contact(contact_id);
CREATE INDEX idx_contact_display_name ON contact(display_name);
CREATE INDEX idx_contact_phone_number ON contact(phone_number);
CREATE INDEX idx_contact_status_muted ON contact(status_muted);
CREATE INDEX idx_encryption_session_encryption_session_id ON encryption_session(encryption_session_id);
CREATE INDEX idx_encryption_session_chat_id ON encryption_session(chat_id);
CREATE INDEX idx_encryption_session_verification_status ON encryption_session(verification_status);
CREATE INDEX idx_whatsapp_user_user_id ON whatsapp_user(user_id);
CREATE INDEX idx_whatsapp_user_phone_number ON whatsapp_user(phone_number);
CREATE INDEX idx_whatsapp_user_online_status_visibility ON whatsapp_user(online_status_visibility);
CREATE INDEX idx_user_privacy_setting_privacy_setting_id ON user_privacy_setting(privacy_setting_id);
CREATE INDEX idx_user_privacy_setting_user_id ON user_privacy_setting(user_id);
CREATE INDEX idx_user_privacy_setting_profile_photo_visibility ON user_privacy_setting(profile_photo_visibility);
CREATE INDEX idx_user_privacy_setting_status_text_visibility ON user_privacy_setting(status_text_visibility);
CREATE INDEX idx_user_privacy_setting_group_invite_permission ON user_privacy_setting(group_invite_permission);
CREATE INDEX idx_user_appearance_setting_appearance_setting_id ON user_appearance_setting(appearance_setting_id);
CREATE INDEX idx_user_appearance_setting_user_id ON user_appearance_setting(user_id);
CREATE INDEX idx_user_appearance_setting_language_code ON user_appearance_setting(language_code);
CREATE INDEX idx_user_usage_setting_usage_setting_id ON user_usage_setting(usage_setting_id);
CREATE INDEX idx_user_usage_setting_user_id ON user_usage_setting(user_id);
CREATE INDEX idx_user_backup_setting_backup_setting_id ON user_backup_setting(backup_setting_id);
CREATE INDEX idx_user_backup_setting_user_id ON user_backup_setting(user_id);
CREATE INDEX idx_user_backup_setting_last_backup_at ON user_backup_setting(last_backup_at);
CREATE INDEX idx_business_profile_business_profile_id ON business_profile(business_profile_id);
CREATE INDEX idx_business_profile_display_name ON business_profile(display_name);
CREATE INDEX idx_business_profile_verification_status ON business_profile(verification_status);
CREATE INDEX idx_business_business_id ON business(business_id);
CREATE INDEX idx_business_business_name ON business(business_name);
CREATE INDEX idx_integration_feature_integration_feature_id ON integration_feature(integration_feature_id);
CREATE INDEX idx_integration_feature_feature_type ON integration_feature(feature_type);
CREATE INDEX idx_integration_feature_requirement_level ON integration_feature(requirement_level);
CREATE INDEX idx_performance_requirement_performance_requirement_id ON performance_requirement(performance_requirement_id);
CREATE INDEX idx_performance_requirement_metric_type ON performance_requirement(metric_type);
CREATE INDEX idx_performance_requirement_requirement_level ON performance_requirement(requirement_level);
CREATE INDEX idx_ai_assistant_ai_assistant_id ON ai_assistant(ai_assistant_id);
CREATE INDEX idx_ai_assistant_name ON ai_assistant(name);
CREATE INDEX idx_ai_assistant_is_enabled ON ai_assistant(is_enabled);
CREATE INDEX idx_locale_locale_id ON locale(locale_id);
CREATE INDEX idx_locale_locale_code ON locale(locale_code);
CREATE INDEX idx_locale_rtl_supported ON locale(rtl_supported);
CREATE INDEX idx_user_profile_profile_id ON user_profile(profile_id);
CREATE INDEX idx_user_profile_user_id ON user_profile(user_id);
CREATE INDEX idx_user_profile_display_name ON user_profile(display_name);
CREATE INDEX idx_user_profile_qr_code_value ON user_profile(qr_code_value);
CREATE INDEX idx_user_device_device_id ON user_device(device_id);
CREATE INDEX idx_user_device_user_id ON user_device(user_id);
CREATE INDEX idx_user_device_device_platform ON user_device(device_platform);
CREATE INDEX idx_auth_credential_credential_id ON auth_credential(credential_id);
CREATE INDEX idx_auth_credential_user_id ON auth_credential(user_id);
CREATE INDEX idx_auth_credential_credential_type ON auth_credential(credential_type);
CREATE INDEX idx_auth_credential_is_enabled ON auth_credential(is_enabled);
CREATE INDEX idx_contact_block_block_id ON contact_block(block_id);
CREATE INDEX idx_contact_block_blocker_user_id ON contact_block(blocker_user_id);
CREATE INDEX idx_contact_block_blocked_user_id ON contact_block(blocked_user_id);
CREATE INDEX idx_notification_setting_notification_setting_id ON notification_setting(notification_setting_id);
CREATE INDEX idx_notification_setting_user_id ON notification_setting(user_id);
CREATE INDEX idx_notification_setting_push_enabled ON notification_setting(push_enabled);
CREATE INDEX idx_notification_setting_do_not_disturb_enabled ON notification_setting(do_not_disturb_enabled);
CREATE INDEX idx_notification_setting_call_notification_mode ON notification_setting(call_notification_mode);
CREATE INDEX idx_notification_setting_created_at ON notification_setting(created_at);
CREATE INDEX idx_message_message_id ON message(message_id);
CREATE INDEX idx_message_chat_id ON message(chat_id);
CREATE INDEX idx_message_sender_user_id ON message(sender_user_id);
CREATE INDEX idx_message_message_type ON message(message_type);
CREATE INDEX idx_message_parent_message_id ON message(parent_message_id);
CREATE INDEX idx_message_is_forwarded ON message(is_forwarded);
CREATE INDEX idx_message_is_deleted ON message(is_deleted);
CREATE INDEX idx_message_is_edited ON message(is_edited);
CREATE INDEX idx_message_expires_at ON message(expires_at);
CREATE INDEX idx_backup_backup_id ON backup(backup_id);
CREATE INDEX idx_backup_chat_id ON backup(chat_id);
CREATE INDEX idx_backup_is_end_to_end_encrypted ON backup(is_end_to_end_encrypted);
CREATE INDEX idx_group_member_group_member_id ON group_member(group_member_id);
CREATE INDEX idx_group_member_group_chat_id ON group_member(group_chat_id);
CREATE INDEX idx_group_member_user_id ON group_member(user_id);
CREATE INDEX idx_group_member_role ON group_member(role);
CREATE INDEX idx_group_group_id ON group(group_id);
CREATE INDEX idx_group_community_id ON group(community_id);
CREATE INDEX idx_group_name ON group(name);
CREATE INDEX idx_call_log_call_log_id ON call_log(call_log_id);
CREATE INDEX idx_call_log_contact_id ON call_log(contact_id);
CREATE INDEX idx_call_log_started_at ON call_log(started_at);
CREATE INDEX idx_status_update_status_update_id ON status_update(status_update_id);
CREATE INDEX idx_status_update_contact_id ON status_update(contact_id);
CREATE INDEX idx_status_update_expires_at ON status_update(expires_at);
CREATE INDEX idx_status_update_visibility ON status_update(visibility);
CREATE INDEX idx_label_label_id ON label(label_id);
CREATE INDEX idx_label_owner_user_id ON label(owner_user_id);
CREATE INDEX idx_label_label_name ON label(label_name);
CREATE INDEX idx_quick_reply_quick_reply_id ON quick_reply(quick_reply_id);
CREATE INDEX idx_quick_reply_business_profile_id ON quick_reply(business_profile_id);
CREATE INDEX idx_quick_reply_shortcut ON quick_reply(shortcut);
CREATE INDEX idx_auto_message_auto_message_id ON auto_message(auto_message_id);
CREATE INDEX idx_auto_message_business_profile_id ON auto_message(business_profile_id);
CREATE INDEX idx_auto_message_message_type ON auto_message(message_type);
CREATE INDEX idx_auto_message_is_active ON auto_message(is_active);
CREATE INDEX idx_product_product_id ON product(product_id);
CREATE INDEX idx_product_business_id ON product(business_id);
CREATE INDEX idx_product_product_name ON product(product_name);
CREATE INDEX idx_product_currency_code ON product(currency_code);
CREATE INDEX idx_cart_cart_id ON cart(cart_id);
CREATE INDEX idx_cart_business_id ON cart(business_id);
CREATE INDEX idx_cart_status ON cart(status);
CREATE INDEX idx_cart_currency_code ON cart(currency_code);
CREATE INDEX idx_business_statistic_stat_id ON business_statistic(stat_id);
CREATE INDEX idx_business_statistic_business_id ON business_statistic(business_id);
CREATE INDEX idx_business_statistic_period_start ON business_statistic(period_start);
CREATE INDEX idx_business_statistic_period_end ON business_statistic(period_end);
CREATE INDEX idx_smart_reply_smart_reply_id ON smart_reply(smart_reply_id);
CREATE INDEX idx_smart_reply_ai_assistant_id ON smart_reply(ai_assistant_id);
CREATE INDEX idx_smart_reply_language_code ON smart_reply(language_code);
CREATE INDEX idx_smart_reply_context_key ON smart_reply(context_key);
CREATE INDEX idx_sticker_pack_sticker_pack_id ON sticker_pack(sticker_pack_id);
CREATE INDEX idx_sticker_pack_locale_id ON sticker_pack(locale_id);
CREATE INDEX idx_sticker_pack_name ON sticker_pack(name);
CREATE INDEX idx_sticker_pack_is_active ON sticker_pack(is_active);
CREATE INDEX idx_message_media_media_id ON message_media(media_id);
CREATE INDEX idx_message_media_message_id ON message_media(message_id);
CREATE INDEX idx_message_media_media_type ON message_media(media_type);
CREATE INDEX idx_message_media_is_view_once ON message_media(is_view_once);
CREATE INDEX idx_message_reaction_reaction_id ON message_reaction(reaction_id);
CREATE INDEX idx_message_reaction_message_id ON message_reaction(message_id);
CREATE INDEX idx_message_reaction_reacting_user_id ON message_reaction(reacting_user_id);
CREATE INDEX idx_message_mention_mention_id ON message_mention(mention_id);
CREATE INDEX idx_message_mention_message_id ON message_mention(message_id);
CREATE INDEX idx_message_mention_mentioned_user_id ON message_mention(mentioned_user_id);
CREATE INDEX idx_media_attachment_attachment_id ON media_attachment(attachment_id);
CREATE INDEX idx_media_attachment_message_id ON media_attachment(message_id);
CREATE INDEX idx_media_attachment_media_type ON media_attachment(media_type);
CREATE INDEX idx_media_attachment_source_library ON media_attachment(source_library);
CREATE INDEX idx_media_attachment_is_hd ON media_attachment(is_hd);
CREATE INDEX idx_report_report_id ON report(report_id);
CREATE INDEX idx_report_reporter_user_id ON report(reporter_user_id);
CREATE INDEX idx_report_target_message_id ON report(target_message_id);
CREATE INDEX idx_report_target_user_id ON report(target_user_id);
CREATE INDEX idx_report_status ON report(status);
CREATE INDEX idx_report_created_at ON report(created_at);
CREATE INDEX idx_channel_channel_id ON channel(channel_id);
CREATE INDEX idx_channel_group_id ON channel(group_id);
CREATE INDEX idx_channel_name ON channel(name);
CREATE INDEX idx_status_reply_status_reply_id ON status_reply(status_reply_id);
CREATE INDEX idx_status_reply_status_update_id ON status_reply(status_update_id);
CREATE INDEX idx_media_item_media_item_id ON media_item(media_item_id);
CREATE INDEX idx_media_item_sender_contact_id ON media_item(sender_contact_id);
CREATE INDEX idx_media_item_status_update_id ON media_item(status_update_id);
CREATE INDEX idx_media_item_media_type ON media_item(media_type);
CREATE INDEX idx_media_item_edited_flag ON media_item(edited_flag);
CREATE INDEX idx_payment_payment_id ON payment(payment_id);
CREATE INDEX idx_payment_cart_id ON payment(cart_id);
CREATE INDEX idx_payment_payment_status ON payment(payment_status);
CREATE INDEX idx_payment_currency_code ON payment(currency_code);
CREATE INDEX idx_payment_market_code ON payment(market_code);
CREATE INDEX idx_sticker_suggestion_sticker_suggestion_id ON sticker_suggestion(sticker_suggestion_id);
CREATE INDEX idx_sticker_suggestion_sticker_pack_id ON sticker_suggestion(sticker_pack_id);
CREATE INDEX idx_sticker_suggestion_locale_id ON sticker_suggestion(locale_id);
CREATE INDEX idx_sticker_suggestion_context_keyword ON sticker_suggestion(context_keyword);
CREATE INDEX idx_sticker_suggestion_confidence_score ON sticker_suggestion(confidence_score);
