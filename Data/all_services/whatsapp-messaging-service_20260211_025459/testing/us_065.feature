@@smoke @@regression
Feature: Push-Benachrichtigungen
  As a registrierter Nutzer
  I want to Push-Benachrichtigungen auf meinem Geraet empfangen
  So that damit ich wichtige Nachrichten schnell und zuverlaessig erhalte, unabhaengig von der Plattform

  Background:
    Given der Nutzer ist registriert und besitzt ein Geraet mit aktivierter Push-Registrierung

  @@smoke @@happy-path @@regression
  Scenario: Push wird online innerhalb der Zielzeit zugestellt
    # Happy path: Zustellung bei online Geraet und aktivierten Push
    Given Push-Benachrichtigungen sind fuer den Nutzer aktiviert
    And das Geraet ist online
    When das System eine neue Nachricht sendet
    Then die Push-Benachrichtigung wird innerhalb von 5 Sekunden zugestellt
    And die Benachrichtigung wird auf dem Geraet angezeigt

  @@regression @@edge
  Scenario: Push wird nach Offline-Phase automatisch zugestellt
    # Edge case: Geraet ist voruebergehend offline und erhaelt die Benachrichtigung nach Wiederverbindung
    Given Push-Benachrichtigungen sind fuer den Nutzer aktiviert
    And das Geraet ist offline
    When das System eine neue Nachricht sendet
    And das Geraet wieder online geht
    Then die Benachrichtigung wird automatisch zugestellt

  @@negative @@regression
  Scenario: Push wird nicht zugestellt wenn deaktiviert
    # Error scenario: Deaktivierte Push-Benachrichtigungen verhindern Zustellung und werden protokolliert
    Given Push-Benachrichtigungen sind fuer den Nutzer deaktiviert
    When das System eine neue Nachricht sendet
    Then es wird keine Push-Benachrichtigung zugestellt
    And der Versand wird im System protokolliert

  @@regression @@boundary
  Scenario Outline: Zustellungszeit liegt an der Grenze von 5 Sekunden
    # Boundary condition: Zustellung genau an der Zeitgrenze
    Given Push-Benachrichtigungen sind fuer den Nutzer aktiviert
    And das Geraet ist online
    When das System eine neue Nachricht sendet
    Then die Push-Benachrichtigung wird in <zustellzeit> Sekunden zugestellt
    And die Benachrichtigung wird angezeigt

    Examples:
      | zustellzeit |
      | 5 |
      | 4.9 |
