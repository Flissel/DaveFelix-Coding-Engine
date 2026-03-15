@@smoke @@regression
Feature: Gruppeneinstellungen konfigurieren und speichern
  As a Gruppenadministrator
  I want to Gruppeneinstellungen konfigurieren und speichern
  So that damit die Gruppenkommunikation sicher, effizient und an die Bedürfnisse der Mitglieder angepasst ist

  Background:
    Given eine bestehende Gruppe ist vorhanden
    And der Nutzer ist angemeldet

  @@smoke @@regression @@happy-path
  Scenario: Gültige Gruppeneinstellungen speichern und sofort anwenden
    # Happy path: Administrator speichert gültige Einstellungen und sie wirken sofort
    Given der Nutzer hat Administratorrechte in der Gruppe
    When der Administrator wählt gültige Einstellungen aus und speichert
    Then die Einstellungen werden dauerhaft gespeichert
    And die Änderungen wirken sich sofort auf die Gruppe aus

  @@regression @@happy-path
  Scenario: Standardwert für eine Einstellung zurücksetzen
    # Happy path: Einstellung wird auf Standard zurückgesetzt und korrekt angezeigt
    Given der Nutzer hat Administratorrechte in der Gruppe
    When der Administrator setzt eine Einstellung auf den Standardwert zurück und speichert
    Then der Standardwert wird angewendet
    And der Standardwert wird in der Übersicht korrekt angezeigt

  @@negative @@regression
  Scenario: Ungültige Berechtigung beim Ändern der Gruppeneinstellungen
    # Error scenario: Nutzer ohne Administratorrechte darf Einstellungen nicht ändern
    Given der Nutzer hat keine Administratorrechte in der Gruppe
    When der Nutzer versucht, Gruppeneinstellungen zu ändern und zu speichern
    Then die Aktion wird verweigert
    And eine verständliche Fehlermeldung wird angezeigt

  @@regression @@boundary
  Scenario Outline: Szenario Outline: Grenzwerte für maximale Mitgliederzahl speichern
    # Boundary conditions: maximale Mitgliederzahl innerhalb und außerhalb der erlaubten Grenzen
    Given der Nutzer hat Administratorrechte in der Gruppe
    And die Einstellung 'maximale Mitgliederzahl' ist konfigurierbar
    When der Administrator setzt die maximale Mitgliederzahl auf <wert> und speichert
    Then <ergebnis>
    And <anzeige>

    Examples:
      | wert | ergebnis | anzeige |
      | 1 | die Einstellung wird gespeichert | die Übersicht zeigt den Wert 1 |
      | 500 | die Einstellung wird gespeichert | die Übersicht zeigt den Wert 500 |
      | 0 | die Speicherung wird abgelehnt | eine verständliche Fehlermeldung wird angezeigt |
      | 501 | die Speicherung wird abgelehnt | eine verständliche Fehlermeldung wird angezeigt |

  @@regression @@edge
  Scenario Outline: Szenario Outline: Leere oder zu lange Gruppenbeschreibung
    # Edge cases: Beschreibung ist leer oder überschreitet die erlaubte Länge
    Given der Nutzer hat Administratorrechte in der Gruppe
    And die Einstellung 'Gruppenbeschreibung' ist konfigurierbar
    When der Administrator setzt die Gruppenbeschreibung auf <beschreibung> und speichert
    Then <ergebnis>
    And <anzeige>

    Examples:
      | beschreibung | ergebnis | anzeige |
      | "" | die Einstellung wird gespeichert | die Übersicht zeigt eine leere Beschreibung |
      | "A"*500 | die Einstellung wird gespeichert | die Übersicht zeigt die Beschreibung mit 500 Zeichen |
      | "B"*501 | die Speicherung wird abgelehnt | eine verständliche Fehlermeldung wird angezeigt |
