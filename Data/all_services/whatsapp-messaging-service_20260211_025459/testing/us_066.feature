@@smoke @@regression
Feature: Benachrichtigungsvorschau konfigurieren und anzeigen
  As a registrierter Nutzer
  I want to eine konfigurierbare Benachrichtigungsvorschau einstellen und anzeigen lassen
  So that Benachrichtigungen schnell zu erfassen und Datenschutzanforderungen einzuhalten

  Background:
    Given der Nutzer ist eingeloggt und befindet sich in den Benachrichtigungseinstellungen

  @@smoke @@regression @@happy-path
  Scenario: Speichern einer gültigen Vorschaukonfiguration und Anzeige der Vorschau
    # Validiert den Happy Path für das Speichern und Anzeigen der Vorschau
    When der Nutzer wählt eine Vorschaukonfiguration mit Anzeige von Absender, Zeit und Nachrichtentext
    And der Nutzer speichert die Vorschaukonfiguration
    Then das System zeigt eine Vorschau gemäß der gewählten Konfiguration an
    And die Vorschau enthält Absender, Zeit und Nachrichtentext

  @@regression @@happy-path
  Scenario: Ausblenden sensibler Inhalte in der Vorschau
    # Validiert die Datenschutzanforderung bei sensiblen Benachrichtigungen
    Given eine Benachrichtigung enthält sensible Inhalte
    When die Vorschau ist so konfiguriert, dass Inhalte ausgeblendet werden
    Then das System zeigt nur Metadaten wie Absender und Zeit an
    And der Nachrichtentext wird ausgeblendet

  @@regression @@edge-case
  Scenario Outline: Grenzwert: maximale Vorschau-Länge wird eingehalten
    # Prüft die Boundary-Condition für die maximale Vorschau-Länge
    Given eine Benachrichtigung enthält einen langen Nachrichtentext mit Länge <Nachrichtenlaenge>
    When die Vorschau ist so konfiguriert, dass maximal <MaxVorschauLaenge> Zeichen angezeigt werden
    Then die Vorschau zeigt höchstens <MaxVorschauLaenge> Zeichen des Nachrichtentextes an
    And die Vorschau enthält weiterhin Absender und Zeit

    Examples:
      | Nachrichtenlaenge | MaxVorschauLaenge |
      | 160 | 100 |
      | 100 | 100 |

  @@regression @@negative
  Scenario Outline: Ablehnung ungültiger Vorschaukonfiguration
    # Validiert Fehlermeldung bei ungültiger Konfiguration
    When das System erhält eine ungültige Vorschaukonfiguration <UngueltigeKonfiguration>
    Then die Konfiguration wird abgelehnt
    And eine verständliche Fehlermeldung wird angezeigt

    Examples:
      | UngueltigeKonfiguration |
      | leere Konfiguration ohne Pflichtfelder |
      | unbekanntes Vorschau-Attribut |
      | MaxVorschauLaenge ist negativ |
