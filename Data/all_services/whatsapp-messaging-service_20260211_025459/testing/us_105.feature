@smoke @regression
Feature: API-Zugang
  As a Technischer Integrationspartner
  I want to über eine Business-API Nachrichten und Integrationen an das System anbinden
  So that automatisierte und zuverlässige Kommunikation plattformübergreifend sowie schnelle Integrationen zu ermöglichen

  Background:
    Given the Business-API is available and documented endpoints are published

  @smoke @regression @happy-path
  Scenario: Successful authorized request returns expected response within performance limits
    # Valid credentials should allow access and respond within defined SLA
    Given the integrator has valid API credentials
    When the integrator sends an authorized GET request to a documented endpoint
    Then the system returns the expected response payload
    And the system responds with a correct success status code within the defined performance limits

  @regression @negative
  Scenario: Unauthorized request is rejected with clear error message
    # Missing or invalid credentials should be denied with proper status and message
    Given the integrator has missing or invalid API credentials
    When the integrator calls a documented endpoint
    Then the system rejects the request with an authorization error status code
    And the system returns a clear and understandable error message

  @regression @negative @boundary
  Scenario: Rate limit is enforced and retry information is returned
    # Requests beyond rate limit should be rejected with retry information
    Given the integrator has valid API credentials and has exceeded the defined rate limit
    When the integrator sends additional API requests
    Then the system rejects the requests with a rate-limit error status code
    And the response includes information on when to retry

  @regression @edge @boundary
  Scenario: Authorized request at rate limit boundary
    # Verify behavior at the exact boundary of allowed requests
    Given the integrator has valid API credentials and is at the last allowed request within the current rate limit window
    When the integrator sends one additional authorized request within the same window
    Then the system returns a success status code for the last allowed request
    And the system provides rate limit headers indicating the remaining quota is zero

  @regression @negative @edge
  Scenario: Invalid endpoint returns proper error response
    # Calling a non-documented endpoint should return a proper error
    Given the integrator has valid API credentials
    When the integrator sends a request to a non-documented endpoint
    Then the system returns a not-found or unsupported endpoint status code
    And the response includes a clear error message

  @regression @negative
  Scenario Outline: Authorization error variants
    # Data-driven test for missing vs invalid credentials
    Given the integrator uses <credential_state> credentials
    When the integrator calls a documented endpoint
    Then the system responds with status <status_code>
    And the error message indicates <error_reason>

    Examples:
      | credential_state | status_code | error_reason |
      | missing | 401 | authentication is required |
      | invalid | 403 | access is forbidden |

  @regression @boundary
  Scenario: Performance boundary for authorized requests
    # Ensure responses meet performance SLA at boundary
    Given the integrator has valid API credentials
    When the integrator sends an authorized request during peak load
    Then the system returns a success status code
    And the response time is within the defined performance limits
