@smoke @regression
Feature: Verifiziertes Business
  As a Business-Administrator
  I want to ein Business-Profil zur Verifizierung einreichen
  So that damit Kunden Vertrauen fassen und die Kommunikation als offiziell erkennen

  Background:
    Given der Business-Administrator ist angemeldet
    And ein nicht verifiziertes Business-Profil existiert

  @smoke @regression @happy-path
  Scenario: Erfolgreiche Einreichung setzt Status auf In Pruefung
    # Happy path: vollständiger Antrag wird gespeichert und Status aktualisiert
    Given das Verifizierungsformular ist geoeffnet
    And alle Pflichtfelder sind korrekt ausgefuellt
    And zulaessige Dokumente sind hochgeladen
    When der Business-Administrator den Antrag absendet
    Then der Verifizierungsantrag wird gespeichert
    And der Profilstatus ist auf "In Pruefung" gesetzt

  @regression @happy-path
  Scenario: Erfolgreiche Pruefung verleiht Status Verifiziert und Abzeichen
    # Happy path: erfolgreicher Pruefprozess aktualisiert Profil und zeigt Abzeichen
    Given ein Verifizierungsantrag ist eingereicht
    When die Pruefung erfolgreich abgeschlossen wird
    Then das Profil erhaelt den Status "Verifiziert"
    And ein sichtbares Verifizierungsabzeichen wird angezeigt

  @regression @negative
  Scenario Outline: Validierungsfehler bei fehlenden Pflichtfeldern oder unzulaessigen Dokumenten
    # Error scenario: Einreichung wird abgelehnt und konkrete Fehler werden angezeigt
    Given das Verifizierungsformular ist geoeffnet
    When der Business-Administrator den Antrag mit fehlerhaften Angaben absendet
    Then die Einreichung wird abgelehnt
    And konkrete Validierungsfehler werden angezeigt

    Examples:
      | pflichtfeld | dokument | erwarteter_fehler |
      | Firmenname | gueltig | Pflichtfeld Firmenname fehlt |
      | Handelsregisternummer | gueltig | Pflichtfeld Handelsregisternummer fehlt |
      | alle | unzulaessig | Dokumenttyp nicht erlaubt |

  @regression @edge
  Scenario: Ablehnung anzeigen und erneute Einreichung anbieten
    # Edge case: Ablehnungsgruende sind sichtbar und erneute Einreichung ist moeglich
    Given ein Verifizierungsantrag wurde abgelehnt
    When der Business-Administrator die Ablehnungsbenachrichtigung oeffnet
    Then die Ablehnungsgruende werden angezeigt
    And eine Option zur erneuten Einreichung eines korrigierten Antrags wird angeboten

  @regression @edge
  Scenario Outline: Boundary: Dokumentgroesse am Limit wird akzeptiert
    # Boundary condition: maximal zulaessige Dokumentgroesse wird akzeptiert
    Given das Verifizierungsformular ist geoeffnet
    And alle Pflichtfelder sind korrekt ausgefuellt
    When ein Dokument mit der maximal zulaessigen Dateigroesse hochgeladen und der Antrag abgesendet wird
    Then der Verifizierungsantrag wird gespeichert
    And der Profilstatus ist auf "In Pruefung" gesetzt

    Examples:
      | max_dateigroesse_mb |
      | 10 |

  @regression @negative
  Scenario Outline: Boundary: Dokumentgroesse ueber dem Limit wird abgelehnt
    # Boundary condition: Datei groesser als Limit erzeugt Validierungsfehler
    Given das Verifizierungsformular ist geoeffnet
    And alle Pflichtfelder sind korrekt ausgefuellt
    When ein Dokument groesser als die maximal zulaessige Dateigroesse hochgeladen und der Antrag abgesendet wird
    Then die Einreichung wird abgelehnt
    And ein Validierungsfehler zur Dateigroesse wird angezeigt

    Examples:
      | dateigroesse_mb | erwarteter_fehler |
      | 10.01 | Dateigroesse ueberschreitet das Limit |
