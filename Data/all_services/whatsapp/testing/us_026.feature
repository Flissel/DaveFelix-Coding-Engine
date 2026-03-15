@@smoke @@regression
Feature: Gruppe erstellen
  As a registered user
  I want to create a group chat with selected participants and a group name
  So that to communicate efficiently with multiple people in a single conversation

  Background:
    Given the user is authenticated and on the group creation screen

  @@smoke @@regression @@happy-path
  Scenario: Create a group chat with valid name and minimum participants
    # Happy path for creating a group chat with valid inputs
    When the user enters the group name "Project Alpha" and selects participants "Alice" and "Bob" and submits
    Then the system creates the group chat
    And the group chat is displayed in the user's chat list with name "Project Alpha" and members "Alice" and "Bob"

  @@regression @@negative
  Scenario Outline: Prevent group creation when participant count is below minimum
    # Error scenario for not meeting the minimum participant requirement
    When the user enters the group name "Team" and selects <participant_count> participant(s) and submits
    Then the system prevents group creation
    And a validation message indicates at least 2 participants are required

    Examples:
      | participant_count |
      | 0 |
      | 1 |

  @@regression @@negative
  Scenario Outline: Prevent group creation with empty or invalid group name
    # Error scenario for invalid group name inputs
    When the user enters the group name <group_name> and selects participants "Alice" and "Bob" and submits
    Then the system prevents group creation
    And the system prompts the user to provide a valid group name

    Examples:
      | group_name |
      | "" |
      | "   " |
      | "@@@" |

  @@regression @@boundary
  Scenario: Create group with boundary minimum participants
    # Boundary condition for exactly two participants
    When the user enters the group name "Pair Chat" and selects participants "Alice" and "Bob" and submits
    Then the system creates the group chat
    And the group chat is displayed in the user's chat list with name "Pair Chat" and members "Alice" and "Bob"
