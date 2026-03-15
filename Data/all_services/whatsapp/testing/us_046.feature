@smoke @regression
Feature: Mute contact status updates
  As a registered user
  I want to mute a contact's status updates
  So that to reduce distractions and control which status updates are visible

  Background:
    Given the user is logged in and the contact list is visible

  @smoke @happy-path @regression
  Scenario: Mute a visible contact status successfully
    # Validates that a non-muted contact's status updates are hidden after muting
    Given a contact named "Alice" is visible and not muted
    When the user selects the option to mute "Alice"
    Then status updates from "Alice" are not shown to the user
    And "Alice" is marked as muted in the contact list

  @regression @edge @negative
  Scenario: Attempt to mute an already muted contact
    # Ensures the system keeps the contact muted and informs the user
    Given a contact named "Bob" is already muted
    When the user selects the option to mute "Bob" again
    Then "Bob" remains muted
    And the user is informed that "Bob" is already muted

  @regression @negative @error
  Scenario Outline: Fail to mute while offline or server unavailable
    # Validates error handling when the system cannot process the mute request
    Given a contact named "Charlie" is visible and not muted
    And the system is <system_state>
    When the user selects the option to mute "Charlie"
    Then an error message is displayed
    And "Charlie" remains not muted

    Examples:
      | system_state |
      | offline |
      | server unavailable |

  @regression @boundary
  Scenario Outline: Mute boundary conditions for contact visibility and status feed
    # Ensures mute behavior at the boundary where the status feed has minimal updates
    Given a contact named "<contact_name>" is visible and not muted
    And "<contact_name>" has <status_count> status updates in the feed
    When the user selects the option to mute "<contact_name>"
    Then status updates from "<contact_name>" are not shown to the user
    And "<contact_name>" is marked as muted in the contact list

    Examples:
      | contact_name | status_count |
      | Dana | 0 |
      | Evan | 1 |
