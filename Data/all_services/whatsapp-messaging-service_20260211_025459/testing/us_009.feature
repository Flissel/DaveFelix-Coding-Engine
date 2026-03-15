@@smoke @@regression
Feature: Telefonnummer im Profil anzeigen
  As a Endnutzer
  I want to die Telefonnummer im Profil anzeigen lassen
  So that die Kontaktaufnahme zu erleichtern und eine zuverlaessige Kommunikation zu ermoeglichen

  Background:
    Given der Endnutzer ist angemeldet
    And das Profil kann aufgerufen werden

  @@smoke @@regression @@happy-path
  Scenario Outline: Telefonnummer wird im Profil angezeigt
    # Validiert die Anzeige einer hinterlegten Telefonnummer
    Given der Nutzer hat die Telefonnummer "<phone_number>" im Profil hinterlegt
    When das Profil angezeigt wird
    Then wird die Telefonnummer im Profil sichtbar dargestellt
    And die Telefonnummer entspricht exakt dem hinterlegten Wert

    Examples:
      | phone_number |
      | +49 170 1234567 |
      | 0049 30 123456 |

  @@regression @@edge-case @@negative
  Scenario: Kein Telefonnummernfeld bei fehlender Telefonnummer
    # Validiert das Verhalten wenn keine Telefonnummer hinterlegt ist
    Given der Nutzer hat keine Telefonnummer im Profil hinterlegt
    When das Profil angezeigt wird
    Then wird kein Telefonnummernfeld angezeigt oder es erscheint ein Hinweis, dass keine Telefonnummer vorhanden ist
    And alle anderen Profildaten sind sichtbar

  @@regression @@boundary
  Scenario Outline: Grenzwerte der Telefonnummernlaenge werden korrekt angezeigt
    # Prueft minimale und maximale Laenge einer gueltig gespeicherten Telefonnummer
    Given der Nutzer hat die Telefonnummer "<phone_number>" im Profil hinterlegt
    When das Profil angezeigt wird
    Then wird die Telefonnummer im Profil sichtbar dargestellt
    And die Anzeige akzeptiert die Laenge "<length_type>"

    Examples:
      | phone_number | length_type |
      | 12345 | minimal |
      | +49 170 123456789012 | maximal |

  @@regression @@negative @@error
  Scenario: Technischer Fehler beim Laden der Telefonnummer
    # Validiert die benutzerfreundliche Fehlermeldung bei Ladefehler
    Given das System kann die Telefonnummer aufgrund eines technischen Fehlers nicht laden
    When das Profil angezeigt wird
    Then wird eine benutzerfreundliche Fehlermeldung angezeigt
    And die uebrigen Profildaten bleiben sichtbar
