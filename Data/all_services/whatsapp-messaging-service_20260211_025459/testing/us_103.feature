@@smoke @@regression
Feature: WhatsApp Pay In-App-Zahlung
  As a registrierter Nutzer
  I want to eine In-App-Zahlung in einem unterstützten Markt durchführen
  So that schnell und sicher innerhalb der App bezahlen zu können

  Background:
    Given der Nutzer ist registriert und in der App angemeldet

  @@smoke @@regression @@happy-path
  Scenario: Erfolgreiche Zahlung in unterstütztem Markt
    # Happy Path: Zahlung wird verarbeitet und bestätigt
    Given der Nutzer befindet sich in einem unterstützten Markt
    And der Nutzer hat eine gültige Zahlungsart hinterlegt
    When der Nutzer eine Zahlung über WhatsApp Pay bestätigt
    Then wird die Zahlung erfolgreich verarbeitet
    And der Nutzer erhält eine Bestätigung der Zahlung

  @@regression @@negative
  Scenario: Zahlungsfunktion in nicht unterstütztem Markt deaktiviert
    # Error Scenario: Zahlungsfunktion ist nicht verfügbar
    Given der Nutzer befindet sich in einem nicht unterstützten Markt
    When der Nutzer versucht, eine In-App-Zahlung zu starten
    Then wird die Zahlungsfunktion deaktiviert angezeigt
    And der Nutzer erhält einen Hinweis zur Nichtverfügbarkeit

  @@regression @@negative
  Scenario: Zahlungsabwicklung temporär nicht verfügbar
    # Error Scenario: Payment Service Down
    Given der Nutzer befindet sich in einem unterstützten Markt
    And die Zahlungsabwicklung ist temporär nicht verfügbar
    When der Nutzer eine Zahlung abschicken möchte
    Then wird eine Fehlermeldung angezeigt
    And die Zahlung wird nicht ausgeführt

  @@regression @@boundary
  Scenario Outline: Boundary: Marktunterstützung anhand Ländercode
    # Boundary Condition: Grenzfälle für unterstützte vs. nicht unterstützte Märkte
    Given der Nutzer befindet sich in Markt "<market_code>"
    And der Nutzer hat eine gültige Zahlungsart hinterlegt
    When der Nutzer eine Zahlung über WhatsApp Pay bestätigen möchte
    Then ist die Zahlungsfunktion "<payment_state>"
    And wird die erwartete Rückmeldung "<user_message>" angezeigt

    Examples:
      | market_code | payment_state | user_message |
      | IN | aktiv | Zahlung kann bestätigt werden |
      | BR | aktiv | Zahlung kann bestätigt werden |
      | DE | deaktiviert | Zahlungsfunktion in diesem Markt nicht verfügbar |

  @@regression @@negative @@edge
  Scenario: Edge Case: Zahlungsart fehlt trotz unterstütztem Markt
    # Edge Case: Nutzer ohne hinterlegte Zahlungsart
    Given der Nutzer befindet sich in einem unterstützten Markt
    And der Nutzer hat keine Zahlungsart hinterlegt
    When der Nutzer versucht, eine In-App-Zahlung zu starten
    Then wird die Zahlungsfunktion deaktiviert angezeigt
    And der Nutzer erhält einen Hinweis zur fehlenden Zahlungsart
