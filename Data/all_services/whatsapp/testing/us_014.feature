@smoke @regression
Feature: Nachricht bearbeiten
  As a registered user
  I want to edit a message I have already sent
  So that I can correct mistakes or update information for recipients

  Background:
    Given the user is authenticated and has access to sent messages

  @smoke @regression @happy-path
  Scenario: Edit a sent message within the editable period
    # Valid update should save changes and mark the message as edited
    Given a sent message exists within the editable period
    When the user updates the message content and saves
    Then the message content is updated
    And the message is marked as edited

  @regression @negative
  Scenario Outline: Prevent editing outside editable period or when locked
    # Editing should be blocked when the message is not editable
    Given a sent message exists with status <status>
    When the user attempts to edit the message
    Then the system prevents editing
    And the user is informed that the message cannot be edited

    Examples:
      | status |
      | outside editable period |
      | locked |

  @regression @negative
  Scenario Outline: Validate empty or invalid content on save
    # Invalid content should not be saved and validation errors should be shown
    Given the edit form is open for a sent message within the editable period
    When the user attempts to save with <content_type>
    Then validation errors are displayed
    And the message changes are not saved

    Examples:
      | content_type |
      | empty content |
      | invalid content |

  @regression @edge-case @boundary
  Scenario Outline: Edit at the exact boundary of the editable period
    # Message should be editable at the boundary and non-editable immediately after
    Given a sent message exists with edit window <time_state>
    When the user attempts to update the message content and save
    Then the system behavior is <expected_result>

    Examples:
      | time_state | expected_result |
      | exactly at the editable period limit | the message is updated and marked as edited |
      | just after the editable period limit | the system prevents editing and informs the user |
