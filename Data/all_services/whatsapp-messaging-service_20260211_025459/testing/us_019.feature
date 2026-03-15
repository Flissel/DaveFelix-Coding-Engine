@@smoke @@regression
Feature: US-019 Einmal-Ansicht Medien
  As a Endnutzer
  I want to View-Once-Medien einmalig anzeigen
  So that um Datenschutz und Kontrolle über sensible Inhalte sicherzustellen

  Background:
    Given ein Endnutzer ist angemeldet und hat Zugriff auf seine Nachrichten

  @@smoke @@happy-path @@regression
  Scenario: View-Once-Medien werden genau einmal angezeigt
    # Erfolgreiches Öffnen einer View-Once-Mediennachricht und automatische Markierung als angesehen
    Given eine neue View-Once-Mediennachricht wurde an den Nutzer gesendet
    When der Nutzer öffnet die View-Once-Medien
    Then die Medien werden angezeigt
    And die Nachricht wird automatisch als angesehen markiert

  @@negative @@regression
  Scenario: Bereits angesehene View-Once-Medien können nicht erneut geöffnet werden
    # Wiederholter Zugriff auf View-Once-Medien wird blockiert
    Given eine View-Once-Mediennachricht wurde bereits einmal angezeigt
    When der Nutzer versucht die View-Once-Medien erneut zu öffnen
    Then die Medien werden nicht erneut angezeigt
    And eine Hinweisnachricht wird angezeigt

  @@negative @@regression
  Scenario: Speichern oder Weiterleiten von View-Once-Medien wird verhindert
    # Sicherheitsrestriktionen für View-Once-Medien greifen
    Given eine View-Once-Mediennachricht wurde empfangen
    When der Nutzer versucht die Medien offline zu speichern oder weiterzuleiten
    Then das System verhindert Speicherung und Weiterleitung
    And eine Sicherheitsmeldung wird angezeigt

  @@edge @@regression
  Scenario: Grenzfall: Öffnen der Medien bei instabiler Verbindung
    # Sicherstellen, dass das View-Once-Verhalten auch bei Verbindungsabbrüchen korrekt ist
    Given eine View-Once-Mediennachricht wurde empfangen
    And die Netzwerkverbindung ist instabil
    When der Nutzer öffnet die View-Once-Medien
    Then die Medien werden höchstens einmal angezeigt
    And die Nachricht wird als angesehen markiert, sobald die Anzeige erfolgreich war

  @@regression @@outline
  Scenario Outline: Scenario Outline: Hinweistext bei erneutem Öffnen
    # Validiert den Hinweistext für unterschiedliche Sprachen
    Given eine View-Once-Mediennachricht wurde bereits einmal angezeigt
    And die App-Sprache ist <language>
    When der Nutzer versucht die View-Once-Medien erneut zu öffnen
    Then eine Hinweisnachricht mit dem Text <message> wird angezeigt

    Examples:
      | language | message |
      | Deutsch | Diese Medien wurden bereits angezeigt. |
      | Englisch | This media has already been viewed. |

  @@negative @@regression @@outline
  Scenario Outline: Scenario Outline: Blockierte Aktionen für View-Once-Medien
    # Datengetriebener Test für verschiedene blockierte Aktionen
    Given eine View-Once-Mediennachricht wurde empfangen
    When der Nutzer versucht die Aktion <action> auszuführen
    Then die Aktion <action> wird verhindert
    And eine Sicherheitsmeldung wird angezeigt

    Examples:
      | action |
      | offline speichern |
      | weiterleiten |
