@@smoke @@regression
Feature: Schnellantwort aus Benachrichtigung
  As a Endnutzer der Messaging-App
  I want to direkt aus der Benachrichtigung eine Antwort senden
  So that um schnell und ohne App-Wechsel zu kommunizieren und die Antwortzeiten zu reduzieren

  Background:
    Given eine neue Nachricht ist eingegangen und eine Benachrichtigung ist sichtbar

  @@smoke @@regression @@happy-path
  Scenario: Schnellantwort erfolgreich senden
    # Prüft, dass eine Schnellantwort erfolgreich zugestellt und im Chat angezeigt wird
    Given der Nutzer hat Schreibberechtigung für den Chat
    When der Nutzer tippt eine Antwort in das Schnellantwortfeld und sendet sie
    Then die Antwort wird erfolgreich an den Absender zugestellt
    And die Antwort wird in der Konversation angezeigt

  @@regression @@negative @@boundary
  Scenario: Schnellantwort mit leerer Eingabe verhindern
    # Prüft die Randbedingung, dass leere Eingaben nicht gesendet werden
    Given der Nutzer hat Schreibberechtigung für den Chat
    When der Nutzer versucht eine Schnellantwort mit leerem Text zu senden
    Then das System verhindert das Senden
    And der Nutzer erhält einen Hinweis, dass eine Nachricht erforderlich ist

  @@regression @@negative
  Scenario: Schnellantwort ohne Schreibberechtigung
    # Prüft, dass Senden ohne Berechtigung blockiert wird
    Given der Nutzer hat keine Schreibberechtigung für den Chat
    When der Nutzer versucht eine Schnellantwort zu senden
    Then das System verhindert das Senden
    And eine verständliche Fehlermeldung wird angezeigt

  @@regression @@negative
  Scenario: Schnellantwort bei unterbrochener Netzwerkverbindung
    # Prüft Fehlverhalten bei fehlender Netzwerkverbindung
    Given die Netzwerkverbindung ist unterbrochen
    When der Nutzer sendet eine Schnellantwort
    Then die Nachricht wird nicht zugestellt
    And der Nutzer erhält einen Hinweis zur fehlgeschlagenen Zustellung

  @@regression @@boundary
  Scenario Outline: Schnellantwort mit maximaler Zeichenanzahl
    # Prüft die Grenzbedingung für sehr lange Antworten
    Given der Nutzer hat Schreibberechtigung für den Chat
    When der Nutzer sendet eine Schnellantwort mit der maximal erlaubten Zeichenanzahl <max_length>
    Then die Antwort wird erfolgreich an den Absender zugestellt
    And die Antwort wird vollständig in der Konversation angezeigt

    Examples:
      | max_length |
      | 500 |

  @@regression @@edge
  Scenario: Schnellantwort bei wiederhergestellter Verbindung erneut senden
    # Prüft den Edge Case, dass nach Verbindungswiederherstellung das Senden funktioniert
    Given die Netzwerkverbindung war unterbrochen und ist wiederhergestellt
    When der Nutzer sendet eine Schnellantwort
    Then die Antwort wird erfolgreich an den Absender zugestellt
    And die Antwort wird in der Konversation angezeigt

  @@regression @@edge
  Scenario Outline: Schnellantwort-Sendeversuch mit Sonderzeichen
    # Prüft, dass Sonderzeichen korrekt verarbeitet werden
    Given der Nutzer hat Schreibberechtigung für den Chat
    When der Nutzer sendet eine Schnellantwort mit dem Text <message_text>
    Then die Antwort wird erfolgreich an den Absender zugestellt
    And die Antwort wird mit unveränderten Zeichen in der Konversation angezeigt

    Examples:
      | message_text |
      | Danke! 👍 #schnell @team |
      | ÄÖÜ ß € © ✓ |
