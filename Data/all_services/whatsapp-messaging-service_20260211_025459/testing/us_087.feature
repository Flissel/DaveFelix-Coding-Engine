@@smoke @@regression
Feature: Chat-Hintergrund
  As a registrierter Nutzer
  I want to den Chat-Hintergrund aus vordefinierten Optionen auswählen und speichern
  So that Chats personalisieren und die Bedienung angenehmer gestalten

  Background:
    Given der Nutzer ist registriert und angemeldet
    And der Nutzer befindet sich in den Chat-Einstellungen

  @@smoke @@regression @@happy-path
  Scenario Outline: Hintergrund auswählen und speichern (Happy Path)
    # Prüft, dass ein gewählter Hintergrund sofort und dauerhaft angewendet wird
    When der Nutzer wählt den Hintergrund "<background>" aus
    And der Nutzer speichert die Auswahl
    Then der Hintergrund "<background>" wird im aktuellen Chatverlauf angezeigt
    And der Hintergrund "<background>" wird in zukünftigen Chats angezeigt

    Examples:
      | background |
      | Nachtmodus |
      | Hell |

  @@regression @@edge
  Scenario Outline: Auf Standard-Hintergrund zurücksetzen (Edge Case)
    # Prüft, dass ein bereits gesetzter Hintergrund auf Standard zurückgesetzt werden kann
    Given der Nutzer hat den Hintergrund "<previous_background>" festgelegt
    When der Nutzer setzt den Hintergrund auf Standard zurück
    Then der Standard-Hintergrund wird sofort angewendet
    And der Standard-Hintergrund wird gespeichert

    Examples:
      | previous_background |
      | Nachtmodus |

  @@regression @@negative
  Scenario: Hintergrundliste kann nicht geladen werden (Error Scenario)
    # Prüft die Fehlermeldung und dass der bisherige Hintergrund aktiv bleibt
    Given die Hintergrundliste kann aufgrund eines Fehlers nicht geladen werden
    When der Nutzer die Chat-Einstellungen öffnet
    Then eine verständliche Fehlermeldung wird angezeigt
    And der bisherige Hintergrund bleibt aktiv

  @@regression @@boundary
  Scenario Outline: Grenzwerte der Auswahloptionen (Boundary Condition)
    # Prüft, dass die erste und letzte verfügbare Option gewählt und gespeichert werden können
    Given die Hintergrundliste enthält "<position>" verfügbare Option
    When der Nutzer wählt die "<position>" Option aus und speichert
    Then die "<position>" Option wird als Hintergrund angewendet
    And die Auswahl ist für zukünftige Chats gespeichert

    Examples:
      | position |
      | erste |
      | letzte |
