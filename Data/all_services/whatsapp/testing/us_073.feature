@@smoke @@regression
Feature: Favoriten markieren
  As a registered user
  I want to mark a contact as a favorite
  So that to quickly access important contacts

  Background:
    Given the user is logged in and on the contacts page

  @@smoke @@regression @@happy-path
  Scenario Outline: Add a contact to favorites
    # Verify a contact can be marked as favorite and appears in favorites list
    Given the user is viewing the contact "<contact_name>"
    When the user marks the contact as favorite
    Then the contact is added to the user's favorites list
    And the favorite indicator is shown for the contact

    Examples:
      | contact_name |
      | Alice Meyer |
      | Bob Schmidt |

  @@regression @@edge
  Scenario Outline: Prevent duplicate favorites
    # Ensure marking a favorite twice does not create duplicates
    Given the contact "<contact_name>" is already marked as favorite
    When the user marks the contact as favorite again
    Then the system keeps a single favorite entry for the contact
    And the favorites count for the contact remains 1

    Examples:
      | contact_name |
      | Carla Fischer |
      | David Weber |

  @@regression @@edge @@boundary
  Scenario: Open favorites list with no favorites
    # Validate empty state when no favorites exist
    Given the user has no favorites
    When the user opens the favorites list
    Then an empty state message is displayed indicating no favorites

  @@regression @@negative @@error
  Scenario Outline: Fail to mark favorite when contact is missing
    # Handle error when contact cannot be found
    Given the user tries to view a non-existent contact with id "<contact_id>"
    When the user attempts to mark the contact as favorite
    Then the system shows an error message that the contact is not found
    And no favorite entry is created

    Examples:
      | contact_id |
      | 999999 |
      | 000000 |
