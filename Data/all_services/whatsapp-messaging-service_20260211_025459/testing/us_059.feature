@@smoke @@regression
Feature: Nachrichtensperre mit Authentifizierung
  As a registrierter Nutzer
  I want to die App per Nachrichtensperre mit Authentifizierung sperren und entsperren
  So that meine Nachrichten und personenbezogenen Daten vor unbefugtem Zugriff schuetzen

  Background:
    Given die App ist installiert und der Nutzer ist registriert

  @@smoke @@regression @@happy-path
  Scenario: Erfolgreicher Zugriff nach Authentifizierung bei aktivierter Nachrichtensperre
    # Happy path: Zugriff nach erfolgreicher Authentifizierung beim App-Start
    Given die Nachrichtensperre ist aktiviert
    When der Nutzer oeffnet die App
    Then wird der Nutzer zur Authentifizierung aufgefordert
    And nach erfolgreicher Authentifizierung hat der Nutzer Zugriff auf die Nachrichten

  @@regression @@happy-path
  Scenario: Fortgesetzter Zugriff nach kurzer Inaktivitaet
    # Happy path: Zugriff bleibt nach kurzer Inaktivitaet ohne erneute Authentifizierung
    Given die Nachrichtensperre ist aktiviert und der Nutzer ist erfolgreich authentifiziert
    When der Nutzer kehrt nach kurzer Inaktivitaet zur App zurueck
    Then bleibt der Zugriff ohne erneute Authentifizierung moeglich

  @@regression @@negative
  Scenario: Wiederholte falsche Authentifizierung fuehrt zu Zugriff verweigert
    # Error scenario: Zugriff wird nach wiederholt falscher Authentifizierung verweigert
    Given die Nachrichtensperre ist aktiviert
    When der Nutzer gibt wiederholt eine falsche Authentifizierung ein
    Then wird der Zugriff verweigert
    And eine Fehlermeldung wird angezeigt

  @@regression @@negative @@boundary
  Scenario Outline: Authentifizierung mit Grenzwerten der Fehlversuche
    # Boundary condition: Verhalten bei maximal erlaubten Fehlversuchen
    Given die Nachrichtensperre ist aktiviert
    When der Nutzer gibt <attempts> falsche Authentifizierungen ein
    Then ist der Zugriff <access_state>
    And wird <message_state> angezeigt

    Examples:
      | attempts | access_state | message_state |
      | 2 | weiterhin gesperrt und erfordert erneute Eingabe | keine Sperrmeldung |
      | 3 | verweigert | eine Fehlermeldung |

  @@regression @@edge @@boundary
  Scenario Outline: Rueckkehr nach Inaktivitaet am Timeout-Limit
    # Edge case: Verhalten am Inaktivitaets-Grenzwert
    Given die Nachrichtensperre ist aktiviert und der Nutzer ist erfolgreich authentifiziert
    When der Nutzer kehrt nach <inactivity_duration> Inaktivitaet zur App zurueck
    Then ist <auth_requirement>

    Examples:
      | inactivity_duration | auth_requirement |
      | kurzer Inaktivitaet | kein erneutes Anmelden erforderlich |
      | langer Inaktivitaet | eine erneute Authentifizierung erforderlich |
