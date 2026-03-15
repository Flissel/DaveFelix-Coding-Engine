@smoke @regression
Feature: Melden
  As a registrierter Nutzer
  I want to eine Nachricht oder einen Kontakt melden
  So that um Missbrauch zu verhindern und eine sichere Kommunikation zu gewährleisten

  Background:
    Given der registrierte Nutzer ist angemeldet und betrachtet eine erhaltene Nachricht oder einen Kontakt

  @@smoke @@regression @@happy-path
  Scenario: Erfolgreiche Meldung einer Nachricht oder eines Kontakts
    # Happy path: Meldung wird mit ausgewähltem Grund erfolgreich erfasst
    Given die Meldefunktion ist für die angezeigte Nachricht oder den Kontakt verfügbar
    When der Nutzer öffnet die Meldefunktion und wählt einen Meldungsgrund
    And der Nutzer sendet die Meldung ab
    Then die Meldung wird erfolgreich erfasst
    And der Nutzer erhält eine Bestätigung

  @@regression @@negative
  Scenario: Meldung ohne Auswahl eines Grundes wird abgelehnt
    # Error scenario: Meldung ohne Begründung wird nicht gespeichert
    Given die Meldefunktion ist geöffnet
    When der Nutzer sendet die Meldung ohne einen Grund auszuwählen ab
    Then eine Fehlermeldung wird angezeigt
    And die Meldung wird nicht gespeichert

  @@regression @@negative @@edge
  Scenario: Doppelte Meldung derselben Nachricht oder desselben Kontakts wird verhindert
    # Edge case: erneute Meldung derselben Entität wird blockiert
    Given die Nachricht oder der Kontakt wurde vom Nutzer bereits gemeldet
    When der Nutzer versucht die gleiche Nachricht oder den gleichen Kontakt erneut zu melden
    Then die erneute Meldung wird verhindert
    And eine Hinweisnachricht wird angezeigt

  @@regression @@boundary
  Scenario Outline: Meldung mit verschiedenen gültigen Gründen
    # Boundary conditions: verschiedene vordefinierte Gründe sind zulässig
    Given die Meldefunktion ist geöffnet
    When der Nutzer wählt den Meldungsgrund "<reason>" aus
    And der Nutzer sendet die Meldung ab
    Then die Meldung wird erfolgreich erfasst
    And eine Bestätigung wird angezeigt

    Examples:
      | reason |
      | Spam |
      | Belästigung |
      | Unangemessene Inhalte |
      | Betrug |
