@smoke @regression
Feature: Status anzeigen
  As a registered user
  I want to view the current status of a contact
  So that so that I can quickly understand the contact's availability and decide on the next action

  Background:
    Given the user is authenticated and has access to contact details

  @happy-path @smoke @regression
  Scenario Outline: Display defined contact status
    # Shows the current status when a contact has a defined status
    Given a contact exists with status "<status>"
    When the user opens the contact details
    Then the system displays the status label "<status>"

    Examples:
      | status |
      | Available |
      | Busy |
      | Away |

  @edge-case @regression
  Scenario: Display default status when none is defined
    # Shows a default label when the contact has no defined status
    Given a contact exists without a defined status
    When the user opens the contact details
    Then the system displays the default status label "Unknown"

  @boundary @regression
  Scenario Outline: Display default status when status is empty or whitespace
    # Treats empty or whitespace status values as undefined
    Given a contact exists with status value "<status_value>"
    When the user opens the contact details
    Then the system displays the default status label "Unknown"

    Examples:
      | status_value |
      |  |
      |   |

  @negative @regression
  Scenario: Show error when status retrieval fails
    # Displays an error message if the status service cannot be reached
    Given a contact exists and the status service returns an error
    When the user opens the contact details
    Then the system shows an error message indicating the status is unavailable
