@@smoke @@regression
Feature: Share content via system share sheet
  As a end user
  I want to share content from the app using the device's system share sheet
  So that to quickly distribute information through installed apps without leaving the app

  Background:
    Given the user is logged in and viewing shareable content in the app

  @@smoke @@regression @@happy-path
  Scenario: Open share sheet and share successfully
    # Validates successful share flow to a selected app
    Given the device has at least one compatible share target installed
    When the user taps the Share option
    Then the system opens the native share sheet with relevant targets
    When the user selects a target app and confirms sharing
    Then the content is passed to the selected app
    And a success confirmation is shown in the app

  @@regression @@happy-path
  Scenario Outline: Share to different target apps
    # Ensures content is passed correctly to multiple compatible targets
    Given the device has compatible share targets installed
    When the user taps the Share option
    Then the system opens the native share sheet with relevant targets
    When the user selects "<target_app>" and confirms sharing
    Then the content is passed to "<target_app>"
    And a success confirmation is shown in the app

    Examples:
      | target_app |
      | Messages |
      | Email |
      | Notes |

  @@regression @@negative @@edge-case
  Scenario: No compatible share targets available
    # Handles edge case where the device has no share targets
    Given the device has no compatible share targets installed
    When the user taps the Share option
    Then the system displays a message indicating no share options are available

  @@regression @@negative @@error
  Scenario: Share fails due to system error and user retries
    # Validates error handling and retry behavior on share failure
    Given the device has at least one compatible share target installed
    And the system share service returns an error
    When the user taps the Share option
    Then the app shows an error message
    And the app allows the user to retry sharing

  @@regression @@boundary
  Scenario: Boundary: share sheet opens with minimal target list
    # Ensures behavior when only one compatible share target is available
    Given the device has exactly one compatible share target installed
    When the user taps the Share option
    Then the system opens the native share sheet showing only the single target
