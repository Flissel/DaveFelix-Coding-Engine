@smoke @regression
Feature: US-033 Umfragen - Create and view polls in chats
  As a registered chat user
  I want to create and view polls within group chats and individual chats
  So that so that I can gather quick feedback and make decisions directly in the conversation

  Background:
    Given I am a registered chat user and logged in

  @smoke @happy-path
  Scenario: Post a poll in a group chat
    # Creates a poll with valid question and options in a group chat
    Given I am a member of a group chat
    When I create a poll with question "Where should we eat?" and options "Italian" and "Sushi"
    Then the poll is posted in the group chat
    And the poll is visible to all group members

  @regression @happy-path
  Scenario: Post a poll in an individual chat
    # Creates a poll in a one-to-one chat and both participants can see it
    Given I am in an individual chat with another user
    When I create a poll with question "Meet at 3 PM?" and options "Yes" and "No"
    Then the poll is posted in the individual chat
    And the poll is visible to both participants

  @regression @negative
  Scenario Outline: Validate poll creation with invalid inputs
    # Prevents creation of a poll without a question or with fewer than two options
    Given I am a member of a group chat
    When I attempt to create a poll with <question> and options <options>
    Then the system prevents submission
    And a validation error is displayed

    Examples:
      | question | options |
      | "" | "Option A, Option B" |
      | "Pick one" | "Option A" |

  @regression @negative
  Scenario: Deny poll creation when user lacks chat access
    # Blocks poll creation for users without permission to the chat
    Given I do not have access to the chat
    When I attempt to create a poll in that chat
    Then the system denies the action
    And I am informed that I lack permission

  @regression @edge-case
  Scenario: Create a poll with minimum valid options
    # Allows poll creation when exactly two options are provided
    Given I am a member of a group chat
    When I create a poll with question "Choose one" and options "A" and "B"
    Then the poll is posted in the group chat
    And the poll shows exactly two options
