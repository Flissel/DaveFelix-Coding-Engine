@smoke @regression
Feature: Lokale Sticker
  As a registrierter Nutzer
  I want to regionalspezifische Sticker-Packs im Sticker-Bereich auswählen und verwenden
  So that um lokal relevante Inhalte schnell und intuitiv in Nachrichten zu teilen und die Kommunikation persönlicher zu gestalten

  Background:
    Given der Nutzer ist registriert und im Sticker-Bereich angemeldet

  @@smoke @@regression @@happy-path
  Scenario: Regionale Sticker-Packs werden für erkannte Region angezeigt
    # Happy path: passende lokale Packs werden angezeigt und auswählbar
    Given die Region wird anhand der Sprache/Region als "de-DE" erkannt
    When der Nutzer ruft die Sticker-Pack-Übersicht auf
    Then werden regionalspezifische Sticker-Packs für "de-DE" angezeigt
    And die Packs können ausgewählt und geöffnet werden

  @@regression @@happy-path
  Scenario Outline: Regionale Sticker-Packs mit unterstützter Region (Outline)
    # Happy path mit mehreren unterstützten Regionen
    Given die Region wird anhand der Sprache/Region als "<region>" erkannt
    When der Nutzer ruft die Sticker-Pack-Übersicht auf
    Then werden regionalspezifische Sticker-Packs für "<region>" angezeigt
    And die Anzahl der angezeigten Packs ist mindestens <min_packs>

    Examples:
      | region | min_packs |
      | de-DE | 1 |
      | fr-FR | 1 |

  @@regression @@edge-case
  Scenario Outline: Keine lokalen Sticker-Packs verfügbar
    # Edge case: Region ohne lokale Packs zeigt Standardauswahl und Hinweis
    Given die Region wird anhand der Sprache/Region als "<region>" erkannt
    And für die Region "<region>" sind keine lokalen Sticker-Packs verfügbar
    When der Nutzer ruft die Sticker-Pack-Übersicht auf
    Then wird eine neutrale Standardauswahl angezeigt
    And es wird ein Hinweis angezeigt, dass keine lokalen Packs verfügbar sind

    Examples:
      | region |
      | is-IS |
      | ga-IE |

  @@regression @@negative
  Scenario: Sticker-Server nicht erreichbar beim Laden lokaler Packs
    # Error scenario: Fehlermeldung und Fallback auf Cache oder Standard
    Given die Region wird anhand der Sprache/Region als "de-DE" erkannt
    And der Sticker-Server ist nicht erreichbar
    When der Nutzer versucht ein regionalspezifisches Sticker-Pack zu laden
    Then erhält der Nutzer eine Fehlermeldung
    And es werden zwischengespeicherte oder Standard-Sticker angeboten

  @@regression @@edge-case
  Scenario Outline: Boundary: Region-Erkennung mit Grenzfall-Sprachcode
    # Boundary condition: minimale unterstützte Sprach-Region-Kombination
    Given die Region wird anhand der Sprache/Region als "<region>" erkannt
    And für die Region "<region>" sind lokale Sticker-Packs verfügbar
    When der Nutzer ruft die Sticker-Pack-Übersicht auf
    Then werden regionalspezifische Sticker-Packs für "<region>" angezeigt
    And die Anzeige bleibt korrekt formatiert

    Examples:
      | region |
      | en-GB |
      | pt-BR |
