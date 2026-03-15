@@smoke @@regression
Feature: Watch-App
  As a smartwatch user
  I want to connect their smartwatch to the system to receive and interact with app notifications
  So that so they can access key updates quickly without using their phone, improving responsiveness and engagement

  Background:
    Given the mobile app is installed and the user is logged in

  @@smoke @@regression @@happy-path
  Scenario: Pair supported smartwatch successfully
    # Validates successful pairing flow and confirmation on both devices
    Given a supported smartwatch is powered on and within pairing range
    When the user initiates smartwatch pairing from the app
    Then the system completes pairing
    And the connection is confirmed on both the mobile app and the smartwatch

  @@regression @@happy-path
  Scenario: Notification delivered within acceptable time frame
    # Validates notification delivery after successful connection
    Given the smartwatch is connected to the system
    When a new notification is generated in the system
    Then the notification is delivered and displayed on the smartwatch within the acceptable time frame

  @@regression @@negative @@error
  Scenario: Block unsupported smartwatch models
    # Ensures unsupported models are rejected with a clear message
    Given an unsupported smartwatch model is available for pairing
    When the user attempts to connect the smartwatch
    Then the system blocks the connection
    And a clear unsupported-device message is shown to the user

  @@regression @@error
  Scenario: Handle unexpected disconnection
    # Ensures user is informed and reconnection is attempted or guidance is provided
    Given the smartwatch is connected to the system
    When the smartwatch loses connection unexpectedly
    Then the app informs the user about the disconnection
    And the system attempts to reconnect or provides instructions to reconnect

  @@regression @@edge @@boundary
  Scenario Outline: Pairing attempts with boundary signal strength
    # Validates pairing behavior near the lower limit of acceptable signal strength
    Given a supported smartwatch is powered on with Bluetooth signal strength at <signal_level>
    When the user initiates smartwatch pairing from the app
    Then the system returns pairing result as <pairing_result>
    And the app displays the message <message>

    Examples:
      | signal_level | pairing_result | message |
      | minimum acceptable threshold | successful | Pairing complete |
      | below minimum acceptable threshold | failed | Unable to pair due to weak signal |

  @@regression @@edge @@boundary
  Scenario Outline: Notification delivery latency boundary conditions
    # Verifies delivery time at and just beyond the acceptable limit
    Given the smartwatch is connected to the system
    When a notification is generated with delivery latency of <latency_ms> milliseconds
    Then the delivery outcome is <outcome>
    And the app records the latency as <latency_recorded>

    Examples:
      | latency_ms | outcome | latency_recorded |
      | 5000 | delivered within acceptable time frame | within threshold |
      | 5001 | delivered outside acceptable time frame | exceeds threshold |

  @@regression @@negative @@error
  Scenario Outline: Prevent pairing when permissions are denied
    # Ensures pairing is blocked if required permissions are not granted
    Given a supported smartwatch is powered on and within pairing range
    And Bluetooth permission is set to <permission_state> in the mobile app
    When the user initiates smartwatch pairing from the app
    Then the system blocks pairing
    And the app displays the message <message>

    Examples:
      | permission_state | message |
      | denied | Bluetooth permission is required to pair a smartwatch |
      | restricted | Bluetooth permission is required to pair a smartwatch |
