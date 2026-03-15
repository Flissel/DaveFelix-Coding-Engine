@@smoke @@regression
Feature: Profilbild-Sichtbarkeit verwalten
  As a system administrator
  I want to configure profile picture visibility settings for user profiles
  So that to control privacy and compliance requirements while enabling appropriate user identification

  Background:
    Given the administrator is authenticated and on the profile visibility settings page

  @@happy-path @@smoke @@regression
  Scenario Outline: Set profile picture visibility successfully
    # Verifies that valid visibility selections are saved and applied
    When the administrator selects the visibility option "<visibility>"
    And the administrator clicks save
    Then the system stores the visibility setting as "<visibility>"
    And profile pictures are visible to "<expected_audience>"

    Examples:
      | visibility | expected_audience |
      | Everyone | all users |
      | Only me | their owners |

  @@negative @@regression
  Scenario: Do not save when no visibility option is selected
    # Validates that saving without a selection is blocked
    Given no visibility option is selected
    When the administrator clicks save
    Then a validation error is displayed
    And the current visibility setting remains unchanged

  @@edge-case @@regression
  Scenario Outline: Prevent saving when a previously saved option is unselected
    # Edge case where a saved value exists but the admin clears the selection before saving
    Given the current visibility setting is "<current_visibility>"
    When the administrator clears the selection
    And the administrator clicks save
    Then a validation error is displayed
    And the visibility setting remains "<current_visibility>"

    Examples:
      | current_visibility |
      | Everyone |
      | Only me |

  @@boundary @@regression
  Scenario Outline: Save operation is idempotent for the same selection
    # Boundary condition where saving the already selected option does not alter state
    Given the current visibility setting is "<current_visibility>"
    When the administrator re-selects "<current_visibility>"
    And the administrator clicks save
    Then the visibility setting remains "<current_visibility>"
    And no additional changes to profile picture visibility occur

    Examples:
      | current_visibility |
      | Everyone |
      | Only me |
