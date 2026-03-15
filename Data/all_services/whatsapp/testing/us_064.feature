@@smoke @@regression
Feature: IP-Adresse schuetzen
  As a call participant
  I want to make a call with their IP address masked
  So that so that their network identity is protected during communications

  Background:
    Given the IP masking service is configured for the call system

  @@smoke @@happy-path
  Scenario: Masked IPs are shown for a successful call
    # Verifies that both parties see masked IPs when a call is established
    Given a caller and callee have accounts with valid network connections
    When the caller initiates a call to the callee
    Then the call is connected through the system
    And both parties see only masked IP addresses
    And no real IP address is exposed in the call metadata

  @@regression @@happy-path
  Scenario Outline: Masked IPs across different networks
    # Ensures masked IPs are shown regardless of network location
    Given a caller is on the <caller_network> network
    And a callee is on the <callee_network> network
    When the caller initiates a call to the callee
    Then the call is connected
    And both parties see only masked IP addresses

    Examples:
      | caller_network | callee_network |
      | corporate LAN | home Wi-Fi |
      | mobile LTE | public Wi-Fi |

  @@regression @@negative
  Scenario: Masking service unavailable blocks exposure
    # Validates the system prevents real IP exposure when masking is down
    Given the IP masking service is unavailable
    When a caller initiates a call to a callee
    Then the system blocks the call or warns the caller before connecting
    And no real IP address is exposed to either party
    And the failure is logged with an error reason

  @@regression @@edge
  Scenario Outline: Boundary condition for immediate disconnect
    # Ensures masked IPs are not exposed during short-lived connections
    Given a caller and callee are ready to connect
    When the call connects and is disconnected within <seconds> seconds
    Then no real IP address is exposed during the connection
    And masked IPs are recorded in the call logs

    Examples:
      | seconds |
      | 1 |
      | 2 |
