@@smoke @@regression
Feature: Kontakte synchronisieren
  As a Endnutzer
  I want to die Kontakte meines Geraets mit WhatsApp-Nutzern synchronisieren
  So that damit ich schnell und sicher sehen kann, welche meiner Kontakte auf WhatsApp verfuegbar sind, und Nachrichten zuverlaessig senden kann

  Background:
    Given die App ist installiert und der Nutzer ist angemeldet

  @@smoke @@regression @@happy-path
  Scenario Outline: Erfolgreiche Synchronisierung zeigt uebereinstimmende WhatsApp-Kontakte
    # Happy path: Kontakte werden abgeglichen und passende WhatsApp-Nutzer angezeigt
    Given der Nutzer hat der App Zugriff auf Geraete-Kontakte erlaubt
    And das Geraet enthaelt die Kontakte <geraetekontakte>
    And WhatsApp hat die Nutzer <whatsapp_nutzer>
    When der Nutzer die Synchronisierung startet
    Then das System gleicht die Kontakte mit WhatsApp-Nutzern ab
    And es werden die uebereinstimmenden Kontakte <erwartete_anzeige> angezeigt

    Examples:
      | geraetekontakte | whatsapp_nutzer | erwartete_anzeige |
      | Anna, Ben, Clara | Anna, Clara | Anna, Clara |
      | Dina, Erik | Dina | Dina |

  @@regression @@edge
  Scenario Outline: Kontakt ohne WhatsApp wird nicht angezeigt
    # Edge case: Nicht-WhatsApp-Kontakte werden ausgeschlossen
    Given der Nutzer hat der App Zugriff auf Geraete-Kontakte erlaubt
    And das Geraet enthaelt den Kontakt <kontaktname>
    And WhatsApp hat keine Nutzer mit diesen Kontaktdaten
    When die Synchronisierung laeuft
    Then der Kontakt wird nicht als WhatsApp-Nutzer angezeigt

    Examples:
      | kontaktname |
      | Max Mustermann |
      | Julia Beispiel |

  @@negative @@regression
  Scenario Outline: Fehlermeldung bei verweigerten Kontaktberechtigungen
    # Error scenario: Synchronisierung ohne Berechtigung
    Given der Nutzer hat den Zugriff auf Kontakte <berechtigungsstatus>
    When die Synchronisierung gestartet wird
    Then das System zeigt eine klare Fehlermeldung an
    And das System bietet an, die Berechtigung in den Einstellungen zu erteilen

    Examples:
      | berechtigungsstatus |
      | verweigert |
      | entzogen |

  @@regression @@boundary
  Scenario: Synchronisierung mit leerer Kontaktliste
    # Boundary condition: Keine Kontakte auf dem Geraet
    Given der Nutzer hat der App Zugriff auf Geraete-Kontakte erlaubt
    And das Geraet hat keine gespeicherten Kontakte
    When der Nutzer die Synchronisierung startet
    Then das System zeigt keine uebereinstimmenden WhatsApp-Kontakte an
    And es wird keine Fehlermeldung angezeigt
