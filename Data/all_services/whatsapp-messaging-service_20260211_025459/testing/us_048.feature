@smoke @regression
Feature: Videos senden
  As a registrierter Nutzer
  I want to ein Video in einem Chat senden
  So that damit ich Inhalte schnell und anschaulich teilen kann und die Kommunikation effizienter wird

  Background:
    Given der Nutzer ist registriert, angemeldet und befindet sich in einem bestehenden Chat

  @smoke @regression @happy-path
  Scenario: Video erfolgreich senden und im Chat anzeigen
    # Happy path: unterstütztes Video wird erfolgreich gesendet und sichtbar
    Given ein unterstütztes Video mit gültigem Format und erlaubter Größe ist ausgewählt
    When der Nutzer auf Senden tippt
    Then das Video wird erfolgreich übertragen
    And das Video wird im Chat für alle Teilnehmer sichtbar angezeigt

  @regression @boundary
  Scenario: Video mit maximal erlaubter Dateigröße senden
    # Boundary condition: Video exakt an der Größenobergrenze wird akzeptiert
    Given ein unterstütztes Video mit Dateigröße genau der maximal erlaubten Größe ist ausgewählt
    When der Nutzer auf Senden tippt
    Then das Video wird erfolgreich übertragen
    And das Video wird im Chat sichtbar angezeigt

  @regression @negative
  Scenario: Upload ablehnen bei Überschreitung der maximalen Größe
    # Error scenario: Upload wird abgelehnt und verständliche Fehlermeldung angezeigt
    Given ein Video überschreitet die maximal erlaubte Dateigröße
    When der Nutzer den Sendevorgang startet
    Then der Upload wird abgelehnt
    And eine Fehlermeldung mit Hinweis auf die maximale Größe wird angezeigt

  @regression @negative
  Scenario: Netzwerkfehler beim Senden und erneuter Versuch
    # Error scenario: instabile oder fehlende Verbindung führt zu Abbruch und Retry-Option
    Given die Netzwerkverbindung ist instabil oder nicht verfügbar
    When der Nutzer ein Video senden möchte
    Then der Sendevorgang wird abgebrochen
    And eine Fehlermeldung mit Option zum erneuten Versuch wird angezeigt

  @regression @edge-case
  Scenario Outline: Unterstützte Videoformate senden
    # Edge case: unterschiedliche unterstützte Formate werden akzeptiert
    Given ein unterstütztes Videoformat <format> mit erlaubter Größe ist ausgewählt
    When der Nutzer auf Senden tippt
    Then das Video wird erfolgreich übertragen
    And das Video wird im Chat sichtbar angezeigt

    Examples:
      | format |
      | mp4 |
      | mov |
      | webm |

  @regression @negative @edge-case
  Scenario Outline: Unzulässiges Format wird abgelehnt
    # Edge case: nicht unterstütztes Videoformat wird blockiert
    Given ein nicht unterstütztes Videoformat <format> ist ausgewählt
    When der Nutzer den Sendevorgang startet
    Then der Upload wird abgelehnt
    And eine verständliche Fehlermeldung zum unterstützten Format wird angezeigt

    Examples:
      | format |
      | avi |
      | mkv |
