@smoke @regression
Feature: Galerie-Zugriff
  As a mobile app user
  I want to select images from the device gallery
  So that to attach existing photos to complete tasks efficiently

  Background:
    Given the user is on a screen that supports adding media

  @@smoke @@regression @@happy-path
  Scenario: Open gallery and attach a single image
    # Verifies the user can open the gallery and attach one image
    When the user taps the option to add a photo
    Then the system opens the device gallery and displays available images
    When the user selects one image and confirms
    Then the selected image is attached and shown in the app

  @@regression @@happy-path
  Scenario Outline: Attach multiple images from gallery
    # Verifies multiple image selection and attachment
    When the user taps the option to add a photo
    Then the system opens the device gallery and displays available images
    When the user selects <image_count> images and confirms
    Then <image_count> images are attached and shown in the app

    Examples:
      | image_count |
      | 2 |
      | 5 |

  @@regression @@negative
  Scenario: Permission prompt blocks gallery access when not granted
    # Verifies permission is required before opening the gallery
    Given gallery permission is not granted
    When the user taps the option to add a photo
    Then the system prompts for gallery permission
    And the system does not open the gallery without consent

  @@regression @@edge
  Scenario: Attempt to attach zero images after opening gallery
    # Verifies no attachment occurs when user confirms with no selection
    When the user taps the option to add a photo
    Then the system opens the device gallery and displays available images
    When the user confirms without selecting any images
    Then no images are attached and the app remains unchanged

  @@regression @@boundary
  Scenario Outline: Attach up to the maximum allowed images
    # Verifies boundary condition at maximum selectable images
    Given the maximum allowed images is <max_images>
    When the user taps the option to add a photo
    Then the system opens the device gallery and displays available images
    When the user selects <max_images> images and confirms
    Then <max_images> images are attached and shown in the app

    Examples:
      | max_images |
      | 10 |
