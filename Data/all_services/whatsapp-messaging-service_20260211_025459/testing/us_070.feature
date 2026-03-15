@smoke @regression
Feature: Anrufbenachrichtigungen konfigurieren
  As a Endnutzer
  I want to separate Einstellungen für Anrufbenachrichtigungen konfigurieren
  So that damit ich Anrufe zuverlässig und datenschutzkonform erhalte, ohne andere Benachrichtigungen zu beeinflussen

  Background:
    Given der Benutzer ist angemeldet und befindet sich in den Benachrichtigungseinstellungen

  @@smoke @@regression @@happy-path
  Scenario: Aktivieren von Anrufbenachrichtigungen und Speichern
    # Happy path: Benutzer aktiviert Anrufbenachrichtigungen und die Einstellung wird gespeichert
    Given Anrufbenachrichtigungen sind deaktiviert
    When der Benutzer aktiviert Anrufbenachrichtigungen und speichert
    Then Anrufbenachrichtigungen sind aktiviert
    And die Einstellung ist persistent gespeichert

  @@regression @@edge
  Scenario: Eingehender Anruf bei deaktivierten Anrufbenachrichtigungen
    # Edge case: Eingehender Anruf erzeugt keine Benachrichtigung, andere Benachrichtigungen bleiben unverändert
    Given Anrufbenachrichtigungen sind deaktiviert
    And andere Benachrichtigungstypen sind aktiviert
    When ein eingehender Anruf erfolgt
    Then der Benutzer erhält keine Anrufbenachrichtigung
    And andere Benachrichtigungseinstellungen bleiben unverändert

  @@regression @@negative @@error
  Scenario: Fehlermeldung bei Netzwerkunterbrechung während Speichern
    # Error scenario: Änderung kann nicht gespeichert werden und alte Einstellung bleibt erhalten
    Given eine vorübergehende Netzwerkunterbrechung liegt vor
    And Anrufbenachrichtigungen sind aktiviert
    When der Benutzer deaktiviert Anrufbenachrichtigungen und speichert
    Then eine Fehlermeldung wird angezeigt
    And die bisherige Einstellung bleibt erhalten

  @@regression @@boundary
  Scenario: Mehrfaches schnelles Umschalten vor dem Speichern
    # Boundary condition: Nur der zuletzt gewählte Zustand wird gespeichert
    Given Anrufbenachrichtigungen sind deaktiviert
    When der Benutzer schaltet Anrufbenachrichtigungen mehrfach um und speichert den letzten Zustand
    Then nur der zuletzt gewählte Zustand ist gespeichert
    And der gespeicherte Zustand bleibt nach dem Neuladen der Seite erhalten

  @@regression @@happy-path
  Scenario Outline: Anrufbenachrichtigungen speichern mit Datenvarianten
    # Data-driven happy path: Verschiedene Zielzustände werden korrekt gespeichert
    Given Anrufbenachrichtigungen sind aktuell auf <initial_state> gesetzt
    When der Benutzer setzt Anrufbenachrichtigungen auf <target_state> und speichert
    Then Anrufbenachrichtigungen sind auf <target_state> gesetzt
    And die Einstellung ist persistent gespeichert

    Examples:
      | initial_state | target_state |
      | deaktiviert | aktiviert |
      | aktiviert | deaktiviert |

  @@regression @@negative @@error
  Scenario Outline: Fehlermeldungen je nach Netzwerkzustand
    # Data-driven error scenario: unterschiedliche Netzwerkprobleme verhindern Speichern
    Given der Netzwerkzustand ist <network_state>
    And Anrufbenachrichtigungen sind deaktiviert
    When der Benutzer aktiviert Anrufbenachrichtigungen und speichert
    Then eine Fehlermeldung wird angezeigt
    And die bisherige Einstellung bleibt erhalten

    Examples:
      | network_state |
      | temporär offline |
      | hohe Paketverluste |
