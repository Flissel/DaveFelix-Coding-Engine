@@smoke @@regression
Feature: Profilbild hochladen und verwalten
  As a primaerer Nutzer
  I want to ein Profilbild hochladen und verwalten
  So that mein Profil persoenlich gestalten und vertrauenswuerdig auftreten zu koennen

  Background:
    Given der Nutzer ist angemeldet und befindet sich in den Profileinstellungen

  @@smoke @@happy-path @@regression
  Scenario: Profilbild erfolgreich hochladen und anzeigen
    # Valides Bild wird gespeichert und sofort angezeigt
    When er ein gueltiges Bildformat innerhalb der Groessenlimits hochlaedt
    Then wird das Profilbild gespeichert
    And das neue Profilbild wird sofort im Profil angezeigt

  @@regression @@happy-path
  Scenario: Profilbild ersetzen mit neuem Bild
    # Vorhandenes Profilbild wird durch neues Bild ersetzt
    Given der Nutzer hat ein bestehendes Profilbild
    When er ein neues gueltiges Bild innerhalb der Groessenlimits hochlaedt
    Then wird das alte Profilbild ersetzt
    And das neue Profilbild wird im Profil angezeigt

  @@regression @@edge @@boundary
  Scenario Outline: Gueltige Bildformate und Grenzwerte akzeptieren
    # Akzeptierte Formate und Dateigroessen an der Grenze werden gespeichert
    When er eine Datei mit dem Format <format> und der Groesse <size> hochlaedt
    Then wird das Profilbild gespeichert
    And das Profilbild wird im Profil angezeigt

    Examples:
      | format | size |
      | JPG | Maximalgroesse |
      | PNG | Maximalgroesse |
      | GIF | Maximalgroesse |

  @@negative @@regression @@error
  Scenario Outline: Ungueltiges Format oder zu grosse Datei ablehnen
    # Fehlermeldung bei ungueltigen Uploads und Profilbild bleibt unveraendert
    Given der Nutzer hat ein bestehendes Profilbild
    When er eine Datei mit dem Format <format> und der Groesse <size> hochlaedt
    Then erhaelt er eine klare Fehlermeldung
    And das bestehende Profilbild bleibt unveraendert

    Examples:
      | format | size |
      | BMP | unterhalb der Maximalgroesse |
      | JPG | ueber der Maximalgroesse |
      | EXE | ueber der Maximalgroesse |
