@@smoke @@regression
Feature: API Access for Integration Partners
  As a integration partner
  I want to access the business API to integrate external systems
  So that to automate data exchange and enable seamless integrations

  Background:
    Given the business API is available

  @@smoke @@regression @@happy-path
  Scenario: Successful authorized API call returns 200
    # Valid credentials and valid request receive a successful response
    Given the integration partner has valid API credentials
    And the request payload includes all required parameters
    When they call the authorized endpoint "/api/v1/orders" with a valid request
    Then the system returns HTTP 200
    And the response body contains the expected order data

  @@regression @@negative
  Scenario Outline: Invalid or missing parameters return 400 with clear error
    # Validation errors are handled with a 400 response and descriptive message
    Given the integration partner has valid API credentials
    When they call the authorized endpoint "/api/v1/orders" with <invalid_payload>
    Then the system returns HTTP 400
    And the error message states <error_message>

    Examples:
      | invalid_payload | error_message |
      | missing required field "orderId" | "orderId" is required |
      | invalid data type for "quantity" | "quantity" must be a positive integer |

  @@regression @@negative
  Scenario Outline: Invalid or expired credentials return 401
    # Unauthorized access is rejected and the request is not processed
    Given the integration partner uses <credential_state> API credentials
    When they call the authorized endpoint "/api/v1/orders"
    Then the system returns HTTP 401
    And no data is created or modified

    Examples:
      | credential_state |
      | invalid |
      | expired |

  @@regression @@edge-case
  Scenario Outline: Boundary condition for maximum allowed parameter length
    # Requests at boundary limits are accepted when valid
    Given the integration partner has valid API credentials
    And the request payload includes a field "referenceId" with length <length>
    When they call the authorized endpoint "/api/v1/orders" with a valid request
    Then the system returns HTTP 200
    And the response includes the same "referenceId"

    Examples:
      | length |
      | 1 |
      | 64 |
