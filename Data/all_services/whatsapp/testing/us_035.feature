@@smoke @@regression
Feature: US-035 Encrypted Voice Calls
  As a registered user
  I want to place and receive encrypted voice calls
  So that so that my conversations remain confidential and compliant with security requirements

  Background:
    Given the user is authenticated and has a registered account

  @@smoke @@happy-path @@regression
  Scenario: Establish encrypted voice call successfully
    # Verifies end-to-end encrypted call is established when the other party is available
    Given the other party is available and supports encrypted calls
    When the user initiates a voice call
    Then the call is established
    And end-to-end encryption is enabled for the call

  @@regression @@edge-case
  Scenario: Maintain encryption under low-bandwidth conditions
    # Validates adaptive quality or notification while encryption remains enabled in low bandwidth
    Given the network condition is low-bandwidth
    When the user starts or continues a voice call
    Then end-to-end encryption remains enabled
    And the call proceeds with adaptive quality or a clear notification about quality impact is shown

  @@negative @@regression
  Scenario: Reject call when encryption setup fails
    # Ensures calls are not established and user is notified if encryption cannot be set up
    Given the other party does not support encrypted calls or encryption setup fails
    When the user attempts to start a voice call
    Then the call is not established
    And the user is informed of the encryption failure

  @@regression @@edge-case
  Scenario Outline: Encrypted call behavior by network quality
    # Data-driven validation of encryption and handling across bandwidth conditions
    Given the network condition is <network_condition>
    When the user initiates a voice call
    Then end-to-end encryption remains enabled
    And <expected_call_behavior>

    Examples:
      | network_condition | expected_call_behavior |
      | moderate-bandwidth | the call proceeds with acceptable quality and no notification |
      | low-bandwidth | the call proceeds with adaptive quality or a clear notification about quality impact is shown |
      | very-low-bandwidth | a clear notification about quality impact is shown |

  @@negative @@boundary @@regression
  Scenario: Call establishment boundary on encryption handshake timeout
    # Validates behavior when encryption setup exceeds the allowed timeout
    Given the encryption handshake takes longer than the allowed timeout
    When the user attempts to start a voice call
    Then the call is not established
    And the user is informed of the encryption failure

  @@regression @@negative
  Scenario Outline: Call establishment outcome by encryption capability
    # Data-driven validation of call setup based on other party encryption support
    Given the other party encryption capability is <capability>
    When the user initiates a voice call
    Then <call_outcome>
    And <user_message>

    Examples:
      | capability | call_outcome | user_message |
      | supports encryption | the call is established | end-to-end encryption is enabled for the call |
      | does not support encryption | the call is not established | the user is informed of the encryption failure |
