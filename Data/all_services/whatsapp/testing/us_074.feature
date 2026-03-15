@smoke @regression
Feature: Labels/Tags
  As a business user
  I want to assign, edit, and remove labels for contacts
  So that to categorize contacts for faster retrieval and segmentation

  Background:
    Given a business user is authenticated and has access to contacts

  @smoke @regression @happy-path
  Scenario: Assign an existing label to a contact
    # Verifies a business user can assign an existing label and see it on the contact profile
    Given the contact profile is open and an existing label "VIP" is available
    When the user adds the label "VIP" to the contact
    Then the label "VIP" is saved
    And the label "VIP" is displayed on the contact profile

  @regression @happy-path
  Scenario Outline: Create a new label with a unique name
    # Ensures a newly created unique label becomes available for assignment
    Given the user is on the label management screen
    When the user creates a label with name "<label_name>"
    Then the label "<label_name>" is created successfully
    And the label "<label_name>" is available for assignment to contacts

    Examples:
      | label_name |
      | Prospect |
      | Partner |

  @regression @negative @error
  Scenario Outline: Prevent creation of a label with duplicate or empty name
    # Validates that duplicate or empty label names are rejected with a validation message
    Given the user is on the label management screen and a label named "Existing" already exists
    When the user attempts to create a label with name "<label_name>"
    Then the system prevents the label from being saved
    And a validation message is shown for "<label_name>"

    Examples:
      | label_name |
      | Existing |
      |  |
      |     |

  @regression @edge-case @boundary
  Scenario Outline: Create a label at name length boundaries
    # Checks behavior at minimum and maximum name length limits
    Given the user is on the label management screen
    When the user creates a label with name length "<name_length>"
    Then the system accepts the label if within allowed limits
    And the label is available for assignment when accepted

    Examples:
      | name_length |
      | 1 |
      | 50 |

  @regression @negative @boundary
  Scenario Outline: Attempt to create a label exceeding maximum length
    # Ensures the system rejects label names longer than the maximum allowed length
    Given the user is on the label management screen
    When the user attempts to create a label with name length "<name_length>"
    Then the system prevents the label from being saved
    And a validation message indicates the name exceeds the maximum length

    Examples:
      | name_length |
      | 51 |
