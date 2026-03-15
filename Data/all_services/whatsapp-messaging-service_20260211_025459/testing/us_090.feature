@smoke @regression
Feature: Cloud-Backup
  As a registrierter Nutzer
  I want to Chat-Backups in der Cloud aktivieren und ausfuehren
  So that um meine Nachrichten sicher zu speichern und sie plattformuebergreifend schnell wiederherstellen zu koennen

  Background:
    Given ein registrierter Nutzer ist angemeldet

  @@smoke @@regression @@happy-path
  Scenario: Erfolgreiches Aktivieren und Starten eines Cloud-Backups
    # Happy path: Backup wird erfolgreich gespeichert und bestaetigt
    Given der Nutzer hat eine stabile Internetverbindung
    And Cloud-Backup ist in den Einstellungen deaktiviert
    When der Nutzer aktiviert Cloud-Backup
    And der Nutzer startet ein Backup
    Then das Backup wird erfolgreich in der Cloud gespeichert
    And der Nutzer erhaelt eine Bestaetigung

  @@regression @@negative
  Scenario: Backup wird bei fehlender Verbindung abgelehnt
    # Error scenario: kein Internet oder Verbindungsabbruch
    Given der Nutzer hat keine Internetverbindung
    When der Nutzer startet ein Cloud-Backup
    Then das Backup wird nicht ausgefuehrt
    And der Nutzer erhaelt eine klare Fehlermeldung mit Hinweis zur Wiederholung

  @@regression @@negative
  Scenario: Backup wird abgelehnt wenn Speicherlimit erreicht ist
    # Error scenario: Speicherlimit ueberschritten
    Given der Nutzer hat sein Cloud-Speicherlimit erreicht
    When der Nutzer versucht ein weiteres Backup auszufuehren
    Then das Backup wird abgelehnt
    And der Nutzer erhaelt eine Meldung mit Optionen zur Speicherverwaltung

  @@regression @@edge
  Scenario: Cloud-Backup startet bei grenzwertiger Verbindung
    # Edge case: Verbindung ist instabil aber vorhanden
    Given der Nutzer hat eine instabile Internetverbindung mit kurzen Unterbrechungen
    When der Nutzer startet ein Cloud-Backup
    Then das Backup wird nicht ausgefuehrt
    And der Nutzer erhaelt eine klare Fehlermeldung mit Hinweis zur Wiederholung

  @@regression @@boundary
  Scenario: Backup bei Speicherlimit-Grenze
    # Boundary condition: Backup groesse an der Speichergrenze
    Given der Nutzer hat noch genau 0 MB freien Cloud-Speicher
    When der Nutzer startet ein Cloud-Backup
    Then das Backup wird abgelehnt
    And der Nutzer erhaelt eine Meldung mit Optionen zur Speicherverwaltung

  @@regression @@outline
  Scenario Outline: Datengetriebene Pruefung fuer Backup-Startbedingungen
    # Scenario Outline: verschiedene Netzwerkzustande und erwartete Ergebnisse
    Given der Nutzer hat den Netzwerkzustand "<network_state>"
    When der Nutzer startet ein Cloud-Backup
    Then das Ergebnis ist "<backup_result>"
    And die Nutzerbenachrichtigung ist "<message_type>"

    Examples:
      | network_state | backup_result | message_type |
      | stabil | erfolgreich gespeichert | Bestaetigung |
      | kein Internet | nicht ausgefuehrt | Fehlermeldung mit Hinweis zur Wiederholung |
      | verbindet sich und bricht ab | nicht ausgefuehrt | Fehlermeldung mit Hinweis zur Wiederholung |
