@smoke @regression
Feature: Language Selection
  As a site visitor
  I want to select a preferred language for the interface
  So that so I can understand and use the system effectively in my language

  Background:
    Given the visitor is on a page where multiple interface languages are configured

  @happy-path @@smoke @@regression
  Scenario Outline: Select a supported language and see the interface update
    # Verifies the interface switches to the selected supported language on the current page
    When the visitor selects the supported language "<language>" from the language selector
    Then all interface text is displayed in "<language>" on the current page
    And the language selector shows "<language>" as the current selection

    Examples:
      | language |
      | English |
      | Deutsch |
      | Español |

  @happy-path @@regression
  Scenario Outline: Persist selected language across navigation and refresh
    # Ensures the selected language is сохранates for the session on navigation and refresh
    Given the visitor has selected the supported language "<language>"
    When the visitor navigates to another page and refreshes the page
    Then the interface remains displayed in "<language>"
    And the selected language is retained for the session

    Examples:
      | language |
      | English |
      | Deutsch |

  @error @@negative @@regression
  Scenario Outline: Attempt to select an unsupported language
    # Validates the system rejects unsupported language selections and keeps the current language
    Given the current interface language is "<current_language>"
    When the visitor attempts to select the unsupported language "<unsupported_language>"
    Then the interface remains in "<current_language>"
    And a message is displayed that the language is not available

    Examples:
      | current_language | unsupported_language |
      | English | Klingon |
      | Deutsch | Elvish |

  @edge @@regression
  Scenario Outline: Select language when only one language is configured
    # Checks boundary condition where only one language is available
    Given only one interface language "<only_language>" is configured
    When the visitor opens the language selector
    Then the selector shows only "<only_language>"
    And the interface is displayed in "<only_language>" without change

    Examples:
      | only_language |
      | English |
