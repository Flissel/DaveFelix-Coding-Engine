@smoke @regression
Feature: Schnellantworten
  As a business account user
  I want to select and send predefined quick replies in conversations
  So that to respond faster and maintain consistent communication with customers

  Background:
    Given a business account user is authenticated and viewing an active conversation

  @smoke @regression @happy-path
  Scenario Outline: Insert and send a selected quick reply
    # Valid quick replies are inserted into the message input and can be sent
    Given quick replies are configured for the business
    When the user opens the quick replies menu and selects <quick_reply>
    Then the message input contains the text <quick_reply_text>
    And the user can send the message

    Examples:
      | quick_reply | quick_reply_text |
      | Greeting | Hello! How can we help you today? |
      | Order Status | Your order is being processed. |

  @regression @edge-case
  Scenario: Show empty state when no quick replies exist
    # Opening the menu without configured quick replies shows an empty state message
    Given no quick replies are configured for the business
    When the user opens the quick replies menu
    Then an empty state message is displayed indicating no quick replies are available

  @regression @negative
  Scenario: Prevent access when user lacks permission
    # Users without permission cannot access quick replies and receive an error
    Given the user does not have permission to use business messaging tools
    When the user attempts to access the quick replies menu
    Then access is blocked
    And an appropriate error message is shown

  @regression @boundary
  Scenario Outline: Handle quick reply with maximum allowed length
    # A quick reply at the maximum configured length can be inserted and sent
    Given a quick reply exists with text length of <max_length> characters
    When the user selects the maximum length quick reply
    Then the message input contains the full quick reply text
    And the user can send the message without truncation

    Examples:
      | max_length |
      | 500 |
