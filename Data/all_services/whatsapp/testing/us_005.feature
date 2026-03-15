@smoke @regression
Feature: Passkey login support
  As a registered user
  I want to sign in using a passkey instead of a password
  So that to access my account quickly and securely without remembering a password

  Background:
    Given the user is on the login screen

  @smoke @regression @happy-path
  Scenario: Successful login with registered passkey
    # Verifies a registered user can authenticate with a passkey and access the account
    Given the user has a registered passkey for the account
    When the user selects passkey login
    And the user completes device authentication successfully
    Then the user is authenticated and logged in
    And the user sees the account home page

  @regression @happy-path
  Scenario Outline: Passkey login with different authenticators
    # Verifies passkey login succeeds across supported authenticator types
    Given the user has a registered passkey for the account
    And the authenticator type is <authenticator_type>
    When the user selects passkey login
    And the user completes device authentication successfully
    Then the user is authenticated and logged in

    Examples:
      | authenticator_type |
      | device biometrics |
      | security key |
      | platform PIN |

  @regression @negative
  Scenario: No passkey registered for account
    # Ensures users without a passkey are informed and can use alternative login
    Given the user does not have a registered passkey for the account
    When the user selects passkey login
    Then the system informs the user that no passkey is available
    And the system offers an alternative login method

  @regression @negative @error
  Scenario Outline: Passkey authentication failure or cancellation
    # Validates login is denied when device authentication fails or is cancelled
    Given the user has a registered passkey for the account
    When the user selects passkey login
    And device authentication results in <auth_result>
    Then the login is denied
    And the user can retry passkey login or choose another login method

    Examples:
      | auth_result |
      | authentication failed |
      | authentication cancelled |

  @regression @edge
  Scenario: Boundary condition for passkey availability check
    # Ensures the system handles the transition state where passkey registration was removed
    Given the user had a registered passkey but it was removed immediately before login
    When the user selects passkey login
    Then the system informs the user that no passkey is available
    And the system offers an alternative login method
