@smoke @regression
Feature: Nachrichtensuche
  As a message user
  I want to perform a full-text search across messages
  So that so that I can quickly find relevant information without manually browsing messages

  Background:
    Given the user is on the message search page

  @happy-path @smoke @regression
  Scenario Outline: Return messages that contain the keyword
    # Valid keyword returns all matching messages by full-text search
    Given there are messages containing the keyword
    When the user enters the keyword and submits the search
    Then the system returns a list of messages that contain the keyword in their full text
    And each result displays message metadata and a snippet containing the keyword

    Examples:
      | keyword | matching_count |
      | invoice | 3 |
      | meeting | 1 |

  @negative @regression
  Scenario Outline: No results found when keyword is absent
    # Search with a non-matching keyword returns an empty result set with a user message
    Given no messages contain the keyword
    When the user enters the keyword and submits the search
    Then the system shows an empty result set
    And the system displays a 'no results found' message

    Examples:
      | keyword |
      | nonexistentterm |

  @negative @regression
  Scenario Outline: Prevent search on empty input
    # Empty search input is blocked with a prompt
    When the user submits an empty search input
    Then the system prevents the search
    And the system prompts the user to enter a search term

    Examples:
      | keyword |
      |  |

  @edge @regression
  Scenario Outline: Handle keyword length boundaries
    # Search accepts minimum and maximum keyword lengths without error
    Given there are messages containing the keyword
    When the user enters a boundary-length keyword and submits the search
    Then the system returns a list of messages that contain the keyword in their full text

    Examples:
      | keyword | boundary |
      | a | min |
      | aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa | max |
