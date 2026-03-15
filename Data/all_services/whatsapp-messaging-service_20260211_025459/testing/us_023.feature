@smoke @regression
Feature: Erwaehnung im Gruppenchat
  As a Gruppenchat-Nutzer
  I want to einen Teilnehmer in einem Gruppenchat per @-Erwähnung markieren
  So that damit der adressierte Teilnehmer die Nachricht schnell erkennt und die Kommunikation effizienter wird

  Background:
    Given ein Gruppenchat mit mehreren Teilnehmern ist geöffnet

  @@smoke @@regression @@happy-path
  Scenario Outline: Erfolgreiche @-Erwähnung aus Vorschlagsliste
    # Prüft, dass ein ausgewählter Teilnehmer korrekt eingefügt und nach dem Senden markiert angezeigt wird
    Given der Nutzer befindet sich im Nachrichtenfeld
    When der Nutzer tippt @ und wählt "<teilnehmer>" aus der Vorschlagsliste
    And der Nutzer sendet die Nachricht
    Then der ausgewählte Teilnehmer wird im Nachrichtenfeld als @<teilnehmer> eingefügt
    And die gesendete Nachricht zeigt @<teilnehmer> als markierte Erwähnung an

    Examples:
      | teilnehmer |
      | Anna |
      | Max.M |

  @@regression @@negative @@edge-case
  Scenario Outline: Nicht existierender @Name wird ohne Markierung gesendet
    # Prüft, dass ungültige Erwähnungen keine Markierung oder Benachrichtigung auslösen
    Given der Nutzer tippt einen nicht existierenden @Namen "<ungueltiger_name>"
    When der Nutzer sendet die Nachricht
    Then die Nachricht wird ohne Markierung gesendet
    And es erfolgt keine Benachrichtigung an nicht existierende Nutzer

    Examples:
      | ungueltiger_name |
      | GhostUser |
      | 12345 |

  @@regression @@negative @@error
  Scenario: Nachricht mit @-Erwähnung kann ohne Netzwerk nicht gesendet werden
    # Prüft die Fehlermeldung bei fehlender Netzwerkverbindung
    Given der Nutzer hat keine Netzwerkverbindung
    And die Nachricht enthält eine @-Erwähnung für einen existierenden Teilnehmer
    When der Nutzer versucht die Nachricht zu senden
    Then die Nachricht wird nicht gesendet
    And es wird eine Fehlermeldung zur Zustellung angezeigt

  @@regression @@boundary
  Scenario Outline: Grenzfall: Erwähnung mit maximaler Namenslänge
    # Prüft die korrekte Markierung bei maximal zulässiger Namenslänge
    Given ein Teilnehmer hat den Namen "<max_name>" mit maximal zulässiger Länge
    When der Nutzer tippt @ und wählt "<max_name>" aus der Vorschlagsliste
    And der Nutzer sendet die Nachricht
    Then die gesendete Nachricht zeigt @<max_name> als markierte Erwähnung an

    Examples:
      | max_name |
      | ABCDEFGHIJKLMNOPQRSTUVWXYZ |
