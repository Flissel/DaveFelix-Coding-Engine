@@smoke @@regression
Feature: Two-Step Verification (PIN)
  As a registered user
  I want to enable an optional additional PIN verification step for my account
  So that to increase the security of sensitive actions and protect my account from unauthorized access

  Background:
    Given the user is logged in

  @@smoke @@regression @@happy-path
  Scenario Outline: Enable additional PIN verification with a valid PIN
    # Verifies that the system saves a valid PIN and enables additional verification
    Given additional PIN verification is not enabled
    When the user enables additional PIN verification and sets PIN <pin>
    Then the system saves the PIN
    And the system marks additional PIN verification as enabled

    Examples:
      | pin |
      | 1234 |
      | 987654 |

  @@smoke @@regression @@happy-path
  Scenario Outline: Perform a protected action with the correct PIN
    # Verifies protected actions proceed when the correct PIN is entered
    Given additional PIN verification is enabled with PIN <pin>
    When the user performs the protected action <action> and enters the correct PIN <pin>
    Then the system allows the protected action to proceed

    Examples:
      | pin | action |
      | 1234 | change email |
      | 987654 | delete account |

  @@regression @@negative
  Scenario Outline: Block a protected action when an incorrect PIN is entered
    # Verifies the system blocks actions and shows an error for wrong PIN
    Given additional PIN verification is enabled with PIN <pin>
    When the user performs the protected action <action> and enters the incorrect PIN <wrong_pin>
    Then the system blocks the protected action
    And the system displays an error message indicating the PIN is incorrect

    Examples:
      | pin | wrong_pin | action |
      | 1234 | 0000 | change password |
      | 987654 | 111111 | update billing details |

  @@regression @@happy-path
  Scenario: Disable additional PIN verification
    # Verifies disabling the PIN removes the requirement for future protected actions
    Given additional PIN verification is enabled
    When the user disables additional PIN verification
    Then the system removes the additional PIN requirement for future protected actions
    And the system marks additional PIN verification as disabled

  @@regression @@edge-case
  Scenario Outline: Accept boundary PIN lengths when enabling verification
    # Verifies minimum and maximum valid PIN lengths are accepted
    Given additional PIN verification is not enabled
    When the user enables additional PIN verification and sets PIN <pin>
    Then the system saves the PIN
    And the system marks additional PIN verification as enabled

    Examples:
      | pin |
      | 1234 |
      | 123456 |

  @@regression @@negative @@error
  Scenario Outline: Reject invalid PIN formats when enabling verification
    # Verifies invalid PIN formats are rejected and not saved
    Given additional PIN verification is not enabled
    When the user attempts to enable additional PIN verification with PIN <pin>
    Then the system does not save the PIN
    And the system displays a validation error for the PIN

    Examples:
      | pin |
      | 12 |
      | 1234567 |
      | 12ab |
