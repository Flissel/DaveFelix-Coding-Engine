@smoke @regression
Feature: Desktop Application Download and Usage
  As a end user
  I want to download and use a native desktop application to access the system
  So that so that I can work with the system using a performant, OS-integrated application

  Background:
    Given the user is on the desktop application download page

  @smoke @happy-path @regression
  Scenario: Successful download, installation, and launch on supported OS
    # Validates that supported OS users can download, install, and launch the app to access main features
    Given the user is on a supported desktop operating system
    When the user downloads and installs the desktop application
    Then the application installs successfully
    And the user can launch the app and access the system’s main features

  @regression @happy-path
  Scenario Outline: Supported OS download availability and install success by OS
    # Verifies that each supported OS is offered a download and installation completes
    Given the user is on <os_name>
    When the user requests the desktop application download
    Then the correct installer for <os_name> is provided
    And the application installs successfully on <os_name>

    Examples:
      | os_name |
      | Windows 11 |
      | macOS 13 |
      | Ubuntu 22.04 |

  @negative @regression
  Scenario: Unsupported OS blocked from download
    # Ensures users on unsupported OS are informed and no download is provided
    Given the user is on an unsupported operating system
    When the user attempts to download the desktop application
    Then the user is informed that the OS is not supported
    And no download link or installer is provided

  @negative @regression
  Scenario Outline: Unsupported OS messaging by OS type
    # Validates consistent messaging for multiple unsupported OS types
    Given the user is on <unsupported_os>
    When the user requests the desktop application download
    Then a message indicates <unsupported_os> is not supported
    And no download is initiated

    Examples:
      | unsupported_os |
      | Windows 8.1 |
      | macOS 10.13 |
      | ChromeOS |

  @negative @regression
  Scenario: Corrupted installer fails gracefully
    # Verifies installation failure handling with clear error and guidance
    Given the user has a corrupted installation package
    When the user attempts to install the desktop application
    Then the installation fails gracefully
    And a clear error message with guidance to retry or download again is displayed

  @edge-case @regression
  Scenario: Edge case: Launch app without network connectivity
    # Checks that app launch is possible and user receives a clear connectivity message
    Given the desktop application is installed
    And the user has no network connectivity
    When the user launches the app
    Then the app launches successfully
    And the user is informed that connectivity is required to access main features

  @boundary @regression
  Scenario Outline: Boundary condition: Minimum supported OS versions
    # Validates behavior on minimum supported OS versions
    Given the user is on the minimum supported OS version <min_os>
    When the user downloads and installs the desktop application
    Then the application installs successfully on <min_os>
    And the app can be launched and access main features

    Examples:
      | min_os |
      | Windows 10 |
      | macOS 12 |
      | Ubuntu 20.04 |
