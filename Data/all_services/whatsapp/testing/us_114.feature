@@smoke @@regression
Feature: Speichereffizienz
  As a system administrator
  I want to configure and verify that the system stores data using efficient compression and deduplication settings
  So that to minimize storage costs while maintaining required performance and data integrity

  Background:
    Given the storage system is running and monitoring is enabled

  @@smoke @@happy-path @@regression
  Scenario: Efficient storage consumption under default settings
    # Verifies compression efficiency threshold under normal load
    Given the system is configured with default compression and deduplication settings
    When a normal workload of data is ingested and stored
    Then the effective storage consumption is within the defined efficiency threshold versus raw input size
    And data integrity checks pass for the stored data

  @@regression @@happy-path
  Scenario Outline: Deduplication of duplicate data sets
    # Validates that redundant data is stored once without data loss
    Given the system is configured with deduplication enabled
    When a dataset with <duplicate_ratio> duplicate content is ingested
    Then only one physical copy of each duplicate block is stored
    And all logical data blocks are retrievable without loss

    Examples:
      | duplicate_ratio |
      | 50% |
      | 90% |

  @@regression @@boundary
  Scenario Outline: Performance at high storage utilization
    # Ensures efficiency mechanisms are applied without exceeding acceptable access latency
    Given storage utilization is at <utilization_threshold>
    When additional data is stored under normal load
    Then compression and deduplication remain enabled
    And data access latency remains within <max_latency_ms> milliseconds

    Examples:
      | utilization_threshold | max_latency_ms |
      | 85% | 50 |
      | 95% | 100 |

  @@negative @@regression
  Scenario: Misconfiguration triggers safe fallback mode
    # Verifies error logging and safe fallback when efficiency mechanisms fail
    Given compression or deduplication is misconfigured
    When new data is ingested and stored
    Then an error is logged indicating efficiency mechanism failure
    And the system stores data in a safe fallback mode without corruption
