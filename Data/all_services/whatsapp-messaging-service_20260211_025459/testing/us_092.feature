@@smoke @@regression
Feature: Chat exportieren
  As a registrierter Nutzer
  I want to einen einzelnen Chat exportieren
  So that um Konversationen zu dokumentieren und weiterzugeben, ohne den Datenschutz zu verletzen

  Background:
    Given der Nutzer ist angemeldet

  @@smoke @@happy-path @@regression
  Scenario: Erfolgreicher Export eines bestehenden Chats
    # Stellt sicher, dass ein Chat erfolgreich exportiert und zum Download bereitgestellt wird
    Given der Nutzer befindet sich in einem bestehenden Einzelchat mit Nachrichten
    When der Nutzer die Export-Funktion für diesen Chat auslöst
    Then das System erstellt eine Exportdatei des ausgewählten Chats
    And die Exportdatei wird dem Nutzer zum Download bereitgestellt

  @@regression @@edge
  Scenario: Export eines leeren Chats liefert Datei mit Metadaten
    # Prüft den Export, wenn der Chat keine Nachrichten enthält
    Given der ausgewählte Chat enthält keine Nachrichten
    When der Nutzer den Export startet
    Then das System erstellt eine leere Exportdatei
    And die Exportdatei enthält Metadaten zum Chat

  @@negative @@regression
  Scenario: Export wird verweigert ohne Berechtigung
    # Stellt sicher, dass der Export ohne Berechtigung blockiert wird
    Given der Nutzer hat keine Berechtigung zum Exportieren des Chats
    When der Nutzer den Export versucht
    Then das System verweigert den Export
    And das System zeigt eine verständliche Fehlermeldung an

  @@regression @@boundary @@outline
  Scenario Outline: Exportformat und Grenzwerte für Nachrichtenanzahl
    # Überprüft Exportverhalten für unterschiedliche Formate und Nachrichtenzahlen
    Given der Nutzer befindet sich in einem bestehenden Einzelchat mit <message_count> Nachrichten
    When der Nutzer den Export im Format <format> startet
    Then das System erstellt eine Exportdatei im Format <format>
    And die Exportdatei ist vollständig und enthält alle <message_count> Nachrichten

    Examples:
      | message_count | format |
      | 1 | PDF |
      | 5000 | JSON |
