@smoke @regression
Feature: Voice message in chat
  As a messaging user
  I want to record and send a voice message in a chat
  So that communicate quickly when typing is inconvenient

  Background:
    Given the user is logged in
    And the user is in an active chat with at least one participant

  @smoke @regression @happy-path
  Scenario: Send a voice message successfully
    # Happy path for recording and sending a playable voice message
    Given the network connection is available
    When the user records a voice message
    And the user taps send
    Then the voice message is delivered to the chat
    And the voice message is playable by recipients

  @regression @edge-case
  Scenario: Cancel or discard a recording
    # Edge case where a recording is discarded before sending
    Given the user is recording a voice message
    When the user cancels the recording
    Then no voice message is sent
    And no draft is saved

  @regression @negative
  Scenario: Network unavailable when sending voice message
    # Error scenario when attempting to send without network
    Given the network connection is unavailable
    When the user attempts to send a recorded voice message
    Then an error is shown to the user
    And the voice message is not sent

  @regression @boundary
  Scenario Outline: Send voice messages with boundary durations
    # Boundary conditions for minimum and maximum recording durations
    Given the network connection is available
    When the user records a voice message of <duration>
    And the user taps send
    Then the voice message is delivered to the chat
    And the voice message is playable by recipients

    Examples:
      | duration |
      | the minimum allowed length |
      | the maximum allowed length |
