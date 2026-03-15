@@smoke @@regression
Feature: Schnellantworten verwalten und in Chats verwenden
  As a Business-Admin
  I want to vordefinierte Schnellantworten erstellen und in Chats auswaehlen
  So that Kundenanfragen schneller, konsistenter und professionell beantworten zu koennen

  Background:
    Given der Business-Admin ist angemeldet und hat Zugriffsrechte auf die Nachrichtenverwaltung

  @@smoke @@happy-path
  Scenario: Schnellantwort erstellen und in der Liste anzeigen
    # Prueft das erfolgreiche Speichern und Anzeigen einer Schnellantwort
    Given der Business-Admin befindet sich in der Schnellantworten-Verwaltung
    When er eine neue Schnellantwort mit Titel "Rueckruf" und Text "Wir melden uns in Kuerze" speichert
    Then wird die Schnellantwort in der Liste der Schnellantworten angezeigt
    And die Schnellantwort kann in einem Chat eingefuegt werden

  @@regression @@happy-path
  Scenario: Schnellantwort in Chat einfuegen und bearbeiten
    # Prueft das Einfuegen des Textes in das Nachrichtenfeld und die Bearbeitbarkeit vor dem Senden
    Given der Business-Admin hat einen Chat mit einem Kunden geoeffnet
    When er die Schnellantworten-Liste oeffnet und die Schnellantwort "Rueckruf" auswaehlt
    Then wird der zugehoerige Text in das Nachrichtenfeld eingefuegt
    And der Text kann vor dem Senden bearbeitet werden

  @@negative @@regression
  Scenario Outline: Validierung bei fehlenden Pflichtfeldern beim Speichern
    # Prueft Validierungsfehler fuer fehlenden Titel oder Text
    Given der Business-Admin befindet sich in der Schnellantworten-Verwaltung
    When er versucht eine Schnellantwort mit Titel "<title>" und Text "<text>" zu speichern
    Then wird eine Validierungsfehlermeldung angezeigt
    And die Schnellantwort wird nicht gespeichert

    Examples:
      | title | text |
      |  | Wir melden uns in Kuerze |
      | Rueckruf |  |
      |  |  |

  @@edge @@regression
  Scenario Outline: Grenzwerte fuer Titel- und Textlaenge
    # Prueft das Speichern von Schnellantworten an den Laengen-Grenzen
    Given der Business-Admin befindet sich in der Schnellantworten-Verwaltung
    When er eine Schnellantwort mit Titel der Laenge <title_length> und Text der Laenge <text_length> speichert
    Then wird die Schnellantwort gespeichert und in der Liste angezeigt
    And der gespeicherte Titel und Text entsprechen den eingegebenen Werten

    Examples:
      | title_length | text_length |
      | 1 | 1 |
      | 100 | 1000 |
