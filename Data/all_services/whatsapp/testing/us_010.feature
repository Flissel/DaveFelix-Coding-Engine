@smoke @regression
Feature: QR-Code Profil
  As a registered user
  I want to generate a scannable QR code for my profile
  So that so others can quickly add my profile without manual entry

  Background:
    Given the QR code generation feature is available

  @happy-path @smoke @regression
  Scenario: Generate QR code successfully for complete profile
    # Verifies that an authenticated user with complete profile can generate a scannable QR code linking to their profile
    Given the user is authenticated and viewing their profile
    And the user profile data is complete
    When the user selects the option to generate a QR code
    Then the system displays a scannable QR code
    And the QR code links to the user's profile URL

  @negative @regression
  Scenario: Prevent QR generation when required profile data is missing
    # Validates that QR code generation is blocked and missing data is indicated
    Given the user is authenticated and viewing their profile
    And the user profile is missing required data
    When the user attempts to generate a QR code
    Then the system prevents QR code generation
    And the system shows a message listing the missing data

  @negative @regression
  Scenario: Deny QR generation access for unauthenticated user
    # Ensures unauthenticated users are prompted to sign in when accessing QR generation
    Given the user is not authenticated
    When the user attempts to access the QR code generation feature
    Then the system denies access
    And the system prompts the user to sign in

  @edge @regression
  Scenario Outline: Generate QR code for multiple profile URL formats
    # Checks that QR codes are generated for valid profile URL formats
    Given the user is authenticated and viewing their profile
    And the user profile data is complete
    And the profile URL format is <url_format>
    When the user selects the option to generate a QR code
    Then the system displays a scannable QR code
    And the QR code links to the profile URL in the same format

    Examples:
      | url_format |
      | https URL |
      | custom domain URL |

  @boundary @regression
  Scenario: Boundary check for maximum profile data length before QR generation
    # Validates that QR generation works when profile data is at the maximum allowed length
    Given the user is authenticated and viewing their profile
    And the user profile data is complete
    And the profile data fields are at their maximum allowed length
    When the user selects the option to generate a QR code
    Then the system displays a scannable QR code
    And the QR code links to the user's profile URL
