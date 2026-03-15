@@smoke @@regression
Feature: GIFs
  As a messaging app user
  I want to search for and send GIFs in a conversation
  So that to express emotions quickly and enhance communication

  Background:
    Given the user is logged in
    And the user has an active conversation open
    And the GIF provider is available

  @@smoke @@regression @@happy-path
  Scenario: Send a GIF from search results
    # Verifies a selected GIF is sent and displayed in the conversation
    Given the user is in the GIF search interface
    When the user searches for "celebration"
    And the user selects a GIF from the results
    Then the selected GIF is sent
    And the selected GIF is displayed in the conversation

  @@regression @@edge
  Scenario Outline: Search with no results shows message and allows new search
    # Validates no-results handling and ability to retry search
    Given the user is in the GIF search interface
    When the user searches for "<term>"
    Then a no-results message is displayed
    And the search input remains available for a new search

    Examples:
      | term |
      | asdkjfhqwoeir |
      | %%%%% |

  @@regression @@negative
  Scenario: Provider unavailable prevents search or send
    # Ensures error message is shown and GIF is not sent when provider is unreachable
    Given the GIF provider is unavailable
    When the user searches for "happy"
    Then an error message is displayed
    And no GIF is sent

  @@regression @@boundary
  Scenario Outline: Search term length boundary conditions
    # Validates search behavior for minimum and maximum term lengths
    Given the user is in the GIF search interface
    When the user searches for a term with <length> characters
    Then the search is processed without error
    And results or a no-results message are displayed

    Examples:
      | length |
      | 1 |
      | 100 |
