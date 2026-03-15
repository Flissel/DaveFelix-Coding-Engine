@@smoke @@regression
Feature: Umfragen in Chats erstellen und teilen
  As a privater Nutzer
  I want to eine Umfrage in einem Gruppen- oder Einzelchat erstellen und teilen
  So that schnell und einfach Meinungen einholen, um Entscheidungen effizient zu treffen

  Background:
    Given der Nutzer ist angemeldet

  @@happy-path @@smoke
  Scenario: Umfrage im Gruppenchat erfolgreich senden
    # Happy Path: Eine Umfrage mit Titel und mindestens zwei Optionen wird im Gruppenchat angezeigt
    Given der Nutzer befindet sich in einem Gruppenchat
    When er erstellt eine Umfrage mit Titel und mindestens zwei Antwortoptionen und sendet sie
    Then die Umfrage wird im Gruppenchat angezeigt
    And alle Gruppenmitglieder koennen abstimmen

  @@happy-path @@regression
  Scenario: Umfrage im Einzelchat erfolgreich senden
    # Happy Path: Eine Umfrage wird im Einzelchat angezeigt und beide Teilnehmer koennen abstimmen
    Given der Nutzer befindet sich in einem Einzelchat
    When er erstellt eine Umfrage mit Titel und mindestens zwei Antwortoptionen und sendet sie
    Then die Umfrage wird im Einzelchat angezeigt
    And beide Teilnehmer koennen abstimmen

  @@negative @@regression
  Scenario: Umfrage ohne Antwortoptionen wird nicht gesendet
    # Error Scenario: Validierung verhindert das Senden ohne Antwortoptionen
    Given der Nutzer befindet sich in einem Gruppenchat
    When er erstellt eine Umfrage ohne Antwortoptionen und moechte sie senden
    Then die Umfrage wird nicht gesendet
    And eine Validierungsnachricht wird angezeigt

  @@negative @@regression
  Scenario: Umfrage in moderierter Gruppe ohne Berechtigung wird abgelehnt
    # Error Scenario: Berechtigungspruefung verhindert das Senden
    Given der Nutzer befindet sich in einer moderierten Gruppe ohne Post-Berechtigung
    When er moechte eine Umfrage senden
    Then die Aktion wird abgelehnt
    And eine Fehlermeldung wird angezeigt

  @@boundary @@regression
  Scenario Outline: Umfrage mit minimaler Optionenzahl in verschiedenen Chattypen
    # Boundary Condition: Genau zwei Antwortoptionen sind erlaubt
    Given der Nutzer befindet sich in einem <chat_typ>
    When er erstellt eine Umfrage mit Titel und genau zwei Antwortoptionen und sendet sie
    Then die Umfrage wird im <chat_typ> angezeigt
    And alle berechtigten Teilnehmer koennen abstimmen

    Examples:
      | chat_typ |
      | Gruppenchat |
      | Einzelchat |

  @@negative @@edge @@regression
  Scenario: Umfrage mit leerem Titel wird nicht gesendet
    # Edge Case: Titel ist erforderlich
    Given der Nutzer befindet sich in einem Gruppenchat
    When er erstellt eine Umfrage mit leerem Titel und mindestens zwei Antwortoptionen und moechte sie senden
    Then die Umfrage wird nicht gesendet
    And eine Validierungsnachricht fuer den Titel wird angezeigt

  @@boundary @@regression
  Scenario: Umfrage mit maximaler Optionenzahl wird angezeigt
    # Boundary Condition: Umfrage mit der maximal erlaubten Anzahl an Antwortoptionen
    Given der Nutzer befindet sich in einem Gruppenchat
    When er erstellt eine Umfrage mit Titel und der maximal erlaubten Anzahl an Antwortoptionen und sendet sie
    Then die Umfrage wird im Gruppenchat angezeigt
    And alle Gruppenmitglieder koennen abstimmen
