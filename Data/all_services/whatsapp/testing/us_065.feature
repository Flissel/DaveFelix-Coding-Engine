@@smoke @@regression
Feature: Push-Benachrichtigungen
  As a mobile App-Nutzer
  I want to Push-Benachrichtigungen empfangen
  So that damit ich zeitkritische Informationen zuverlässig und rechtzeitig erhalte

  Background:
    Given die App ist installiert und der Nutzer ist angemeldet

  @@smoke @@happy-path
  Scenario: Erfolgreiche Zustellung bei aktivierten Push-Benachrichtigungen
    # Prüft die rechtzeitige Zustellung bei aktivierten Pushs und Online-Gerät
    Given Push-Benachrichtigungen sind in der App aktiviert
    And das Gerät ist online
    When eine relevante Benachrichtigung vom System ausgelöst wird
    Then wird die Push-Benachrichtigung innerhalb der definierten Zustellzeit auf dem Gerät angezeigt
    And die Benachrichtigung enthält den erwarteten Titel und Inhalt

  @@regression @@edge
  Scenario: Zustellung nach Offline-Phase
    # Prüft automatische Zustellung nach Wiederherstellung der Verbindung
    Given Push-Benachrichtigungen sind in der App aktiviert
    And das Gerät ist vorübergehend offline
    When eine Benachrichtigung ausgelöst wird
    And die Verbindung wird wiederhergestellt
    Then wird die Benachrichtigung automatisch zugestellt
    And die Zustellung erfolgt ohne erneutes Auslösen der Benachrichtigung

  @@regression @@negative
  Scenario: Keine Zustellung bei deaktivierten Push-Benachrichtigungen
    # Prüft, dass keine Pushs gesendet werden, wenn der Nutzer sie deaktiviert hat
    Given Push-Benachrichtigungen sind in der App deaktiviert
    When eine Benachrichtigung ausgelöst wird
    Then wird keine Push-Benachrichtigung an das Gerät gesendet
    And es gibt keinen Eintrag im Geräte-Benachrichtigungscenter

  @@regression @@boundary
  Scenario Outline: Zustellzeit-Grenze einhalten
    # Prüft die Zustellung an der maximal erlaubten Zustellzeit
    Given Push-Benachrichtigungen sind in der App aktiviert
    And das Gerät ist online
    When eine relevante Benachrichtigung vom System ausgelöst wird
    Then erscheint die Push-Benachrichtigung innerhalb der maximalen Zustellzeit

    Examples:
      | max_zustellzeit_sekunden |
      | 5 |
      | 30 |

  @@regression @@negative @@error
  Scenario: Fehlerhafte Verbindung verhindert Zustellung während Offline-Phase
    # Prüft, dass während anhaltender Offline-Phase keine Zustellung erfolgt
    Given Push-Benachrichtigungen sind in der App aktiviert
    And das Gerät ist offline und bleibt offline
    When eine Benachrichtigung ausgelöst wird
    Then wird keine Push-Benachrichtigung auf dem Gerät angezeigt
    And die Benachrichtigung wird zur späteren Zustellung vorgemerkt

  @@regression @@edge
  Scenario Outline: Mehrere Benachrichtigungen während kurzer Offline-Zeit
    # Prüft die automatische Zustellung mehrerer Benachrichtigungen nach Wiederverbindung
    Given Push-Benachrichtigungen sind in der App aktiviert
    And das Gerät ist vorübergehend offline
    When mehrere Benachrichtigungen ausgelöst werden
    And die Verbindung wird wiederhergestellt
    Then werden alle Benachrichtigungen automatisch zugestellt

    Examples:
      | anzahl_benachrichtigungen |
      | 2 |
      | 10 |
