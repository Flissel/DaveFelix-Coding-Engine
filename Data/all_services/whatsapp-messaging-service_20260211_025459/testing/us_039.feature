@@smoke @@regression
Feature: Anruflink erstellen und teilen
  As a registrierter Nutzer
  I want to einen Anruflink für einen geplanten Anruf erstellen und teilen
  So that Teilnehmende schnell und plattformübergreifend zu einem geplanten Anruf einladen zu können

  Background:
    Given ein registrierter Nutzer ist angemeldet

  @@smoke @@happy-path @@regression
  Scenario: Anruflink für geplanten Anruf wird erfolgreich erstellt
    # Erstellt einen eindeutigen, teilbaren Link für einen gültigen geplanten Anruf
    Given ein geplanter Anruf mit gültigem Datum und Uhrzeit existiert
    When der Nutzer einen Anruflink erstellt
    Then das System generiert einen eindeutigen, teilbaren Link
    And das System zeigt den Link dem Nutzer an

  @@happy-path @@regression
  Scenario: Empfänger öffnet Anruflink und sieht Details
    # Öffnet den Link und zeigt Anrufdetails sowie Beitrittsmöglichkeit zum geplanten Zeitpunkt
    Given ein Anruflink wurde für einen geplanten Anruf erstellt
    When ein Empfänger den Link öffnet
    Then das System zeigt die Anrufdetails an
    And das System ermöglicht den Beitritt zum geplanten Zeitpunkt

  @@negative @@regression
  Scenario: Fehler bei Erstellung eines Anruflinks für Termin in der Vergangenheit
    # Verhindert die Erstellung und zeigt Fehlermeldung für vergangene Termine
    Given ein geplanter Anruf existiert
    When der Nutzer einen Anruflink für einen Termin in der Vergangenheit erstellt
    Then das System verhindert die Erstellung
    And das System zeigt eine verständliche Fehlermeldung an

  @@edge @@regression
  Scenario Outline: Anruflink-Erstellung am Rand der Gültigkeit
    # Prüft Boundary Condition für Termine in naher Zukunft
    Given ein geplanter Anruf existiert
    When der Nutzer einen Anruflink für einen Termin mit Startzeit <offset> erstellt
    Then das System <result>
    And das System zeigt <message> an

    Examples:
      | offset | result | message |
      | genau jetzt | verhindert die Erstellung | eine verständliche Fehlermeldung |
      | in 1 Minute | generiert einen eindeutigen, teilbaren Link | den Link |

  @@edge @@regression
  Scenario: Edge Case: Mehrfache Link-Erstellung für denselben geplanten Anruf
    # Stellt sicher, dass jeder Link eindeutig ist oder derselbe Link angezeigt wird
    Given ein geplanter Anruf mit gültigem Datum und Uhrzeit existiert
    When der Nutzer zweimal hintereinander einen Anruflink erstellt
    Then das System zeigt einen gültigen, teilbaren Link an
    And der Link ist konsistent oder eindeutig gemäß Produktspezifikation

  @@negative @@regression
  Scenario: Fehler bei ungültigem Anruflink beim Öffnen
    # Zeigt eine Fehlermeldung, wenn der Link nicht existiert oder abgelaufen ist
    Given ein Anruflink existiert nicht oder ist abgelaufen
    When ein Empfänger den Link öffnet
    Then das System zeigt eine verständliche Fehlermeldung an
    And das System ermöglicht keinen Beitritt
