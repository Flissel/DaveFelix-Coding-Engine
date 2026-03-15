@smoke @regression
Feature: Call History
  As a customer service agent
  I want to view and access the call history for a customer
  So that to track prior interactions and provide informed, efficient support

  Background:
    Given the agent is authenticated and viewing a customer profile

  @smoke @regression @happy-path
  Scenario: View chronological call history list
    # Verifies calls are shown in chronological order with date/time and direction
    Given the customer has completed multiple calls with stored date/time and direction
    When the agent opens the customer's call history
    Then the system displays a chronological list of calls
    And each call shows its date/time and call direction

  @regression @edge-case
  Scenario: Display empty state when no call history exists
    # Verifies empty state for customers with no call records
    Given the customer has no call records
    When the agent opens the customer's call history
    Then the system shows an empty state indicating no call history is available
    And no call list items are displayed

  @regression @negative
  Scenario: Handle call history retrieval error
    # Verifies error handling when call history cannot be retrieved
    Given a system error prevents retrieving the customer's call history
    When the agent attempts to load the call history
    Then the system displays an error message
    And no incomplete or incorrect call data is shown

  @regression @boundary
  Scenario: Boundary: single call record
    # Verifies display when only one call exists
    Given the customer has exactly one call record
    When the agent opens the customer's call history
    Then the system displays a list with exactly one call
    And the call shows its date/time and call direction

  @regression @edge-case
  Scenario: Sort order for calls with close timestamps
    # Validates chronological ordering when calls occur close together
    Given the customer has calls with timestamps within one minute of each other
    When the agent opens the customer's call history
    Then the system orders the calls chronologically by date/time
    And no duplicate or missing entries appear

  @regression
  Scenario Outline: Scenario Outline: Display call direction for each call
    # Verifies call direction values are shown correctly
    Given the customer has a <direction> call with a valid timestamp
    When the agent opens the customer's call history
    Then the call entry displays direction as <direction>

    Examples:
      | direction |
      | incoming |
      | outgoing |

  @regression @boundary
  Scenario Outline: Scenario Outline: Display date/time format for call entries
    # Validates date/time formatting for different locales or formats
    Given the customer has a call with timestamp in <format>
    When the agent opens the customer's call history
    Then the call entry displays date/time in <format>

    Examples:
      | format |
      | YYYY-MM-DD HH:MM |
      | DD.MM.YYYY HH:MM |
