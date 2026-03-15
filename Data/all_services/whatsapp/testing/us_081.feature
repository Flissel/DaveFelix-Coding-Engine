@@smoke @@regression
Feature: Read Receipt Configuration
  As a system administrator
  I want to configure read receipts for messages
  So that ensure compliance and provide auditability of message delivery and acknowledgment

  Background:
    Given the administrator is authenticated and has access to system settings

  @@smoke @@regression @@happy-path
  Scenario: Enable read receipts and apply to new messages
    # Happy path for enabling read receipts and applying to new messages
    Given the administrator is on the read receipt configuration page
    When they enable read receipts and save the settings
    Then the system persists the configuration
    And new messages are created with read receipts enabled

  @@regression @@happy-path
  Scenario: Read confirmation is visible to sender when enabled
    # Happy path for read confirmation generation after recipient reads a message
    Given read receipts are enabled
    And a sender has sent a message to a recipient
    When the recipient reads the message
    Then the sender can view a read confirmation for that message

  @@regression @@edge
  Scenario: No read confirmation when disabled
    # Edge case for disabled read receipts ensuring no confirmation is produced
    Given read receipts are disabled
    And a sender has sent a message to a recipient
    When the recipient reads the message
    Then no read confirmation is generated
    And the sender cannot view any read confirmation for that message

  @@regression @@negative
  Scenario: Reject invalid configuration values
    # Error scenario for invalid configuration submission
    Given the administrator is on the read receipt configuration page
    When they submit an invalid configuration value and save the settings
    Then the system rejects the change
    And a validation error is displayed

  @@regression @@edge
  Scenario: Toggle read receipts multiple times before saving
    # Boundary condition for multiple changes in a single session
    Given the administrator is on the read receipt configuration page
    When they toggle read receipts on and off multiple times and then save the settings with the final state set to enabled
    Then the system persists the final configuration state only
    And new messages reflect the final read receipt setting

  @@regression @@negative
  Scenario Outline: Scenario Outline: Validate configuration input types
    # Data-driven validation for configuration values
    Given the administrator is on the read receipt configuration page
    When they enter <invalid_value> for the read receipt setting and save
    Then the system rejects the change
    And a validation error <error_message> is displayed

    Examples:
      | invalid_value | error_message |
      | null | Value is required |
      | "" | Value is required |
      | 123 | Invalid boolean value |
      | "enable" | Invalid boolean value |

  @@regression @@edge
  Scenario Outline: Scenario Outline: Read receipt application only for messages created after enabling
    # Boundary condition for messages created before and after enabling read receipts
    Given read receipts are <state> at the time the message is created
    And a sender has sent a message to a recipient
    When the recipient reads the message
    Then the sender <confirmation_visibility> a read confirmation for that message

    Examples:
      | state | confirmation_visibility |
      | enabled | can view |
      | disabled | cannot view |
