@@smoke @@regression
Feature: Anruf ablehnen mit Nachricht
  As a eingehender Anrufempfänger
  I want to einen eingehenden Anruf mit einer Schnellantwort ablehnen
  So that damit der Anrufer sofort informiert wird und der Gesprächsverlauf effizient bleibt

  Background:
    Given ein eingehender Anruf wird angezeigt

  @@smoke @@regression @@happy-path
  Scenario: Anruf mit konfigurierter Schnellantwort ablehnen
    # Happy path: Anruf ablehnen und ausgewählte Nachricht senden
    Given Schnellantworten sind konfiguriert
    When der Nutzer eine Schnellantwort auswählt und den Anruf ablehnt
    Then der Anruf wird abgelehnt
    And die ausgewählte Nachricht wird an den Anrufer gesendet

  @@regression @@edge-case
  Scenario: Anruf ablehnen ohne Schnellantwort
    # Edge case: Ablehnung ohne Nachricht
    When der Nutzer den Anruf ablehnt ohne eine Schnellantwort auszuwählen
    Then der Anruf wird abgelehnt
    And es wird keine Nachricht gesendet

  @@regression @@negative
  Scenario: Nachrichtendienst nicht verfügbar beim Ablehnen mit Schnellantwort
    # Error scenario: Nachricht kann nicht gesendet werden
    Given der Nachrichtendienst ist vorübergehend nicht verfügbar
    And Schnellantworten sind konfiguriert
    When der Nutzer eine Schnellantwort auswählt und den Anruf ablehnt
    Then der Anruf wird abgelehnt
    And das System informiert den Nutzer, dass die Nachricht nicht gesendet werden konnte

  @@regression
  Scenario Outline: Schnellantwort-Auswahl mit verschiedenen Nachrichten
    # Boundary condition: unterschiedliche Schnellantwort-Optionen senden
    Given Schnellantworten sind konfiguriert
    When der Nutzer die Schnellantwort "<reply>" auswählt und den Anruf ablehnt
    Then der Anruf wird abgelehnt
    And die Nachricht "<reply>" wird an den Anrufer gesendet

    Examples:
      | reply |
      | Ich rufe später zurück |
      | Bin in einem Meeting |
      | Bitte sende eine Nachricht |
