@@smoke @@regression
Feature: Gruppenanruf
  As a privater Nutzer
  I want to einen Gruppen-Sprach- oder Videoanruf mit mehreren Teilnehmern starten und verwalten
  So that um schnell und effizient mit mehreren Kontakten gleichzeitig kommunizieren zu koennen

  Background:
    Given der Nutzer ist eingeloggt, hat eine stabile Internetverbindung und eine Kontaktliste mit mehreren Kontakten

  @@smoke @@regression @@happy-path
  Scenario: Erfolgreicher Gruppen-Sprachanruf mit mehreren Teilnehmern
    # Validiert, dass ein Gruppenanruf aufgebaut wird und alle eingeladenen Teilnehmer beitreten koennen
    Given mindestens drei Kontakte sind online und verfuegbar
    When der Nutzer einen Gruppen-Sprachanruf startet und zwei Kontakte einlaedt
    Then der Gruppenanruf wird aufgebaut
    And alle eingeladenen Teilnehmer koennen dem Sprachanruf beitreten

  @@regression @@edge-case
  Scenario: Statusanzeige fuer offline oder abgelehnte Teilnehmer
    # Validiert, dass der Anruf aktiv bleibt und der Teilnehmerstatus angezeigt wird
    Given ein Gruppenanruf ist aktiv mit mindestens zwei Teilnehmern
    When ein eingeladener Teilnehmer ist offline oder lehnt die Einladung ab
    Then der Gruppenanruf bleibt fuer die anderen Teilnehmer aktiv
    And der Status des betreffenden Teilnehmers wird angezeigt

  @@regression @@negative @@error
  Scenario: Gruppenanruf mit nicht unterstuetzter Teilnehmeranzahl
    # Validiert, dass der Anruf bei nicht unterstuetzter Teilnehmeranzahl nicht gestartet wird
    Given die erlaubte Teilnehmeranzahl ist auf einen Bereich von 3 bis 10 begrenzt
    When der Nutzer einen Gruppenanruf mit einer nicht unterstuetzten Teilnehmeranzahl startet
    Then das System zeigt eine klare Fehlermeldung
    And der Gruppenanruf wird nicht gestartet

  @@regression @@boundary
  Scenario Outline: Gruppenanruf mit Grenzwerten der Teilnehmeranzahl
    # Validiert die Grenzen der unterstuetzten Teilnehmeranzahl
    Given die erlaubte Teilnehmeranzahl ist auf einen Bereich von 3 bis 10 begrenzt
    When der Nutzer einen Gruppenanruf mit der Teilnehmeranzahl <teilnehmeranzahl> startet
    Then das System verhaelt sich entsprechend <erwartetes_ergebnis>

    Examples:
      | teilnehmeranzahl | erwartetes_ergebnis |
      | 3 | der Gruppenanruf wird gestartet |
      | 10 | der Gruppenanruf wird gestartet |
      | 2 | eine klare Fehlermeldung wird angezeigt und der Anruf wird nicht gestartet |
      | 11 | eine klare Fehlermeldung wird angezeigt und der Anruf wird nicht gestartet |

  @@regression @@happy-path
  Scenario: Gruppenanruf als Videoanruf mit mehreren Teilnehmern
    # Validiert den Aufbau eines Gruppen-Videoanrufs
    Given mindestens drei Kontakte sind online und verfuegbar
    When der Nutzer einen Gruppen-Videoanruf startet und zwei Kontakte einlaedt
    Then der Gruppenanruf wird aufgebaut
    And alle eingeladenen Teilnehmer koennen dem Videoanruf beitreten
