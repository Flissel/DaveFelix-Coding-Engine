@@smoke @@regression
Feature: Unbekannte Absender
  As a Systemadministrator
  I want to unbekannte Absender erkennen und gesondert behandeln lassen
  So that Datenschutz und Sicherheit erhöhen sowie Missbrauch präventiv reduzieren

  Background:
    Given das System ist betriebsbereit und die Absenderdatenbank ist geladen

  @@happy-path @@smoke
  Scenario: Unbekannter Absender wird markiert und verschoben
    # Happy Path: Eine Nachricht von einer unbekannten Nummer wird korrekt behandelt
    Given eine eingehende Nachricht stammt von einer nicht verifizierten Nummer
    When die Nachricht verarbeitet wird
    Then wird der Absender als unbekannt markiert
    And die Nachricht wird in den Bereich für unbekannte Absender verschoben

  @@happy-path @@regression
  Scenario: Bekannter Absender bleibt im regulären Posteingang
    # Happy Path: Eine Nachricht von einem verifizierten Absender wird normal abgelegt
    Given eine eingehende Nachricht stammt von einer verifizierten Nummer
    When die Nachricht verarbeitet wird
    Then wird die Nachricht im regulären Posteingang abgelegt
    And es erfolgt keine Sonderbehandlung

  @@edge @@regression
  Scenario: Mehrfacher Versand durch unbekannten Absender wird zusammengefasst
    # Edge Case: Mehrere Nachrichten im Zeitfenster werden gebündelt und optional gemeldet
    Given ein unbekannter Absender sendet mehrere Nachrichten innerhalb eines definierten Zeitfensters
    When die Nachrichten verarbeitet werden
    Then werden die Nachrichten zusammengefasst angezeigt
    And es kann eine Benachrichtigung an die Moderation ausgelöst werden

  @@negative @@regression
  Scenario: Klassifizierungsfehler legt Nachricht in Quarantäne
    # Error Scenario: Nachricht ohne Metadaten wird nicht klassifiziert
    Given eine Nachricht von einem unbekannten Absender enthält keine erforderlichen Metadaten
    When die Verarbeitung der Nachricht fehlschlägt
    Then wird die Nachricht in die Quarantäne gelegt
    And ein Fehlerprotokoll für das Monitoring wird erzeugt

  @@boundary @@regression
  Scenario: Boundary: Zeitfenstergrenze für Zusammenfassung
    # Boundary Condition: Nachrichten genau an der Zeitfenstergrenze
    Given ein unbekannter Absender sendet Nachrichten mit einem Zeitabstand exakt an der Zeitfenstergrenze
    When die Nachrichten verarbeitet werden
    Then werden die Nachrichten gemäß der Zeitfenster-Definition entweder zusammengefasst oder getrennt angezeigt
    And die Moderationsbenachrichtigung folgt der Konfiguration

  @@happy-path @@regression
  Scenario Outline: Scenario Outline: Unbekannte Absender-Identifikation anhand unterschiedlicher IDs
    # Data-driven: Unbekannte Absender werden korrekt erkannt und verschoben
    Given eine eingehende Nachricht stammt von der Absender-ID "<sender_id>" und ist nicht verifiziert
    When die Nachricht verarbeitet wird
    Then wird der Absender als unbekannt markiert
    And die Nachricht wird in den Bereich für unbekannte Absender verschoben

    Examples:
      | sender_id |
      | +491701234567 |
      | whatsapp:abc-unknown-001 |
      | email:unknown@example.com |

  @@happy-path @@smoke
  Scenario Outline: Scenario Outline: Klassifizierung bekannter Absender
    # Data-driven: Verifizierte Absender werden normal verarbeitet
    Given eine eingehende Nachricht stammt von der verifizierten Absender-ID "<sender_id>"
    When die Nachricht verarbeitet wird
    Then wird die Nachricht im regulären Posteingang abgelegt
    And es erfolgt keine Sonderbehandlung

    Examples:
      | sender_id |
      | +491709876543 |
      | whatsapp:verified-777 |
