@@smoke @@regression
Feature: Mediensuche - Filter nach Medientypen
  As a registrierter Nutzer
  I want to in der Mediensuche nach Medientypen filtern
  So that relevante Inhalte schneller finden und die Bedienung intuitiv halten

  Background:
    Given der Nutzer ist registriert und in der Mediensuche angemeldet
    And es existiert ein Medienkatalog mit mehreren Medientypen

  @@happy-path @@smoke @@regression
  Scenario: Filter nach einem einzelnen Medientyp zeigt nur passende Medien
    # Happy path für die Auswahl eines Medientyps
    Given in der Ergebnisliste sind Medien der Typen "Video" und "Audio" vorhanden
    When der Nutzer den Medientyp-Filter "Video" auswählt
    Then werden nur Medien vom Typ "Video" angezeigt
    And alle angezeigten Treffer haben den Medientyp "Video"

  @@happy-path @@regression
  Scenario: Mehrfachauswahl von Medientypen zeigt Vereinigung der Treffer
    # Happy path für mehrere ausgewählte Medientypen
    Given in der Ergebnisliste sind Medien der Typen "Video", "Audio" und "Bild" vorhanden
    When der Nutzer die Medientyp-Filter "Audio" und "Bild" auswählt
    Then werden nur Medien angezeigt, die vom Typ "Audio" oder "Bild" sind
    And Medien vom Typ "Video" werden nicht angezeigt

  @@edge-case @@regression
  Scenario: Keine Treffer für gewählten Medientyp
    # Edge case wenn der gewählte Typ nicht existiert
    Given in der Ergebnisliste existieren keine Medien vom Typ "Dokument"
    When der Nutzer den Medientyp-Filter "Dokument" auswählt
    Then wird eine leere Ergebnisliste angezeigt
    And ein Hinweis über fehlende Treffer wird angezeigt

  @@negative @@regression
  Scenario: Ungültiger Medientyp-Filter wird abgelehnt
    # Error scenario bei ungültigem Filterwert
    Given der Nutzer sieht verfügbare Medientyp-Filter
    When der Nutzer einen nicht unterstützten Medientyp-Filter "UNKNOWN" auswählt
    Then wird ein validierungsnaher Hinweis zur ungültigen Auswahl angezeigt
    And die Ergebnisliste bleibt unverändert

  @@boundary @@regression
  Scenario: Grenzfall: Auswahl aller verfügbaren Medientypen
    # Boundary condition bei maximaler Filterauswahl
    Given es sind die Medientypen "Video", "Audio", "Bild" und "Dokument" verfügbar
    When der Nutzer alle verfügbaren Medientyp-Filter auswählt
    Then werden Medien aller ausgewählten Typen angezeigt
    And die Trefferanzahl entspricht der ungefilterten Suche

  @@regression
  Scenario Outline: Filterkombinationen mit unterschiedlichen Medientypen
    # Data-driven Prüfung verschiedener Mehrfachauswahlen
    Given in der Ergebnisliste sind Medien der Typen "Video", "Audio", "Bild" und "Dokument" vorhanden
    When der Nutzer die Medientyp-Filter <filter_1> und <filter_2> auswählt
    Then werden nur Medien angezeigt, die vom Typ <filter_1> oder <filter_2> sind
    And Medien anderer Typen werden nicht angezeigt

    Examples:
      | filter_1 | filter_2 |
      | Video | Audio |
      | Bild | Dokument |
