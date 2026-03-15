@@smoke @@regression
Feature: Telefonnummer-Registrierung
  As a new user
  I want to register with a mobile phone number and complete verification
  So that to securely create an account and access the system

  Background:
    Given the user is on the registration screen

  @@smoke @@regression @@happy-path
  Scenario: Successful registration with valid phone number and correct code
    # Verifies account creation when a valid unused phone number is submitted and the correct code is entered within the allowed time
    Given the user has an unused valid mobile phone number
    When the user submits the phone number
    And the user enters the correct verification code within the allowed time
    Then the account is created
    And the phone number is marked as verified

  @@regression @@negative
  Scenario Outline: Reject invalid or improperly formatted phone numbers
    # Ensures validation errors are shown for invalid phone number formats
    When the user enters an invalid phone number "<phone_number>"
    And the user attempts to submit the registration form
    Then the system rejects the input
    And a validation message is displayed

    Examples:
      | phone_number |
      | 12345 |
      | +49-abc-7890 |
      |  |

  @@regression @@negative
  Scenario Outline: Deny verification for incorrect or expired codes
    # Validates that incorrect or expired verification codes are rejected and a new code can be requested
    Given the user has submitted a valid phone number
    And the system has sent a verification code
    When the user enters a "<code_status>" verification code
    Then the system denies verification
    And the user is allowed to request a new code

    Examples:
      | code_status |
      | incorrect |
      | expired |

  @@regression @@boundary
  Scenario Outline: Boundary validation for phone number length
    # Checks acceptance at minimum and maximum allowed phone number lengths and rejection outside the boundaries
    When the user enters a phone number with length "<length_status>"
    And the user submits the registration form
    Then the system "<outcome>" the input

    Examples:
      | length_status | outcome |
      | minimum allowed | accepts |
      | maximum allowed | accepts |
      | below minimum | rejects |
      | above maximum | rejects |
