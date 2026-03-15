@@smoke @@regression
Feature: Zwei-Faktor-Authentifizierung (2FA) mit 6-stelliger PIN
  As a registrierter Nutzer
  I want to die optionale Zwei-Faktor-Authentifizierung mit einer 6-stelligen PIN aktivieren und verwenden
  So that mein Konto besser schützen und unbefugten Zugriff verhindern

  Background:
    Given der Nutzer ist registriert

  @@smoke @@regression @@happy-path
  Scenario: 2FA aktivieren mit gültiger 6-stelliger PIN
    # Happy path für die Aktivierung der 2FA
    Given der Nutzer ist angemeldet und 2FA ist deaktiviert
    When der Nutzer aktiviert die 2FA und gibt eine gültige 6-stellige PIN ein
    Then wird 2FA aktiviert
    And die PIN wird als zweiter Faktor gespeichert

  @@smoke @@regression @@happy-path
  Scenario: Login mit korrektem Passwort und korrekter 6-stelliger PIN
    # Happy path für den Login mit 2FA
    Given 2FA ist aktiviert
    And der Nutzer hat ein korrektes Passwort
    When der Nutzer meldet sich an und gibt die korrekte 6-stellige PIN ein
    Then wird der Login erfolgreich abgeschlossen

  @@regression @@negative @@edge
  Scenario Outline: Login mit PIN in falscher Länge
    # Edge cases für PIN-Längen außerhalb des 6-stelligen Formats
    Given 2FA ist aktiviert
    And der Nutzer hat ein korrektes Passwort
    When der Nutzer meldet sich an und gibt die PIN '<pin>' ein
    Then wird die Eingabe abgelehnt
    And es wird eine verständliche Fehlermeldung angezeigt

    Examples:
      | pin | case |
      | 12345 | 5-stellig |
      | 1234567 | 7-stellig |
      | 1234 | 4-stellig |
      | 12345678 | 8-stellig |

  @@regression @@negative @@error
  Scenario Outline: Login mit falscher 6-stelliger PIN
    # Error scenario für falsche PIN bei aktivierter 2FA
    Given 2FA ist aktiviert
    And der Nutzer hat ein korrektes Passwort
    When der Nutzer meldet sich an und gibt die falsche 6-stellige PIN '<pin>' ein
    Then wird der Login blockiert
    And es wird eine Fehlermeldung ohne Preisgabe sensibler Informationen angezeigt

    Examples:
      | pin |
      | 000000 |
      | 654321 |
