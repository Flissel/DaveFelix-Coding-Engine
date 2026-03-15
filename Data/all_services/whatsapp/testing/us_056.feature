@@smoke @@regression
Feature: HD-Medien
  As a registered user
  I want to send media in HD quality
  So that so that recipients receive clear, high-quality content for better communication

  Background:
    Given the user is authenticated and on the media send screen

  @@smoke @@regression @@happy-path
  Scenario: Send HD media successfully with stable network
    # Verifies that HD media is delivered when the file supports HD and the network is stable
    Given the user has an HD-capable media file
    And the network connection is stable
    When the user selects HD quality and sends the media
    Then the media is delivered in HD quality to the recipient
    And the sender sees a confirmation that HD was used

  @@regression @@negative
  Scenario: Prevent HD selection for non-HD media files
    # Ensures the system blocks HD selection and informs the user when the file does not support HD
    Given the user has a non-HD media file
    When the user attempts to select HD quality
    Then the system prevents HD selection
    And the user is informed that the file does not support HD

  @@regression @@negative
  Scenario: Notify and handle insufficient bandwidth when sending HD
    # Validates that the system notifies the user and queues or offers downgrade on insufficient bandwidth
    Given the user has an HD-capable media file
    And the network bandwidth is insufficient for HD
    When the user selects HD quality and sends the media
    Then the system notifies the user about insufficient bandwidth
    And the system queues the send or offers to downgrade quality

  @@regression
  Scenario Outline: Data-driven: HD send behavior by file capability and network quality
    # Covers boundary and edge conditions with varying file capability and network status
    Given the user has a <file_type> media file
    And the network condition is <network_condition>
    When the user selects HD quality and sends the media
    Then <expected_result>
    And <additional_check>

    Examples:
      | file_type | network_condition | expected_result | additional_check |
      | HD-capable | stable | the media is delivered in HD quality to the recipient | the sender sees a confirmation that HD was used |
      | HD-capable | insufficient bandwidth | the system notifies the user about insufficient bandwidth | the system queues the send or offers to downgrade quality |
      | non-HD | stable | the system prevents HD selection | the user is informed that the file does not support HD |
