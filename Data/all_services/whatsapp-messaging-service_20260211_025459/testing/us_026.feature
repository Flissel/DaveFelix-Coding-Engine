@@smoke @@regression
Feature: Gruppe erstellen
  As a registrierter Nutzer
  I want to einen neuen Gruppenchat erstellen
  So that um mit mehreren Kontakten effizient und sicher kommunizieren zu koennen

  Background:
    Given der Nutzer ist angemeldet und befindet sich in der Chat-Uebersicht

  @@smoke @@regression @@happy-path
  Scenario: Gruppe erfolgreich erstellen mit gueltigen Daten
    # Prueft die erfolgreiche Erstellung eines Gruppenchats mit gueltigem Namen und mindestens zwei Teilnehmern
    When der Nutzer gibt den Gruppennamen "Projekt Alpha" ein
    And der Nutzer waehlt die Teilnehmer "Anna" und "Ben" aus
    And der Nutzer klickt auf "Gruppe erstellen"
    Then wird der Gruppenchat erstellt
    And der Gruppenchat wird in der Chat-Liste angezeigt

  @@regression @@negative @@edge
  Scenario Outline: Validierung verhindert Erstellung bei ungueltigen Eingaben
    # Prueft die Validierungsnachricht bei fehlendem Namen oder zu wenigen Teilnehmern
    Given der Nutzer befindet sich im Erstellen-Dialog
    When der Nutzer gibt den Gruppennamen "<group_name>" ein
    And der Nutzer waehlt <participant_count> Teilnehmer aus
    And der Nutzer klickt auf "Gruppe erstellen"
    Then wird die Erstellung verhindert
    And eine verstaendliche Validierungsnachricht wird angezeigt

    Examples:
      | group_name | participant_count |
      |  | 2 |
      | Team Sync | 1 |
      |  | 1 |

  @@regression @@negative @@error
  Scenario: Fehler bei instabiler Netzwerkverbindung und erneuter Versuch
    # Prueft die Fehlermeldung und die erneute moegliche Erstellung ohne Datenverlust
    Given der Nutzer befindet sich im Erstellen-Dialog
    And die Netzwerkverbindung ist instabil
    When der Nutzer gibt den Gruppennamen "Projekt Beta" ein
    And der Nutzer waehlt die Teilnehmer "Clara" und "David" aus
    And der Nutzer klickt auf "Gruppe erstellen"
    Then wird ein Fehler angezeigt
    And der Nutzer kann die Erstellung erneut versuchen ohne dass Name oder Teilnehmer verloren gehen

  @@regression @@boundary
  Scenario Outline: Grenzwerte fuer Teilnehmeranzahl
    # Prueft die Erstellung mit minimaler und maximaler erlaubter Teilnehmeranzahl
    Given der Nutzer befindet sich im Erstellen-Dialog
    When der Nutzer gibt den Gruppennamen "<group_name>" ein
    And der Nutzer waehlt <participant_count> Teilnehmer aus
    And der Nutzer klickt auf "Gruppe erstellen"
    Then wird die Erstellung erfolgreich abgeschlossen
    And der Gruppenchat wird in der Chat-Liste angezeigt

    Examples:
      | group_name | participant_count |
      | Minimale Gruppe | 2 |
      | Maximale Gruppe | 50 |
