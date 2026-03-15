@smoke @regression
Feature: Widgets
  As a Endnutzer
  I want to Home-Screen-Widgets aktivieren und konfigurieren
  So that damit ich schnellen und intuitiven Zugriff auf wichtige Informationen habe und die App effizienter nutzen kann

  Background:
    Given der Endnutzer hat die App installiert und ist angemeldet

  @happy-path @smoke @regression
  Scenario: Widget mit Standardkonfiguration hinzufuegen
    # Erfolgreiches Hinzufuegen eines Widgets mit Standardwerten
    When der Endnutzer fuegt ein Widget hinzu und waehlt die Standardkonfiguration
    Then wird das Widget auf dem Home-Screen angezeigt
    And das Widget zeigt die erwarteten Informationen an

  @happy-path @regression
  Scenario: Widget-Einstellungen aendern und innerhalb von 5 Sekunden sehen
    # Aenderungen an Inhalt oder Groesse werden gespeichert und zeitnah sichtbar
    Given der Endnutzer oeffnet die Widget-Einstellungen
    When der Endnutzer passt die Inhalte und die Groesse an
    Then werden die Aenderungen gespeichert
    And die Aenderungen sind innerhalb von 5 Sekunden im Widget sichtbar

  @edge-case @regression @negative
  Scenario: Offline-Update zeigt letzten Inhalt und Hinweis
    # Bei fehlender Netzwerkverbindung wird der letzte Inhalt angezeigt
    Given der Endnutzer hat keine Netzwerkverbindung
    When das Widget soll aktualisiert werden
    Then zeigt das Widget den zuletzt verfuegbaren Inhalt an
    And das Widget zeigt einen Hinweis auf die fehlende Verbindung

  @regression
  Scenario Outline: Widget-Konfigurationen fuer Inhalte
    # Datengetriebene Tests fuer verschiedene Inhaltsoptionen
    Given der Endnutzer oeffnet die Widget-Einstellungen
    When der Endnutzer waehlt die Inhaltsoption "<content_option>"
    And speichert die Einstellungen
    Then zeigt das Widget die Inhalte entsprechend "<content_option>" an
    And die Inhalte sind innerhalb von 5 Sekunden sichtbar

    Examples:
      | content_option |
      | Wetter |
      | Kalender |
      | Nachrichten |

  @boundary @regression
  Scenario Outline: Widget-Groesse an Grenzwerten
    # Grenzwerte fuer minimale und maximale Widget-Groesse
    Given der Endnutzer oeffnet die Widget-Einstellungen
    When der Endnutzer setzt die Widget-Groesse auf "<size>"
    Then wird die Groesse gespeichert
    And das Widget wird in der Groesse "<size>" angezeigt

    Examples:
      | size |
      | minimal |
      | maximal |

  @negative @regression
  Scenario: Speicherfehler beim Speichern der Widget-Einstellungen
    # Fehlerfall, wenn das Speichern der Einstellungen fehlschlaegt
    Given der Endnutzer oeffnet die Widget-Einstellungen
    When der Endnutzer speichert die Einstellungen und es tritt ein Speicherfehler auf
    Then wird eine Fehlermeldung angezeigt
    And die vorherige Widget-Konfiguration bleibt unveraendert
