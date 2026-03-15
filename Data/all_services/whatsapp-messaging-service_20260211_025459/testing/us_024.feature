@smoke @regression
Feature: Standort teilen
  As a Endnutzer
  I want to einen Standort in einer Nachricht teilen
  So that damit Empfänger meinen Standort schnell finden können und die Kommunikation effizient bleibt

  Background:
    Given der Nutzer ist in einem aktiven Chat

  @@smoke @@regression @@happy-path
  Scenario: Standort mit erteilter Berechtigung erfolgreich teilen
    # Happy path: Standort wird als Kartenansicht mit Koordinaten gesendet
    Given die Standortfreigabe ist erteilt
    When der Nutzer wählt die Funktion „Standort teilen“ und sendet
    Then wird der aktuelle Standort als Kartenansicht in der Nachricht angezeigt
    And werden die Koordinaten in der Nachricht angezeigt und zugestellt

  @@regression @@negative
  Scenario: Standort teilen ohne Berechtigung
    # Error scenario: System fordert Berechtigung an und sendet keinen Standort
    Given die Standortfreigabe ist nicht erteilt
    When der Nutzer versucht die Funktion „Standort teilen“ zu senden
    Then fordert das System zur Erteilung der Berechtigung auf
    And wird kein Standort gesendet

  @@regression @@negative
  Scenario: Standortdienste nicht verfügbar
    # Error scenario: verständliche Fehlermeldung und Angebot zur manuellen Auswahl
    Given die Standortfreigabe ist erteilt
    And die Standortdienste sind nicht verfügbar
    When der Nutzer wählt die Funktion „Standort teilen“
    Then zeigt das System eine verständliche Fehlermeldung an
    And bietet das System an, den Standort manuell auszuwählen

  @@regression @@edge
  Scenario: Manuelle Standortauswahl nach Fehler
    # Edge case: Nutzer wählt nach Ausfall der Dienste einen manuellen Standort
    Given die Standortdienste sind nicht verfügbar
    When der Nutzer wählt einen Standort manuell aus und sendet
    Then wird der manuell ausgewählte Standort als Kartenansicht gesendet
    And werden die Koordinaten des manuellen Standorts angezeigt

  @@regression @@boundary
  Scenario Outline: Koordinatenformat und Grenzwerte
    # Boundary conditions: gültige Koordinaten werden korrekt angezeigt
    Given die Standortfreigabe ist erteilt
    When der Nutzer teilt den Standort mit Koordinaten <latitude>, <longitude>
    Then zeigt die Nachricht die Koordinaten im erwarteten Format an
    And wird die Kartenansicht für die Koordinaten gerendert

    Examples:
      | latitude | longitude |
      | -90.0000 | 180.0000 |
      | 90.0000 | -180.0000 |
      | 0.0000 | 0.0000 |

  @@regression @@edge
  Scenario: Verzögerte Standortermittlung
    # Edge case: Standortermittlung dauert länger, aber sendet nach Ermittlung
    Given die Standortfreigabe ist erteilt
    And die Standortermittlung benötigt länger als üblich
    When der Nutzer wählt die Funktion „Standort teilen“
    Then zeigt das System einen Ladezustand an
    And sendet das System den Standort, sobald die Koordinaten verfügbar sind

  @@regression @@negative
  Scenario Outline: Ungültige Koordinaten werden nicht gesendet
    # Error scenario: Standortdaten sind ungültig
    Given die Standortfreigabe ist erteilt
    When das System erhält ungültige Koordinaten <latitude>, <longitude>
    Then zeigt das System eine Fehlermeldung zur Standortermittlung an
    And wird kein Standort gesendet

    Examples:
      | latitude | longitude |
      | 91.0000 | 0.0000 |
      | 0.0000 | 181.0000 |
