@@smoke @@regression
Feature: US-084 Gruppen-Einladungen
  As a Nutzeradministrator
  I want to konfigurieren, wer Nutzer zu Gruppen hinzufügen darf
  So that um Datenschutz, Sicherheit und Missbrauchsprävention in der Gruppenkommunikation sicherzustellen

  Background:
    Given eine existierende Gruppe mit mindestens einem Administrator und einem normalen Mitglied
    And der Nutzeradministrator ist angemeldet und hat die Berechtigung zur Gruppenverwaltung

  @@smoke @@regression @@happy-path
  Scenario: Administrator setzt Einladungen auf Nur Administratoren
    # Happy path: Admin konfiguriert Einladungseinstellungen erfolgreich
    Given die Einladungseinstellungen stehen auf "Alle Mitglieder"
    When der Nutzeradministrator die Einladungseinstellungen auf "Nur Administratoren" setzt und speichert
    Then die Einstellung wird erfolgreich gespeichert
    And nur Administratoren dürfen Mitglieder zu Gruppen hinzufügen

  @@regression @@negative
  Scenario: Mitglied darf bei Nur Administratoren niemanden hinzufügen
    # Error scenario: normales Mitglied versucht unerlaubt einzuladen
    Given die Einladungseinstellungen stehen auf "Nur Administratoren"
    And ein normales Gruppenmitglied ist angemeldet
    When das Gruppenmitglied versucht, einen Nutzer hinzuzufügen
    Then der Vorgang wird abgelehnt
    And eine entsprechende Fehlermeldung wird angezeigt

  @@smoke @@regression @@happy-path
  Scenario: Mitglied darf bei Alle Mitglieder Nutzer hinzufügen
    # Happy path: Mitglied fügt Nutzer hinzu, wenn alle Mitglieder einladen dürfen
    Given die Einladungseinstellungen stehen auf "Alle Mitglieder"
    And ein normales Gruppenmitglied ist angemeldet
    When das Gruppenmitglied einen Nutzer hinzufügt
    Then der Nutzer wird erfolgreich der Gruppe hinzugefügt

  @@regression @@edge
  Scenario Outline: Konfiguration wird mit nur gültigen Rollen akzeptiert
    # Edge case and boundary: nur erlaubte Werte sind speicherbar
    Given der Nutzeradministrator öffnet die Einladungseinstellungen
    When er versucht, die Einstellung auf "<rolle>" zu setzen und zu speichern
    Then das System antwortet mit "<ergebnis>"
    And die Einladungseinstellungen sind "<gespeichert>"

    Examples:
      | rolle | ergebnis | gespeichert |
      | Nur Administratoren | Speicherung erfolgreich | Nur Administratoren |
      | Alle Mitglieder | Speicherung erfolgreich | Alle Mitglieder |
      | Unbekannte Rolle | Speicherung abgelehnt | unverändert |

  @@regression @@boundary @@negative
  Scenario: Gleichzeitige Einladungen bei Nur Administratoren
    # Boundary condition: parallele Einladungen erlauben nur Admins
    Given die Einladungseinstellungen stehen auf "Nur Administratoren"
    And ein Administrator und ein normales Mitglied sind gleichzeitig angemeldet
    When beide versuchen gleichzeitig, denselben Nutzer hinzuzufügen
    Then nur die Einladung des Administrators wird akzeptiert
    And der Versuch des normalen Mitglieds wird mit einer Fehlermeldung abgelehnt
