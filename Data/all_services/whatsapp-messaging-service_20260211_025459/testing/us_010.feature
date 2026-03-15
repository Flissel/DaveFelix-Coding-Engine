@smoke @regression
Feature: QR-Code Profil
  As a Business-Profilinhaber
  I want to einen scanbaren QR-Code für mein Profil generieren und anzeigen
  So that damit Kunden mich schnell und plattformübergreifend hinzufügen können

  Background:
    Given der Nutzer ist in der App angemeldet

  @@smoke @@regression @@happy-path
  Scenario: QR-Code für verifiziertes Profil generieren und anzeigen
    # Erfolgreiche Generierung und Anzeige eines QR-Codes für ein verifiziertes Profil
    Given ein verifiziertes Business-Profil ist vorhanden und aktiv
    When der Nutzer die Funktion „QR-Code generieren“ aufruft
    Then wird ein scanbarer QR-Code erstellt
    And der QR-Code wird auf dem Bildschirm angezeigt

  @@regression @@happy-path
  Scenario: QR-Code Scan öffnet korrektes Profil
    # Ein gescannter QR-Code öffnet das korrekte Profil und ermöglicht das Hinzufügen
    Given ein QR-Code wurde für ein verifiziertes Business-Profil generiert
    When ein Kunde den QR-Code mit einem mobilen Gerät scannt
    Then öffnet sich das korrekte Business-Profil
    And der Kunde kann den Nutzer hinzufügen

  @@negative @@regression
  Scenario: Fehlermeldung wenn kein Profil vorhanden ist
    # Verhindert QR-Code-Generierung ohne vorhandenes Profil
    Given kein Business-Profil ist vorhanden
    When der Nutzer die Funktion „QR-Code generieren“ aufruft
    Then erhält der Nutzer eine verständliche Fehlermeldung
    And es wird kein QR-Code erstellt

  @@negative @@regression
  Scenario: Fehlermeldung wenn Profil deaktiviert ist
    # Verhindert QR-Code-Generierung für deaktivierte Profile
    Given ein Business-Profil ist vorhanden aber deaktiviert
    When der Nutzer die Funktion „QR-Code generieren“ aufruft
    Then erhält der Nutzer eine verständliche Fehlermeldung
    And es wird kein QR-Code erstellt

  @@regression @@negative
  Scenario Outline: QR-Code Generierung bei unterschiedlichen Profilzuständen
    # Datengetriebene Prüfung für gültige und ungültige Profilzustände
    Given ein Business-Profil ist <profil_status>
    When der Nutzer die Funktion „QR-Code generieren“ aufruft
    Then <erwartetes_ergebnis>
    And <zusatz_pruefung>

    Examples:
      | profil_status | erwartetes_ergebnis | zusatz_pruefung |
      | vorhanden und verifiziert | wird ein scanbarer QR-Code erstellt | der QR-Code wird auf dem Bildschirm angezeigt |
      | vorhanden aber deaktiviert | erhält der Nutzer eine verständliche Fehlermeldung | es wird kein QR-Code erstellt |
      | nicht vorhanden | erhält der Nutzer eine verständliche Fehlermeldung | es wird kein QR-Code erstellt |

  @@regression @@boundary
  Scenario Outline: Boundary: QR-Code für Profil mit maximaler Profil-ID-Länge
    # Prüft die Generierung bei maximaler zulässiger Profil-ID-Länge
    Given ein verifiziertes Business-Profil mit der Profil-ID-Länge <id_laenge> ist vorhanden
    When der Nutzer die Funktion „QR-Code generieren“ aufruft
    Then wird ein scanbarer QR-Code erstellt
    And der QR-Code wird auf dem Bildschirm angezeigt

    Examples:
      | id_laenge |
      | maximal erlaubt |

  @@regression @@edge
  Scenario: Edge: Wiederholte Generierung überschreibt vorherigen QR-Code
    # Stellt sicher, dass bei erneuter Generierung der QR-Code aktualisiert wird
    Given ein verifiziertes Business-Profil ist vorhanden und ein QR-Code wurde bereits generiert
    When der Nutzer die Funktion „QR-Code generieren“ erneut aufruft
    Then wird ein neuer scanbarer QR-Code erstellt
    And der angezeigte QR-Code entspricht der aktuellen Profildaten
