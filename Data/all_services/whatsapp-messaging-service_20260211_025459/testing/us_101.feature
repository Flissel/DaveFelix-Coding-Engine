@smoke @regression
Feature: Produktkatalog
  As a Business-Administrator
  I want to einen Produktkatalog anlegen, pflegen und für Kunden sichtbar machen
  So that damit Kunden Produkte schnell finden und Bestellungen effizient vorbereitet werden können

  Background:
    Given der Business-Administrator ist authentifiziert und hat die Berechtigung zur Katalogverwaltung

  @smoke @regression @happy-path
  Scenario: Neuen Produktkatalog erstellen und veröffentlichen
    # Happy path: Ein neuer Katalog mit mindestens einem Produkt wird veröffentlicht und ist für Kunden sichtbar
    Given es existiert kein veröffentlichter Produktkatalog
    When der Administrator einen neuen Produktkatalog mit einem Produkt erstellt und veröffentlicht
    Then der Katalog ist für Kunden sichtbar
    And das Produkt wird mit Name, Preis und Verfügbarkeit korrekt angezeigt

  @regression @happy-path
  Scenario: Produktdaten aktualisieren oder entfernen
    # Happy path: Änderungen an Produkten sind sofort sichtbar und die Liste bleibt konsistent
    Given ein bestehender Produktkatalog mit mehreren Produkten ist veröffentlicht
    When der Administrator ein Produkt aktualisiert oder entfernt
    Then die Änderungen sind sofort im Katalog sichtbar
    And die Produktliste bleibt konsistent ohne Duplikate oder Lücken

  @regression @negative
  Scenario: Fehlende Pflichtangaben verhindern das Speichern
    # Error scenario: Ein Produkt ohne Pflichtangaben wird nicht gespeichert und zeigt eine Fehlermeldung
    Given der Administrator erstellt ein neues Produkt im Katalogeditor
    When er versucht das Produkt ohne Pflichtangaben zu speichern
    Then eine verständliche Fehlermeldung wird angezeigt
    And das Produkt wird nicht gespeichert

  @regression @boundary
  Scenario: Produkt speichern mit minimal gültigen Angaben
    # Boundary condition: Produkt wird mit minimalen Pflichtfeldern korrekt gespeichert
    Given der Administrator erstellt ein neues Produkt im Katalogeditor
    When er speichert das Produkt mit Name und Preis sowie einer Verfügbarkeit
    Then das Produkt wird gespeichert und im Katalog angezeigt
    And keine optionalen Felder sind erforderlich

  @regression @negative
  Scenario Outline: Produkt speichern ohne einzelne Pflichtfelder
    # Error scenarios: Validierung je fehlendem Pflichtfeld
    Given der Administrator erstellt ein neues Produkt im Katalogeditor
    When er versucht das Produkt mit fehlendem Pflichtfeld zu speichern
    Then eine verständliche Fehlermeldung für das fehlende Feld wird angezeigt
    And das Produkt wird nicht gespeichert

    Examples:
      | missing_field |
      | Name |
      | Preis |

  @regression @edge
  Scenario: Produktkatalog mit einem einzigen Produkt veröffentlichen
    # Edge case: Minimaler Katalogumfang ist zulässig und sichtbar
    Given der Administrator hat einen neuen Katalog mit genau einem Produkt erstellt
    When er den Katalog veröffentlicht
    Then der Katalog ist für Kunden sichtbar
    And genau ein Produkt wird korrekt angezeigt

  @regression @edge
  Scenario: Produktliste bleibt konsistent nach Löschen des letzten Produkts
    # Edge case: Entfernen eines Produkts aktualisiert die Liste ohne Inkonsistenzen
    Given ein veröffentlichter Katalog enthält genau ein Produkt
    When der Administrator dieses Produkt entfernt
    Then das Produkt ist nicht mehr im Katalog sichtbar
    And die Produktliste wird als leer angezeigt ohne Fehler
