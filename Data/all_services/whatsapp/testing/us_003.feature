@@smoke @@regression
Feature: Biometrische Entsperrung
  As a registrierter Benutzer
  I want to mich per Fingerabdruck oder Face ID entsperren
  So that um mich schneller und sicherer anzumelden, ohne mein Passwort eingeben zu muessen

  Background:
    Given der Benutzer ist registriert und die App ist installiert

  @@smoke @@regression @@happy-path
  Scenario Outline: Biometrische Entsperrung erfolgreich
    # Validiert die erfolgreiche Anmeldung mit Fingerabdruck oder Face ID
    Given biometrische Entsperrung ist in der App aktiviert
    And Biometrie ist auf dem Geraet eingerichtet
    When der Benutzer die App oeffnet
    Then wird der Benutzer per <biometrie_typ> authentifiziert
    And der Benutzer erhaelt Zugang zur App

    Examples:
      | biometrie_typ |
      | Fingerabdruck |
      | Face ID |

  @@regression @@negative @@error
  Scenario Outline: Biometrische Pruefung fehlschlaegt und Passwort oder PIN wird angeboten
    # Stellt sicher, dass bei fehlgeschlagener Biometrie die alternative Anmeldung angeboten wird
    Given biometrische Entsperrung ist in der App aktiviert
    And Biometrie ist auf dem Geraet eingerichtet
    When die biometrische Pruefung fehlschlaegt
    Then wird die Anmeldung mit <alternative> angeboten
    And der Benutzer kann sich mit <alternative> anmelden

    Examples:
      | alternative |
      | Passwort |
      | PIN |

  @@regression @@edge
  Scenario Outline: Geraet unterstuetzt keine Biometrie oder Biometrie ist nicht eingerichtet
    # Prueft, dass die biometrische Option nicht angeboten wird, wenn sie nicht verfuegbar ist
    Given biometrische Entsperrung ist in der App aktiviert
    And das Geraet hat den Status <biometrie_status>
    When der Benutzer die Entsperrung versucht
    Then wird die biometrische Option nicht angeboten
    And der Benutzer kann sich mit Passwort oder PIN anmelden

    Examples:
      | biometrie_status |
      | keine Biometrie-Unterstuetzung |
      | Biometrie nicht eingerichtet |

  @@regression @@negative @@boundary
  Scenario Outline: Mehrere fehlgeschlagene Biometrieversuche erzwingen alternative Anmeldung
    # Boundary-Test fuer maximale fehlgeschlagene Versuche vor dem Wechsel auf Passwort oder PIN
    Given biometrische Entsperrung ist in der App aktiviert
    And Biometrie ist auf dem Geraet eingerichtet
    When die biometrische Pruefung <anzahl> Mal hintereinander fehlschlaegt
    Then wird die biometrische Anmeldung gesperrt
    And die Anmeldung mit Passwort oder PIN wird angeboten

    Examples:
      | anzahl |
      | 3 |
      | 5 |
