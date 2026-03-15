@smoke @regression
Feature: Einladungslink
  As a group administrator
  I want to generate and share an invitation link for a group
  So that so that I can onboard members quickly without manual approvals

  Background:
    Given a group exists in the system

  @@smoke @@regression @@happy-path
  Scenario: Generate a unique invitation link
    # Verify that an authenticated group administrator can generate a unique, shareable link
    Given the user is authenticated as a group administrator
    When the user creates an invitation link for the group
    Then the system generates a unique invitation link
    And the link can be copied and shared

  @@smoke @@regression @@happy-path
  Scenario: Join group using a valid invitation link
    # Verify that an unauthenticated user can join the group using a valid link
    Given a valid invitation link exists for the group
    And the user is unauthenticated
    When the user opens the invitation link and completes the join process
    Then the user is added to the group

  @@regression @@negative
  Scenario Outline: Prevent joining with revoked or expired link
    # Verify that revoked or expired links cannot be used to join the group
    Given an invitation link for the group is <link_status>
    When a user opens the invitation link
    Then the system prevents the user from joining the group
    And an error message is displayed

    Examples:
      | link_status |
      | revoked |
      | expired |

  @@regression @@negative @@boundary
  Scenario Outline: Link expiration boundary condition
    # Verify behavior when a link is used exactly at and just after expiration time
    Given an invitation link exists with an expiration time of <expiration_time>
    And the current time is <current_time>
    When a user opens the invitation link
    Then the system response is <expected_outcome>

    Examples:
      | expiration_time | current_time | expected_outcome |
      | 2025-01-01T10:00:00Z | 2025-01-01T10:00:00Z | join is allowed |
      | 2025-01-01T10:00:00Z | 2025-01-01T10:00:01Z | join is prevented with an error message |
