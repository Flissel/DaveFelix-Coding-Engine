@@smoke @@regression
Feature: Meta AI Chat
  As a Endnutzer
  I want to einen KI-Assistenten im Chat aktivieren und nutzen
  So that schnell und einfach hilfreiche Antworten zu erhalten und die Kommunikation effizienter zu gestalten

  Background:
    Given der Nutzer ist angemeldet und befindet sich in einem aktiven Chat

  @@smoke @@regression @@happy-path
  Scenario: KI-Assistent liefert Antwort innerhalb der definierten Antwortzeit
    # Validiert den Happy Path für eine erfolgreiche KI-Antwort
    When der Nutzer aktiviert den KI-Assistenten
    And der Nutzer sendet eine Frage an den KI-Assistenten
    Then wird innerhalb der definierten Antwortzeit eine KI-Antwort im Chat angezeigt
    And die Anfrage wird als zugestellt markiert

  @@regression @@boundary
  Scenario Outline: Antwortzeit an der Grenze der erlaubten Latenz
    # Prueft die Antwortzeit am Randwert der definierten SLA
    Given die definierte Antwortzeit betraegt <sla_ms> Millisekunden
    When der Nutzer aktiviert den KI-Assistenten und sendet eine Frage
    Then die KI-Antwort wird im Chat nach <response_ms> Millisekunden angezeigt
    And die Antwortzeit wird als innerhalb der SLA bewertet

    Examples:
      | sla_ms | response_ms |
      | 3000 | 3000 |
      | 3000 | 2999 |

  @@regression @@negative @@error
  Scenario Outline: Aktivierung des KI-Assistenten auf nicht unterstuetzter Plattform
    # Validiert Fehlermeldung bei nicht unterstuetztem Endgeraet oder Plattform
    Given der Nutzer verwendet eine nicht unterstuetzte Plattform <platform>
    When der Nutzer versucht den KI-Assistenten zu aktivieren
    Then erhaelt der Nutzer eine klare Meldung, dass die Funktion nicht verfuegbar ist
    And der KI-Assistent wird nicht aktiviert

    Examples:
      | platform |
      | Legacy Browser v1.0 |
      | Nicht unterstütztes mobiles Betriebssystem |

  @@regression @@negative @@error
  Scenario: Externer KI-Dienst ist temporaer nicht erreichbar
    # Validiert Fehlerbehandlung bei Ausfall der KI-Integration
    Given die KI-Integration ist temporaer nicht erreichbar
    When der Nutzer sendet eine Frage an den KI-Assistenten
    Then erhaelt der Nutzer eine Fehlermeldung mit Hinweis auf die Stoerung
    And die Anfrage wird nicht als zugestellt markiert

  @@regression @@edge
  Scenario Outline: Leere oder sehr kurze Eingabe an den KI-Assistenten
    # Prueft Edge Case fuer minimale Eingabe
    Given der KI-Assistent ist aktiviert
    When der Nutzer sendet eine Eingabe mit Laenge <input_length>
    Then wird eine Rueckmeldung zur ungueltigen oder unzureichenden Eingabe angezeigt
    And keine Anfrage wird an den externen Dienst gesendet

    Examples:
      | input_length |
      | 0 |
      | 1 |
