@smoke @regression
Feature: Spam-Erkennung
  As a system administrator
  I want to enable and configure automatic spam detection for user-generated content
  So that reduce spam exposure and protect platform quality with minimal manual moderation

  Background:
    Given spam detection is enabled with configured spam rules

  @happy-path @smoke @regression
  Scenario Outline: Flag and block content that matches spam rules
    # Validates that matching content is flagged and not published
    Given a user prepares content with text "<content>"
    When the user submits the content
    Then the system flags the content as spam
    And the content is not published

    Examples:
      | content |
      | Buy now!!! http://spam.example |
      | FREE gift with promo code SPAM123 |

  @happy-path @regression
  Scenario Outline: Accept and publish content that does not match spam rules
    # Validates that non-spam content is accepted and published
    Given a user prepares content with text "<content>"
    When the user submits the content
    Then the system accepts the content
    And the content is published normally

    Examples:
      | content |
      | This is a genuine product review. |
      | Looking forward to the event next week. |

  @edge @regression
  Scenario Outline: Handle boundary condition for exact rule match
    # Validates that content matching a rule exactly is flagged
    Given a spam rule exists for the exact phrase "<phrase>"
    And a user prepares content with text "<content>"
    When the user submits the content
    Then the system flags the content as spam
    And the content is not published

    Examples:
      | phrase | content |
      | CLICK HERE | CLICK HERE |
      | Limited offer | Limited offer |

  @error @negative @regression
  Scenario Outline: Route content to manual review when spam service fails
    # Validates error handling when the spam detection service is unavailable
    Given the spam detection service returns "<error>"
    And a user prepares content with text "<content>"
    When the user submits the content
    Then the system logs the error
    And the content is routed to the manual review queue

    Examples:
      | error | content |
      | timeout | Please review my post. |
      | 500 internal server error | Hello community! |
