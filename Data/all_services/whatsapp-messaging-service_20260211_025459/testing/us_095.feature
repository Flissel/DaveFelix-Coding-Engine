@smoke @regression
Feature: Chat anpinnen
  As a Endnutzer
  I want to einen wichtigen Chat anpinnen
  So that um wichtige Unterhaltungen schnell zu finden und die Bedienung intuitiv zu halten

  Background:
    Given der Nutzer ist angemeldet und sieht die Chatliste

  @happy-path @smoke @regression
  Scenario: Chat erfolgreich anpinnen und nach oben verschieben
    # Verifiziert das erfolgreiche Anpinnen eines nicht angepinnten Chats
    Given ein Chat mit dem Namen "Projekt A" ist nicht angepinnt
    When der Nutzer wählt die Option zum Anpinnen für "Projekt A"
    Then "Projekt A" ist als angepinnt markiert
    And "Projekt A" wird oben in der Chatliste angezeigt

  @happy-path @regression
  Scenario: Mehrere Chats anpinnen und Reihenfolge beibehalten
    # Stellt sicher, dass mehrere angepinnte Chats oben angezeigt werden
    Given die Chats "Projekt A" und "Projekt B" sind nicht angepinnt
    When der Nutzer pinnt zuerst "Projekt A" und danach "Projekt B" an
    Then beide Chats sind als angepinnt markiert
    And die angepinnten Chats werden oben in der Chatliste angezeigt

  @edge-case @regression
  Scenario: Erneutes Anpinnen eines bereits angepinnten Chats
    # Edge Case: Kein doppelter Eintrag beim erneuten Anpinnen
    Given ein Chat mit dem Namen "Projekt A" ist bereits angepinnt
    When der Nutzer wählt die Option zum Anpinnen für "Projekt A" erneut
    Then "Projekt A" bleibt angepinnt
    And es existiert nur ein Eintrag für "Projekt A" in der Chatliste

  @negative @regression
  Scenario: Anpinnen eines nicht mehr existierenden Chats
    # Error Case: Fehlermeldung und keine Änderung an der Liste
    Given der Chat "Veraltet" existiert nicht mehr in der Chatliste
    When der Nutzer versucht, den Chat "Veraltet" anzupinnen
    Then das System zeigt eine Fehlermeldung an
    And die Chatliste bleibt unverändert

  @regression @boundary
  Scenario Outline: Anpinnen mit Datenvarianten
    # Boundary/Datengrenzen: unterschiedliche Chatnamenlängen
    Given ein Chat mit dem Namen "<chat_name>" ist nicht angepinnt
    When der Nutzer wählt die Option zum Anpinnen für "<chat_name>"
    Then der Chat "<chat_name>" ist angepinnt
    And der Chat "<chat_name>" wird oben in der Chatliste angezeigt

    Examples:
      | chat_name |
      | A |
      | Projekt Alpha 2024 - Sprint 1 |
