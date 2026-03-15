@@smoke @@regression
Feature: Kontakte synchronisieren
  As a WhatsApp user
  I want to synchronize device contacts to identify which contacts are WhatsApp users
  So that so that I can easily find and message people who are already on WhatsApp

  Background:
    Given the user is on the contacts screen

  @@smoke @@regression @@happy-path
  Scenario Outline: Sync matches WhatsApp users from device contacts
    # Validates successful synchronization and display of matched contacts
    Given the user has granted contact access
    And the device has contacts including WhatsApp users
    When the user initiates contact synchronization
    Then the system matches device contacts with WhatsApp users
    And the system displays the matched contacts

    Examples:
      | matched_contacts |
      | 3 |
      | 25 |

  @@regression @@edge
  Scenario Outline: Sync completes with no matched contacts
    # Validates edge case where no device contacts are WhatsApp users
    Given the user has granted contact access
    And the device has contacts but none are WhatsApp users
    When the user initiates contact synchronization
    Then the system completes synchronization successfully
    And the system shows no matched contacts

    Examples:
      | contact_count |
      | 1 |
      | 500 |

  @@regression @@negative
  Scenario Outline: Permission prompt blocks synchronization until access is granted
    # Validates permission handling when contact access is not granted
    Given the user has not granted contact access
    When the user initiates contact synchronization
    Then the system prompts for contact permission
    And the system does not perform synchronization

    Examples:
      | permission_state |
      | denied |
      | not_asked |

  @@regression @@negative
  Scenario Outline: Network or service error during synchronization allows retry
    # Validates error handling and retry capability when sync fails
    Given the user has granted contact access
    And the device has contacts
    When the user initiates contact synchronization
    And a network or service error occurs during synchronization
    Then the system displays an error message
    And the system allows the user to retry synchronization

    Examples:
      | error_type |
      | network_timeout |
      | service_unavailable |
