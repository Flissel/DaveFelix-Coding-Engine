@@smoke @@regression
Feature: Sticker
  As a chat user
  I want to send stickers in a chat
  So that express emotions quickly and enrich communication

  Background:
    Given the user is logged in and has access to stickers

  @@smoke @@happy-path
  Scenario: Send a sticker in a one-to-one chat
    # Validates sticker delivery in an active direct chat
    Given the user is in an active chat with another user
    When the user selects a sticker and sends it
    Then the sticker is displayed in the conversation for both participants
    And the message status shows sent successfully

  @@regression @@happy-path
  Scenario: Send a sticker in a group chat
    # Validates sticker visibility for all group members
    Given the user is in a group chat with multiple members
    When the user sends a sticker
    Then the sticker is visible to all group members in the chat timeline

  @@negative @@regression
  Scenario: Send a sticker fails without network connectivity
    # Validates error handling when offline
    Given the user has no network connectivity
    When the user attempts to send a sticker
    Then the system shows a send error
    And the sticker is not posted in the chat timeline

  @@regression @@edge-case
  Scenario Outline: Send sticker with different sticker types
    # Validates sticker sending across supported sticker types
    Given the user is in an active chat
    When the user sends a <sticker_type> sticker
    Then the sticker is displayed in the conversation for both participants

    Examples:
      | sticker_type |
      | static |
      | animated |

  @@regression @@boundary
  Scenario Outline: Send sticker with maximum allowed size
    # Validates boundary condition for sticker size limits
    Given the user is in an active chat
    When the user sends a sticker of size <size>
    Then the sticker is sent successfully when size is within limits
    And the system shows a validation error when size exceeds limits

    Examples:
      | size |
      | maximum allowed size |
      | above maximum allowed size |
