@smoke @regression
Feature: Kontrast
  As a Endnutzer
  I want to die Benutzeroberflaeche lesen und bedienen
  So that Inhalte schnell und fehlerfrei zu erfassen, um eine einfache und intuitive Bedienung sicherzustellen

  Background:
    Given die Anwendung ist geladen und eine Kontrastpruefung ist verfuegbar

  @happy-path @smoke @regression
  Scenario: Standard-Theme liefert ausreichenden Kontrast fuer Texte und interaktive Elemente
    # Happy path fuer Standard-Theme mit gueltigem Kontrast
    Given ein Standard-Theme der Anwendung ist aktiv
    When Text und interaktive Elemente angezeigt werden
    Then alle Text-Hintergrund-Kombinationen weisen einen ausreichenden Farbkontrast auf
    And die Inhalte sind gut lesbar

  @happy-path @regression
  Scenario: Hochkontrastmodus passt Farben automatisch an
    # Happy path fuer barrierefreie Ansicht mit automatischer Anpassung
    Given der Nutzer aktiviert den Hochkontrastmodus
    When die Oberflaeche neu gerendert wird
    Then Farben werden automatisch angepasst
    And der Kontrast bleibt ausreichend

  @negative @regression
  Scenario: Warnung und Speichern verhindern bei zu geringem Kontrast
    # Error scenario fuer Administrator-Konfiguration mit unzureichendem Kontrast
    Given ein Administrator konfiguriert ein eigenes Farbschema
    When eine Farbwahl zu geringem Kontrast fuehrt
    Then wird eine Warnung angezeigt
    And das Speichern wird verhindert, bis der Kontrast ausreichend ist

  @edge @regression
  Scenario Outline: Kontrastgrenzen fuer Konfiguration des Farbschemas
    # Boundary conditions fuer minimalen ausreichenden Kontrast
    Given ein Administrator bearbeitet ein Farbschema
    When die Kontrastpruefung mit dem Wert <contrast_ratio> ausgefuehrt wird
    Then <expected_outcome>
    And <save_behavior>

    Examples:
      | contrast_ratio | expected_outcome | save_behavior |
      | 4.5:1 | kein Warnhinweis wird angezeigt | das Speichern ist erlaubt |
      | 4.49:1 | ein Warnhinweis wird angezeigt | das Speichern ist verhindert |

  @edge @regression
  Scenario Outline: Kontrastpruefung fuer unterschiedliche Elementtypen
    # Edge case fuer verschiedene Text- und Hintergrundkombinationen
    Given ein Standard-Theme der Anwendung ist aktiv
    When das Element <element_type> mit der Textfarbe <text_color> auf Hintergrund <bg_color> gerendert wird
    Then der Kontrast wird als <result> bewertet
    And <ui_feedback>

    Examples:
      | element_type | text_color | bg_color | result | ui_feedback |
      | Button-Label | weiss | dunkelblau | ausreichend | keine Warnung wird angezeigt |
      | Link-Text | hellgrau | weiss | unzureichend | eine Warnung wird angezeigt |
