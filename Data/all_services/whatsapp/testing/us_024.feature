@@smoke @@regression
Feature: Standort teilen
  As a registered user
  I want to share my current location with another user
  So that so that I can quickly communicate where I am for coordination

  Background:
    Given I am logged in as a registered user

  @@smoke @@regression @@happy-path
  Scenario Outline: Share current location successfully
    # Validates successful location share to a selected recipient
    Given location services are enabled and permission is granted
    When I select the share location option and choose recipient "<recipient>"
    Then the system sends my current location to the recipient
    And the system confirms the location share

    Examples:
      | recipient |
      | Alice |
      | Bob |

  @@regression @@negative
  Scenario Outline: Prompt to enable location services when disabled or denied
    # Ensures no location is sent when services are disabled or permission denied
    Given location services are "<location_state>"
    When I attempt to share my location
    Then the system prompts me to enable location services
    And no location is sent to any recipient

    Examples:
      | location_state |
      | disabled |
      | permission denied |

  @@regression @@negative
  Scenario: Handle location determination failure with retry
    # Shows error and allows retry when location cannot be determined
    Given location services are enabled and permission is granted
    And the system cannot determine my current location
    When I attempt to share my location
    Then the system displays a location error
    And the system allows me to retry sharing my location

  @@regression @@edge @@boundary
  Scenario Outline: Boundary condition for maximum recipient selection list
    # Validates that selecting a recipient at the end of a long list still shares successfully
    Given location services are enabled and permission is granted
    And I have a recipient list with "<recipient_count>" users
    When I select the share location option and choose recipient "<recipient_at_end>"
    Then the system sends my current location to the recipient
    And the system confirms the location share

    Examples:
      | recipient_count | recipient_at_end |
      | 500 | User500 |
