@@smoke @@regression
Feature: Broadcast-Listen
  As a Business-Account-Administrator
  I want to eine Broadcast-Liste erstellen und eine Massen-Nachricht an mehrere Empfänger versenden
  So that Kunden schnell und zuverlässig zu erreichen und die professionelle Kommunikation effizient zu skalieren

  Background:
    Given der Administrator ist als Business-Account-Administrator angemeldet

  @@smoke @@regression @@happy-path
  Scenario Outline: Broadcast an gültige Empfänger senden
    # Happy path: Nachricht wird an alle gültigen Empfänger zugestellt und der Versandstatus pro Empfänger angezeigt
    Given eine Broadcast-Liste mit gültigen Empfängern existiert
    And eine Nachricht mit Inhalt "<message>" ist erstellt
    When der Administrator den Versand an die Broadcast-Liste startet
    Then die Nachricht wird an alle Empfänger zugestellt
    And der Versandstatus wird pro Empfänger angezeigt

    Examples:
      | message |
      | Neue Öffnungszeiten ab morgen |
      | Sonderangebot nur heute |

  @@regression @@edge
  Scenario Outline: Empfänger ohne Einwilligung oder gesperrte Kontakte werden übersprungen
    # Edge case: Liste enthält nicht berechtigte Empfänger, die ausgeschlossen werden
    Given eine Broadcast-Liste enthält gültige Empfänger sowie Empfänger ohne Einwilligung oder gesperrte Kontakte
    And eine Nachricht mit Inhalt "<message>" ist erstellt
    When der Administrator den Versand an die Broadcast-Liste startet
    Then Empfänger ohne Einwilligung oder gesperrte Kontakte werden übersprungen
    And eine Übersicht der ausgeschlossenen Kontakte mit Begründung wird angezeigt

    Examples:
      | message |
      | Wartungsinformation für Kunden |

  @@regression @@negative
  Scenario Outline: Versand bei leerer Broadcast-Liste verhindern
    # Error scenario: Versand wird verhindert, wenn die Broadcast-Liste leer ist
    Given eine leere Broadcast-Liste ist ausgewählt
    And eine Nachricht mit Inhalt "<message>" ist erstellt
    When der Administrator den Versand an die Broadcast-Liste startet
    Then der Versand wird verhindert
    And eine verständliche Fehlermeldung wird angezeigt

    Examples:
      | message |
      | Testnachricht |

  @@regression @@boundary
  Scenario Outline: Grenzwert: Broadcast-Liste mit minimaler Empfängeranzahl
    # Boundary condition: Versand an eine Liste mit genau einem gültigen Empfänger
    Given eine Broadcast-Liste mit genau einem gültigen Empfänger existiert
    And eine Nachricht mit Inhalt "<message>" ist erstellt
    When der Administrator den Versand an die Broadcast-Liste startet
    Then die Nachricht wird an den Empfänger zugestellt
    And der Versandstatus wird für diesen Empfänger angezeigt

    Examples:
      | message |
      | Willkommen bei unserem Service |
