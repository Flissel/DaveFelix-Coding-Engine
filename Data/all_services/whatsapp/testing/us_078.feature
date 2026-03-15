@@smoke @@regression
Feature: Chat-Suche
  As a chat user
  I want to search for chats or contacts by name or keyword
  So that quickly find the right conversation or person to continue communication efficiently

  Background:
    Given the user is on the chat list screen

  @@smoke @@regression @@happy-path
  Scenario Outline: Search returns matching chats or contacts by name or keyword
    # Verifies that valid search terms show matching results
    When the user enters "<search_term>" into the search field
    Then only chats or contacts matching "<search_term>" are displayed in the results list
    And each displayed result highlights the matched name or keyword

    Examples:
      | search_term |
      | Alice |
      | Project Apollo |
      | urgent |

  @@regression @@negative
  Scenario Outline: Search shows empty state when no matches exist
    # Verifies empty state message for no results
    When the user enters "<search_term>" into the search field
    Then an empty state message is shown indicating no results found
    And the results list is empty

    Examples:
      | search_term |
      | NonExistentContact999 |
      | zzzzzz |

  @@smoke @@regression @@happy-path
  Scenario: Clear search restores full chat list
    # Verifies that clearing search shows the unfiltered list
    Given the user has an active search with filtered results
    When the user clears the search field
    Then the full, unfiltered chat list is displayed
    And the search field is empty

  @@regression @@negative
  Scenario Outline: Search service unavailable shows error and allows retry
    # Verifies error handling when search service is down
    Given the search service is unavailable
    When the user enters "<search_term>" into the search field
    Then an error message is shown indicating the search failed
    And a retry option is available to the user

    Examples:
      | search_term |
      | Alice |

  @@regression @@boundary
  Scenario Outline: Search handles boundary length terms
    # Validates behavior for minimum and maximum search input lengths
    When the user enters "<search_term>" into the search field
    Then the search is executed without validation errors
    And matching chats or contacts are displayed if they exist

    Examples:
      | search_term |
      | A |
      | AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA |
