@@smoke @@regression
Feature: Gruppeneinstellungen verwalten
  As a group administrator
  I want to configure group settings
  So that to tailor group behavior to meet organizational needs and improve collaboration

  Background:
    Given the group exists and the group settings page is available

  @@smoke @@regression @@happy-path
  Scenario: Administrator saves valid group settings successfully
    # Verifies that valid settings are persisted and a confirmation is shown
    Given the user is a group administrator with valid permissions
    And the administrator is on the group settings page
    When the administrator updates configurable settings to valid values and saves
    Then the system persists the changes
    And a confirmation message is displayed

  @@regression @@negative
  Scenario Outline: Validation errors are shown for invalid settings values
    # Ensures invalid values are rejected and validation messages are displayed
    Given the user is a group administrator with valid permissions
    And the administrator is on the group settings page
    When the administrator enters an invalid value for <field> and saves
    Then the system rejects the save
    And a validation error is shown for <field>

    Examples:
      | field |
      | group name |
      | description length |
      | privacy setting |

  @@regression @@negative @@error
  Scenario: Unauthorized user cannot access or modify group settings
    # Prevents users without permissions from accessing or saving changes
    Given the user does not have group administration permissions
    When the user attempts to access the group settings page
    Then the system denies access
    And any attempted changes cannot be saved

  @@regression @@edge @@boundary
  Scenario Outline: Boundary values are accepted for configurable settings
    # Checks that minimum and maximum allowed values are saved successfully
    Given the user is a group administrator with valid permissions
    And the administrator is on the group settings page
    When the administrator sets <field> to <boundary_value> and saves
    Then the system persists the changes
    And a confirmation message is displayed

    Examples:
      | field | boundary_value |
      | group name length | minimum allowed length |
      | group name length | maximum allowed length |
      | member limit | maximum allowed limit |
