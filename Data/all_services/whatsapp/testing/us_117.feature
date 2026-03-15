@@smoke @@regression
Feature: Widgets
  As a mobile app user
  I want to add and view home-screen widgets from the app
  So that so that I can quickly access key information without opening the app

  Background:
    Given the app is installed on the device

  @@smoke @@happy-path
  Scenario: Add widget and show default content
    # Validates widget can be added and shows default content
    When the user adds the app widget to the home screen
    Then the widget appears on the home screen
    And the widget displays the default content

  @@regression @@edge
  Scenario: Show placeholder when no data is available
    # Ensures placeholder is shown when widget has no data
    Given the widget is present on the home screen
    And the app has no data available for the widget
    When the widget renders its content
    Then the widget shows a placeholder message indicating no data is available

  @@regression @@negative
  Scenario: Use last cached data when offline
    # Verifies offline behavior uses cached data and indicates offline state
    Given the widget is present on the home screen
    And the device is offline
    When the widget attempts to refresh
    Then the widget displays the last cached data
    And the widget indicates it is offline

  @@regression @@negative
  Scenario Outline: Widget refresh behavior by data availability and connectivity
    # Data-driven validation of refresh outcomes for boundary and error conditions
    Given the widget is present on the home screen
    And the device is <connectivity_state>
    And the app data state is <data_state>
    When the widget attempts to refresh
    Then the widget displays <expected_content>
    And the widget shows <expected_status_indicator>

    Examples:
      | connectivity_state | data_state | expected_content | expected_status_indicator |
      | online | available | the latest data | no offline indicator |
      | online | empty | a placeholder message | no offline indicator |
      | offline | available | the last cached data | an offline indicator |
      | offline | empty | a placeholder message | an offline indicator |
