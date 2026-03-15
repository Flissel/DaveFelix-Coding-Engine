@smoke @regression
Feature: Datumsbasierte Suche
  As a user
  I want to jump to a specific date in the system
  So that so that I can quickly access data from the desired time period and improve efficiency

  Background:
    Given the user is viewing a date-based list or timeline

  @happy-path @smoke @regression
  Scenario: Jump to a valid date with available data
    # Valid date selection navigates to the chosen date and shows data
    When the user selects the date "2024-05-15" and confirms the action
    Then the system navigates to "2024-05-15"
    And the system displays the data for "2024-05-15"

  @edge-case @regression
  Scenario: Jump to a valid date with no data
    # Valid date selection navigates to the chosen date and shows empty state
    When the user selects the date "2023-01-01" and confirms the action
    Then the system navigates to "2023-01-01"
    And the system shows an empty state message indicating no data available

  @negative @regression
  Scenario: Reject invalid date formats
    # Invalid date input is rejected and navigation does not occur
    When the user enters the date "15-05-2024" and confirms the action
    Then the system displays a validation error for invalid date format
    And the system does not navigate away from the current view

  @edge-case @regression
  Scenario Outline: Jump to boundary dates
    # Navigation works for boundary dates of the available range
    When the user selects the date "<date>" and confirms the action
    Then the system navigates to "<date>"
    And the system displays the data for "<date>"

    Examples:
      | date |
      | 2020-01-01 |
      | 2024-12-31 |
