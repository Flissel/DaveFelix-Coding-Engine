@@smoke @@regression
Feature: Events planen
  As a group organizer
  I want to create and manage an event plan within a group
  So that so that group activities are coordinated and agreed efficiently

  Background:
    Given the user is a member of a group with at least one other member

  @@smoke @@happy-path
  Scenario: Create a new event successfully
    # Valid event details are saved and visible to all group members
    Given the group has no event with the same title and date
    When the user creates an event with title, date, time, and location
    Then the event is saved in the group plan
    And the event is visible to all group members

  @@regression @@happy-path
  Scenario: Update existing event details
    # Changes to an event are reflected for all group members
    Given an event exists in the group with title, date, time, and location
    When the user updates the event details
    Then the updated event is saved
    And all group members see the updated details

  @@regression @@negative
  Scenario Outline: Prevent saving when required fields are missing or invalid
    # Validation messages are shown and the event is not saved
    Given the user is on the create event form
    When the user enters invalid or missing required fields
    Then the system prevents saving the event
    And a validation message is displayed for the invalid or missing fields

    Examples:
      | title | date | time | location | expected_message |
      |  | 2025-05-10 | 18:00 | Community Hall | Title is required |
      | Weekly Meeting |  | 18:00 | Community Hall | Date is required |
      | Weekly Meeting | 2025-05-10 |  | Community Hall | Time is required |
      | Weekly Meeting | 2025-05-10 | 18:00 |  | Location is required |
      | Weekly Meeting | invalid-date | 18:00 | Community Hall | Date is invalid |
      | Weekly Meeting | 2025-05-10 | 25:61 | Community Hall | Time is invalid |

  @@regression @@edge-case
  Scenario Outline: Create event at boundary date and time values
    # System accepts valid boundary values for date and time
    Given the user is on the create event form
    When the user creates an event with boundary date and time values
    Then the event is saved successfully
    And the event is visible to all group members

    Examples:
      | title | date | time | location |
      | New Year Kickoff | 2025-01-01 | 00:00 | Main Square |
      | Year End Review | 2025-12-31 | 23:59 | Conference Room |
