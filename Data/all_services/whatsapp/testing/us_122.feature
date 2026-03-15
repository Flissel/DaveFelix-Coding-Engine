@@smoke @@regression
Feature: Smart Reply Suggestions
  As a customer support agent
  I want to generate intelligent reply suggestions for an incoming message
  So that to respond faster and consistently, improving customer satisfaction

  Background:
    Given the agent is logged in and an incoming customer message is displayed

  @@smoke @@regression @@happy-path
  Scenario: Show relevant smart reply suggestions for incoming messages
    # Verifies suggestions appear for messages with sufficient context
    When the agent opens the reply composer
    Then the system shows a list of relevant smart reply suggestions
    And each suggestion is related to the incoming message

  @@smoke @@regression @@happy-path
  Scenario: Insert selected smart reply into composer
    # Verifies a selected suggestion is inserted into the reply composer
    Given smart reply suggestions are shown
    When the agent selects a suggestion
    Then the selected text is inserted into the reply composer for editing
    And the composer cursor is positioned at the end of the inserted text

  @@regression @@negative @@edge
  Scenario: No suggestions for insufficient context
    # Verifies the system indicates no suggestions when context is insufficient
    Given the incoming message has insufficient context
    When the agent opens the reply composer
    Then the system shows no smart reply suggestions
    And the system indicates that no suggestions are available

  @@regression @@edge
  Scenario Outline: Smart reply suggestions based on message types
    # Validates suggestions are shown or not shown based on message context type
    Given the incoming message content is <message_type>
    When the agent opens the reply composer
    Then the system <suggestion_behavior>
    And the suggestion list count is <suggestion_count>

    Examples:
      | message_type | suggestion_behavior | suggestion_count |
      | a clear billing question with order number | shows smart reply suggestions | at least 1 |
      | a greeting only | shows no smart reply suggestions | 0 |
      | a long detailed complaint | shows smart reply suggestions | at least 1 |

  @@regression @@negative @@error
  Scenario: Handle smart reply service failure
    # Verifies graceful handling when the suggestion service is unavailable
    Given the smart reply service is unavailable
    When the agent opens the reply composer
    Then the system shows no smart reply suggestions
    And the system displays an error message that suggestions could not be loaded

  @@regression @@boundary
  Scenario Outline: Boundary conditions for suggestion list size
    # Validates behavior when suggestion list is at minimum or maximum limits
    Given the suggestion service returns <suggestion_count> suggestions
    When the agent opens the reply composer
    Then the system displays <suggestion_count> suggestions
    And the suggestions are displayed in the reply composer panel

    Examples:
      | suggestion_count |
      | 1 |
      | 10 |
