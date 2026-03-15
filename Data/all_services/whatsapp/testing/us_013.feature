@@smoke @@regression
Feature: Nachricht loeschen
  As a registered user
  I want to delete a message from my message list
  So that keep my inbox organized and remove irrelevant content

  Background:
    Given I am logged in as a registered user
    And I am viewing my inbox

  @@smoke @@regression @@happy-path
  Scenario: Delete a selected message from inbox
    # Verifies that a selected message is removed successfully
    Given a message with subject "Welcome" exists in my inbox
    When I select the message with subject "Welcome" and choose the delete option
    Then the message with subject "Welcome" is removed from my inbox
    And the inbox message count decreases by 1

  @@regression @@negative
  Scenario: Prevent deletion when no message is selected
    # Ensures the system blocks deletion without selection and prompts the user
    Given at least one message exists in my inbox
    And no message is selected
    When I attempt to delete a message
    Then the system prevents deletion
    And I am prompted to select a message

  @@regression @@negative @@error
  Scenario: Attempt to delete an already deleted message
    # Validates error handling when deleting the same message twice
    Given a message with subject "Receipt" was deleted from my inbox
    When I attempt to delete the message with subject "Receipt" again
    Then the system informs me that the message no longer exists
    And no changes are made to the inbox message count

  @@regression @@boundary
  Scenario Outline: Delete message from inbox with varying message counts
    # Checks deletion behavior at boundary conditions of inbox size
    Given my inbox contains <message_count> message(s)
    And a message with subject "Target" exists in my inbox
    When I select the message with subject "Target" and choose the delete option
    Then the message with subject "Target" is removed from my inbox
    And the inbox message count becomes <expected_count>

    Examples:
      | message_count | expected_count |
      | 1 | 0 |
      | 2 | 1 |

  @@regression @@happy-path
  Scenario Outline: Delete message with different subjects
    # Data-driven verification that deletion works across message variations
    Given a message with subject "<subject>" exists in my inbox
    When I select the message with subject "<subject>" and choose the delete option
    Then the message with subject "<subject>" is removed from my inbox

    Examples:
      | subject |
      | Invoice #123 |
      | Meeting Reminder |
      | System Alert |
