@smoke @regression
Feature: Multi-Device Support
  As a registered user
  I want to use the system concurrently on multiple devices
  So that to stay productive and continue work seamlessly across devices

  Background:
    Given a registered user account exists with valid credentials

  @happy-path @smoke @regression
  Scenario: Concurrent sessions remain active on two devices
    # Validates that a user can log in on a second device without terminating the first session
    Given the user is authenticated and active on Device A
    When the user logs in on Device B with the same account
    Then both Device A and Device B sessions remain active
    And the user can navigate and perform actions on both devices

  @happy-path @regression
  Scenario: Actions from either device do not terminate the other session
    # Ensures actions on one device are processed without impacting the other session
    Given the user is active on Device A and Device B
    When the user performs an action on Device A
    Then the action is processed successfully
    And the session on Device B remains active and usable

  @edge-case @regression
  Scenario: Allow third device session without blocking other devices
    # Verifies the system allows a third concurrent session
    Given the user is active on Device A and Device B
    When the user logs in on Device C with the same account
    Then the session on Device C is created successfully
    And sessions on Device A and Device B remain active

  @negative @regression
  Scenario: Concurrent login with invalid credentials is rejected on one device
    # Validates error handling when a third device uses incorrect credentials
    Given the user is active on Device A and Device B
    When an attempt is made to log in on Device C with invalid credentials
    Then the login on Device C is rejected with an authentication error
    And sessions on Device A and Device B remain active

  @edge-case @regression
  Scenario Outline: Concurrent sessions across device types and networks
    # Data-driven coverage for multiple device types and network conditions
    Given the user is authenticated on <device_a> using <network_a>
    When the user logs in on <device_b> using <network_b>
    Then both sessions remain active and usable concurrently
    And actions from either device are processed successfully

    Examples:
      | device_a | network_a | device_b | network_b |
      | iOS phone | Wi-Fi | Android tablet | 4G |
      | Windows desktop | Ethernet | Mac laptop | Wi-Fi |

  @boundary @regression
  Scenario Outline: Boundary: multiple concurrent sessions up to defined limit
    # Validates system behavior at the maximum supported concurrent session limit
    Given the system supports up to <max_sessions> concurrent sessions per user
    When the user logs in on <max_sessions> different devices
    Then all <max_sessions> sessions remain active and usable
    And no session is terminated by the system

    Examples:
      | max_sessions |
      | 3 |
