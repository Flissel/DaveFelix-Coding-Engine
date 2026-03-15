@@smoke @@regression
Feature: Datumsbasierte Suche im Chatverlauf
  As a Endnutzer
  I want to in einem Chatverlauf zu einem bestimmten Datum springen
  So that um Nachrichten schnell und intuitiv zu finden und die Bedienung effizient zu halten

  Background:
    Given ein Endnutzer ist im Chatverlauf angemeldet und die Datumsnavigation ist sichtbar

  @@smoke @@regression @@happy-path
  Scenario: Sprung zu einem Datum mit vorhandenen Nachrichten
    # Happy path: gültiges Datum mit Nachrichten springt zum ersten Eintrag des Tages
    Given der Chatverlauf enthält Nachrichten an mehreren Tagen
    When der Nutzer wählt das Datum "2024-02-15" aus
    Then das System springt zum ersten Eintrag vom "2024-02-15"
    And der Verlauf wird ab diesem Zeitpunkt angezeigt

  @@regression @@edge
  Scenario: Kein Eintrag am gewählten Datum bietet nächsten verfügbaren Tag an
    # Edge case: Datum ohne Nachrichten zeigt Meldung und Navigation zum nächsten Tag
    Given der Chatverlauf enthält keine Nachrichten am ausgewählten Datum
    When der Nutzer wählt das Datum "2024-02-16" aus
    Then das System zeigt eine hilfreiche Meldung an
    And das System bietet den nächsten verfügbaren Tag zur Navigation an

  @@negative @@regression
  Scenario: Ungültige Datumseingabe verhindert die Suche
    # Error scenario: ungültiges Datum wird blockiert und markiert
    Given ein Datumseingabefeld ist verfügbar
    When der Nutzer ein ungültiges Datum eingibt
    Then das System verhindert die Suche
    And das System markiert die Eingabe als ungültig und fordert zur Korrektur auf

  @@regression @@boundary
  Scenario Outline: Datumsgrenzen innerhalb des Verlaufs
    # Boundary conditions: erster und letzter Tag im Verlauf
    Given der Chatverlauf beginnt am "2024-01-01" und endet am "2024-12-31"
    When der Nutzer ein Grenzdatum auswählt
    Then das System springt zum ersten Eintrag des gewählten Grenzdatums
    And der Verlauf wird ab diesem Zeitpunkt angezeigt

    Examples:
      | ausgewaehltes_datum |
      | 2024-01-01 |
      | 2024-12-31 |

  @@regression @@happy-path
  Scenario Outline: Datumsauswahl mit verschiedenen Eingabeformaten
    # Data-driven happy path: mehrere gültige Eingaben führen zum Sprung
    Given der Chatverlauf enthält Nachrichten am ausgewählten Datum
    When der Nutzer ein gültiges Datum eingibt
    Then das System springt zum ersten Eintrag dieses Datums

    Examples:
      | gueltiges_datum |
      | 2024-03-05 |
      | 2024-10-20 |

  @@negative @@regression
  Scenario Outline: Ungültige Datumsformate werden abgewiesen
    # Data-driven error scenario: verschiedene ungültige Formate
    Given ein Datumseingabefeld ist verfügbar
    When der Nutzer ein ungültiges Datumsformat eingibt
    Then das System verhindert die Suche
    And die Eingabe wird als ungültig markiert

    Examples:
      | ungueltiges_datum |
      | 31-02-2024 |
      | 2024/13/01 |
      | abcd-ef-gh |
