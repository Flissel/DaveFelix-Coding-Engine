@@smoke @@regression
Feature: Begruessungsnachrichten beim Erstkontakt
  As a erstmaliger Kunde
  I want to automatisch eine Begrüßungsnachricht beim ersten Kontakt erhalten
  So that damit ich mich willkommen fühle und schnell verstehe, wie ich Unterstützung erhalte

  Background:
    Given das System ist betriebsbereit und die unterstützten Kontaktkanäle sind aktiviert

  @@smoke @@regression @@happy-path
  Scenario Outline: Automatische Begrüßung beim ersten Kontakt über unterstützten Kanal
    # Prüft die automatische Begrüßung für erstmalige Kunden über unterstützte Kanäle
    Given ein Kunde hat keinen früheren Kontaktverlauf
    When der Kunde kontaktiert das Unternehmen über den Kanal <channel>
    Then das System sendet automatisch eine Begrüßungsnachricht
    And die Begrüßungsnachricht wird dem aktuellen Kontakt zugeordnet

    Examples:
      | channel |
      | E-Mail |
      | Telefon |
      | Chat |

  @@regression @@negative
  Scenario Outline: Keine Begrüßung bei erneutem Kontakt eines bestehenden Kunden
    # Stellt sicher, dass bei bestehendem Kontaktverlauf keine Begrüßung gesendet wird
    Given ein Kunde hat einen früheren Kontaktverlauf
    When der Kunde kontaktiert das Unternehmen erneut über den Kanal <channel>
    Then das System sendet keine automatische Begrüßungsnachricht
    And der Kontakt wird regulär protokolliert

    Examples:
      | channel |
      | E-Mail |
      | Chat |

  @@regression @@negative @@edge-case
  Scenario Outline: Kein Versand bei nicht unterstütztetem Kanal
    # Edge Case: Kontakt über einen nicht unterstützten Kanal erzeugt keine Begrüßung
    Given ein Kunde hat keinen früheren Kontaktverlauf
    When der Kunde kontaktiert das Unternehmen über den Kanal <channel>
    Then das System sendet keine automatische Begrüßungsnachricht
    And der Kontakt wird als nicht unterstützter Kanal protokolliert

    Examples:
      | channel |
      | Fax |
      | Briefpost |

  @@regression @@negative @@error
  Scenario: Fehler bei nicht ermittelbarem Kontaktstatus
    # Fehlerszenario: System kann den Kontaktstatus nicht bestimmen
    Given der Kontaktstatus des Kunden kann nicht ermittelt werden
    When der Kunde kontaktiert das Unternehmen über einen unterstützten Kanal
    Then das System sendet keine Begrüßungsnachricht
    And das System protokolliert den Fehler

  @@regression @@boundary
  Scenario Outline: Grenzfall bei erstem Kontakt unmittelbar nach Datenmigration
    # Boundary: fehlender historischer Kontaktverlauf nach Migration gilt als Erstkontakt
    Given der Kundenverlauf wurde migriert und enthält keinen Kontaktverlauf
    When der Kunde kontaktiert das Unternehmen über den Kanal <channel>
    Then das System sendet automatisch eine Begrüßungsnachricht
    And der Kontakt wird als Erstkontakt markiert

    Examples:
      | channel |
      | E-Mail |
