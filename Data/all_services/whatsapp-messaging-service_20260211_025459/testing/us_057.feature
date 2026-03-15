@@smoke @@regression
Feature: End-to-End Verschluesselung
  As a registrierter Endnutzer
  I want to Nachrichten mit Ende-zu-Ende-Verschlüsselung senden und empfangen
  So that damit meine Kommunikation vertraulich bleibt und meine Daten geschützt sind

  Background:
    Given der Nutzer ist angemeldet und besitzt ein gültiges Schlüsselpaar
    And der Empfänger ist erreichbar und besitzt ein gültiges Schlüsselpaar

  @@smoke @@regression @@happy-path
  Scenario: Erfolgreiches Senden und Empfangen einer verschlüsselten Nachricht
    # Validiert die Ende-zu-Ende-Verschlüsselung im Happy Path
    Given eine neue Textnachricht ist erstellt
    When der Nutzer die Nachricht an den Empfänger sendet
    Then wird die Nachricht Ende-zu-Ende verschlüsselt übertragen
    And nur der Empfänger kann die Nachricht entschlüsseln und lesen

  @@regression @@edge
  Scenario: Nachricht mit Anhängen und Sonderzeichen wird korrekt verschlüsselt
    # Stellt sicher, dass Inhalt und Anhänge verschlüsselt und korrekt angezeigt werden
    Given eine Nachricht mit Text, Sonderzeichen und einem Anhang ist erstellt
    When der Nutzer die Nachricht versendet
    Then werden Text und Anhang Ende-zu-Ende verschlüsselt übertragen
    And der Empfänger sieht Text und Anhang unverändert und vollständig

  @@regression @@negative @@security
  Scenario: Unbefugter Dritter kann den Inhalt nicht lesen
    # Validiert, dass keine Klartextdaten auf dem Transportweg übertragbar sind
    Given ein unbefugter Dritter überwacht den Transportweg
    When die Nachricht übertragen wird
    Then sind keine Klartextdaten im Transport sichtbar
    And der Dritte kann den Inhalt nicht entschlüsseln

  @@regression @@boundary
  Scenario Outline: Scenario Outline: Nachrichtenlaenge wird am Grenzwert verschlüsselt und zugestellt
    # Prüft Grenzwerte der Nachrichtenlänge
    Given eine Nachricht mit der Länge <message_length> ist erstellt
    When der Nutzer die Nachricht sendet
    Then wird die Nachricht Ende-zu-Ende verschlüsselt übertragen
    And der Empfänger kann die Nachricht vollständig entschlüsseln

    Examples:
      | message_length |
      | 1 Zeichen |
      | maximale erlaubte Länge |

  @@regression @@negative
  Scenario Outline: Scenario Outline: Versand schlägt fehl, wenn Empfänger nicht erreichbar ist
    # Fehlerszenario bei nicht erreichbarem Empfänger
    Given der Empfänger ist <empfaenger_status>
    When der Nutzer eine Nachricht sendet
    Then wird keine Nachricht übertragen
    And der Nutzer erhält eine verständliche Fehlermeldung

    Examples:
      | empfaenger_status |
      | nicht erreichbar |
      | offline |
