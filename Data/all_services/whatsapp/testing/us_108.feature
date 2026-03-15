@@smoke @@regression
Feature: Color Contrast Compliance
  As a website visitor
  I want to use the interface with sufficient color contrast between text and background
  So that to read and navigate content reliably, improving accessibility and usability

  Background:
    Given the user is on the website with the standard theme enabled

  @@smoke @@regression @@happy-path
  Scenario: Standard theme meets WCAG AA contrast ratios for core elements
    # Validates that text, icons, and UI components in the standard theme meet required contrast ratios
    Given the page is rendered in the standard theme
    When the user views text, icons, and interactive elements
    Then normal text contrast ratio is at least 4.5:1 against its background
    And large text and UI components contrast ratio is at least 3:1 against their background

  @@regression @@happy-path
  Scenario Outline: Component states maintain contrast across sections
    # Checks contrast in all UI states across different components and sections
    Given the user navigates to a page section containing the <component>
    When the <component> is in the <state> state
    Then the contrast ratio for the <component> foreground and background meets WCAG AA

    Examples:
      | component | state |
      | button | default |
      | link | hover |
      | form label | focus |
      | status indicator | active |
      | button | disabled |

  @@regression @@edge-case
  Scenario Outline: Alternate theme preserves contrast requirements
    # Ensures high-contrast or dark mode still meets contrast ratios
    Given the user enables the <theme> theme
    When the interface switches to the <theme> theme
    Then normal text contrast ratio is at least 4.5:1
    And large text and UI components contrast ratio is at least 3:1

    Examples:
      | theme |
      | high-contrast |
      | dark |

  @@negative @@regression
  Scenario Outline: Detects insufficient contrast in custom styling
    # Negative test to ensure the system flags insufficient contrast
    Given a component is styled with the <foreground> color on the <background> color
    When the system evaluates the contrast ratio
    Then the contrast check fails for WCAG AA thresholds
    And an accessibility violation is reported for the component

    Examples:
      | foreground | background |
      | light gray | white |
      | yellow | white |
