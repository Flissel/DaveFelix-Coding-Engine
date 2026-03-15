@smoke @regression
Feature: Datennutzung konfigurieren und überwachen
  As a system administrator
  I want to configure and monitor data usage limits for the system
  So that to ensure data consumption stays within agreed limits and costs are controlled

  Background:
    Given the administrator is authenticated and on the data usage settings page

  @happy-path @smoke @regression
  Scenario: Save and display a valid usage limit
    # Verifies that a valid usage limit is saved and shown as active
    When the administrator enters a usage limit of 5000 MB
    And saves the configuration
    Then the limit is stored
    And the limit is displayed as active with value 5000 MB

  @happy-path @regression
  Scenario: Notify administrator when consumption reaches threshold
    # Ensures a notification is triggered when usage reaches the configured threshold
    Given a usage limit of 5000 MB is active
    When data consumption reaches 5000 MB
    Then the system triggers the configured notification to the administrator

  @happy-path @regression
  Scenario: Block consumption when limit would be exceeded
    # Confirms consumption is blocked and logged when exceeding the active limit
    Given a usage limit of 5000 MB is active
    When a request would increase consumption beyond 5000 MB
    Then the system blocks further consumption
    And the system logs the limit-exceeded event

  @negative @regression
  Scenario Outline: Reject invalid usage limits
    # Validates that invalid limits are rejected with errors
    When the administrator enters an invalid usage limit of <invalid_value> MB
    And attempts to save the configuration
    Then the system rejects the input
    And a validation error is shown

    Examples:
      | invalid_value |
      | -1 |
      | -100 |

  @edge @regression
  Scenario Outline: Boundary limits are accepted
    # Checks that boundary values are handled correctly
    When the administrator enters a usage limit of <boundary_value> MB
    And saves the configuration
    Then the limit is stored
    And the limit is displayed as active with value <boundary_value> MB

    Examples:
      | boundary_value |
      | 0 |
      | 1 |

  @edge @regression
  Scenario: Edge case: consumption exactly one unit below limit
    # Ensures no notification or block happens just below the limit
    Given a usage limit of 5000 MB is active
    When data consumption reaches 4999 MB
    Then no notification is triggered
    And consumption continues without blocking
