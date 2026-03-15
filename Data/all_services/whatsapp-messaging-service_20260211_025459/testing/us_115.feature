@@smoke @@regression
Feature: Share-Extension
  As a registrierter Endnutzer
  I want to einen Inhalt aus der App über die System-Share-Extension an andere Apps teilen
  So that Inhalte schnell und plattformübergreifend teilen zu können, ohne die App zu verlassen

  Background:
    Given der Nutzer ist in der App angemeldet und sieht einen teilbaren Inhalt

  @@smoke @@regression @@happy-path
  Scenario: Teilen eines Inhalts an eine verfügbare Ziel-App
    # Happy path: Inhalt wird an eine ausgewählte Ziel-App übergeben und bestätigt
    Given die System-Share-Extension ist verfügbar
    When der Nutzer die Teilen-Funktion auswählt und die Ziel-App "Mail" auswählt
    Then der Inhalt wird korrekt an die Ziel-App übergeben
    And eine Bestätigung wird in der App angezeigt

  @@regression @@edge
  Scenario: Verfügbare Share-Optionen bei eingeschränkten Ziel-Apps
    # Edge case: Gerät hat eingeschränkte oder keine kompatiblen Ziel-Apps
    Given das Gerät hat eingeschränkte Share-Optionen oder keine kompatiblen Ziel-Apps
    When der Nutzer die Teilen-Funktion aufruft
    Then das System zeigt die verfügbaren Optionen an
    And das System informiert, falls keine kompatiblen Ziel-Apps vorhanden sind

  @@regression @@negative
  Scenario: Temporärer Fehler beim Öffnen der Share-Extension
    # Error scenario: temporärer Fehler führt zu verständlicher Fehlermeldung und Retry
    Given beim Aufruf der System-Share-Extension tritt ein temporärer Fehler auf
    When der Nutzer die Teilen-Funktion auslöst
    Then das System zeigt eine verständliche Fehlermeldung an
    And das System bietet eine erneute Ausführung an

  @@regression @@boundary
  Scenario Outline: Teilen verschiedener Inhaltstypen mit Share-Extension
    # Boundary condition: unterschiedliche Inhaltstypen werden korrekt übergeben
    Given die System-Share-Extension ist verfügbar
    When der Nutzer die Teilen-Funktion auswählt und die Ziel-App "Nachrichten" auswählt
    Then der Inhaltstyp wird korrekt an die Ziel-App übergeben
    And eine Bestätigung wird angezeigt

    Examples:
      | content_type | content_size |
      | Text | 1 Zeichen |
      | Bild | Maximal zulässige Größe |
      | Link | Lange URL |

  @@regression @@happy-path
  Scenario Outline: Share-Extension öffnet sich mit variierenden Ziel-Apps
    # Data-driven success: unterschiedliche Ziel-Apps sind wählbar
    Given die System-Share-Extension ist verfügbar
    When der Nutzer die Teilen-Funktion auswählt und eine Ziel-App auswählt
    Then der Inhalt wird an die ausgewählte Ziel-App übergeben
    And eine Bestätigung wird angezeigt

    Examples:
      | target_app |
      | Mail |
      | Nachrichten |
      | Notizen |
