@@smoke @@regression
Feature: Media Search - Filter by Media Type
  As a end user
  I want to filter search results by media type
  So that to quickly find relevant media and reduce time spent reviewing irrelevant results

  Background:
    Given the user is on the media search page with results available across multiple media types

  @@smoke @@regression @@happy-path
  Scenario: Filter results by a single media type
    # Verifies that selecting one media type shows only matching results
    When the user selects the media type filter "Video"
    Then only results with media type "Video" are displayed
    And no results of other media types are shown

  @@regression @@happy-path
  Scenario Outline: Filter results by media type using data-driven examples
    # Validates filtering for multiple media types
    When the user selects the media type filter "<media_type>"
    Then only results with media type "<media_type>" are displayed
    And no results of other media types are shown

    Examples:
      | media_type |
      | Image |
      | Audio |
      | Document |

  @@regression @@happy-path
  Scenario: Clear all media type filters
    # Ensures clearing filters returns to showing all media types
    Given the user has applied one or more media type filters
    When the user clears all media type filters
    Then results from all media types are displayed
    And the filter state shows no media type selected

  @@regression @@negative @@edge
  Scenario Outline: No results for selected media type
    # Validates the no results message when a media type has no matches
    Given the selected media type has no matching results
    When the user applies the media type filter "<media_type>"
    Then a "no results" message is displayed
    And no unrelated media results are shown

    Examples:
      | media_type |
      | 3D Model |

  @@regression @@boundary
  Scenario Outline: Boundary condition with exactly one matching result
    # Ensures filtering works when only one result matches the selected media type
    Given there is exactly one result of media type "<media_type>"
    When the user selects the media type filter "<media_type>"
    Then exactly one result is displayed
    And the displayed result has media type "<media_type>"

    Examples:
      | media_type |
      | Video |
