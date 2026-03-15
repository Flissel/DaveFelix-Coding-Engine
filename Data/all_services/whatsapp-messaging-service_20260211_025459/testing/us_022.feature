@smoke @regression
Feature: Formatierte Texte in Nachrichten
  As a Endnutzer
  I want to Nachrichten mit grundlegender Textformatierung wie Fett, Kursiv und Unterstrichen verfassen
  So that Informationen klarer und professioneller kommunizieren, um die Verständlichkeit zu erhöhen

  Background:
    Given der Nutzer ist angemeldet und der Nachrichten-Editor ist geöffnet
    And der Empfänger ist erreichbar

  @smoke @happy-path
  Scenario Outline: Erfolgreiches Rendern einzelner Formatierung
    # Prüft, dass eine einzelne unterstützte Formatierung korrekt angezeigt wird
    Given der Nutzer gibt den Nachrichtentext mit einer gültigen Markierung ein
    When der Nutzer die Nachricht sendet
    Then wird die Nachricht beim Empfänger mit der entsprechenden Formatierung angezeigt
    And es wird kein Hinweis auf ungültige Markierungen angezeigt

    Examples:
      | marked_text | expected_render |
      | **Fett** | Fett (fett formatiert) |
      | *Kursiv* | Kursiv (kursiv formatiert) |
      | __Unterstrichen__ | Unterstrichen (unterstrichen formatiert) |

  @regression @happy-path
  Scenario Outline: Mehrere Formatierungen in einem Satz
    # Prüft, dass mehrere unterstützte Formatierungen korrekt und in Reihenfolge gerendert werden
    Given der Nutzer gibt einen Satz mit mehreren gültigen Markierungen ein
    When der Nutzer die Nachricht sendet
    Then werden alle unterstützten Formatierungen korrekt und in der richtigen Reihenfolge angezeigt
    And der nicht formatierte Text bleibt unverändert

    Examples:
      | marked_text |
      | Dies ist **fett** und *kursiv* sowie __unterstrichen__. |
      | **Start** Mitte *Kursiv* Ende __U__. |

  @negative @regression
  Scenario Outline: Ungültige oder nicht unterstützte Markierungen
    # Prüft, dass ungültige Markierungen nicht gerendert werden und ein Hinweis erscheint
    Given der Nutzer gibt Text mit nicht unterstützten oder fehlerhaften Markierungen ein
    When der Nutzer die Nachricht sendet
    Then wird die Nachricht ohne diese Formatierungen angezeigt
    And der Nutzer erhält einen Hinweis auf ungültige Markierungen

    Examples:
      | marked_text |
      | Dies ist ~~durchgestrichen~~ |
      | Unvollständig **fett |
      | Falsch verschachtelt **fett *kursiv** |

  @edge @regression
  Scenario Outline: Grenzfall: leere oder nur Markierungen
    # Prüft die Darstellung bei leerem Text oder nur Markierungen ohne Inhalt
    Given der Nutzer gibt eine Eingabe ohne sichtbaren Inhalt ein
    When der Nutzer die Nachricht sendet
    Then wird eine leere Nachricht nicht formatiert angezeigt
    And ein Hinweis auf ungültige Markierungen wird angezeigt, falls Markierungen ohne Inhalt vorhanden sind

    Examples:
      | marked_text |
      |  |
      | **** |
      | __ |

  @edge @regression
  Scenario Outline: Grenzfall: sehr lange Nachricht mit Formatierungen
    # Prüft, dass Formatierungen in langen Texten stabil gerendert werden
    Given der Nutzer gibt einen sehr langen Nachrichtentext mit gültigen Markierungen ein
    When der Nutzer die Nachricht sendet
    Then werden alle Markierungen korrekt gerendert
    And es tritt kein Abschneiden oder Reihenfolgefehler auf

    Examples:
      | marked_text |
      | Lorem ipsum **fett** dolor sit amet ... (2000 Zeichen) ... *kursiv* ... __unterstrichen__ |
