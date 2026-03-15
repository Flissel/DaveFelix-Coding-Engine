@@smoke @@regression
Feature: Nachricht zitieren
  As a Endnutzer
  I want to eine spezifische Nachricht in einem Chat zitieren und darauf antworten
  So that damit der Kontext der Kommunikation klar bleibt und die Bedienung intuitiv ist

  Background:
    Given der Nutzer ist authentifiziert und befindet sich in einem bestehenden Chat
    And im Chat sind mehrere Nachrichten sichtbar

  @@smoke @@regression @@happy-path
  Scenario: Zitieren und antworten auf eine vorhandene Nachricht
    # Happy path: Eine vorhandene Nachricht wird zitiert und die Antwort wird erfolgreich gesendet
    Given eine spezifische Nachricht mit sichtbarem Text ist vorhanden
    When der Nutzer wählt die Nachricht aus und führt die Funktion "Zitieren/Antworten" aus
    And der Nutzer gibt eine Antwortnachricht ein und sendet sie ab
    Then die Antwort wird gesendet und enthält das Zitat der ausgewählten Nachricht
    And das Zitat wird im Antwortbereich korrekt formatiert angezeigt

  @@regression @@negative
  Scenario: Zitieren nicht verfügbarer Nachricht
    # Error scenario: Zitat ist nicht möglich, weil die Nachricht nicht mehr verfügbar ist
    Given eine Nachricht ist in der UI sichtbar, wurde aber serverseitig gelöscht
    When der Nutzer versucht die gelöschte Nachricht zu zitieren
    Then der Nutzer erhält eine verständliche Meldung, dass die Nachricht nicht mehr verfügbar ist
    And der Nutzer kann eine normale Antwort ohne Zitat senden

  @@regression @@performance
  Scenario: Performance beim Zitieren in langen Chats
    # Boundary/performance: Zitieren in stark frequentierten Chats ohne spürbare Verzögerung
    Given der Chat enthält eine sehr lange Nachrichtenliste
    When der Nutzer zitiert eine Nachricht aus der Liste
    Then die Zitierfunktion wird ohne spürbare Verzögerung ausgeführt
    And die Benutzeroberfläche bleibt responsiv

  @@regression @@edge
  Scenario Outline: Zitieren verschiedener Nachrichtentypen
    # Edge case: Zitat funktioniert für unterschiedliche Nachrichtentypen
    Given die ausgewählte Nachricht ist vom Typ "<message_type>"
    When der Nutzer führt die Funktion "Zitieren/Antworten" aus
    Then das Zitat wird korrekt angezeigt und die Antwort kann gesendet werden

    Examples:
      | message_type |
      | Text |
      | Bild mit Beschreibung |
      | Emoji-only |

  @@regression @@negative @@boundary
  Scenario: Zitieren und Senden mit leerer Antwort
    # Boundary/error: Verhindert das Senden ohne Antwortinhalt
    Given der Nutzer hat eine Nachricht zum Zitieren ausgewählt
    When der Nutzer versucht eine Antwort ohne Text zu senden
    Then die Antwort wird nicht gesendet und eine verständliche Validierungsmeldung wird angezeigt
    And das Zitat bleibt im Antwortbereich erhalten

  @@regression @@happy-path
  Scenario Outline: Zitieren mit Datenvarianten der Antwort
    # Data-driven: Antworten mit unterschiedlichen Längen werden korrekt gesendet
    Given eine Nachricht ist zum Zitieren ausgewählt
    When der Nutzer gibt die Antwort "<reply_text>" ein und sendet sie ab
    Then die Antwort wird gesendet und enthält das Zitat der ausgewählten Nachricht

    Examples:
      | reply_text |
      | OK |
      | Das ist eine ausführliche Antwort zur zitierten Nachricht. |
