@@smoke @@regression
Feature: Abwesenheitsnachrichten
  As a employee
  I want to configure an automatic absence message for a defined period
  So that so that incoming messages receive timely status information without manual replies

  Background:
    Given the employee is authenticated
    And the employee has access to absence message settings

  @@smoke @@regression @@happy-path
  Scenario: Activate absence message for a valid period
    # Happy path for saving a valid absence message configuration
    Given the absence message form is open
    When the employee sets a start date, end date, and message text
    And the employee saves the absence message
    Then the system activates the automatic absence message for the specified period
    And the saved configuration is visible to the employee

  @@regression @@happy-path
  Scenario: Automatic reply is sent during active absence period
    # Happy path for sending automated replies during the configured period
    Given an automatic absence message is active with a configured message text
    And the current time is within the configured absence period
    When a sender sends a message to the employee
    Then the sender receives the configured automatic absence reply

  @@regression @@negative
  Scenario: Validate error when message text is empty
    # Error scenario for missing required message text
    Given the absence message form is open
    When the employee sets a start date and end date but leaves the message text empty
    And the employee saves the absence message
    Then the system displays a validation error for message text
    And the absence message is not activated

  @@regression @@negative
  Scenario: Reject absence message when end date is before start date
    # Error scenario for invalid date range
    Given the absence message form is open
    When the employee sets the end date before the start date
    And the employee enters a valid message text
    And the employee saves the absence message
    Then the system displays a validation error for the date range
    And the absence message is not activated

  @@regression @@boundary
  Scenario Outline: Boundary conditions for start and end date times
    # Boundary condition tests for absence period start and end timestamps
    Given the absence message form is open
    When the employee sets start and end date times as <start_time> and <end_time>
    And the employee enters a valid message text
    And the employee saves the absence message
    Then the system activates the automatic absence message for the specified period
    And the configured period matches the exact start and end timestamps

    Examples:
      | start_time | end_time |
      | 2025-06-01T00:00 | 2025-06-01T00:00 |
      | 2025-06-01T23:59 | 2025-06-02T00:00 |

  @@regression @@edge-case
  Scenario Outline: Automatic reply not sent outside absence period
    # Edge case where a message is received before the absence period starts or after it ends
    Given an automatic absence message is active with a configured message text
    And the current time is <current_time> relative to the configured absence period
    When a sender sends a message to the employee
    Then the sender does not receive an automatic absence reply

    Examples:
      | current_time |
      | before the start time |
      | after the end time |
