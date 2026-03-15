@@smoke @@regression
Feature: Events planen und veröffentlichen in Gruppen
  As a Gruppenmitglied
  I want to in einer Gruppe ein Event planen und veröffentlichen
  So that damit alle Teilnehmer transparent informiert sind und die Koordination zuverlässig und einfach erfolgt

  Background:
    Given ich bin als Gruppenmitglied angemeldet und sehe die Gruppenansicht

  @@smoke @@regression @@happy-path
  Scenario: Event erfolgreich erstellen und veröffentlichen
    # Happy path: Event mit gültigen Pflichtfeldern wird gespeichert, angezeigt und benachrichtigt
    Given ich habe Zugriff auf die Event-Funktion in der Gruppe
    When ich erstelle ein Event mit Titel, Datum/Uhrzeit und Ort und speichere es
    Then das Event wird in der Gruppenansicht angezeigt
    And alle Gruppenmitglieder erhalten eine Benachrichtigung

  @@regression @@negative
  Scenario: Event-Erstellung mit fehlendem Pflichtfeld verhindern
    # Error scenario: Validierungsfehler bei fehlendem Titel oder Datum
    Given ich habe Zugriff auf die Event-Funktion in der Gruppe
    When ich versuche ein Event zu speichern, bei dem ein Pflichtfeld fehlt
    Then das System zeigt eine verständliche Validierungsfehlermeldung
    And das Event wird nicht gespeichert

  @@regression @@negative
  Scenario: Event-Erstellung ohne Berechtigung verweigern
    # Error scenario: Benutzer ohne Rechte darf kein Event erstellen
    Given ich bin in einer Gruppe ohne Berechtigung zum Planen von Events
    When ich versuche ein Event zu erstellen
    Then das System verweigert die Aktion
    And ich werde über fehlende Berechtigungen informiert

  @@regression @@edge
  Scenario: Event-Erstellung mit minimal gültigen Eingaben
    # Edge case: minimale gültige Eingaben werden akzeptiert
    Given ich habe Zugriff auf die Event-Funktion in der Gruppe
    When ich erstelle ein Event mit minimal gültigen Werten für Titel, Datum/Uhrzeit und Ort
    Then das Event wird gespeichert und angezeigt

  @@regression @@boundary
  Scenario: Event-Datum am aktuellen Tag
    # Boundary condition: Event-Datum ist heute und Uhrzeit in der Zukunft
    Given ich habe Zugriff auf die Event-Funktion in der Gruppe
    When ich erstelle ein Event mit Datum heute und einer Uhrzeit in der Zukunft
    Then das Event wird gespeichert und angezeigt

  @@regression @@happy-path
  Scenario Outline: Event-Erstellung mit variierenden Pflichtfeldwerten
    # Data-driven: verschiedene gültige Kombinationen für Titel, Datum/Uhrzeit und Ort
    Given ich habe Zugriff auf die Event-Funktion in der Gruppe
    When ich erstelle ein Event mit Titel "<titel>", Datum/Uhrzeit "<datum_zeit>", Ort "<ort>" und speichere es
    Then das Event wird in der Gruppenansicht angezeigt
    And alle Gruppenmitglieder erhalten eine Benachrichtigung

    Examples:
      | titel | datum_zeit | ort |
      | Team-Meeting | 2025-05-01 18:00 | Vereinsheim |
      | Training | 2025-05-02 19:30 | Sportplatz A |

  @@regression @@negative
  Scenario Outline: Validierungsfehler für fehlende Pflichtfelder
    # Data-driven negative: fehlende Pflichtfelder verhindern das Speichern
    Given ich habe Zugriff auf die Event-Funktion in der Gruppe
    When ich versuche ein Event zu speichern mit Titel "<titel>", Datum/Uhrzeit "<datum_zeit>", Ort "<ort>"
    Then das System zeigt eine Validierungsfehlermeldung für das fehlende Pflichtfeld
    And das Event wird nicht gespeichert

    Examples:
      | titel | datum_zeit | ort |
      |  | 2025-05-01 18:00 | Vereinsheim |
      | Team-Meeting |  | Vereinsheim |
