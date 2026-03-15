@@smoke @@regression
Feature: Bildschirmfreigabe im aktiven Anruf
  As a Endnutzer
  I want to während eines aktiven Anrufs die Bildschirmfreigabe starten und beenden
  So that um Inhalte schnell und sicher zu teilen und die Kommunikation effizienter zu gestalten

  Background:
    Given ein aktiver Anruf zwischen Nutzer A und Nutzer B besteht

  @@smoke @@regression @@happy-path
  Scenario: Erfolgreicher Start und Stopp der Bildschirmfreigabe
    # Happy Path: Nutzer startet und beendet die Freigabe erfolgreich
    Given Nutzer A hat die Berechtigung zur Bildschirmfreigabe erteilt
    When Nutzer A startet die Bildschirmfreigabe und wählt den gesamten Bildschirm
    Then Nutzer B sieht den ausgewählten Bildschirm in Echtzeit
    When Nutzer A beendet die Bildschirmfreigabe
    Then Nutzer B sieht keinen geteilten Inhalt mehr

  @@regression @@negative
  Scenario: Berechtigung verweigert beim Start der Freigabe
    # Error Scenario: Betriebssystem-Berechtigung wird verweigert
    Given das Betriebssystem verweigert die Berechtigung zur Bildschirmfreigabe
    When Nutzer A versucht die Bildschirmfreigabe zu starten
    Then eine verständliche Fehlermeldung wird angezeigt
    And die Bildschirmfreigabe startet nicht

  @@regression @@negative @@edge-case
  Scenario: Verbindungsabbruch während laufender Freigabe
    # Edge Case: instabile Netzwerkverbindung führt zum Abbruch
    Given Nutzer A teilt bereits den Bildschirm
    When die Netzwerkverbindung bricht ab
    Then die Bildschirmfreigabe wird automatisch beendet
    And Nutzer A erhält einen Hinweis zur Wiederherstellung

  @@regression @@happy-path
  Scenario Outline: Datengetriebene Startvarianten der Bildschirmfreigabe
    # Boundary Conditions: unterschiedliche Auswahl des Freigabeinhalts
    Given Nutzer A hat die Berechtigung zur Bildschirmfreigabe erteilt
    When Nutzer A startet die Bildschirmfreigabe und wählt <freigabe_typ>
    Then Nutzer B sieht den ausgewählten Inhalt in Echtzeit
    And die Freigabe startet ohne Fehlermeldung

    Examples:
      | freigabe_typ |
      | den gesamten Bildschirm |
      | ein einzelnes Fenster |
      | einen bestimmten Tab |
