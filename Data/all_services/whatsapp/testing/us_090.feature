@smoke @regression
Feature: Cloud Backup of Chat History
  As a chat user
  I want to enable and run a backup of my chat history to the cloud
  So that so that my conversations are محفوظ and can be restored if I change devices or lose data

  Background:
    Given the user is authenticated in the chat application

  @@smoke @@regression @@happy-path
  Scenario: Successful cloud backup completes and confirms
    # Verifies a full backup succeeds when connectivity is available
    Given the user has an active internet connection
    And the user has chat history with new messages since the last backup
    When the user initiates a cloud backup
    Then the system creates a backup of the chat history in the cloud
    And the system confirms backup completion

  @@regression @@edge
  Scenario: Backup is up to date when no new messages
    # Verifies the system indicates the backup is current and completes quickly
    Given the user has an active internet connection
    And there are no new messages since the last successful backup
    When the user initiates a cloud backup
    Then the system completes the backup quickly
    And the system indicates the backup is up to date

  @@regression @@negative
  Scenario: Backup fails gracefully without internet
    # Verifies error handling and guidance when connectivity is unavailable
    Given the user has no internet connection
    When the user initiates a cloud backup
    Then the system fails the backup gracefully
    And the system displays an error with guidance to retry

  @@regression @@boundary
  Scenario Outline: Backup completes within expected time bounds
    # Validates boundary conditions for backup duration based on data size
    Given the user has an active internet connection
    And the chat history size is <history_size>
    When the user initiates a cloud backup
    Then the backup completes within <max_duration_seconds> seconds
    And the system confirms backup completion

    Examples:
      | history_size | max_duration_seconds |
      | 0 messages | 5 |
      | 10,000 messages | 60 |

  @@regression @@edge @@negative
  Scenario: Retry after transient connectivity loss during backup
    # Ensures backup can be retried after a mid-process disconnect
    Given the user has an active internet connection
    And the connection drops during the backup process
    When the user initiates a cloud backup
    Then the system displays an error with guidance to retry
    And the user can retry the backup after the connection is restored
