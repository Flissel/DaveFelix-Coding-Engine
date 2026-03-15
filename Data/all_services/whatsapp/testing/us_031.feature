@smoke @regression
Feature: Community creation and group management
  As a community administrator
  I want to create a community with multiple groups
  So that so that related groups can be managed under a single community for easier organization and governance

  Background:
    Given the administrator is authenticated and has access to community management

  @smoke @regression @happy-path
  Scenario: Create a community with multiple groups
    # Validates that a community is saved with all specified groups linked
    Given the administrator is on the community creation page
    When they enter a community name and add groups "Group A" and "Group B"
    And they save the community
    Then the community is saved successfully
    And the community shows groups "Group A" and "Group B" linked to it

  @regression @negative @error
  Scenario: Prevent saving a community with no groups
    # Validates error handling when no groups are provided
    Given the administrator is on the community creation page
    When they enter a community name and do not add any groups
    And they attempt to save the community
    Then the system prevents the community from being saved
    And a message is displayed indicating at least one group is required

  @regression @happy-path
  Scenario: Update groups in an existing community
    # Validates that adding and removing groups updates the community
    Given an existing community has groups "Group A" and "Group B"
    And the administrator is on the community edit page
    When they remove "Group B" and add "Group C"
    And they save the changes
    Then the community shows groups "Group A" and "Group C" linked to it

  @regression @boundary
  Scenario Outline: Create a community with the minimum number of groups
    # Boundary condition for minimum group requirement
    Given the administrator is on the community creation page
    When they enter a community name and add a single group "<group_name>"
    And they save the community
    Then the community is saved successfully
    And the community shows group "<group_name>" linked to it

    Examples:
      | group_name |
      | Group A |

  @regression @edge @scenario-outline
  Scenario Outline: Create a community with multiple groups via data-driven inputs
    # Edge case using varying numbers of groups
    Given the administrator is on the community creation page
    When they enter a community name and add groups "<group_1>", "<group_2>", and "<group_3>"
    And they save the community
    Then the community is saved successfully
    And the community shows groups "<group_1>", "<group_2>", and "<group_3>" linked to it

    Examples:
      | group_1 | group_2 | group_3 |
      | Group A | Group B | Group C |
      | Engineering | Marketing | Support |
