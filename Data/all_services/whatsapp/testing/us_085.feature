@@smoke @@regression
Feature: Storage Usage Overview and Details
  As a system administrator
  I want to view and manage storage usage across the system
  So that to monitor capacity and prevent storage shortages that could impact operations

  Background:
    Given the administrator is authenticated and has storage management permissions

  @@smoke @@regression @@happy-path
  Scenario: Display storage usage overview with category breakdown
    # Validates that total, used, and available storage with category breakdown are shown
    When the administrator opens the storage usage overview
    Then the system displays total, used, and available storage values
    And the system displays a breakdown by configured categories

  @@regression @@happy-path
  Scenario Outline: View item-level usage details for a selected category or resource
    # Validates item-level usage details and size metrics are shown for a selection
    Given the storage usage overview is displayed
    When the administrator requests detailed usage information for <selection>
    Then the system shows item-level usage details for <selection>
    And the system shows current size metrics for each item

    Examples:
      | selection |
      | Backups category |
      | Logs category |
      | Resource VM-01 |

  @@regression @@negative @@error
  Scenario: Handle unavailable storage usage data source
    # Validates error handling and retry option when data source is unavailable
    Given the storage usage data source is temporarily unavailable
    When the administrator attempts to load the storage usage overview
    Then the system shows an error message indicating the data is unavailable
    And the system provides an option to retry loading the overview

  @@regression @@edge
  Scenario: Display overview when no categories are configured
    # Edge case when category list is empty
    Given no storage categories are configured
    When the administrator opens the storage usage overview
    Then the system displays total, used, and available storage values
    And the system indicates that no categories are configured

  @@regression @@boundary
  Scenario Outline: Boundary conditions for storage capacity values
    # Validates rendering when used storage approaches total capacity
    Given the storage usage data includes total capacity of <total> and used capacity of <used>
    When the administrator opens the storage usage overview
    Then the system displays available storage as <available>
    And the system does not display negative available storage

    Examples:
      | total | used | available |
      | 100 GB | 0 GB | 100 GB |
      | 100 GB | 100 GB | 0 GB |
      | 100 GB | 99.99 GB | 0.01 GB |

  @@regression @@negative @@recovery
  Scenario: Retry loading overview after data source recovers
    # Validates successful reload after temporary outage
    Given the storage usage data source was unavailable and is now available
    When the administrator selects the retry option
    Then the system loads the storage usage overview
    And the system displays total, used, and available storage values
