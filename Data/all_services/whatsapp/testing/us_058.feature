@smoke @regression
Feature: Sicherheitscode-Verifizierung
  As a security administrator
  I want to manually verify the encryption security code for a stored asset
  So that to ensure encryption compliance and reduce the risk of data breaches

  Background:
    Given the security administrator is authenticated
    And the stored asset verification screen is open

  @happy-path @smoke @regression
  Scenario: Successful manual verification of a valid encryption security code
    # Verifies that a valid code is accepted and recorded with verifier and timestamp
    Given a stored asset with a valid encryption security code exists
    When the security administrator initiates manual verification for that asset
    Then the system verifies the code successfully
    And a verification record is saved with the verifier and current timestamp

  @negative @regression
  Scenario Outline: Reject manual verification for invalid or mismatched codes
    # Ensures invalid or mismatched codes are rejected with an error and failure record
    Given a stored asset with an encryption security code exists
    And the provided verification code is <provided_code>
    When the security administrator initiates manual verification for that asset
    Then the system rejects the verification
    And a clear error message is displayed and a failure record is saved

    Examples:
      | provided_code |
      | WRONGCODE123 |
      | MISMATCH-000 |

  @negative @regression
  Scenario: Prevent manual verification when no encryption security code is available
    # Ensures verification is blocked when the asset has no code
    Given a stored asset without an encryption security code exists
    When the security administrator attempts manual verification for that asset
    Then the system prevents verification
    And the user is informed that no code is available

  @edge-case @regression
  Scenario Outline: Boundary validation for encryption security code length
    # Validates acceptance and rejection at minimum and maximum allowed code lengths
    Given a stored asset with an encryption security code of length <code_length> exists
    When the security administrator initiates manual verification for that asset
    Then the verification result is <expected_result>
    And <expected_message> is displayed

    Examples:
      | code_length | expected_result | expected_message |
      | 1 | rejected | a clear error message |
      | 64 | verified | a success confirmation |
      | 65 | rejected | a clear error message |
