@smoke @regression
Feature: RTL-Unterstuetzung
  As a RTL-sprachiger Endnutzer
  I want to die Anwendung in einer rechts-nach-links Sprache nutzen
  So that alle Inhalte korrekt lesen und effizient bedienen zu können

  Background:
    Given die Anwendung ist gestartet und eine RTL-Sprache ist als Standardsprache aktiviert

  @smoke @happy-path
  Scenario: RTL-Layout und Textrichtung werden korrekt dargestellt
    # Validiert die korrekte RTL-Ausrichtung von Layout, Navigation und Formularen auf einer typischen Seite
    Given die Anwendung ist auf Arabisch eingestellt
    When ich eine Seite mit Text, Navigation und Formularfeldern öffne
    Then werden Layout, Ausrichtung und Textrichtung vollständig von rechts nach links dargestellt
    And die Navigationselemente erscheinen in der erwarteten RTL-Reihenfolge

  @regression @happy-path
  Scenario: RTL-Navigation in Menüs, Listen und Paginierung
    # Prüft die korrekte Reihenfolge der UI-Elemente bei Navigation in RTL
    Given eine RTL-Sprache ist aktiv
    When ich durch Menüs, Listen und Paginierung navigiere
    Then befinden sich Navigations- und UI-Elemente in der erwarteten RTL-Reihenfolge
    And vorwärts und rückwärts Navigation folgen der RTL-Ausrichtung

  @regression @happy-path
  Scenario: RTL-Formulareingaben werden rechtsbündig verarbeitet
    # Validiert die korrekte Ausrichtung von Eingabefeldern, Cursor und Platzhaltern sowie das Speichern der Eingabe
    Given eine RTL-Sprache ist aktiv
    When ich ein Formular mit mehreren Feldern ausfülle und absende
    Then sind Eingabefelder rechtsbündig, Cursor und Platzhalter RTL-konform
    And die Eingabe wird korrekt gespeichert und angezeigt

  @regression @edge-case
  Scenario: Gemischte RTL- und LTR-Inhalte bleiben lesbar
    # Überprüft die korrekte Einbettung von LTR-Inhalten in RTL-Kontext
    Given die Anwendung enthält gemischten RTL- und LTR-Text
    When ich Inhalte mit Zahlen, URLs oder LTR-Begriffen ansehe
    Then werden LTR-Inhalte korrekt eingebettet und bleiben lesbar
    And es treten keine Layoutbrüche oder Überlappungen auf

  @regression @boundary
  Scenario: RTL-Formularfelder reagieren korrekt bei leeren Eingaben
    # Boundary-Test für leere Eingaben und Platzhalterausrichtung in RTL-Formularen
    Given eine RTL-Sprache ist aktiv und ein Formular ist geöffnet
    When ich das Formular ohne Eingaben absende
    Then bleiben Platzhalter und Fehlermeldungen rechtsbündig und RTL-konform
    And die Fehlermeldungen beeinträchtigen nicht die Ausrichtung des Layouts

  @negative @regression
  Scenario: RTL-Unterstützung bei nicht unterstützter Sprache
    # Error-Szenario bei einer nicht verfügbaren Spracheinstellung
    Given eine nicht unterstützte Sprache wird ausgewählt
    When ich die Anwendung öffne
    Then wird eine verständliche Fehlermeldung angezeigt
    And die Anwendung fällt auf die zuletzt gültige Spracheinstellung zurück

  @regression @boundary
  Scenario: RTL-Layout bleibt korrekt bei sehr langen RTL-Texten
    # Boundary-Test für lange Texte in RTL-Layouts ohne Überlauf
    Given eine RTL-Sprache ist aktiv und eine Seite mit langen Textblöcken ist verfügbar
    When ich die Seite mit sehr langen RTL-Absätzen öffne
    Then bleiben Textausrichtung und Umbrüche RTL-konform
    And es kommt zu keinem Überlauf außerhalb des Containers

  @regression @edge-case
  Scenario Outline: Datengetriebene Prüfung von gemischten RTL/LTR-Inhalten
    # Scenario Outline zur Prüfung unterschiedlicher LTR-Einbettungen in RTL-Kontext
    Given eine RTL-Sprache ist aktiv und der Inhaltstyp <content_type> wird angezeigt
    When ich den Inhalt betrachte
    Then bleibt der LTR-Abschnitt <ltr_sample> lesbar und korrekt eingebettet
    And das Layout bleibt stabil ohne Verschiebungen

    Examples:
      | content_type | ltr_sample |
      | Zahlen und Datum | 2024-12-31 |
      | URL | https://example.com/path |
      | Technischer Begriff | API v2.1 |
