@smoke @regression
Feature: Regionale Formate
  As a end user
  I want to view and enter dates, numbers, and currencies in their local regional format
  So that so that information is understood and processed correctly without confusion or errors

  Background:
    Given the user is authenticated and on a form with date, number, and currency fields

  @happy-path @smoke @regression
  Scenario: Display values in de-DE locale
    # Verify date, number, and currency are displayed in German format
    Given the user locale is set to de-DE
    When the user views the record with date 2024-12-31, number 1234.56, and currency 1234.56 EUR
    Then the system displays the date as 31.12.2024
    And the system displays the number as 1.234,56
    And the system displays the currency as 1.234,56 €

  @happy-path @regression
  Scenario: Accept and store inputs for en-US locale
    # Verify the system accepts and stores input in US format
    Given the user locale is set to en-US
    When the user enters date 12/31/2024 and number 1,234.56
    And the user submits the form
    Then the system stores the date as 2024-12-31
    And the system stores the number as 1234.56

  @negative @regression
  Scenario: Reject input that does not match active locale format
    # Validate error is shown for mismatched regional format
    Given the user locale is set to de-DE
    When the user enters date 12/31/2024 and number 1,234.56
    And the user submits the form
    Then the system shows a validation error indicating the required regional format

  @edge-case @regression
  Scenario Outline: Accept boundary numeric values per locale
    # Verify minimum and maximum numeric values are accepted in locale format
    Given the user locale is set to <locale>
    When the user enters number <input_number>
    And the user submits the form
    Then the system stores the number as <stored_number>

    Examples:
      | locale | input_number | stored_number |
      | en-US | 0.00 | 0.00 |
      | de-DE | 0,01 | 0.01 |
      | en-US | 9,999,999.99 | 9999999.99 |
      | de-DE | 9.999.999,99 | 9999999.99 |

  @edge-case @negative @regression
  Scenario: Handle ambiguous date formats on locale switch
    # Ensure dates are validated against the active locale after switching
    Given the user locale is switched from en-US to de-DE
    When the user enters date 04/05/2024
    And the user submits the form
    Then the system shows a validation error indicating the required regional format

  @edge-case @regression
  Scenario Outline: Validate currency formatting for zero and negative values
    # Verify currency display for boundary and negative values
    Given the user locale is set to <locale>
    When the user views a record with currency value <currency_value>
    Then the system displays the currency as <display_value>

    Examples:
      | locale | currency_value | display_value |
      | en-US | 0 | $0.00 |
      | de-DE | 0 | 0,00 € |
      | en-US | -1234.56 | -$1,234.56 |
      | de-DE | -1234.56 | -1.234,56 € |
