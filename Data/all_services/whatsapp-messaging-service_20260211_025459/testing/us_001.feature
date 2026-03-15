@smoke @regression
Feature: Telefonnummer-Registrierung
  As a Endnutzer
  I want to mich mit meiner Telefonnummer registrieren und verifizieren
  So that damit ich sicher und schnell Zugriff auf die Plattform erhalte

  Background:
    Given der Nutzer hat die Registrierungsseite geöffnet

  @happy-path @smoke @regression
  Scenario: Erfolgreiche Registrierung und Verifizierung
    # Happy Path: gültige Telefonnummer und korrekter Verifizierungscode
    Given der Nutzer gibt eine gültige Telefonnummer ein
    When der Nutzer sendet die Registrierung ab
    And der Nutzer gibt den korrekt zugesandten Verifizierungscode ein
    Then wird das Konto erstellt
    And die Telefonnummer wird als verifiziert markiert

  @negative @regression
  Scenario Outline: Ungültige oder unvollständige Telefonnummer verhindert Registrierung
    # Error Scenario: Validierungsfehler bei Telefonnummer
    Given der Nutzer gibt eine Telefonnummer im Format <phone_input> ein
    When der Nutzer sendet die Registrierung ab
    Then zeigt das System eine verständliche Fehlermeldung <error_message> an
    And die Registrierung wird verhindert

    Examples:
      | phone_input | error_message |
      | 12345 | Bitte geben Sie eine gültige Telefonnummer ein |
      | +49 | Telefonnummer ist unvollständig |
      | abcd-efg | Telefonnummer enthält ungültige Zeichen |

  @negative @regression
  Scenario Outline: Abgelaufener oder falscher Verifizierungscode
    # Error Scenario: Code ist falsch oder abgelaufen
    Given der Nutzer hat eine gültige Registrierung gestartet
    And der Nutzer gibt einen Verifizierungscode <code_input> ein
    When der Nutzer den Code zur Verifizierung absendet
    Then weist das System den Code zurück
    And das System bietet eine Option zum erneuten Anfordern eines Codes an

    Examples:
      | code_input |
      | 000000 |
      | 123456 |

  @regression @edge-case
  Scenario: SMS-Zustellung vorübergehend nicht möglich
    # Edge Case: Nachrichtenzustellung ist gestört
    Given der Nutzer gibt eine gültige Telefonnummer ein
    When der Nutzer die Registrierung mit Telefonnummer startet
    Then informiert das System über Zustellprobleme
    And das System ermöglicht einen späteren erneuten Versand

  @regression @boundary
  Scenario Outline: Grenzwerte für Telefonnummernlänge
    # Boundary Conditions: minimale und maximale Länge der Telefonnummer
    Given der Nutzer gibt eine Telefonnummer mit Länge <length> ein
    When der Nutzer sendet die Registrierung ab
    Then ist das Validierungsergebnis <validation_result>

    Examples:
      | length | validation_result |
      | 7 | gültig |
      | 15 | gültig |
      | 6 | ungültig |
      | 16 | ungültig |
