@@smoke @@regression
Feature: Sticker Suggestions
  As a chat user
  I want to receive context-based sticker suggestions while composing a message
  So that to express reactions faster and more relevantly without searching manually

  Background:
    Given the user is in an active chat with the message composer visible

  @@smoke @@regression @@happy-path
  Scenario: Display ranked sticker suggestions for clear context
    # Validates that relevant stickers are ranked and shown for recognizable context
    Given the suggestion service is available
    When the user enters text with clear context "Happy birthday!" and opens the suggestion panel
    Then the system displays a ranked list of relevant sticker suggestions
    And the top suggestion reflects the message context

  @@regression @@edge-case
  Scenario: Provide generic or trending stickers for ambiguous context
    # Ensures generic or trending stickers are shown when context is unclear
    Given the suggestion service is available
    When the user enters text with ambiguous context and triggers suggestions
    Then the system shows generic or trending stickers
    And the system does not show an empty suggestion panel

  @@regression @@negative
  Scenario: Handle suggestion service unavailability
    # Shows a non-blocking error and allows manual browsing when service fails
    Given the suggestion service is unavailable
    When the user requests sticker suggestions
    Then the system shows a non-blocking error message
    And the user can open manual sticker browsing

  @@regression @@boundary
  Scenario Outline: Suggest stickers for boundary message lengths
    # Validates behavior for very short and very long messages
    Given the suggestion service is available
    When the user enters <message> and triggers suggestions
    Then the system returns sticker suggestions without error
    And the suggestions are appropriate for the detected context or generic if none

    Examples:
      | message |
      | Hi |
      | This is a very long message describing a detailed scenario with multiple emotions and events to evaluate context detection across a large input |
