@smoke @regression
Feature: Schneller App-Start
  As a mobile app user
  I want to open the app and reach the home screen quickly
  So that so that I can start using the app without delay and stay satisfied

  Background:
    Given the device is a typical supported device with stable OS

  @@smoke @@regression @@happy-path
  Scenario: Cold start reaches home screen within 2 seconds
    # Validates cold start performance on typical device
    Given the app is not running
    When the user taps the app icon
    Then the home screen is displayed within 2 seconds
    And the app does not crash

  @@regression @@happy-path
  Scenario: Warm start returns to last active screen within 1 second
    # Validates background to foreground performance
    Given the app was previously opened and put into the background
    When the user brings the app to the foreground
    Then the last active screen is available within 1 second
    And no data loss is observed on the last active screen

  @@regression @@edge-case
  Scenario: Cold start with limited memory reaches home screen within 3 seconds
    # Validates performance under memory pressure
    Given the device has limited available memory
    And the app is not running
    When the user launches the app
    Then the home screen is displayed within 3 seconds
    And the app does not crash

  @@regression @@boundary
  Scenario Outline: Startup time boundary conditions
    # Validates launch timing at acceptance criteria boundaries
    Given the app is not running on a typical supported device
    When the user taps the app icon
    Then the home screen is displayed within <max_time_seconds> seconds

    Examples:
      | max_time_seconds |
      | 2 |
      | 3 |

  @@regression @@negative @@error
  Scenario: App fails to reach home screen within allowed time
    # Negative test when startup time exceeds threshold
    Given the app is not running
    When the user taps the app icon
    Then the home screen is not displayed within 2 seconds
    And a performance failure is recorded

  @@regression @@boundary
  Scenario Outline: Background resume time boundary conditions
    # Validates resume timing at acceptance criteria boundaries
    Given the app was previously opened and put into the background
    When the user brings the app to the foreground
    Then the last active screen is available within <max_time_seconds> seconds

    Examples:
      | max_time_seconds |
      | 1 |
      | 2 |
