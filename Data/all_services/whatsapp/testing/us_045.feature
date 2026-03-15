@@smoke @@regression
Feature: Status Visibility Privacy नियंत्रण
  As a system administrator
  I want to configure which statuses are visible to specific user roles
  So that to ensure data privacy by exposing only permitted status information

  Background:
    Given the administrator is authenticated and on the status visibility settings page

  @@smoke @@regression @@happy-path
  Scenario: Assign selected statuses to a role and save successfully
    # Validates that assigned statuses are visible to users in that role
    Given the role "Support Agent" exists and has no visibility settings
    When the administrator assigns statuses "Open" and "In Progress" to role "Support Agent" and saves
    Then users in role "Support Agent" see only statuses "Open" and "In Progress"
    And no other statuses are visible to users in role "Support Agent"

  @@regression @@edge
  Scenario: Role with no configured statuses shows no visible statuses
    # Ensures users see a message when no statuses are configured for their role
    Given the role "Auditor" has no statuses configured for visibility
    When a user with role "Auditor" views status information
    Then no statuses are displayed
    And a message indicates that there are no visible statuses

  @@regression @@negative @@error
  Scenario: Prevent saving when required role has no selected statuses
    # Validates validation error when saving empty required configuration
    Given the role "Manager" is marked as required
    When the administrator attempts to save visibility settings without selecting any statuses for role "Manager"
    Then the system prevents saving
    And a validation error is displayed for role "Manager"

  @@regression @@boundary
  Scenario Outline: Assigning boundary status counts per role
    # Covers boundary conditions for minimum and maximum selectable statuses
    Given the role "Coordinator" is configured with selectable statuses list
    When the administrator assigns the following statuses to role "Coordinator" and saves
    Then users in role "Coordinator" see only the assigned statuses
    And no other statuses are visible to users in role "Coordinator"

    Examples:
      | Assigned Statuses | Case |
      | Open | minimum 1 status |
      | Open, In Progress, Pending, Resolved, Closed | maximum allowed statuses |

  @@regression @@outline
  Scenario Outline: Data-driven role assignments and visibility verification
    # Validates visibility across multiple roles and status sets
    Given the role "<Role>" exists
    When the administrator assigns statuses "<Statuses>" to role "<Role>" and saves
    Then users in role "<Role>" see only statuses "<Statuses>"
    And no other statuses are visible to users in role "<Role>"

    Examples:
      | Role | Statuses |
      | Support Agent | Open, In Progress |
      | Supervisor | Pending, Resolved |
