@@smoke @@regression
Feature: End-to-End Verschluesselung
  As a message sender
  I want to send a message that is end-to-end encrypted
  So that to ensure only intended recipients can read the content and protect confidentiality

  Background:
    Given the sender and recipient accounts are registered in the system
    And the messaging service is available

  @@smoke @@regression @@happy-path
  Scenario: Successful end-to-end encrypted message delivery
    # Valid keys allow the recipient to decrypt the message while the server handles only encrypted payloads
    Given the sender and recipient have valid encryption keys
    When the sender sends a message "Hello" to the recipient
    Then the message is encrypted on the sender device before transmission
    And the server stores and transmits only the encrypted payload
    And the recipient can decrypt and read the message content

  @@regression @@edge @@outline
  Scenario Outline: Edge case message sizes are encrypted and decrypted correctly
    # Boundary message sizes are handled end-to-end with encryption and decryption
    Given the sender and recipient have valid encryption keys
    When the sender sends a message with size <message_size> characters
    Then the message is encrypted on the sender device
    And the server stores and transmits only encrypted payloads
    And the recipient can decrypt and read the message

    Examples:
      | message_size |
      | 1 |
      | 1024 |
      | 4096 |

  @@regression @@negative @@error @@outline
  Scenario Outline: Recipient without valid decryption key cannot read message
    # Invalid or missing keys prevent decryption and show a user-facing error
    Given the sender has a valid encryption key
    And the recipient has an <key_state> decryption key for the message
    When the recipient attempts to read the message
    Then the message cannot be decrypted
    And an error is shown indicating decryption is not possible

    Examples:
      | key_state |
      | missing |
      | invalid |
      | expired |

  @@regression @@security
  Scenario: Server cannot decrypt messages in transit
    # System servers only handle encrypted payloads and cannot access plaintext
    Given the sender and recipient have valid encryption keys
    When the system processes a message in transit
    Then the server stores and transmits only the encrypted payload
    And the server cannot decrypt the message content
