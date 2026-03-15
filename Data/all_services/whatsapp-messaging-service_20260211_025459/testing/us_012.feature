@@smoke @@regression
Feature: US-012 Sprachnachricht senden
  As a registrierter Endnutzer
  I want to eine Sprachnachricht aufnehmen und senden
  So that schnell und intuitiv kommunizieren, auch wenn Tippen unpraktisch ist

  Background:
    Given der Nutzer ist registriert und angemeldet
    And der Nutzer befindet sich in einem bestehenden Chat

  @@smoke @@regression @@happy-path
  Scenario: Sprachnachricht erfolgreich aufnehmen und senden
    # Happy path: gültige Aufnahme wird gesendet und im Chat angezeigt
    Given der Nutzer hat Mikrofonzugriff erteilt
    When der Nutzer startet die Aufnahme
    And der Nutzer beendet die Aufnahme und tippt auf Senden
    Then die Sprachnachricht wird versendet
    And die Sprachnachricht erscheint im Chat als gesendet und beim Empfänger als empfangen

  @@regression @@edge
  Scenario: Aufnahme wird vor dem Senden abgebrochen
    # Edge case: Aufnahme wird verworfen und es erscheint keine Nachricht
    Given der Nutzer hat Mikrofonzugriff erteilt
    When der Nutzer startet die Aufnahme
    And der Nutzer bricht die Aufnahme vor dem Senden ab
    Then die Sprachnachricht wird nicht versendet
    And im Chat erscheint keine neue Nachricht

  @@regression @@negative @@error
  Scenario: Mikrofonzugriff verweigert zeigt Fehlermeldung
    # Error scenario: fehlende Berechtigung führt zu verständlicher Fehlermeldung
    Given der Nutzer hat den Mikrofonzugriff verweigert
    When der Nutzer versucht eine Sprachnachricht aufzunehmen
    Then das System zeigt eine verständliche Fehlermeldung
    And das System bietet an, die Mikrofonberechtigung zu erteilen

  @@regression @@boundary
  Scenario Outline: Grenzwerte der Aufnahmelänge
    # Boundary conditions: minimale und maximale zulässige Aufnahmelänge
    Given der Nutzer hat Mikrofonzugriff erteilt
    When der Nutzer nimmt eine Sprachnachricht mit der Dauer "<duration>" auf
    And der Nutzer tippt auf Senden
    Then das System verhält sich gemäß "<expected_result>"

    Examples:
      | duration | expected_result |
      | minimale erlaubte Dauer | Sprachnachricht wird gesendet und angezeigt |
      | maximale erlaubte Dauer | Sprachnachricht wird gesendet und angezeigt |

  @@regression @@negative @@boundary @@error
  Scenario Outline: Ungültige Aufnahmelänge außerhalb der Grenzen
    # Boundary error: zu kurze oder zu lange Aufnahme wird abgewiesen
    Given der Nutzer hat Mikrofonzugriff erteilt
    When der Nutzer nimmt eine Sprachnachricht mit der Dauer "<duration>" auf
    And der Nutzer tippt auf Senden
    Then das System zeigt eine verständliche Fehlermeldung
    And die Sprachnachricht wird nicht versendet

    Examples:
      | duration |
      | kürzer als die minimale Dauer |
      | länger als die maximale Dauer |
