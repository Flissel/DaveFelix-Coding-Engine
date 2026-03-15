@@smoke @@regression
Feature: Nachricht loeschen
  As a registrierter Nutzer
  I want to eine gesendete oder empfangene Nachricht loeschen
  So that um Datenschutz zu wahren und die Unterhaltung uebersichtlich zu halten

  Background:
    Given der Nutzer ist angemeldet und sieht eine Nachrichtenliste

  @@smoke @@regression @@happy-path
  Scenario Outline: Nachricht erfolgreich loeschen (gesendet/empfangen)
    # Loescht eine ausgewaehlte Nachricht und entfernt sie aus der Liste
    Given eine Nachricht vom Typ <message_type> ist in der Liste vorhanden
    When der Nutzer waehlt die Nachricht aus und bestaetigt das Loeschen
    Then die Nachricht wird aus der Liste des Nutzers entfernt
    And die Nachricht ist fuer den Nutzer nicht mehr abrufbar

    Examples:
      | message_type |
      | gesendet |
      | empfangen |

  @@regression @@negative @@edge-case
  Scenario Outline: Loeschung einer bereits geloeschten oder nicht existierenden Nachricht
    # Zeigt Hinweis bei nicht auffindbarer Nachricht ohne weitere Aenderung
    Given die Nachricht mit ID <message_id> ist bereits geloescht oder existiert nicht
    When der Nutzer fuehrt die Loeschaktion fuer die Nachricht aus
    Then das System zeigt eine Hinweis-Meldung an, dass die Nachricht nicht gefunden wurde
    And es erfolgt keine weitere Aenderung an der Nachrichtenliste

    Examples:
      | message_id |
      | msg-404 |
      | msg-deleted-001 |

  @@regression @@negative @@error
  Scenario Outline: Unberechtigte Loeschung einer Nachricht
    # Verweigert die Aktion und protokolliert den Vorfall
    Given die Nachricht mit ID <message_id> gehoert einem anderen Nutzer
    When der Nutzer loest die Loeschaktion fuer diese Nachricht aus
    Then das System verweigert die Aktion mit einer klaren Fehlermeldung
    And der Vorfall wird protokolliert

    Examples:
      | message_id |
      | msg-unauthorized-007 |

  @@regression @@boundary
  Scenario Outline: Loeschung der letzten Nachricht in der Liste
    # Boundary: Entfernen der letzten verbleibenden Nachricht
    Given die Nachrichtenliste enthaelt genau eine Nachricht mit ID <message_id>
    When der Nutzer bestaetigt das Loeschen dieser Nachricht
    Then die Nachrichtenliste ist leer
    And die Nachricht ist fuer den Nutzer nicht mehr abrufbar

    Examples:
      | message_id |
      | msg-last-001 |
