@smoke @regression
Feature: US-047 Bilder senden
  As a end user
  I want to send images through the system
  So that so that I can share visual information to improve communication

  Background:
    Given the user is on the messaging/composition screen

  @@smoke @@regression @@happy-path
  Scenario Outline: Send supported image successfully
    # Verifies that supported image formats can be sent and displayed to the recipient
    Given a supported image file <file_name> of size <file_size_mb> MB is available
    When the user selects the image and taps send
    Then the image is sent successfully
    And the recipient displays the image

    Examples:
      | file_name | file_size_mb |
      | photo.jpg | 2.0 |
      | diagram.png | 4.5 |
      | scan.jpeg | 0.8 |

  @@regression @@edge-case @@boundary
  Scenario Outline: Send image at size limit boundary
    # Validates that an image at or just below the size limit can be sent
    Given the maximum allowed image size is <max_size_mb> MB
    And a supported image file <file_name> of size <file_size_mb> MB is available
    When the user selects the image and taps send
    Then the image is sent successfully
    And no size limit error is displayed

    Examples:
      | max_size_mb | file_name | file_size_mb |
      | 5.0 | limit_exact.png | 5.0 |
      | 5.0 | limit_below.png | 4.99 |

  @@regression @@negative @@error
  Scenario Outline: Block sending image larger than size limit
    # Ensures the system blocks images exceeding the size limit and shows an error message
    Given the maximum allowed image size is <max_size_mb> MB
    And a supported image file <file_name> of size <file_size_mb> MB is available
    When the user attempts to send the image
    Then the system blocks the send
    And a clear size limit error message is displayed

    Examples:
      | max_size_mb | file_name | file_size_mb |
      | 5.0 | too_large.jpg | 5.01 |
      | 5.0 | very_large.jpg | 10.0 |

  @@regression @@negative @@error
  Scenario Outline: Reject unsupported file format
    # Ensures non-image files are rejected with an informative message
    Given a file <file_name> of size <file_size_mb> MB is available
    When the user attempts to send the file
    Then the system rejects the file
    And the user is informed that only image formats are supported

    Examples:
      | file_name | file_size_mb |
      | document.pdf | 1.2 |
      | archive.zip | 3.4 |
      | script.exe | 0.7 |
