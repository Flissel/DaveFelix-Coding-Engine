@smoke @regression
Feature: Web Version Access
  As a end user
  I want to access the system via a web browser
  So that use the system without installing any software and from any device

  Background:
    Given the system URL is available

  @smoke @happy-path
  Scenario Outline: Load web version in supported desktop browsers
    # Verifies the web version loads and core functionality is accessible in supported browsers
    Given the user has a supported browser and a stable internet connection
    When the user navigates to the system URL
    Then the web version loads successfully
    And the user can access core functionality

    Examples:
      | browser | version |
      | Chrome | latest |
      | Firefox | latest |
      | Safari | latest |

  @regression @happy-path
  Scenario Outline: Responsive usability on mobile devices
    # Ensures the web version is usable and responsive on mobile devices
    Given the user is on a mobile device with a supported browser
    When the user opens the system URL
    Then the web version loads successfully
    And the layout adapts to the screen size and remains usable

    Examples:
      | device | browser |
      | iPhone 14 | Safari |
      | Pixel 7 | Chrome |

  @negative @regression
  Scenario Outline: Unsupported browser displays guidance
    # Validates the system blocks unsupported browsers and suggests alternatives
    Given the user is using an unsupported browser
    When the user attempts to open the system URL
    Then the system displays an unsupported browser message
    And the message suggests supported alternatives

    Examples:
      | browser | version |
      | Internet Explorer | 11 |
      | Legacy Android Browser | 4.4 |

  @edge @regression
  Scenario Outline: Edge case: Slow network still loads with core access
    # Checks that the web version loads on slow connections without breaking core access
    Given the user has a supported browser and a slow internet connection
    When the user navigates to the system URL
    Then the web version loads within an acceptable time
    And core functionality remains accessible

    Examples:
      | network | max_load_seconds |
      | 3G | 10 |

  @boundary @regression
  Scenario Outline: Boundary: Minimum supported browser versions
    # Validates access at the minimum supported browser versions
    Given the user has a supported browser at the minimum supported version
    When the user opens the system URL
    Then the web version loads successfully
    And core functionality is accessible without critical UI issues

    Examples:
      | browser | version |
      | Chrome | minimum_supported |
      | Firefox | minimum_supported |

  @negative @error
  Scenario: Error: No internet connection
    # Ensures the user receives a clear error when offline
    Given the user has a supported browser and no internet connection
    When the user attempts to open the system URL
    Then the browser indicates the page cannot be reached
    And the system does not load
