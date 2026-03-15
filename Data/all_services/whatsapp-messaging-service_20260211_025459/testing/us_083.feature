@smoke @regression
Feature: Info-Sichtbarkeit konfigurieren
  As a Shop-Admin
  I want to die Sichtbarkeit von Info- und Status-Texten konfigurierbar festlegen
  So that damit Kommunikation konsistent, datenschutzkonform und kundenorientiert erfolgt

  Background:
    Given der Shop-Admin ist authentifiziert und befindet sich in den Einstellungen fuer Info/Status-Texte

  @happy-path @smoke @regression
  Scenario: Sichtbarkeit auf sichtbar setzen und anzeigen
    # Happy path: Ein Text wird als sichtbar gespeichert und in der UI angezeigt
    Given ein Info-Text fuer die Zielgruppe Kunden existiert
    When der Shop-Admin die Sichtbarkeit auf "sichtbar" setzt und speichert
    Then wird der Text in der Benutzeroberflaeche fuer Kunden angezeigt
    And die Einstellung wird im System persistiert

  @happy-path @regression
  Scenario: Sichtbarkeit auf unsichtbar setzen und nicht anzeigen
    # Happy path: Ein Text wird als unsichtbar konfiguriert und erscheint nicht
    Given ein Status-Text fuer die Zielgruppe Kunden existiert
    When der Shop-Admin die Sichtbarkeit auf "unsichtbar" setzt und speichert
    Then wird der Text in der Benutzeroberflaeche fuer Kunden nicht angezeigt
    And die Einstellung wird im System persistiert

  @negative @regression
  Scenario: Ungueltige Sichtbarkeitsoption verhindern
    # Error: Eine ungueltige Sichtbarkeitsoption darf nicht gespeichert werden
    Given ein Info-Text existiert
    When der Shop-Admin eine ungueltige Sichtbarkeitsoption eingibt und speichert
    Then wird eine Fehlermeldung angezeigt
    And die Aenderung wird nicht uebernommen

  @edge @regression
  Scenario: Sichtbarkeit umschalten und konsistent anzeigen
    # Edge case: Umschalten der Sichtbarkeit von sichtbar auf unsichtbar und umgekehrt
    Given ein Info-Text ist aktuell auf "sichtbar" gesetzt
    When der Shop-Admin die Sichtbarkeit auf "unsichtbar" aendert und speichert
    Then wird der Text in der Benutzeroberflaeche nicht angezeigt
    And nach erneutem Setzen auf "sichtbar" wird der Text angezeigt

  @boundary @regression
  Scenario: Sichtbarkeit nur fuer definierte Zielgruppe pruefen
    # Boundary: Text wird nur fuer die konfigurierte Zielgruppe angezeigt
    Given ein Info-Text ist fuer die Zielgruppe "Kunden" konfiguriert
    When ein Endnutzer in der Zielgruppe "Gaeste" die Ansicht oeffnet
    Then wird der Text nicht angezeigt
    And ein Endnutzer in der Zielgruppe "Kunden" sieht den Text

  @regression
  Scenario Outline: Gueltige Sichtbarkeitsoptionen speichern
    # Data-driven: Nur erlaubte Sichtbarkeitswerte werden akzeptiert
    Given ein Status-Text existiert
    When der Shop-Admin die Sichtbarkeit auf "<option>" setzt und speichert
    Then wird die Einstellung akzeptiert
    And das UI verhaelt sich gemaess der Sichtbarkeit

    Examples:
      | option |
      | sichtbar |
      | unsichtbar |

  @negative @regression
  Scenario Outline: Ungueltige Sichtbarkeitsoptionen blockieren
    # Data-driven error: Unerlaubte Werte werden abgelehnt
    Given ein Info-Text existiert
    When der Shop-Admin die Sichtbarkeit auf "<option>" setzt und speichert
    Then wird eine Fehlermeldung angezeigt
    And die Aenderung wird nicht uebernommen

    Examples:
      | option |
      |  |
      | hidden |
      | SICHTBAR |
      | null |
