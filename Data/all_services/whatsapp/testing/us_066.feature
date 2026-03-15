@@smoke @@regression
Feature: Benachrichtigungsvorschau
  As a notification administrator
  I want to configure and preview notification templates before sending
  So that to ensure messages are accurate and consistent across channels, reducing errors and rework

  Background:
    Given a notification template with placeholders is open in the configuration view

  @@smoke @@happy-path @@regression
  Scenario: Preview resolves placeholders with sample data
    # Validates successful preview generation with all placeholders resolved
    Given the administrator has provided sample data for all placeholders
    When the administrator clicks the Preview button
    Then the system displays a preview with all placeholders replaced by the sample data
    And the preview shows the selected delivery channel formatting

  @@regression @@happy-path
  Scenario Outline: Channel-specific preview reflects formatting constraints
    # Ensures preview adapts to channel-specific formatting and length constraints
    Given the administrator selects the <channel> delivery channel
    And the administrator has provided valid sample data
    When the administrator generates a preview
    Then the system displays a <channel> specific preview
    And the preview complies with the <constraint> constraint

    Examples:
      | channel | constraint |
      | Email | HTML formatting |
      | SMS | maximum character length |
      | Push | title and body layout |

  @@negative @@regression
  Scenario: Validation error when required placeholder data is missing
    # Prevents preview generation when required sample data is not provided
    Given the template includes a required placeholder with no sample data provided
    When the administrator attempts to generate a preview
    Then the system displays a validation error indicating the missing placeholder data
    And no preview is generated

  @@regression @@boundary
  Scenario Outline: Boundary: SMS preview at maximum length
    # Verifies preview generation when content is exactly at the SMS character limit
    Given the administrator selects the SMS delivery channel
    And the sample data results in a preview length of <max_length> characters
    When the administrator generates a preview
    Then the system displays the preview without truncation or error
    And the character count equals <max_length>

    Examples:
      | max_length |
      | 160 |
