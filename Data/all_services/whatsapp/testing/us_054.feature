@@smoke @@regression
Feature: Audio-Dateien senden
  As a authenticated user
  I want to send an audio file through the system
  So that to share voice information efficiently and improve communication

  Background:
    Given the user is authenticated and has access to the send message feature

  @@smoke @@regression @@happy-path
  Scenario Outline: Send supported audio file successfully
    # Verifies that a supported audio file is delivered and playable by the recipient
    Given the user is on the send message screen
    When the user selects a supported audio file "<file_name>" within the size limit
    And the user sends the message
    Then the audio file is delivered successfully to the recipient
    And the recipient can play the audio file

    Examples:
      | file_name |
      | voice-note.mp3 |
      | meeting-summary.m4a |

  @@regression @@negative @@error
  Scenario Outline: Reject audio file exceeding size limit
    # Validates that files larger than the allowed limit are rejected with a clear error message
    Given the user is on the send message screen
    When the user selects an audio file "<file_name>" of size "<file_size_mb>" MB
    And the user submits the file
    Then the system rejects the file upload
    And a size limit error message is displayed stating the maximum allowed size is "<max_size_mb>" MB

    Examples:
      | file_name | file_size_mb | max_size_mb |
      | long-podcast.mp3 | 26 | 25 |

  @@regression @@negative @@error
  Scenario Outline: Prevent upload of unsupported audio file type
    # Ensures unsupported file types are blocked and the user is informed
    Given the user is on the send message screen
    When the user attempts to upload a file "<file_name>" with type "<file_type>" as audio
    Then the system prevents the upload
    And the user is informed that the format is not supported

    Examples:
      | file_name | file_type |
      | image.png | image/png |
      | document.pdf | application/pdf |

  @@regression @@boundary
  Scenario Outline: Send audio file at maximum allowed size boundary
    # Checks that a file exactly at the size limit is accepted
    Given the user is on the send message screen
    When the user selects a supported audio file "<file_name>" of size "<file_size_mb>" MB
    And the user sends the message
    Then the audio file is delivered successfully
    And the recipient can play the audio file

    Examples:
      | file_name | file_size_mb |
      | max-size-audio.mp3 | 25 |
