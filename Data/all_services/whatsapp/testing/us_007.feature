@smoke @regression
Feature: Display Name Configuration
  As a registered user
  I want to set and update my configurable display name
  So that so that my preferred name is shown to others while keeping my account identity consistent

  Background:
    Given the user is logged in

  @smoke @regression @happy-path
  Scenario: Set a valid display name successfully
    # Verifies that a valid display name is saved and shown across the application
    Given the user is on the profile settings page
    When the user enters a valid display name "Alex Doe" and saves
    Then the system stores the display name
    And the display name is shown wherever the user's name is displayed

  @regression @edge-case
  Scenario: Show default account name when display name is not set
    # Validates that the default account name is shown when no display name exists
    Given the user has not set a display name
    When the user views their profile
    Then the system shows the default name configured for the account

  @regression @negative
  Scenario Outline: Reject invalid or empty display names
    # Ensures invalid input is rejected with a validation message and no data is saved
    Given the user is on the profile settings page
    When the user enters "<invalid_name>" as the display name and saves
    Then the system rejects the change
    And a validation message is shown and the previous display name remains unchanged

    Examples:
      | invalid_name |
      |  |
      |     |
      | !@#$% |

  @regression @boundary
  Scenario Outline: Accept display names at minimum and maximum length boundaries
    # Validates boundary conditions for display name length
    Given the user is on the profile settings page
    When the user enters a display name with length "<length>" and saves
    Then the system stores the display name
    And the display name is shown wherever the user's name is displayed

    Examples:
      | length |
      | 1 |
      | 50 |
