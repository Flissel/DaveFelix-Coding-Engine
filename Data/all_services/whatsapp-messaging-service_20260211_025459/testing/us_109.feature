@@smoke @@regression
Feature: Sprachnachrichten transkribieren
  As a Endnutzer
  I want to Sprachnachrichten automatisch transkribieren lassen
  So that ich den Inhalt schnell lesen und in lauten oder stillen Umgebungen verstehen kann

  Background:
    Given eine empfangene Sprachnachricht ist im Chatverlauf verfügbar

  @@smoke @@regression @@happy-path
  Scenario: Transkription wird erfolgreich angezeigt
    # Happy path für manuell ausgelöste Transkription
    Given die automatische Transkription ist deaktiviert
    When der Nutzer die Transkription für die Sprachnachricht anfordert
    Then der Text der Sprachnachricht wird korrekt und zeitnah angezeigt
    And die Sprachnachricht bleibt abspielbar

  @@regression @@edge
  Scenario Outline: Transkription mit kurzen Nachrichten oder Hintergrundgeräuschen
    # Edge cases für bestmögliches Ergebnis und Markierung unsicherer Wörter
    Given eine Sprachnachricht mit <audio_condition> liegt vor
    When die Transkription gestartet wird
    Then ein bestmögliches Transkriptionsergebnis wird angezeigt
    And unsichere Wörter werden gekennzeichnet

    Examples:
      | audio_condition |
      | sehr kurzer Dauer |
      | Hintergrundgeräuschen |

  @@regression @@negative
  Scenario: Transkriptionsdienst ist nicht verfügbar
    # Error scenario bei Ausfall des Transkriptionsdienstes
    Given der Transkriptionsdienst ist nicht verfügbar
    When der Nutzer die Transkription anfordert
    Then der Nutzer erhält eine verständliche Fehlermeldung
    And die Sprachnachricht bleibt unverändert verfügbar

  @@regression @@boundary
  Scenario Outline: Automatische Transkription für Grenzwerte der Nachrichtendauer
    # Boundary conditions für automatische Transkription bei minimaler und maximaler Dauer
    Given die automatische Transkription ist aktiviert
    And eine Sprachnachricht mit Dauer <duration> liegt vor
    When die Sprachnachricht empfangen wird
    Then die Transkription wird automatisch gestartet
    And der Text der Sprachnachricht wird zeitnah angezeigt

    Examples:
      | duration |
      | minimaler unterstützter Dauer |
      | maximaler unterstützter Dauer |
