@@smoke @@regression
Feature: Business-Statistiken im Dashboard
  As a Business-Admin
  I want to grundlegende Nachrichtenstatistiken im Business-Dashboard anzeigen lassen
  So that um die Kommunikation mit Kunden zu bewerten und Optimierungspotenziale zu erkennen

  Background:
    Given der Business-Admin ist angemeldet und befindet sich im Business-Dashboard

  @@happy-path @@smoke @@regression
  Scenario: Grundlegende Nachrichtenstatistiken werden für einen Zeitraum angezeigt
    # Happy path: Statistiken werden für einen Zeitraum mit vorhandenen Nachrichten geladen
    Given es existieren Nachrichtenaktivitäten im ausgewählten Zeitraum
    When der Business-Admin den Statistikbereich öffnet
    Then das System zeigt die Kennzahlen für gesendete, zugestellte und gelesene Nachrichten an
    And die Kennzahlen entsprechen den Daten des gewählten Zeitraums

  @@edge @@regression
  Scenario: Statistiken zeigen 0-Werte bei Zeitraum ohne Aktivität
    # Edge case: Zeitraum ohne Nachrichtenaktivität liefert 0-Werte und neutrale Information
    Given der Business-Admin wählt einen Zeitraum ohne Nachrichtenaktivität
    When die Statistiken geladen werden
    Then das System zeigt 0-Werte für gesendete, zugestellte und gelesene Nachrichten
    And das System informiert neutral, dass keine Daten vorhanden sind

  @@negative @@regression
  Scenario: Fehlermeldung und erneuter Ladeversuch bei nicht erreichbarer Datenquelle
    # Error scenario: Statistiken können nicht geladen werden
    Given die Statistikdatenquelle ist nicht erreichbar
    When der Business-Admin den Statistikbereich öffnet
    Then das System zeigt eine verständliche Fehlermeldung an
    And das System bietet einen erneuten Ladeversuch an

  @@boundary @@regression
  Scenario Outline: Statistiken für Grenzwerte des Zeitraums
    # Boundary conditions: minimaler und maximaler Zeitraum werden korrekt verarbeitet
    Given der Business-Admin wählt einen Zeitraum von "<start>" bis "<end>"
    When die Statistiken geladen werden
    Then das System zeigt Kennzahlen nur für den gewählten Zeitraum an
    And die Anzeige bleibt performant und vollständig

    Examples:
      | start | end |
      | 2024-01-01 | 2024-01-01 |
      | 2024-01-01 | 2024-12-31 |
