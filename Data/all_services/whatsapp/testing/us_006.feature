@smoke @regression
Feature: US-006 Profilbild hochladen und verwalten
  As a registered user
  I want to upload and manage a profile picture
  So that so that my account is easily recognizable and personalized

  Background:
    Given I am logged in and on my profile settings page

  @@smoke @@regression @@happy-path
  Scenario: Upload a valid profile picture within size limit
    # Verifies successful upload and display of a valid image
    When I upload a valid image file within the allowed size limit
    Then the system saves the image
    And the image is displayed as my current profile picture

  @@regression @@happy-path
  Scenario: Replace existing profile picture with a new valid image
    # Ensures an existing profile picture is replaced by a new valid image
    Given I already have a profile picture
    When I upload a new valid image file
    Then the system replaces the existing profile picture with the new one

  @@regression @@negative
  Scenario Outline: Reject invalid file types and oversized files
    # Validates error handling for non-image files and files exceeding size limit
    When I attempt to upload an invalid file
    Then the system rejects the upload
    And a clear error message is shown

    Examples:
      | file_type | file_size | reason |
      | PDF document | 1 MB | not an image |
      | JPEG image | 6 MB | exceeds size limit |

  @@regression @@boundary
  Scenario Outline: Boundary conditions for file size limits
    # Checks acceptance at maximum allowed size and rejection just above it
    When I upload an image file with size <size>
    Then the upload result is <result>
    And the system shows <message>

    Examples:
      | size | result | message |
      | 5 MB | accepted | the image is displayed as my current profile picture |
      | 5.1 MB | rejected | a clear error message |

  @@regression @@happy-path
  Scenario: Remove existing profile picture
    # Ensures removing a profile picture restores the default placeholder
    Given I have a profile picture
    When I choose to remove it
    Then the system deletes the profile picture
    And a default placeholder is shown

  @@regression @@negative @@edge
  Scenario: Attempt upload with corrupted image file
    # Validates rejection of corrupted image files
    When I upload a corrupted image file
    Then the system rejects the upload
    And a clear error message is shown
