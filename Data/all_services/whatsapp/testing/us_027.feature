@smoke @regression
Feature: Gruppenadministration
  As a group administrator
  I want to manage groups by creating, editing, deleting, and assigning users with roles and permissions
  So that so that user access is controlled efficiently and securely across the system

  Background:
    Given the group administrator is authenticated and has admin rights

  @happy-path @smoke @regression
  Scenario: Create a new group with unique name and assigned users and roles
    # Verifies successful creation and visibility of a group with users and roles
    Given the group name "Engineering Team" does not exist
    When the administrator creates a group named "Engineering Team" and assigns users "Alice" and "Bob" with roles "Editor" and "Viewer"
    Then the group is saved and visible in the group list
    And the group details show users "Alice" and "Bob" with roles "Editor" and "Viewer"

  @happy-path @regression
  Scenario: Update group name and membership
    # Verifies changes are persisted and reflected in group details and user access
    Given an existing group "Support" has users "Cara" and "Dan" with role "Viewer"
    When the administrator renames the group to "Customer Support" and replaces "Dan" with "Eli" as a member
    Then the group name is updated to "Customer Support"
    And the group membership shows users "Cara" and "Eli" and user access is updated accordingly

  @negative @regression
  Scenario: Prevent duplicate group name on create or rename
    # Validates duplicate name rejection and error messaging
    Given a group named "Finance" already exists
    When the administrator attempts to create or rename a group to "Finance"
    Then the system rejects the action
    And a validation error indicates the group name must be unique

  @edge @regression
  Scenario: Delete group linked to users or permission sets
    # Checks deletion handling when group has dependencies
    Given a group "Operations" is linked to at least one user or permission set
    When the administrator attempts to delete the group
    Then the system prevents deletion with an explanatory message or requires confirmation
    And affected users are reassigned according to policy when confirmation is provided

  @boundary @regression
  Scenario Outline: Create group with boundary name lengths
    # Validates group name length boundaries using data-driven tests
    Given the group name "<group_name>" does not exist
    When the administrator creates a group named "<group_name>" with no users assigned
    Then the system accepts the group name and saves the group

    Examples:
      | group_name |
      | A |
      | AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA |

  @boundary @negative @regression
  Scenario Outline: Reject group name beyond maximum length
    # Ensures validation error for group names exceeding maximum length
    Given the group name "<group_name>" does not exist
    When the administrator attempts to create a group named "<group_name>"
    Then the system rejects the action
    And a validation error indicates the name exceeds the maximum length

    Examples:
      | group_name |
      | AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA |
