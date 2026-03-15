@smoke @regression
Feature: WhatsApp Pay
  As a registered customer
  I want to pay for goods or services directly within the WhatsApp app
  So that to complete purchases quickly without leaving the chat and increase conversion for supported markets

  Background:
    Given the user is a registered customer with an active WhatsApp account

  @smoke @regression @happy-path
  Scenario: Successful WhatsApp Pay payment in supported market
    # Valid payment method and supported market result in successful in-app payment
    Given the user is located in a market where WhatsApp Pay is available
    And the user has set up a valid payment method
    When the user selects WhatsApp Pay at checkout and confirms the payment
    Then the payment is processed successfully
    And a confirmation is shown in the chat

  @regression @negative
  Scenario: WhatsApp Pay not available in user market
    # User in unsupported market is blocked from initiating in-app payment
    Given the user is located in a market where WhatsApp Pay is not available
    When the user attempts to initiate an in-app payment
    Then the system informs the user that WhatsApp Pay is not available in their market
    And the payment flow does not proceed

  @regression @negative
  Scenario: Payment authorization failure allows retry or alternate method
    # Authorization failure shows error and options to continue
    Given the user is located in a market where WhatsApp Pay is available
    And the user has selected WhatsApp Pay at checkout
    When the payment is submitted and authorization fails
    Then a failure message is shown in the chat
    And the user is allowed to retry or choose another payment method

  @regression @negative
  Scenario Outline: WhatsApp Pay availability by market and payment method validity
    # Data-driven coverage for supported and unsupported markets with valid/invalid methods
    Given the user is located in <market_status> market
    And the user has a <payment_method_status> payment method set up
    When the user selects WhatsApp Pay at checkout and confirms the payment
    Then <expected_outcome>

    Examples:
      | market_status | payment_method_status | expected_outcome |
      | supported | valid | the payment is processed successfully and a confirmation is shown in the chat |
      | supported | invalid | a failure message is shown in the chat and the user is allowed to retry or choose another payment method |
      | unsupported | valid | the system informs the user that WhatsApp Pay is not available in their market and the payment flow does not proceed |

  @regression
  Scenario Outline: Boundary condition for minimum and maximum order amounts
    # Ensure payments succeed at supported boundary order amounts
    Given the user is located in a market where WhatsApp Pay is available
    And the user has set up a valid payment method
    And the order total is <order_amount>
    When the user selects WhatsApp Pay at checkout and confirms the payment
    Then the payment is processed successfully and a confirmation is shown in the chat

    Examples:
      | order_amount |
      | the minimum allowed amount |
      | the maximum allowed amount |
