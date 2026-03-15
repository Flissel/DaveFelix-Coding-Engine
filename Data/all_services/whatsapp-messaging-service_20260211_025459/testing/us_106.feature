@@smoke @@regression
Feature: Screenreader-Unterstuetzung
  As a Endnutzer mit Screenreader
  I want to die Anwendung vollständig per Screenreader bedienen und alle Inhalte korrekt auslesen lassen
  So that Barrierefreiheit sicherzustellen und die Anwendung zuverlässig und intuitiv nutzen zu können

  Background:
    Given die Anwendung ist geladen und ein Screenreader ist aktiv

  @@smoke @@regression @@happy-path
  Scenario: Hauptnavigation und zentrale Funktionen werden korrekt vorgelesen
    # Validates that interactive elements expose correct roles, states and labels in primary navigation
    When der Nutzer mit der Tastatur durch die Hauptnavigation und zentrale Funktionen navigiert
    Then der Screenreader liest für jedes interaktive Element Rolle, Zustand und Beschriftung korrekt vor
    And der Fokus bleibt auf dem aktuell navigierten Element

  @@regression @@happy-path
  Scenario: Dynamische Inhalte werden per ARIA-Live angekündigt
    # Ensures updates in dynamic views are announced without focus changes
    Given eine Ansicht mit dynamischen Inhalten wie Nachrichtenliste oder Statusmeldungen ist geöffnet
    When neue Inhalte erscheinen oder bestehende Inhalte aktualisiert werden
    Then der Screenreader kündigt die Änderung über eine geeignete ARIA-Live-Region an
    And der Fokus wird nicht unerwartet verschoben

  @@regression @@negative
  Scenario: Pflichtfeld-Validierung setzt Fokus und liest Fehlermeldung
    # Verifies error messaging and focus management for required fields
    Given ein Formular mit Pflichtfeldern ist geöffnet
    When der Nutzer ein Pflichtfeld leer lässt und das Formular absendet
    Then der Screenreader liest die Fehlermeldung vor
    And der Fokus wird auf das fehlerhafte Pflichtfeld gesetzt

  @@regression @@edge-case
  Scenario Outline: ARIA-Live-Regionen für verschiedene Update-Typen
    # Checks announcements for multiple dynamic update types
    Given eine dynamische Ansicht mit ARIA-Live-Regionen ist geöffnet
    When der Update-Typ ist <update_type> und die Änderung betrifft <content_type>
    Then die Änderung wird vom Screenreader mit geeigneter Dringlichkeit angekündigt
    And der Fokus bleibt auf dem aktuell aktiven Element

    Examples:
      | update_type | content_type |
      | polite | neue Nachricht in der Liste |
      | assertive | kritische Statusmeldung |

  @@regression @@boundary
  Scenario: Grenzfall: Navigation mit minimaler Fokusreihenfolge
    # Ensures correct reading order when only one interactive element is present
    Given eine Ansicht mit genau einem interaktiven Element ist geöffnet
    When der Nutzer die Ansicht per Tastatur erreicht
    Then der Screenreader liest Rolle, Zustand und Beschriftung des Elements korrekt vor
    And der Fokus bleibt stabil auf dem einzigen Element

  @@regression @@negative @@error
  Scenario: Fehlende ARIA-Beschriftung wird erkannt
    # Validates error handling when an interactive element lacks an accessible name
    Given ein interaktives Element ohne ARIA-Beschriftung ist in der Hauptnavigation vorhanden
    When der Nutzer dieses Element fokussiert
    Then der Screenreader kann keine korrekte Beschriftung vorlesen
    And die Anwendung protokolliert einen Barrierefreiheitsfehler

  @@regression @@negative @@outline
  Scenario Outline: Pflichtfeld-Validierung für verschiedene Feldtypen
    # Data-driven check for different required field types and error announcements
    Given ein Formular mit dem Pflichtfeldtyp <field_type> ist geöffnet
    When der Nutzer das Pflichtfeld leer lässt und absendet
    Then der Screenreader liest die Fehlermeldung für <field_type> vor
    And der Fokus wird auf das Pflichtfeld vom Typ <field_type> gesetzt

    Examples:
      | field_type |
      | Textfeld |
      | Dropdown |
      | Checkbox |
