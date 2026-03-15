@@smoke @@regression
Feature: Do Not Disturb Mode
  As a end user
  I want to activate and deactivate a Do Not Disturb mode
  So that to avoid interruptions and focus on tasks without unwanted notifications

  Background:
    Given the user is logged in and notification settings are available

  @@smoke @@regression @@happy-path
  Scenario: Enable Do Not Disturb suppresses notifications
    # Verifies enabling Do Not Disturb stops notifications and shows active indicator
    When the user enables Do Not Disturb mode
    Then the system indicates that Do Not Disturb is active
    And notifications are suppressed for the user

  @@smoke @@regression @@happy-path
  Scenario: Disable Do Not Disturb resumes notifications
    # Verifies disabling Do Not Disturb resumes notifications and shows inactive indicator
    Given Do Not Disturb mode is active
    When the user disables Do Not Disturb mode
    Then the system indicates that Do Not Disturb is inactive
    And normal notifications are resumed

  @@regression @@happy-path
  Scenario: Notification is not delivered while Do Not Disturb is active
    # Ensures notifications are not delivered when Do Not Disturb is active
    Given Do Not Disturb mode is active
    When a notification would normally be sent
    Then the notification is not delivered to the user

  @@regression @@edge
  Scenario: Enable Do Not Disturb when already active
    # Edge case where user tries to enable Do Not Disturb while it is already active
    Given Do Not Disturb mode is active
    When the user enables Do Not Disturb mode again
    Then the system keeps Do Not Disturb active without error
    And notifications remain suppressed

  @@regression @@edge
  Scenario: Disable Do Not Disturb when already inactive
    # Edge case where user tries to disable Do Not Disturb while it is already inactive
    Given Do Not Disturb mode is inactive
    When the user disables Do Not Disturb mode again
    Then the system keeps Do Not Disturb inactive without error
    And normal notifications remain enabled

  @@regression @@negative
  Scenario: Enable Do Not Disturb fails when settings are unavailable
    # Error scenario when notification settings cannot be accessed
    Given notification settings are unavailable
    When the user attempts to enable Do Not Disturb mode
    Then the system shows an error message indicating the action cannot be completed
    And Do Not Disturb remains inactive

  @@regression @@boundary
  Scenario Outline: Notification suppression boundary for multiple notification types
    # Boundary condition to verify all notification types are suppressed while Do Not Disturb is active
    Given Do Not Disturb mode is active
    When a <notification_type> notification would normally be sent
    Then the <notification_type> notification is not delivered to the user

    Examples:
      | notification_type |
      | email |
      | push |
      | in-app |

  @@regression @@boundary
  Scenario Outline: Toggle Do Not Disturb across rapid changes
    # Boundary condition to ensure final state and notification behavior reflect the last action
    When the user performs the sequence <action_sequence>
    Then Do Not Disturb is <final_state>
    And notifications are <notification_behavior>

    Examples:
      | action_sequence | final_state | notification_behavior |
      | enable then disable | inactive | resumed |
      | disable then enable | active | suppressed |
