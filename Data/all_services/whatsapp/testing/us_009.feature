@smoke @regression
Feature: Telefonnummer anzeigen
  As a registered user
  I want to view my phone number in my profile
  So that so that I can verify my contact information is correct

  Background:
    Given the user profile service is available

  @@smoke @@regression @@happy-path
  Scenario Outline: Display saved phone number in profile
    # Verifies that a saved phone number is shown on the profile page
    Given I am logged in as a registered user
    And my profile contains the phone number "<phone_number>"
    When I open my profile page
    Then the phone number field displays "<phone_number>"
    And the phone number field is in read-only view mode

    Examples:
      | phone_number |
      | +49 170 1234567 |
      | +1 415 555 0199 |

  @@regression @@edge
  Scenario Outline: Handle missing phone number
    # Verifies that an empty or prompt state is shown when no phone number is saved
    Given I am logged in as a registered user
    And my profile does not contain a phone number
    When I open my profile page
    Then the phone number field shows "<display_state>"
    And no phone number value is displayed

    Examples:
      | display_state |
      | an empty value |
      | a prompt to add a phone number |

  @@regression @@negative
  Scenario: Redirect unauthenticated user from profile page
    # Verifies that unauthenticated access to profile redirects to login and hides phone number
    Given I am not authenticated
    When I attempt to access the profile page URL directly
    Then I am redirected to the login page
    And the phone number is not displayed

  @@regression @@boundary
  Scenario Outline: Display boundary length phone numbers
    # Verifies that phone numbers at boundary lengths are displayed without truncation
    Given I am logged in as a registered user
    And my profile contains the phone number "<phone_number>"
    When I open my profile page
    Then the phone number field displays "<phone_number>"
    And the phone number is not truncated or masked

    Examples:
      | phone_number |
      | 1234567 |
      | 123456789012345 |
