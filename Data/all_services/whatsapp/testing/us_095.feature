@smoke @regression
Feature: Chat anpinnen
  As a registered user
  I want to pin an important chat to the top of the chat list
  So that so that I can quickly access high-priority conversations

  Background:
    Given the user is logged in and viewing the chat list

  @smoke @happy-path
  Scenario Outline: Pin an unpinned chat to the top of the list
    # Verifies that a non-pinned chat can be pinned and moved to the top
    Given the chat list contains an unpinned chat named "<chat_name>"
    When the user selects the option to pin the chat "<chat_name>"
    Then the chat "<chat_name>" is marked as pinned
    And the chat "<chat_name>" appears at the top of the chat list

    Examples:
      | chat_name |
      | Project Alpha |

  @regression @happy-path
  Scenario Outline: Unpin a pinned chat and restore its normal position
    # Verifies that a pinned chat can be unpinned and returns to the sorted position
    Given the chat list contains a pinned chat named "<chat_name>"
    When the user selects the option to unpin the chat "<chat_name>"
    Then the chat "<chat_name>" is not marked as pinned
    And the chat "<chat_name>" appears in its normal position based on sorting rules

    Examples:
      | chat_name |
      | Team Updates |

  @regression @negative @error
  Scenario Outline: Prevent pinning when maximum pinned chats is reached
    # Ensures the system blocks pinning beyond the allowed maximum and shows a message
    Given the user has already pinned the maximum number of chats "<max_pins>"
    And the chat list contains an unpinned chat named "<chat_name>"
    When the user selects the option to pin the chat "<chat_name>"
    Then the system prevents the chat from being pinned
    And an informative message "<message>" is displayed

    Examples:
      | max_pins | chat_name | message |
      | 5 | Finance | You have reached the maximum number of pinned chats. |

  @regression @edge @boundary
  Scenario Outline: Pinning at boundary when one slot is available
    # Validates that pinning succeeds when pinned count is one less than maximum
    Given the user has pinned "<pinned_count>" chats and the maximum is "<max_pins>"
    And the chat list contains an unpinned chat named "<chat_name>"
    When the user selects the option to pin the chat "<chat_name>"
    Then the chat "<chat_name>" is marked as pinned
    And the total number of pinned chats equals "<max_pins>"

    Examples:
      | pinned_count | max_pins | chat_name |
      | 4 | 5 | HR |
