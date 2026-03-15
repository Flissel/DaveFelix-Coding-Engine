@smoke @regression
Feature: Call Link Generation and Access
  As a call organizer
  I want to generate and share a call link for a scheduled call
  So that participants can join the call easily at the scheduled time, reducing coordination effort

  Background:
    Given a call scheduling system is available

  @@smoke @@regression @@happy-path
  Scenario: Generate a unique call link for a scheduled call
    # Verifies that a unique call link is generated and displayed for a scheduled call
    Given a call is scheduled in the system with status "scheduled"
    When the organizer requests a call link
    Then the system generates a unique call link
    And the system displays the call link to the organizer

  @@regression @@happy-path
  Scenario: Participant joins the correct call using the link at scheduled time
    # Ensures the participant is directed to the correct call when using a valid link at the scheduled time
    Given a call link has been generated for a scheduled call at "2025-03-01T10:00:00Z"
    When a participant uses the link at "2025-03-01T10:00:00Z"
    Then the participant is directed to join the correct scheduled call

  @@regression @@negative
  Scenario: Prevent link generation for a canceled call
    # Validates that link generation is blocked when the call is canceled
    Given a call is scheduled in the system with status "canceled"
    When the organizer requests a call link
    Then the system prevents call link generation
    And the system informs the organizer that the call is canceled

  @@regression @@edge @@negative
  Scenario Outline: Link usage outside the scheduled time window
    # Checks system behavior when a participant attempts to use the link outside the allowed join window
    Given a call link has been generated for a scheduled call at "<scheduled_time>" with an allowed join window of "<join_window_minutes>" minutes
    When a participant uses the link at "<attempt_time>"
    Then the system blocks joining the call
    And the system displays a message that the call is not available at this time

    Examples:
      | scheduled_time | join_window_minutes | attempt_time |
      | 2025-03-01T10:00:00Z | 10 | 2025-03-01T09:45:00Z |
      | 2025-03-01T10:00:00Z | 10 | 2025-03-01T10:15:01Z |

  @@regression @@edge
  Scenario Outline: Uniqueness of generated call links per call
    # Ensures generating a link for different scheduled calls results in different links
    Given two different calls are scheduled with identifiers "<call_id_1>" and "<call_id_2>"
    When the organizer requests a call link for each call
    Then the system generates a unique call link for each call
    And the links for the two calls are not identical

    Examples:
      | call_id_1 | call_id_2 |
      | CALL-1001 | CALL-1002 |
