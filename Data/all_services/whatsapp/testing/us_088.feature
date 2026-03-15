@smoke @regression
Feature: Dark Mode
  As a end user
  I want to switch the interface to dark mode
  So that to reduce eye strain and improve usability in low-light conditions

  Background:
    Given the user is authenticated and viewing the application settings

  @smoke @regression @happy-path
  Scenario: Enable Dark Mode from settings
    # Verify the interface switches to dark theme immediately when selected
    When the user selects the Dark Mode option
    Then the interface switches to the dark theme immediately
    And the Dark Mode option is shown as selected

  @regression @happy-path
  Scenario: Persist Dark Mode across logout and login on same device
    # Verify Dark Mode preference is retained after logout and login on the same device
    Given Dark Mode is enabled
    When the user logs out and logs back in on the same device
    Then the application loads with the dark theme applied

  @regression @negative @error
  Scenario: Attempt to enable Dark Mode on unsupported browser
    # Verify user is informed and theme is unchanged when the browser does not support theme switching
    Given the user's browser does not support theme switching
    When the user selects the Dark Mode option
    Then a message indicates Dark Mode is not supported
    And the current theme remains unchanged

  @regression @edge-case
  Scenario: Toggle Dark Mode option multiple times
    # Verify the theme accurately follows the last selected option
    When the user toggles the Dark Mode option on and off rapidly
    Then the theme matches the final selected option
    And no visual glitches are displayed during the final state

  @regression @boundary @data-driven
  Scenario Outline: Theme selection retained for supported browsers
    # Verify selection behavior across supported browsers using a scenario outline
    Given the user is using a supported browser <browser>
    When the user selects the Dark Mode option
    Then the interface switches to the dark theme immediately
    And the preference is stored for the current device

    Examples:
      | browser |
      | Chrome (latest) |
      | Firefox (latest) |
      | Safari (latest) |
