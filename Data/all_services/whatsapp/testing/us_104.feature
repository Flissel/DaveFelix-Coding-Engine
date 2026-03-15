@@smoke @@regression
Feature: Business-Statistiken
  As a business account admin
  I want to view basic message statistics for their business
  So that so that they can monitor communication volume and trends to make operational decisions

  Background:
    Given the business statistics service is available

  @@smoke @@regression @@happy-path
  Scenario Outline: View message statistics for a valid time range
    # Validates that basic statistics are displayed for a selected range with messages
    Given the business account admin is logged in
    And the admin has access to a business with existing messages between "<start_date>" and "<end_date>"
    When the admin opens the business statistics section
    And the admin selects the time range from "<start_date>" to "<end_date>"
    Then the system displays total messages for the selected range
    And the system displays sent and received message counts for the selected range

    Examples:
      | start_date | end_date |
      | 2024-01-01 | 2024-01-31 |
      | 2024-02-01 | 2024-02-29 |

  @@regression @@edge
  Scenario Outline: Show zero statistics when no messages exist
    # Ensures zero values and no data indicator for a range with no messages
    Given the business account admin is logged in
    And the admin has access to a business with no messages between "<start_date>" and "<end_date>"
    When the admin requests statistics for the time range from "<start_date>" to "<end_date>"
    Then the system shows zero total messages
    And the system indicates that no data is available for the selected period

    Examples:
      | start_date | end_date |
      | 2023-12-01 | 2023-12-31 |

  @@regression @@negative
  Scenario: Deny access for unauthorized admin
    # Validates access control and error message for unauthorized access
    Given the business account admin is logged in
    And the admin is not authorized to access the target business
    When the admin attempts to open the business statistics section
    Then the system denies access
    And the system displays an authorization error message

  @@regression @@boundary
  Scenario Outline: Display statistics for a single-day boundary range
    # Checks boundary condition where start and end dates are the same day
    Given the business account admin is logged in
    And the admin has access to a business with messages on "<date>"
    When the admin selects the time range from "<date>" to "<date>"
    Then the system displays total messages for the selected day
    And the system displays sent and received message counts for the selected day

    Examples:
      | date |
      | 2024-03-15 |
