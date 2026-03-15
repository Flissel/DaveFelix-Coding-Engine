@@smoke @@regression
Feature: Warenkorb
  As a shopper
  I want to add, view, update, and remove products in a shopping cart during the ordering process
  So that so that I can review and adjust my intended purchase before checkout, increasing order accuracy and conversion

  Background:
    Given the shopper is on the storefront with an empty cart

  @@smoke @@regression @@happy-path
  Scenario Outline: Add in-stock product to cart and verify totals
    # Happy path for adding a product and verifying line item and cart total
    Given the shopper is viewing the product detail page for "<product_name>" with price "<unit_price>" and stock "<stock>"
    When the shopper adds quantity "<qty>" to the cart
    Then the cart shows "<product_name>" with quantity "<qty>" and unit price "<unit_price>"
    And the cart total equals "<expected_total>"

    Examples:
      | product_name | unit_price | qty | stock | expected_total |
      | Coffee Mug | 12.50 | 2 | 25 | 25.00 |

  @@regression @@happy-path
  Scenario Outline: Update quantity and remove item from cart
    # Happy path for updating quantity and removing a line item with recalculated totals
    Given the cart contains "<product_name>" with quantity "<initial_qty>" and unit price "<unit_price>"
    When the shopper changes the quantity to "<updated_qty>"
    Then the cart line item for "<product_name>" shows quantity "<updated_qty>"
    And the cart total equals "<expected_total>"
    When the shopper removes "<product_name>" from the cart
    Then the cart does not list "<product_name>"
    And the cart total equals "0.00"

    Examples:
      | product_name | initial_qty | updated_qty | unit_price | expected_total |
      | Notebook | 1 | 3 | 5.00 | 15.00 |

  @@regression @@negative
  Scenario Outline: Prevent add to cart for out-of-stock product
    # Error scenario for attempting to add an out-of-stock product
    Given the shopper is viewing the product detail page for "<product_name>" with stock "0"
    When the shopper clicks add to cart
    Then the system prevents the add to cart
    And an out-of-stock message is displayed
    And the cart remains unchanged

    Examples:
      | product_name |
      | Limited Edition Poster |

  @@regression @@negative @@boundary
  Scenario Outline: Boundary quantity update rules in cart
    # Boundary conditions for quantity limits and validation
    Given the cart contains "<product_name>" with quantity "<initial_qty>" and unit price "<unit_price>"
    When the shopper updates the quantity to "<invalid_qty>"
    Then the system rejects the quantity update
    And a quantity validation message is displayed
    And the cart retains the original quantity "<initial_qty>"

    Examples:
      | product_name | initial_qty | invalid_qty | unit_price |
      | T-Shirt | 1 | 0 | 20.00 |
      | T-Shirt | 1 | -1 | 20.00 |
