@@smoke @@regression
Feature: Favoriten
  As a Endnutzer
  I want to Kontakte als Favoriten markieren und in einer Favoritenliste verwalten
  So that um haeufig genutzte Kontakte schneller zu finden und Nachrichten effizienter zu versenden

  Background:
    Given der Nutzer ist angemeldet

  @@smoke @@regression @@happy-path
  Scenario: Kontakt als Favorit markieren (Happy Path)
    # Prueft, dass ein vorhandener Kontakt als Favorit markiert wird und sofort in der Favoritenliste erscheint
    Given ein Kontakt mit dem Namen "Anna Schmidt" ist vorhanden
    When der Nutzer den Kontakt als Favorit markiert
    Then der Kontakt erscheint sofort in der Favoritenliste
    And der Kontakt ist als Favorit gekennzeichnet

  @@regression @@happy-path
  Scenario: Favoriten-Markierung entfernen (Happy Path)
    # Prueft, dass ein Favorit korrekt aus der Favoritenliste entfernt wird
    Given ein Kontakt mit dem Namen "Max Mueller" ist als Favorit markiert
    When der Nutzer die Favoriten-Markierung entfernt
    Then der Kontakt wird aus der Favoritenliste entfernt
    And die Favoriten-Kennzeichnung ist nicht mehr sichtbar

  @@regression @@edge
  Scenario: Leere Favoritenliste anzeigen (Edge Case)
    # Prueft den leeren Zustand in der Favoritenansicht
    Given die Favoritenliste ist leer
    When der Nutzer die Favoritenansicht oeffnet
    Then ein leerer Zustand mit Hinweis wird angezeigt
    And es treten keine Fehler auf

  @@regression @@boundary
  Scenario: Mehrfaches Markieren eines bereits favorisierten Kontakts (Boundary)
    # Prueft, dass mehrfaches Markieren keine Duplikate erzeugt
    Given ein Kontakt mit dem Namen "Erika Muster" ist als Favorit markiert
    When der Nutzer den Kontakt erneut als Favorit markiert
    Then der Kontakt erscheint nur einmal in der Favoritenliste
    And die Favoriten-Kennzeichnung bleibt aktiv

  @@regression @@negative
  Scenario: Favorit-Markierung bei Netzwerkfehler (Error)
    # Prueft das Verhalten bei fehlgeschlagener Speicherung
    Given ein Kontakt mit dem Namen "Lukas Weber" ist vorhanden
    And die Verbindung zum Server ist unterbrochen
    When der Nutzer den Kontakt als Favorit markiert
    Then eine Fehlermeldung wird angezeigt
    And der Kontakt erscheint nicht in der Favoritenliste

  @@regression
  Scenario Outline: Kontakt als Favorit markieren - datengesteuert
    # Prueft das Markieren verschiedener Kontakte als Favoriten
    Given ein Kontakt mit dem Namen "<contact_name>" ist vorhanden
    When der Nutzer den Kontakt als Favorit markiert
    Then der Kontakt erscheint sofort in der Favoritenliste
    And der Kontakt ist als Favorit gekennzeichnet

    Examples:
      | contact_name |
      | Julia Klein |
      | Sven Richter |
      | Mia Fischer |
