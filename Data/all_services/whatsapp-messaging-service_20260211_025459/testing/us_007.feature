@@smoke @@regression
Feature: Anzeigename verwalten
  As a Business-Nutzer
  I want to einen konfigurierbaren Anzeigenamen für mein Profil festlegen und aktualisieren
  So that damit ich professionell kommuniziere und meine Identität klar erkennbar ist

  Background:
    Given der Business-Nutzer ist im Profilbereich angemeldet

  @@smoke @@regression @@happy-path
  Scenario: Anzeigename erfolgreich speichern und anzeigen
    # Happy Path: gültiger Anzeigename wird gespeichert und angezeigt
    When er einen gültigen Anzeigenamen eingibt
    And er die Änderungen speichert
    Then wird der Anzeigename gespeichert
    And der Anzeigename wird in der Oberfläche angezeigt

  @@regression @@boundary
  Scenario Outline: Anzeigename am Zeichenlimit speichern
    # Boundary Condition: Anzeigename mit maximal erlaubter Länge wird akzeptiert
    Given die maximale Länge für den Anzeigenamen ist <max_length> Zeichen
    When er einen Anzeigenamen mit genau <max_length> Zeichen eingibt
    And er die Änderungen speichert
    Then wird der Anzeigename gespeichert
    And der Anzeigename wird in der Oberfläche angezeigt

    Examples:
      | max_length |
      | 50 |

  @@regression @@negative
  Scenario Outline: Leerer oder nur aus Leerzeichen bestehender Anzeigename
    # Error Scenario: Eingabe ist leer oder besteht nur aus Leerzeichen
    When er einen Anzeigenamen <input_value> eingibt
    And er die Änderungen speichert
    Then wird eine Validierungsfehlermeldung angezeigt
    And der Anzeigename wird nicht gespeichert

    Examples:
      | input_value |
      |  |
      |     |

  @@regression @@negative @@boundary
  Scenario Outline: Anzeigename überschreitet maximale Zeichenlänge
    # Error Scenario: Anzeigename ist länger als erlaubt
    Given die maximale Länge für den Anzeigenamen ist <max_length> Zeichen
    When er einen Anzeigenamen mit <max_length_plus_one> Zeichen eingibt
    And er die Änderungen speichert
    Then wird eine Fehlermeldung angezeigt
    And der Anzeigename wird nicht gespeichert

    Examples:
      | max_length | max_length_plus_one |
      | 50 | 51 |
