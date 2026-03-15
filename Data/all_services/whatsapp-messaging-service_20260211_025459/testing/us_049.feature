@@smoke @@regression
Feature: Dokumente senden
  As a Endnutzer
  I want to beliebige Dokumente über die Plattform senden
  So that damit ich Informationen zuverlässig und sicher mit meinen Kontakten teilen kann

  Background:
    Given der Endnutzer ist angemeldet
    And eine Unterhaltung mit einem Kontakt ist geöffnet

  @@smoke @@regression @@happy-path
  Scenario: Erfolgreiches Senden eines unterstützten Dokuments
    # Happy path: Ein unterstütztes Dokument wird erfolgreich gesendet und angezeigt
    Given ein unterstütztes Dokument ist ausgewählt
    When der Endnutzer auf „Senden“ klickt
    Then das Dokument wird erfolgreich übertragen
    And das Dokument wird als gesendet in der Unterhaltung angezeigt

  @@regression @@boundary
  Scenario Outline: Dokumentgröße an der Grenze der maximal zulässigen Größe
    # Boundary: Dokumente an der Größenobergrenze werden akzeptiert, darüber abgelehnt
    Given ein Dokument mit der Größe "<file_size>" ist ausgewählt
    When der Endnutzer den Versand startet
    Then der Versand wird "<outcome>"
    And die Nutzerbenachrichtigung lautet "<message>"

    Examples:
      | file_size | outcome | message |
      | maximal zulässige Größe | erfolgreich durchgeführt | Dokument wurde gesendet |
      | maximal zulässige Größe + 1 Byte | abgelehnt | Dokument ist zu groß |

  @@regression @@negative @@edge
  Scenario Outline: Versand eines nicht unterstützten Dateityps
    # Edge case: Nicht unterstützte Dateitypen dürfen nicht gesendet werden
    Given ein Dokument mit dem Dateityp "<file_type>" ist ausgewählt
    When der Endnutzer den Versand startet
    Then der Versand wird abgelehnt
    And eine verständliche Fehlermeldung wird angezeigt

    Examples:
      | file_type |
      | exe |
      | bat |

  @@regression @@negative @@error
  Scenario: Versand schlägt fehl bei instabiler Netzwerkverbindung
    # Error: Bei fehlender stabiler Verbindung wird der Versand vollständig abgebrochen
    Given während des Versands besteht keine stabile Netzwerkverbindung
    When der Endnutzer ein Dokument senden möchte
    Then der Versand schlägt fehl
    And der Endnutzer wird über den Fehler informiert
    And das Dokument wird nicht teilweise versendet
