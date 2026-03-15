@@smoke @@regression
Feature: Videoanruf
  As a Endnutzer
  I want to einen verschlüsselten Videoanruf starten und führen
  So that um vertrauliche Gespräche sicher zu führen und Datenschutzanforderungen zu erfüllen

  Background:
    Given der Endnutzer ist angemeldet

  @@smoke @@regression @@happy-path
  Scenario: Verschlüsselter Videoanruf wird erfolgreich aufgebaut
    # Prüft den erfolgreichen Aufbau eines verschlüsselten Videoanrufs bei stabiler Verbindung
    Given der Endnutzer hat eine stabile Internetverbindung
    And der angerufene Nutzer ist online und verfügbar
    When der Endnutzer einen Videoanruf startet
    Then wird der Videoanruf aufgebaut
    And die Verbindung ist während des gesamten Anrufs verschlüsselt

  @@regression @@negative @@error
  Scenario: Anruf schlägt fehl, wenn Teilnehmer offline ist
    # Fehlerfall bei nicht erreichbarem Teilnehmer
    Given der angerufene Nutzer ist offline
    When der Endnutzer einen Videoanruf startet
    Then erhält der Endnutzer eine verständliche Meldung, dass der Teilnehmer nicht erreichbar ist
    And der Anruf wird nicht aufgebaut

  @@regression @@edge
  Scenario: Videoqualität passt sich an bei schlechter Netzwerkqualität
    # Edge Case: Bandbreite fällt unter Mindestniveau während eines laufenden Anrufs
    Given ein verschlüsselter Videoanruf ist aktiv
    When die Bandbreite unter ein Mindestniveau fällt
    Then passt das System die Videoqualität an
    And die Verschlüsselung bleibt aktiv

  @@regression @@boundary
  Scenario Outline: Grenzwertprüfung der Bandbreite für Qualitätsanpassung
    # Boundary Condition: Verhalten bei Bandbreite knapp unter/über dem Mindestniveau
    Given ein verschlüsselter Videoanruf ist aktiv
    When die Bandbreite beträgt <bandwidth_kbps> Kbps
    Then ist die Qualitätsanpassung <quality_adjustment>
    And die Verschlüsselung bleibt aktiv

    Examples:
      | bandwidth_kbps | quality_adjustment |
      | 299 | aktiv |
      | 300 | inaktiv |
