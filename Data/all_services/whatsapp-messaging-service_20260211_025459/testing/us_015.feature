@@smoke @@regression
Feature: Nachricht weiterleiten
  As a registrierter Nutzer
  I want to eine erhaltene Nachricht an einen anderen Kontakt weiterleiten
  So that damit ich Informationen schnell teilen und die Kommunikation effizienter gestalten kann

  Background:
    Given der Nutzer ist in der App angemeldet
    And der Nutzer befindet sich in der Nachrichtenübersicht

  @@smoke @@regression @@happy-path
  Scenario Outline: Weiterleiten an einen oder mehrere Empfänger
    # Erfolgreiche Weiterleitung einer ausgewählten Nachricht an bestätigte Empfänger
    Given der Nutzer hat eine erhaltene Nachricht ausgewählt
    When er wählt die Funktion „Weiterleiten“ und bestätigt die Empfänger <empfaenger>
    Then wird die Nachricht an alle ausgewählten Empfänger zugestellt
    And der Nutzer sieht eine Bestätigung der erfolgreichen Weiterleitung

    Examples:
      | empfaenger |
      | einen Kontakt |
      | mehrere Kontakte |

  @@regression @@negative @@edge-case
  Scenario: Weiterleiten ohne Empfänger
    # Edge Case: Weiterleitung wird verhindert, wenn keine Empfänger ausgewählt sind
    Given der Nutzer hat eine Nachricht ausgewählt
    When er wählt die Funktion „Weiterleiten“ und bestätigt ohne Empfänger
    Then wird die Weiterleitung nicht ausgeführt
    And der Nutzer erhält einen Hinweis, dass mindestens ein Empfänger erforderlich ist

  @@regression @@negative @@error
  Scenario: Weiterleiten blockiert durch Berechtigung oder Datenschutz
    # Error Scenario: Weiterleitung ist nicht erlaubt und wird blockiert
    Given der Nutzer hat eine Nachricht ausgewählt
    And die Nachricht darf aus Berechtigungs- oder Datenschutzgründen nicht weitergeleitet werden
    When er wählt die Funktion „Weiterleiten“
    Then wird die Weiterleitung blockiert
    And der Nutzer erhält eine verständliche Fehlermeldung

  @@regression @@boundary
  Scenario Outline: Weiterleiten an maximale Anzahl Empfänger
    # Boundary Condition: Weiterleitung an die maximale zulässige Anzahl von Empfängern
    Given der Nutzer hat eine erhaltene Nachricht ausgewählt
    And die App erlaubt maximal <max_empfaenger> Empfänger für eine Weiterleitung
    When er wählt die Funktion „Weiterleiten“ und bestätigt <max_empfaenger> Empfänger
    Then wird die Nachricht an alle ausgewählten Empfänger zugestellt
    And es wird keine Fehlermeldung angezeigt

    Examples:
      | max_empfaenger |
      | 5 |
