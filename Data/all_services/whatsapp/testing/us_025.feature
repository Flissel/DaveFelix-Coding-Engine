@smoke @regression
Feature: Kontakt teilen
  As a registered user
  I want to share a contact's details with another person
  So that to easily exchange contact information and improve communication

  Background:
    Given the user is authenticated and viewing a saved contact

  @@smoke @@regression @@happy-path
  Scenario Outline: Share contact with a selected recipient
    # Verifies successful sharing with one or more recipients
    Given the share contact dialog is open
    When the user selects recipient(s) "<recipients>" and confirms share
    Then the contact details are shared successfully with "<recipients>"
    And a success confirmation is displayed

    Examples:
      | recipients |
      | alice@example.com |
      | alice@example.com, bob@example.com |

  @@regression @@negative @@edge
  Scenario: Prevent sharing without selecting a recipient
    # Ensures the user must select at least one recipient
    Given the share contact dialog is open
    When the user confirms share without selecting any recipient
    Then the system prompts the user to select a recipient
    And the contact is not shared

  @@regression @@negative @@error
  Scenario Outline: Handle system error during sharing
    # Validates error handling when sharing fails
    Given the share contact dialog is open
    And a system error occurs during the share request
    When the user confirms share with recipient "<recipient>"
    Then an error message is displayed
    And the contact is not shared

    Examples:
      | recipient |
      | alice@example.com |

  @@regression @@boundary
  Scenario Outline: Share contact with maximum allowed recipients
    # Checks boundary condition for recipient count limit
    Given the share contact dialog is open
    When the user selects exactly "<max_recipients>" recipients and confirms share
    Then the contact details are shared successfully with all selected recipients
    And no recipient limit warning is shown

    Examples:
      | max_recipients |
      | 10 |
