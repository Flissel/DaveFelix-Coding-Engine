@@smoke @@regression
Feature: Biometrische Entsperrung
  As a registrierter Nutzer
  I want to die App per Fingerabdruck oder Face ID entsperren
  So that um mich schnell, sicher und ohne Passworteingabe anzumelden

  Background:
    Given ich bin als registrierter Nutzer auf dem Gerät angemeldet

  @@smoke @@regression @@happy-path
  Scenario: Erfolgreiche Entsperrung mit Biometrie
    # Verifiziert die erfolgreiche Anmeldung ohne Passwort nach biometrischer Bestätigung
    Given die biometrische Authentifizierung ist in der App aktiviert und auf dem Gerät eingerichtet
    When ich öffne die App und bestätige die biometrische Abfrage erfolgreich
    Then werde ich ohne erneute Passworteingabe in die App eingelassen
    And die Startseite der App wird angezeigt

  @@regression @@negative @@error
  Scenario: Biometrie fehlgeschlagen zeigt Passwort-Fallback
    # Stellt sicher, dass bei fehlgeschlagener Biometrie ein Passwort-Fallback angezeigt wird
    Given die biometrische Authentifizierung ist in der App aktiviert
    When die biometrische Prüfung fehlschlägt
    Then wird mir ein Fallback zur Passworteingabe angezeigt
    And die biometrische Abfrage wird nicht erneut automatisch gestartet

  @@regression @@edge
  Scenario: Gerät ohne Biometrie erzwingt Passwort
    # Validiert den Passwort-Flow, wenn keine Biometrie verfügbar oder deaktiviert ist
    Given das Gerät unterstützt keine Biometrie oder Biometrie ist deaktiviert
    When ich die App öffnen möchte
    Then werde ich ausschließlich zur Passworteingabe aufgefordert

  @@regression @@data-driven
  Scenario Outline: Szenario Outline: Biometrie aktiviert und Ergebnis
    # Deckt mehrere biometrische Ergebnisse über Datenvarianten ab
    Given die biometrische Authentifizierung ist in der App aktiviert und auf dem Gerät eingerichtet
    When ich öffne die App und die biometrische Prüfung liefert <result>
    Then <expected_outcome>

    Examples:
      | result | expected_outcome |
      | erfolgreich | werde ich ohne erneute Passworteingabe in die App eingelassen |
      | fehlgeschlagen | wird mir ein Fallback zur Passworteingabe angezeigt |

  @@regression @@edge @@boundary
  Scenario Outline: Szenario Outline: Grenzfälle der biometrischen Verfügbarkeit
    # Prüft Grenzbedingungen der Gerätekonfiguration
    Given die Biometrie-Verfügbarkeit ist <biometry_state>
    When ich die App öffnen möchte
    Then <expected_prompt>

    Examples:
      | biometry_state | expected_prompt |
      | nicht unterstützt | werde ich ausschließlich zur Passworteingabe aufgefordert |
      | deaktiviert | werde ich ausschließlich zur Passworteingabe aufgefordert |
