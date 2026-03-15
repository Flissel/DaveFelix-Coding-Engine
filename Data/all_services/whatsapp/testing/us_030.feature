@smoke @regression
Feature: US-030 Gruppe verlassen
  As a group member
  I want to leave a group
  So that to exit group participation without notifying other members

  Background:
    Given the user is authenticated

  @happy-path @smoke
  Scenario Outline: Leave group successfully without notifying others
    # Valid member leaves a group and no notifications are sent
    Given the user is a member of the group "<group_name>"
    When the user selects the option to leave the group and confirms
    Then the user is removed from the group
    And no notifications are sent to other group members

    Examples:
      | group_name |
      | Running Club |
      | Project Alpha |

  @negative @regression
  Scenario Outline: Prevent leaving when user is not a member
    # System blocks leave action for non-members
    Given the user is not a member of the group "<group_name>"
    When the user attempts to leave the group
    Then the system prevents the action
    And the user is informed that they are not a member

    Examples:
      | group_name |
      | Photography Club |
      | Team Omega |

  @negative @regression
  Scenario Outline: Handle server error during leave request
    # User remains a member when a server error occurs
    Given the user is a member of the group "<group_name>"
    And the server is unable to process leave requests
    When the user attempts to leave the group
    Then an error message is displayed
    And the user remains a member of the group

    Examples:
      | group_name |
      | Book Club |

  @edge @regression
  Scenario Outline: Leave group when user is the last member
    # Boundary condition where the group has only one member
    Given the user is the only member of the group "<group_name>"
    When the user selects the option to leave the group and confirms
    Then the user is removed from the group
    And no notifications are sent to other group members

    Examples:
      | group_name |
      | Solo Group |
