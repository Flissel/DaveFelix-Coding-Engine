@@smoke @@regression
Feature: Spam-Erkennung
  As a Support-Mitarbeiter
  I want to automatische Spam-Erkennung für eingehende und ausgehende Nachrichten aktivieren und überwachen
  So that Missbrauch zu verhindern, die Zustellbarkeit zu sichern und die Compliance-Anforderungen einzuhalten

  Background:
    Given die Spam-Erkennung ist im System aktiviert
    And der Support-Mitarbeiter ist angemeldet und kann Nachrichten überwachen

  @@smoke @@regression @@happy-path
  Scenario: Automatische Markierung und Verschiebung von Spam-Nachrichten
    # Validiert den Happy Path für das automatische Erkennen und Verschieben von Spam
    When eine eingehende Nachricht mit typischen Spam-Merkmalen eingeht
    Then wird die Nachricht automatisch als Spam markiert
    And wird die Nachricht in den separaten Spam-Bereich verschoben

  @@regression @@happy-path
  Scenario: Legitime Nachrichten werden nicht blockiert
    # Stellt sicher, dass legitime Nachrichten normal zugestellt werden
    When eine eingehende Nachricht ohne Spam-Merkmale eingeht
    Then wird die Nachricht normal zugestellt
    And wird die Nachricht nicht als Spam markiert

  @@regression @@happy-path
  Scenario: Manuelle Korrektur einer fälschlich als Spam markierten Nachricht
    # Validiert die Korrektur durch den Support und das Lernen der Erkennung
    Given eine legitime Nachricht wurde fälschlicherweise als Spam markiert
    When der Support-Mitarbeiter die Nachricht manuell als legitim kennzeichnet
    Then wird die Nachricht zugestellt
    And wird die Erkennung für ähnliche Nachrichten verbessert

  @@regression @@negative @@error
  Scenario: Warnprotokollierung bei nicht verfügbarem Spam-Erkennungsdienst
    # Error Scenario: Der Dienst ist nicht verfügbar und es muss eine Warnung protokolliert werden
    Given der Spam-Erkennungsdienst ist vorübergehend nicht verfügbar
    When eine Nachricht eingeht
    Then wird die Nachricht zugestellt
    And protokolliert das System eine Warnung für das Monitoring

  @@regression @@boundary
  Scenario Outline: Spam-Erkennung nach Schwellenwerten für Spam-Merkmale
    # Boundary Condition: Verhalten an der Schwelle für Spam-Merkmale
    Given ein konfigurierter Schwellenwert für Spam-Merkmale existiert
    When eine Nachricht mit dem Merkmal-Score <score> eingeht
    Then ist die Nachricht als <classification> klassifiziert
    And wird die Nachricht in den Bereich <destination> verschoben

    Examples:
      | score | classification | destination |
      | 49 | legitim | Posteingang |
      | 50 | Spam | Spam-Bereich |
      | 51 | Spam | Spam-Bereich |

  @@regression @@edge
  Scenario Outline: Datengetriebene Prüfung typischer Spam-Merkmale
    # Edge Case: Unterschiedliche Merkmalskombinationen führen zur Spam-Klassifizierung
    When eine Nachricht mit Merkmalen <features> eingeht
    Then wird die Nachricht als <classification> behandelt
    And wird die Nachricht in den Bereich <destination> verschoben

    Examples:
      | features | classification | destination |
      | verdächtige Links, viele Großbuchstaben | Spam | Spam-Bereich |
      | kein Link, normaler Text | legitim | Posteingang |
      | ungewöhnlicher Absender, wiederholte Phrasen | Spam | Spam-Bereich |
