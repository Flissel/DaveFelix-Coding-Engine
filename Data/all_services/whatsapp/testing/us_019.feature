@@smoke @@regression
Feature: Einmal-Ansicht Medien
  As a messaging user
  I want to send and view media that can be opened only once
  So that to share sensitive content with reduced risk of repeated access

  Background:
    Given sender and recipient accounts exist and are able to exchange messages

  @@smoke @@happy-path
  Scenario: Send view-once media and open it exactly once
    # Verifies recipient can open view-once media a single time and it is marked as opened
    Given the sender selects a media file and enables view-once
    When the sender sends the media to the recipient
    And the recipient opens the view-once media
    Then the media is displayed to the recipient
    And the media is marked as opened and unavailable for future opens

  @@regression @@negative
  Scenario: Prevent re-opening a view-once media
    # Ensures system blocks access when media has already been opened
    Given the recipient has already opened a view-once media message
    When the recipient attempts to open the same media again
    Then the system prevents access to the media
    And a message indicates the media can only be viewed once

  @@regression @@edge-case
  Scenario: Open view-once media after offline delivery
    # Validates view-once media remains accessible exactly once after offline period
    Given the recipient is offline when the view-once media is delivered
    When the recipient comes online and opens the media
    Then the media is displayed exactly once
    And the media becomes unavailable after the first open

  @@regression @@boundary
  Scenario Outline: View-once media types and sizes boundary validation
    # Verifies supported media types and size limits for view-once behavior
    Given the sender selects a <media_type> file with size <file_size_mb> MB and enables view-once
    When the sender sends the media to the recipient
    Then the system accepts the media and delivers it successfully
    And the recipient can open the media exactly once

    Examples:
      | media_type | file_size_mb |
      | image | 1 |
      | video | 25 |

  @@regression @@negative
  Scenario Outline: Reject unsupported media type for view-once
    # Ensures unsupported media types cannot be sent as view-once
    Given the sender selects an unsupported <media_type> file and enables view-once
    When the sender attempts to send the media
    Then the system blocks the send action
    And an error message indicates the media type is not supported for view-once

    Examples:
      | media_type |
      | audio |
      | document |
