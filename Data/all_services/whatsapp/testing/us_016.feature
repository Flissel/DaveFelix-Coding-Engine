@@smoke @@regression
Feature: Quote a message in chat
  As a chat user
  I want to quote a specific message when replying in a chat
  So that to provide clear context and improve conversation clarity

  Background:
    Given a chat thread exists with messages from multiple participants

  @@smoke @@regression @@happy-path
  Scenario Outline: Quote a message when replying
    # Verify a quoted reply includes the selected message reference
    Given the user is viewing the chat thread
    When the user selects message "<message_text>" from sender "<sender>" and chooses to reply with quote
    Then the reply input includes a quoted reference to "<message_text>"
    And the quoted reference displays the original sender as "<sender>"

    Examples:
      | message_text | sender |
      | Please review the latest draft. | Alex |
      | Meeting starts at 10 AM. | Priya |

  @@regression @@happy-path
  Scenario Outline: View quoted message content and sender
    # Verify other participants can see quoted content and original sender after sending
    Given a quoted reply is sent referencing message "<message_text>" from sender "<sender>"
    When another participant opens the chat thread
    Then the quoted block shows the content "<message_text>"
    And the quoted block shows the original sender "<sender>"

    Examples:
      | message_text | sender |
      | Can you send the report? | Lina |

  @@regression @@negative @@error
  Scenario Outline: Prevent quoting a deleted message
    # Ensure system blocks quoting when the original message is unavailable
    Given message "<message_text>" from sender "<sender>" has been deleted
    When the user attempts to quote the deleted message
    Then the system informs the user that the message cannot be quoted
    And the user is prevented from sending a quoted reply

    Examples:
      | message_text | sender |
      | This message will be removed. | Mark |

  @@regression @@boundary
  Scenario Outline: Quote message with maximum length content
    # Validate quoting works for boundary message length
    Given a message exists with length "<length>" characters
    When the user quotes the message and sends a reply
    Then the quoted reference preserves the full original content
    And the reply is sent successfully

    Examples:
      | length |
      | 1 |
      | 1000 |

  @@regression @@negative @@edge
  Scenario: Attempt to quote from an empty thread
    # Handle edge case when no messages exist to quote
    Given the chat thread has no messages
    When the user opens the reply options
    Then no quote action is available
    And the user cannot select a message to quote
