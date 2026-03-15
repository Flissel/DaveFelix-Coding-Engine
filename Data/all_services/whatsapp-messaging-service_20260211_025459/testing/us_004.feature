@smoke @regression
Feature: Multi-Device Support
  As a Endnutzer
  I want to den Dienst gleichzeitig auf mehreren Geräten nutzen
  So that nahtlos zwischen Geräten arbeiten zu können und keine Nachrichten zu verpassen

  Background:
    Given der Endnutzer hat ein gültiges Konto und ist online

  @happy-path @smoke @regression
  Scenario: Nachricht von Gerät A wird auf Gerät B angezeigt
    # Erfolgreiches Senden und Synchronisieren einer Nachricht innerhalb des Zeitlimits
    Given der Endnutzer ist auf Gerät A und Gerät B mit demselben Konto angemeldet
    When er sendet eine Nachricht von Gerät A an einen Kontakt
    Then die Nachricht wird innerhalb von 2 Sekunden auf Gerät B angezeigt
    And die Nachricht ist auf beiden Geräten als gesendet markiert

  @happy-path @regression
  Scenario: Lesestatus wird auf beiden Geräten synchronisiert
    # Benachrichtigung und Lesestatus-Synchronisation nach Öffnen auf einem Gerät
    Given der Endnutzer ist auf Gerät A und Gerät B mit demselben Konto angemeldet
    When er erhält eine neue Nachricht auf Gerät A
    Then eine Benachrichtigung wird auf Gerät A und Gerät B angezeigt
    And nach dem Öffnen der Nachricht auf einem Gerät ist der Lesestatus auf beiden Geräten synchronisiert

  @negative @regression
  Scenario: Geräte-Limit erreicht und drittes Gerät blockiert
    # Fehlermeldung bei Überschreitung des zulässigen Geräte-Limits
    Given das zulässige Geräte-Limit ist erreicht und zwei Geräte sind aktiv angemeldet
    When ein drittes Gerät versucht sich anzumelden und die Anmeldung abzuschließen
    Then es wird eine verständliche Fehlermeldung angezeigt
    And es wird keine neue Sitzung erstellt

  @boundary @regression
  Scenario Outline: Nachrichtensynchronisation innerhalb der zeitlichen Grenze
    # Boundary-Check für das 2-Sekunden-Limit der Anzeige auf dem zweiten Gerät
    Given der Endnutzer ist auf Gerät A und Gerät B mit demselben Konto angemeldet
    When er sendet eine Nachricht von Gerät A und die Synchronisationsdauer beträgt <sync_time_seconds> Sekunden
    Then die Nachricht wird auf Gerät B angezeigt
    And die Nachricht ist als gesendet markiert

    Examples:
      | sync_time_seconds |
      | 2 |

  @edge @negative @regression
  Scenario Outline: Verzögerte Synchronisation überschreitet das Zeitlimit
    # Edge Case wenn die Anzeige auf Gerät B länger als 2 Sekunden dauert
    Given der Endnutzer ist auf Gerät A und Gerät B mit demselben Konto angemeldet
    When er sendet eine Nachricht von Gerät A und die Synchronisationsdauer beträgt <sync_time_seconds> Sekunden
    Then die Nachricht wird nicht innerhalb von 2 Sekunden auf Gerät B angezeigt
    And ein Synchronisationsproblem wird protokolliert

    Examples:
      | sync_time_seconds |
      | 3 |

  @boundary @regression
  Scenario Outline: Grenzfall Geräte-Limit exakt erreicht
    # Boundary-Check bei genau erreichtem Geräte-Limit ohne zusätzliche Anmeldung
    Given genau <device_limit> Geräte sind bereits angemeldet
    When kein weiteres Gerät versucht sich anzumelden
    Then alle bestehenden Sitzungen bleiben aktiv
    And keine Fehlermeldung wird angezeigt

    Examples:
      | device_limit |
      | 2 |
