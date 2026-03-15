@smoke @regression
Feature: Info/Status Text
  As a registered user
  I want to add or update a short info/status text in my profile
  So that so that others can quickly understand my current status or information

  Background:
    Given the user is logged in
    And the user is on the profile edit page

  @happy-path @smoke @regression
  Scenario: Save valid info/status text
    # Verifies a valid status text is saved and displayed
    When the user enters a valid info/status text within the allowed length
    And the user saves the profile
    Then the profile is saved successfully
    And the info/status text is displayed on the profile view

  @edge @regression
  Scenario: Save profile with empty info/status text
    # Verifies saving with an empty status text is allowed and no error is shown
    When the user leaves the info/status text empty
    And the user saves the profile
    Then the profile is saved successfully
    And no validation error is shown for the info/status text
    And no info/status text is displayed on the profile view

  @negative @regression
  Scenario: Reject info/status text that exceeds maximum length
    # Verifies the system prevents saving when the text exceeds the maximum length
    When the user enters an info/status text that exceeds the maximum allowed length
    And the user saves the profile
    Then the profile is not saved
    And a validation message indicates the maximum length limit

  @boundary @regression
  Scenario Outline: Boundary validation for info/status text length
    # Validates behavior at and just over the maximum length boundary
    When the user enters an info/status text with length "<length_condition>"
    And the user saves the profile
    Then the save result should be "<save_result>"
    And the validation message should be "<validation_message>"

    Examples:
      | length_condition | save_result | validation_message |
      | maximum allowed length | successful | not shown |
      | maximum allowed length plus 1 | prevented | shown |
