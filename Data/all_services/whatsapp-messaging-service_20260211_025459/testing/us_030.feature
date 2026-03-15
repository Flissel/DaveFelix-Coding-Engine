@@smoke @@regression
Feature: US-030 Gruppe verlassen
  As a Gruppenmitglied
  I want to eine Gruppe verlassen, ohne dass andere Mitglieder benachrichtigt werden
  So that Datenschutz zu wahren und die Bedienung einfach und schnell zu halten

  Background:
    Given das Gruppenmitglied ist in der App angemeldet

  @@smoke @@regression @@happy-path
  Scenario: Mitglied verlässt Gruppe erfolgreich ohne Benachrichtigung
    # Happy path: Mitglied wird entfernt und es werden keine Benachrichtigungen gesendet
    Given das Gruppenmitglied ist aktives Mitglied der Gruppe "G1"
    When es führt die Funktion "Gruppe verlassen" für "G1" aus
    Then ist das Mitglied aus der Gruppe "G1" entfernt
    And es werden keine Benachrichtigungen an andere Gruppenmitglieder gesendet

  @@regression @@negative
  Scenario: Gruppe verlassen ohne Netzwerkverbindung
    # Error scenario: keine Verbindung führt zu Fehlermeldung und keiner Änderung
    Given das Gruppenmitglied ist aktives Mitglied der Gruppe "G1"
    And das Gerät hat keine Netzwerkverbindung
    When es versucht die Funktion "Gruppe verlassen" für "G1" auszuführen
    Then erhält das Mitglied eine Fehlermeldung zur fehlenden Verbindung
    And bleibt das Mitglied Teil der Gruppe "G1"

  @@regression @@negative @@edge
  Scenario: Erneutes Verlassen einer bereits verlassenen Gruppe
    # Edge case: Mitglied ist nicht mehr Teil der Gruppe und erhält Hinweis
    Given das Gruppenmitglied ist kein Mitglied der Gruppe "G1"
    When es versucht die Funktion "Gruppe verlassen" für "G1" auszuführen
    Then erhält das Mitglied die Information, dass es nicht mehr Teil der Gruppe ist
    And es werden keine Änderungen am Gruppenstatus vorgenommen

  @@regression @@boundary
  Scenario Outline: Gruppe verlassen mit mehreren Gruppen (Auswahl per Szenario-Outline)
    # Boundary condition: Mitglied verlässt eine von mehreren Gruppen ohne Benachrichtigung
    Given das Gruppenmitglied ist aktives Mitglied der Gruppe "<group_id>"
    And das Gruppenmitglied ist zusätzlich Mitglied in weiteren Gruppen
    When es führt die Funktion "Gruppe verlassen" für "<group_id>" aus
    Then ist das Mitglied aus der Gruppe "<group_id>" entfernt
    And es werden keine Benachrichtigungen an andere Gruppenmitglieder gesendet

    Examples:
      | group_id |
      | G1 |
      | G2 |
