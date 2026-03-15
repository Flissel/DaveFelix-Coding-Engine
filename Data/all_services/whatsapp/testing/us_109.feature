@@smoke @@regression
Feature: Sprachnachrichten transkribieren
  As a app user
  I want to request transcription of a voice message
  So that to understand the content quickly and search or reference it later

  Background:
    Given the app user is authenticated and has access to voice messages

  @@smoke @@regression @@happy-path
  Scenario: Transcribe a supported voice message successfully
    # Validates that a readable transcription is provided for supported languages with acceptable audio quality
    Given a voice message in a supported language with acceptable audio quality is available
    When the user selects the transcription option
    Then the system provides a readable text transcription
    And the transcription is displayed alongside the voice message

  @@regression @@happy-path
  Scenario Outline: Transcription is generated with minimal delay for supported languages
    # Ensures minimal delay for supported languages and acceptable audio quality across different languages
    Given a voice message in <language> with acceptable audio quality is available
    When the user requests transcription
    Then the transcription is generated with minimal delay
    And the transcription is displayed alongside the message

    Examples:
      | language |
      | German |
      | English |
      | Spanish |

  @@regression @@negative
  Scenario Outline: Unsupported language informs the user
    # Validates user notification when transcription is requested for unsupported languages
    Given a voice message in <language> is available
    When the user requests transcription
    Then the system informs the user that transcription is not possible or may be inaccurate

    Examples:
      | language |
      | Klingon |
      | Elvish |

  @@regression @@negative
  Scenario: Poor audio quality warns the user
    # Validates user notification when audio quality is poor
    Given a voice message in a supported language with poor audio quality is available
    When the user requests transcription
    Then the system informs the user that transcription is not possible or may be inaccurate

  @@regression @@edge-case
  Scenario: Boundary condition for minimum acceptable audio quality
    # Ensures transcription works at the lowest acceptable audio quality threshold
    Given a voice message in a supported language with audio quality at the minimum acceptable threshold is available
    When the user selects the transcription option
    Then the system provides a readable text transcription
    And the transcription is displayed alongside the voice message

  @@regression @@edge-case
  Scenario: Boundary condition for very short voice message
    # Ensures transcription is provided for the shortest allowable voice message duration
    Given a very short voice message in a supported language with acceptable audio quality is available
    When the user requests transcription
    Then the system provides a readable text transcription
    And the transcription is displayed alongside the voice message
