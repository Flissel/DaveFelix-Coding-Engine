@smoke @regression
Feature: Kamera-Integration
  As a chat user
  I want to open the device camera directly from the chat to capture and send a photo
  So that so I can share visual information instantly without leaving the conversation

  Background:
    Given the user is logged in and is viewing an active chat

  @smoke @regression @happy-path
  Scenario: Capture and send a photo from chat
    # Validates that the camera opens and a captured photo is sent to the chat
    Given the device has a functioning camera and permission is granted
    When the user taps the camera icon in the chat composer
    And the user captures a photo and confirms send
    Then the photo is sent and appears in the chat thread
    And the chat remains open without navigation away

  @regression @edge
  Scenario: Prompt for camera permission and proceed when granted
    # Ensures permission prompt is shown and flow continues only on grant
    Given camera permission has not been granted
    When the user taps the camera icon in the chat composer
    Then the system prompts the user for camera permission
    And the camera opens only after the user grants permission

  @regression @negative
  Scenario: Handle camera unavailable or restricted access
    # Shows an error when the camera is not available
    Given the device has no camera or access is restricted
    When the user taps the camera icon in the chat composer
    Then an error message indicates the camera is unavailable
    And the application does not crash and remains in the chat

  @regression @negative
  Scenario Outline: Permission decision outcomes
    # Validates system behavior based on permission decision
    Given camera permission has not been granted
    When the user responds to the permission prompt with <decision>
    Then the system behavior is <result>

    Examples:
      | decision | result |
      | Allow | the camera opens and allows capturing a photo |
      | Deny | the camera does not open and an informative message is shown |

  @regression @edge
  Scenario Outline: Capture outcomes
    # Validates boundary behavior for capture confirmation vs cancellation
    Given the camera is open from the chat
    When the user performs <action>
    Then <expected_result>

    Examples:
      | action | expected_result |
      | capture a photo and confirm send | the photo is sent and appears in the chat thread |
      | cancel the camera without capturing | no photo is sent and the user returns to the chat composer |
