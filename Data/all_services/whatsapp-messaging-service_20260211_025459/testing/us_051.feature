@smoke @regression
Feature: Sticker im Chat senden und empfangen
  As a registrierter Nutzer
  I want to Sticker im Chat senden und empfangen
  So that Unterhaltungen ausdrucksstark und intuitiv gestalten

  Background:
    Given ein registrierter Nutzer ist im Chat angemeldet

  @@smoke @@regression @@happy-path
  Scenario: Sticker erfolgreich senden und empfangen
    # Prüft den erfolgreichen Versand und die Zustellung eines Stickers im aktiven Chat
    Given ein aktiver Chat ist geöffnet und die Internetverbindung ist stabil
    When der Nutzer wählt einen Sticker aus dem Sticker-Menü und sendet ihn
    Then der Sticker wird im Chat des Senders angezeigt
    And der Sticker wird dem Empfänger zugestellt und angezeigt

  @@regression @@negative @@edge
  Scenario: Sticker-Auswahl verhindert Senden bei keiner Auswahl
    # Prüft die Validierung, wenn kein Sticker ausgewählt wurde
    Given ein aktiver Chat ist geöffnet und die Internetverbindung ist stabil
    When der Nutzer versucht ohne Sticker-Auswahl zu senden
    Then das System verhindert den Versand
    And das System zeigt einen Hinweis zur Sticker-Auswahl

  @@regression @@negative @@error
  Scenario: Fehler beim Senden ohne Verbindung mit erneuter Sendung
    # Prüft die Fehlermeldung und die Option zur erneuten Sendung bei Verbindungsabbruch
    Given ein aktiver Chat ist geöffnet und die Internetverbindung ist unterbrochen
    When der Nutzer wählt einen Sticker aus dem Sticker-Menü und sendet ihn
    Then das System zeigt eine Fehlermeldung an
    And das System bietet eine erneute Sendung an

  @@regression @@happy-path @@edge
  Scenario Outline: Senden verschiedener Sticker-Typen
    # Prüft den Versand unterschiedlicher Sticker-Typen als Datenvariation
    Given ein aktiver Chat ist geöffnet und die Internetverbindung ist stabil
    When der Nutzer wählt den Sticker "<sticker_type>" aus dem Sticker-Menü und sendet ihn
    Then der Sticker "<sticker_type>" wird im Chat angezeigt
    And der Sticker "<sticker_type>" wird dem Empfänger zugestellt

    Examples:
      | sticker_type |
      | statischer Sticker |
      | animierter Sticker |
      | benutzerdefinierter Sticker |
