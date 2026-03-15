@smoke @regression
Feature: Effiziente Synchronisation
  As a Endnutzer
  I want to Nachrichten effizient mit dem Server synchronisieren
  So that um eine schnelle und zuverlaessige Zustellung auf allen Plattformen sicherzustellen

  Background:
    Given die App ist installiert und der Endnutzer ist eingeloggt

  @@smoke @@regression @@happy-path
  Scenario: Stabile Verbindung synchronisiert alle neuen Nachrichten schnell
    # Prueft den Happy Path bei stabiler Verbindung und ausstehenden Nachrichten
    Given eine stabile Netzwerkverbindung ist vorhanden
    And es liegen neue Nachrichten auf dem Server vor
    When der Endnutzer die App oeffnet
    Then werden alle neuen Nachrichten innerhalb der Performance-Grenzen heruntergeladen
    And die neuen Nachrichten werden in der Inbox angezeigt

  @@regression @@edge
  Scenario Outline: Langsame oder instabile Verbindung synchronisiert in Batches ohne Blockierung
    # Prueft Batch-Synchronisation und Fortschrittsanzeige bei langsamer Verbindung
    Given eine Verbindung mit hoher Latenz oder Paketverlust liegt vor
    And es liegen neue Nachrichten auf dem Server vor
    When die Synchronisation gestartet wird
    Then werden Nachrichten in Batches von <batch_size> synchronisiert
    And die App bleibt waehrend der Synchronisation bedienbar
    And der Fortschritt der Synchronisation wird angezeigt

    Examples:
      | batch_size |
      | 10 |
      | 25 |

  @@regression @@negative
  Scenario Outline: Serverfehler liefert klare Fehlermeldung und plant Retry
    # Prueft Fehlermeldung, Retry-Planung und Datenintegritaet bei Serverfehlern
    Given der Server ist nicht erreichbar oder liefert einen Fehlercode <status_code>
    And der Endnutzer hat bereits lokale Nachrichten
    When die Synchronisation versucht wird
    Then erhaelt der Endnutzer eine klare Fehlermeldung
    And die App plant einen automatischen Retry
    And bereits vorhandene Nachrichten bleiben erhalten

    Examples:
      | status_code |
      | 503 |
      | 500 |

  @@regression @@boundary
  Scenario Outline: Performance-Grenze wird exakt eingehalten
    # Prueft die Boundary-Condition am definierten Performance-Limit
    Given eine stabile Netzwerkverbindung ist vorhanden
    And es liegen <message_count> neue Nachrichten auf dem Server vor
    When die Synchronisation gestartet wird
    Then die Synchronisation schliesst innerhalb von <max_time_ms> Millisekunden ab
    And alle neuen Nachrichten werden angezeigt

    Examples:
      | message_count | max_time_ms |
      | 100 | 2000 |
