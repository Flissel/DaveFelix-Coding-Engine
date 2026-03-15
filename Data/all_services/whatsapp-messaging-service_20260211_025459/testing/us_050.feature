@@smoke @@regression
Feature: Bildbearbeitung vor dem Versand
  As a Endnutzer
  I want to ein Bild vor dem Senden zuschneiden und drehen
  So that damit ich Inhalte schnell und intuitiv anpassen kann und nur relevante Informationen sicher versende

  Background:
    Given der Endnutzer befindet sich im Versand-Flow und hat Zugriff auf die Bildbearbeitung

  @@smoke @@happy-path @@regression
  Scenario: Zuschneiden und Speichern zeigt bearbeitetes Bild in der Vorschau
    # Happy Path: Zuschneiden und Speichern übernimmt das Bild für den Versand
    Given der Endnutzer hat ein gültiges Bild zum Versand ausgewählt
    When er schneidet das Bild zu und speichert die Bearbeitung
    Then wird das bearbeitete Bild in der Vorschau angezeigt
    And das bearbeitete Bild wird für den Versand verwendet

  @@regression @@happy-path
  Scenario Outline: Drehen und Rückgängig ohne Qualitätsverlust
    # Happy Path/Edge: Änderungen werden sofort sichtbar und bleiben qualitativ unverändert
    Given der Endnutzer hat ein gültiges Bild zum Versand ausgewählt
    When er führt die Aktion <aktion> aus
    Then werden die Änderungen sofort angezeigt
    And die Änderungen können ohne Qualitätsverlust übernommen werden

    Examples:
      | aktion |
      | Drehen um 90 Grad |
      | Drehen um 180 Grad |
      | Rückgängig machen des letzten Schritts |

  @@regression @@edge-case
  Scenario Outline: Zuschneiden auf minimale Größe
    # Boundary: Zuschneiden auf die minimale erlaubte Größe bleibt gültig
    Given der Endnutzer hat ein Bild mit ausreichend hoher Auflösung ausgewählt
    When er schneidet das Bild auf die minimale erlaubte Größe von <min_breite>x<min_hoehe> zu und speichert
    Then wird das zugeschnittene Bild in der Vorschau angezeigt
    And das Bild wird für den Versand akzeptiert

    Examples:
      | min_breite | min_hoehe |
      | 64 | 64 |

  @@negative @@regression
  Scenario Outline: Nicht unterstütztes Bildformat oder Bearbeitungsfehler
    # Error: Fehlermeldung bei nicht unterstütztem Format oder Bearbeitungsfehler
    Given der Endnutzer hat ein Bild mit dem Format <format> ausgewählt
    When die Bearbeitung fehlschlägt oder das Format nicht unterstützt wird
    Then erhält er eine verständliche Fehlermeldung
    And er kann ein anderes Bild auswählen

    Examples:
      | format |
      | TIFF |
      | RAW |
