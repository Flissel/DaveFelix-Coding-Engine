@@smoke @@regression
Feature: Chatverlauf uebertragen
  As a Registrierter Nutzer
  I want to den Chatverlauf auf ein neues Gerät übertragen
  So that damit Unterhaltungen nahtlos und sicher fortgeführt werden können

  Background:
    Given der Nutzer besitzt ein aktives Konto und die App ist auf beiden Geräten installiert

  @@smoke @@regression @@happy-path
  Scenario: Erfolgreiche Übertragung des vollständigen Chatverlaufs
    # Happy path: Chatverlauf wird vollständig übertragen und kann fortgesetzt werden
    Given der Nutzer ist auf dem alten und neuen Gerät mit demselben Konto angemeldet
    And beide Geräte sind online
    When der Nutzer die Übertragung des Chatverlaufs startet
    Then wird der vollständige Chatverlauf auf dem neuen Gerät angezeigt
    And der Nutzer kann eine neue Nachricht senden und die Konversation wird fortgesetzt

  @@regression @@edge
  Scenario: Übertragung bei sehr großem Chatverlauf
    # Edge case: großer Datenumfang wird vollständig übertragen
    Given der Nutzer ist auf dem alten und neuen Gerät mit demselben Konto angemeldet
    And beide Geräte sind online
    And der Chatverlauf umfasst sehr viele Nachrichten und Anhänge
    When der Nutzer die Übertragung des Chatverlaufs startet
    Then wird der vollständige Chatverlauf ohne Datenverlust auf dem neuen Gerät angezeigt

  @@regression @@negative @@error
  Scenario: Fehlende stabile Internetverbindung auf neuem Gerät
    # Error scenario: Übertragung schlägt wegen instabiler Verbindung fehl
    Given der Nutzer ist auf dem neuen Gerät angemeldet
    And die Internetverbindung auf dem neuen Gerät ist instabil
    When der Nutzer die Übertragung startet
    Then zeigt das System eine Fehlermeldung mit dem Hinweis auf die fehlende Verbindung
    And das System bietet einen erneuten Versuch an

  @@regression @@negative @@error
  Scenario: Übertragung auf Gerät mit anderem Konto
    # Error scenario: Konteninkongruenz verhindert Übertragung
    Given der Nutzer ist auf dem alten Gerät mit Konto A und auf dem neuen Gerät mit Konto B angemeldet
    When der Nutzer die Übertragung initiiert
    Then verweigert das System die Übertragung
    And der Nutzer wird über die Konteninkongruenz informiert

  @@regression @@boundary
  Scenario: Übertragung mit minimalem Chatverlauf
    # Boundary condition: kleinster Datenumfang wird korrekt übertragen
    Given der Nutzer ist auf dem alten und neuen Gerät mit demselben Konto angemeldet
    And beide Geräte sind online
    And der Chatverlauf besteht aus genau einer Nachricht
    When der Nutzer die Übertragung des Chatverlaufs startet
    Then wird die einzelne Nachricht auf dem neuen Gerät angezeigt

  @@regression @@edge
  Scenario Outline: Datengetriebene Übertragung mit variablen Verbindungszuständen
    # Scenario Outline: Verhaltensprüfung bei unterschiedlichen Online-Status
    Given der Nutzer ist auf dem alten und neuen Gerät mit demselben Konto angemeldet
    And das alte Gerät ist <old_device_status> und das neue Gerät ist <new_device_status>
    When der Nutzer die Übertragung des Chatverlaufs startet
    Then ist das Ergebnis <expected_result>

    Examples:
      | old_device_status | new_device_status | expected_result |
      | online | online | erfolgreich und der Chatverlauf ist vollständig sichtbar |
      | online | offline | fehlgeschlagen mit Hinweis auf fehlende Verbindung |
