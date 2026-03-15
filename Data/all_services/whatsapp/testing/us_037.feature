@smoke @regression
Feature: Group Call
  As a registered user
  I want to start a group voice or video call with multiple participants
  So that to communicate and collaborate with several people simultaneously

  Background:
    Given the user is logged in
    And the user has a contact list available

  @smoke @regression @happy-path
  Scenario Outline: Start a group call with multiple participants
    # Verifies a group voice or video call can be created and invited participants can join
    Given the user has at least two available contacts
    When the user initiates a group <call_type> call and invites <participant_count> participants
    Then a group <call_type> call is created
    And the invited participants receive the invitation and can join

    Examples:
      | call_type | participant_count |
      | voice | 2 |
      | video | 3 |

  @regression @happy-path
  Scenario Outline: Invite an additional participant during an ongoing call
    # Verifies a new participant can be invited and join an ongoing group call
    Given a group <call_type> call is in progress with <initial_participant_count> participants
    When the user invites an additional participant during the call
    Then the new participant receives the invitation
    And the new participant can join the ongoing call

    Examples:
      | call_type | initial_participant_count |
      | voice | 2 |
      | video | 4 |

  @regression @negative
  Scenario: Prevent starting a group call without selecting participants
    # Verifies an error is shown when no participant is selected
    Given the user is on the group call initiation screen
    When the user confirms the call without selecting any participant
    Then the system displays an error message indicating at least one participant must be selected

  @regression @boundary
  Scenario Outline: Start a group call with the minimum allowed participants
    # Verifies the boundary condition for minimum participant selection
    Given the user has at least one available contact
    When the user initiates a group <call_type> call and invites <participant_count> participant
    Then the group <call_type> call is created successfully

    Examples:
      | call_type | participant_count |
      | voice | 1 |
      | video | 1 |
