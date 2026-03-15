@smoke @regression
Feature: Produktkatalog
  As a business admin
  I want to view and browse the product catalog for businesses
  So that to evaluate and select products that fit the company’s purchasing needs

  Background:
    Given the business admin is authenticated
    And the product catalog contains business products with name, price, and availability

  @smoke @regression @happy-path
  Scenario: View product catalog with key details
    # Happy path to display available products with required details
    When the business admin opens the product catalog
    Then a list of available business products is displayed
    And each product shows name, price, and availability

  @regression @happy-path
  Scenario Outline: Filter or search catalog results
    # Success scenario for filtering and searching products using different criteria
    Given the catalog contains multiple products
    When the business admin applies filter criteria <criteria>
    Then only products matching <criteria> are shown

    Examples:
      | criteria |
      | category equals "Software" |
      | availability equals "In Stock" |
      | price between 100 and 500 |

  @regression @negative @edge
  Scenario: No results message and reset option
    # Edge case when filters yield no matching products
    Given the catalog contains multiple products
    When the business admin searches with criteria that match no products
    Then a clear no-results message is displayed
    And an option to reset filters is offered

  @regression @negative @error
  Scenario: Catalog service unavailable
    # Error scenario when the catalog cannot be loaded
    Given the catalog service is unavailable
    When the business admin opens the product catalog
    Then an error message indicating the catalog cannot be loaded is displayed
    And the system provides a retry option

  @regression @boundary
  Scenario Outline: Boundary conditions for price filter
    # Boundary scenario for price filter using minimum and maximum values
    Given the catalog contains products priced at the boundary values
    When the business admin sets price filter from <min_price> to <max_price>
    Then products priced within <min_price> and <max_price> inclusive are shown

    Examples:
      | min_price | max_price |
      | 0 | 0 |
      | 1 | 1 |
      | 0 | 99999 |
