@@smoke @@regression
Feature: Bilder senden
  As a Endnutzer
  I want to Bilder in einer Nachricht senden
  So that damit ich Informationen visuell teilen und eine schnelle, intuitive Kommunikation ermoeglichen kann

  Background:
    Given der Nutzer ist angemeldet und befindet sich in einem Chat

  @@smoke @@regression @@happy-path
  Scenario: Erfolgreiches Senden eines unterstuetzten Bildes
    # Prueft den Happy Path fuer das Senden eines unterstuetzten Bildformats
    Given ein unterstuetztes Bild ist ausgewaehlt
    When der Nutzer auf Senden tippt
    Then das Bild wird erfolgreich uebermittelt
    And das Bild erscheint im Chat mit Zustellbestaetigung

  @@regression @@negative
  Scenario: Nicht unterstuetztes Bildformat wird abgelehnt
    # Prueft die Fehlermeldung bei nicht unterstuetzten Dateiformaten
    Given ein nicht unterstuetztes Bildformat ist ausgewaehlt
    When der Nutzer auf Senden tippt
    Then eine klare Fehlermeldung wird angezeigt
    And das Bild wird nicht gesendet

  @@regression @@negative @@boundary
  Scenario: Zu grosses Bild wird abgelehnt
    # Prueft die Fehlermeldung bei ueber der maximalen Dateigroesse
    Given ein Bild groesser als die maximale Dateigroesse ist ausgewaehlt
    When der Nutzer auf Senden tippt
    Then eine klare Fehlermeldung wird angezeigt
    And das Bild wird nicht gesendet

  @@regression @@negative
  Scenario: Versand scheitert bei instabiler oder getrennter Verbindung
    # Prueft das Verhalten bei Versandfehlern durch Netzwerkprobleme
    Given die Internetverbindung ist instabil oder getrennt
    When der Nutzer ein Bild sendet
    Then der Versand wird als fehlgeschlagen markiert
    And eine Option zum erneuten Senden wird angeboten

  @@regression @@happy-path
  Scenario Outline: Unterstuetzte Formate und Groessen als Szenario-Outline
    # Datengetriebene Pruefung von unterstuetzten Formaten innerhalb der Groessengrenze
    Given ein Bild mit Format <format> und Groesse <size_mb> MB ist ausgewaehlt
    When der Nutzer auf Senden tippt
    Then das Bild wird erfolgreich uebermittelt
    And das Bild erscheint im Chat mit Zustellbestaetigung

    Examples:
      | format | size_mb |
      | JPG | 1 |
      | PNG | 3 |
      | GIF | 5 |

  @@regression @@boundary
  Scenario Outline: Grenzwerte fuer maximale Dateigroesse
    # Boundary-Test fuer die maximale erlaubte Groesse
    Given ein Bild mit Groesse <size_mb> MB ist ausgewaehlt
    When der Nutzer auf Senden tippt
    Then das Ergebnis entspricht <expected_result>
    And der Chat zeigt <ui_state>

    Examples:
      | size_mb | expected_result | ui_state |
      | 9.9 | erfolgreicher Versand | Zustellbestaetigung |
      | 10.0 | erfolgreicher Versand | Zustellbestaetigung |
      | 10.1 | Fehlermeldung | kein gesendetes Bild |
