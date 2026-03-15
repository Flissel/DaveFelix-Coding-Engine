@@smoke @@regression
Feature: Offline-Modus
  As a field employee
  I want to access and use core functions while offline
  So that so that work can continue without interruption when no network is available

  Background:
    Given the user has previously logged in on the device

  @@smoke @@regression @@happy-path
  Scenario: Launch app offline and access cached basic functions
    # Verifies the app launches offline and allows access to cached core functions
    Given the device is offline
    And cached data is available on the device
    When the user opens the application
    Then the application launches successfully
    And the user can access basic functions using cached data

  @@regression @@happy-path
  Scenario Outline: Save supported basic function data locally while offline
    # Validates local save and pending synchronization state for supported functions
    Given the device is offline
    And the user is on a supported basic function screen for <function_name>
    When the user saves data locally
    Then the system stores the data on the device
    And the system marks the data as pending synchronization

    Examples:
      | function_name |
      | create field note |
      | update task status |
      | add photo to report |

  @@regression @@negative
  Scenario Outline: Attempt offline-unavailable function
    # Ensures a clear message is shown when a live connectivity function is used offline
    Given the device is offline
    And the user selects a function that requires live connectivity: <live_function>
    When the user submits the action
    Then the system displays a clear message that the action is unavailable offline
    And the application does not crash

    Examples:
      | live_function |
      | submit real-time approval |
      | fetch latest customer data |

  @@regression @@negative @@edge
  Scenario: Launch app offline with no cached data
    # Validates behavior when cached data is not available (boundary condition)
    Given the device is offline
    And no cached data exists on the device
    When the user opens the application
    Then the application launches successfully
    And the user sees a message that cached data is unavailable
