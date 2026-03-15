@@smoke @@regression
Feature: Business-Profil
  As a business account admin
  I want to create and update an extended business profile with additional company details
  So that so that the business can present comprehensive information and improve trust with partners and customers

  Background:
    Given the admin is authenticated and on the business profile edit page

  @@smoke @@regression @@happy-path
  Scenario: Save extended business profile with all fields populated
    # Happy path: admin saves required and optional extended fields
    When the admin enters valid values for all required and optional extended fields
    And saves the business profile
    Then the system stores the extended profile data
    And the updated extended information is displayed on the profile

  @@regression @@edge
  Scenario: Save extended business profile with optional fields empty
    # Edge case: optional fields omitted while required fields are provided
    When the admin enters valid values for all required extended fields
    And leaves all optional extended fields empty
    And saves the business profile
    Then the system stores the required extended profile data
    And the profile shows empty states for the optional fields

  @@regression @@negative
  Scenario: Prevent saving when required extended fields are missing
    # Error scenario: required field validation blocks save
    When the admin leaves a required extended field empty
    And attempts to save the business profile
    Then the system prevents saving the profile
    And the missing required field is highlighted with an error message

  @@regression @@edge
  Scenario: View profile with no extended data shows empty states
    # Edge case: existing profile without extended data displays defaults
    Given an existing business profile has no extended data saved
    When the admin views the business profile
    Then the system shows default or empty states for extended fields
    And no validation errors are shown

  @@regression @@boundary
  Scenario Outline: Validate length boundaries for extended fields
    # Boundary conditions: min and max length constraints for text fields
    When the admin enters a <field_name> value with length <length_case>
    And saves the business profile
    Then the system <outcome> the save
    And the system shows <message_behavior>

    Examples:
      | field_name | length_case | outcome | message_behavior |
      | company description | minimum allowed length | accepts | no error message |
      | company description | maximum allowed length | accepts | no error message |
      | company description | exceeding maximum allowed length | rejects | a length validation error message |

  @@regression @@boundary @@negative
  Scenario Outline: Validate format boundaries for extended fields
    # Boundary conditions: format validation for structured fields
    When the admin enters <field_name> with value <value>
    And saves the business profile
    Then the system <outcome> the save
    And the system shows <message_behavior>

    Examples:
      | field_name | value | outcome | message_behavior |
      | VAT number | valid format value | accepts | no error message |
      | VAT number | invalid format value | rejects | a format validation error message |
