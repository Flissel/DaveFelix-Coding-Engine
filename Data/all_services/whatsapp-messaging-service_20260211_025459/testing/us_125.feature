@@smoke @@regression
Feature: Regionale Formate
  As a Endnutzer
  I want to Datums-, Zeit- und Zahlenformate in den regionalen Einstellungen anzeigen lassen
  So that damit Informationen intuitiv lesbar sind und Eingaben korrekt verarbeitet werden

  Background:
    Given die Anwendung ist geöffnet

  @@smoke @@regression @@happy-path
  Scenario: DE-Region zeigt deutsche Datums-, Zeit- und Zahlenformate
    # Happy path für Deutschland-Formatierung
    Given die Region des Geräts ist auf Deutschland eingestellt
    When eine Nachricht mit Datum, Uhrzeit und Betrag angezeigt wird
    Then wird das Datum im Format TT.MM.JJJJ angezeigt
    And wird die Uhrzeit im 24-Stunden-Format angezeigt
    And wird der Betrag mit Dezimaltrennzeichen "," angezeigt

  @@regression @@happy-path
  Scenario: US-Region zeigt US Datums-, Zeit- und Zahlenformate
    # Happy path für USA-Formatierung
    Given die Region des Geräts wird auf USA umgestellt
    When eine Nachricht mit Datum, Uhrzeit und Betrag angezeigt wird
    Then wird das Datum im Format MM/DD/YYYY angezeigt
    And wird die Uhrzeit im 12-Stunden-Format mit AM/PM angezeigt
    And wird der Betrag mit Dezimaltrennzeichen "." angezeigt

  @@regression @@negative
  Scenario: Nicht unterstützte Region verwendet Standardformat und Hinweis
    # Error scenario wenn Region nicht unterstützt wird
    Given eine nicht unterstützte Region ist eingestellt
    When eine Nachricht mit Datums-, Zeit- oder Zahlenformaten angezeigt wird
    Then verwendet das System ein definiertes Standardformat
    And wird eine Information zur verwendeten Region angezeigt

  @@regression
  Scenario Outline: Regionen-abhängige Formatierung für mehrere Eingaben
    # Scenario Outline für Datengetriebene Formatvalidierung
    Given die Region des Geräts ist auf <region> eingestellt
    When eine Nachricht mit Datum <date>, Uhrzeit <time> und Betrag <amount> angezeigt wird
    Then entspricht das Datumsformat <date_format>
    And entspricht das Zeitformat <time_format>
    And entspricht das Dezimaltrennzeichen <decimal_separator>

    Examples:
      | region | date | time | amount | date_format | time_format | decimal_separator |
      | Deutschland | 2024-01-05 | 13:45 | 1234.50 | TT.MM.JJJJ | 24h | , |
      | USA | 2024-01-05 | 13:45 | 1234.50 | MM/DD/YYYY | 12h AM/PM | . |

  @@regression @@boundary
  Scenario Outline: Grenzwerte für Zeit und Datum werden korrekt formatiert
    # Boundary conditions für Tageswechsel und Monatswechsel
    Given die Region des Geräts ist auf <region> eingestellt
    When eine Nachricht mit Datum <date> und Uhrzeit <time> angezeigt wird
    Then wird das Datum gemäß <date_format> formatiert
    And wird die Uhrzeit gemäß <time_format> formatiert

    Examples:
      | region | date | time | date_format | time_format |
      | Deutschland | 2024-12-31 | 00:00 | TT.MM.JJJJ | 24h |
      | USA | 2024-01-01 | 23:59 | MM/DD/YYYY | 12h AM/PM |
