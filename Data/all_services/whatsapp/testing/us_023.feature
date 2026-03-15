@smoke @regression
Feature: Erwaehnung im Gruppenchat
  As a Gruppenchat-Nutzer
  I want to einen anderen Teilnehmer mit @mention im Gruppenchat markieren
  So that damit die angesprochene Person gezielt benachrichtigt wird und schneller reagieren kann

  Background:
    Given ein aktiver Gruppenchat mit mehreren Teilnehmern ist vorhanden

  @@smoke @@regression @@happy-path
  Scenario: Erfolgreiche @mention eines vorhandenen Teilnehmers
    # Stellt sicher, dass eine gültige Erwähnung hervorgehoben wird und eine Benachrichtigung auslöst
    Given der Teilnehmer "Anna" ist Mitglied im Gruppenchat
    When der Nutzer die Nachricht "@Anna Bitte schau dir das an" sendet
    Then die Erwähnung von "Anna" wird im Chat hervorgehoben
    And "Anna" erhält eine Benachrichtigung

  @@regression @@negative @@error
  Scenario: Ungültige @mention eines nicht vorhandenen Teilnehmers
    # Stellt sicher, dass eine Erwähnung für einen nicht existierenden Namen nicht hervorgehoben wird
    When der Nutzer die Nachricht "@Unbekannt Bitte prüfen" sendet
    Then es wird keine Erwähnung im Chat hervorgehoben
    And es wird keine Benachrichtigung ausgelöst

  @@regression @@negative @@edge
  Scenario: Nachricht mit @ ohne Auswahl
    # Stellt sicher, dass ohne Auswahl keine Erwähnung verarbeitet wird
    When der Nutzer die Nachricht "@ Bitte hilf" sendet
    Then die Nachricht wird ohne Erwähnung verarbeitet
    And es wird keine Benachrichtigung ausgelöst

  @@regression @@happy-path
  Scenario: Mehrere gültige @mentions in einer Nachricht
    # Prüft, dass mehrere Teilnehmer korrekt hervorgehoben und benachrichtigt werden
    Given die Teilnehmer "Anna" und "Ben" sind Mitglieder im Gruppenchat
    When der Nutzer die Nachricht "@Anna @Ben Bitte abstimmen" sendet
    Then die Erwähnungen von "Anna" und "Ben" werden im Chat hervorgehoben
    And "Anna" und "Ben" erhalten jeweils eine Benachrichtigung

  @@regression @@edge
  Scenario Outline: Scenario Outline: Grenzfälle für @mention-Namen
    # Validiert Randbedingungen für Namen mit minimaler und maximaler Länge sowie Sonderzeichen
    Given ein Teilnehmer mit dem Namen <name> ist Mitglied im Gruppenchat
    When der Nutzer die Nachricht "@<name> Hallo" sendet
    Then die Erwähnung von <name> wird im Chat hervorgehoben
    And der Teilnehmer <name> erhält eine Benachrichtigung

    Examples:
      | name |
      | A |
      | MaximilianAlexanderTheodor |
      | Anna-Maria |

  @@regression @@negative @@error
  Scenario Outline: Scenario Outline: Fehlerfälle mit nicht existierenden Namen
    # Stellt sicher, dass nicht existierende Namen keine Erwähnung erzeugen
    When der Nutzer die Nachricht "@<name> Bitte prüfen" sendet
    Then es wird keine Erwähnung im Chat hervorgehoben
    And es wird keine Benachrichtigung ausgelöst

    Examples:
      | name |
      | Unbekannt |
      | NichtDabei |
      | Annaa |
