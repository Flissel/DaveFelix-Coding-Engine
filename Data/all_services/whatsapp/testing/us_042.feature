@smoke @regression
Feature: Status erstellen
  As a registered user
  I want to create a 24-hour status update
  So that to share timely updates that automatically expire and keep content current

  Background:
    Given the user is authenticated
    And the user is on the status creation interface

  @happy-path @smoke @regression
  Scenario Outline: Create a status with valid content
    # Verifies a valid status is saved and visible for 24 hours
    When the user submits a status with content "<content>"
    Then the system saves the status
    And the status is visible to other users for 24 hours

    Examples:
      | content |
      | Meeting in 10 minutes |
      | Service update: maintenance complete |

  @negative @regression
  Scenario Outline: Reject status submission without required content
    # Validates required content is enforced
    When the user submits a status with content "<content>"
    Then the system rejects the submission
    And a validation message "<message>" is displayed

    Examples:
      | content | message |
      |  | Status content is required |
      |     | Status content is required |

  @regression @boundary
  Scenario Outline: Status expires after 24 hours
    # Ensures statuses older than 24 hours are not displayed
    Given a status exists created "<age>" ago
    When any user attempts to view the status
    Then the status is "<visibility>"

    Examples:
      | age | visibility |
      | 24 hours minus 1 minute | displayed |
      | 24 hours | not displayed |
      | 24 hours plus 1 minute | not displayed |

  @edge @regression
  Scenario Outline: Handle content length edge cases
    # Verifies boundary conditions for content length limits
    When the user submits a status with content length "<length>"
    Then the submission result is "<result>"
    And the system shows message "<message>"

    Examples:
      | length | result | message |
      | 1 | accepted | Status created |
      | 500 | accepted | Status created |
      | 501 | rejected | Status content exceeds maximum length |
