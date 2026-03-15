@smoke @regression
Feature: Chat history transfer to new device
  As a registered user
  I want to transfer my chat history to a new device
  So that so that I can continue conversations without losing context when switching devices

  Background:
    Given the user is registered and can log in on multiple devices

  @smoke @regression @happy-path
  Scenario: Successful transfer of existing chat history
    # Verifies all chats and messages are transferred in correct order
    Given the user is logged in on the new device
    And the old device has existing chat history
    When the user initiates chat history transfer
    Then all chats and messages are available on the new device in the correct order
    And the transfer is marked as completed

  @regression @edge-case
  Scenario: Transfer completes with no data when no history exists
    # Verifies informative message when there is no chat history to transfer
    Given the user is logged in on the new device
    And the old device has no chat history
    When the user initiates chat history transfer
    Then the system completes the transfer with no data
    And an informative message is shown to the user

  @regression @negative @error
  Scenario: Transfer failure on unstable connection allows retry without data loss
    # Verifies error handling and retry behavior when transfer fails
    Given the user is logged in on the new device
    And the old device has existing chat history
    And the network connection is unstable
    When the user initiates chat history transfer
    Then the system displays an error message
    And the user can retry the transfer without data loss

  @regression @boundary
  Scenario Outline: Boundary conditions for chat history size
    # Validates transfer for minimum and maximum supported chat history sizes
    Given the user is logged in on the new device
    And the old device has <chat_count> chats with a total of <message_count> messages
    When the user initiates chat history transfer
    Then all chats and messages are available on the new device in the correct order
    And the transfer completes within the allowed time limit

    Examples:
      | chat_count | message_count |
      | 0 | 0 |
      | 1 | 1 |
      | 500 | 100000 |
