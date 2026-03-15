@@smoke @@regression
Feature: Siri/Google Assistant Linking and Voice Commands
  As a end user
  I want to link Siri or Google Assistant to my account and issue voice commands to use the system's features
  So that so that I can complete tasks hands-free and more quickly

  Background:
    Given the user has a valid account and is signed in to the system

  @@smoke @@happy-path @@regression
  Scenario: Link voice assistant and execute a supported command
    # Verifies successful linking and command execution with voice confirmation
    Given Siri or Google Assistant is available on the user's device
    When the user links the voice assistant and issues a supported command
    Then the system executes the command
    And the system confirms completion via voice response

  @@regression @@edge @@negative
  Scenario: Unsupported or ambiguous command returns clarification
    # Ensures the system requests clarification and avoids unintended actions
    Given the voice assistant is linked
    When the user issues an unsupported or ambiguous command
    Then the system responds with a clarification or list of supported commands
    And no unintended action is performed

  @@regression @@negative @@error
  Scenario: Linking fails when assistant service is unavailable
    # Validates error handling when the assistant service is down
    Given the voice assistant service is unavailable
    When the user starts the linking process
    Then the system displays an error message
    And the system allows the user to retry later without creating a partial link

  @@regression @@boundary
  Scenario Outline: Supported commands execute correctly across assistant types
    # Covers boundary of supported commands across different assistants
    Given the voice assistant <assistant> is available and linked
    When the user issues the supported command <command>
    Then the system executes <expected_action>
    And the system confirms completion via voice response

    Examples:
      | assistant | command | expected_action |
      | Siri | Create a new task | a new task is created |
      | Google Assistant | Mark task as done | the task status is updated to done |
