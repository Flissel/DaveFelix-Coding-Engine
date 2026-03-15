@@smoke @@regression
Feature: Kontakt hinzufuegen
  As a registrierter Endnutzer
  I want to einen neuen Kontakt über mehrere verfügbare Wege hinzufügen
  So that um schnell und intuitiv kommunizieren zu können und eine zuverlässige Zustellung sicherzustellen

  Background:
    Given der Nutzer ist angemeldet und befindet sich im Bereich "Kontakte"

  @@smoke @@regression @@happy-path
  Scenario Outline: Kontakt erfolgreich über unterstützte Wege hinzufügen
    # Validiert, dass ein neuer Kontakt über mehrere unterstützte Wege gespeichert und angezeigt wird
    When der Nutzer fügt einen Kontakt über den Weg "<weg>" mit gültigen Daten hinzu
    And er bestätigt die Eingaben
    Then wird der Kontakt gespeichert
    And der Kontakt wird in der Kontaktliste angezeigt

    Examples:
      | weg |
      | Telefonnummer |
      | QR-Code |
      | Link |

  @@regression @@boundary
  Scenario Outline: Kontakt hinzufügen mit minimal gültigen Daten
    # Prüft die untere Grenze gültiger Eingaben
    When der Nutzer fügt einen Kontakt über den Weg "Telefonnummer" mit der minimal gültigen Nummer "<nummer>" hinzu
    And er bestätigt die Eingaben
    Then wird der Kontakt gespeichert
    And der Kontakt wird in der Kontaktliste angezeigt

    Examples:
      | nummer |
      | +49123456789 |

  @@regression @@boundary
  Scenario Outline: Kontakt hinzufügen mit maximal erlaubter Länge
    # Prüft die obere Grenze für einen Kontaktnamen
    When der Nutzer fügt einen Kontakt mit dem Namen "<name>" über den Weg "Telefonnummer" hinzu
    And er bestätigt die Eingaben
    Then wird der Kontakt gespeichert
    And der Kontakt wird in der Kontaktliste angezeigt

    Examples:
      | name |
      | MaximalLaengerNameMit40Zeichen_1234567890 |

  @@regression @@negative @@error
  Scenario Outline: Kontakt hinzufügen mit unvollständigen oder ungültigen Daten
    # Stellt sicher, dass ungültige Eingaben abgewiesen werden
    When der Nutzer versucht einen Kontakt über den Weg "<weg>" mit ungültigen Daten "<daten>" hinzuzufügen
    And er sendet die Eingabe ab
    Then zeigt das System eine verständliche Fehlermeldung an
    And der Kontakt wird nicht gespeichert

    Examples:
      | weg | daten |
      | Telefonnummer | 123ABC |
      | QR-Code | leer |
      | Link | htp://ungueltig |

  @@regression @@negative
  Scenario Outline: Duplikatkontakt hinzufügen
    # Verhindert das Hinzufügen eines bereits vorhandenen Kontakts
    Given ein Kontakt mit dem eindeutigen Identifier "<identifier>" ist bereits vorhanden
    When der Nutzer fügt denselben Kontakt über den Weg "<weg>" erneut hinzu
    And er bestätigt die Eingaben
    Then verhindert das System das Duplikat
    And der Nutzer wird entsprechend informiert

    Examples:
      | weg | identifier |
      | Telefonnummer | +49123456789 |
      | QR-Code | qr:contact-123 |
      | Link | https://example.com/contact/123 |

  @@regression @@negative @@error
  Scenario Outline: Kontakt hinzufügen mit nicht unterstütztem Weg
    # Stellt sicher, dass nicht unterstützte Wege abgewiesen werden
    When der Nutzer versucht einen Kontakt über den nicht unterstützten Weg "<weg>" hinzuzufügen
    Then zeigt das System eine verständliche Fehlermeldung an
    And der Kontakt wird nicht gespeichert

    Examples:
      | weg |
      | NFC |
