@@smoke @@regression
Feature: Siri/Google Assistant Voice Messaging
  As a registrierter Nutzer
  I want to Nachrichten per Siri/Google Assistant diktieren und versenden
  So that damit ich die App intuitiv und schnell sprachgesteuert nutzen kann, ohne die Hände zu verwenden

  Background:
    Given the user is logged in and the app is installed on a supported device

  @@smoke @@regression @@happy-path
  Scenario: Send dictated message successfully after confirmation
    # Happy path for dictating a message and sending after confirmation
    Given voice assistant integration is enabled and permission is granted
    And a valid contact exists in the user address book
    When the user dictates a message to the contact via voice assistant
    Then the system creates a message preview for the dictated content
    And the message is sent only after the user confirms the preview

  @@regression @@happy-path
  Scenario Outline: Send dictated message with supported assistant and language
    # Data-driven validation across assistants and languages
    Given voice assistant integration is enabled and permission is granted
    And the assistant is <assistant> and the app language is <language>
    When the user dictates "<message>" to contact <contact>
    Then the system shows a preview containing "<message>"
    And the message is sent after user confirmation

    Examples:
      | assistant | language | message | contact |
      | Siri | de-DE | Bin in 10 Minuten da | Max Mustermann |
      | Google Assistant | en-US | Running late by 5 minutes | Jane Doe |

  @@regression @@negative @@edge-case
  Scenario: Handle unclear or incomplete voice command
    # Edge case where dictation is unclear or missing required data
    Given voice assistant integration is enabled
    When the user provides an unclear or incomplete voice command
    Then the system prompts the user to уточify the command
    And no message is sent without explicit confirmation

  @@regression @@negative @@error
  Scenario Outline: Handle missing permission or network error
    # Error scenario where the assistant is unreachable
    Given voice assistant integration is enabled
    And assistant access fails due to <reason>
    When the user tries to dictate a message via the assistant
    Then the system informs the user about the error
    And the system offers an alternative input method in the app

    Examples:
      | reason |
      | missing permission |
      | network error |

  @@regression @@edge-case @@boundary
  Scenario Outline: Boundary condition: maximum message length
    # Validate behavior at the maximum allowed dictation length
    Given voice assistant integration is enabled and permission is granted
    And the maximum message length is <max_length> characters
    When the user dictates a message of <message_length> characters
    Then the system shows a preview with <expected_behavior>
    And the message is sent only after confirmation

    Examples:
      | max_length | message_length | expected_behavior |
      | 1000 | 1000 | the full message |
      | 1000 | 1001 | a validation message indicating the length limit |
