@@smoke @@regression
Feature: Bildschirmfreigabe
  As a call participant
  I want to share their screen during a call
  So that so that all participants can view information in real time and collaborate effectively

  Background:
    Given a call is active with at least two participants

  @@smoke @@regression @@happy-path
  Scenario Outline: Start screen sharing successfully for a selected target
    # Verifies that a user with permissions can share a chosen screen or window
    Given the user has screen sharing permission granted by the OS
    When the user starts screen sharing for the <share_target>
    Then the <share_target> is shared with all call participants
    And participants can view the shared content in real time

    Examples:
      | share_target |
      | entire screen |
      | specific application window |

  @@regression @@happy-path
  Scenario: Stop screen sharing returns participants to standard call view
    # Verifies that stopping share ends sharing for all participants
    Given the user is currently sharing the screen
    When the user stops screen sharing
    Then screen sharing ends for all call participants
    And participants return to the standard call view

  @@regression @@negative
  Scenario: Attempt to start sharing without OS permission
    # Validates error handling when OS permission is not granted
    Given the user has not granted screen sharing permission in the OS
    When the user attempts to start screen sharing
    Then the system displays an error message
    And screen sharing does not start

  @@regression @@negative @@edge
  Scenario: Attempt to start sharing while already sharing
    # Edge case where a user tries to start a new share while a share is active
    Given the user is currently sharing the screen
    When the user attempts to start screen sharing again
    Then the system prevents a second screen sharing session from starting
    And the original screen sharing session continues

  @@regression @@edge
  Scenario: Boundary condition for minimal share target selection
    # Ensures sharing works when the smallest valid target is selected
    Given the user has screen sharing permission granted by the OS
    When the user selects the smallest available window and starts sharing
    Then the selected window is shared with all call participants
    And the shared content remains visible without cropping errors
