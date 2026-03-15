@@smoke @@regression
Feature: Screenreader-Unterstuetzung
  As a user with visual impairment
  I want to navigate and operate all system features using a screen reader
  So that so that they can independently access and complete tasks, ensuring accessibility compliance and inclusivity

  Background:
    Given the user has a screen reader enabled
    And the user is on an application page with interactive elements

  @@smoke @@regression @@happy-path
  Scenario: Announce interactive elements in logical order
    # Happy path for navigating interactive elements with correct labels, roles, and states
    When the user navigates the page using keyboard and screen reader commands
    Then all interactive elements are announced with correct labels, roles, and states
    And the announcements follow a logical focus order

  @@regression @@happy-path
  Scenario: Screen reader announces form control details
    # Happy path for announcing purpose, required status, and current value
    Given the user focuses a form control
    When the screen reader reads the focused element
    Then the control purpose, required status, and current value are announced accurately

  @@regression @@edge-case
  Scenario: Live region announcements for dynamic updates
    # Edge case for dynamic content updates without full page reload
    Given the page contains a live region for dynamic updates
    When the user performs an action that triggers a dynamic content change
    Then the screen reader announces the update via the live region

  @@regression @@negative @@error
  Scenario: Validation errors are announced and focus moves to first invalid field
    # Error scenario for form submission with invalid or missing data
    Given the user is on a form with required fields
    When the user submits the form with invalid or missing data
    Then the screen reader announces validation errors
    And focus moves to the first invalid field

  @@regression @@boundary
  Scenario: Announce state changes for toggle controls
    # Boundary condition for controls with state changes
    Given the user focuses a toggle control
    When the user changes the toggle state
    Then the screen reader announces the updated state accurately

  @@regression @@edge-case
  Scenario Outline: Form control announcement across different input types
    # Data-driven verification for various form input types
    Given the user focuses the <control_type> control labeled <label>
    When the screen reader reads the focused element
    Then the control purpose is announced as <label>
    And the required status is announced as <required_status>
    And the current value is announced as <current_value>

    Examples:
      | control_type | label | required_status | current_value |
      | text field | First Name | required | empty |
      | checkbox | Accept Terms | required | unchecked |
      | dropdown | Country | optional | Germany |
