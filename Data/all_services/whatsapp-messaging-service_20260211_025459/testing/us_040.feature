@@smoke @@regression
Feature: Anruf ablehnen mit Nachricht
  As a Primaerer Nutzer (Endkunde)
  I want to einen eingehenden Anruf mit einer vordefinierten schnellen Antwort ablehnen
  So that damit der Anrufer umgehend informiert wird und die Kommunikation effizient sowie zuverlaessig bleibt

  Background:
    Given ein eingehender Anruf wird angezeigt und der Nutzer ist angemeldet

  @@smoke @@regression @@happy-path
  Scenario: Erfolgreiches Ablehnen mit vordefinierter schneller Antwort
    # Prueft, dass der Anruf abgelehnt und die ausgewaehlte Nachricht gesendet wird
    Given es sind vordefinierte schnelle Antworten konfiguriert
    When der Nutzer waehlt eine schnelle Antwort und lehnt den Anruf ab
    Then der Anruf wird abgelehnt
    And die ausgewaehlte Nachricht wird sofort an den Anrufer gesendet

  @@regression @@happy-path
  Scenario Outline: Auswahl einer schnellen Antwort per Liste (Scenario Outline)
    # Validiert mehrere vordefinierte Antworten in einem datengetriebenen Test
    Given es sind vordefinierte schnelle Antworten konfiguriert
    When der Nutzer waehlt die schnelle Antwort "<quick_reply>" und lehnt den Anruf ab
    Then der Anruf wird abgelehnt
    And die Nachricht "<quick_reply>" wird sofort an den Anrufer gesendet

    Examples:
      | quick_reply |
      | Ich rufe spaeter zurueck. |
      | Bin im Meeting, melde mich spaeter. |

  @@regression @@edge-case
  Scenario: Keine schnellen Antworten konfiguriert
    # Edge Case: System zeigt Hinweis und bietet Ablehnen ohne Nachricht an
    Given es sind keine schnellen Antworten konfiguriert
    When der Nutzer moechte den Anruf mit Nachricht ablehnen
    Then das System zeigt eine klare Hinweismeldung
    And das System bietet das Ablehnen ohne Nachricht an

  @@regression @@negative
  Scenario: Zustellfehler der Nachricht bei Ablehnen
    # Error Scenario: Nachrichtenzustellung temporaer nicht moeglich
    Given es sind vordefinierte schnelle Antworten konfiguriert
    And die Nachrichtenzustellung ist temporaer nicht moeglich
    When der Nutzer lehnt den Anruf mit einer schnellen Antwort ab
    Then der Anruf wird abgelehnt
    And das System informiert den Nutzer ueber den Zustellfehler der Nachricht

  @@regression @@boundary
  Scenario Outline: Grenzfall: maximale Laenge einer schnellen Antwort (Scenario Outline)
    # Boundary Condition: maximale erlaubte Zeichenlaenge der Nachricht wird akzeptiert
    Given eine schnelle Antwort mit Laenge "<length>" Zeichen ist konfiguriert
    When der Nutzer waehlt diese schnelle Antwort und lehnt den Anruf ab
    Then der Anruf wird abgelehnt
    And die Nachricht wird sofort an den Anrufer gesendet

    Examples:
      | length |
      | 1 |
      | 160 |
