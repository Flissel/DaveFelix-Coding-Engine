@@smoke @@regression
Feature: Effiziente Synchronisation
  As a system integration service
  I want to synchronize messages between systems efficiently
  So that to ensure timely delivery while minimizing resource usage and avoiding delays

  Background:
    Given the source and target systems are configured for synchronization

  @@smoke @@regression @@happy-path
  Scenario: Sync transfers only new or changed messages within performance threshold
    # Validates successful sync of only new or changed messages and completion within the defined threshold
    Given new and changed messages exist in the source system
    And the network connection is available
    When a synchronization cycle is executed
    Then only new or changed messages are transferred
    And the cycle completes within the performance threshold

  @@regression @@edge-case
  Scenario Outline: Process large batch in configured batches without exceeding resource limits
    # Ensures batching behavior and resource limits are respected while all messages are eventually synchronized
    Given a large batch of messages is pending synchronization
    And batch size is configured to <batch_size>
    And resource limit is configured to <resource_limit>
    When the synchronization runs
    Then messages are processed in batches of <batch_size>
    And resource usage does not exceed <resource_limit>
    And all messages are eventually synchronized

    Examples:
      | batch_size | resource_limit |
      | 100 | 70% |
      | 500 | 80% |

  @@regression @@negative @@error
  Scenario: Retry on network interruption without creating duplicates
    # Validates retry policy is applied and no duplicate messages are created after a failure
    Given messages are in the process of synchronization
    And the network connection is interrupted
    When the system detects the failure
    Then the synchronization is retried according to the retry policy
    And no duplicate messages are created in the target system

  @@regression @@boundary
  Scenario Outline: Performance threshold boundary for sync cycle
    # Checks behavior at the defined performance threshold boundary
    Given new messages exist in the source system
    And the performance threshold is <threshold_ms> milliseconds
    When a synchronization cycle is executed
    Then the cycle completes in <actual_ms> milliseconds
    And the completion time is within the performance threshold

    Examples:
      | threshold_ms | actual_ms |
      | 2000 | 2000 |
      | 2000 | 1999 |
