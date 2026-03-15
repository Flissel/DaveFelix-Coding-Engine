@smoke @regression
Feature: Galerie-Zugriff
  As a Endnutzer
  I want to auf die Geräte-Galerie zugreifen, um ein Bild auszuwählen
  So that Medien schnell und intuitiv teilen zu können, ohne die App zu verlassen

  Background:
    Given der Nutzer befindet sich im Medienauswahl-Dialog

  @@smoke @@regression @@happy-path
  Scenario: Galerie öffnen und Bild auswählen (Happy Path)
    # Erfolgreicher Zugriff auf die Galerie und Auswahl eines Bildes
    Given die App hat Zugriff auf die Galerie
    When der Nutzer die Option "Galerie" auswählt
    Then öffnet sich die Geräte-Galerie
    And der Nutzer kann ein Bild auswählen

  @@regression @@happy-path
  Scenario: Berechtigungsanfrage bei erstem Zugriff (Happy Path)
    # Systemdialog erscheint, wenn Berechtigung noch nicht erteilt wurde
    Given der Nutzer hat der App den Zugriff auf die Galerie noch nicht erlaubt
    When der Nutzer die Option "Galerie" auswählt
    Then wird ein Systemdialog zur Berechtigungsanfrage angezeigt

  @@regression @@negative
  Scenario: Fehlermeldung bei verweigertem Zugriff (Error)
    # Verständliche Fehlermeldung mit Hinweis zur Berechtigungsaktivierung
    Given der Nutzer hat den Galeriezugriff verweigert
    When der Nutzer erneut versucht, die Galerie zu öffnen
    Then wird eine verständliche Fehlermeldung angezeigt
    And die Fehlermeldung enthält einen Hinweis zur Berechtigungsaktivierung

  @@regression @@edge
  Scenario: Abbruch der Auswahl aus der Galerie (Edge Case)
    # Nutzer bricht die Galerieauswahl ab, ohne ein Bild zu wählen
    Given die App hat Zugriff auf die Galerie
    When der Nutzer die Galerie öffnet und die Auswahl abbricht
    Then kehrt der Nutzer zum Medienauswahl-Dialog zurück
    And es wird kein Bild ausgewählt oder angehängt

  @@regression @@boundary
  Scenario: Grenzfall: Galerie enthält keine Bilder (Boundary)
    # Umgang mit leerer Galerie
    Given die App hat Zugriff auf die Galerie
    And die Galerie enthält keine Bilder
    When der Nutzer die Option "Galerie" auswählt
    Then öffnet sich die Galerie und zeigt einen Hinweis, dass keine Bilder verfügbar sind
    And der Nutzer kann zur vorherigen Ansicht zurückkehren

  @@regression @@negative @@outline
  Scenario Outline: Datengetriebener Zugriff je Berechtigungsstatus (Scenario Outline)
    # Validiert das Verhalten für verschiedene Berechtigungszustände
    Given der Berechtigungsstatus ist "<status>"
    When der Nutzer die Option "Galerie" auswählt
    Then ist das erwartete Ergebnis "<ergebnis>"

    Examples:
      | status | ergebnis |
      | erlaubt | Galerie öffnet sich und der Nutzer kann ein Bild auswählen |
      | nicht_erlaubt | Systemdialog zur Berechtigungsanfrage wird angezeigt |
      | verweigert | verständliche Fehlermeldung mit Hinweis zur Berechtigungsaktivierung wird angezeigt |
