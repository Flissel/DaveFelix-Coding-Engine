@@smoke @@regression
Feature: Sprache
  As a Endnutzer
  I want to die Anwendung in einer bevorzugten Sprache auswählen und nutzen
  So that eine einfache und intuitive Bedienung sowie bessere Verständlichkeit zu erhalten

  Background:
    Given die Anwendung ist gestartet und es sind mehrere Sprachen konfiguriert

  @@smoke @@regression @@happy-path
  Scenario Outline: Manuelle Sprachauswahl zeigt alle UI-Texte in der gewählten Sprache
    # Happy Path: Der Nutzer wählt eine verfügbare Sprache und alle UI-Elemente werden übersetzt angezeigt
    Given der Endnutzer befindet sich auf der Sprach-Auswahlseite
    When der Endnutzer die Sprache <language> auswählt
    Then werden alle UI-Texte, Systemmeldungen und Navigationselemente in <language> angezeigt
    And die Auswahl wird in den Benutzereinstellungen gespeichert

    Examples:
      | language |
      | Deutsch |
      | Englisch |

  @@regression @@edge-case
  Scenario Outline: Automatische Spracherkennung bei keiner manuellen Auswahl
    # Edge Case: Wenn keine Sprache gewählt ist, wird die Gerätesprache verwendet und kann überschrieben werden
    Given der Endnutzer hat noch keine Sprache manuell ausgewählt
    And die Gerätesprache ist <device_language>
    When die Anwendung die Sprache initialisiert
    Then wird die UI automatisch in <device_language> angezeigt
    And der Endnutzer kann die Sprache jederzeit manuell überschreiben

    Examples:
      | device_language |
      | Deutsch |
      | Französisch |

  @@regression @@negative
  Scenario Outline: Nicht unterstützte Sprache wird abgelehnt
    # Error Scenario: Die Auswahl einer nicht unterstützten Sprache bleibt ohne Änderung und zeigt eine Fehlermeldung
    Given die aktuelle Sprache ist <current_language>
    When der Endnutzer die nicht unterstützte Sprache <unsupported_language> auswählt und bestätigt
    Then bleibt die aktuelle Sprache <current_language> aktiv
    And es wird eine verständliche Fehlermeldung angezeigt

    Examples:
      | current_language | unsupported_language |
      | Deutsch | Klingonisch |
      | Englisch | Latein |

  @@regression @@boundary
  Scenario Outline: Wechsel zwischen Sprachen bei minimaler und maximaler Konfiguration
    # Boundary Condition: Sprache wechseln bei minimaler/ maximaler Anzahl verfügbarer Sprachen
    Given es sind <configured_languages_count> Sprachen konfiguriert
    When der Endnutzer eine verfügbare Sprache auswählt
    Then werden alle UI-Texte, Systemmeldungen und Navigationselemente vollständig in der gewählten Sprache angezeigt
    And die Anwendung bleibt bedienbar ohne Layout- oder Textabbrüche

    Examples:
      | configured_languages_count |
      | 1 |
      | 20 |
