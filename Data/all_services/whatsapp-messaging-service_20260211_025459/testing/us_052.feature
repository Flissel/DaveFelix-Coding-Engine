@@smoke @@regression
Feature: GIFs in Chat senden
  As a Nutzer
  I want to GIFs suchen und in einer Nachricht senden
  So that um Kommunikation schneller, anschaulicher und plattformuebergreifend zu gestalten

  Background:
    Given der Nutzer befindet sich im Chat
    And der Nutzer hat eine aktive Netzwerkverbindung

  @@smoke @@regression @@happy-path
  Scenario Outline: GIF suchen und erfolgreich senden
    # Happy path: GIF wird gesucht, ausgewählt, eingefügt und gesendet
    When der Nutzer nach dem Suchbegriff "<suchbegriff>" sucht
    And der Nutzer ein GIF aus den Ergebnissen auswählt
    Then das GIF wird in die Nachricht eingefügt
    And die Nachricht mit dem GIF wird erfolgreich zugestellt

    Examples:
      | suchbegriff |
      | lustig |
      | katzen |

  @@regression @@edge
  Scenario Outline: Keine Treffer bei GIF-Suche
    # Edge case: keine Ergebnisse für den Suchbegriff
    When der Nutzer nach dem Suchbegriff "<suchbegriff>" sucht
    Then das System zeigt eine leere Ergebnisliste mit Hinweis
    And das System bietet die Möglichkeit, die Suche zu verändern

    Examples:
      | suchbegriff |
      | asdkfjhasdkjfh |
      | zzzzzzzzzz |

  @@regression @@negative
  Scenario: GIF-Suche nicht verfügbar wegen Dienstfehler
    # Error scenario: Dienstfehler bei der GIF-Suche
    Given die GIF-Suche ist aufgrund eines Dienstfehlers nicht verfügbar
    When der Nutzer eine GIF-Suche startet
    Then das System zeigt eine Fehlermeldung an
    And das System bietet eine erneute Anfrage an ohne die Chat-Funktion zu blockieren

  @@regression @@boundary
  Scenario Outline: Boundary: sehr kurzer und sehr langer Suchbegriff
    # Boundary conditions für minimale und maximale Suchbegriffslänge
    When der Nutzer nach dem Suchbegriff "<suchbegriff>" sucht
    Then die Suche wird ausgeführt und liefert entweder Ergebnisse oder einen leeren Hinweis
    And die Chat-Funktion bleibt bedienbar

    Examples:
      | suchbegriff |
      | a |
      | aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa |
