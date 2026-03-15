@smoke @regression
Feature: Verschwindende Nachrichten
  As a registrierter Nutzer
  I want to selbstlöschende Nachrichten senden und einen Ablaufzeitpunkt festlegen
  So that damit sensible Inhalte automatisch verschwinden und Datenschutz sowie Sicherheit verbessert werden

  Background:
    Given der Nutzer ist angemeldet
    And eine Unterhaltung mit einem Empfänger ist geöffnet

  @happy-path @smoke @regression
  Scenario Outline: Selbstlöschende Nachricht wird gesendet und nach Ablauf gelöscht
    # Happy path: Nachricht wird zugestellt und nach Ablauf automatisch entfernt
    Given die aktuelle Systemzeit ist bekannt
    When der Nutzer eine Nachricht mit einem gültigen Ablaufzeitpunkt sendet
    Then die Nachricht wird erfolgreich zugestellt
    And die Nachricht wird nach Erreichen des Ablaufzeitpunkts aus allen Ansichten gelöscht

    Examples:
      | gültiger_ablaufzeitpunkt |
      | in 10 Minuten |
      | in 24 Stunden |

  @edge-case @regression
  Scenario: Ablaufzeitpunkt erreicht während Empfänger offline ist
    # Edge case: Nachricht verfällt, obwohl Empfänger offline ist
    Given eine selbstlöschende Nachricht wurde erfolgreich gesendet
    And der Empfänger ist offline
    When der Ablaufzeitpunkt erreicht wird
    Then die Nachricht wird gelöscht
    And die Nachricht ist beim späteren Öffnen der Unterhaltung nicht sichtbar

  @negative @regression
  Scenario Outline: Ungültiger Ablaufzeitpunkt verhindert das Senden
    # Error scenario: ungültige Ablaufzeit führt zu Fehlermeldung
    When der Nutzer eine Nachricht mit einem ungültigen Ablaufzeitpunkt senden möchte
    Then die Nachricht wird nicht gesendet
    And eine verständliche Fehlermeldung wird angezeigt

    Examples:
      | ungültiger_ablaufzeitpunkt |
      | Zeitpunkt in der Vergangenheit |
      | leeres Ablaufzeitfeld |

  @boundary @regression
  Scenario Outline: Ablaufzeitpunkt an der minimalen zulässigen Grenze
    # Boundary condition: minimale gültige TTL wird akzeptiert
    Given die minimale zulässige Ablaufdauer ist konfiguriert
    When der Nutzer eine Nachricht mit dem minimalen gültigen Ablaufzeitpunkt sendet
    Then die Nachricht wird zugestellt
    And die Nachricht wird exakt nach Ablauf der minimalen Dauer gelöscht

    Examples:
      | minimale_ablaufdauer |
      | 30 Sekunden |
