@@smoke @@regression
Feature: Melden
  As a registered user
  I want to report a message or contact
  So that to flag inappropriate content so it can be reviewed and addressed

  Background:
    Given the user is authenticated and viewing a message or contact details

  @@smoke @@regression @@happy-path
  Scenario: Report message or contact with a valid reason
    # Valid report is submitted and recorded for review
    Given the report dialog is open for the selected item
    When the user selects a valid reason and submits the report
    Then the system confirms the report submission
    And the system records the report for review

  @@regression @@negative @@error
  Scenario: Prevent submission when no reason is selected
    # Reporting without a reason is blocked with a prompt
    Given the report dialog is open for the selected item
    When the user submits the report without selecting a reason
    Then the system prevents the submission
    And the system prompts the user to select a reason

  @@regression @@negative @@edge
  Scenario: Block duplicate reports for the same item
    # Duplicate report attempt is prevented and user is informed
    Given the user has already reported the selected item
    When the user attempts to report the same item again
    Then the system informs the user it has already been reported
    And the system does not create a duplicate report

  @@regression @@happy-path
  Scenario Outline: Scenario Outline: Report different item types with valid reasons
    # Data-driven validation for item type and reason combinations
    Given the user is viewing a <item_type>
    When the user selects the reason <reason> and submits the report
    Then the system confirms the report submission
    And the system records the report for review

    Examples:
      | item_type | reason |
      | message | spam |
      | contact | harassment |
      | message | inappropriate content |

  @@regression @@edge
  Scenario Outline: Scenario Outline: Boundary validation for maximum reason selection
    # Ensure only one reason can be selected when UI allows multiple toggles
    Given the report dialog is open for the selected item
    When the user selects reasons <first_reason> and <second_reason>
    Then the system allows only one reason to be selected
    And the submission uses the last selected reason

    Examples:
      | first_reason | second_reason |
      | spam | harassment |
      | inappropriate content | other |
