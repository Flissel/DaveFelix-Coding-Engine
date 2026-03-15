@smoke @regression
Feature: Community Management
  As a Community-Manager
  I want to eine Community mit mehreren getrennten Gruppen anlegen und verwalten
  So that damit zielgruppenspezifische Kommunikation uebersichtlich und sicher erfolgt

  Background:
    Given the Community-Manager is authenticated and in the Community section

  @@smoke @@regression @@happy-path
  Scenario: Create community with multiple groups
    # Validates successful creation and listing of a community with at least two groups
    Given no community with the same name exists
    When the Community-Manager creates a community named "Projekt Alpha"
    And adds groups "Team A" and "Team B"
    And saves the community
    Then the community is saved with both groups
    And the community appears in the overview list

  @@regression @@happy-path
  Scenario: Update group name or add new group
    # Ensures changes are saved immediately and visible across platforms
    Given a community exists with groups "Team A" and "Team B"
    When the Community-Manager renames group "Team A" to "Team Alpha"
    And adds a new group "Team C"
    Then the changes are saved immediately
    And the updated groups are visible on web and mobile clients

  @@regression @@negative
  Scenario: Prevent community creation without groups
    # Validates error handling when no groups are provided
    Given the Community-Manager starts creating a community named "Projekt Leer"
    When the Community-Manager attempts to save without adding any groups
    Then an error message is displayed indicating at least one group is required
    And the community is not created

  @@regression @@boundary
  Scenario: Create community with minimum allowed groups
    # Boundary condition for minimum group count (2 groups required by acceptance criteria)
    Given no community with the same name exists
    When the Community-Manager creates a community named "Projekt Minimum"
    And adds exactly two groups "Gruppe 1" and "Gruppe 2"
    And saves the community
    Then the community is saved successfully
    And both groups are displayed in the community details

  @@regression @@edge
  Scenario: Create community with large number of groups
    # Edge case for handling many groups in a single community
    Given no community with the same name exists
    When the Community-Manager creates a community named "Projekt Groß"
    And adds 50 distinct groups
    And saves the community
    Then the community is saved with all 50 groups
    And the overview list loads without errors

  @@regression @@edge
  Scenario Outline: Data-driven group operations
    # Scenario outline for add or rename group operations with validation
    Given a community exists with group "Team A"
    When the Community-Manager performs the operation <operation> with value <value>
    Then the community groups reflect the change <expected_result>

    Examples:
      | operation | value | expected_result |
      | rename group "Team A" to "Team Alpha" | "Team Alpha" | "Team Alpha" is present and "Team A" is not present |
      | add a new group | "Team B" | "Team B" is present |

  @@regression @@negative
  Scenario: Reject group name with only whitespace
    # Error scenario for invalid group name input
    Given the Community-Manager is creating a community named "Projekt Ungueltig"
    When the Community-Manager adds a group name consisting only of whitespace
    And attempts to save the community
    Then an error message is displayed for invalid group name
    And the community is not created
