@@smoke @@regression
Feature: Einladungslink für Gruppen
  As a Gruppenadministrator
  I want to einen Einladungslink für eine Gruppe erzeugen und teilen
  So that damit Nutzer schnell und plattformübergreifend einer Gruppe beitreten können, ohne manuelle Freigabe, bei gleichzeitigem Schutz der Gruppe

  Background:
    Given der Gruppenadministrator ist authentifiziert
    And der Gruppenadministrator hat Berechtigung zur Gruppenverwaltung

  @@happy-path @@smoke @@regression
  Scenario: Einladungslink wird erstellt und angezeigt
    # Happy path für die Erstellung eines eindeutigen, teilbaren Links
    When der Gruppenadministrator erstellt einen Einladungslink für die Gruppe
    Then wird ein eindeutiger Link generiert
    And der Link wird im UI angezeigt

  @@happy-path @@regression
  Scenario: Beitritt mit gültigem Einladungslink
    # Happy path für das Beitreten eines eingeladenen Nutzers
    Given ein gültiger Einladungslink wurde erstellt
    When der eingeladene Nutzer den Link öffnet
    Then kann der Nutzer der Gruppe beitreten
    And der Nutzer erhält eine Bestätigung

  @@negative @@regression
  Scenario: Einladungslink ist deaktiviert oder abgelaufen
    # Error scenario für ungültige Links
    Given ein Einladungslink wurde deaktiviert oder ist abgelaufen
    When ein Nutzer den Link öffnet
    Then wird der Beitritt verhindert
    And eine verständliche Fehlermeldung wird angezeigt

  @@edge @@regression
  Scenario Outline: Einladungslink Nutzung je nach Linkstatus
    # Scenario Outline für Edge und Boundary Conditions basierend auf Linkstatus
    Given ein Einladungslink mit Status "<status>" existiert
    When ein Nutzer den Link öffnet
    Then ist der Beitritt "<join_result>"
    And die Meldung "<message>" wird angezeigt

    Examples:
      | status | join_result | message |
      | gültig | erlaubt | Beitritt erfolgreich |
      | deaktiviert | verhindert | Einladungslink ist deaktiviert |
      | abgelaufen | verhindert | Einladungslink ist abgelaufen |
      | ungültiges Format | verhindert | Einladungslink ist ungültig |
