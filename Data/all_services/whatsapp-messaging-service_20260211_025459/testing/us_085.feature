@@smoke @@regression
Feature: Speichernutzung verwalten
  As a System-Administrator
  I want to die Speichernutzung im System einsehen und verwalten
  So that um Speicherressourcen effizient zu planen und Performance sowie Compliance sicherzustellen

  Background:
    Given der Administrator ist im System angemeldet

  @@smoke @@regression @@happy-path
  Scenario: Speichernutzungsuebersicht zeigt aktuelle Belegung und Verfuegbarkeit
    # Happy Path: Anzeige von belegtem und verfuegbarem Speicher pro Bereich und Gesamtverbrauch
    Given es liegen aktuelle Speichernutzungsdaten fuer alle Bereiche vor
    When der Administrator die Uebersicht zur Speichernutzung oeffnet
    Then werden belegter und verfuegbarer Speicher pro Bereich angezeigt
    And wird der Gesamtverbrauch aktuell und konsistent zur Summe der Bereiche angezeigt

  @@regression @@happy-path
  Scenario Outline: Speichergrenze wird validiert und gespeichert
    # Happy Path: Speichern einer gueltigen Speichergrenze pro Bereich
    Given der Administrator verwaltet Speichergrenzen
    When er fuer den Bereich <bereich> die Speichergrenze <grenze_gb> GB speichert
    Then wird die Grenze als gueltig validiert
    And wird die Grenze im System persistiert und in der Uebersicht angezeigt

    Examples:
      | bereich | grenze_gb |
      | Datenbank | 500 |
      | Dateispeicher | 1000 |

  @@regression @@boundary
  Scenario Outline: Speichergrenze an Systemgrenzen wird akzeptiert
    # Boundary: Speichern von Mindest- und Hoechstwerten der Speichergrenze
    Given der Administrator verwaltet Speichergrenzen
    When er fuer den Bereich <bereich> die Speichergrenze <grenze_gb> GB speichert
    Then wird die Grenze innerhalb der zulaessigen Systemgrenzen akzeptiert
    And wird die Grenze persistiert

    Examples:
      | bereich | grenze_gb |
      | Logs | 1 |
      | Backups | 2048 |

  @@regression @@negative @@edge
  Scenario Outline: Ungueltige Speichergrenze wird abgelehnt
    # Edge Case: Nicht zulaessige Werte duerfen nicht gespeichert werden
    Given der Administrator verwaltet Speichergrenzen
    When er fuer den Bereich <bereich> die Speichergrenze <grenze_gb> GB speichert
    Then wird eine Validierungsfehlermeldung angezeigt
    And wird keine neue Grenze im System persistiert

    Examples:
      | bereich | grenze_gb |
      | Datenbank | 0 |
      | Dateispeicher | -10 |
      | Logs | 9999999 |

  @@regression @@negative @@error
  Scenario: Speichernutzungsdaten sind voruebergehend nicht verfuegbar
    # Error Scenario: Anzeige einer aussagekraeftigen Fehlermeldung ohne veraltete Werte
    Given die Speichernutzungsdaten sind voruebergehend nicht verfuegbar
    When der Administrator die Uebersicht zur Speichernutzung aufruft
    Then wird eine aussagekraeftige Fehlermeldung angezeigt
    And werden keine veralteten Speicherwerte dargestellt
