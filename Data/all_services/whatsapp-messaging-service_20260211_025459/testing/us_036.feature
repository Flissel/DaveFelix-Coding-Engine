@@smoke @@regression
Feature: Videoanruf
  As a Endnutzer
  I want to verschluesselte Videoanrufe starten und empfangen
  So that um sicher und datenschutzkonform in hoher Qualität kommunizieren zu koennen

  Background:
    Given der Endnutzer ist in der App angemeldet

  @@smoke @@regression @@happy-path
  Scenario: Erfolgreicher ausgehender verschluesselter Videoanruf
    # Happy path fuer das Starten eines verschluesselten Videoanrufs bei stabiler Verbindung
    Given der Endnutzer hat eine stabile Internetverbindung
    And der Zielnutzer ist erreichbar und online
    When der Endnutzer einen Videoanruf mit dem Zielnutzer startet
    Then wird der Anruf erfolgreich aufgebaut
    And die Verbindung ist Ende-zu-Ende verschluesselt

  @@regression @@happy-path
  Scenario: Eingehender Videoanruf wird innerhalb von 3 Sekunden gestartet
    # Happy path fuer das Annehmen eines eingehenden Anrufs mit aktivierter Verschluesselung
    Given der Endnutzer erhaelt einen eingehenden Videoanruf
    When der Endnutzer den Anruf annimmt
    Then startet der Videoanruf innerhalb von 3 Sekunden
    And die Verschluesselung ist aktiv

  @@regression @@negative
  Scenario: Schwache oder unterbrochene Internetverbindung beendet den Anruf sicher
    # Error scenario fuer Verbindungsprobleme beim Starten oder Fortsetzen
    Given die Internetverbindung ist zu schwach oder unterbrochen
    When der Endnutzer einen Videoanruf startet oder fortsetzt
    Then erhaelt der Endnutzer eine Fehlermeldung
    And der Anruf wird sicher beendet, ohne unverschluesselte Daten zu uebertragen

  @@regression @@boundary
  Scenario: Videoanruf Startzeit an der 3-Sekunden-Grenze
    # Boundary condition fuer die Startzeit eines eingehenden Anrufs
    Given der Endnutzer erhaelt einen eingehenden Videoanruf
    When der Endnutzer den Anruf annimmt
    Then startet der Videoanruf in genau 3 Sekunden
    And die Verschluesselung ist aktiv

  @@regression @@edge
  Scenario: Videoanruf Aufbau bei minimal stabiler Bandbreite
    # Edge case fuer Aufbau des Anrufs bei minimaler stabiler Verbindung
    Given der Endnutzer hat eine stabile Verbindung mit minimal akzeptierter Bandbreite
    And der Zielnutzer ist erreichbar und online
    When der Endnutzer einen Videoanruf mit dem Zielnutzer startet
    Then wird der Anruf erfolgreich aufgebaut
    And die Verbindung ist Ende-zu-Ende verschluesselt

  @@regression @@outline
  Scenario Outline: Datengetriebene Verbindungsqualitaet beim Anrufstart
    # Scenario outline fuer verschiedene Verbindungsqualitaeten beim Starten eines Anrufs
    Given der Endnutzer hat eine <verbindungsqualitaet> Internetverbindung
    And der Zielnutzer ist erreichbar und online
    When der Endnutzer einen Videoanruf mit dem Zielnutzer startet
    Then <erwartetes_ergebnis>
    And <verschluesselungsstatus>

    Examples:
      | verbindungsqualitaet | erwartetes_ergebnis | verschluesselungsstatus |
      | stabile | wird der Anruf erfolgreich aufgebaut | die Verbindung ist Ende-zu-Ende verschluesselt |
      | zu schwache | erhaelt der Endnutzer eine Fehlermeldung | der Anruf wird sicher beendet, ohne unverschluesselte Daten zu uebertragen |

  @@regression @@outline @@boundary
  Scenario Outline: Datengetriebene Startzeit fuer eingehenden Anruf
    # Scenario outline fuer Startzeitgrenzen bei eingehenden Anrufen
    Given der Endnutzer erhaelt einen eingehenden Videoanruf
    When der Endnutzer den Anruf annimmt
    Then startet der Videoanruf in <startzeit> Sekunden
    And <verschluesselungsstatus>

    Examples:
      | startzeit | verschluesselungsstatus |
      | 2.5 | die Verschluesselung ist aktiv |
      | 3.0 | die Verschluesselung ist aktiv |
