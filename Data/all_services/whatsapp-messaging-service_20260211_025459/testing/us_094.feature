@smoke @regression
Feature: Chat archivieren
  As a registrierter Nutzer
  I want to einen Chat archivieren
  So that damit ich meine Chatliste übersichtlich halte und weiterhin datenschutzkonform auf frühere Unterhaltungen zugreifen kann

  Background:
    Given der Nutzer ist registriert und angemeldet
    And die Chatliste und das Archiv sind verfügbar

  @@smoke @@regression @@happy-path
  Scenario: Aktiven Chat erfolgreich archivieren
    # Happy path: ein sichtbarer aktiver Chat wird archiviert
    Given ein bestehender Chat ist in der aktiven Chatliste sichtbar
    When der Nutzer die Funktion „Archivieren“ für diesen Chat auswählt
    Then wird der Chat aus der aktiven Liste entfernt
    And der Chat wird im Archiv angezeigt

  @@regression @@edge
  Scenario: Bereits archivierten Chat erneut archivieren
    # Edge case: erneutes Archivieren ändert den Status nicht und zeigt eine neutrale Meldung
    Given ein Chat ist bereits im Archiv
    When der Nutzer den archivierten Chat erneut archivieren möchte
    Then bleibt der Status des Chats unverändert
    And das System zeigt eine neutrale Hinweis-Meldung ohne Fehlermeldung

  @@negative @@regression
  Scenario: Archivieren ohne Berechtigung
    # Error scenario: fehlende Berechtigung verhindert Archivierung
    Given der Nutzer hat keine Berechtigung auf den Chat zuzugreifen
    When der Nutzer versucht, diesen Chat zu archivieren
    Then verweigert das System die Aktion
    And es wird eine verständliche Fehlermeldung angezeigt

  @@regression @@boundary
  Scenario Outline: Archivieren anhand verschiedener Chat-IDs
    # Boundary condition: Archivieren verschiedener gültiger Chat-IDs
    Given ein aktiver Chat mit der ID <chat_id> ist in der aktiven Chatliste sichtbar
    When der Nutzer den Chat mit der ID <chat_id> archiviert
    Then wird der Chat mit der ID <chat_id> aus der aktiven Liste entfernt
    And der Chat mit der ID <chat_id> wird im Archiv angezeigt

    Examples:
      | chat_id |
      | 1 |
      | 999999 |

  @@regression @@boundary
  Scenario: Archivieren wenn aktive Chatliste nur einen Chat enthält
    # Boundary condition: letzter aktiver Chat wird archiviert
    Given die aktive Chatliste enthält genau einen Chat
    When der Nutzer diesen Chat archiviert
    Then ist die aktive Chatliste leer
    And der Chat wird im Archiv angezeigt

  @@negative @@regression
  Scenario Outline: Archivieren bei nicht vorhandenem Chat
    # Error scenario: Archivieren eines nicht vorhandenen Chats
    Given ein Chat mit der ID <chat_id> existiert nicht
    When der Nutzer versucht, den Chat mit der ID <chat_id> zu archivieren
    Then verweigert das System die Aktion
    And es wird eine verständliche Fehlermeldung angezeigt

    Examples:
      | chat_id |
      | 0 |
      | unknown |
