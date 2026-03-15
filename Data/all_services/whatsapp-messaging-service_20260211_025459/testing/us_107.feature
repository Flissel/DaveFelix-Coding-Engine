@@smoke @@regression
Feature: Schriftgroesse anpassen
  As a Endnutzer
  I want to die Schriftgroesse in der Anwendung anpassen
  So that die Lesbarkeit zu verbessern und die Bedienung einfacher und barrierearmer zu machen

  Background:
    Given der Endnutzer ist angemeldet und die Anwendung ist geladen
    And die Einstellungen sind erreichbar

  @@smoke @@regression @@happy-path
  Scenario: Schriftgroesse wird sofort auf alle Textbereiche angewendet
    # Happy path: Auswahl einer gueltigen Schriftgroesse in den Einstellungen
    Given der Endnutzer ist in den Einstellungen der Anwendung
    When er waehlt die Schriftgroesse "Mittel" aus
    Then alle Textbereiche der Anwendung werden sofort mit der Schriftgroesse "Mittel" angezeigt
    And es treten keine Layoutfehler auf

  @@regression @@happy-path
  Scenario: Schriftgroesse bleibt nach Neustart erhalten
    # Happy path: Persistenz der Auswahl nach Neustart oder Reload
    Given der Endnutzer hat die Schriftgroesse "Gross" ausgewaehlt
    When er die Anwendung neu startet oder die Seite neu laedt
    Then wird die Schriftgroesse "Gross" weiterhin verwendet
    And alle Textbereiche erscheinen in der gespeicherten Schriftgroesse

  @@regression @@boundary
  Scenario Outline: Grenzwerte der Schriftgroesse werden korrekt gesetzt
    # Boundary condition: Auswahl der kleinsten oder groessten zulaessigen Schriftgroesse
    Given der Endnutzer ist in den Einstellungen der Anwendung
    When er waehlt die Schriftgroesse "<size>" aus und bestaetigt die Auswahl
    Then das System stellt die Schriftgroesse auf den zulaessigen Grenzwert "<size>" ein
    And es treten keine Layoutfehler auf

    Examples:
      | size |
      | Kleinste |
      | Groesste |

  @@regression @@negative
  Scenario Outline: Ungueltige Schriftgroesse wird abgelehnt
    # Error scenario: Ungueltige Eingabe ueber Schnittstelle oder Feld
    Given die letzte gueltige Schriftgroesse ist "Mittel"
    When eine ungueltige Schriftgroessenangabe "<invalid_value>" uebermittelt wird
    Then wird die ungueltige Angabe abgelehnt
    And die Schriftgroesse bleibt auf "Mittel"

    Examples:
      | invalid_value |
      | -1 |
      | 999 |
      | abc |
      |  |

  @@regression @@edge-case
  Scenario: Schriftgroesse wird in mehreren Bereichen konsistent angezeigt
    # Edge case: unterschiedliche Textbereiche aktualisieren sich konsistent
    Given der Endnutzer befindet sich auf einer Seite mit Menue, Inhalt und Footer
    When er waehlt die Schriftgroesse "Klein" aus
    Then Menue, Inhalt und Footer werden sofort mit der Schriftgroesse "Klein" angezeigt
    And es gibt keine abgeschnittenen Texte oder Ueberlappungen
