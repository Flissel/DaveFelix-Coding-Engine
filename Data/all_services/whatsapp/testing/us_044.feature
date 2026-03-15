@@smoke @@regression
Feature: Status Response
  As a authenticated user
  I want to respond to a status update
  So that to communicate current state and keep stakeholders informed

  Background:
    Given the user is authenticated

  @@smoke @@happy-path @@regression
  Scenario: Submit a valid response to a visible status update
    # Verifies that a valid response is saved and displayed with the status update
    Given a visible status update exists
    When the user submits a response "Acknowledged, working on it"
    Then the response is saved
    And the response is displayed with the status update

  @@negative @@regression
  Scenario: Reject empty responses
    # Validates that empty or whitespace-only responses are rejected with a validation message
    Given a visible status update exists
    When the user submits an empty response
    Then the system rejects the submission
    And a validation message is shown

  @@negative @@regression
  Scenario: Prevent responses to unavailable status updates
    # Ensures responses are blocked when the status update is archived or deleted
    Given the status update is unavailable
    When the user tries to submit a response
    Then the system prevents the response
    And the user is informed that the status is unavailable

  @@regression @@boundary
  Scenario Outline: Submit responses with boundary lengths
    # Covers boundary conditions for response length limits
    Given a visible status update exists
    When the user submits a response with length <length> characters
    Then the system processes the response with outcome <outcome>
    And a user message <message> is shown

    Examples:
      | length | outcome | message |
      | 1 | accepted | response is saved and displayed |
      | 500 | accepted | response is saved and displayed |
      | 501 | rejected | validation message is shown |

  @@negative @@edge @@regression
  Scenario Outline: Submit responses with whitespace-only content
    # Edge case validation for responses that contain only whitespace
    Given a visible status update exists
    When the user submits a response with content <content>
    Then the system rejects the submission
    And a validation message is shown

    Examples:
      | content |
      | " " |
      | "\n\t" |
