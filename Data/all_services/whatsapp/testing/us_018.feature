@@smoke @@regression
Feature: US-018 Verschwindende Nachrichten
  As a registered user
  I want to send a self-destructing message with a specified expiration time
  So that so that sensitive information is automatically removed after a set period

  Background:
    Given a registered user is authenticated and can compose messages

  @@smoke @@happy-path
  Scenario: Send a self-destructing message and view it before expiration
    # Valid expiration time allows recipient to view message before it expires
    Given the sender composes a new message to a valid recipient
    When the sender sets a valid expiration time of 10 minutes and sends the message
    Then the recipient can view the message content
    And the system schedules deletion for 10 minutes after send time

  @@regression @@happy-path
  Scenario: Self-destructing message is deleted after expiration
    # Message content becomes inaccessible after expiration and shows expired indicator
    Given a self-destructing message was sent with an expiration time of 1 minute
    When the expiration time has elapsed
    Then both sender and recipient cannot access the message content
    And an expired indicator is displayed in place of the message content

  @@negative @@regression
  Scenario Outline: Reject invalid expiration time
    # System rejects zero or negative expiration time values
    Given the sender composes a new message to a valid recipient
    When the sender attempts to send the message with an expiration time of <invalid_time> minutes
    Then the system rejects the request
    And the user is prompted to provide a valid expiration time

    Examples:
      | invalid_time |
      | 0 |
      | -5 |

  @@regression @@boundary
  Scenario Outline: Boundary expiration time values are accepted
    # System accepts minimum and maximum allowed expiration time values
    Given the sender composes a new message to a valid recipient
    When the sender sets an expiration time of <boundary_time> minutes and sends the message
    Then the message is sent successfully
    And the recipient can view the message before it expires

    Examples:
      | boundary_time |
      | 1 |
      | 1440 |
