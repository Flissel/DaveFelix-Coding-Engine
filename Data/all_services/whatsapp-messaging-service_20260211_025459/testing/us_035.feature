@smoke @regression
Feature: Sprachanruf
  As a Endnutzer
  I want to einen Sprachanruf innerhalb der App starten und durchgehend verschluesselt fuehren
  So that damit meine Kommunikation sicher bleibt und ich plattformuebergreifend zuverlaessig telefonieren kann

  Background:
    Given der Endnutzer ist in der App eingeloggt
    And der Kontakt ist in der Kontaktliste des Endnutzers vorhanden

  @@smoke @@regression @@happy-path
  Scenario: Verschluesselter Sprachanruf innerhalb derselben Plattform
    # Erfolgreicher Anrufaufbau mit durchgehender Verschluesselung
    Given der Endnutzer und der Kontakt sind online und haben die App installiert
    When der Endnutzer startet einen Sprachanruf
    Then der Anruf wird erfolgreich aufgebaut
    And die Verbindung ist waehrend des gesamten Gespraechs verschluesselt

  @@regression @@happy-path
  Scenario: Plattformuebergreifender verschluesselter Sprachanruf
    # Erfolgreicher Anrufaufbau zwischen unterschiedlichen Plattformen
    Given der Endnutzer startet einen Sprachanruf zu einem Kontakt auf einer anderen Plattform
    When die Verbindung hergestellt wird
    Then der Anruf ist erfolgreich
    And die Verbindung bleibt verschluesselt

  @@regression @@negative @@error
  Scenario: Instabile Netzwerkverbindung verhindert unverschluesselten Anruf
    # Fehlermeldung bei instabiler Verbindung ohne unverschluesselten Verbindungsaufbau
    Given die Netzwerkverbindung des Endnutzers ist instabil
    When der Endnutzer startet einen Sprachanruf
    Then der Endnutzer erhaelt eine klare Fehlermeldung
    And der Anruf wird nicht unverschluesselt aufgebaut

  @@regression @@boundary
  Scenario: Verbindungsaufbau bei grenzwertiger Netzwerkqualitaet
    # Boundary-Test fuer minimale akzeptable Netzwerkparameter mit erzwungener Verschluesselung
    Given die Netzwerkqualitaet liegt bei minimal akzeptablen Werten
    When der Endnutzer startet einen Sprachanruf
    Then der Anruf wird nur bei erfolgreichem Verschluesselungshandshake aufgebaut
    And bei Scheitern des Handshakes wird eine klare Fehlermeldung angezeigt

  @@regression @@edge
  Scenario Outline: Scenario Outline: Plattformuebergreifender Anruf mit unterschiedlichen Geraeten
    # Datengetriebener Test fuer verschiedene Plattformkombinationen
    Given der Endnutzer nutzt die Plattform <caller_platform> und der Kontakt nutzt <callee_platform>
    And beide Nutzer sind online und haben die App installiert
    When der Endnutzer startet einen Sprachanruf
    Then der Anruf wird erfolgreich aufgebaut
    And die Verbindung ist durchgehend verschluesselt

    Examples:
      | caller_platform | callee_platform |
      | iOS | Android |
      | Android | Web |
      | Web | iOS |
