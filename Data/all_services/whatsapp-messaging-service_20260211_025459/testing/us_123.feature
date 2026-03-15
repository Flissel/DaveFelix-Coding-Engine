@@smoke @@regression
Feature: Sticker-Vorschlaege
  As a Endnutzer
  I want to kontextbasierte Sticker-Vorschläge beim Schreiben einer Nachricht erhalten
  So that schneller und intuitiver antworten zu können, ohne lange nach passenden Stickern zu suchen

  Background:
    Given der Endnutzer befindet sich in einem aktiven Chat und die Sticker-Funktion ist verfügbar

  @@smoke @@regression @@happy-path
  Scenario Outline: Kontextbasierte Sticker-Vorschläge bei erkennbarem Kontext
    # Happy path: passende Vorschläge werden schnell angezeigt
    Given der Endnutzer hat Sticker-Vorschläge in den Einstellungen aktiviert
    When der Endnutzer tippt eine Nachricht mit erkennbarem Kontext: "<message>"
    Then das System zeigt innerhalb kurzer Zeit passende Sticker-Vorschläge an
    And die Vorschläge passen semantisch zum Kontext "<context>"

    Examples:
      | message | context |
      | Alles Gute zum Geburtstag! | Geburtstag |
      | Herzlichen Glückwunsch zur Beförderung! | Gratulation |

  @@regression @@edge
  Scenario Outline: Allgemeine Sticker-Vorschläge bei mehrdeutigem Kontext
    # Edge case: neutrale oder mehrdeutige Eingabe führt zu allgemeinen Vorschlägen
    Given der Endnutzer hat Sticker-Vorschläge in den Einstellungen aktiviert
    When der Endnutzer tippt eine Nachricht mit neutralem Kontext: "<message>"
    Then das System zeigt allgemeine, nicht aufdringliche Sticker-Vorschläge an
    And die Vorschläge sind nicht thematisch stark spezialisiert

    Examples:
      | message |
      | Ok |
      | Alles klar |

  @@regression @@negative
  Scenario: Keine Vorschläge bei deaktivierten Sticker-Vorschlägen
    # Error/negative: deaktivierte Funktion zeigt keine Vorschläge
    Given der Endnutzer hat Sticker-Vorschläge in den Einstellungen deaktiviert
    When der Endnutzer tippt eine Nachricht mit erkennbarem Kontext
    Then es werden keine Sticker-Vorschläge angezeigt
    And die Nachrichteneingabe bleibt ohne Verzögerung

  @@regression @@negative
  Scenario: Keine Vorschläge bei nicht verfügbarem Kontextanalyse-Dienst
    # Error scenario: externer Dienst ist nicht verfügbar
    Given der Dienst zur Kontextanalyse ist vorübergehend nicht verfügbar
    When der Endnutzer tippt eine Nachricht
    Then die Nachrichteneingabe wird ohne Verzögerung fortgesetzt
    And es werden keine Sticker-Vorschläge angezeigt

  @@regression @@boundary
  Scenario Outline: Grenzfall: sehr lange Nachricht mit erkennbarem Kontext
    # Boundary: lange Eingabe darf die Vorschlagsanzeige nicht blockieren
    Given der Endnutzer hat Sticker-Vorschläge in den Einstellungen aktiviert
    When der Endnutzer tippt eine sehr lange Nachricht mit erkennbarem Kontext: "<message>"
    Then das System zeigt passende Sticker-Vorschläge an
    And die Eingabe bleibt flüssig ohne spürbare Verzögerung

    Examples:
      | message |
      | Herzlichen Glückwunsch zum Geburtstag! Ich hoffe, du hast einen wunderbaren Tag mit vielen Überraschungen, Kuchen und lieben Menschen um dich herum. Alles Liebe! |
