@smoke @regression
Feature: One-Way-Broadcast-Kanal (Kanaele)
  As a Business-Administrator
  I want to einen One-Way-Broadcast-Kanal erstellen und Nachrichten an Abonnenten senden
  So that um Kunden professionell und zuverlässig zu informieren, ohne dass Antworten den Kanal überfluten

  Background:
    Given der Administrator ist authentifiziert und hat Berechtigung zur Kanalverwaltung

  @happy-path @smoke @regression
  Scenario: Erfolgreiches Erstellen eines One-Way-Broadcast-Kanals und Senden einer Nachricht
    # Happy Path: Nachricht wird an alle Abonnenten zugestellt und nur Administratoren können posten
    Given es existieren Abonnenten im neuen One-Way-Broadcast-Kanal
    When der Administrator den One-Way-Broadcast-Kanal erstellt und eine Nachricht sendet
    Then wird die Nachricht an alle Abonnenten zugestellt
    And nur Administratoren können im Kanal posten

  @negative @regression
  Scenario: Abonnent versucht im One-Way-Broadcast-Kanal zu posten
    # Error Scenario: Aktion wird blockiert und es gibt eine Fehlermeldung
    Given ein Abonnent ist im One-Way-Broadcast-Kanal registriert
    When der Abonnent eine Nachricht im Kanal sendet
    Then wird die Aktion blockiert
    And der Abonnent erhält eine klare Fehlermeldung

  @negative @regression
  Scenario: Teilweise fehlgeschlagene Zustellung mit automatischer Wiederholung
    # Error/Edge: Administrator wird informiert und fehlgeschlagene Zustellungen werden erneut versucht
    Given es gibt Abonnenten mit temporären Zustellproblemen
    When der Administrator eine Nachricht sendet und die Zustellung an einige Abonnenten fehlschlägt
    Then wird der Administrator über die fehlgeschlagenen Zustellungen informiert
    And die Nachricht wird für betroffene Empfänger erneut zugestellt

  @edge @regression
  Scenario: Senden einer Nachricht an einen Kanal mit 0 Abonnenten
    # Edge Case: Versand ist erfolgreich, aber es gibt keine Empfänger
    Given der One-Way-Broadcast-Kanal hat keine Abonnenten
    When der Administrator eine Nachricht sendet
    Then wird die Nachricht erfolgreich verarbeitet
    And es wird angezeigt, dass keine Zustellungen erforderlich sind

  @boundary @regression
  Scenario Outline: Nachrichtensende-Validierung für minimale und maximale Textlänge
    # Boundary Condition: Nachrichtentext wird anhand der Längenbegrenzung validiert
    Given der One-Way-Broadcast-Kanal ist aktiv und hat Abonnenten
    When der Administrator eine Nachricht mit der Länge <message_length> sendet
    Then ist das Ergebnis <expected_result>
    And eine passende Meldung <user_feedback> wird angezeigt

    Examples:
      | message_length | expected_result | user_feedback |
      | 1 | erfolgreich | die Nachricht wurde gesendet |
      | 5000 | erfolgreich | die Nachricht wurde gesendet |
      | 5001 | fehlgeschlagen | die Nachricht ist zu lang |

  @negative @regression
  Scenario: Zugriffssteuerung: Nicht-Administrator versucht Kanal zu erstellen
    # Error Scenario: Unberechtigter Benutzer wird abgewiesen
    Given ein authentifizierter Benutzer ohne Kanalverwaltungsrechte
    When der Benutzer versucht, einen One-Way-Broadcast-Kanal zu erstellen
    Then wird die Aktion blockiert
    And der Benutzer erhält eine Berechtigungsfehlermeldung
