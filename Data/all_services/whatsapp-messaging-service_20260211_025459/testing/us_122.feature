@smoke @regression
Feature: Smart Reply
  As a Kundenservice-Mitarbeiter
  I want to intelligente Antwortvorschläge in Unterhaltungen anzeigen und auswählen
  So that um schneller und konsistent auf Kundenanfragen zu reagieren und die Antwortzeiten zu senken

  Background:
    Given eine aktive Kundenkonversation mit Schreibzugriff ist geöffnet

  @@smoke @@regression @@happy-path
  Scenario: Antwortvorschläge werden rechtzeitig angezeigt
    # Happy path: passende Vorschläge werden innerhalb von 2 Sekunden angezeigt
    Given eine eingehende Nachricht mit normaler Länge liegt vor
    When der Nutzer die Antwortfunktion öffnet
    Then zeigt das System innerhalb von 2 Sekunden mindestens drei passende Antwortvorschläge an
    And die Vorschläge sind sichtbar und auswählbar

  @@regression @@happy-path
  Scenario: Ausgewählter Vorschlag wird in das Eingabefeld übernommen
    # Happy path: Vorschlag kann übernommen und bearbeitet werden
    Given die vorgeschlagenen Antworten werden angezeigt
    When der Nutzer einen Vorschlag auswählt
    Then wird der Vorschlag in das Eingabefeld übernommen
    And der Nutzer kann den Text vor dem Senden bearbeiten

  @@regression @@edge-case
  Scenario: Kurze oder emoji-only Nachricht erzeugt neutrale Vorschläge oder Hinweis
    # Edge case: sehr kurze Nachricht oder nur Emoji
    Given eine eingehende Nachricht mit extrem wenig Kontext liegt vor
    When das System Antwortvorschläge erzeugen soll
    Then zeigt das System neutrale, kontextarme Vorschläge an oder eine Hinweisnachricht
    And es werden keine irreführenden, spezifischen Antworten vorgeschlagen

  @@regression @@negative
  Scenario: Antwortdienst nicht erreichbar zeigt Fehlermeldung
    # Error scenario: Dienst ist vorübergehend nicht erreichbar
    Given der Antwortdienst ist vorübergehend nicht erreichbar
    When der Nutzer die Antwortfunktion öffnet
    Then zeigt das System eine verständliche Fehlermeldung an
    And das manuelle Schreiben einer Antwort bleibt möglich

  @@regression @@boundary
  Scenario Outline: Antwortvorschläge Anzahl und Zeitlimit als Boundary
    # Boundary conditions: minimale Anzahl und Zeitlimit
    Given eine eingehende Nachricht mit normaler Länge liegt vor
    When der Nutzer die Antwortfunktion öffnet
    Then werden mindestens drei Vorschläge angezeigt
    And die Anzeige erfolgt innerhalb des Zeitlimits

    Examples:
      | time_limit_seconds | min_suggestions |
      | 2 | 3 |

  @@regression @@edge-case
  Scenario Outline: Scenario Outline: Kontextarme Eingaben
    # Data-driven edge cases for input length/content
    Given eine eingehende Nachricht mit dem Inhalt <message> liegt vor
    When das System Antwortvorschläge erzeugen soll
    Then zeigt das System neutrale Vorschläge oder eine Hinweisnachricht
    And die Vorschläge sind nicht spezifisch zum fehlenden Kontext

    Examples:
      | message |
      | 👍 |
      | Ok |
      | ? |
