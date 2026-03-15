@@smoke @@regression
Feature: Business-Profil
  As a Business-Nutzer
  I want to ein erweitertes Business-Profil mit verifizierten Unternehmensdaten, Katalog und Kommunikationsoptionen anlegen und verwalten
  So that Kunden professionell ansprechen, Vertrauen erhöhen und die Auffindbarkeit sowie Conversion steigern

  Background:
    Given der Nutzer ist angemeldet und verfügt über die Berechtigung, ein Business-Profil zu erstellen

  @@smoke @@regression @@happy-path
  Scenario: Erfolgreiche Erstellung eines erweiterten Business-Profils
    # Validiert die erfolgreiche Erstellung und plattformübergreifende Sichtbarkeit bei vollständigen Pflichtfeldern
    Given alle Pflichtfelder sind mit gültigen Daten ausgefüllt
    When der Nutzer die Profilanlage speichert
    Then wird das erweiterte Business-Profil erfolgreich erstellt
    And das Profil ist plattformübergreifend sichtbar

  @@regression @@negative
  Scenario: Speichern verhindert bei fehlenden Pflichtfeldern
    # Prüft, dass die Speicherung bei leeren Pflichtfeldern verhindert wird und feldspezifische Fehler angezeigt werden
    Given mindestens ein Pflichtfeld ist leer
    When der Nutzer die Profilanlage speichert
    Then wird die Speicherung verhindert
    And es werden konkrete Fehlermeldungen zu den betroffenen Feldern angezeigt

  @@regression @@negative
  Scenario: Speichern verhindert bei ungültigen Pflichtfeldern
    # Prüft Validierungsfehler bei ungültigen Eingaben in Pflichtfeldern
    Given Pflichtfelder enthalten ungültige Daten
    When der Nutzer die Profilanlage speichert
    Then wird die Speicherung verhindert
    And es werden konkrete Fehlermeldungen zu den betroffenen Feldern angezeigt

  @@regression @@happy-path
  Scenario: Verifizierung anstoßen setzt Status auf in Prüfung
    # Validiert den Verifizierungsprozess und Statuswechsel
    Given das Business-Profil ist erstellt und die Verifizierung ist verfügbar
    When der Nutzer die Verifizierung anstößt und die Nachweise einreicht
    Then ändert sich der Profilstatus auf „in Prüfung“
    And der Nutzer erhält eine Bestätigung

  @@regression @@boundary
  Scenario Outline: Pflichtfelder-Grenzwerte werden akzeptiert
    # Prüft Boundary Conditions für die Länge von Pflichtfeldern
    Given Pflichtfelder werden mit Grenzwerten befüllt
    When der Nutzer die Profilanlage speichert
    Then wird das Business-Profil erfolgreich erstellt
    And keine Validierungsfehler werden angezeigt

    Examples:
      | feld | wert |
      | Firmenname | A |
      | Firmenname | AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA |

  @@regression @@negative @@edge
  Scenario Outline: Ungültige Eingabeformate in Pflichtfeldern
    # Prüft Edge Cases für Formatvalidierung in Pflichtfeldern
    Given ein Pflichtfeld enthält ein ungültiges Format
    When der Nutzer die Profilanlage speichert
    Then wird die Speicherung verhindert
    And eine konkrete Fehlermeldung für das betroffene Feld wird angezeigt

    Examples:
      | feld | wert |
      | E-Mail | invalid-email |
      | Telefon | 123-ABC |
