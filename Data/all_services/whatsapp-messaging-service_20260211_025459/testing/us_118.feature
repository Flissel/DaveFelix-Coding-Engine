@@smoke @@regression
Feature: Watch-App Messaging
  As a registrierter Nutzer
  I want to Nachrichten auf der Smartwatch empfangen und darauf reagieren
  So that um unterwegs schnell und zuverlässig kommunizieren zu können, ohne das Smartphone zu nutzen

  Background:
    Given der Nutzer ist registriert und in der Watch-App angemeldet
    And die Smartwatch ist mit der App gekoppelt

  @@smoke @@regression @@happy-path
  Scenario Outline: Benachrichtigung wird innerhalb weniger Sekunden angezeigt
    # Happy path für den Empfang einer neuen Nachricht auf der Smartwatch
    Given Benachrichtigungen sind auf der Smartwatch aktiviert
    When eine neue Nachricht im System eingeht
    Then wird innerhalb von <sekunden> Sekunden eine Benachrichtigung auf der Smartwatch angezeigt

    Examples:
      | sekunden |
      | 3 |
      | 5 |

  @@regression @@happy-path
  Scenario Outline: Antwort wird sicher gesendet und bestätigt
    # Happy path für Antworten per Auswahl oder Diktat
    Given eine Benachrichtigung ist auf der Smartwatch sichtbar
    And die Smartwatch hat eine aktive Internetverbindung
    When der Nutzer eine Antwort per <antwort_typ> auswählt oder eingibt
    Then wird die Nachricht sicher an den Empfänger gesendet
    And die Nachricht wird als gesendet bestätigt

    Examples:
      | antwort_typ |
      | vordefinierte Schnellantwort |
      | Diktat |

  @@regression @@boundary
  Scenario Outline: Grenzfall: Benachrichtigung genau an der Zeitgrenze
    # Boundary condition für die Anzeigezeit der Benachrichtigung
    Given Benachrichtigungen sind auf der Smartwatch aktiviert
    When eine neue Nachricht im System eingeht
    Then wird die Benachrichtigung spätestens nach <sekunden> Sekunden angezeigt

    Examples:
      | sekunden |
      | 5 |

  @@negative @@regression
  Scenario: Keine Internetverbindung verhindert Empfang oder Versand
    # Error scenario bei fehlender aktiver Internetverbindung
    Given die Smartwatch hat keine aktive Internetverbindung
    When eine Nachricht eingeht oder der Nutzer eine Antwort senden möchte
    Then wird der Nutzer über die fehlende Verbindung informiert
    And die Aktion wird nicht gesendet
