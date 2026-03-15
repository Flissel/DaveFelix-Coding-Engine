@@smoke @@regression
Feature: Anrufverlauf anzeigen
  As a registrierter Nutzer
  I want to den Anrufverlauf einsehen
  So that um vergangene Anrufe schnell nachzuvollziehen und zuverlässig kommunizieren zu können

  Background:
    Given der Nutzer ist registriert und angemeldet

  @@smoke @@regression @@happy-path
  Scenario: Anrufverlauf zeigt erfolgreiche Anrufe chronologisch
    # Happy path: erfolgreiche ein- und ausgehende Anrufe werden vollständig und in richtiger Reihenfolge angezeigt
    Given es liegen erfolgreiche ein- und ausgehende Anrufe mit Datum, Uhrzeit, Richtung und Kontakt vor
    When der Nutzer den Anrufverlauf öffnet
    Then werden die Anrufe chronologisch sortiert angezeigt
    And jeder Eintrag zeigt Datum, Uhrzeit, Richtung und Kontakt

  @@regression @@edge
  Scenario: Status für verpasste oder abgebrochene Anrufe wird angezeigt
    # Edge case: Anrufe ohne erfolgreiche Verbindung zeigen einen eindeutigen Status
    Given es existieren Anrufeinträge mit Status verpasst oder abgebrochen
    When der Nutzer den Anrufverlauf aufruft
    Then wird jeder nicht erfolgreiche Anruf mit einem eindeutigen Status angezeigt
    And die Statuswerte sind für den Nutzer verständlich

  @@regression @@negative
  Scenario: Zugriff auf fremden Anrufverlauf wird verweigert
    # Error scenario: fehlende Berechtigung führt zu verweigertem Zugriff mit Fehlermeldung
    Given der Nutzer hat keine Berechtigung für den Anrufverlauf eines anderen Kontos
    When der Nutzer versucht den Anrufverlauf des anderen Kontos aufzurufen
    Then wird der Zugriff verweigert
    And eine verständliche Fehlermeldung wird angezeigt

  @@regression @@boundary
  Scenario: Nachladen vieler Anrufeinträge beim Scrollen
    # Boundary/Performance: zusätzliche Einträge werden performant nachgeladen
    Given es gibt sehr viele Anrufeinträge
    When der Nutzer im Verlauf scrollt und weitere Einträge lädt
    Then werden zusätzliche Einträge performant nachgeladen
    And die Bedienung bleibt reaktionsfähig

  @@regression @@data-driven
  Scenario Outline: Anrufeinträge werden korrekt nach Richtung und Status angezeigt
    # Scenario outline: verschiedene Richtungen und Status werden korrekt dargestellt
    Given ein Anrufeintrag mit Richtung <richtung> und Status <status> existiert
    When der Nutzer den Anrufverlauf öffnet
    Then wird der Anruf mit Richtung <richtung> und Status <status> angezeigt

    Examples:
      | richtung | status |
      | eingehend | erfolgreich |
      | ausgehend | erfolgreich |
      | eingehend | verpasst |
      | ausgehend | abgebrochen |
