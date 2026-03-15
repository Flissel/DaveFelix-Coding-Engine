@@smoke @@regression
Feature: Zwei-Faktor-Authentifizierung
  As a registered user
  I want to enable and use optional two-factor authentication with a 6-digit PIN
  So that increase account security against unauthorized access

  Background:
    Given the user is registered and logged in

  @@happy-path @@smoke @@regression
  Scenario: Enable 2FA with valid 6-digit PIN
    # Verifies that a user can enable 2FA with a valid PIN and it is required on next login
    Given the user has access to security settings
    When the user enables 2FA and verifies a valid 6-digit PIN
    Then 2FA is activated for the account
    And a 6-digit PIN is required for subsequent logins

  @@happy-path @@regression
  Scenario: Login with 2FA enabled and correct PIN
    # Ensures login succeeds when correct credentials and PIN are provided
    Given 2FA is enabled for the user
    When the user logs in with correct credentials and enters the correct 6-digit PIN
    Then the user is authenticated and granted access

  @@negative @@regression
  Scenario: Login denied with incorrect 6-digit PIN
    # Validates access is denied when an incorrect PIN is entered
    Given 2FA is enabled for the user
    When the user logs in with correct credentials and enters an incorrect 6-digit PIN
    Then access is denied
    And an error message is displayed

  @@happy-path @@regression
  Scenario: Disable 2FA successfully
    # Checks that a user can disable 2FA and login no longer requires a PIN
    Given 2FA is enabled for the user
    And the user has access to security settings
    When the user disables 2FA
    Then 2FA is deactivated for the account
    And no PIN is required for subsequent logins

  @@negative @@regression
  Scenario Outline: Validate PIN format when enabling 2FA
    # Covers edge and boundary cases for PIN format validation
    Given the user has access to security settings
    When the user attempts to enable 2FA with PIN "<pin>"
    Then the system rejects the PIN
    And a validation message is displayed

    Examples:
      | pin |
      | 12345 |
      | 1234567 |
      | 12a456 |
      | 00000 |

  @@edge @@regression
  Scenario Outline: Accept boundary-valid 6-digit PINs when enabling 2FA
    # Ensures boundary-valid PINs are accepted, including leading zeros
    Given the user has access to security settings
    When the user enables 2FA with PIN "<pin>"
    Then 2FA is activated for the account

    Examples:
      | pin |
      | 000000 |
      | 999999 |
