@@smoke @@regression
Feature: US-088 Dark Mode
  As a Endnutzer
  I want to den Dark Mode in den Einstellungen aktivieren und deaktivieren
  So that eine angenehmere und augenschonende Bedienung bei unterschiedlichen Lichtverhaeltnissen zu haben

  Background:
    Given der Endnutzer ist in der Anwendung angemeldet und befindet sich in den Einstellungen

  @@happy-path @@smoke @@regression
  Scenario: Dark Mode aktivieren wechselt sofort zu dunklem Farbschema
    # Happy path: Aktivierung des Dark Mode aus den Einstellungen
    When der Endnutzer aktiviert den Dark Mode
    Then die Benutzeroberflaeche wechselt sofort in ein dunkles Farbschema
    And die Einstellung fuer Dark Mode ist als aktiv markiert

  @@happy-path @@regression
  Scenario: Dark Mode deaktivieren wechselt sofort zu hellem Farbschema
    # Happy path: Deaktivierung des Dark Mode aus den Einstellungen
    Given der Endnutzer hat den Dark Mode aktiviert
    When der Endnutzer deaktiviert den Dark Mode
    Then die Benutzeroberflaeche wechselt sofort in das helle Farbschema
    And die Einstellung fuer Dark Mode ist als inaktiv markiert

  @@happy-path @@regression
  Scenario: Dark Mode bleibt nach App-Neustart aktiv
    # Happy path: Persistenz der Einstellung nach Neustart
    Given der Endnutzer hat den Dark Mode aktiviert
    When die Anwendung neu gestartet wird und die Startansicht geladen ist
    Then der Dark Mode ist weiterhin aktiv
    And die Startansicht wird korrekt im dunklen Farbschema angezeigt

  @@edge @@regression
  Scenario: Mehrfaches schnelles Umschalten endet im zuletzt gewaehlt Zustand
    # Edge case: wiederholtes Umschalten des Dark Mode
    When der Endnutzer den Dark Mode schnell mehrfach ein- und ausschaltet
    Then die Benutzeroberflaeche zeigt das Farbschema des zuletzt ausgewaehlten Zustands
    And die Einstellung fuer Dark Mode entspricht dem zuletzt ausgewaehlten Zustand

  @@boundary @@regression
  Scenario Outline: Umschalten mit gespeicherten Vorzugswerten
    # Boundary condition: Initialzustand und Zustandswechsel aus einem definierten Startwert
    Given die gespeicherte Voreinstellung fuer Dark Mode ist <initial_state>
    When der Endnutzer den Dark Mode auf <target_state> setzt
    Then die Benutzeroberflaeche wechselt sofort in das <expected_theme> Farbschema
    And die Einstellung fuer Dark Mode ist als <target_state> markiert

    Examples:
      | initial_state | target_state | expected_theme |
      | aktiv | inaktiv | helle |
      | inaktiv | aktiv | dunkle |

  @@negative @@regression
  Scenario: Fehler beim Speichern der Dark-Mode-Einstellung
    # Error scenario: Persistierung der Einstellung schlaegt fehl
    When der Endnutzer den Dark Mode aktiviert und das Speichern der Einstellung fehlschlaegt
    Then die Anwendung zeigt eine Fehlermeldung zur Speicherung an
    And die Benutzeroberflaeche bleibt im vorherigen Farbschema
