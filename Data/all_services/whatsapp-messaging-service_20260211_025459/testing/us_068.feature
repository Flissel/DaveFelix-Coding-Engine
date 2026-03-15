@smoke @regression
Feature: Nicht stoeren Modus
  As a Endnutzer
  I want to den Nicht-Stoeren-Modus aktivieren und deaktivieren
  So that um in bestimmten Zeiten ungestoert zu bleiben, ohne die Kontrolle ueber eingehende Nachrichten zu verlieren

  Background:
    Given der Nutzer ist in der Anwendung angemeldet
    And der Nutzer befindet sich in den Einstellungen

  @smoke @happy-path
  Scenario: Nicht-Stoeren-Modus aktivieren und Benachrichtigungen unterdruecken
    # Happy path: Aktivierung unterdrueckt Benachrichtigungen und zeigt Status sofort an
    Given der Nicht-Stoeren-Modus ist deaktiviert
    When der Nutzer aktiviert den Nicht-Stoeren-Modus
    Then Benachrichtigungen werden unterdrueckt
    And der Modus-Status wird sofort als aktiviert angezeigt

  @regression @boundary
  Scenario: Nicht-Stoeren-Modus endet zur festgelegten Endzeit
    # Boundary: Modus deaktiviert sich automatisch an der Endzeit
    Given der Nicht-Stoeren-Modus ist aktiv und eine Endzeit ist gesetzt
    When die Systemzeit erreicht die festgelegte Endzeit
    Then Benachrichtigungen werden wieder normal zugestellt
    And der Modus-Status wird als deaktiviert angezeigt

  @regression @happy-path
  Scenario: Nicht-Stoeren-Modus manuell deaktivieren
    # Happy path: Manuelle Deaktivierung stellt Benachrichtigungen wieder her
    Given der Nicht-Stoeren-Modus ist aktiv
    When der Nutzer deaktiviert den Nicht-Stoeren-Modus manuell
    Then Benachrichtigungen werden wieder normal zugestellt
    And der Modus-Status wird als deaktiviert angezeigt

  @regression @negative
  Scenario: Fehler beim Speichern der Aktivierung
    # Error scenario: Speichern scheitert, Modus bleibt unveraendert
    Given der Nicht-Stoeren-Modus ist deaktiviert
    When der Nutzer aktiviert den Nicht-Stoeren-Modus und das Speichern schlaegt fehl
    Then der Nutzer erhaelt eine Fehlermeldung
    And der Modus bleibt deaktiviert

  @regression @edge-case
  Scenario Outline: Nicht-Stoeren-Modus Aktivierung mit verschiedenen Endzeiten
    # Scenario Outline: Aktivierung mit unterschiedlichen Endzeiten prueft Statusanzeige
    Given der Nicht-Stoeren-Modus ist deaktiviert
    When der Nutzer aktiviert den Nicht-Stoeren-Modus mit Endzeit "<endzeit>"
    Then der Modus-Status wird sofort als aktiviert angezeigt
    And die Endzeit wird korrekt gespeichert und angezeigt

    Examples:
      | endzeit |
      | in 5 Minuten |
      | in 24 Stunden |
      | am Tagesende um 23:59 |
