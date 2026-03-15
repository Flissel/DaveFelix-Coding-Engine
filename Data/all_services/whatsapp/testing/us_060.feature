@smoke @regression
Feature: Block Contact
  As a registered user
  I want to block a contact
  So that to prevent unwanted communication and protect my privacy

  Background:
    Given a registered user is logged in

  @happy-path @smoke @regression
  Scenario Outline: Block an existing contact successfully
    # Validates that a user can block an existing contact and communication is prevented
    Given the user has the contact "<contact_name>" in their contact list
    When the user selects "<contact_name>" and chooses the block action
    Then the contact "<contact_name>" is marked as blocked
    And the contact "<contact_name>" can no longer send messages or requests to the user

    Examples:
      | contact_name |
      | Alice |
      | Bob |

  @edge @regression @negative
  Scenario Outline: Prevent duplicate blocking of an already blocked contact
    # Ensures the system blocks duplicate block attempts and informs the user
    Given the contact "<contact_name>" is already blocked
    When the user attempts to block "<contact_name>" again
    Then the system prevents duplicate blocking
    And the user is informed that the contact is already blocked

    Examples:
      | contact_name |
      | Charlie |

  @error @regression @negative
  Scenario Outline: Handle system error during block action
    # Verifies error handling when block action fails
    Given the user is viewing the contact "<contact_name>"
    When the user chooses the block action and a system error occurs
    Then an error message is displayed to the user
    And the block status of "<contact_name>" remains unchanged

    Examples:
      | contact_name |
      | Dana |

  @boundary @regression @negative
  Scenario Outline: Block action is unavailable for non-existing contact in list
    # Boundary condition to ensure block action cannot be performed on missing contacts
    Given the contact "<contact_name>" is not in the user's contact list
    When the user attempts to access the block action for "<contact_name>"
    Then the system prevents the block action
    And the user is informed that the contact does not exist in their list

    Examples:
      | contact_name |
      | Eve |
