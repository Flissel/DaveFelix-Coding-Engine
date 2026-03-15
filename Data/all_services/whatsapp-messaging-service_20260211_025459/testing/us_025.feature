@smoke @regression
Feature: Kontakt teilen
  As a Registrierter Nutzer
  I want to Kontaktdaten in einem Chat teilen
  So that damit ich Kontakte schnell, sicher und plattformuebergreifend weitergeben kann

  Background:
    Given der Nutzer ist registriert und in der Chat-Ansicht angemeldet

  @@smoke @@regression @@happy-path
  Scenario: Kontakt erfolgreich teilen
    # Prueft, dass ein ausgewaehlter Kontakt als Nachricht gesendet und beim Empfaenger angezeigt wird
    Given der Nutzer hat die Berechtigung zum Teilen von Kontakten
    And mindestens ein Kontakt ist auf dem Geraet verfuegbar
    When der Nutzer einen Kontakt auswaehlt und auf "Teilen" tippt
    Then werden die Kontaktdaten als Nachricht gesendet
    And die Kontaktdaten werden beim Empfaenger im Chat angezeigt

  @@regression @@edge
  Scenario: Kontaktteildialog abbrechen
    # Prueft, dass kein Kontakt gesendet wird, wenn der Nutzer den Dialog abbricht
    Given der Nutzer oeffnet den Kontaktteildialog
    When der Nutzer den Vorgang abbricht
    Then wird keine Nachricht gesendet
    And der Chat bleibt unveraendert

  @@regression @@negative @@error
  Scenario Outline: Keine Kontakte verfuegbar oder Zugriff verweigert
    # Prueft die Fehlermeldung und dass kein Teilen ausgefuehrt wird
    Given der Nutzer moechte das Teilen von Kontakten starten
    When keine Kontakte verfuegbar sind oder der Zugriff verweigert wurde
    Then wird eine klare Fehlermeldung angezeigt
    And das Teilen wird nicht ausgefuehrt

    Examples:
      | case |
      | keine Kontakte verfuegbar |
      | Zugriff verweigert |

  @@regression @@boundary
  Scenario Outline: Scenario Outline: Teilen mit minimalen Kontaktfeldern
    # Prueft Boundary Condition fuer minimale Pflichtfelder beim Kontakt
    Given der Nutzer hat die Berechtigung zum Teilen von Kontakten
    And ein Kontakt mit minimalen Pflichtfeldern ist verfuegbar
    When der Nutzer den Kontakt mit "<pflichtfelder>" auswaehlt und teilt
    Then wird eine Kontakt-Nachricht mit den Pflichtfeldern gesendet
    And beim Empfaenger werden die gleichen Pflichtfelder angezeigt

    Examples:
      | pflichtfelder |
      | Name |
      | Name und Telefonnummer |

  @@regression @@edge
  Scenario Outline: Scenario Outline: Sehr viele Kontakte im Adressbuch
    # Prueft Edge Case bei grosser Kontaktanzahl und Auswahl
    Given der Nutzer hat die Berechtigung zum Teilen von Kontakten
    And es sind "<anzahl>" Kontakte auf dem Geraet verfuegbar
    When der Nutzer einen Kontakt aus der Liste auswaehlt und auf "Teilen" tippt
    Then wird genau ein Kontakt als Nachricht gesendet
    And die ausgewaehlten Kontaktdaten werden beim Empfaenger angezeigt

    Examples:
      | anzahl |
      | 1000 |
      | 5000 |
