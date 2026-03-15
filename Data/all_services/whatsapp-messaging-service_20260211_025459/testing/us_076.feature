@smoke @regression
Feature: Nachrichtensuche per Volltext
  As a registrierter Nutzer
  I want to Nachrichten per Volltextsuche finden
  So that relevante Informationen schnell wiederfinden und die Kommunikation effizienter gestalten

  Background:
    Given der Nutzer ist angemeldet
    And der Nutzer befindet sich im Nachrichtenverlauf

  @@smoke @@regression @@happy-path
  Scenario: Erfolgreiche Volltextsuche liefert passende Nachrichten
    # Prüft, dass Nachrichten mit dem Suchbegriff im Text angezeigt werden
    Given es existieren Nachrichten mit dem Text "Projektstatus" im Verlauf
    When der Nutzer den Suchbegriff "Projektstatus" eingibt und die Suche startet
    Then zeigt das System alle Nachrichten an, die den Suchbegriff im Text enthalten
    And zeigt das System keine Nachrichten ohne den Suchbegriff

  @@regression @@negative
  Scenario: Suche ohne Treffer zeigt leere Ergebnisliste
    # Prüft, dass bei keinem Treffer ein Hinweis angezeigt wird
    Given es existieren Nachrichten, die den Suchbegriff nicht enthalten
    When der Nutzer den Suchbegriff "nichtvorhanden" eingibt und die Suche startet
    Then zeigt das System eine leere Ergebnisliste
    And zeigt das System den Hinweis, dass keine Treffer gefunden wurden

  @@regression @@negative
  Scenario: Suche ohne Eingabe eines Suchbegriffs
    # Prüft, dass keine Suche ohne Suchbegriff gestartet wird
    When der Nutzer die Suche ohne Eingabe eines Suchbegriffs startet
    Then fordert das System zur Eingabe eines Suchbegriffs auf
    And startet das System keine Suche

  @@regression @@edge
  Scenario: Suchbegriff mit Sonderzeichen und gemischter Groß-/Kleinschreibung
    # Prüft Robustheit der Suche bei Sonderzeichen und Case-Variation
    Given es existieren Nachrichten mit dem Text "API-Update v2.0" im Verlauf
    When der Nutzer den Suchbegriff "api-update v2.0" eingibt und die Suche startet
    Then zeigt das System alle Nachrichten an, die den Suchbegriff im Text enthalten
    And zeigt das System keine Nachrichten ohne den Suchbegriff

  @@regression @@boundary
  Scenario Outline: Datengetriebene Suche nach unterschiedlichen Begriffslängen
    # Prüft Suchverhalten bei minimalen und maximalen Begriffslängen
    Given es existieren Nachrichten mit dem Text "{term}" im Verlauf
    When der Nutzer den Suchbegriff "{term}" eingibt und die Suche startet
    Then zeigt das System alle Nachrichten an, die den Suchbegriff im Text enthalten

    Examples:
      | term |
      | A |
      | SehrLangerSuchbegriffMitMehrAlsFuenfzigZeichen1234567890 |
