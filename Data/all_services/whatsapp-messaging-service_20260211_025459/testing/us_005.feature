@@smoke @@regression
Feature: Passkey-Unterstuetzung
  As a Endnutzer
  I want to sich passwortlos per Passkey anmelden
  So that damit die Anmeldung sicherer und schneller erfolgt und die Nutzung plattformuebergreifend bequem bleibt

  Background:
    Given der Login-Bildschirm ist geladen

  @@smoke @@regression @@happy-path
  Scenario: Erfolgreiche Passkey-Anmeldung mit bestaetigter Geraete-Authentifizierung
    # Happy path: registrierter Nutzer meldet sich erfolgreich per Passkey an
    Given ein registrierter Endnutzer mit einem auf dem Geraet hinterlegten Passkey
    When der Nutzer die Passkey-Anmeldung auswaehlt
    And die biometrische oder Geraete-Authentifizierung erfolgreich bestaetigt wird
    Then wird der Nutzer erfolgreich angemeldet
    And es wird eine Session erstellt

  @@regression @@edge
  Scenario: Passkey-Anmeldung ohne hinterlegten Passkey zeigt Hinweis und Alternative
    # Edge case: registrierter Nutzer hat keinen Passkey auf dem Geraet
    Given ein registrierter Endnutzer ohne hinterlegten Passkey
    When der Nutzer die Passkey-Anmeldung auswaehlt
    Then wird eine klare Hinweismeldung angezeigt
    And eine alternative Anmeldeoption wird angeboten

  @@regression @@negative
  Scenario: Geraete-Authentifizierung schlaegt fehl und bricht Login ab
    # Error scenario: Authentifizierung wird abgelehnt oder fehlschlaegt
    Given ein registrierter Endnutzer mit Passkey auf dem Geraet
    When der Nutzer die Passkey-Anmeldung auswaehlt
    And die biometrische oder Geraete-Authentifizierung fehlschlaegt
    Then wird der Login abgebrochen
    And eine Fehlernachricht wird angezeigt und keine Session wird erstellt

  @@regression @@boundary
  Scenario Outline: Passkey-Anmeldung auf Plattformen mit und ohne WebAuthn-Unterstuetzung
    # Boundary condition: Plattformunterstuetzung variieren
    Given ein registrierter Endnutzer mit Passkey auf dem Geraet
    When der Nutzer die Passkey-Anmeldung auf einer Plattform mit Status <plattform_status> auswaehlt
    Then ist das Ergebnis <ergebnis>
    And wird die Anzeige <hinweis> dargestellt

    Examples:
      | plattform_status | ergebnis | hinweis |
      | WebAuthn-unterstuetzt | der Nutzer erfolgreich angemeldet | keine Warnung |
      | WebAuthn-nicht-unterstuetzt | die Passkey-Anmeldung nicht gestartet | ein Hinweis auf fehlende Plattformunterstuetzung |
