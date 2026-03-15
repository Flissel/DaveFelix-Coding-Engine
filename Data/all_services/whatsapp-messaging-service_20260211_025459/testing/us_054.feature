@@smoke @@regression
Feature: Audio-Dateien senden
  As a registrierter Nutzer
  I want to Audio-Dateien in einer Nachricht senden
  So that um schnell und intuitiv Informationen auszutauschen und die Kommunikation zu erleichtern

  Background:
    Given der Nutzer ist in der App angemeldet und befindet sich in einem Chat

  @@smoke @@regression @@happy-path
  Scenario Outline: Unterstützte Audio-Dateien erfolgreich senden
    # Erfolgreiches Hochladen und Zustellen unterstützter Audio-Formate
    When er eine unterstützte Audio-Datei im Format <format> auswählt und sendet
    Then wird die Audio-Datei erfolgreich hochgeladen
    And die Audio-Datei wird dem Empfänger als Nachricht zugestellt

    Examples:
      | format |
      | mp3 |
      | wav |
      | m4a |

  @@regression @@negative @@error
  Scenario Outline: Nicht unterstützte Audio-Dateien werden abgelehnt
    # Fehlermeldung bei Auswahl nicht unterstützter Audio-Datei
    When er eine nicht unterstützte Audio-Datei im Format <format> auswählt
    Then erhält er eine verständliche Fehlermeldung
    And die Datei wird nicht gesendet

    Examples:
      | format |
      | flac |
      | aac-raw |
      | ogg |

  @@regression @@negative @@error
  Scenario: Versand bei instabiler Netzwerkverbindung schlägt fehl und kann erneut versucht werden
    # Fehlerhinweis und Retry-Option bei Netzwerkproblemen
    Given die Netzwerkverbindung ist instabil
    When er eine Audio-Datei sendet
    Then wird ein klarer Fehlerhinweis angezeigt
    And der Nutzer kann den Versand erneut versuchen

  @@regression @@edge @@boundary
  Scenario Outline: Audio-Datei an der Größen-Grenze senden
    # Grenzwerte für maximale Dateigröße werden korrekt behandelt
    When er eine Audio-Datei mit Größe <size_mb> MB auswählt und sendet
    Then wird die Datei <result> verarbeitet
    And <message> wird angezeigt

    Examples:
      | size_mb | result | message |
      | 24.9 | erfolgreich | keine Fehlermeldung |
      | 25.0 | erfolgreich | keine Fehlermeldung |
      | 25.1 | nicht | eine verständliche Fehlermeldung |
