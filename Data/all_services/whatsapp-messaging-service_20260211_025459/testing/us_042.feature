@@smoke @@regression
Feature: Status erstellen
  As a Endnutzer
  I want to einen 24-Stunden-Status erstellen
  So that damit ich zeitlich begrenzte Updates schnell und zuverlässig mit meinen Kontakten teilen kann

  Background:
    Given der Nutzer ist angemeldet
    And der Nutzer hat die Status-Funktion geöffnet

  @@smoke @@regression @@happy-path
  Scenario Outline: Status mit Text oder Bild erfolgreich veröffentlichen
    # Erstellt einen Status und zeigt ihn 24 Stunden an
    When der Nutzer fügt einen gültigen Inhalt hinzu
    And der Nutzer tippt auf „Veröffentlichen“
    Then der Status wird erstellt
    And der Status ist für 24 Stunden sichtbar

    Examples:
      | inhaltstyp | inhalt |
      | Text | Kurzes Update |
      | Bild | bild_datei.jpg |

  @@regression @@negative
  Scenario Outline: Leeren Status nicht veröffentlichen
    # Verhindert das Erstellen eines leeren Status und zeigt eine Fehlermeldung
    When der Nutzer versucht einen leeren Status zu veröffentlichen
    Then der Status wird nicht erstellt
    And eine verständliche Fehlermeldung wird angezeigt

    Examples:
      | leerer_status |
      | kein Text und kein Bild |

  @@regression @@negative
  Scenario Outline: Status bei fehlender Internetverbindung nicht veröffentlichen
    # Informiert den Nutzer über fehlende Verbindung und verhindert Veröffentlichung
    Given es besteht keine Internetverbindung
    When der Nutzer fügt einen gültigen Inhalt hinzu
    And der Nutzer tippt auf „Veröffentlichen“
    Then der Nutzer wird über die fehlende Verbindung informiert
    And der Status wird nicht veröffentlicht

    Examples:
      | inhaltstyp | inhalt |
      | Text | Update ohne Netz |

  @@regression @@boundary
  Scenario Outline: Grenzfall: Maximale Textlänge zulassen
    # Erstellt einen Status bei maximal erlaubter Textlänge
    Given die maximale Textlänge ist bekannt
    When der Nutzer fügt Text mit maximaler Länge hinzu
    And der Nutzer tippt auf „Veröffentlichen“
    Then der Status wird erstellt
    And der Status ist für 24 Stunden sichtbar

    Examples:
      | textlaenge |
      | MAX_TEXT_LAENGE |
