@@smoke @@regression
Feature: Abwesenheitsnachrichten konfigurieren und aktivieren
  As a Shop-Admin
  I want to automatische Abwesenheitsnachrichten für eingehende Anfragen konfigurieren und aktivieren
  So that um Kunden zuverlässig und professionell über meine Abwesenheit zu informieren und Erwartungsmanagement sicherzustellen

  Background:
    Given der Shop-Admin ist angemeldet und befindet sich im Bereich Einstellungen für Abwesenheitsnachrichten

  @@smoke @@regression @@happy-path
  Scenario: Aktive Abwesenheitsnachricht wird im Zeitraum automatisch versendet
    # Happy path: aktivierte Nachricht wird für eingehende Anfragen im definierten Zeitraum gesendet
    Given eine gültige Abwesenheitsnachricht mit Text und Zeitraum ist konfiguriert und aktiviert
    When eine neue Kundenanfrage im definierten Zeitraum eingeht
    Then wird die konfigurierte Abwesenheitsnachricht automatisch versendet
    And die Anfrage wird im System als beantwortet mit Abwesenheitsnachricht markiert

  @@regression @@edge-case
  Scenario: Abwesenheitsnachricht wird nach Ablauf des Zeitraums nicht mehr versendet
    # Edge case: Nachricht endet und wird danach nicht gesendet
    Given eine Abwesenheitsnachricht ist aktiv und der definierte Zeitraum ist abgelaufen
    When eine neue Kundenanfrage eingeht
    Then wird keine Abwesenheitsnachricht gesendet
    And die Anfrage bleibt ohne automatische Antwort

  @@regression @@negative
  Scenario Outline: Fehlermeldung bei ungültigen Eingaben für Abwesenheitsnachricht
    # Error scenario: Speichern ohne Text oder mit ungültigem Zeitraum wird verhindert
    When der Shop-Admin versucht die Abwesenheitsnachricht mit ungültigen Eingaben zu speichern
    Then zeigt das System eine valide Fehlermeldung an
    And die Abwesenheitsnachricht wird nicht gespeichert

    Examples:
      | invalid_case | text | start_date | end_date |
      | kein Text |  | 2025-05-01 | 2025-05-10 |
      | Startdatum nach Enddatum | Wir sind im Urlaub | 2025-05-10 | 2025-05-01 |
      | Zeitraum fehlt | Wir sind im Urlaub |  |  |

  @@regression @@boundary
  Scenario Outline: Grenzwerte für Zeitraum: Nachricht gilt exakt am Start- und Enddatum
    # Boundary conditions: Nachricht wird am Start- und Endzeitpunkt gesendet
    Given eine Abwesenheitsnachricht mit Zeitraum von {start_date} bis {end_date} ist aktiviert
    When eine Anfrage genau am Zeitpunkt {request_time} eingeht
    Then wird die Abwesenheitsnachricht gesendet

    Examples:
      | start_date | end_date | request_time |
      | 2025-06-01T00:00:00 | 2025-06-07T23:59:59 | 2025-06-01T00:00:00 |
      | 2025-06-01T00:00:00 | 2025-06-07T23:59:59 | 2025-06-07T23:59:59 |

  @@regression @@edge-case
  Scenario Outline: Abwesenheitsnachricht außerhalb des Zeitraums wird nicht gesendet
    # Edge case: Anfrage kurz vor Start oder nach Ende erhält keine Abwesenheitsnachricht
    Given eine Abwesenheitsnachricht mit Zeitraum von {start_date} bis {end_date} ist aktiviert
    When eine Anfrage außerhalb des Zeitraums zum Zeitpunkt {request_time} eingeht
    Then wird keine Abwesenheitsnachricht gesendet

    Examples:
      | start_date | end_date | request_time |
      | 2025-06-01T00:00:00 | 2025-06-07T23:59:59 | 2025-05-31T23:59:59 |
      | 2025-06-01T00:00:00 | 2025-06-07T23:59:59 | 2025-06-08T00:00:00 |
