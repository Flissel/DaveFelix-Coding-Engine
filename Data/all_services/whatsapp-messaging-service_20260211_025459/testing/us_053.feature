@@smoke @@regression
Feature: Kamera-Integration im Chat
  As a Endnutzer
  I want to im Chat direkt auf die Kamera zugreifen und ein Foto aufnehmen
  So that damit ich Inhalte schnell und intuitiv teilen kann, ohne den Chat zu verlassen

  Background:
    Given der Nutzer ist im Chat angemeldet und der Chat ist geöffnet

  @@smoke @@regression @@happy-path
  Scenario: Foto aufnehmen und als Vorschau senden (Happy Path)
    # Erfolgreiches Aufnehmen eines Fotos und Anzeige der Nachrichtenvorschau
    Given das Gerät verfügt über eine funktionierende Kamera und die Berechtigung ist erteilt
    When der Nutzer wählt die Kamera-Funktion im Chat aus und nimmt ein Foto auf
    Then das Foto wird als Nachrichtenvorschau im Chat angezeigt
    And der Nutzer kann die Vorschau als Nachricht senden

  @@regression @@edge
  Scenario: Kameraberechtigung anfordern wenn noch nicht erteilt (Edge Case)
    # Systemabfrage erscheint und Chat bleibt geöffnet
    Given die Kameraberechtigung wurde noch nicht erteilt
    When der Nutzer wählt die Kamera-Funktion im Chat aus
    Then eine Systemabfrage zur Kameraberechtigung wird angezeigt
    And der Chat bleibt im Hintergrund geöffnet

  @@regression @@negative
  Scenario: Kameraberechtigung verweigert oder Kamera nicht verfügbar (Error Scenario)
    # Fehlermeldung und alternative Option zum Senden von Medien
    Given die Kameraberechtigung ist verweigert oder keine Kamera ist verfügbar
    When der Nutzer versucht die Kamera-Funktion im Chat zu nutzen
    Then eine verständliche Fehlermeldung wird angezeigt
    And eine alternative Option zum Senden von Medien wird angeboten

  @@regression @@boundary
  Scenario: Mehrere Fotoaufnahmen vor dem Senden (Boundary Condition)
    # Letzte Aufnahme ersetzt die Vorschau vor dem Senden
    Given das Gerät verfügt über eine funktionierende Kamera und die Berechtigung ist erteilt
    When der Nutzer nimmt ein Foto auf und nimmt danach ein weiteres Foto auf, ohne zu senden
    Then die Vorschau zeigt das zuletzt aufgenommene Foto
    And es kann genau eine Vorschau als Nachricht gesendet werden

  @@regression
  Scenario Outline: Kamera-Funktion mit unterschiedlichen Berechtigungszuständen (Scenario Outline)
    # Systemreaktion abhängig vom Berechtigungsstatus
    Given der Berechtigungsstatus ist <permission_state> und das Gerät ist <camera_state>
    When der Nutzer wählt die Kamera-Funktion im Chat aus
    Then das Ergebnis ist <expected_outcome>
    And der Chat bleibt geöffnet

    Examples:
      | permission_state | camera_state | expected_outcome |
      | erteilt | verfügbar | die Kamera öffnet sich und der Nutzer kann ein Foto aufnehmen |
      | nicht erteilt | verfügbar | eine Systemabfrage zur Kameraberechtigung wird angezeigt |
      | verweigert | verfügbar | eine Fehlermeldung mit Medien-Alternative wird angezeigt |
      | erteilt | nicht verfügbar | eine Fehlermeldung mit Medien-Alternative wird angezeigt |
