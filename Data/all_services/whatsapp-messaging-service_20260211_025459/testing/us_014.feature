@@smoke @@regression
Feature: Nachricht bearbeiten
  As a registrierter Nutzer
  I want to eine gesendete Nachricht bearbeiten
  So that Fehler zu korrigieren und die Kommunikation professionell und zuverlässig zu halten

  Background:
    Given der Nutzer ist registriert und angemeldet
    And der Nutzer hat eine gesendete Nachricht im Chatverlauf

  @@smoke @@regression @@happy-path
  Scenario: Erfolgreiches Bearbeiten innerhalb des erlaubten Zeitfensters
    # Happy path: Nachricht wird erfolgreich aktualisiert und ist für alle Empfänger sichtbar
    Given die Nachricht liegt innerhalb des erlaubten Bearbeitungszeitfensters
    When der Nutzer öffnet den Bearbeiten-Dialog
    And der Nutzer ändert den Text und speichert
    Then die Nachricht wird mit dem neuen Text aktualisiert angezeigt
    And die Änderung ist für alle Empfänger sichtbar

  @@regression @@boundary
  Scenario Outline: Bearbeiten am Zeitfenster-Grenzwert
    # Boundary condition: Bearbeitung ist exakt bis zur Frist möglich
    Given die Nachricht wurde vor exakt <minutes> Minuten gesendet
    And das erlaubte Bearbeitungszeitfenster beträgt <limit> Minuten
    When der Nutzer öffnet den Bearbeiten-Dialog, ändert den Text und speichert
    Then die Bearbeitung ist <expected_result>
    And die Anzeige der Nachricht entspricht dem Bearbeitungsergebnis

    Examples:
      | minutes | limit | expected_result |
      | 10 | 10 | erfolgreich |
      | 10.01 | 10 | verhindert |

  @@regression @@negative @@edge
  Scenario: Bearbeiten außerhalb des erlaubten Zeitfensters
    # Edge case: Bearbeitung wird verhindert und Hinweis zur Frist angezeigt
    Given die Nachricht liegt außerhalb des erlaubten Bearbeitungszeitfensters
    When der Nutzer versucht die Nachricht zu bearbeiten
    Then die Bearbeitung wird verhindert
    And ein Hinweis zur abgelaufenen Bearbeitungsfrist wird angezeigt

  @@regression @@negative @@error
  Scenario: Fehler beim Speichern wegen instabiler Netzwerkverbindung
    # Error scenario: Übertragung schlägt fehl, Nachricht bleibt unverändert
    Given die Netzwerkverbindung ist instabil
    And die Nachricht liegt innerhalb des erlaubten Bearbeitungszeitfensters
    When der Nutzer die Bearbeitung speichert und die Übertragung fehlschlägt
    Then die ursprüngliche Nachricht bleibt unverändert
    And eine verständliche Fehlermeldung wird angezeigt

  @@regression @@happy-path
  Scenario: Mehrere Empfänger sehen die Aktualisierung
    # Happy path: alle Empfänger erhalten die aktualisierte Nachricht
    Given die Nachricht wurde an mehrere Empfänger gesendet
    And die Nachricht liegt innerhalb des erlaubten Bearbeitungszeitfensters
    When der Nutzer den Text ändert und speichert
    Then alle Empfänger sehen die aktualisierte Nachricht
