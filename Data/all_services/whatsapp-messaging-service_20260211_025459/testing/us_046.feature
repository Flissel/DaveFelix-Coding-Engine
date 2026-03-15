@@smoke @@regression
Feature: Kontakt-Status stumm schalten
  As a registrierter Nutzer
  I want to Kontakt-Status stumm schalten
  So that Benachrichtigungen reduzieren und konzentriert arbeiten, ohne die Nachrichtenübermittlung zu beeinträchtigen

  Background:
    Given der Nutzer ist registriert und angemeldet
    And der Nutzer hat mindestens einen aktiven Kontakt mit Statusmeldungen

  @@smoke @@regression @@happy-path
  Scenario: Kontakt-Status erfolgreich stumm schalten
    # Happy path: Status-Updates eines Kontakts werden nach dem Stummschalten nicht mehr angezeigt
    Given der Kontakt-Status ist nicht stumm geschaltet
    When der Nutzer schaltet den Kontakt-Status stumm
    Then Status-Updates dieses Kontakts werden nicht mehr angezeigt
    And die Nachrichtenübermittlung bleibt unbeeinträchtigt

  @@regression @@happy-path
  Scenario: Kontakt-Status erfolgreich wieder aktivieren
    # Happy path: Status-Updates werden nach dem Aufheben der Stummschaltung wieder angezeigt
    Given der Kontakt-Status ist stumm geschaltet
    When der Nutzer hebt die Stummschaltung auf
    Then Status-Updates des Kontakts werden wieder angezeigt

  @@regression @@negative
  Scenario: Stummschalten mit fehlender Berechtigung
    # Error scenario: System verweigert die Aktion und zeigt eine Fehlermeldung
    Given der Nutzer hat keine Berechtigung für den Kontakt
    When der Nutzer versucht den Kontakt-Status stumm zu schalten
    Then das System verweigert die Aktion
    And eine verständliche Fehlermeldung wird angezeigt

  @@regression @@performance
  Scenario: Stummschalten in großer Kontaktliste ohne Verzögerung
    # Boundary condition: Aktion erfolgt ohne spürbare Verzögerung bei sehr großer Kontaktliste
    Given der Nutzer hat eine sehr große Kontaktliste
    And der Kontakt-Status ist nicht stumm geschaltet
    When der Nutzer schaltet den Status eines Kontakts stumm
    Then die Aktion wird ohne spürbare Verzögerung ausgeführt
    And der Status ist sofort stumm geschaltet

  @@regression @@edge @@outline
  Scenario Outline: Datengetriebenes Stummschalten mehrerer Kontakte
    # Edge case: Stummschalten verschiedener Kontakte mit unterschiedlichen Statusarten
    Given der Kontakt-Status ist nicht stumm geschaltet
    And der Kontakt hat Statusmeldungen vom Typ <status_typ>
    When der Nutzer schaltet den Kontakt-Status stumm
    Then Status-Updates vom Typ <status_typ> werden nicht mehr angezeigt

    Examples:
      | status_typ |
      | Text |
      | Bild |
      | Video |

  @@regression @@edge @@outline
  Scenario Outline: Datengetriebenes Aufheben der Stummschaltung
    # Edge case: Wiederanzeigen von Status-Updates nach dem Entstummen für verschiedene Kontakte
    Given der Kontakt-Status ist stumm geschaltet
    When der Nutzer hebt die Stummschaltung für Kontakt <kontakt_name> auf
    Then Status-Updates des Kontakts <kontakt_name> werden wieder angezeigt

    Examples:
      | kontakt_name |
      | Kontakt A |
      | Kontakt B |
