@@smoke @@regression
Feature: Schriftgroesse
  As a end user
  I want to adjust the font size in the system interface
  So that to improve readability and accessibility according to personal needs

  Background:
    Given the user is logged in and viewing a content page

  @@smoke @@regression @@happy-path
  Scenario Outline: Update font size immediately on current page
    # Verifies that selecting a different font size updates the current page text immediately
    Given the font size settings panel is available
    When the user selects a valid font size option
    Then the text on the current page updates to the selected font size immediately
    And the selected font size is shown as active in the settings

    Examples:
      | selected_font_size |
      | Medium |
      | Large |

  @@regression @@happy-path
  Scenario Outline: Persist chosen font size across navigation and sessions
    # Ensures the chosen font size is saved and applied after navigation and re-login
    Given the user has selected a valid font size
    When the user navigates to another page
    Then the text on the new page is displayed with the chosen font size
    When the user logs out and logs in again later
    Then the chosen font size is applied consistently after login

    Examples:
      | selected_font_size |
      | Small |
      | Extra Large |

  @@regression @@negative @@boundary
  Scenario Outline: Prevent selection below minimum font size
    # Validates the system blocks sizes below the minimum limit and keeps the nearest allowed size
    Given the minimum font size is defined
    And the current font size is set to the minimum allowed
    When the user attempts to select a font size below the minimum
    Then the system prevents the selection
    And the font size remains at the minimum allowed

    Examples:
      | min_font_size | attempted_font_size |
      | Small | Extra Small |

  @@regression @@negative @@boundary
  Scenario Outline: Prevent selection above maximum font size
    # Validates the system blocks sizes above the maximum limit and keeps the nearest allowed size
    Given the maximum font size is defined
    And the current font size is set to the maximum allowed
    When the user attempts to select a font size above the maximum
    Then the system prevents the selection
    And the font size remains at the maximum allowed

    Examples:
      | max_font_size | attempted_font_size |
      | Extra Large | Ultra Large |
