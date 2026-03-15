@smoke @regression
Feature: Labels/Tags Management
  As a Business-Nutzer
  I want to Kontakt-Labels anlegen, bearbeiten und Kontakten zuweisen
  So that Kundenkontakte strukturiert verwalten und zielgerichtet kommunizieren

  Background:
    Given ein Business-Nutzer ist angemeldet und befindet sich im Kontaktbereich

  @happy-path @smoke @regression
  Scenario: Label anlegen und Kontakt zuweisen (Happy Path)
    # Erstellt ein neues Label mit gültigem Namen und weist es einem Kontakt zu
    Given ein Kontakt ohne dieses Label existiert
    When der Nutzer ein neues Label mit dem Namen "Premium" anlegt
    And der Nutzer das Label dem Kontakt zuweist
    Then wird das Label gespeichert
    And wird das Label beim Kontakt sichtbar angezeigt

  @regression
  Scenario: Labelname bearbeiten und bei allen Kontakten aktualisieren
    # Ändert den Namen eines bestehenden Labels und prüft die Aktualisierung bei zugewiesenen Kontakten
    Given ein bestehendes Label "VIP" ist zwei Kontakten zugewiesen
    When der Nutzer den Labelnamen in "VIP-Kunde" ändert
    Then werden die Änderungen gespeichert
    And wird der neue Labelname bei allen zugewiesenen Kontakten angezeigt

  @regression
  Scenario: Label löschen und von Kontakten entfernen
    # Löscht ein Label, das Kontakten zugewiesen ist, und entfernt es automatisch
    Given ein Label "Newsletter" ist einem Kontakt zugewiesen
    When der Nutzer das Löschen des Labels bestätigt
    Then wird das Label entfernt
    And wird das Label von allen betroffenen Kontakten automatisch gelöst

  @negative @regression
  Scenario: Doppeltes Label verhindern (Fehlerfall)
    # Verhindert das Speichern eines Labels mit bereits existierendem Namen
    Given ein Label mit dem Namen "Stammkunde" existiert bereits
    When der Nutzer versucht ein weiteres Label mit dem Namen "Stammkunde" zu speichern
    Then wird eine verständliche Fehlermeldung angezeigt
    And wird das Label nicht dupliziert

  @edge @regression
  Scenario Outline: Labelname-Grenzen validieren (Boundary/Edge)
    # Validiert minimale und maximale Länge für Labelnamen
    Given der Nutzer öffnet den Dialog zum Erstellen eines Labels
    When der Nutzer einen Labelnamen mit der Länge "<length>" eingibt
    Then ist das Speichern "<save_result>"
    And ist die Rückmeldung "<message>"

    Examples:
      | length | save_result | message |
      | 1 | erlaubt | keine Fehlermeldung |
      | 50 | erlaubt | keine Fehlermeldung |
      | 0 | nicht erlaubt | Fehlermeldung: Name ist erforderlich |
      | 51 | nicht erlaubt | Fehlermeldung: Name ist zu lang |

  @negative @edge @regression
  Scenario Outline: Ungültige Zeichen im Labelnamen (Edge/Error)
    # Verhindert das Speichern von Labels mit ungültigen Zeichen
    Given der Nutzer öffnet den Dialog zum Erstellen eines Labels
    When der Nutzer den Labelnamen "<label_name>" eingibt
    Then wird das Speichern "<save_result>"
    And ist die Rückmeldung "<message>"

    Examples:
      | label_name | save_result | message |
      | VIP&Gold | nicht erlaubt | Fehlermeldung: ungültige Zeichen |
      | Team-Lead | erlaubt | keine Fehlermeldung |
