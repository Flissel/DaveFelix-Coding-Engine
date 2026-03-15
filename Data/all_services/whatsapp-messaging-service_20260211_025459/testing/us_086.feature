@@smoke @@regression
Feature: Datennutzung einsehen und steuern
  As a registrierter Nutzer
  I want to den eigenen Datenverbrauch einsehen und steuern
  So that damit ich Datenschutz und Sicherheit wahren und meinen Datenverbrauch kontrollieren kann

  Background:
    Given ich bin als registrierter Nutzer angemeldet und habe Zugriff auf die Einstellungen

  @@smoke @@regression @@happy-path
  Scenario: Anzeige von aktuellem Datenverbrauch und Steuerungsoptionen
    # Happy path: Nutzer sieht Verbrauchsdaten und verfügbare Steuerungsoptionen
    When ich rufe die Ansicht zur Datennutzung auf
    Then werden mein aktueller Datenverbrauch und verfügbare Steuerungsoptionen angezeigt
    And die angezeigten Werte sind für meinen Account eindeutig zugeordnet

  @@regression @@happy-path
  Scenario Outline: Benachrichtigung und Maßnahme bei Erreichen der Datennutzungsbegrenzung
    # Happy path: Schwellenwert erreicht und ausgewählte Maßnahme wird angewendet
    Given ich habe eine Datennutzungsbegrenzung von <limit> festgelegt und eine Maßnahme <measure> ausgewählt
    When mein Verbrauch den festgelegten Schwellenwert erreicht
    Then werde ich benachrichtigt
    And das System wendet die gewählte Steuerungsmaßnahme <measure> an

    Examples:
      | limit | measure |
      | 5 GB | Datenverbrauch sperren |
      | 10 GB | Datenverbrauch drosseln |

  @@regression @@boundary
  Scenario Outline: Grenzwert exakt erreicht
    # Boundary condition: Verhalten bei exakt erreichtem Schwellenwert
    Given ich habe eine Datennutzungsbegrenzung von <limit> festgelegt und eine Maßnahme <measure> ausgewählt
    When mein Verbrauch genau <limit> beträgt
    Then werde ich benachrichtigt
    And das System wendet die gewählte Steuerungsmaßnahme <measure> an

    Examples:
      | limit | measure |
      | 1 GB | Datenverbrauch drosseln |
      | 0 MB | Datenverbrauch sperren |

  @@regression @@negative
  Scenario: Datennutzungsdaten vorübergehend nicht verfügbar
    # Error scenario: verständliche Fehlermeldung und Option zur Aktualisierung
    Given die Datennutzungsdaten sind vorübergehend nicht verfügbar
    When ich versuche die Datennutzung einzusehen
    Then erhalte ich eine verständliche Fehlermeldung
    And mir wird eine Option zur erneuten Aktualisierung angeboten

  @@regression @@edge
  Scenario: Erneute Aktualisierung nach temporärer Nichtverfügbarkeit
    # Edge case: Daten werden nach erneuter Aktualisierung erfolgreich geladen
    Given die Datennutzungsdaten waren vorübergehend nicht verfügbar
    When ich wähle die Option zur erneuten Aktualisierung
    Then werden mein aktueller Datenverbrauch und verfügbare Steuerungsoptionen angezeigt
