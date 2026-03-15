@@smoke @@regression
Feature: Reaktionsbenachrichtigungen
  As a Endnutzer
  I want to Benachrichtigungen zu Reaktionen auf meine eigenen Nachrichten erhalten
  So that um schnell informiert zu sein und zeitnah reagieren zu können

  Background:
    Given ein Endnutzer ist im System angemeldet
    And der Endnutzer hat eine Nachricht in einem Chat gesendet

  @@happy-path @@smoke @@regression
  Scenario: Sofortige Benachrichtigung bei einzelner Reaktion
    # Happy path: eine Reaktion wird registriert und löst sofort eine Benachrichtigung aus
    Given ein anderer Nutzer reagiert auf die Nachricht mit einer gültigen Reaktion
    When die Reaktion im System registriert wird
    Then erhält der Endnutzer umgehend eine Benachrichtigung mit Hinweis auf die Reaktion
    And die Benachrichtigung enthält die Nachrichtenzuordnung und den Reaktionstyp

  @@edge @@regression
  Scenario Outline: Mehrere Reaktionen in kurzer Zeit werden einzeln oder zusammengefasst
    # Edge case: Reaktionen folgen schnell und werden gemäß Einstellung einzeln oder gebündelt benachrichtigt
    Given der Endnutzer hat die Benachrichtigungseinstellung "<notification_setting>"
    And mehrere Nutzer reagieren innerhalb von <time_window> Sekunden auf dieselbe Nachricht
    When die Benachrichtigungen ausgelöst werden
    Then erhält der Endnutzer <expected_notification_behavior>

    Examples:
      | notification_setting | time_window | expected_notification_behavior |
      | einzeln | 10 | für jede Reaktion eine separate Benachrichtigung |
      | zusammengefasst | 10 | eine zusammengefasste Benachrichtigung mit Anzahl und Reaktionstypen |

  @@edge @@regression
  Scenario: Entfernte Reaktion erzeugt keine zusätzliche Benachrichtigung
    # Edge case: Reaktion wird entfernt und es erfolgt keine neue Benachrichtigung oder klare Aktualisierung
    Given ein anderer Nutzer setzt eine Reaktion auf die Nachricht
    And die Reaktion wurde bereits benachrichtigt
    When die Reaktion wieder entfernt wird
    Then erhält der Endnutzer keine neue Benachrichtigung
    And falls eine Aktualisierung gesendet wird, ist sie klar als Entfernung der Reaktion erkennbar

  @@negative @@regression
  Scenario: Benachrichtigung wird nach Ausfall des Dienstes nachgeliefert
    # Error scenario: Benachrichtigungsdienst ist temporär nicht verfügbar
    Given der Benachrichtigungsdienst ist vorübergehend nicht verfügbar
    And ein anderer Nutzer reagiert auf die Nachricht
    When der Benachrichtigungsdienst wiederhergestellt wird
    Then wird die Benachrichtigung zuverlässig nachgeliefert
    And die Benachrichtigung wird genau einmal zugestellt

  @@boundary @@regression
  Scenario Outline: Grenzfall für Zeitfenster der Zusammenfassung
    # Boundary condition: Reaktionen am Rand des Zusammenfassungsfensters
    Given der Endnutzer hat die Benachrichtigungseinstellung "zusammengefasst"
    And die Zusammenfassungsgrenze beträgt <boundary_seconds> Sekunden
    When zwei Reaktionen erfolgen mit einem Abstand von <gap_seconds> Sekunden
    Then erhält der Endnutzer <expected_notification_behavior>

    Examples:
      | boundary_seconds | gap_seconds | expected_notification_behavior |
      | 10 | 10 | eine zusammengefasste Benachrichtigung |
      | 10 | 11 | zwei separate Benachrichtigungen |
