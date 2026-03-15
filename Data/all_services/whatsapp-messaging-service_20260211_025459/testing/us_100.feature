@@smoke @@regression
Feature: Automatische Begruessungsnachrichten bei Erstkontakt
  As a Business-Profil-Administrator
  I want to automatische Begruessungsnachrichten bei Erstkontakt konfigurieren und aktivieren
  So that Kunden sofort professionell und konsistent zu empfangen und die Reaktionszeit zu verkuerzen

  Background:
    Given ein Business-Profil existiert und ist fuer Nachrichtenempfang erreichbar

  @@smoke @@regression @@happy-path
  Scenario: Automatische Begruessung bei Erstkontakt wird einmalig gesendet
    # Happy path: Erstkontakt sendet genau eine konfigurierte Begruessungsnachricht
    Given das Business-Profil ist aktiv und eine Begruessungsnachricht ist aktiviert
    And der Kunde hatte bisher keinen Kontakt mit dem Business-Profil
    When der Kunde sendet eine erste Nachricht an das Business-Profil
    Then das System sendet genau eine automatische Begruessungsnachricht
    And die Begruessungsnachricht wird dem Kunden zuverlaessig zugestellt

  @@regression @@edge
  Scenario: Keine Begruessung bei erneutem Kontakt
    # Edge case: Wiederkontakt darf keine automatische Begruessung ausloesen
    Given das Business-Profil ist aktiv und eine Begruessungsnachricht ist aktiviert
    And der Kunde hatte bereits zuvor Kontakt mit dem Business-Profil
    When der Kunde sendet eine neue Nachricht an das Business-Profil
    Then das System sendet keine automatische Begruessungsnachricht
    And die Nachricht des Kunden wird normal verarbeitet

  @@regression @@negative
  Scenario: Keine Begruessung bei deaktivierter oder fehlender Konfiguration
    # Error/negative: Begruessung ist deaktiviert oder nicht konfiguriert
    Given das Business-Profil ist aktiv
    And die Begruessungsnachricht ist nicht konfiguriert oder deaktiviert
    When der Kunde sendet eine erste Nachricht an das Business-Profil
    Then das System sendet keine automatische Begruessungsnachricht
    And der Zustand wird im Protokoll erfasst

  @@regression @@boundary
  Scenario: Begruessung wird bei Erstkontakt nur einmal gesendet (Boundary)
    # Boundary: Mehrere Erstkontakt-Nachrichten in kurzer Zeit erzeugen nur eine Begruessung
    Given das Business-Profil ist aktiv und eine Begruessungsnachricht ist aktiviert
    And der Kunde hatte bisher keinen Kontakt mit dem Business-Profil
    When der Kunde sendet mehrere Nachrichten in kurzer Folge
    Then das System sendet insgesamt nur eine automatische Begruessungsnachricht
    And alle Kunden-Nachrichten werden normal verarbeitet

  @@regression @@data-driven
  Scenario Outline: Begruessungsnachricht Ausloesung nach Status
    # Scenario Outline: Begruessung nur bei aktivem Profil und aktiver Konfiguration
    Given der Business-Profil-Status ist <profil_status>
    And der Begruessungsstatus ist <begruessungs_status>
    And der Kunde hatte bisher keinen Kontakt mit dem Business-Profil
    When der Kunde sendet eine erste Nachricht an das Business-Profil
    Then die automatische Begruessung wird <erwartetes_verhalten> gesendet
    And das System protokolliert den Versandstatus

    Examples:
      | profil_status | begruessungs_status | erwartetes_verhalten |
      | aktiv | aktiviert | genau einmal |
      | aktiv | deaktiviert | nicht |
      | inaktiv | aktiviert | nicht |
