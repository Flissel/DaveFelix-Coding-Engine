@@smoke @@regression
Feature: US-114 Speichereffizienz
  As a System-Administrator
  I want to Speicherverbrauch des Systems überwachen und sicherstellen, dass Daten speichereffizient abgelegt werden
  So that Kosten und Ressourcenverbrauch reduzieren und eine schnelle Performance gewährleisten

  Background:
    Given das System überwacht Speicherverbrauch und hat definierte Grenzwerte für Speicher und Redundanz

  @@happy-path @@smoke @@regression
  Scenario: Speichereffiziente Speicherung im Normalbetrieb
    # Validiert, dass redundante Daten im Normalbetrieb vermieden werden und der Speicherverbrauch innerhalb der Grenzwerte bleibt
    Given das System verarbeitet Nachrichten und Metadaten im Normalbetrieb
    When die Daten gespeichert werden
    Then werden redundante Daten vermieden
    And der Speicherverbrauch bleibt innerhalb definierter Grenzwerte

  @@happy-path @@regression
  Scenario: Speicherbereinigung oder Komprimierung bei historischen Daten
    # Stellt sicher, dass Speicherbereinigung oder Komprimierung Speicher freigibt ohne Datenintegrität oder Verfügbarkeit zu beeinträchtigen
    Given eine große Menge historischer Daten ist vorhanden
    When eine Speicherbereinigung oder Komprimierung ausgelöst wird
    Then wird Speicher freigegeben
    And Datenintegrität und Verfügbarkeit bleiben unverändert

  @@edge @@regression
  Scenario: Warnung und kontrollierte Speicherung bei kritischem Schwellenwert
    # Prüft, dass bei kritischem Speicherstand eine Warnung ausgelöst wird und die Speicherung kontrolliert erfolgt
    Given der verfügbare Speicher nähert sich einem kritischen Schwellenwert
    When das System neue Daten speichern soll
    Then wird eine Warnung ausgelöst
    And die Speicherung erfolgt kontrolliert ohne Systemabsturz

  @@boundary @@regression
  Scenario Outline: Boundary Conditions für Speichergrenzwerte bei Speicherung
    # Validiert das Verhalten an den Speichergrenzen für die kontrollierte Speicherung
    Given der verfügbare Speicher liegt bei <percent_of_threshold>% des kritischen Schwellenwerts
    When das System einen Datensatz mit <data_size_mb> MB speichern soll
    Then die Speicherung wird <expected_behavior> ausgeführt
    And eine Warnung wird <alert_expected> ausgelöst

    Examples:
      | percent_of_threshold | data_size_mb | expected_behavior | alert_expected |
      | 99 | 10 | kontrolliert | ja |
      | 100 | 1 | kontrolliert | ja |
      | 90 | 50 | normal | nein |

  @@negative @@regression
  Scenario: Fehlerfall bei fehlgeschlagener Komprimierung
    # Stellt sicher, dass ein Komprimierungsfehler keinen Datenverlust verursacht und ein Fehler protokolliert wird
    Given eine Speicherbereinigung oder Komprimierung wurde gestartet
    When die Komprimierung aufgrund eines internen Fehlers fehlschlägt
    Then werden keine Daten gelöscht
    And der Fehler wird protokolliert und eine Warnung wird ausgelöst

  @@happy-path @@regression
  Scenario Outline: Deduplizierung in Szenario Outline
    # Prüft die Vermeidung redundanter Daten für verschiedene Datentypen
    Given das System verarbeitet den Datentyp <data_type> mit identischen Metadaten
    When die Daten gespeichert werden
    Then wird nur eine Kopie der redundanten Daten abgelegt
    And der Speicherverbrauch bleibt innerhalb definierter Grenzwerte

    Examples:
      | data_type |
      | Nachricht |
      | Metadaten |
      | Anhang |
