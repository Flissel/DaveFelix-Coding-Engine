@@smoke @@regression
Feature: Warenkorb
  As a registrierter Kunde
  I want to Artikel in einem Warenkorb sammeln und die Bestellung vorbereiten
  So that damit ich meine Auswahl bequem überprüfen und die Bestellung effizient abschließen kann

  Background:
    Given der Nutzer ist eingeloggt und der Shop ist verfügbar

  @@happy-path @@smoke @@regression
  Scenario Outline: Artikel zum Warenkorb hinzufügen (Happy Path)
    # Stellt sicher, dass ein Artikel mit korrekter Menge und Preis angezeigt wird
    Given der Warenkorb ist leer
    When der Nutzer fügt den Artikel "{artikel}" mit Menge {menge} zum Warenkorb hinzu
    Then der Warenkorb zeigt den Artikel "{artikel}" mit Menge {menge} und Preis {preis} an
    And die Zwischensumme und Gesamtsumme entsprechen {erwartete_summe}

    Examples:
      | artikel | menge | preis | erwartete_summe |
      | Kaffeemaschine | 1 | 79.99 EUR | 79.99 EUR |
      | Kopfhörer | 2 | 49.50 EUR | 99.00 EUR |

  @@regression
  Scenario Outline: Menge ändern oder Artikel entfernen aktualisiert Summen sofort
    # Validiert die sofortige Aktualisierung von Zwischensumme und Gesamtsumme
    Given der Warenkorb enthält den Artikel "{artikel}" mit Menge {start_menge} und Preis {preis} pro Stück
    When der Nutzer setzt die Menge des Artikels auf {neue_menge}
    Then der Warenkorb zeigt die aktualisierte Menge {neue_menge} an
    And die Zwischensumme und Gesamtsumme entsprechen {erwartete_summe}

    Examples:
      | artikel | start_menge | preis | neue_menge | erwartete_summe |
      | Laptop | 1 | 999.00 EUR | 2 | 1998.00 EUR |
      | Maus | 3 | 20.00 EUR | 0 | 0.00 EUR |

  @@edge @@regression
  Scenario Outline: Edge Case: Maximale Menge pro Artikel
    # Überprüft die Behandlung der oberen Mengenbegrenzung
    Given der Warenkorb enthält den Artikel "{artikel}" mit Menge {start_menge}
    When der Nutzer erhöht die Menge auf {neue_menge}
    Then der Warenkorb zeigt die Menge {erwartete_menge} an
    And eine Meldung informiert über die maximale Menge {max_menge}

    Examples:
      | artikel | start_menge | neue_menge | erwartete_menge | max_menge |
      | Smartphone | 9 | 10 | 10 | 10 |
      | Smartphone | 10 | 11 | 10 | 10 |

  @@boundary @@regression
  Scenario Outline: Boundary Condition: Menge auf Minimum setzen
    # Validiert die untere Grenze bei Menge 1
    Given der Warenkorb enthält den Artikel "{artikel}" mit Menge {start_menge}
    When der Nutzer reduziert die Menge auf {neue_menge}
    Then der Warenkorb zeigt die Menge {erwartete_menge} an
    And die Summen werden korrekt aktualisiert

    Examples:
      | artikel | start_menge | neue_menge | erwartete_menge |
      | Buch | 2 | 1 | 1 |

  @@negative @@regression
  Scenario Outline: Error Scenario: Backend nicht erreichbar beim Hinzufügen
    # Stellt sicher, dass eine verständliche Fehlermeldung angezeigt wird und der Warenkorb unverändert bleibt
    Given der Warenkorb enthält {start_anzahl} Artikel
    And der Shop oder das Backend ist vorübergehend nicht erreichbar
    When der Nutzer versucht den Artikel "{artikel}" hinzuzufügen
    Then der Nutzer erhält eine verständliche Fehlermeldung
    And der Warenkorb bleibt mit {start_anzahl} Artikeln unverändert

    Examples:
      | artikel | start_anzahl |
      | Tablet | 1 |
