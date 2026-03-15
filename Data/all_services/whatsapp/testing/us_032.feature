@smoke @regression
Feature: One-way broadcast channels
  As a channel administrator
  I want to create and manage a one-way broadcast channel
  So that so that important information can be distributed reliably without member replies cluttering the channel

  Background:
    Given the messaging system is available

  @happy-path @smoke @regression
  Scenario: Create a one-way broadcast channel successfully
    # Verifies an authorized administrator can create a one-way broadcast channel and only administrators can post
    Given an administrator is logged in with channel creation permission
    When the administrator creates a channel named "Announcements" with one-way broadcast mode enabled
    Then the channel "Announcements" is created in one-way broadcast mode
    And only administrators can post messages in the channel

  @negative @regression
  Scenario: Prevent regular members from posting in a one-way broadcast channel
    # Ensures non-admin members are blocked from posting and see a permission error
    Given a one-way broadcast channel named "Announcements" exists
    And a regular member is logged in and viewing the channel
    When the member attempts to post a message "Hello"
    Then the system blocks the post
    And a permission error is displayed to the member

  @happy-path @regression
  Scenario: Administrator message is delivered to all members
    # Validates messages posted by an administrator are visible to all subscribed members
    Given a one-way broadcast channel named "Announcements" exists with subscribed members
    And an administrator is logged in
    When the administrator posts a message "System maintenance at 8 PM"
    Then the message is visible in the channel
    And the message is delivered to all subscribed members

  @edge @regression
  Scenario Outline: Channel creation name length boundaries
    # Checks boundary conditions for channel name length when creating a one-way broadcast channel
    Given an administrator is logged in with channel creation permission
    When the administrator creates a one-way broadcast channel with name "<channel_name>"
    Then the system responds with "<result>"

    Examples:
      | channel_name | result |
      | A | channel created successfully |
      | AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA | channel created successfully |
      |  | validation error for missing channel name |

  @negative @regression
  Scenario: Unauthorized user cannot create a one-way broadcast channel
    # Ensures permission checks prevent unauthorized creation
    Given a user is logged in without channel creation permission
    When the user attempts to create a one-way broadcast channel named "Announcements"
    Then the system denies the request
    And a permission error is displayed to the user
