@@smoke @@regression
Feature: Videos senden
  As a registered user
  I want to send a video message to another user
  So that so that I can share rich media information to improve communication

  Background:
    Given the user is authenticated
    And the user is in a chat with another user

  @@smoke @@happy-path @@regression
  Scenario: Send a valid video successfully
    # Verifies a valid video is uploaded and delivered with status
    Given a valid video file within the allowed size is available
    When the user selects the video file and taps send
    Then the video is uploaded and delivered to the recipient
    And a visible message status is shown to the sender

  @@regression @@boundary
  Scenario Outline: Send video at size boundary
    # Validates behavior at the maximum allowed video size boundary
    Given a video file of size <file_size> is available
    When the user selects the video file and taps send
    Then the system <expected_outcome> the upload
    And the user sees <user_feedback>

    Examples:
      | file_size | expected_outcome | user_feedback |
      | exactly the maximum allowed size | allows | a visible message status |
      | one byte above the maximum allowed size | prevents | a clear size limit error message |

  @@negative @@regression
  Scenario Outline: Reject unsupported video format
    # Ensures unsupported formats are blocked with a clear message
    Given a file with format <file_format> is available
    When the user selects the file and taps send
    Then the system blocks the upload
    And the user is informed that the format is unsupported

    Examples:
      | file_format |
      | exe |
      | txt |

  @@negative @@regression
  Scenario: Handle network failure during upload
    # Shows failure status and allows retry when upload fails
    Given a valid video file within the allowed size is available
    When the network connection fails during the video upload
    Then a failure status is shown for the message
    And the user is allowed to retry sending the video
