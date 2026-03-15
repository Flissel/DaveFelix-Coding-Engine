@smoke @regression
Feature: Verschluesseltes Backup
  As a system administrator
  I want to configure and perform end-to-end encrypted backups
  So that ensure backup data is protected from unauthorized access and meets security compliance

  Background:
    Given the administrator is authenticated and has access to backup settings

  @@smoke @@regression @@happy-path
  Scenario: Successful encrypted backup with valid key
    # Verifies that a backup completes successfully and is stored end-to-end encrypted when a valid key is provided
    Given a valid encryption key is available and end-to-end encryption is enabled
    When the administrator initiates a backup
    Then the system stores the backup encrypted end-to-end
    And the system confirms successful completion

  @@regression @@happy-path
  Scenario: Exported backups remain encrypted
    # Ensures exported or transferred backups remain encrypted and unreadable without the correct key
    Given end-to-end encryption is enabled and a backup exists
    When the administrator exports the backup to external storage
    Then the exported backup remains encrypted
    And the backup cannot be read without the correct decryption key

  @@negative @@regression
  Scenario: Prevent backup without valid encryption key
    # Validates that backups are blocked and errors are logged when no valid key is provided
    Given end-to-end encryption is enabled and no valid encryption key is provided
    When the administrator attempts to start a backup
    Then the system prevents the backup
    And the system displays a clear error message and logs the failure

  @@negative @@regression @@edge-case
  Scenario Outline: Scenario Outline: Key validity boundary conditions for backup start
    # Checks boundary conditions for encryption key validity during backup initiation
    Given end-to-end encryption is enabled
    And the encryption key is <key_state>
    When the administrator initiates a backup
    Then the system responds with <expected_outcome>
    And the system logs <log_detail>

    Examples:
      | key_state | expected_outcome | log_detail |
      | empty | backup prevented with an error message about missing key | a failure entry for missing encryption key |
      | expired | backup prevented with an error message about invalid key | a failure entry for invalid encryption key |
      | valid | backup started and completes successfully | a success entry for encrypted backup completion |
