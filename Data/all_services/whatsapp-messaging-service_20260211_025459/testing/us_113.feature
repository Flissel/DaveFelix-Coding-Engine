@smoke @regression
Feature: Batterieeffizienz
  As a Endnutzer
  I want to die Anwendung nutzen, ohne dass der Akku übermäßig schnell entladen wird
  So that um die App zuverlässig und komfortabel über längere Zeiträume verwenden zu können

  Background:
    Given die Anwendung ist installiert, gestartet und die Akku-Messung ist aktiviert

  @smoke @regression @happy-path
  Scenario: Vordergrundnutzung bleibt innerhalb der Effizienzgrenzen
    # Happy path für aktive Nutzung im Vordergrund über 30 Minuten
    Given die Anwendung läuft im Vordergrund und aktive Nachrichten werden empfangen und gesendet
    When die Nutzung über einen Zeitraum von 30 Minuten erfolgt
    Then der Akkuverbrauch liegt innerhalb definierter Effizienzgrenzen
    And es kommt zu keiner ungewöhnlich hohen Entladung

  @regression @happy-path
  Scenario: Hintergrund ohne Interaktion verursacht minimale Aktivität
    # Happy path für Hintergrundbetrieb ohne neue Nachrichten
    Given die Anwendung befindet sich im Hintergrund ohne aktive Interaktion
    When keine neuen Nachrichten eintreffen
    Then es erfolgen keine unnötigen Hintergrundaktivitäten
    And der Akkuverbrauch bleibt minimal

  @smoke @regression @happy-path
  Scenario: Push-Benachrichtigung im Hintergrund startet keine dauerhaften Prozesse
    # Happy path für eingehende Nachricht im Hintergrund
    Given die Anwendung ist im Hintergrund
    When eine neue Nachricht trifft ein und eine Push-Benachrichtigung wird ausgelöst
    Then die Benachrichtigung wird zugestellt
    And es werden keine dauerhaft stromintensiven Prozesse gestartet

  @regression @boundary
  Scenario Outline: Grenzwerte der Akkueffizienz im Vordergrundbetrieb
    # Boundary-Testing für Effizienzgrenzen bei 30 Minuten Nutzung
    Given die Anwendung läuft im Vordergrund und aktive Nachrichten werden empfangen und gesendet
    When die Nutzung über einen Zeitraum von <duration_minutes> Minuten erfolgt
    Then der Akkuverbrauch liegt bei oder unter der Effizienzgrenze <max_allowed_percent> Prozent
    And es wird keine ungewöhnlich hohe Entladung erkannt

    Examples:
      | duration_minutes | max_allowed_percent |
      | 30 | 5 |
      | 31 | 5 |

  @regression @edge-case
  Scenario Outline: Kurzzeitige Push-Burst im Hintergrund ohne dauerhafte Last
    # Edge case für mehrere Pushes in kurzer Zeit
    Given die Anwendung ist im Hintergrund
    When innerhalb von <burst_window_seconds> Sekunden treffen <push_count> Push-Benachrichtigungen ein
    Then jede Benachrichtigung wird zugestellt
    And es werden keine dauerhaft stromintensiven Prozesse gestartet

    Examples:
      | burst_window_seconds | push_count |
      | 10 | 5 |
      | 30 | 10 |

  @regression @negative @error
  Scenario: Fehlerfall: Hintergrundprozess verursacht übermäßigen Akkuverbrauch
    # Negativtest bei unerwarteter Hintergrundaktivität
    Given die Anwendung befindet sich im Hintergrund ohne aktive Interaktion
    When ein unerwarteter Hintergrundprozess startet
    Then der Akkuverbrauch überschreitet die Effizienzgrenzen
    And es wird ein Fehlerereignis zur Diagnose protokolliert
