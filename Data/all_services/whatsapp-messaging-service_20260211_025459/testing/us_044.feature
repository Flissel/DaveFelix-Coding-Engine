@smoke @regression
Feature: Status-Antwort
  As a Endnutzer
  I want to auf Status-Nachrichten mit einer Antwort reagieren
  So that um schnell und intuitiv Kommunikation fortzusetzen und eine zuverlaessige Zustellung sicherzustellen

  Background:
    Given der Endnutzer ist im Chat angemeldet und sieht eine Konversation mit Status-Nachrichten

  @@smoke @@regression @@happy-path
  Scenario: Erfolgreiche Status-Antwort wird verknuepft und zugestellt
    # Prueft, dass eine Antwort auf eine sichtbare Status-Nachricht als verknuepfte Antwort gesendet und zugestellt wird
    Given eine empfangene Status-Nachricht ist im Chat sichtbar und verfuegbar
    When der Endnutzer antwortet mit dem Text "Alles klar"
    Then die Antwort wird als verknuepfte Antwort zur Status-Nachricht gesendet
    And die Antwort wird dem Absender zugestellt und als gesendet markiert

  @@regression @@negative @@edge
  Scenario Outline: Antwortoption fuer abgelaufene oder nicht verfuegbare Status-Nachrichten
    # Prueft, dass Antworten auf abgelaufene oder nicht verfuegbare Status-Nachrichten blockiert werden
    Given eine Status-Nachricht hat den Status <status_verfuegbarkeit>
    When der Endnutzer versucht, darauf zu antworten
    Then die Antwortoption ist deaktiviert oder es wird eine klare Hinweisnachricht angezeigt
    And es wird keine Antwort gesendet

    Examples:
      | status_verfuegbarkeit |
      | abgelaufen |
      | nicht mehr verfuegbar |

  @@regression @@negative @@error
  Scenario Outline: Fehlermeldung bei instabiler oder unterbrochener Netzwerkverbindung
    # Prueft Fehlerverhalten, wenn die Netzwerkverbindung instabil oder unterbrochen ist
    Given die Netzwerkverbindung ist <netzwerkzustand>
    And eine empfangene Status-Nachricht ist im Chat sichtbar und verfuegbar
    When der Endnutzer sendet eine Status-Antwort
    Then der Endnutzer erhaelt eine Fehlermeldung
    And die Antwort wird nicht als gesendet markiert

    Examples:
      | netzwerkzustand |
      | instabil |
      | unterbrochen |

  @@regression @@boundary
  Scenario Outline: Antwort auf Status-Nachricht am Verfallszeitpunkt
    # Prueft das Grenzverhalten rund um den Verfallszeitpunkt der Status-Nachricht
    Given die Status-Nachricht hat den Zustand <zeitpunkt>
    When der Endnutzer versucht, darauf zu antworten
    Then das System behandelt die Antwort gemaess dem Zustand
    And keine inkonsistente Zustellung wird angezeigt

    Examples:
      | zeitpunkt |
      | gerade noch verfuegbar |
      | soeben abgelaufen |
