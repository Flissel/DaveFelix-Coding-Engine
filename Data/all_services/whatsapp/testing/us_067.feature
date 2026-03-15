@smoke @regression
Feature: Schnellantwort
  As a end user
  I want to reply directly from a notification
  So that to respond faster without opening the app

  Background:
    Given the user is logged in and has notifications enabled

  @happy-path @smoke @regression
  Scenario Outline: Reply successfully from a notification
    # Verifies that a reply sent from a supported notification is delivered and updates the conversation
    Given the user receives a notification that supports inline replies for an active conversation
    When the user enters a reply '<message>' and sends it from the notification
    Then the reply is delivered successfully
    And the conversation shows the new reply

    Examples:
      | message |
      | Sure, I will be there at 5. |
      | Thanks! |

  @edge-case @regression
  Scenario Outline: Queue reply while offline and send on reconnect
    # Verifies that replies sent from notifications while offline are queued and delivered when connectivity returns
    Given the user receives a notification that supports inline replies for an active conversation
    And the device is offline
    When the user enters a reply '<message>' and sends it from the notification
    Then the reply is queued for delivery
    And the queued reply is sent when connectivity is restored

    Examples:
      | message |
      | I am on my way. |
      | Can we reschedule? |

  @negative @regression
  Scenario Outline: Prevent reply when notification is outdated or conversation unavailable
    # Verifies that the system blocks replies from invalid notifications and informs the user
    Given the user receives a notification for a conversation that is '<state>'
    When the user attempts to send a reply from the notification
    Then the system prevents the reply from being sent
    And the user is informed that the reply cannot be delivered

    Examples:
      | state |
      | deleted |
      | archived |
      | expired |

  @boundary @regression
  Scenario Outline: Reply boundary conditions for message length
    # Verifies handling of replies at minimum and maximum allowed lengths
    Given the user receives a notification that supports inline replies for an active conversation
    When the user enters a reply with length '<length>' and sends it from the notification
    Then the system processes the reply according to length validation rules
    And the user receives appropriate feedback on the result

    Examples:
      | length |
      | 1 |
      | 500 |
      | 501 |
