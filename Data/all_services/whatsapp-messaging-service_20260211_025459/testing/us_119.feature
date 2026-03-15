@smoke @regression
Feature: Desktop-App Nutzung und Installation
  As a Endnutzer
  I want to die Anwendung als native Desktop-App auf meinem Betriebssystem installieren und nutzen
  So that um schnell, sicher und plattformübergreifend Nachrichten zu verwalten und zuverlässig zu kommunizieren

  Background:
    Given die Desktop-App Installationsdatei ist verfügbar

  @@smoke @@regression @@happy-path
  Scenario: Vollständige Kernfunktionen nach Login auf unterstützter Plattform
    # Happy Path: Nach erfolgreichem Login stehen alle Kernfunktionen der Webversion zur Verfügung
    Given eine unterstützte Plattform und eine gültige Installation der Desktop-App
    When ich die App starte und mich mit gültigen Zugangsdaten anmelde
    Then kann ich alle Kernfunktionen ohne Funktionsverlust gegenüber der Webversion nutzen
    And die Funktionen Nachrichten lesen, Nachrichten senden und Kontakte verwalten sind verfügbar

  @@regression @@edge
  Scenario: Nachrichtenversand bei kurzfristiger Offline-Unterbrechung wird nach Wiederherstellung automatisch gesendet
    # Edge Case: Kurzzeitige Netzunterbrechung während aktiver Sitzung führt zu Hinweis und Auto-Send
    Given eine bestehende aktive Sitzung in der Desktop-App
    And die Internetverbindung ist kurzfristig unterbrochen
    When ich eine Nachricht sende
    Then erhalte ich einen klaren Hinweis zur fehlenden Verbindung
    And die Nachricht wird nach Wiederherstellung der Verbindung automatisch gesendet

  @@regression @@negative
  Scenario: Installation auf nicht unterstützter Plattform zeigt Fehlermeldung
    # Error Scenario: Installation wird mit verständlicher Fehlermeldung abgebrochen
    Given eine nicht unterstützte Plattform
    When ich die Installation der Desktop-App starte
    Then erhalte ich eine verständliche Fehlermeldung mit Hinweis auf unterstützte Plattformen

  @@regression @@boundary
  Scenario Outline: Kernfunktionen auf unterstützten Plattformen ohne Funktionsverlust
    # Boundary: Plattformenliste prüfen, dass alle unterstützten OS funktionieren
    Given eine unterstützte Plattform <plattform> und eine gültige Installation
    When ich die App starte und mich anmelde
    Then stehen alle Kernfunktionen ohne Funktionsverlust zur Verfügung

    Examples:
      | plattform |
      | Windows 11 |
      | macOS 14 |
      | Ubuntu 22.04 |

  @@regression @@edge
  Scenario Outline: Hinweis bei Offline-Senden und automatische Zustellung nach Wiederverbindung
    # Boundary: unterschiedliche Unterbrechungsdauern der Verbindung
    Given eine bestehende aktive Sitzung
    And die Internetverbindung ist für <dauer> unterbrochen
    When ich eine Nachricht sende
    Then erscheint ein Hinweis zur fehlenden Verbindung
    And die Nachricht wird nach Wiederherstellung automatisch gesendet

    Examples:
      | dauer |
      | 5 Sekunden |
      | 30 Sekunden |
      | 2 Minuten |
