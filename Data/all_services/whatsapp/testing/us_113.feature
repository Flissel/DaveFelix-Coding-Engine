@smoke @regression
Feature: Batterieeffizienz
  As a mobile app user
  I want to use the application throughout the day without excessive battery drain
  So that to maintain device usability and avoid frequent recharging

  Background:
    Given the app is installed on a supported device with battery monitoring enabled

  @happy-path @smoke @regression
  Scenario: Foreground usage stays within efficiency threshold
    # Validates battery consumption during typical foreground usage
    Given the app is running in the foreground
    When the user performs standard tasks for 30 minutes
    Then battery consumption is within the defined foreground efficiency threshold
    And no unexpected power warnings are triggered

  @happy-path @regression
  Scenario: Background idle usage stays within limit
    # Validates minimal background activity during idle time
    Given the app is running in the background
    When the device is idle for 1 hour
    Then background activity is minimized
    And battery usage does not exceed the defined background usage limit

  @happy-path @regression
  Scenario: Low-power mode reduces non-essential processing
    # Validates reduced processing and acceptable performance in low-power mode
    Given the device is in low-power mode
    When the app is opened or resumes
    Then non-essential processing is reduced
    And performance remains acceptable without increased battery drain

  @boundary @regression
  Scenario Outline: Boundary: Foreground usage at threshold duration
    # Validates battery consumption at the 30-minute boundary
    Given the app is running in the foreground
    When the user performs standard tasks for <duration_minutes> minutes
    Then battery consumption remains within the defined foreground efficiency threshold

    Examples:
      | duration_minutes |
      | 29 |
      | 30 |
      | 31 |

  @edge @regression
  Scenario Outline: Edge: Background idle close to limit
    # Validates battery usage when idle time is near the 1-hour limit
    Given the app is running in the background
    When the device is idle for <idle_minutes> minutes
    Then battery usage does not exceed the defined background usage limit

    Examples:
      | idle_minutes |
      | 59 |
      | 60 |
      | 61 |

  @negative @regression
  Scenario: Error: Excessive background activity triggers limit breach
    # Validates detection when background activity exceeds allowed limit
    Given the app is running in the background
    And a non-essential background task is forced to run continuously
    When the device is idle for 1 hour
    Then battery usage exceeds the defined background usage limit
    And the app logs a battery efficiency violation

  @negative @regression
  Scenario: Error: Low-power mode with non-essential processing not reduced
    # Validates failure handling if non-essential processing continues in low-power mode
    Given the device is in low-power mode
    And non-essential processing is enabled
    When the app resumes
    Then battery drain increases beyond acceptable levels
    And the app records a low-power efficiency failure
