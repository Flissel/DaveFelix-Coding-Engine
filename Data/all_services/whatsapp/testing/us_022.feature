@smoke @regression
Feature: Formatierte Texte
  As a chat user
  I want to format text using basic styles (e.g., bold, italic, underline) while composing a message
  So that so that messages are clearer and emphasize important information

  Background:
    Given the user is in an active chat and the message composer is open

  @smoke @happy-path
  Scenario: Send message with a single supported format
    # Verifies that a supported formatting option is rendered in the editor and the delivered message
    Given the user has entered the text "Hello World"
    When the user applies the "bold" format to the word "World" and sends the message
    Then the editor shows "World" as bold
    And the delivered message renders "World" in bold

  @regression
  Scenario: Send plain text without formatting
    # Validates that unformatted text is delivered exactly as typed
    Given the user has entered the text "Just plain text"
    When the user sends the message
    Then the delivered message matches "Just plain text" exactly
    And no formatting is applied in the delivered message

  @regression @edge
  Scenario: Apply multiple supported formats to the same segment
    # Ensures combined formatting is preserved in the delivered message
    Given the user has entered the text "Important"
    When the user applies "bold" and "italic" to the entire text and sends the message
    Then the editor renders the text with both bold and italic
    And the delivered message renders the text with both bold and italic

  @negative @regression
  Scenario: Unsupported formatting is ignored
    # Validates that unsupported formatting does not break message delivery
    Given the user has entered the text "Unsupported style"
    When the user applies the unsupported "strikethrough" format and sends the message
    Then the delivered message contains the text without strikethrough
    And the message is delivered without errors

  @regression @boundary
  Scenario: Formatting boundary with minimal selection
    # Checks formatting applied to a single character
    Given the user has entered the text "A"
    When the user applies the "underline" format to the character and sends the message
    Then the delivered message renders the character underlined
    And no other characters are affected

  @regression
  Scenario Outline: Supported formatting options outline
    # Data-driven coverage of each supported format
    Given the user has entered the text "Sample"
    When the user applies the "<format>" format to the text and sends the message
    Then the delivered message renders the text with "<format>"

    Examples:
      | format |
      | bold |
      | italic |
      | underline |
