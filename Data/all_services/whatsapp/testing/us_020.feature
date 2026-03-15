@smoke @regression
Feature: Chat sperren
  As a authenticated user
  I want to lock an individual chat with additional authentication
  So that to prevent unauthorized access to sensitive conversations

  Background:
    Given the user is authenticated and has access to at least one chat
    And additional authentication is configured for the user account

  @@smoke @@regression @@happy-path
  Scenario: Lock a chat successfully with additional authentication
    # Verifies the happy path where a chat is locked after successful additional authentication
    Given the user is viewing an unlocked chat
    When the user selects the lock option
    And the user successfully completes additional authentication
    Then the chat is marked as locked
    And opening the chat requires additional authentication

  @@regression @@negative
  Scenario: Access is denied when opening a locked chat without authentication
    # Validates that access is blocked until additional authentication is completed
    Given a chat is locked
    When the user attempts to open the locked chat without completing additional authentication
    Then access is denied
    And the user is prompted to authenticate

  @@regression @@negative
  Scenario Outline: Lock process fails or is cancelled
    # Ensures the chat remains unlocked when additional authentication is not completed
    Given the user is viewing an unlocked chat
    When the user initiates the lock process
    And additional authentication is <auth_outcome>
    Then the chat remains unlocked
    And <message_type> message is displayed

    Examples:
      | auth_outcome | message_type |
      | failed | an error |
      | cancelled | a cancellation |

  @@regression @@boundary
  Scenario Outline: Multiple access attempts to a locked chat require authentication each time
    # Checks boundary condition for repeated access attempts to a locked chat
    Given a chat is locked
    When the user attempts to open the locked chat <attempt_count> times without authenticating
    Then access is denied for each attempt
    And the user is prompted to authenticate each time

    Examples:
      | attempt_count |
      | 1 |
      | 3 |
