@smoke @regression
Feature: Chat exportieren
  As a chat user
  I want to export a single chat conversation
  So that to archive or share the conversation for documentation and compliance

  Background:
    Given the chat export feature is available

  @happy-path @smoke @regression
  Scenario Outline: Export a chat successfully in supported formats
    # Verifies a user with access can export a chat in supported formats
    Given a chat user has access to the chat "<chat_id>"
    And the chat "<chat_id>" contains multiple messages and attachments
    When the user exports the chat in format "<format>"
    Then the system provides a downloadable export for chat "<chat_id>"
    And the export includes all messages, attachments, and metadata

    Examples:
      | chat_id | format |
      | CHAT-1001 | PDF |
      | CHAT-1001 | JSON |

  @edge-case @regression
  Scenario Outline: Export chat with minimal content
    # Verifies export works for a chat with a single message and no attachments
    Given a chat user has access to the chat "<chat_id>"
    And the chat "<chat_id>" contains exactly one message and no attachments
    When the user exports the chat in format "<format>"
    Then the system provides a downloadable export for chat "<chat_id>"
    And the export contains the single message and associated metadata

    Examples:
      | chat_id | format |
      | CHAT-2001 | PDF |

  @negative @regression
  Scenario Outline: Deny export when user lacks permission
    # Verifies authorization error is shown when the user lacks access
    Given a chat user does not have access to the chat "<chat_id>"
    When the user attempts to export the chat in format "<format>"
    Then the system denies the export
    And an authorization error is displayed

    Examples:
      | chat_id | format |
      | CHAT-3001 | JSON |

  @boundary @regression
  Scenario Outline: Export boundary condition with large number of messages
    # Verifies export handles a chat at the upper message count limit
    Given a chat user has access to the chat "<chat_id>"
    And the chat "<chat_id>" contains "<message_count>" messages and "<attachment_count>" attachments
    When the user exports the chat in format "<format>"
    Then the system provides a downloadable export for chat "<chat_id>"
    And the export includes all messages, attachments, and metadata

    Examples:
      | chat_id | message_count | attachment_count | format |
      | CHAT-4001 | 1000 | 50 | JSON |
