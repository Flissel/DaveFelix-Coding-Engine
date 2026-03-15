@@smoke @@regression
Feature: Verschluesseltes Backup
  As a registrierter Nutzer
  I want to ein Ende-zu-Ende-verschlüsseltes Backup seiner Daten erstellen und wiederherstellen
  So that damit seine Daten auch im Backup sicher und vertraulich bleiben und er sie bei Bedarf zuverlässig zurückerhalten kann

  Background:
    Given der Nutzer ist registriert und angemeldet
    And die Backup-Funktion ist geöffnet

  @@smoke @@happy-path @@regression
  Scenario: Erfolgreiches Erstellen eines Ende-zu-Ende-verschlüsselten Backups
    # Happy path für das Erstellen eines verschlüsselten Backups
    Given der Nutzer verfügt über gültige Verschlüsselungsdaten
    When er ein Backup startet
    Then wird das Backup Ende-zu-Ende verschlüsselt erstellt
    And der Nutzer erhält eine Erfolgsmeldung

  @@regression @@happy-path
  Scenario: Erfolgreiche Wiederherstellung eines Ende-zu-Ende-verschlüsselten Backups
    # Happy path für die Wiederherstellung eines verschlüsselten Backups
    Given es existiert ein Ende-zu-Ende-verschlüsseltes Backup des Nutzers
    And der Nutzer besitzt ein gültiges Entschlüsselungsgeheimnis
    When der Nutzer die Wiederherstellung ausführt
    Then werden die Daten vollständig und korrekt wiederhergestellt

  @@negative @@regression
  Scenario: Wiederherstellung wird ohne gültiges Entschlüsselungsgeheimnis abgelehnt
    # Error scenario für fehlendes oder ungültiges Entschlüsselungsgeheimnis
    Given es existiert ein Ende-zu-Ende-verschlüsseltes Backup des Nutzers
    And der Nutzer hat kein gültiges Entschlüsselungsgeheimnis
    When er versucht, ein Backup wiederherzustellen
    Then wird die Wiederherstellung abgelehnt
    And eine verständliche Fehlermeldung wird angezeigt

  @@regression @@boundary
  Scenario Outline: Wiederherstellung mit unterschiedlichen Datenmengen
    # Boundary conditions für minimale und maximale Datenmengen
    Given es existiert ein Ende-zu-Ende-verschlüsseltes Backup des Nutzers mit <data_size>
    And der Nutzer besitzt ein gültiges Entschlüsselungsgeheimnis
    When der Nutzer die Wiederherstellung ausführt
    Then werden die Daten vollständig und korrekt wiederhergestellt

    Examples:
      | data_size |
      | minimaler Datenmenge (0 Datensätze) |
      | maximal unterstützter Datenmenge |

  @@edge @@regression
  Scenario: Backup-Erstellung bei kurzzeitigem Netzwerkunterbruch
    # Edge case für temporäre Netzwerkausfälle während der Backup-Erstellung
    Given der Nutzer verfügt über gültige Verschlüsselungsdaten
    And es tritt ein kurzzeitiger Netzwerkunterbruch auf
    When er ein Backup startet
    Then wird das Backup Ende-zu-Ende verschlüsselt erstellt, sobald die Verbindung wiederhergestellt ist
    And der Nutzer erhält eine Erfolgsmeldung
