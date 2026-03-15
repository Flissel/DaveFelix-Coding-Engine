@smoke @regression
Feature: HD-Medien
  As a Endnutzer
  I want to Medien in HD-Qualität senden
  So that damit Inhalte klar und professionell dargestellt werden und die Kommunikation hochwertiger wirkt

  Background:
    Given ein registrierter Nutzer ist angemeldet

  @@smoke @@regression @@happy-path
  Scenario Outline: HD-Medium senden mit unterstütztem Format
    # Happy path für unterstützte Bild- und Videoformate mit HD-Option
    Given der Nutzer wählt ein unterstütztes Medium vom Typ <media_type> im Format <format> aus
    When der Nutzer aktiviert die HD-Option und sendet das Medium
    Then das Medium wird in HD-Qualität zugestellt
    And das Medium wird korrekt angezeigt

    Examples:
      | media_type | format |
      | Bild | JPEG |
      | Bild | PNG |
      | Video | MP4 |

  @@regression @@edge
  Scenario: HD-Senden bei begrenzter Bandbreite mit Hinweis
    # Edge Case: System informiert über längere Übertragungszeit und erlaubt HD-Senden
    Given der Nutzer befindet sich auf einem Gerät mit begrenzter Bandbreite
    And der Nutzer wählt ein unterstütztes Medium aus
    When der Nutzer aktiviert die HD-Option und sendet das Medium
    Then das System informiert über mögliche längere Übertragungszeit
    And das Medium wird in HD gesendet

  @@regression @@edge
  Scenario: HD-Senden bei begrenzter Bandbreite mit Qualitätsreduktion
    # Edge Case: Nutzer erhält Option zur Qualitätsreduktion bei niedriger Bandbreite
    Given der Nutzer befindet sich auf einem Gerät mit begrenzter Bandbreite
    And der Nutzer wählt ein unterstütztes Medium aus
    When der Nutzer aktiviert die HD-Option und sendet das Medium
    Then das System bietet eine Qualitätsreduktion als Alternative an
    And die Auswahl der Qualitätsreduktion sendet das Medium in reduzierter Qualität

  @@regression @@negative
  Scenario Outline: Nicht unterstütztes Dateiformat blockiert
    # Error Scenario: Versand wird blockiert und Fehlermeldung mit unterstützten Formaten angezeigt
    Given der Nutzer wählt ein Medium im nicht unterstützten Format <format> aus
    When der Nutzer startet den Sendevorgang mit aktivierter HD-Option
    Then das System blockiert den Versand
    And das System zeigt eine verständliche Fehlermeldung mit unterstützten Formaten an

    Examples:
      | format |
      | TIFF |
      | AVI |
      | MKV |

  @@regression @@boundary
  Scenario Outline: Grenzfall: Maximale erlaubte Dateigröße in HD
    # Boundary Condition: Medium mit maximal zulässiger Größe wird in HD gesendet
    Given der Nutzer wählt ein unterstütztes Medium mit der maximal erlaubten Dateigröße <max_size_mb> MB aus
    When der Nutzer aktiviert die HD-Option und sendet das Medium
    Then das Medium wird in HD-Qualität zugestellt
    And keine Fehlermeldung zur Dateigröße wird angezeigt

    Examples:
      | max_size_mb |
      | 100 |
