@smoke @regression
Feature: Web-Version
  As a Endnutzer
  I want to die Anwendung als Web-Version im Browser nutzen, ohne eine App zu installieren
  So that plattformuebergreifend, schnell und sicher auf Funktionen zugreifen zu koennen

  Background:
    Given the web application is available
    And a valid user account exists

  @happy-path @smoke @regression
  Scenario: Successful login and full core functionality on web
    # Validates that a user can log in and access core functions with acceptable performance
    Given the user has a modern browser and a stable internet connection
    When the user opens the web version and logs in with valid credentials
    Then the user can access core features end-to-end
    And core pages load within the defined performance threshold

  @happy-path @regression
  Scenario: Cross-device data consistency for chats and settings
    # Ensures that existing chats and settings are consistent after switching devices
    Given the user has existing chats and saved settings on another device
    When the user logs in to the web version with the same account
    Then the user sees the same chats and settings on the web version

  @negative @regression
  Scenario: Graceful recovery when internet is unstable
    # Verifies error messaging and data preservation during unstable connectivity
    Given the user is logged in on the web version
    And the internet connection becomes unstable or disconnected
    When the user attempts to perform a data-changing action
    Then the user receives a clear error message
    And the application retries recovery without data loss when the connection restores

  @edge-case @negative @regression
  Scenario: Unsupported or outdated browser access is blocked
    # Edge case where the browser does not meet minimum requirements
    Given the user attempts to access the web version with an unsupported browser
    When the web version loads
    Then the user is informed that the browser is not supported
    And no login or core features are accessible

  @boundary @regression
  Scenario Outline: Boundary performance for core feature loading
    # Validates performance at the maximum acceptable latency threshold
    Given the user has a stable internet connection at the minimum supported bandwidth
    When the user logs in and navigates to a core feature page
    Then the page loads within the maximum acceptable response time

    Examples:
      | min_bandwidth_mbps | max_response_time_ms |
      | 1.5 | 3000 |

  @negative @regression
  Scenario Outline: Scenario Outline: Data integrity during intermittent connection retries
    # Ensures data is not duplicated or lost during multiple retry attempts
    Given the user is logged in and has an intermittent connection pattern
    When the user sends a message during a connection drop
    Then the message is stored exactly once after recovery
    And the user sees a clear status indicator during retry

    Examples:
      | pattern |
      | drop-then-recover-5s |
      | flap-3-times-within-10s |
