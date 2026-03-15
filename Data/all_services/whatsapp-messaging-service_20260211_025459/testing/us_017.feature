@smoke @regression
Feature: Reaktionen auf Nachrichten
  As a Endnutzer
  I want to eine Emoji-Reaktion zu einer Nachricht hinzufügen
  So that um schnell und intuitiv auf Nachrichten zu reagieren und die Kommunikation effizienter zu gestalten

  Background:
    Given eine geöffnete Unterhaltung mit mindestens einer Nachricht

  @@smoke @@regression @@happy-path
  Scenario Outline: Emoji-Reaktion wird hinzugefügt und für alle sichtbar
    # Prüft das erfolgreiche Hinzufügen einer Reaktion und die Sichtbarkeit für alle Teilnehmer
    Given eine Nachricht ohne eigene Reaktion
    When der Nutzer ein Emoji auswählt und auf die Nachricht reagiert
    Then wird die Emoji-Reaktion an der Nachricht angezeigt
    And ist die Reaktion für alle Teilnehmer sichtbar

    Examples:
      | emoji |
      | 😀 |
      | 👍 |

  @@regression @@edge-case
  Scenario Outline: Eigenes Emoji durch erneute Auswahl entfernen
    # Prüft das Entfernen der eigenen Reaktion bei erneuter Auswahl desselben Emojis
    Given eine Nachricht mit einer bestehenden Reaktion des Nutzers
    When der Nutzer dasselbe Emoji erneut auswählt
    Then wird die eigene Reaktion entfernt
    And wird die Anzeige der Reaktionen aktualisiert

    Examples:
      | emoji |
      | 😀 |
      | ❤️ |

  @@regression @@edge-case
  Scenario Outline: Mehrere Reaktionen anderer Teilnehmer bleiben erhalten
    # Prüft, dass nur die eigene Reaktion entfernt wird und Reaktionen anderer bestehen bleiben
    Given eine Nachricht mit Reaktionen anderer Teilnehmer und einer Reaktion des Nutzers
    When der Nutzer dasselbe Emoji erneut auswählt
    Then wird nur die eigene Reaktion entfernt
    And bleiben die Reaktionen anderer Teilnehmer sichtbar

    Examples:
      | emoji |
      | 👍 |

  @@negative @@regression @@error
  Scenario Outline: Reaktion scheitert bei instabiler oder fehlender Netzwerkverbindung
    # Prüft die Fehlermeldung und dass keine Reaktion als gesendet markiert wird
    Given eine instabile oder fehlende Netzwerkverbindung
    When der Nutzer eine Emoji-Reaktion senden möchte
    Then wird eine verständliche Fehlermeldung angezeigt
    And wird die Reaktion nicht als gesendet markiert

    Examples:
      | network_state |
      | instabil |
      | offline |
