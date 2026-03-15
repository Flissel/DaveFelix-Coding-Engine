@@smoke @@regression
Feature: Blockieren von Kontakten
  As a Endnutzer
  I want to einen Kontakt blockieren
  So that um unerwünschte Kommunikation zu verhindern und die eigene Sicherheit und Privatsphäre zu schützen

  Background:
    Given der Endnutzer ist angemeldet und befindet sich in der Kontaktliste

  @@smoke @@regression @@happy-path
  Scenario: Kontakt erfolgreich blockieren
    # Happy Path: ein bestehender Kontakt wird blockiert und kann keine Nachrichten mehr senden
    Given der Kontakt "Max Mustermann" ist im Status "aktiv"
    When der Endnutzer die Blockieren-Funktion für "Max Mustermann" auslöst
    Then wird der Kontakt als "blockiert" markiert
    And der Kontakt kann keine Nachrichten an den Endnutzer senden

  @@regression @@edge @@negative
  Scenario: Bereits blockierten Kontakt erneut blockieren
    # Edge Case: Blockieren eines bereits blockierten Kontakts zeigt eine informative Meldung ohne Statusänderung
    Given der Kontakt "Erika Musterfrau" ist im Status "blockiert"
    When der Endnutzer die Blockieren-Funktion für "Erika Musterfrau" auslöst
    Then zeigt das System eine informative Meldung an
    And der Status des Kontakts bleibt "blockiert"

  @@regression @@negative @@error
  Scenario: Blockieren schlägt wegen System- oder Netzwerkstörung fehl
    # Error Scenario: Blockieren scheitert und der Status bleibt unverändert
    Given eine Netzwerk- oder Systemstörung liegt vor
    And der Kontakt "Jonas Beispiel" ist im Status "aktiv"
    When der Endnutzer die Blockieren-Funktion für "Jonas Beispiel" auslöst
    Then zeigt das System eine Fehlermeldung an
    And der Status des Kontakts bleibt "aktiv"

  @@regression @@boundary
  Scenario Outline: Blockieren mit verschiedenen Kontaktarten
    # Boundary Condition: unterschiedliche Kontaktarten können blockiert werden
    Given der Kontakt ist im Status "aktiv" und vom Typ "<contact_type>"
    When der Endnutzer die Blockieren-Funktion für den Kontakt auslöst
    Then wird der Kontakt als "blockiert" markiert
    And der Kontakt kann keine Nachrichten an den Endnutzer senden

    Examples:
      | contact_type |
      | privat |
      | geschäftlich |
      | unbekannt |

  @@regression @@boundary
  Scenario Outline: Blockieren mehrerer Kontakte nacheinander
    # Boundary Condition: mehrere Blockierungen hintereinander funktionieren unabhängig
    Given die Kontakte "<contact_a>" und "<contact_b>" sind im Status "aktiv"
    When der Endnutzer die Blockieren-Funktion für "<contact_a>" auslöst
    And der Endnutzer die Blockieren-Funktion für "<contact_b>" auslöst
    Then sind beide Kontakte als "blockiert" markiert

    Examples:
      | contact_a | contact_b |
      | Kontakt 1 | Kontakt 2 |
      | Kontakt A | Kontakt B |
