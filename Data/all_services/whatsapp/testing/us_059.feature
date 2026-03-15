@@smoke @@regression
Feature: Nachrichtensperre
  As a app user
  I want to lock the app and require authentication to access messages
  So that to protect my messages from unauthorized access

  Background:
    Given the user has an existing account with messages

  @@smoke @@regression @@happy-path
  Scenario: Unlock app with valid authentication
    # Verifies that a locked app prompts for authentication and unlocks with valid credentials
    Given the user has enabled app lock
    When the user opens the app
    Then the app prompts for authentication before showing any messages
    When the user provides valid authentication
    Then the app unlocks and displays the message list

  @@regression @@negative
  Scenario: Reject invalid authentication attempts
    # Ensures the app remains locked and messages are not displayed on invalid credentials
    Given the user has enabled app lock
    And the app is locked
    When the user provides invalid authentication
    Then the app remains locked
    And no messages are displayed

  @@regression @@boundary
  Scenario Outline: Scenario Outline: Handle boundary lengths for PIN authentication
    # Validates boundary conditions for PIN length and unlock behavior
    Given the user has enabled app lock with PIN authentication
    And the app is locked
    When the user enters a PIN with length <pin_length>
    Then the app authentication result is <auth_result>
    And the message list visibility is <message_visibility>

    Examples:
      | pin_length | auth_result | message_visibility |
      | 3 | rejected due to invalid length | hidden |
      | 4 | accepted when PIN matches | visible |
      | 6 | accepted when PIN matches | visible |
      | 7 | rejected due to invalid length | hidden |

  @@regression @@edge
  Scenario Outline: Scenario Outline: Authentication prompt appears on app open when lock is enabled
    # Covers edge cases where the app is opened in different states and must prompt before messages
    Given the user has enabled app lock
    And the app state is <app_state>
    When the user opens the app
    Then the app prompts for authentication before showing any messages
    And no messages are displayed until authentication succeeds

    Examples:
      | app_state |
      | cold start |
      | resumed from background |
