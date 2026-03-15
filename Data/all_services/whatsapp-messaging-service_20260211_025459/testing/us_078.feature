@@smoke @@regression
Feature: Chat-Suche
  As a Nutzer
  I want to Chats und Kontakte über eine Suchfunktion finden
  So that schnell relevante Konversationen erreichen und die Kommunikation effizient fortsetzen zu können

  Background:
    Given der Nutzer befindet sich in der Chat-Übersicht

  @@smoke @@regression @@happy-path
  Scenario: Suche liefert passende Chats und Kontakte bei vollständigem Namen
    # Happy path: exakte Namenssuche zeigt passende Ergebnisse
    When der Nutzer gibt den vollständigen Namen "Anna Schmidt" in das Suchfeld ein
    Then werden passende Chats und Kontakte in der Ergebnisliste angezeigt
    And jede Ergebniszeile enthält den Namen "Anna Schmidt"

  @@regression @@happy-path
  Scenario: Suche liefert passende Chats und Kontakte bei teilweisem Namen
    # Happy path: Teilstring-Suche zeigt relevante Ergebnisse
    When der Nutzer gibt den Teilnamen "Ann" in das Suchfeld ein
    Then werden passende Chats und Kontakte in der Ergebnisliste angezeigt
    And alle Ergebnisse enthalten den Teilnamen "Ann"

  @@regression @@negative @@error
  Scenario: Keine Treffer zeigt klare Meldung
    # Error scenario: Suche ohne Treffer zeigt Hinweis
    When der Nutzer gibt eine Suchanfrage "xyz_unbekannt" in das Suchfeld ein
    Then wird eine klare Meldung angezeigt, dass keine Ergebnisse gefunden wurden
    And die Ergebnisliste ist leer

  @@regression @@edge @@boundary
  Scenario Outline: Sonderzeichen und sehr kurze Suchanfragen werden robust verarbeitet
    # Edge and boundary cases: Sonderzeichen und minimale Länge werden ohne Fehler verarbeitet
    When der Nutzer gibt die Suchanfrage "<query>" in das Suchfeld ein
    Then verarbeitet das System die Eingabe ohne Fehler
    And es werden nur gültige Treffer angezeigt oder eine entsprechende Hinweis-Meldung

    Examples:
      | query |
      | @ |
      | #$% |
      | A |
      | Ä |

  @@regression @@boundary
  Scenario Outline: Teilstring-Suche ist unabhängig von Groß-/Kleinschreibung
    # Boundary: case-insensitive Suche liefert konsistente Ergebnisse
    When der Nutzer gibt die Suchanfrage "<query>" in das Suchfeld ein
    Then werden passende Chats und Kontakte in der Ergebnisliste angezeigt
    And die Ergebnisse sind identisch für Varianten mit unterschiedlicher Groß-/Kleinschreibung

    Examples:
      | query |
      | anna |
      | AnNa |
