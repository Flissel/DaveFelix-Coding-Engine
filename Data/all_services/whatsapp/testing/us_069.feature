@smoke @regression
Feature: Reaktionsbenachrichtigungen
  As a message sender
  I want to receive notifications when others react to my messages
  So that to stay informed about engagement without manually checking conversations

  Background:
    Given a conversation exists between Sender and Recipient
    And Sender has sent at least one message in the conversation

  @happy-path @smoke @regression
  Scenario: Receive notification when another user reacts to my message
    # Verifies notification is delivered with reaction and related message
    Given Sender has reaction notifications enabled
    And Recipient can view Sender's message
    When Recipient reacts to Sender's message with a valid reaction
    Then Sender receives a notification indicating the reaction
    And the notification references the message that was reacted to

  @happy-path @regression
  Scenario: Separate notifications for reactions to multiple messages
    # Ensures each reacted message generates its own notification
    Given Sender has two distinct messages in the same conversation
    And Sender has reaction notifications enabled
    When Recipient reacts to both messages
    Then Sender receives separate notifications for each message
    And each notification references the correct message

  @negative @regression
  Scenario: No notification when reaction notifications are disabled
    # Validates preference disables reaction notifications
    Given Sender has disabled reaction notifications in preferences
    When Recipient reacts to Sender's message
    Then no reaction notification is sent to Sender

  @edge @regression
  Scenario: Boundary: multiple reactions in quick succession to different messages
    # Ensures notifications are generated for each distinct message reacted to in rapid sequence
    Given Sender has reaction notifications enabled
    And Sender has sent multiple messages in the conversation
    When Recipient reacts to multiple messages within a short time window
    Then Sender receives a notification for each distinct message reacted to

  @negative @regression
  Scenario: Error: reaction event fails to process
    # Validates system behavior when reaction event processing fails
    Given Sender has reaction notifications enabled
    When Recipient's reaction event fails to be processed by the notification service
    Then no notification is sent to Sender
    And the failure is logged for retry or monitoring

  @happy-path @regression
  Scenario Outline: Scenario Outline: notification content for different reaction types
    # Ensures notification displays correct reaction for various reaction types
    Given Sender has reaction notifications enabled
    When Recipient reacts to Sender's message with <reaction_type>
    Then Sender receives a notification showing reaction <reaction_type>
    And the notification references the reacted message

    Examples:
      | reaction_type |
      | like |
      | love |
      | laugh |

  @edge @regression
  Scenario Outline: Scenario Outline: preference toggle boundary for notification delivery
    # Validates notifications based on preference state
    Given Sender has reaction notifications set to <preference_state>
    When Recipient reacts to Sender's message
    Then notification delivery is <expected_result>

    Examples:
      | preference_state | expected_result |
      | enabled | allowed |
      | disabled | suppressed |
