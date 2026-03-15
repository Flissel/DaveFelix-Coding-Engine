@@smoke @@regression
Feature: Status anzeigen
  As a Endnutzer
  I want to den Kontakt-Status in der Kontaktliste anzeigen
  So that damit ich die Erreichbarkeit meiner Kontakte schnell einschätzen kann und die Kommunikation effizienter wird

  Background:
    Given ich bin angemeldet und habe eine Kontaktliste

  @@smoke @@regression @@happy-path
  Scenario: Kontakt-Status wird korrekt in der Liste angezeigt
    # Happy Path: Status jedes Kontakts wird sichtbar und korrekt angezeigt
    Given die Kontakte haben aktuelle Statuswerte
    When ich die Kontaktliste öffne
    Then wird der Status jedes Kontakts sichtbar angezeigt
    And die angezeigten Statuswerte entsprechen den aktuellen Daten

  @@regression @@edge
  Scenario: Neutraler Platzhalterstatus bei fehlendem Status oder fehlender Freigabe
    # Edge Case: Kontakte ohne Status oder ohne Freigabe zeigen neutralen Platzhalter
    Given ein Kontakt hat keinen verfügbaren Status oder erlaubt keine Statusanzeige
    When die Kontaktliste angezeigt wird
    Then wird ein neutraler Platzhalterstatus angezeigt
    And es werden keine personenbezogenen Details preisgegeben

  @@regression @@negative
  Scenario: Fehlermeldung und letzter bekannter Status bei Netzwerkstörung
    # Error Scenario: Netzwerkstörung beim Abruf des Status
    Given es besteht eine vorübergehende Netzwerkstörung
    And es existiert ein letzter bekannter Status für jeden Kontakt
    When der Kontakt-Status abgerufen werden soll
    Then wird eine verständliche Fehlermeldung angezeigt
    And der letzte bekannte Status bleibt sichtbar

  @@regression @@boundary
  Scenario Outline: Grenzwerte für Anzahl von Kontakten in der Liste
    # Boundary Condition: Statusanzeige für minimale und maximale Kontaktanzahl
    Given eine Kontaktliste mit <contact_count> Kontakten
    And alle Kontakte haben aktuelle Statuswerte
    When ich die Kontaktliste öffne
    Then wird der Status jedes Kontakts sichtbar angezeigt
    And die Liste wird ohne fehlende Statusanzeige dargestellt

    Examples:
      | contact_count |
      | 1 |
      | 500 |

  @@regression @@happy-path
  Scenario Outline: Statuswerte mit unterschiedlichen Typen
    # Data-driven: Anzeige verschiedener Statuswerte
    Given ein Kontakt hat den Statuswert <status_value>
    When die Kontaktliste angezeigt wird
    Then wird der Statuswert <status_value> korrekt angezeigt

    Examples:
      | status_value |
      | online |
      | abwesend |
      | beschäftigt |
      | offline |
