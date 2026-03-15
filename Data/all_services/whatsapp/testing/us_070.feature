@smoke @regression
Feature: Anrufbenachrichtigungen
  As a end user
  I want to configure separate call notification settings
  So that to control how and when I am alerted about calls according to my preferences

  Background:
    Given the user is authenticated and on the notification settings page

  @@smoke @@regression @@happy-path
  Scenario: Enable call notifications and save
    # Verifies call notifications are saved separately and activated
    Given call notifications are currently disabled
    When the user sets call notifications to enabled and saves
    Then call notification settings are stored separately from other notification types
    And call notifications are active

  @@regression @@negative
  Scenario: Incoming call when call notifications are disabled
    # Ensures disabled call notifications do not generate alerts while other types remain unaffected
    Given call notifications are disabled and message notifications are enabled
    When an incoming call occurs
    Then no call notification is generated
    And message notification settings remain enabled

  @@regression @@happy-path
  Scenario: Update non-call notifications only
    # Validates call settings remain unchanged when only other notifications are updated
    Given call notifications are enabled and email notifications are enabled
    When the user disables email notifications and saves
    Then call notification settings remain enabled
    And email notification settings are disabled

  @@regression @@edge
  Scenario: Save with no changes to call notifications
    # Edge case where saving without modifying call settings keeps state unchanged
    Given call notifications are enabled
    When the user saves notification settings without changing call notifications
    Then call notification settings remain enabled

  @@regression @@negative
  Scenario: Attempt to save call notifications with invalid state
    # Error scenario when save fails due to a system error
    Given call notifications are enabled
    When the user saves and a system error occurs
    Then an error message is displayed
    And call notification settings are not changed in storage

  @@regression @@boundary
  Scenario Outline: Toggle call notifications multiple times before save
    # Boundary condition ensuring final toggle state is saved
    Given call notifications are disabled
    When the user toggles call notifications <toggle_count> times and saves
    Then call notifications are <final_state>

    Examples:
      | toggle_count | final_state |
      | 1 | enabled |
      | 2 | disabled |
      | 3 | enabled |
