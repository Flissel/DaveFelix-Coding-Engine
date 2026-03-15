@@smoke @@regression
Feature: Status-Datenschutz
  As a registrierter Nutzer
  I want to die Sichtbarkeit meines Status für definierte Kontakte konfigurieren
  So that meine Privatsphäre zu schützen und dennoch relevante Kontakte zu informieren

  Background:
    Given ich bin als registrierter Nutzer angemeldet und befinde mich in den Datenschutzeinstellungen

  @@smoke @@happy-path @@regression
  Scenario Outline: Status-Sichtbarkeit auf vordefinierte Optionen setzen
    # Erfolgreiches Speichern einer Sichtbarkeitsoption mit sofortiger Wirkung
    Given ich sehe die verfügbaren Sichtbarkeitsoptionen für meinen Status
    When ich wähle die Option <visibility_option> und speichere
    Then die Auswahl wird gespeichert
    And die Statusanzeige ist sofort entsprechend <visibility_option> sichtbar

    Examples:
      | visibility_option |
      | Alle Kontakte |
      | Nur Favoriten |
      | Niemand |

  @@edge @@regression
  Scenario: Benutzerdefinierte Kontaktliste vollständig leeren
    # Edge Case: Leere Liste führt zu keiner Sichtbarkeit und Systembestätigung
    Given ich habe die Sichtbarkeitsoption Benutzerdefinierte Liste ausgewählt
    And die benutzerdefinierte Liste enthält mindestens einen Kontakt
    When ich entferne alle Kontakte aus der Liste und speichere
    Then mein Status ist für niemanden sichtbar
    And das System bestätigt die Änderung

  @@negative @@regression
  Scenario: Keine Berechtigung zum Speichern
    # Error Scenario: Speichern wird abgelehnt und Fehlermeldung angezeigt
    Given ich habe keine Berechtigung, die Datenschutzeinstellungen zu ändern
    When ich versuche eine neue Sichtbarkeitsoption zu speichern
    Then die Änderung wird abgelehnt
    And eine verständliche Fehlermeldung wird angezeigt

  @@boundary @@regression
  Scenario: Grenzfall: Benutzerdefinierte Liste mit einem Kontakt
    # Boundary Condition: Liste mit minimaler Anzahl an Kontakten
    Given ich habe die Sichtbarkeitsoption Benutzerdefinierte Liste ausgewählt
    And die benutzerdefinierte Liste enthält genau einen Kontakt
    When ich speichere die Einstellungen
    Then die Auswahl wird gespeichert
    And der Status ist nur für diesen einen Kontakt sichtbar

  @@negative @@regression
  Scenario: Ungültige Eingabe bei benutzerdefinierter Liste
    # Error Scenario: Speichern mit ungültigen Kontakten wird verhindert
    Given ich habe die Sichtbarkeitsoption Benutzerdefinierte Liste ausgewählt
    And die Liste enthält einen ungültigen Kontaktverweis
    When ich speichere die Einstellungen
    Then die Änderung wird abgelehnt
    And eine verständliche Fehlermeldung wird angezeigt
