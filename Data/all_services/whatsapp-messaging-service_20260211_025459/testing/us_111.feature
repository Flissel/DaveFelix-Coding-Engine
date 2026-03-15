@smoke @regression
Feature: Schneller App-Start
  As a Endnutzer
  I want to die App schnell starten
  So that um eine reibungslose und performante Nutzung ohne Wartezeit zu haben

  Background:
    Given die App ist auf dem Geraet installiert
    And alle erforderlichen Berechtigungen sind erteilt

  @smoke @regression @happy-path
  Scenario: Schneller Start unter normalen Bedingungen
    # Prueft, dass die Hauptansicht schnell angezeigt wird (Happy Path)
    Given das Geraet ist normal ausgelastet und hat ausreichend freien Speicher
    And eine Netzwerkverbindung ist verfuegbar
    When der Nutzer die App startet
    Then ist die App innerhalb des definierten Zeitlimits startbereit
    And die Hauptansicht wird angezeigt

  @regression @edge-case
  Scenario Outline: Start unter hoher Auslastung oder wenig Speicher
    # Prueft, dass die App auch bei Lastbedingungen schnell startet und bedienbar bleibt
    Given das Geraet hat die Auslastung <cpu_load> und freien Speicher <free_storage>
    When der Nutzer die App startet
    Then ist die App innerhalb des definierten Zeitlimits startbereit
    And die App bleibt bedienbar

    Examples:
      | cpu_load | free_storage |
      | hoch | niedrig |
      | sehr hoch | kritisch niedrig |

  @regression @edge-case
  Scenario: Start ohne Netzwerkverbindung
    # Prueft die Offline-Ansicht und Startfaehigkeit ohne Netzwerk
    Given keine Netzwerkverbindung ist verfuegbar
    When der Nutzer die App startet
    Then wird eine Offline-Ansicht angezeigt
    And die App bleibt startfaehig

  @regression @negative @error
  Scenario: Fehlende Berechtigung verhindert schnellen Start
    # Negativfall: Berechtigungen fehlen und die App zeigt einen Hinweis
    Given eine erforderliche Berechtigung ist nicht erteilt
    When der Nutzer die App startet
    Then wird ein Hinweis zur Berechtigung angezeigt
    And die Hauptansicht wird nicht angezeigt

  @regression @boundary
  Scenario Outline: Grenzwert fuer Startzeit bei minimalem freien Speicher
    # Boundary-Test fuer Startzeit bei minimal ausreichendem Speicher
    Given freier Speicher entspricht dem minimal erforderlichen Wert <min_free_storage>
    And das Geraet ist moderat ausgelastet
    When der Nutzer die App startet
    Then startet die App innerhalb des definierten Zeitlimits
    And die Hauptansicht wird angezeigt

    Examples:
      | min_free_storage |
      | 200MB |
      | 100MB |
