@@smoke @@regression
Feature: Sicherheitscode-Verifizierung
  As a Support-Administrator
  I want to manuell die Verschlüsselung eines Nachrichtenaustauschs verifizieren
  So that Datenschutz- und Compliance-Anforderungen zuverlässig erfüllen zu können

  Background:
    Given der Support-Administrator ist im Administrationsportal authentifiziert
    And eine gesendete Nachricht steht im Verifikationsbereich zur Auswahl

  @@smoke @@regression @@happy-path
  Scenario: Manuelle Verifizierung zeigt verifiziert mit Schlüssel- und Algorithmusdetails
    # Happy Path: vollständige Verschlüsselungsmetadaten werden erfolgreich verifiziert
    Given die Nachricht enthält vollständige Verschlüsselungsmetadaten
    And die Metadaten enthalten Schlüssel-ID und Algorithmus
    When der Support-Administrator die manuelle Verifizierung startet
    Then zeigt das System das Ergebnis als "verifiziert" an
    And zeigt das System die verwendete Schlüssel-ID und den Algorithmus an

  @@regression @@negative @@edge
  Scenario: Verifizierung nicht möglich bei fehlenden oder unvollständigen Metadaten
    # Edge Case: fehlende Metadaten verhindern die Verifizierung
    Given die Nachricht hat unvollständige Verschlüsselungsmetadaten
    When der Support-Administrator die manuelle Verifizierung startet
    Then weist das System auf fehlende Daten hin
    And markiert das System die Verifizierung als "nicht möglich"

  @@regression @@negative
  Scenario: Verifizierung schlägt fehl bei ungültigen oder manipulierten Daten
    # Error Scenario: ungültige Metadaten führen zu Fehlerhinweis und Protokollierung
    Given die Nachricht enthält manipulierte Verschlüsselungsmetadaten
    When der Support-Administrator die manuelle Verifizierung durchführt
    Then zeigt das System einen klaren Fehlerhinweis an
    And protokolliert das System den Vorfall im Audit-Log

  @@regression @@boundary @@happy-path
  Scenario Outline: Manuelle Verifizierung als Szenario-Outline für verschiedene Algorithmen
    # Boundary Condition: minimale und maximale erlaubte Schlüssellängen je Algorithmus
    Given die Nachricht enthält vollständige Verschlüsselungsmetadaten mit Algorithmus <algorithm> und Schlüssellänge <key_length>
    When der Support-Administrator die manuelle Verifizierung startet
    Then zeigt das System das Ergebnis als "verifiziert" an
    And zeigt das System die verwendete Schlüssel-ID und den Algorithmus an

    Examples:
      | algorithm | key_length |
      | RSA | 2048 |
      | RSA | 4096 |
      | AES | 128 |
      | AES | 256 |

  @@regression @@negative @@edge
  Scenario Outline: Nicht möglich bei vollständig fehlenden Metadaten als Szenario-Outline
    # Edge Case: fehlende Pflichtfelder verhindern Verifizierung
    Given die Nachricht hat fehlende Pflichtmetadaten: <missing_field>
    When der Support-Administrator die manuelle Verifizierung startet
    Then weist das System auf fehlende Daten hin
    And markiert das System die Verifizierung als "nicht möglich"

    Examples:
      | missing_field |
      | Schlüssel-ID |
      | Algorithmus |
      | Zeitstempel der Verschlüsselung |
