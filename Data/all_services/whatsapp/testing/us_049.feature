@@smoke @@regression
Feature: Dokumente senden
  As a medizinischer Benutzer
  I want to beliebige Dokumente über das System senden
  So that damit Dokumente zuverlässig und nachvollziehbar an die vorgesehenen Empfänger übermittelt werden können

  Background:
    Given der Benutzer ist im System angemeldet

  @@smoke @@regression @@happy-path
  Scenario: Dokument erfolgreich senden
    # Happy Path: Ein gültiges Dokument wird an einen Empfänger gesendet und bestätigt
    Given der Benutzer hat ein gültiges Dokument ausgewählt
    And ein gültiger Empfänger ist angegeben
    When der Benutzer das Senden des Dokuments auslöst
    Then wird das Dokument erfolgreich an den Empfänger gesendet
    And es wird eine Bestätigung angezeigt

  @@regression @@negative
  Scenario: Dokument senden ohne Empfänger
    # Fehlerfall: Senden ohne Empfänger wird verhindert und eine Fehlermeldung angezeigt
    Given der Benutzer hat ein gültiges Dokument ausgewählt
    And kein Empfänger ist angegeben
    When der Benutzer das Senden des Dokuments auslöst
    Then wird das Senden verhindert
    And eine verständliche Fehlermeldung wird angezeigt

  @@regression @@negative
  Scenario: Nicht unterstützte oder beschädigte Datei senden
    # Fehlerfall: Das System lehnt nicht unterstützte oder beschädigte Dateien ab
    Given der Benutzer hat eine Datei ausgewählt, die nicht unterstützt oder beschädigt ist
    And ein gültiger Empfänger ist angegeben
    When der Benutzer das Senden des Dokuments auslöst
    Then wird das Senden abgelehnt
    And ein Hinweis zur Datei wird angezeigt

  @@regression @@edge-case
  Scenario Outline: Dokument senden mit Empfängergrenzen
    # Boundary: Senden mit minimaler und maximaler Empfängerlänge wird korrekt verarbeitet
    Given der Benutzer hat ein gültiges Dokument ausgewählt
    And ein Empfänger mit einer Länge von "<laenge>" Zeichen ist angegeben
    When der Benutzer das Senden des Dokuments auslöst
    Then wird das Senden entsprechend der Validierungsregeln akzeptiert oder abgelehnt
    And es wird eine Bestätigung oder eine Fehlermeldung angezeigt

    Examples:
      | laenge | ergebnis |
      | 1 | akzeptiert |
      | 255 | akzeptiert |
      | 256 | abgelehnt |

  @@regression @@edge-case
  Scenario Outline: Dokument senden mit Dateigrößen-Grenzen
    # Boundary: Senden mit minimaler und maximaler Dateigröße wird korrekt verarbeitet
    Given der Benutzer hat ein gültiges Dokument mit Dateigröße "<groesse>" ausgewählt
    And ein gültiger Empfänger ist angegeben
    When der Benutzer das Senden des Dokuments auslöst
    Then wird das Senden entsprechend der Dateigrößen-Regeln akzeptiert oder abgelehnt
    And eine passende Bestätigung oder Fehlermeldung wird angezeigt

    Examples:
      | groesse | ergebnis |
      | 1KB | akzeptiert |
      | 10MB | akzeptiert |
      | 10MB+1B | abgelehnt |

  @@regression @@edge-case
  Scenario: Mehrere Empfänger angeben
    # Edge Case: Mehrere Empfänger werden angegeben und das Dokument wird an alle gesendet
    Given der Benutzer hat ein gültiges Dokument ausgewählt
    And mehrere gültige Empfänger sind angegeben
    When der Benutzer das Senden des Dokuments auslöst
    Then wird das Dokument an alle Empfänger gesendet
    And eine Bestätigung für den Versand wird angezeigt
