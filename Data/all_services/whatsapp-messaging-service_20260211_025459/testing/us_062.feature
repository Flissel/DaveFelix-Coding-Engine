@smoke @regression
Feature: Zwei-Schritte-Verifizierung (PIN-Sicherung)
  As a registrierter Nutzer
  I want to die optionale zusätzliche PIN-Sicherung für mein Konto aktivieren und verwenden
  So that damit mein Konto durch einen zweiten Sicherheitsfaktor besser geschützt ist

  Background:
    Given der Nutzer ist registriert und besitzt gültige Zugangsdaten

  @@smoke @@regression @@happy-path
  Scenario: Aktivierung der PIN-Sicherung und Abfrage bei späterer Anmeldung
    # Happy Path: PIN-Sicherung wird aktiviert und bei zukünftiger Anmeldung abgefragt
    Given der Nutzer ist angemeldet und befindet sich in den Sicherheitseinstellungen
    When der Nutzer aktiviert die PIN-Sicherung und legt eine gültige PIN fest
    Then die PIN-Sicherung wird aktiviert
    And bei der nächsten Anmeldung wird die PIN abgefragt

  @@regression @@happy-path
  Scenario: PIN-Sicherung deaktivieren
    # Happy Path: Deaktivierung bestätigt und keine PIN-Abfrage mehr
    Given die PIN-Sicherung ist aktiviert und der Nutzer ist in den Sicherheitseinstellungen
    When der Nutzer deaktiviert die PIN-Sicherung
    Then die Deaktivierung wird bestätigt
    And bei zukünftigen Anmeldungen wird keine PIN mehr abgefragt

  @@regression @@negative @@error
  Scenario: Falsche PIN bei Anmeldung
    # Error Scenario: Zugriff wird verweigert und Fehlermeldung angezeigt
    Given die PIN-Sicherung ist aktiviert
    When der Nutzer meldet sich an und gibt eine falsche PIN ein
    Then der Zugriff wird verweigert
    And eine Fehlermeldung wird angezeigt

  @@regression @@edge @@boundary
  Scenario Outline: Gültige PIN-Formate bei Aktivierung
    # Boundary/Edge: verschiedene gültige PIN-Formate akzeptieren
    Given der Nutzer ist angemeldet und befindet sich in den Sicherheitseinstellungen
    When der Nutzer aktiviert die PIN-Sicherung mit PIN "<pin>"
    Then die PIN-Sicherung wird aktiviert
    And bei der nächsten Anmeldung wird die PIN abgefragt

    Examples:
      | pin |
      | 0000 |
      | 1234 |
      | 9876 |

  @@regression @@negative @@boundary
  Scenario Outline: Ungültige PIN-Formate bei Aktivierung
    # Error/Boundary: ungültige PIN-Längen oder Zeichen werden abgelehnt
    Given der Nutzer ist angemeldet und befindet sich in den Sicherheitseinstellungen
    When der Nutzer versucht die PIN-Sicherung mit PIN "<pin>" zu aktivieren
    Then die PIN-Sicherung wird nicht aktiviert
    And eine Validierungsfehlermeldung wird angezeigt

    Examples:
      | pin |
      | 12 |
      | 12345 |
      | 12a4 |
      |      |

  @@regression @@edge
  Scenario: PIN-Abfrage bei Anmeldung nach Aktivierung
    # Edge Case: PIN-Abfrage erscheint nur wenn aktiviert
    Given die PIN-Sicherung ist aktiviert
    When der Nutzer meldet sich mit korrekten Zugangsdaten an
    Then die PIN-Abfrage wird angezeigt
    And der Nutzer wird erst nach korrekter PIN weitergeleitet
