@@smoke @@regression
Feature: Unbekannte Absender
  As a communications administrator
  I want to segregate messages from unknown senders
  So that so that they can be reviewed and handled appropriately without affecting standard processing

  Background:
    Given the known sender list contains valid sender identifiers

  @@smoke @@happy-path @@regression
  Scenario: Route known sender through standard processing
    # Valid known sender is processed normally and not marked unknown
    Given an incoming message from sender "KNOWN_001"
    When the system processes the message
    Then the message is routed through the standard processing flow
    And the message is not marked as unknown

  @@regression @@negative
  Scenario: Segregate unknown sender to separate queue
    # Unknown sender is marked and routed to the unknown handling queue
    Given an incoming message from sender "UNKNOWN_999"
    When the system processes the message
    Then the message is marked as unknown
    And the message is routed to the separate handling queue

  @@regression @@negative @@edge-case
  Scenario Outline: Treat missing or malformed sender information as unknown
    # Messages without valid sender data are handled as unknown
    Given an incoming message with sender information "<sender_info>"
    When the system processes the message
    Then the message is treated as from an unknown sender
    And the message is routed to the separate handling queue

    Examples:
      | sender_info |
      |  |
      |     |
      | malformed@@sender |
      | None |

  @@regression @@edge-case
  Scenario Outline: Sender identifier with boundary length is matched correctly
    # Boundary length sender identifiers are matched against the known list
    Given the known sender list contains sender identifier "<known_sender>"
    And an incoming message from sender "<incoming_sender>"
    When the system processes the message
    Then the message is routed through the standard processing flow
    And the message is not marked as unknown

    Examples:
      | known_sender | incoming_sender |
      | A | A |
      | SENDER_1234567890 | SENDER_1234567890 |

  @@regression @@negative @@edge-case
  Scenario: Unknown sender when known list is empty
    # All incoming messages are treated as unknown when there are no known senders configured
    Given the known sender list is empty
    And an incoming message from sender "ANY_SENDER"
    When the system processes the message
    Then the message is marked as unknown
    And the message is routed to the separate handling queue
