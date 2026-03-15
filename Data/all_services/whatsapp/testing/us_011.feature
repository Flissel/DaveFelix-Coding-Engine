@@smoke @@regression
Feature: Textnachricht senden
  As a registered user
  I want to send a text message in real time to another user
  So that to communicate instantly and keep conversations timely

  Background:
    Given the user is authenticated
    And the user has an active conversation open with another user

  @@smoke @@regression @@happy-path
  Scenario: Send a valid message in real time
    # Verifies real-time delivery and display for both users
    Given the recipient is online
    When the user enters a non-empty message "Hello" and taps send
    Then the message is delivered to the recipient in real time
    And the message is displayed in both users' conversation views

  @@regression @@negative @@edge
  Scenario Outline: Prevent sending empty or whitespace-only messages
    # Ensures validation blocks invalid message content
    When the user enters <invalid_message> and taps send
    Then the system prevents sending the message
    And a validation prompt is shown to the user

    Examples:
      | invalid_message |
      | "" |
      | "   " |

  @@regression @@edge
  Scenario: Queue message when recipient is offline
    # Verifies queued delivery and sender status when recipient is offline
    Given the recipient is offline
    When the user sends a valid message "Are you there?"
    Then the message is queued for delivery
    And the sender sees a sent status

  @@regression @@negative @@error
  Scenario: Handle network drop during send with retry option
    # Ensures error handling and retry capability on send failure
    Given the network connection drops during send
    When the user attempts to send a valid message "Test message"
    Then the system shows an error
    And the user is allowed to retry sending the message

  @@regression @@boundary
  Scenario Outline: Send boundary length messages
    # Validates sending messages at boundary lengths
    Given the recipient is online
    When the user sends a message with length <length_description>
    Then the message is delivered in real time
    And the message is displayed in both users' conversation views

    Examples:
      | length_description |
      | 1 character |
      | the maximum allowed length |
