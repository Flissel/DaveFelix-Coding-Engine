@smoke @regression
Feature: Broadcast-Listen
  As a messaging administrator
  I want to create and use a broadcast list to send a mass message to multiple recipients
  So that to efficiently communicate the same information to many recipients at once

  Background:
    Given the messaging administrator is authenticated and on the broadcast list management page

  @happy-path @@smoke @@regression
  Scenario: Send a message to a broadcast list with multiple valid recipients
    # Validates successful delivery to all recipients in the list
    Given the administrator has selected multiple valid recipients
    When the administrator creates a broadcast list and sends a message
    Then the system delivers the message to all recipients in the list
    And the system records the broadcast as successfully sent

  @error @@negative @@regression
  Scenario: Create a broadcast list with no recipients
    # Ensures validation error is shown when saving an empty list
    Given no recipients are selected
    When the administrator attempts to save the broadcast list
    Then the system rejects the action
    And a validation error indicating at least one recipient is required is displayed

  @edge @@regression
  Scenario: Send a message to a list containing invalid or unreachable recipients
    # Verifies delivery to valid recipients and reporting of failed recipients
    Given the administrator has a broadcast list with valid and invalid or unreachable recipients
    When the administrator sends a message to the broadcast list
    Then the system delivers the message to all valid recipients
    And the system reports the failed recipient or recipients

  @boundary @@regression
  Scenario Outline: Broadcast list boundary size validation
    # Validates list creation and sending at minimum and maximum allowed recipient counts
    Given the administrator selects <recipient_count> valid recipients
    When the administrator creates a broadcast list and sends a message
    Then the system processes the request according to the allowed limits
    And the system indicates <expected_outcome>

    Examples:
      | recipient_count | expected_outcome |
      | 1 | the message is delivered to the single recipient |
      | MAX_ALLOWED | the message is delivered to all recipients |
      | MAX_ALLOWED+1 | a validation error indicates the maximum recipient limit was exceeded |
