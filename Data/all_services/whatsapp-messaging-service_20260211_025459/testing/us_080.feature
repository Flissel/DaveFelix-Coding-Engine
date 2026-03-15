@@smoke @@regression
Feature: Zuletzt online Sichtbarkeit konfigurieren
  As a registrierter Nutzer
  I want to die Sichtbarkeit meines Online-Status konfigurieren
  So that meine Privatsphäre zu schützen und selbst zu steuern, wer meinen Status sehen kann

  Background:
    Given der Nutzer ist angemeldet und befindet sich in den Datenschutzeinstellungen

  @@smoke @@regression @@happy-path
  Scenario: Online-Status für andere Nutzer verbergen
    # Happy path: Sichtbarkeit auf Niemand setzen und speichern
    When der Nutzer setzt die Sichtbarkeit auf "Niemand" und speichert
    Then wird der Online-Status für andere Nutzer nicht angezeigt
    And die gespeicherte Einstellung ist "Niemand"

  @@regression @@happy-path
  Scenario: Online-Status für andere Nutzer anzeigen
    # Happy path: Sichtbarkeit auf Alle setzen und speichern
    When der Nutzer setzt die Sichtbarkeit auf "Alle" und speichert
    Then wird der Online-Status für andere Nutzer angezeigt
    And die gespeicherte Einstellung ist "Alle"

  @@regression @@edge
  Scenario: Sofortige Wirkung der Änderung während aktiver Sitzung
    # Edge case: Änderung tritt ohne Neustart sofort in Kraft
    Given ein anderer Nutzer betrachtet die Profilkarte des angemeldeten Nutzers
    When der Nutzer ändert die Sichtbarkeit auf "Niemand" und speichert
    Then wird der Online-Status für den anderen Nutzer sofort nicht mehr angezeigt
    And es ist kein Neustart der Sitzung erforderlich

  @@regression @@negative
  Scenario: Temporärer Serverfehler beim Speichern
    # Error scenario: Fehler anzeigen und Einstellung beibehalten
    Given die aktuelle Sichtbarkeit ist "Alle"
    When der Nutzer setzt die Sichtbarkeit auf "Niemand" und speichert
    And ein temporärer Serverfehler tritt beim Speichern auf
    Then wird eine Fehlermeldung angezeigt
    And die vorherige Einstellung "Alle" bleibt bestehen

  @@regression @@boundary
  Scenario Outline: Gültige Sichtbarkeitswerte speichern (Datengetrieben)
    # Boundary condition: nur erlaubte Werte werden akzeptiert
    When der Nutzer setzt die Sichtbarkeit auf "<visibility>" und speichert
    Then die Einstellung wird erfolgreich gespeichert
    And der Online-Status entspricht der Sichtbarkeit "<visibility>"

    Examples:
      | visibility |
      | Niemand |
      | Alle |
