@@smoke @@regression
Feature: Gruppen-Einladungen - Rollenbasierte Berechtigungen
  As a system admin
  I want to configure which roles are allowed to add users to groups
  So that ensure group membership changes are controlled and compliant with organizational policies

  Background:
    Given the system has existing roles and a group named "Engineering"

  @@smoke @@regression @@happy-path
  Scenario: Admin saves allowed roles for group invitations
    # Verifies that selected roles are stored and applied after saving
    Given the admin is on the group invitation settings page
    When the admin selects "Group Manager" and "Team Lead" as allowed roles and saves
    Then the system stores the allowed roles configuration
    And only users with "Group Manager" or "Team Lead" can add users to groups

  @@smoke @@regression @@happy-path
  Scenario: Allowed role can add user to group
    # Validates that users with configured roles can successfully add members
    Given the allowed roles are configured to include "Group Manager"
    And a user with role "Group Manager" is viewing the "Engineering" group
    When the user adds "Alice" to the group
    Then the system adds "Alice" to the group
    And the action is logged as authorized

  @@regression @@negative
  Scenario: Unauthorized role is blocked from adding users
    # Ensures unauthorized roles receive an authorization error
    Given the allowed roles are configured to include "Group Manager"
    And a user with role "Viewer" is viewing the "Engineering" group
    When the user attempts to add "Bob" to the group
    Then the system blocks the add-to-group action
    And an authorization error is displayed

  @@regression @@negative @@edge-case
  Scenario: No roles configured rejects all add-to-group actions
    # Validates behavior when no roles are configured as allowed
    Given no roles are configured as allowed to add users to groups
    When any user attempts to add "Charlie" to the "Engineering" group
    Then the system rejects the action
    And the system prompts an admin to configure permissions

  @@regression @@outline
  Scenario Outline: Role-based add-to-group permissions matrix
    # Data-driven verification of allowed and disallowed roles
    Given the allowed roles are configured to include <allowed_role>
    And a user with role <actor_role> is viewing the "Engineering" group
    When the user attempts to add <target_user> to the group
    Then the system returns <expected_result>
    And the system displays <message_type>

    Examples:
      | allowed_role | actor_role | target_user | expected_result |
      | Group Manager | Group Manager | Dana | success |
      | Group Manager | Viewer | Eli | authorization_error |
