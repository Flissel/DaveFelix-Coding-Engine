@@smoke @@regression
Feature: Textnachricht senden
  As a registrierter Nutzer
  I want to eine Textnachricht in Echtzeit senden
  So that um schnell und zuverlässig mit Kontakten zu kommunizieren

  Background:
    Given der Nutzer ist registriert und angemeldet

  @@smoke @@regression @@happy-path
  Scenario: Echtzeitversand bei stabiler Verbindung
    # Prüft den erfolgreichen Versand und die gesendet-Bestätigung in Echtzeit
    Given eine stabile Internetverbindung ist vorhanden
    And ein gültiger Kontakt ist ausgewählt
    When der Nutzer eine Textnachricht sendet
    Then wird die Nachricht in Echtzeit zugestellt
    And die Nachricht wird als "gesendet" bestätigt

  @@regression @@edge-case
  Scenario: Automatischer Versand nach kurzfristiger Unterbrechung
    # Prüft ausstehend-Markierung und automatisches Senden nach Wiederherstellung der Verbindung
    Given die Internetverbindung ist kurzzeitig unterbrochen
    And ein gültiger Kontakt ist ausgewählt
    When der Nutzer eine Textnachricht sendet
    Then wird die Nachricht als "ausstehend" markiert
    And die Nachricht wird automatisch gesendet, sobald die Verbindung wiederhergestellt ist

  @@regression @@negative @@error
  Scenario: Fehlermeldung bei ungültiger Empfängernummer
    # Prüft verständliche Fehlermeldung und keine Zustellung bei ungültiger Nummer
    Given die Empfängernummer ist ungültig
    When der Nutzer eine Textnachricht sendet
    Then erhält der Nutzer eine verständliche Fehlermeldung
    And die Nachricht wird nicht zugestellt

  @@regression @@boundary
  Scenario Outline: Grenzwerte für Nachrichtenlänge
    # Prüft Verhalten an der maximal erlaubten Nachrichtenlänge
    Given eine stabile Internetverbindung ist vorhanden
    And ein gültiger Kontakt ist ausgewählt
    When der Nutzer eine Textnachricht mit der Länge <laenge> sendet
    Then wird die Nachricht gemäß den Längenregeln verarbeitet
    And der Nutzer erhält eine passende Statusmeldung

    Examples:
      | laenge |
      | 0 Zeichen |
      | 1 Zeichen |
      | maximal erlaubte Zeichenanzahl |
      | maximal erlaubte Zeichenanzahl + 1 |
