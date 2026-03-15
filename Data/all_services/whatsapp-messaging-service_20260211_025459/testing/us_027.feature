@@smoke @@regression
Feature: Gruppenadministration
  As a Support-Administrator
  I want to Gruppenmitglieder und Rollen in einer Gruppe verwalten
  So that um eine sichere und effiziente Moderation sowie Compliance in Gruppen zu gewährleisten

  Background:
    Given eine bestehende Gruppe mit Administratorrechten für den Support-Administrator

  @@smoke @@regression @@happy-path
  Scenario: Rolle zuweisen und sofortige Sichtbarkeit
    # Happy Path: Rollenänderung wird gespeichert und ist für alle sichtbar
    Given ein aktives Gruppenmitglied ohne spezielle Rolle
    When der Support-Administrator weist dem Nutzer die Rolle "Moderator" zu
    Then die Rollenänderung wird sofort gespeichert
    And alle Gruppenmitglieder sehen die neue Rolle in der Mitgliederliste

  @@regression @@happy-path
  Scenario: Datenschutzeinstellungen ändern und protokollieren
    # Happy Path: Sichtbarkeit und Beitrittsregeln werden sofort wirksam und im Aktivitätsprotokoll erfasst
    Given eine Gruppe mit konfigurierten Datenschutzeinstellungen
    When der Support-Administrator ändert die Gruppensichtbarkeit auf "Privat" und die Beitrittsregel auf "Nur auf Einladung"
    Then die neuen Einstellungen sind sofort wirksam
    And die Änderung wird im Aktivitätsprotokoll mit Zeitstempel erfasst

  @@regression @@happy-path
  Scenario: Beitrag entfernen und Benachrichtigung senden
    # Happy Path: Moderationsverstoß führt zur Löschung und Benachrichtigung
    Given eine Gruppe mit aktivierter Content-Moderation und ein Beitrag, der gegen Richtlinien verstößt
    When der Support-Administrator entfernt den Beitrag mit dem Grund "Richtlinienverstoß"
    Then der Beitrag wird aus der Gruppe gelöscht
    And der Ersteller erhält eine Benachrichtigung mit dem angegebenen Grund

  @@regression @@edge
  Scenario: Rollenänderung für bereits zugewiesene Rolle
    # Edge Case: erneutes Zuweisen derselben Rolle führt zu keiner Änderung, aber ohne Fehler
    Given ein aktives Gruppenmitglied mit der Rolle "Moderator"
    When der Support-Administrator weist dem Nutzer erneut die Rolle "Moderator" zu
    Then die Rollenänderung wird nicht dupliziert
    And eine Bestätigung wird angezeigt, dass die Rolle bereits zugewiesen ist

  @@regression @@edge
  Scenario: Änderung der Sichtbarkeit auf denselben Wert
    # Edge Case: keine effektive Änderung, aber Protokollierung des Versuchs
    Given die Gruppe ist bereits "Öffentlich"
    When der Support-Administrator setzt die Gruppensichtbarkeit erneut auf "Öffentlich"
    Then die Sichtbarkeit bleibt unverändert
    And der Versuch wird im Aktivitätsprotokoll vermerkt

  @@regression @@negative
  Scenario: Benutzer ohne ausreichende Berechtigung entfernen
    # Error Scenario: Aktion wird abgelehnt und Fehlermeldung angezeigt
    Given ein Zielnutzer mit höherer Rolle als der Support-Administrator
    When der Support-Administrator versucht, den Nutzer aus der Gruppe zu entfernen
    Then die Aktion wird abgelehnt
    And eine verständliche Fehlermeldung wird angezeigt

  @@regression @@negative
  Scenario: Ungültige Rolle zuweisen
    # Error Scenario: unbekannte Rolle wird abgelehnt
    Given ein aktives Gruppenmitglied
    When der Support-Administrator weist die Rolle "SuperUserX" zu
    Then die Rollenänderung wird nicht gespeichert
    And eine Fehlermeldung zeigt an, dass die Rolle ungültig ist

  @@regression @@boundary
  Scenario Outline: Rollenwechsel mit Szenario-Outline
    # Boundary: Rollenwechsel zwischen minimalen und maximalen Rechten
    Given ein aktives Gruppenmitglied mit der Rolle "<current_role>"
    When der Support-Administrator ändert die Rolle auf "<new_role>"
    Then die neue Rolle wird gespeichert und ist sichtbar
    And die Änderung wird im Aktivitätsprotokoll vermerkt

    Examples:
      | current_role | new_role |
      | Mitglied | Moderator |
      | Moderator | Mitglied |

  @@regression @@boundary
  Scenario Outline: Datenschutzeinstellungen mit Szenario-Outline
    # Boundary: Wechsel zwischen allen unterstützten Sichtbarkeiten und Beitrittsregeln
    Given eine Gruppe mit aktueller Sichtbarkeit "<current_visibility>" und Beitrittsregel "<current_join_rule>"
    When der Support-Administrator setzt Sichtbarkeit auf "<new_visibility>" und Beitrittsregel auf "<new_join_rule>"
    Then die neuen Einstellungen sind sofort wirksam
    And die Änderungen werden im Aktivitätsprotokoll erfasst

    Examples:
      | current_visibility | current_join_rule | new_visibility | new_join_rule |
      | Öffentlich | Offen | Privat | Nur auf Einladung |
      | Privat | Nur auf Einladung | Öffentlich | Offen |
