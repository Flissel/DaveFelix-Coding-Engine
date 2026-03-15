@@smoke @@regression
Feature: Chat archivieren
  As a registered user
  I want to archive a chat conversation
  So that to keep my active chat list organized while retaining access to past conversations

  Background:
    Given I am a registered user and logged into the chat application

  @@smoke @@happy-path
  Scenario: Archive an active chat from the active list
    # Validates that an active chat is moved to the archived list when archived
    Given I am viewing an active chat thread with another user
    When I select the option to archive the chat
    Then the chat is removed from the active chat list
    And the chat appears in the archived chat list

  @@regression @@happy-path
  Scenario: Access an archived chat from the archived list
    # Ensures archived chats are visible and can be opened
    Given a chat thread is archived
    When I open the archived chat list
    Then the archived chat is visible in the list
    And I can open the archived chat thread

  @@regression @@negative
  Scenario: Prevent duplicate archiving of an already archived chat
    # Verifies the system prevents duplicate archiving and shows a message
    Given a chat thread is already archived
    When I select the option to archive the same chat
    Then the system prevents the duplicate archive action
    And I am informed that the chat is already archived

  @@regression @@edge-case
  Scenario Outline: Archive chats of different sizes and ages
    # Validates archiving works for chats with various message counts and ages
    Given I am viewing an active chat thread with <message_count> messages last active <age_in_days> days ago
    When I select the option to archive the chat
    Then the chat is moved from the active list to the archived list
    And the archived chat is accessible from the archived list

    Examples:
      | message_count | age_in_days |
      | 1 | 0 |
      | 50 | 30 |
      | 1000 | 365 |

  @@regression @@negative @@error
  Scenario: Fail to archive due to network error
    # Ensures the user is notified when archiving fails because of a system error
    Given I am viewing an active chat thread
    When I select the option to archive the chat and a network error occurs
    Then the chat remains in the active list
    And I am shown an error message indicating the archive failed
