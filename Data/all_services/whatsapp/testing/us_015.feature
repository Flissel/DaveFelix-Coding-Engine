@smoke @regression
Feature: Nachricht weiterleiten
  As a registered user
  I want to forward an existing message to one or more recipients
  So that so that I can quickly share relevant information without retyping

  Background:
    Given a registered user is logged in
    And the user is viewing a received message

  @smoke @happy-path @regression
  Scenario: Forward a message to a single valid recipient
    # Validates successful forwarding and sent items metadata
    When the user selects the forward option
    And the user enters a valid recipient
    And the user sends the message
    Then the message is sent successfully
    And the forwarded message appears in the sender's sent items with forwarding metadata

  @regression @happy-path
  Scenario: Forward a message to multiple valid recipients
    # Ensures delivery to all specified recipients
    When the user selects the forward option
    And the user adds multiple valid recipients
    And the user sends the message
    Then the message is delivered to all specified recipients
    And the forwarded message appears in the sender's sent items with forwarding metadata

  @negative @regression
  Scenario: Prevent forwarding to an invalid or non-existent recipient
    # Validates recipient validation and error handling
    When the user selects the forward option
    And the user enters an invalid or non-existent recipient
    And the user attempts to send the message
    Then the system prevents sending
    And a validation error is displayed

  @edge @regression
  Scenario Outline: Forward message with recipient boundary limits
    # Validates behavior at minimum and maximum recipient count
    When the user selects the forward option
    And the user adds recipients count as "<recipient_count>"
    And the user sends the message
    Then the system should "<expected_result>"
    And the system displays "<message>"

    Examples:
      | recipient_count | expected_result | message |
      | 1 | send the message successfully | the message appears in sent items with forwarding metadata |
      | maximum allowed | send the message successfully | the message appears in sent items with forwarding metadata |

  @negative @edge @regression
  Scenario Outline: Forward message with mixed valid and invalid recipients
    # Ensures sending is blocked when any recipient is invalid
    When the user selects the forward option
    And the user enters recipients including "<invalid_recipient>"
    And the user attempts to send the message
    Then the system prevents sending
    And a validation error is displayed for the invalid recipient

    Examples:
      | invalid_recipient |
      | nonexistent@example.com |
      | invalid_format |
