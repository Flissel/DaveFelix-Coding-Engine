@smoke @regression
Feature: Info/Status Text im Profil
  As a Business-Profil-Nutzer
  I want to einen kurzen Info-/Status-Text im Profil eingeben und aktualisieren
  So that damit Kunden schnell aktuelle Informationen erhalten und die Kommunikation professionell wirkt

  Background:
    Given der Nutzer ist im Profilbereich angemeldet

  @@smoke @@regression @@happy-path
  Scenario: Info-/Status-Text speichern und nach Neuladen sichtbar
    # Happy Path: Text wird gespeichert und bleibt nach Reload sichtbar
    Given der aktuelle Info-/Status-Text ist leer
    When der Nutzer einen kurzen Info-/Status-Text eingibt und speichert
    Then wird der Text im Profil angezeigt
    And der Text ist nach dem Neuladen weiterhin sichtbar

  @@regression @@happy-path
  Scenario: Info-/Status-Text aktualisieren
    # Happy Path: Alter Text wird durch neuen Text ersetzt
    Given ein bestehender Info-/Status-Text ist gespeichert
    When der Nutzer den Info-/Status-Text ändert und speichert
    Then wird der vorherige Text durch die neue Version ersetzt
    And nach dem Neuladen ist nur der neue Text sichtbar

  @@negative @@regression
  Scenario: Leeren Info-/Status-Text nicht speichern
    # Fehlerfall: Leerer Text wird abgelehnt
    Given der Nutzer befindet sich im Profilbereich
    When der Nutzer einen leeren Info-/Status-Text speichert
    Then zeigt das System eine verständliche Fehlermeldung an
    And der leere Text wird nicht gespeichert

  @@regression @@boundary
  Scenario Outline: Info-/Status-Text mit minimaler Länge speichern
    # Boundary: Minimal gültiger Text wird akzeptiert
    Given der Nutzer befindet sich im Profilbereich
    When der Nutzer einen Info-/Status-Text mit minimaler Länge eingibt und speichert
    Then wird der Text im Profil angezeigt
    And der Text ist nach dem Neuladen weiterhin sichtbar

    Examples:
      | min_length_text |
      | A |

  @@regression @@boundary
  Scenario Outline: Info-/Status-Text am maximalen Zeichenlimit speichern
    # Boundary: Maximaler Text wird akzeptiert
    Given der Nutzer befindet sich im Profilbereich
    When der Nutzer einen Info-/Status-Text mit maximaler Länge eingibt und speichert
    Then wird der Text im Profil angezeigt
    And der Text ist nach dem Neuladen weiterhin sichtbar

    Examples:
      | max_length_text |
      | AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA |

  @@negative @@regression @@edge-case
  Scenario Outline: Info-/Status-Text über dem maximalen Zeichenlimit ablehnen
    # Edge/Error: Text über Limit wird nicht gespeichert
    Given der Nutzer befindet sich im Profilbereich
    When der Nutzer einen Info-/Status-Text über dem maximalen Zeichenlimit eingibt und speichert
    Then zeigt das System eine verständliche Fehlermeldung an
    And der zu lange Text wird nicht gespeichert

    Examples:
      | over_max_length_text |
      | AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA |
