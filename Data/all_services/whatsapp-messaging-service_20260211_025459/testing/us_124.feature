@smoke @regression
Feature: RTL-Unterstuetzung
  As a Endnutzer
  I want to die Anwendung in einer rechts-nach-links Sprache nutzen
  So that damit die Bedienung intuitiv ist und Inhalte korrekt dargestellt werden

  Background:
    Given die Anwendung ist installiert und der Nutzer ist eingeloggt

  @smoke @regression @happy-path
  Scenario: RTL-Hauptoberflaeche wird korrekt ausgerichtet
    # Validiert die vollständige RTL-Ausrichtung von Layout, Navigation und Texten bei arabischer Systemsprache
    Given die Systemsprache ist auf Arabisch eingestellt
    When der Nutzer die Hauptoberflaeche aufruft
    Then werden Layout und Navigation rechts-nach-links ausgerichtet
    And alle Texte werden in RTL korrekt angezeigt

  @regression @edge-case
  Scenario: Gemischter RTL- und LTR-Text im Chat wird lesbar dargestellt
    # Prueft die korrekte Schreibrichtung und Satzzeichenmischung bei gemischtem Inhalt
    Given eine Nachricht enthaelt gemischten Inhalt aus RTL- und LTR-Text
    When die Nachricht in einem Chat angezeigt wird
    Then werden Schreibrichtung und Satzzeichen korrekt gemischt
    And der Text bleibt lesbar ohne Zeichenvertauschung

  @regression @happy-path
  Scenario: Formularfelder in RTL zeigen Labels und Fehlermeldungen rechtsbuendig
    # Validiert die RTL-Reihenfolge und Ausrichtung von Platzhaltern, Labels und Fehlermeldungen
    Given ein Formular enthaelt Pflichtfelder und Validierungsmeldungen
    When der Nutzer das Formular in einer RTL-Sprache ausfuellt
    Then erscheinen Platzhalter und Labels rechtsbuendig
    And Fehlermeldungen werden in korrekter RTL-Reihenfolge angezeigt

  @regression @edge-case
  Scenario Outline: Scenario Outline: Unterschiedliche RTL-Sprachen auf der Hauptoberflaeche
    # Prueft die RTL-Ausrichtung fuer mehrere RTL-Systemsprachen
    Given die Systemsprache ist auf <rtl_language> eingestellt
    When der Nutzer die Hauptoberflaeche aufruft
    Then werden Layout, Navigation und Texte rechts-nach-links ausgerichtet
    And keine UI-Elemente sind linksbuendig verbleibend

    Examples:
      | rtl_language |
      | Arabisch |
      | Hebraeisch |

  @regression @boundary
  Scenario Outline: Scenario Outline: Boundary-Tests fuer gemischte Nachrichtenlaengen
    # Prueft Lesbarkeit bei minimaler und maximaler Laenge gemischter RTL/LTR-Nachrichten
    Given eine Nachricht enthaelt <message_length> gemischten RTL- und LTR-Text
    When die Nachricht in einem Chat angezeigt wird
    Then die Schreibrichtung ist korrekt fuer beide Textarten
    And Satzzeichen bleiben an der erwarteten Position

    Examples:
      | message_length |
      | 1 Zeichen |
      | 500 Zeichen |

  @regression @negative @error
  Scenario: RTL-Fehlerfall bei fehlender Lokalisierung
    # Stellt sicher, dass fehlende RTL-Strings als Fehler erkannt werden
    Given die Systemsprache ist auf Arabisch eingestellt
    And fuer ein UI-Element fehlen RTL-Strings
    When der Nutzer die Hauptoberflaeche aufruft
    Then wird ein Lokalisierungsfehler sichtbar gemacht
    And das UI zeigt einen Fallback-Text statt leerem Inhalt

  @regression @boundary @error
  Scenario Outline: Scenario Outline: Formularvalidierung in RTL mit Pflichtfeldern
    # Validiert Fehlermeldungen und Platzhalter bei leeren Pflichtfeldern in RTL
    Given ein Formular enthaelt das Pflichtfeld <field_name>
    When der Nutzer das Pflichtfeld leer laesst und das Formular absendet
    Then wird eine Fehlermeldung rechtsbuendig angezeigt
    And die Fehlermeldung erscheint in korrekter RTL-Reihenfolge

    Examples:
      | field_name |
      | E-Mail |
      | Telefon |
