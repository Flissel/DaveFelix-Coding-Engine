@@smoke @@regression
Feature: Bildbearbeitung vor dem Senden
  As a sender
  I want to perform basic image edits before sending
  So that so that images are properly adjusted and professional before being shared

  Background:
    Given the sender is authenticated and has selected an image in the compose screen

  @@smoke @@regression @@happy-path
  Scenario Outline: Apply a basic edit and save to send the edited image
    # Verifies that a saved basic edit replaces the original for preview and sending
    Given the image editor is opened for the selected image
    When the sender applies a basic edit and saves the changes
    Then the preview shows the edited image
    And the edited image is queued to be sent instead of the original

    Examples:
      | edit_type | details |
      | crop | crop to center square |
      | rotate | rotate 90 degrees clockwise |

  @@regression @@edge
  Scenario Outline: Reset or cancel edits returns to original image
    # Ensures reset/cancel discards changes and the original image will be sent
    Given the sender has applied unsaved edits in the image editor
    When the sender resets or cancels the edits
    Then the image returns to its original state in the preview
    And the original image is queued to be sent

    Examples:
      | action |
      | reset |
      | cancel |

  @@regression @@negative
  Scenario Outline: Unsupported format or edit failure prevents sending
    # Validates error handling when saving edits fails
    Given the sender attempts to save edits on an unsupported image or a failing operation
    When the system processes the save request
    Then an error message is displayed to the sender
    And sending is blocked until the issue is resolved or edits are discarded

    Examples:
      | failure_type | format |
      | unsupported_format | HEIC |
      | edit_operation_failure | JPG |

  @@regression @@boundary
  Scenario Outline: Boundary crop to minimum allowed dimensions
    # Checks boundary condition when cropping to the smallest permissible size
    Given the image editor is opened for the selected image
    When the sender crops the image to the minimum allowed dimensions and saves
    Then the preview shows the cropped image without distortion
    And the edited image is queued to be sent

    Examples:
      | min_width_px | min_height_px |
      | 64 | 64 |
