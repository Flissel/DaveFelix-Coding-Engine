@@smoke @@regression
Feature: Profilbild-Sichtbarkeit konfigurieren
  As a registrierter Nutzer
  I want to die Sichtbarkeit meines Profilbildes konfigurieren
  So that damit ich meine Privatsphäre schuetze und die Nutzung trotzdem intuitiv bleibt

  Background:
    Given der Nutzer ist registriert und im Profilbereich angemeldet

  @@smoke @@regression @@happy-path
  Scenario: Sichtbarkeit erfolgreich speichern und sofort anwenden
    # Happy path: gueltige Sichtbarkeit auswaehlen, speichern und sofortige Anwendung bestaetigen
    Given die Sichtbarkeitseinstellungen sind geoeffnet
    When der Nutzer eine gueltige Sichtbarkeitsoption auswaehlt und speichert
    Then wird die ausgewaehlte Sichtbarkeit sofort angewendet
    And eine bestaetigende Anzeige der Auswahl ist sichtbar

  @@regression @@edge
  Scenario: Gespeicherte Sichtbarkeit wird ohne Aenderung korrekt angezeigt
    # Edge case: Einstellungen erneut oeffnen ohne Aenderung und gespeicherte Option anzeigen
    Given eine Sichtbarkeitsoption ist bereits gespeichert
    When der Nutzer die Sichtbarkeitseinstellungen erneut oeffnet ohne eine Aenderung vorzunehmen
    Then wird die aktuell gespeicherte Sichtbarkeitsoption korrekt angezeigt

  @@regression @@negative
  Scenario: Ungueltige Sichtbarkeitsoption wird abgelehnt
    # Error scenario: ungueltige Option speichern und Fehlermeldung anzeigen
    Given die Sichtbarkeitseinstellungen sind geoeffnet
    When der Nutzer versucht eine ungueltige Sichtbarkeitsoption zu speichern
    Then wird die Speicherung abgelehnt
    And eine verstaendliche Fehlermeldung wird angezeigt

  @@regression @@boundary @@happy-path
  Scenario Outline: Mehrere gueltige Sichtbarkeitsoptionen speichern
    # Boundary conditions: alle gueltigen Optionen werden gespeichert und angewendet
    Given die Sichtbarkeitseinstellungen sind geoeffnet
    When der Nutzer die Sichtbarkeitsoption "<option>" auswaehlt und speichert
    Then wird die Sichtbarkeitsoption "<option>" sofort angewendet
    And die bestaetigende Anzeige zeigt "<option>"

    Examples:
      | option |
      | Oeffentlich |
      | Nur Freunde |
      | Privat |

  @@regression @@negative @@boundary
  Scenario Outline: Ungueltige Werte und leere Eingabe ablehnen
    # Boundary/error: leere, zu lange oder nicht erlaubte Werte werden abgelehnt
    Given die Sichtbarkeitseinstellungen sind geoeffnet
    When der Nutzer den ungueltigen Wert "<invalid_value>" speichert
    Then wird die Speicherung abgelehnt
    And eine verstaendliche Fehlermeldung wird angezeigt

    Examples:
      | invalid_value |
      |  |
      |   |
      | UNKNOWN_OPTION |
      | Oeffentlich;DROP TABLE |
