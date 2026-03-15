@smoke @regression
Feature: Lesebestaetigung konfigurieren
  As a primaerer Nutzer
  I want to Lesebestaetigungen fuer meine Nachrichten konfigurieren
  So that um den Zustell- und Lesestatus verlaesslich nachzuverfolgen und die Kommunikation zu verbessern

  Background:
    Given der primaere Nutzer ist angemeldet und befindet sich im Nachrichtenbereich

  @@smoke @@regression @@happy-path
  Scenario: Lesebestaetigung wird angezeigt wenn aktiviert
    # Happy path: Empfaenger liest eine Nachricht und die Lesebestaetigung erscheint
    Given Lesebestaetigungen sind in den Einstellungen aktiviert
    And der Nutzer hat eine Nachricht an einen Empfaenger gesendet
    When der Empfaenger die Nachricht liest
    Then wird dem Nutzer eine Lesebestaetigung angezeigt
    And die Lesebestaetigung enthaelt Datum und Uhrzeit des Lesens

  @@regression @@edge
  Scenario: Keine Lesebestaetigung bei deaktivierter Einstellung
    # Edge case: Einstellung deaktiviert, Empfaenger liest trotzdem
    Given Lesebestaetigungen sind in den Einstellungen deaktiviert
    And der Nutzer hat eine Nachricht an einen Empfaenger gesendet
    When der Empfaenger die Nachricht liest
    Then wird keine Lesebestaetigung angezeigt
    And der Zustellstatus bleibt unveraendert

  @@regression @@boundary
  Scenario: Neue Einstellung gilt nur fuer zukuenftige Nachrichten
    # Boundary condition: Wechsel der Einstellung wirkt nur auf neue Nachrichten
    Given Lesebestaetigungen sind deaktiviert und es existiert eine bereits gesendete Nachricht
    When der Nutzer Lesebestaetigungen aktiviert und die Einstellung speichert
    Then gilt die neue Einstellung fuer alle zukuenftigen Nachrichten
    And bereits gesendete Nachrichten erhalten keine nachtraegliche Lesebestaetigung

  @@regression @@negative
  Scenario: Fehler beim Speichern der Einstellung
    # Error scenario: Speichern der Konfiguration schlaegt fehl
    Given der Nutzer oeffnet die Einstellungen fuer Lesebestaetigungen
    When der Nutzer die Einstellung aendert und der Speichervorgang fehlschlaegt
    Then wird eine Fehlermeldung angezeigt
    And die vorherige Einstellung bleibt unveraendert aktiv

  @@regression @@data-driven
  Scenario Outline: Lesebestaetigung Konfigurationen fuer mehrere Zustaende
    # Scenario outline: Datengetriebene Pruefung fuer Aktiv/Deaktiv
    Given Lesebestaetigungen sind in den Einstellungen <status>
    And der Nutzer sendet eine Nachricht
    When der Empfaenger die Nachricht liest
    Then ist eine Lesebestaetigung <expected_receipt>

    Examples:
      | status | expected_receipt |
      | aktiviert | sichtbar |
      | deaktiviert | nicht sichtbar |
