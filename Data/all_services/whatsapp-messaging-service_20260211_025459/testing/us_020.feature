@@smoke @@regression
Feature: Chat sperren mit zusaetzlicher Authentifizierung
  As a registrierter Nutzer
  I want to einen einzelnen Chat mit zusaetzlicher Authentifizierung sperren
  So that um meine Privatsphaere zu schuetzen und unbefugten Zugriff auf vertrauliche Konversationen zu verhindern

  Background:
    Given der Nutzer ist registriert, eingeloggt und befindet sich in der Chat-Detailansicht eines entsperrten Chats

  @@smoke @@regression @@happy-path
  Scenario: Chat erfolgreich sperren nach bestaetigter Zusatz-Authentifizierung
    # Happy Path: Ein Chat wird nach erfolgreicher zusaetzlicher Authentifizierung gesperrt
    When der Nutzer waehlt die Funktion "Chat sperren"
    And die zusaetzliche Authentifizierung wird erfolgreich bestaetigt
    Then der Chat wird gesperrt
    And der Chat ist ohne erneute zusaetzliche Authentifizierung nicht einsehbar

  @@regression @@happy-path
  Scenario Outline: Chat sperren mit verschiedenen Authentifizierungsarten
    # Happy Path als Scenario Outline: Sperren funktioniert mit unterschiedlichen Zusatz-Authentifizierungen
    When der Nutzer waehlt die Funktion "Chat sperren"
    And die zusaetzliche Authentifizierung vom Typ "<auth_type>" wird erfolgreich bestaetigt
    Then der Chat wird gesperrt
    And der Chat ist ohne erneute zusaetzliche Authentifizierung nicht einsehbar

    Examples:
      | auth_type |
      | PIN |
      | Biometrie |
      | Passwort |

  @@regression @@negative
  Scenario: Fehlgeschlagene Zusatz-Authentifizierung verhindert Sperren
    # Error Scenario: Sperrvorgang bleibt ohne Erfolg und zeigt Fehlermeldung
    When der Nutzer startet den Sperrvorgang
    And die zusaetzliche Authentifizierung schlaegt fehl
    Then der Chat bleibt entsperrt
    And eine klare Fehlermeldung wird angezeigt

  @@regression @@negative
  Scenario: Abgebrochene Zusatz-Authentifizierung verhindert Sperren
    # Error Scenario: Abbruch des Authentifizierungsvorgangs
    When der Nutzer startet den Sperrvorgang
    And die zusaetzliche Authentifizierung wird abgebrochen
    Then der Chat bleibt entsperrt
    And eine klare Fehlermeldung wird angezeigt

  @@regression @@edge
  Scenario: Bereits gesperrter Chat erneut sperren
    # Edge Case: Versuch, einen bereits gesperrten Chat erneut zu sperren
    Given der Chat ist bereits gesperrt
    When der Nutzer versucht den Chat erneut zu sperren
    Then es wird eine Information angezeigt, dass der Chat bereits gesperrt ist
    And der Sperrstatus bleibt unveraendert

  @@regression @@boundary
  Scenario Outline: Grenzfall: Minimale Zeitverzoegerung bei Authentifizierungsbestaetigung
    # Boundary Condition: Sehr schnelle Bestaetigung der Zusatz-Authentifizierung
    When der Nutzer waehlt die Funktion "Chat sperren"
    And die zusaetzliche Authentifizierung wird innerhalb von "<response_time_ms>" Millisekunden bestaetigt
    Then der Chat wird gesperrt
    And der Chat ist ohne erneute zusaetzliche Authentifizierung nicht einsehbar

    Examples:
      | response_time_ms |
      | 50 |
