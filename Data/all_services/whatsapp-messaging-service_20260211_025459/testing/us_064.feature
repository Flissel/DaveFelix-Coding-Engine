@@smoke @@regression
Feature: IP-Adresse schuetzen
  As a Support-Mitarbeiter
  I want to IP-Adressen bei Anrufen automatisch verschleiern
  So that Datenschutz und Compliance zu erhoehen sowie die Sicherheit der Kommunikation zu verbessern

  Background:
    Given the calling system is operational and routing calls through the masking service

  @@smoke @@regression @@happy-path
  Scenario Outline: IP masking for established calls (incoming and outgoing)
    # Ensures IP addresses are masked in signaling and metadata once a call is established
    Given a <call_type> call is initiated between two participants through the system
    When the call connection is established
    Then the signaling data exposes only masked IP addresses to the counterparty
    And the call metadata exposes only masked IP addresses to the counterparty

    Examples:
      | call_type |
      | incoming |
      | outgoing |

  @@regression @@happy-path
  Scenario Outline: Masked IPs are stored in logs and analytics
    # Validates that persisted call records store only masked IPs
    Given a call is completed and is ready for logging
    When call details are stored in <storage_target>
    Then only masked IP addresses are saved in <storage_target>
    And unmasked IP addresses are not displayed in <storage_target>

    Examples:
      | storage_target |
      | system logs |
      | analytics dashboard |

  @@regression @@negative @@error
  Scenario: Service unavailable prevents call initiation
    # Ensures calls are blocked with a clear error when masking service is down
    Given the IP masking service is unavailable
    When a user initiates a call
    Then the call is not established
    And the user receives a clear error message indicating a masking service outage

  @@regression @@edge @@boundary
  Scenario Outline: Boundary: Masking handles IPv4 and IPv6 formats
    # Validates masking for different IP formats to ensure consistency
    Given a call is initiated with participant IP address format <ip_format>
    When the call connection is established
    Then the IP address is masked in signaling and metadata
    And the masked value does not reveal the original address

    Examples:
      | ip_format |
      | IPv4 |
      | IPv6 |
