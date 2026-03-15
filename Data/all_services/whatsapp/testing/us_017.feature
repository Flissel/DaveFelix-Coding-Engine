@@smoke @@regression
Feature: Reaktionen
  As a chat user
  I want to add an emoji reaction to a message
  So that so that I can quickly express feedback without sending a new message

  Background:
    Given a chat conversation with existing messages is open

  @@smoke @@happy-path @@regression
  Scenario: Add a new emoji reaction to a message
    # Verifies a user can add a reaction and it is visible to all participants
    Given the user is online and viewing message "MSG-100"
    When the user selects the "😊" reaction on message "MSG-100"
    Then the "😊" reaction is displayed on message "MSG-100"
    And all participants can see the "😊" reaction on message "MSG-100"

  @@happy-path @@regression
  Scenario: Increment reaction count when the same emoji is added again
    # Ensures the count increases and the user is recorded as a reactor
    Given message "MSG-200" already has a "👍" reaction count of 1
    When the user adds the "👍" reaction to message "MSG-200"
    Then the "👍" reaction count on message "MSG-200" is incremented to 2
    And the user is shown as a reactor for "👍" on message "MSG-200"

  @@happy-path @@regression
  Scenario: Remove an existing reaction
    # Validates reaction removal decrements the count and removes the user
    Given the user has reacted with "🔥" on message "MSG-300" and the count is 3
    When the user removes their "🔥" reaction from message "MSG-300"
    Then the "🔥" reaction count on message "MSG-300" is decremented to 2
    And the user is no longer shown as a reactor for "🔥" on message "MSG-300"

  @@negative @@regression
  Scenario Outline: Prevent adding reaction when offline or message is missing
    # Error handling for offline state or deleted message
    Given the system state is "<state>" for message "<message_id>"
    When the user attempts to add the "😮" reaction to message "<message_id>"
    Then the system prevents the reaction from being added
    And an error message "<error_message>" is displayed to the user

    Examples:
      | state | message_id | error_message |
      | offline | MSG-400 | You are offline. Reactions cannot be added. |
      | message_missing | MSG-404 | This message no longer exists. |

  @@edge @@regression
  Scenario Outline: Boundary: Add reaction when the count is at maximum display limit
    # Ensures system handles boundary reaction count without incorrect behavior
    Given message "<message_id>" has a "<emoji>" reaction count of "<current_count>"
    When the user adds the "<emoji>" reaction to message "<message_id>"
    Then the "<emoji>" reaction count is updated to "<expected_count>"
    And the user is shown as a reactor for "<emoji>" on message "<message_id>"

    Examples:
      | message_id | emoji | current_count | expected_count |
      | MSG-500 | 🎉 | 99 | 100 |
