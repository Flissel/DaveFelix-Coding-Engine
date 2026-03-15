@smoke @regression
Feature: Chat-Hintergrund anpassen
  As a Chatnutzer
  I want to den Chat-Hintergrund aus vordefinierten Optionen anpassen
  So that damit ich die Chat-Oberfläche besser an meine Vorlieben und Lesbarkeit anpassen kann

  Background:
    Given der Chatnutzer ist im Chat und die Hintergrundeinstellungen sind verfügbar

  @smoke @regression @happy-path
  Scenario Outline: Hintergrund aus vordefinierter Liste speichern
    # Prüft, dass ein ausgewählter Hintergrund gespeichert und in zukünftigen Sitzungen geladen wird
    Given die Hintergrundeinstellungen sind geöffnet
    When der Chatnutzer den Hintergrund "<background>" auswählt
    And der Chatnutzer die Auswahl speichert
    Then wird der Hintergrund "<background>" im Chat angezeigt
    And wird der Hintergrund "<background>" in einer neuen Sitzung beibehalten

    Examples:
      | background |
      | Hell |
      | Dunkel |

  @regression @edge-case
  Scenario Outline: Auswahl abbrechen oder keine Änderung vornehmen
    # Prüft, dass der aktive Hintergrund unverändert bleibt, wenn abgebrochen oder nichts geändert wird
    Given der aktuell aktive Hintergrund ist "<active_background>"
    When der Chatnutzer "<action>" in den Hintergrundeinstellungen ausführt
    Then bleibt der aktive Hintergrund "<active_background>" unverändert

    Examples:
      | active_background | action |
      | Hell | die Auswahl abbricht |
      | Dunkel | keine Änderung vornimmt und schließt |

  @regression @negative @error
  Scenario Outline: Speichern schlägt wegen Systemfehler fehl
    # Prüft, dass eine Fehlermeldung angezeigt wird und der vorherige Hintergrund aktiv bleibt
    Given der aktuell aktive Hintergrund ist "<active_background>"
    And die Hintergrundeinstellungen sind geöffnet
    When der Chatnutzer den Hintergrund "<new_background>" auswählt
    And der Chatnutzer die Auswahl speichert und ein Systemfehler auftritt
    Then wird eine verständliche Fehlermeldung angezeigt
    And bleibt der aktive Hintergrund "<active_background>"

    Examples:
      | active_background | new_background |
      | Hell | Dunkel |

  @regression @boundary
  Scenario Outline: Grenzwerte der Hintergrundliste auswählen
    # Prüft, dass der erste und letzte Hintergrund aus der Liste korrekt gespeichert werden
    Given die Hintergrundeinstellungen sind geöffnet
    When der Chatnutzer den Hintergrund an Position "<position>" auswählt
    And der Chatnutzer die Auswahl speichert
    Then wird der Hintergrund an Position "<position>" im Chat angezeigt
    And wird der Hintergrund an Position "<position>" in einer neuen Sitzung beibehalten

    Examples:
      | position |
      | erste |
      | letzte |
