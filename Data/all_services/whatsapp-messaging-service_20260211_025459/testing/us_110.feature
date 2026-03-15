@@smoke @@regression
Feature: Offline-Modus
  As a Endnutzer
  I want to die App im Offline-Modus verwenden, um grundlegende Funktionen auszuführen
  So that damit ich auch ohne Internetverbindung zuverlässig arbeiten und Nachrichten vorbereiten kann

  Background:
    Given die App ist installiert und der Nutzer ist zuvor erfolgreich angemeldet
    And es wurden zuletzt Nachrichten synchronisiert

  @@smoke @@regression @@happy-path
  Scenario: Offline-Grundfunktionen sind verfügbar
    # Prüft das Lesen zuletzt synchronisierter Nachrichten und das Verfassen neuer Nachrichten im Offline-Modus
    Given die Internetverbindung ist ausgefallen
    When der Nutzer die App öffnet
    Then kann der Nutzer die zuletzt synchronisierten Nachrichten lesen
    And kann der Nutzer eine neue Nachricht im Offline-Modus verfassen

  @@regression @@happy-path
  Scenario: Offline erstellte Nachricht wird bei Wiederverbindung automatisch versendet
    # Validiert automatische Warteschlange und Versand ohne weiteres Zutun
    Given die Internetverbindung ist ausgefallen
    And der Nutzer erstellt eine Nachricht im Offline-Modus
    When die Internetverbindung wiederhergestellt wird
    Then wird die Nachricht automatisch in die Warteschlange gestellt
    And wird die Nachricht ohne weiteres Zutun versendet

  @@regression @@negative
  Scenario Outline: Online-pflichtige Funktionen zeigen Offline-Hinweis
    # Stellt sicher, dass klare Offline-Hinweise und Alternativen bei Online-Funktionen angezeigt werden
    Given die Internetverbindung ist ausgefallen
    When der Nutzer die Funktion <funktion> auswählt
    Then zeigt die App eine klare Offline-Hinweismeldung
    And bietet die App die Alternative <alternative> oder die Möglichkeit zur späteren Ausführung

    Examples:
      | funktion | alternative |
      | Nachrichten synchronisieren | später synchronisieren |
      | Kontaktliste aktualisieren | gespeicherte Kontakte anzeigen |

  @@regression @@edge
  Scenario: Leerer Cache im Offline-Modus
    # Edge Case: keine zuvor synchronisierten Nachrichten vorhanden
    Given die Internetverbindung ist ausgefallen
    And es sind keine Nachrichten im lokalen Cache vorhanden
    When der Nutzer den Posteingang öffnet
    Then zeigt die App eine leere Liste oder einen Hinweis auf fehlende Offline-Daten
    And kann der Nutzer weiterhin eine neue Nachricht verfassen

  @@regression @@edge
  Scenario Outline: Grenzfall: Maximale Offline-Warteschlange
    # Boundary Condition: Verhalten bei Erreichen der maximalen Offline-Nachrichtenanzahl
    Given die Internetverbindung ist ausgefallen
    And die Offline-Warteschlange enthält bereits <max_anzahl> Nachrichten
    When der Nutzer eine weitere Nachricht erstellt
    Then zeigt die App eine klare Begrenzungs-Meldung
    And bietet die App die Möglichkeit, die Nachricht später zu speichern oder die Warteschlange zu verwalten

    Examples:
      | max_anzahl |
      | 100 |
