# Test Documentation

**Generated:** 2026-02-12T17:14:32.929626

## Summary

- Gherkin Features: 0
- Total Scenarios: 0
- Test Cases: 1094

---

## Gherkin Features

---

## Test Cases

### TC-001: Erfolgreiche Registrierung mit gültiger Telefonnummer und korrektem Verifizierungscode

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-001
**Requirement:** WA-AUTH-001

**Description:** Prüft den vollständigen Happy-Path der Registrierung inkl. Verifizierung

**Preconditions:**
- Registrierungsseite ist erreichbar
- SMS-Versanddienst ist verfügbar

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | Registrierungsseite öffnen | Registrierungsformular wird angezeigt |
| 2 | Gültige Telefonnummer eingeben (z. B. +49 151 12345678) | Telefonnummer wird ohne Validierungsfehler akzeptiert |
| 3 | Registrierung absenden | System zeigt Eingabefeld für Verifizierungscode und sendet SMS |
| 4 | Empfangenen Verifizierungscode korrekt eingeben | System bestätigt den Code |
| 5 | Verifizierung bestätigen | Konto wird erstellt und Telefonnummer als verifiziert markiert |

**Final Expected Result:** Der Nutzer ist registriert und die Telefonnummer ist verifiziert

---

### TC-002: Registrierung mit leerer Telefonnummer

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-001
**Requirement:** WA-AUTH-001

**Description:** Validiert Fehlerbehandlung bei fehlender Eingabe

**Preconditions:**
- Registrierungsseite ist erreichbar

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | Registrierungsseite öffnen | Registrierungsformular wird angezeigt |
| 2 | Telefonnummer-Feld leer lassen | Feld bleibt leer |
| 3 | Registrierung absenden | Fehlermeldung wird angezeigt und Registrierung wird verhindert |

**Final Expected Result:** Registrierung wird abgelehnt und Nutzer erhält verständliche Fehlermeldung

---

### TC-003: Registrierung mit ungültigem Telefonnummernformat

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-001
**Requirement:** WA-AUTH-001

**Description:** Prüft Validierung bei ungültigem Format

**Preconditions:**
- Registrierungsseite ist erreichbar

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | Registrierungsseite öffnen | Registrierungsformular wird angezeigt |
| 2 | Ungültige Telefonnummer eingeben (z. B. 123ABC) | System markiert Eingabe als ungültig |
| 3 | Registrierung absenden | Fehlermeldung erscheint und Registrierung wird verhindert |

**Final Expected Result:** Registrierung wird blockiert und verständliche Fehlermeldung angezeigt

---

### TC-004: Registrierung mit zu kurzer Telefonnummer (Grenzwert)

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-001
**Requirement:** WA-AUTH-001

**Description:** Prüft die untere Grenze der Telefonnummernlänge

**Preconditions:**
- Registrierungsseite ist erreichbar

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | Registrierungsseite öffnen | Registrierungsformular wird angezeigt |
| 2 | Telefonnummer mit minimaler - 1 Länge eingeben (z. B. 4 Ziffern, wenn min 5) | Validierungsfehler wird angezeigt |
| 3 | Registrierung absenden | Fehlermeldung erscheint und Registrierung wird verhindert |

**Final Expected Result:** System verhindert Registrierung bei zu kurzer Nummer

---

### TC-005: Registrierung mit zu langer Telefonnummer (Grenzwert)

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-001
**Requirement:** WA-AUTH-001

**Description:** Prüft die obere Grenze der Telefonnummernlänge

**Preconditions:**
- Registrierungsseite ist erreichbar

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | Registrierungsseite öffnen | Registrierungsformular wird angezeigt |
| 2 | Telefonnummer mit maximaler + 1 Länge eingeben | Validierungsfehler wird angezeigt |
| 3 | Registrierung absenden | Fehlermeldung erscheint und Registrierung wird verhindert |

**Final Expected Result:** System blockiert Registrierung bei zu langer Nummer

---

### TC-006: Falscher Verifizierungscode

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-001
**Requirement:** WA-AUTH-001

**Description:** Prüft Rückweisung bei falschem Code und Anzeige der Neuversand-Option

**Preconditions:**
- Registrierung mit gültiger Telefonnummer gestartet
- SMS mit Verifizierungscode wurde gesendet

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | Verifizierungsseite öffnen (nach Absenden der Registrierung) | Code-Eingabefeld ist sichtbar |
| 2 | Falschen Verifizierungscode eingeben | System erkennt den Code als ungültig |
| 3 | Verifizierung absenden | Fehlermeldung erscheint und Option zum erneuten Anfordern wird angezeigt |

**Final Expected Result:** Code wird zurückgewiesen und Neuversand-Option ist verfügbar

---

### TC-007: Abgelaufener Verifizierungscode

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-001
**Requirement:** WA-AUTH-001

**Description:** Prüft die Behandlung eines abgelaufenen Codes und die Option zum Neuversand

**Preconditions:**
- Registrierung mit gültiger Telefonnummer gestartet
- Verifizierungscode ist abgelaufen

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | Abgelaufenen Code eingeben | System erkennt den Code als abgelaufen |
| 2 | Verifizierung absenden | Fehlermeldung erscheint und Option zum erneuten Anfordern wird angezeigt |

**Final Expected Result:** Abgelaufener Code wird abgewiesen, Neuversand-Option ist verfügbar

---

### TC-008: Erneutes Anfordern eines Verifizierungscodes

**Type:** integration
**Priority:** medium
**Status:** manual
**User Story:** US-001
**Requirement:** WA-AUTH-001

**Description:** Prüft, dass ein neuer Code angefordert und verwendet werden kann

**Preconditions:**
- Registrierung mit gültiger Telefonnummer gestartet
- Vorheriger Code ist ungültig oder abgelaufen

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | Auf 'Code erneut senden' klicken | System bestätigt die Anforderung und sendet neuen Code |
| 2 | Neuen Verifizierungscode eingeben | System akzeptiert den neuen Code |
| 3 | Verifizierung bestätigen | Konto wird erstellt und Telefonnummer als verifiziert markiert |

**Final Expected Result:** Neuer Code funktioniert und Registrierung wird abgeschlossen

---

### TC-009: SMS-Zustellproblem während der Registrierung

**Type:** integration
**Priority:** high
**Status:** manual
**User Story:** US-001
**Requirement:** WA-AUTH-001

**Description:** Prüft Systemverhalten bei temporären Zustellproblemen

**Preconditions:**
- Registrierungsseite ist erreichbar
- SMS-Dienst ist temporär nicht verfügbar

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | Gültige Telefonnummer eingeben und Registrierung absenden | System versucht SMS zu senden |
| 2 | Zustellfehler wird simuliert | System zeigt Hinweis auf Zustellproblem |
| 3 | Option für späteren erneuten Versand auswählen | System bestätigt die Möglichkeit für späteren Neuversand |

**Final Expected Result:** Nutzer wird über Zustellprobleme informiert und kann später neu anfordern

---

### TC-010: Mehrfache Eingabe falscher Codes (Sicherheits- und UX-Verhalten)

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-001
**Requirement:** WA-AUTH-001

**Description:** Prüft Konsistenz der Fehlermeldung und Neuversand-Option bei wiederholten Fehleingaben

**Preconditions:**
- Registrierung mit gültiger Telefonnummer gestartet
- SMS mit Verifizierungscode wurde gesendet

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | Falschen Code eingeben und absenden (1. Versuch) | Fehlermeldung und Neuversand-Option angezeigt |
| 2 | Falschen Code erneut eingeben und absenden (2. Versuch) | Fehlermeldung bleibt verständlich und Neuversand-Option bleibt verfügbar |

**Final Expected Result:** System bleibt stabil, meldet Fehler korrekt und bietet Neuversand-Option

---

### TC-011: Registrierung mit internationaler Telefonnummer im gültigen Format

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-001
**Requirement:** WA-AUTH-001

**Description:** Prüft Akzeptanz internationaler Nummern mit Länderkennung

**Preconditions:**
- Registrierungsseite ist erreichbar
- SMS-Versanddienst unterstützt internationale Nummern

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | Internationale Telefonnummer eingeben (z. B. +1 415 555 2671) | Telefonnummer wird akzeptiert |
| 2 | Registrierung absenden | System zeigt Verifizierungsseite und sendet SMS |

**Final Expected Result:** Internationale Nummer wird akzeptiert und Registrierung fortgesetzt

---

### TC-012: Erneutes Öffnen der Verifizierungsseite nach Seitenneuladen

**Type:** functional
**Priority:** low
**Status:** manual
**User Story:** US-001
**Requirement:** WA-AUTH-001

**Description:** Prüft den Erhalt des Verifizierungsstatus bei Reload

**Preconditions:**
- Registrierung mit gültiger Telefonnummer gestartet
- Verifizierungsseite ist geöffnet

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | Seite neu laden | Verifizierungsseite bleibt verfügbar |
| 2 | Verifizierungscode eingeben | System akzeptiert den Code bei Gültigkeit |

**Final Expected Result:** Verifizierung kann nach Reload fortgesetzt werden

---

### TC-013: Aktivierung von 2FA mit gültiger 6-stelliger PIN

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-002
**Requirement:** WA-AUTH-002

**Description:** Verifiziert, dass ein angemeldeter Nutzer 2FA aktivieren und eine gültige 6-stellige PIN speichern kann

**Preconditions:**
- Nutzer ist angemeldet
- 2FA ist deaktiviert

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigiere zu den Sicherheitseinstellungen des Nutzerkontos | Die Seite mit den 2FA-Einstellungen wird angezeigt |
| 2 | 2. Aktiviere die Option für 2FA | Eingabefeld für 6-stellige PIN wird angezeigt |
| 3 | 3. Gib eine gültige 6-stellige PIN ein (z. B. 123456) und bestätige | Bestätigung der PIN-Eingabe wird angenommen |
| 4 | 4. Speichere die Einstellungen | 2FA wird aktiviert und eine Erfolgsmeldung erscheint |

**Final Expected Result:** 2FA ist aktiviert und die 6-stellige PIN ist als zweiter Faktor gespeichert

---

### TC-014: Login mit korrektem Passwort und korrekter 6-stelliger PIN

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-002
**Requirement:** WA-AUTH-002

**Description:** Stellt sicher, dass ein Nutzer mit aktiviertem 2FA sich erfolgreich anmelden kann

**Preconditions:**
- 2FA ist aktiviert
- Nutzerkonto existiert

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Öffne die Login-Seite | Login-Formular wird angezeigt |
| 2 | 2. Gib gültigen Benutzernamen und korrektes Passwort ein und bestätige | Eingabeaufforderung für 6-stellige PIN wird angezeigt |
| 3 | 3. Gib die korrekte 6-stellige PIN ein und bestätige | Nutzer wird erfolgreich eingeloggt |

**Final Expected Result:** Login wird erfolgreich abgeschlossen

---

### TC-015: Ablehnung bei PIN mit weniger als 6 Stellen

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-002
**Requirement:** WA-AUTH-002

**Description:** Überprüft die Validierung bei zu kurzer PIN

**Preconditions:**
- 2FA ist aktiviert
- Nutzer befindet sich im 2FA-PIN-Eingabeschritt beim Login

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Gib eine PIN mit 5 Stellen ein (z. B. 12345) | Eingabe wird als ungültig markiert |
| 2 | 2. Bestätige die Eingabe | Fehlermeldung wird angezeigt und Login wird nicht fortgesetzt |

**Final Expected Result:** Eingabe wird abgelehnt und eine verständliche Fehlermeldung angezeigt

---

### TC-016: Ablehnung bei PIN mit mehr als 6 Stellen

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-002
**Requirement:** WA-AUTH-002

**Description:** Überprüft die Validierung bei zu langer PIN

**Preconditions:**
- 2FA ist aktiviert
- Nutzer befindet sich im 2FA-PIN-Eingabeschritt beim Login

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Gib eine PIN mit 7 Stellen ein (z. B. 1234567) | Eingabe wird als ungültig markiert |
| 2 | 2. Bestätige die Eingabe | Fehlermeldung wird angezeigt und Login wird nicht fortgesetzt |

**Final Expected Result:** Eingabe wird abgelehnt und eine verständliche Fehlermeldung angezeigt

---

### TC-017: Login mit falscher 6-stelliger PIN

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-002
**Requirement:** WA-AUTH-002

**Description:** Stellt sicher, dass ein falscher PIN-Versuch den Login blockiert ohne sensible Informationen preiszugeben

**Preconditions:**
- 2FA ist aktiviert
- Nutzerkonto existiert
- Nutzer hat korrektes Passwort eingegeben

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Gib eine falsche 6-stellige PIN ein (z. B. 654321) | Eingabe wird akzeptiert, aber als falsch erkannt |
| 2 | 2. Bestätige die Eingabe | Login wird blockiert und Fehlermeldung ohne sensible Details wird angezeigt |

**Final Expected Result:** Login bleibt blockiert und eine neutrale Fehlermeldung wird angezeigt

---

### TC-018: Grenzfall: PIN aus genau 6 Stellen mit führenden Nullen

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-002
**Requirement:** WA-AUTH-002

**Description:** Überprüft, dass eine 6-stellige PIN mit führenden Nullen akzeptiert wird

**Preconditions:**
- Nutzer ist angemeldet
- 2FA ist deaktiviert

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigiere zu den 2FA-Einstellungen | 2FA-Optionen werden angezeigt |
| 2 | 2. Aktiviere 2FA und gib eine PIN mit führenden Nullen ein (z. B. 000123) | PIN-Eingabe wird akzeptiert |
| 3 | 3. Speichere die Einstellungen | 2FA wird aktiviert und Erfolgsmeldung erscheint |

**Final Expected Result:** 2FA ist aktiviert und die PIN mit führenden Nullen wird gespeichert

---

### TC-019: Validierung: Nicht-numerische Eingabe in PIN-Feld

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-002
**Requirement:** WA-AUTH-002

**Description:** Stellt sicher, dass nur numerische 6-stellige PINs akzeptiert werden

**Preconditions:**
- 2FA ist aktiviert
- Nutzer befindet sich im 2FA-PIN-Eingabeschritt beim Login

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Gib eine PIN mit nicht-numerischen Zeichen ein (z. B. 12AB56) | Eingabe wird als ungültig markiert |
| 2 | 2. Bestätige die Eingabe | Fehlermeldung wird angezeigt und Login wird nicht fortgesetzt |

**Final Expected Result:** Eingabe wird abgelehnt und eine verständliche Fehlermeldung angezeigt

---

### TC-020: Biometrische Entsperrung erfolgreich bei aktivierter Biometrie

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-003
**Requirement:** WA-AUTH-003

**Description:** Validiert, dass die App nach erfolgreicher biometrischer Prüfung ohne Passworteingabe entsperrt.

**Preconditions:**
- Nutzerkonto existiert und ist registriert
- Biometrische Authentifizierung ist in der App aktiviert
- Biometrie (Fingerabdruck oder Face ID) ist auf dem Gerät eingerichtet
- Nutzer ist abgemeldet oder App ist gesperrt

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. App starten | Biometrische Abfrage wird angezeigt |
| 2 | 2. Gültigen Fingerabdruck/Face ID bestätigen | Biometrische Prüfung wird akzeptiert |
| 3 | 3. Auf die Startseite warten | App wird ohne Passworteingabe entsperrt |

**Final Expected Result:** Nutzer erhält Zugriff auf die App ohne erneute Passworteingabe

---

### TC-021: Fallback zur Passworteingabe bei fehlgeschlagener Biometrie

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-003
**Requirement:** WA-AUTH-003

**Description:** Stellt sicher, dass bei fehlgeschlagener biometrischer Prüfung ein Passwort-Fallback angezeigt wird.

**Preconditions:**
- Nutzerkonto existiert und ist registriert
- Biometrische Authentifizierung ist in der App aktiviert
- Biometrie ist auf dem Gerät eingerichtet
- Nutzer ist abgemeldet oder App ist gesperrt

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. App starten | Biometrische Abfrage wird angezeigt |
| 2 | 2. Ungültigen Fingerabdruck/Face ID verwenden | Biometrische Prüfung schlägt fehl |
| 3 | 3. Fallback-Option auswählen oder abwarten | Passworteingabemaske wird angezeigt |

**Final Expected Result:** App zeigt die Passworteingabe als Fallback nach fehlgeschlagener Biometrie

---

### TC-022: Passworteingabe bei deaktivierter Biometrie auf dem Gerät

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-003
**Requirement:** WA-AUTH-003

**Description:** Verifiziert, dass bei deaktivierter Biometrie auf dem Gerät ausschließlich das Passwort verlangt wird.

**Preconditions:**
- Nutzerkonto existiert und ist registriert
- Biometrische Authentifizierung ist in der App aktiviert
- Biometrie ist auf dem Gerät deaktiviert
- Nutzer ist abgemeldet oder App ist gesperrt

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. App starten | Keine biometrische Abfrage wird angezeigt |
| 2 | 2. Auf die Login-Ansicht prüfen | Passworteingabemaske wird angezeigt |

**Final Expected Result:** Nutzer wird ausschließlich zur Passworteingabe aufgefordert

---

### TC-023: Passworteingabe bei Gerät ohne Biometrie-Unterstützung

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-003
**Requirement:** WA-AUTH-003

**Description:** Validiert, dass Geräte ohne Biometrie-Unterstützung nur die Passworteingabe zeigen.

**Preconditions:**
- Nutzerkonto existiert und ist registriert
- Biometrische Authentifizierung ist in der App aktiviert
- Gerät unterstützt keine Biometrie
- Nutzer ist abgemeldet oder App ist gesperrt

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. App auf einem Gerät ohne Biometrie starten | Keine biometrische Abfrage wird angezeigt |
| 2 | 2. Login-Ansicht prüfen | Passworteingabemaske wird angezeigt |

**Final Expected Result:** Nutzer wird ausschließlich zur Passworteingabe aufgefordert

---

### TC-024: Biometrie abgebrochen durch Nutzer zeigt Passwort-Fallback

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-003
**Requirement:** WA-AUTH-003

**Description:** Stellt sicher, dass bei Abbruch der biometrischen Abfrage ein Fallback zur Passworteingabe möglich ist.

**Preconditions:**
- Nutzerkonto existiert und ist registriert
- Biometrische Authentifizierung ist in der App aktiviert
- Biometrie ist auf dem Gerät eingerichtet
- Nutzer ist abgemeldet oder App ist gesperrt

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. App starten | Biometrische Abfrage wird angezeigt |
| 2 | 2. Biometrische Abfrage abbrechen | Abbruch wird erkannt |
| 3 | 3. Fallback-Option auswählen oder abwarten | Passworteingabemaske wird angezeigt |

**Final Expected Result:** Nutzer erhält die Möglichkeit zur Passworteingabe nach Abbruch

---

### TC-025: Mehrfach fehlgeschlagene Biometrie führt zum Passwort-Fallback

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-003
**Requirement:** WA-AUTH-003

**Description:** Validiert den Grenzfall mehrerer fehlgeschlagener biometrischer Versuche.

**Preconditions:**
- Nutzerkonto existiert und ist registriert
- Biometrische Authentifizierung ist in der App aktiviert
- Biometrie ist auf dem Gerät eingerichtet
- Nutzer ist abgemeldet oder App ist gesperrt

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. App starten | Biometrische Abfrage wird angezeigt |
| 2 | 2. Mehrfach ungültige Biometrie eingeben bis zur Sperre | Biometrische Prüfung schlägt wiederholt fehl |
| 3 | 3. Abwarten oder Fallback wählen | Passworteingabemaske wird angezeigt |

**Final Expected Result:** Nach wiederholtem Fehlschlag wird der Passwort-Fallback angezeigt

---

### TC-026: Biometrie in App deaktiviert zeigt ausschließlich Passwort

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-003
**Requirement:** WA-AUTH-003

**Description:** Stellt sicher, dass bei deaktivierter App-Biometrie keine biometrische Abfrage erscheint.

**Preconditions:**
- Nutzerkonto existiert und ist registriert
- Biometrische Authentifizierung ist in der App deaktiviert
- Biometrie ist auf dem Gerät eingerichtet
- Nutzer ist abgemeldet oder App ist gesperrt

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. App starten | Keine biometrische Abfrage wird angezeigt |
| 2 | 2. Login-Ansicht prüfen | Passworteingabemaske wird angezeigt |

**Final Expected Result:** Nutzer sieht nur die Passworteingabe, wenn App-Biometrie deaktiviert ist

---

### TC-027: TC01 - Nachrichtensenden auf Gerät A erscheint innerhalb 2 Sekunden auf Gerät B

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-004
**Requirement:** WA-AUTH-004

**Description:** Validiert, dass gesendete Nachrichten zwischen zwei angemeldeten Geräten innerhalb der Zeitvorgabe synchronisiert werden und als gesendet markiert sind.

**Preconditions:**
- Gerät A und Gerät B sind mit demselben Konto angemeldet
- Stabile Netzwerkverbindung auf beiden Geräten

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | Öffne den gleichen Chat auf Gerät A und Gerät B | Der Chatverlauf ist auf beiden Geräten sichtbar |
| 2 | Sende auf Gerät A eine Nachricht mit dem Text "Test Sync" | Die Nachricht erscheint auf Gerät A mit Status 'gesendet' |
| 3 | Starte einen Timer und beobachte Gerät B | Die Nachricht erscheint innerhalb von 2 Sekunden auf Gerät B und ist als 'gesendet' markiert |

**Final Expected Result:** Die Nachricht wird auf Gerät B innerhalb von 2 Sekunden angezeigt und ist als gesendet markiert.

---

### TC-028: TC02 - Grenzfall Zeitlimit: Nachricht erscheint genau bei 2 Sekunden

**Type:** performance
**Priority:** high
**Status:** manual
**User Story:** US-004
**Requirement:** WA-AUTH-004

**Description:** Validiert die Synchronisation an der Zeitgrenze von 2 Sekunden.

**Preconditions:**
- Gerät A und Gerät B sind mit demselben Konto angemeldet
- Überwachungs-/Timing-Tool verfügbar

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | Sende auf Gerät A eine Nachricht und starte eine Zeitmessung | Die Nachricht erscheint auf Gerät A als gesendet |
| 2 | Erfasse den Zeitpunkt der Anzeige auf Gerät B | Die Anzeigezeit liegt bei <= 2 Sekunden |

**Final Expected Result:** Die Nachricht erscheint spätestens nach 2 Sekunden auf Gerät B.

---

### TC-029: TC03 - Negative: Nachricht erscheint nicht innerhalb 2 Sekunden

**Type:** performance
**Priority:** medium
**Status:** manual
**User Story:** US-004
**Requirement:** WA-AUTH-004

**Description:** Validiert das Verhalten bei Nichteinhaltung der 2-Sekunden-SLA (z. B. durch simulierte Latenz).

**Preconditions:**
- Gerät A und Gerät B sind mit demselben Konto angemeldet
- Netzwerk-Latenz kann simuliert werden

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | Aktiviere eine künstliche Netzwerk-Latenz auf Gerät B | Latenz ist aktiv |
| 2 | Sende auf Gerät A eine Nachricht | Die Nachricht erscheint auf Gerät A als gesendet |
| 3 | Miss die Zeit bis zur Anzeige auf Gerät B | Die Nachricht erscheint nach mehr als 2 Sekunden |

**Final Expected Result:** Die Nachricht überschreitet das 2-Sekunden-Limit; Abweichung wird dokumentiert.

---

### TC-030: TC04 - Benachrichtigung bei eingehender Nachricht auf beiden Geräten

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-004
**Requirement:** WA-AUTH-004

**Description:** Validiert, dass bei Eingang einer neuen Nachricht auf Gerät A eine Benachrichtigung auf beiden Geräten erscheint.

**Preconditions:**
- Gerät A und Gerät B sind mit demselben Konto angemeldet
- Push-Benachrichtigungen sind aktiviert

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | Sende von einem dritten Konto eine Nachricht an das Konto | Die Nachricht wird an das Konto zugestellt |
| 2 | Beobachte Gerät A und Gerät B | Auf beiden Geräten erscheint eine Benachrichtigung |

**Final Expected Result:** Die Benachrichtigung erscheint auf beiden Geräten bei Eingang einer neuen Nachricht.

---

### TC-031: TC05 - Lesestatus-Synchronisierung nach Öffnen auf einem Gerät

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-004
**Requirement:** WA-AUTH-004

**Description:** Validiert, dass der Lesestatus nach Öffnen einer Nachricht auf einem Gerät auf beiden Geräten synchronisiert wird.

**Preconditions:**
- Gerät A und Gerät B sind mit demselben Konto angemeldet
- Eine neue ungelesene Nachricht ist vorhanden

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | Öffne die ungelesene Nachricht auf Gerät A | Die Nachricht wird auf Gerät A als gelesen markiert |
| 2 | Wechsle zu Gerät B und aktualisiere den Chat | Die Nachricht wird auf Gerät B als gelesen markiert |

**Final Expected Result:** Der Lesestatus ist nach dem Öffnen auf einem Gerät auf beiden Geräten synchronisiert.

---

### TC-032: TC06 - Benachrichtigung verschwindet nach Lesen auf einem Gerät

**Type:** integration
**Priority:** medium
**Status:** manual
**User Story:** US-004
**Requirement:** WA-AUTH-004

**Description:** Validiert, dass Benachrichtigungen auf beiden Geräten entsprechend dem Lesestatus aktualisiert werden.

**Preconditions:**
- Gerät A und Gerät B sind mit demselben Konto angemeldet
- Eine neue ungelesene Nachricht ist vorhanden

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | Öffne die Nachricht auf Gerät B | Die Nachricht ist auf Gerät B als gelesen markiert |
| 2 | Prüfe die Benachrichtigungen auf Gerät A | Die Benachrichtigung wird entfernt oder als gelesen markiert |

**Final Expected Result:** Benachrichtigungen werden auf beiden Geräten entsprechend dem Lesestatus synchronisiert.

---

### TC-033: TC07 - Geräte-Limit erreicht: Anmeldung auf drittem Gerät blockiert

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-004
**Requirement:** WA-AUTH-004

**Description:** Validiert, dass eine Anmeldung auf einem dritten Gerät verhindert wird und eine verständliche Fehlermeldung erscheint.

**Preconditions:**
- Gerät A und Gerät B sind mit demselben Konto angemeldet
- Das zulässige Geräte-Limit beträgt 2

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | Starte die Anmeldung auf Gerät C mit demselben Konto | Anmeldevorgang wird gestartet |
| 2 | Schließe die Anmeldung auf Gerät C ab | Eine verständliche Fehlermeldung wird angezeigt |
| 3 | Prüfe die aktiven Sitzungen im Konto | Keine neue Sitzung für Gerät C ist erstellt |

**Final Expected Result:** Gerät C kann nicht angemeldet werden; Fehlermeldung wird angezeigt und keine neue Sitzung entsteht.

---

### TC-034: TC08 - Anmeldung auf drittem Gerät nach Abmeldung eines Geräts

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-004
**Requirement:** WA-AUTH-004

**Description:** Validiert, dass nach Freigabe eines Geräte-Slots eine Anmeldung auf einem dritten Gerät möglich ist.

**Preconditions:**
- Gerät A und Gerät B sind mit demselben Konto angemeldet
- Das Geräte-Limit beträgt 2

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | Melde Gerät B ab | Die Sitzung auf Gerät B wird beendet |
| 2 | Melde Gerät C mit demselben Konto an | Die Anmeldung auf Gerät C ist erfolgreich |

**Final Expected Result:** Nach Abmeldung eines Geräts kann sich ein drittes Gerät erfolgreich anmelden.

---

### TC-035: TC09 - Negative: Ungültige Anmeldedaten auf drittem Gerät bei Geräte-Limit

**Type:** functional
**Priority:** low
**Status:** manual
**User Story:** US-004
**Requirement:** WA-AUTH-004

**Description:** Validiert, dass eine Fehlermeldung für ungültige Anmeldedaten Vorrang hat und keine Sitzung erstellt wird.

**Preconditions:**
- Gerät A und Gerät B sind mit demselben Konto angemeldet
- Das Geräte-Limit beträgt 2

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | Versuche die Anmeldung auf Gerät C mit falschem Passwort | Anmeldung schlägt fehl |
| 2 | Prüfe, ob eine Sitzung erstellt wurde | Keine Sitzung für Gerät C ist erstellt |

**Final Expected Result:** Die Anmeldung schlägt aufgrund falscher Anmeldedaten fehl; keine neue Sitzung wird erstellt.

---

### TC-036: TC10 - Gleichzeitiges Senden von Nachrichten auf beiden Geräten

**Type:** integration
**Priority:** medium
**Status:** manual
**User Story:** US-004
**Requirement:** WA-AUTH-004

**Description:** Validiert die Synchronisation bei parallelem Senden auf Gerät A und B.

**Preconditions:**
- Gerät A und Gerät B sind mit demselben Konto angemeldet
- Stabile Netzwerkverbindung auf beiden Geräten

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | Sende gleichzeitig eine Nachricht von Gerät A und Gerät B in denselben Chat | Beide Nachrichten erscheinen jeweils lokal als gesendet |
| 2 | Überprüfe den Chatverlauf auf beiden Geräten | Beide Nachrichten sind auf beiden Geräten sichtbar |

**Final Expected Result:** Parallele Nachrichten werden korrekt auf beiden Geräten synchronisiert.

---

### TC-037: TC11 - Offline/Online Wechsel auf Gerät B während Nachrichtensendung

**Type:** integration
**Priority:** medium
**Status:** manual
**User Story:** US-004
**Requirement:** WA-AUTH-004

**Description:** Validiert das Verhalten, wenn Gerät B kurzzeitig offline ist und danach die Synchronisation nachholt.

**Preconditions:**
- Gerät A und Gerät B sind mit demselben Konto angemeldet

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | Schalte Gerät B in den Offline-Modus | Gerät B ist offline |
| 2 | Sende auf Gerät A eine Nachricht | Die Nachricht erscheint auf Gerät A als gesendet |
| 3 | Schalte Gerät B wieder online | Gerät B verbindet sich erneut |
| 4 | Überprüfe den Chatverlauf auf Gerät B | Die Nachricht von Gerät A wird nachträglich synchronisiert |

**Final Expected Result:** Nach Wiederherstellung der Verbindung wird die Nachricht auf Gerät B synchronisiert.

---

### TC-038: TC12 - Verständlichkeit der Fehlermeldung bei Geräte-Limit

**Type:** functional
**Priority:** low
**Status:** manual
**User Story:** US-004
**Requirement:** WA-AUTH-004

**Description:** Validiert, dass die Fehlermeldung bei Geräte-Limit verständlich und benutzerfreundlich ist.

**Preconditions:**
- Gerät A und Gerät B sind mit demselben Konto angemeldet
- Das Geräte-Limit beträgt 2

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | Versuche die Anmeldung auf Gerät C | Anmeldevorgang wird gestartet |
| 2 | Schließe den Anmeldevorgang ab | Eine verständliche Fehlermeldung wird angezeigt |
| 3 | Bewerte den Text der Fehlermeldung | Die Fehlermeldung erklärt, dass das Geräte-Limit erreicht ist und keine neue Sitzung erstellt wird |

**Final Expected Result:** Die Fehlermeldung ist klar, verständlich und erklärt die Ursache der Ablehnung.

---

### TC-039: Successful passkey login with biometric authentication

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-005
**Requirement:** WA-AUTH-005

**Description:** Verify that a registered user with a stored passkey can log in successfully using biometric/device authentication.

**Preconditions:**
- Registered end user exists
- Passkey is stored on the device for the user
- User is on the login screen
- Biometric/device authentication is available and enrolled

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Select the passkey login option on the login screen | Passkey authentication prompt is displayed |
| 2 | 2. Complete biometric/device authentication successfully | Authentication succeeds and the login process continues |
| 3 | 3. Observe the post-login state | User is redirected to the authenticated area |

**Final Expected Result:** User is successfully logged in and a session is created.

---

### TC-040: Passkey login selection without stored passkey

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-005
**Requirement:** WA-AUTH-005

**Description:** Verify that a registered user without a stored passkey sees a clear message and an alternative login option.

**Preconditions:**
- Registered end user exists
- No passkey is stored on the device for the user
- User is on the login screen

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Select the passkey login option on the login screen | System checks for stored passkey |
| 2 | 2. Observe the UI response | A clear hint message is shown indicating no passkey is available |
| 3 | 3. Check available login options | An alternative login option (e.g., password, OTP) is presented |

**Final Expected Result:** User is informed that no passkey is available and is offered an alternative login method.

---

### TC-041: Passkey login fails due to failed device authentication

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-005
**Requirement:** WA-AUTH-005

**Description:** Verify that if device authentication fails, login is aborted, an error is shown, and no session is created.

**Preconditions:**
- Registered end user exists
- Passkey is stored on the device for the user
- User is on the login screen
- Biometric/device authentication is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Select the passkey login option on the login screen | Passkey authentication prompt is displayed |
| 2 | 2. Fail biometric/device authentication (e.g., use incorrect biometrics or cancel) | Authentication fails or is canceled |
| 3 | 3. Observe the login state | Login is not completed and user remains on the login screen |

**Final Expected Result:** Login is aborted, a clear error message is displayed, and no session is created.

---

### TC-042: Cancel passkey authentication prompt

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-005
**Requirement:** WA-AUTH-005

**Description:** Verify that canceling the passkey prompt does not create a session and keeps user on login screen.

**Preconditions:**
- Registered end user exists
- Passkey is stored on the device for the user
- User is on the login screen

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Select the passkey login option on the login screen | Passkey authentication prompt is displayed |
| 2 | 2. Cancel the authentication prompt | Authentication flow is canceled |
| 3 | 3. Observe the login state | User remains on the login screen with no active session |

**Final Expected Result:** No session is created and user stays on the login screen.

---

### TC-043: Alternative login option functional after no passkey message

**Type:** e2e
**Priority:** medium
**Status:** manual
**User Story:** US-005
**Requirement:** WA-AUTH-005

**Description:** Verify that the alternative login option works when no passkey is available.

**Preconditions:**
- Registered end user exists
- No passkey is stored on the device for the user
- User is on the login screen
- Alternative login method is enabled

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Select the passkey login option on the login screen | A clear hint message indicates no passkey is available |
| 2 | 2. Choose the alternative login option | Alternative login flow is initiated |
| 3 | 3. Complete the alternative login successfully | User is authenticated and redirected to the authenticated area |

**Final Expected Result:** User logs in successfully using the alternative method when no passkey is available.

---

### TC-044: Passkey login with multiple stored passkeys - select correct account

**Type:** integration
**Priority:** medium
**Status:** manual
**User Story:** US-005
**Requirement:** WA-AUTH-005

**Description:** Verify that the user can select the correct passkey when multiple passkeys are present and login succeeds.

**Preconditions:**
- Two registered end users exist with passkeys on the same device
- User is on the login screen

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Select the passkey login option on the login screen | Passkey selection prompt lists available passkeys |
| 2 | 2. Select the intended user's passkey | Selected passkey is used for authentication |
| 3 | 3. Complete biometric/device authentication successfully | User is authenticated and redirected to the authenticated area |

**Final Expected Result:** User logs in with the selected passkey and the correct session is created.

---

### TC-045: Passkey login session creation validation

**Type:** integration
**Priority:** high
**Status:** manual
**User Story:** US-005
**Requirement:** WA-AUTH-005

**Description:** Verify that a session token is created only on successful passkey authentication.

**Preconditions:**
- Registered end user exists
- Passkey is stored on the device for the user
- User is on the login screen

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Select the passkey login option on the login screen | Passkey authentication prompt is displayed |
| 2 | 2. Complete biometric/device authentication successfully | Authentication succeeds and login completes |
| 3 | 3. Verify session/token presence in client storage or via session endpoint | Valid session/token exists and is active |

**Final Expected Result:** Session is created only after successful passkey authentication.

---

### TC-046: Passkey login attempt with expired or invalid passkey

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-005
**Requirement:** WA-AUTH-005

**Description:** Verify that an invalid passkey fails authentication and no session is created.

**Preconditions:**
- Registered end user exists
- An invalid/expired passkey is stored on the device for the user
- User is on the login screen

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Select the passkey login option on the login screen | Passkey authentication prompt is displayed |
| 2 | 2. Attempt authentication with the invalid/expired passkey | Authentication fails |
| 3 | 3. Observe the login state | User remains on login screen with an error message |

**Final Expected Result:** Authentication fails with an error and no session is created.

---

### TC-047: Performance: Passkey authentication response time

**Type:** performance
**Priority:** medium
**Status:** manual
**User Story:** US-005
**Requirement:** WA-AUTH-005

**Description:** Measure that passkey login completes within acceptable time under normal conditions.

**Preconditions:**
- Registered end user exists
- Passkey is stored on the device for the user
- User is on the login screen
- Performance monitoring is enabled

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Start timing and select the passkey login option | Passkey prompt appears and timing starts |
| 2 | 2. Complete biometric/device authentication successfully | Authentication succeeds |
| 3 | 3. Stop timing when authenticated area loads | Total login time is recorded |

**Final Expected Result:** Passkey login completes within the defined performance threshold.

---

### TC-048: Upload valid profile image within size limit

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-006
**Requirement:** WA-PROF-001

**Description:** Verify a valid image format within size limits is saved and displayed immediately

**Preconditions:**
- User is logged in
- User is on profile settings page
- Valid image file (e.g., JPG) within allowed size limit is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Click on the profile image upload control | File chooser dialog opens |
| 2 | 2. Select a valid JPG image within size limits and confirm upload | Upload starts and completes without error |
| 3 | 3. Observe the profile image area | The new image is displayed immediately |
| 4 | 4. Refresh the profile page | The uploaded image remains displayed after refresh |

**Final Expected Result:** Profile image is saved and displayed immediately and persists after refresh

---

### TC-049: Replace existing profile image with a new valid image

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-006
**Requirement:** WA-PROF-001

**Description:** Verify that uploading a new image replaces the existing profile image

**Preconditions:**
- User is logged in
- User is on profile settings page
- User has an existing profile image
- Valid image file (e.g., PNG) within allowed size limit is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Click on the profile image upload control | File chooser dialog opens |
| 2 | 2. Select a new valid PNG image within size limits and confirm upload | Upload starts and completes without error |
| 3 | 3. Observe the profile image area | The new image replaces the previous image |
| 4 | 4. Refresh the profile page | The new image persists and the old image is no longer shown |

**Final Expected Result:** Existing profile image is replaced by the new image and persists after refresh

---

### TC-050: Reject invalid image format

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-006
**Requirement:** WA-PROF-001

**Description:** Verify that uploading an unsupported file format is rejected with a clear error message

**Preconditions:**
- User is logged in
- User is on profile settings page
- User has an existing profile image
- Invalid file format (e.g., .pdf or .txt) is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Click on the profile image upload control | File chooser dialog opens |
| 2 | 2. Select an invalid file format and confirm upload | Upload is blocked or fails with a clear error message about invalid format |
| 3 | 3. Observe the profile image area | The existing profile image remains unchanged |

**Final Expected Result:** Invalid format is rejected with a clear error message and no change to the profile image

---

### TC-051: Reject image exceeding size limit

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-006
**Requirement:** WA-PROF-001

**Description:** Verify that uploading an image larger than the allowed size is rejected with a clear error message

**Preconditions:**
- User is logged in
- User is on profile settings page
- User has an existing profile image
- Oversized image file exceeding allowed size limit is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Click on the profile image upload control | File chooser dialog opens |
| 2 | 2. Select an oversized image file and confirm upload | Upload is blocked or fails with a clear error message about file size |
| 3 | 3. Observe the profile image area | The existing profile image remains unchanged |

**Final Expected Result:** Oversized image is rejected with a clear error message and no change to the profile image

---

### TC-052: Upload image at exact size limit boundary

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-006
**Requirement:** WA-PROF-001

**Description:** Verify that an image exactly at the maximum allowed size is accepted

**Preconditions:**
- User is logged in
- User is on profile settings page
- Image file exactly at maximum allowed size in a valid format is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Click on the profile image upload control | File chooser dialog opens |
| 2 | 2. Select an image exactly at the size limit and confirm upload | Upload completes successfully without error |
| 3 | 3. Observe the profile image area | The new image is displayed immediately |

**Final Expected Result:** Image at the size limit is accepted and displayed

---

### TC-053: Upload supported alternate valid format

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-006
**Requirement:** WA-PROF-001

**Description:** Verify that another supported valid image format (e.g., GIF) is accepted and displayed

**Preconditions:**
- User is logged in
- User is on profile settings page
- Valid GIF image within allowed size limit is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Click on the profile image upload control | File chooser dialog opens |
| 2 | 2. Select a valid GIF image and confirm upload | Upload completes successfully without error |
| 3 | 3. Observe the profile image area | The new GIF image is displayed immediately |

**Final Expected Result:** Supported valid format is accepted and displayed

---

### TC-054: Cancel upload in file chooser

**Type:** functional
**Priority:** low
**Status:** manual
**User Story:** US-006
**Requirement:** WA-PROF-001

**Description:** Verify that canceling the file selection does not change the profile image

**Preconditions:**
- User is logged in
- User is on profile settings page
- User has an existing profile image

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Click on the profile image upload control | File chooser dialog opens |
| 2 | 2. Cancel or close the file chooser without selecting a file | No upload is initiated |
| 3 | 3. Observe the profile image area | The existing profile image remains unchanged |

**Final Expected Result:** No changes are made when file selection is canceled

---

### TC-055: Error message clarity for invalid format

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-006
**Requirement:** WA-PROF-001

**Description:** Verify error message content is clear and actionable for invalid format upload

**Preconditions:**
- User is logged in
- User is on profile settings page
- Invalid file format (e.g., .exe) is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Click on the profile image upload control | File chooser dialog opens |
| 2 | 2. Select an invalid file format and confirm upload | An error message is displayed |
| 3 | 3. Review the error message text | Message clearly states invalid format and lists supported formats |

**Final Expected Result:** User receives a clear and actionable error message for invalid format

---

### TC-056: Error message clarity for oversized file

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-006
**Requirement:** WA-PROF-001

**Description:** Verify error message content is clear and includes size limit details for oversized upload

**Preconditions:**
- User is logged in
- User is on profile settings page
- Oversized image file exceeding allowed size limit is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Click on the profile image upload control | File chooser dialog opens |
| 2 | 2. Select an oversized image file and confirm upload | An error message is displayed |
| 3 | 3. Review the error message text | Message clearly states the file is too large and indicates the maximum allowed size |

**Final Expected Result:** User receives a clear and actionable error message for oversized file

---

### TC-057: Immediate display after upload without page refresh

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-006
**Requirement:** WA-PROF-001

**Description:** Verify that the profile image updates immediately after successful upload without refresh

**Preconditions:**
- User is logged in
- User is on profile settings page
- Valid image file within allowed size limit is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Initiate upload of a valid image file | Upload completes successfully |
| 2 | 2. Observe the profile image area without refreshing | The new image appears immediately |

**Final Expected Result:** Profile image updates immediately upon successful upload

---

### TC-058: Save valid display name

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-007
**Requirement:** WA-PROF-002

**Description:** Verify a valid display name is saved and shown in the profile UI

**Preconditions:**
- Business user is logged in
- User is in profile settings area

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Enter a valid display name within allowed length (e.g., 'Alex Müller') | Display name input shows the entered value |
| 2 | 2. Click the save/update button | Save action is accepted without validation errors |
| 3 | 3. Refresh the profile page or reopen profile settings | Saved display name is persisted and displayed in the UI |

**Final Expected Result:** Valid display name is stored and visible across sessions/pages

---

### TC-059: Reject empty display name

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-007
**Requirement:** WA-PROF-002

**Description:** Verify empty display name cannot be saved

**Preconditions:**
- Business user is logged in
- User is in profile settings area

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Clear the display name field so it is empty | Display name field is empty |
| 2 | 2. Click the save/update button | Validation error is displayed for required display name |

**Final Expected Result:** Display name is not saved and validation error is shown

---

### TC-060: Reject whitespace-only display name

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-007
**Requirement:** WA-PROF-002

**Description:** Verify display name with only spaces cannot be saved

**Preconditions:**
- Business user is logged in
- User is in profile settings area

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Enter a display name consisting only of spaces (e.g., '   ') | Display name field contains only whitespace |
| 2 | 2. Click the save/update button | Validation error is displayed indicating invalid display name |

**Final Expected Result:** Display name is not saved and validation error is shown

---

### TC-061: Reject display name exceeding max length

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-007
**Requirement:** WA-PROF-002

**Description:** Verify display name longer than maximum length cannot be saved

**Preconditions:**
- Business user is logged in
- User is in profile settings area
- Maximum length is known (e.g., 50 chars)

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Enter a display name exceeding the maximum length by 1 character | Field accepts input or shows length indicator exceeding limit |
| 2 | 2. Click the save/update button | Error message is displayed for exceeding maximum length |

**Final Expected Result:** Display name is not saved and max length validation error is shown

---

### TC-062: Accept display name at max length boundary

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-007
**Requirement:** WA-PROF-002

**Description:** Verify display name exactly at maximum length is accepted

**Preconditions:**
- Business user is logged in
- User is in profile settings area
- Maximum length is known (e.g., 50 chars)

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Enter a display name with exactly the maximum allowed characters | Display name field shows the full input |
| 2 | 2. Click the save/update button | No validation error is shown |
| 3 | 3. Refresh or reopen profile settings | Display name remains saved and displayed |

**Final Expected Result:** Display name at max length is successfully saved and displayed

---

### TC-063: Trim leading/trailing spaces on valid display name

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-007
**Requirement:** WA-PROF-002

**Description:** Verify leading/trailing spaces are handled and saved display name is clean

**Preconditions:**
- Business user is logged in
- User is in profile settings area

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Enter a display name with leading and trailing spaces (e.g., '  Alex Müller  ') | Input field displays the entered value |
| 2 | 2. Click the save/update button | Save action succeeds without validation errors |
| 3 | 3. Refresh or reopen profile settings | Displayed name is saved without unintended extra spaces |

**Final Expected Result:** Display name is saved and shown without leading/trailing spaces

---

### TC-064: Save new info/status text and persist after reload

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-008
**Requirement:** WA-PROF-003

**Description:** Verify a valid info/status text can be saved and remains visible after page reload

**Preconditions:**
- User is logged in
- User is in profile area

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Enter a valid short info/status text in the input field | Text appears in the input field |
| 2 | 2. Click the Save button | Success confirmation is shown and the text appears in the profile display |
| 3 | 3. Reload the profile page | The saved info/status text is still visible in the profile display |

**Final Expected Result:** Info/status text is saved, displayed, and persists after reload

---

### TC-065: Update existing info/status text

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-008
**Requirement:** WA-PROF-003

**Description:** Verify that updating the info/status text replaces the previous text

**Preconditions:**
- User is logged in
- User is in profile area
- An existing info/status text is already saved

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Replace the existing info/status text with a new valid text | New text appears in the input field |
| 2 | 2. Click the Save button | Success confirmation is shown and the profile display shows the new text |

**Final Expected Result:** The previous info/status text is replaced by the new version

---

### TC-066: Prevent saving an empty info/status text

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-008
**Requirement:** WA-PROF-003

**Description:** Verify that an empty info/status text cannot be saved and an error is shown

**Preconditions:**
- User is logged in
- User is in profile area

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Clear the info/status text input so it is empty | Input field is empty |
| 2 | 2. Click the Save button | A clear error message is displayed and no save occurs |

**Final Expected Result:** System shows error and does not save empty text

---

### TC-067: Prevent saving whitespace-only info/status text

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-008
**Requirement:** WA-PROF-003

**Description:** Verify that whitespace-only input is treated as empty and rejected

**Preconditions:**
- User is logged in
- User is in profile area

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Enter only spaces in the info/status text input | Whitespace appears in the input field |
| 2 | 2. Click the Save button | A clear error message is displayed and no save occurs |

**Final Expected Result:** Whitespace-only text is rejected and not saved

---

### TC-068: Save minimum length info/status text

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-008
**Requirement:** WA-PROF-003

**Description:** Verify that a minimal valid text (e.g., 1 character) can be saved

**Preconditions:**
- User is logged in
- User is in profile area

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Enter a 1-character info/status text | Text appears in the input field |
| 2 | 2. Click the Save button | Success confirmation is shown and the text appears in the profile display |

**Final Expected Result:** Minimum length text is saved and displayed

---

### TC-069: Save maximum length info/status text

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-008
**Requirement:** WA-PROF-003

**Description:** Verify that the maximum allowed length can be saved and displayed correctly

**Preconditions:**
- User is logged in
- User is in profile area
- Maximum length requirement is defined

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Enter an info/status text with exactly the maximum allowed characters | Text appears in the input field without truncation |
| 2 | 2. Click the Save button | Success confirmation is shown and the full text appears in the profile display |

**Final Expected Result:** Maximum length text is saved and displayed correctly

---

### TC-070: Reject info/status text exceeding maximum length

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-008
**Requirement:** WA-PROF-003

**Description:** Verify that input longer than maximum length is not saved and user is informed

**Preconditions:**
- User is logged in
- User is in profile area
- Maximum length requirement is defined

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Enter an info/status text exceeding the maximum allowed characters | Input is accepted or truncated per UI behavior |
| 2 | 2. Click the Save button | A clear validation error is shown or text is prevented from exceeding the limit |

**Final Expected Result:** Text longer than maximum length is not saved

---

### TC-071: Persistence check after update and reload

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-008
**Requirement:** WA-PROF-003

**Description:** Verify that the updated text persists after a page reload

**Preconditions:**
- User is logged in
- User is in profile area
- An existing info/status text is already saved

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Update the info/status text to a new valid value | New text appears in the input field |
| 2 | 2. Click the Save button | Success confirmation is shown and the profile display shows the new text |
| 3 | 3. Reload the profile page | The updated text remains visible in the profile display |

**Final Expected Result:** Updated text persists after reload

---

### TC-072: Error message clarity on empty save attempt

**Type:** functional
**Priority:** low
**Status:** manual
**User Story:** US-008
**Requirement:** WA-PROF-003

**Description:** Verify the error message is understandable and does not save empty text

**Preconditions:**
- User is logged in
- User is in profile area

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Clear the info/status text input | Input field is empty |
| 2 | 2. Click the Save button | A clear, user-friendly error message is displayed |

**Final Expected Result:** User receives a clear error and empty text is not saved

---

### TC-073: Display phone number when present in profile

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-009
**Requirement:** WA-PROF-004

**Description:** Verify that a stored phone number is shown on the profile page

**Preconditions:**
- User is logged in
- User profile contains a valid phone number

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to the user profile page | Profile page loads with user details |
| 2 | 2. Locate the phone number section | Phone number field/label is visible |

**Final Expected Result:** The user's phone number is displayed correctly in the profile

---

### TC-074: No phone number present - field hidden

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-009
**Requirement:** WA-PROF-004

**Description:** Verify that no phone number field is shown when the user has no phone number stored

**Preconditions:**
- User is logged in
- User profile has no phone number stored

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to the user profile page | Profile page loads with user details |
| 2 | 2. Check for the phone number section | Phone number field is not displayed OR a 'no phone number' hint is shown |

**Final Expected Result:** Profile displays either no phone number field or a clear hint that no phone number is available

---

### TC-075: Technical error while loading phone number

**Type:** integration
**Priority:** high
**Status:** manual
**User Story:** US-009
**Requirement:** WA-PROF-004

**Description:** Verify friendly error is shown and other profile data remains visible when phone number fails to load

**Preconditions:**
- User is logged in
- User profile contains a phone number
- Phone number service or API is unavailable or returns error

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to the user profile page | Profile page loads with user details |
| 2 | 2. Trigger phone number data load | Phone number retrieval fails |
| 3 | 3. Observe the phone number area | A user-friendly error message is displayed in the phone number area |

**Final Expected Result:** User-friendly error is shown for phone number, while all other profile data remains visible

---

### TC-076: Boundary: Phone number with minimum valid length

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-009
**Requirement:** WA-PROF-004

**Description:** Verify display for a phone number at minimum valid length

**Preconditions:**
- User is logged in
- User profile contains a phone number at minimum valid length per system rules

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to the user profile page | Profile page loads with user details |
| 2 | 2. Locate the phone number section | Phone number field/label is visible |

**Final Expected Result:** Minimum length phone number is displayed correctly without truncation or formatting issues

---

### TC-077: Boundary: Phone number with maximum valid length

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-009
**Requirement:** WA-PROF-004

**Description:** Verify display for a phone number at maximum valid length

**Preconditions:**
- User is logged in
- User profile contains a phone number at maximum valid length per system rules

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to the user profile page | Profile page loads with user details |
| 2 | 2. Locate the phone number section | Phone number field/label is visible |

**Final Expected Result:** Maximum length phone number is displayed fully without truncation or layout break

---

### TC-078: Phone number data formatted display

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-009
**Requirement:** WA-PROF-004

**Description:** Verify that phone number is displayed exactly as stored or per formatting rules

**Preconditions:**
- User is logged in
- User profile contains a phone number with formatting (e.g., +49 170 1234567)

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to the user profile page | Profile page loads with user details |
| 2 | 2. Observe the phone number display | Phone number appears formatted according to system rules |

**Final Expected Result:** Phone number is displayed in the expected format without loss of characters

---

### TC-079: Profile page performance with phone number present

**Type:** performance
**Priority:** low
**Status:** manual
**User Story:** US-009
**Requirement:** WA-PROF-004

**Description:** Ensure profile loads within acceptable time when phone number is present

**Preconditions:**
- User is logged in
- User profile contains a phone number
- Performance threshold is defined (e.g., 2 seconds)

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to the user profile page and measure load time | Profile page loads within defined performance threshold |

**Final Expected Result:** Profile page loads within acceptable performance limits while showing the phone number

---

### TC-080: No phone number present - hint message displayed

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-009
**Requirement:** WA-PROF-004

**Description:** Verify that a hint message appears when no phone number exists and the design specifies a message instead of hiding the field

**Preconditions:**
- User is logged in
- User profile has no phone number stored
- UI specification requires a hint message

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to the user profile page | Profile page loads with user details |
| 2 | 2. Locate the phone number area | A hint message indicating no phone number is available is visible |

**Final Expected Result:** A clear, user-friendly hint message is displayed when no phone number is stored

---

### TC-081: Generate QR code for verified business profile

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-010
**Requirement:** WA-PROF-005

**Description:** Verify that a scanable QR code is generated and displayed for a verified business profile when user is logged in

**Preconditions:**
- User is logged in
- Business profile exists
- Business profile is verified and active

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to the business profile settings page | Profile settings page is displayed with QR code generation option |
| 2 | 2. Click on the “QR-Code generieren” action | System starts QR code generation |
| 3 | 3. Wait for the generation to complete | A QR code is displayed on the screen and is visibly scanable |

**Final Expected Result:** A scanable QR code is generated and shown for the verified, active profile

---

### TC-082: Scan generated QR code opens correct profile

**Type:** integration
**Priority:** high
**Status:** manual
**User Story:** US-010
**Requirement:** WA-PROF-005

**Description:** Verify that scanning the generated QR code opens the correct profile and allows adding the user

**Preconditions:**
- User is logged in
- Business profile exists and is verified/active
- QR code has been generated and is visible

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Use a mobile device to scan the displayed QR code | Mobile device recognizes the QR code and offers to open a link |
| 2 | 2. Open the link from the scan result | The correct business profile page opens |
| 3 | 3. Attempt to add/follow the business profile | User can add/follow the profile successfully |

**Final Expected Result:** Scanning the QR code opens the correct profile and allows adding the user

---

### TC-083: Prevent QR generation when no profile exists

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-010
**Requirement:** WA-PROF-005

**Description:** Verify system blocks QR generation and shows error if no business profile exists

**Preconditions:**
- User is logged in
- No business profile exists for the user

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to the QR code generation feature | QR code generation option is visible |
| 2 | 2. Click on “QR-Code generieren” | System validates profile existence |

**Final Expected Result:** A clear error message is shown and no QR code is created

---

### TC-084: Prevent QR generation when profile is deactivated

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-010
**Requirement:** WA-PROF-005

**Description:** Verify system blocks QR generation and shows error if profile is deactivated

**Preconditions:**
- User is logged in
- Business profile exists
- Business profile is deactivated

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to the QR code generation feature | QR code generation option is visible |
| 2 | 2. Click on “QR-Code generieren” | System validates profile status |

**Final Expected Result:** A clear error message is shown and no QR code is created

---

### TC-085: Unauthorized user cannot generate QR code

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-010
**Requirement:** WA-PROF-005

**Description:** Verify user must be authenticated to generate a QR code

**Preconditions:**
- User is not logged in
- Business profile exists and is verified/active

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Attempt to access the QR code generation URL directly | System detects unauthenticated access |
| 2 | 2. Attempt to initiate QR generation | System blocks the action |

**Final Expected Result:** User is prompted to log in or receives an authorization error and no QR code is created

---

### TC-086: QR code content matches current profile ID

**Type:** integration
**Priority:** medium
**Status:** manual
**User Story:** US-010
**Requirement:** WA-PROF-005

**Description:** Ensure the QR code encodes the correct and current profile identifier

**Preconditions:**
- User is logged in
- Business profile exists and is verified/active

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Generate a QR code for the profile | QR code is displayed |
| 2 | 2. Decode the QR code using a QR decoding tool | Decoded URL/identifier is obtained |
| 3 | 3. Compare decoded value to the current profile URL/ID | Decoded value matches the current profile URL/ID exactly |

**Final Expected Result:** QR code encodes the correct profile identifier

---

### TC-087: QR code regeneration after profile changes

**Type:** integration
**Priority:** medium
**Status:** manual
**User Story:** US-010
**Requirement:** WA-PROF-005

**Description:** Verify QR code updates if profile link or identifier changes

**Preconditions:**
- User is logged in
- Business profile exists and is verified/active
- Profile URL/identifier can change (e.g., username update)

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Generate a QR code for the current profile | QR code is displayed |
| 2 | 2. Change the profile URL/identifier (e.g., update username) | Profile change is saved successfully |
| 3 | 3. Generate a new QR code | New QR code is displayed |
| 4 | 4. Decode both old and new QR codes | New QR code encodes updated profile URL/ID, old QR code encodes previous value |

**Final Expected Result:** Regenerated QR code reflects the latest profile identifier

---

### TC-088: QR code generation performance

**Type:** performance
**Priority:** low
**Status:** manual
**User Story:** US-010
**Requirement:** WA-PROF-005

**Description:** Ensure QR code is generated within acceptable time limits

**Preconditions:**
- User is logged in
- Business profile exists and is verified/active

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Start timing and click “QR-Code generieren” | Generation starts without errors |
| 2 | 2. Stop timing when QR code is displayed | QR code is displayed |

**Final Expected Result:** QR code is generated and displayed within the defined performance threshold (e.g., <= 2 seconds)

---

### TC-089: Multiple QR generation requests are handled safely

**Type:** functional
**Priority:** low
**Status:** manual
**User Story:** US-010
**Requirement:** WA-PROF-005

**Description:** Verify system behavior when user triggers QR generation repeatedly

**Preconditions:**
- User is logged in
- Business profile exists and is verified/active

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Click “QR-Code generieren” multiple times rapidly | System handles repeated requests without crashing or duplicating UI elements |
| 2 | 2. Observe the displayed QR code | A single, valid QR code is shown |

**Final Expected Result:** Repeated requests do not cause errors, and a valid QR code is displayed

---

### TC-090: Send text message successfully in real time

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-011
**Requirement:** WA-MSG-001

**Description:** Verify that a logged-in user with stable internet can send a text message and receive a 'sent' confirmation in real time

**Preconditions:**
- User is logged in
- Stable internet connection is available
- Valid contact exists and is reachable

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the chat with a valid contact | Chat thread loads and input field is enabled |
| 2 | 2. Enter a valid text message in the input field | Message text appears in the input field |
| 3 | 3. Click the Send button | Message appears in the chat thread with status 'gesendet' |

**Final Expected Result:** Message is delivered in real time and confirmed as 'gesendet'

---

### TC-091: Queue message when internet is temporarily interrupted

**Type:** integration
**Priority:** high
**Status:** manual
**User Story:** US-011
**Requirement:** WA-MSG-001

**Description:** Verify that message is marked as pending and auto-sent after connectivity is restored

**Preconditions:**
- User is logged in
- Valid contact exists
- Network can be toggled off/on

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the chat with a valid contact | Chat thread loads and input field is enabled |
| 2 | 2. Disable internet connection on the device | App detects loss of connectivity |
| 3 | 3. Enter a text message and click Send | Message appears with status 'ausstehend' |
| 4 | 4. Re-enable internet connection | Connectivity is restored |
| 5 | 5. Observe the message status | Message status changes to 'gesendet' automatically |

**Final Expected Result:** Message is queued while offline and auto-sent after reconnection

---

### TC-092: Reject message to invalid recipient number

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-011
**Requirement:** WA-MSG-001

**Description:** Verify that sending to an invalid recipient results in an error and no delivery

**Preconditions:**
- User is logged in
- Invalid recipient number is available for testing

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Start a new message and enter an invalid recipient number | Recipient field accepts the input |
| 2 | 2. Enter a text message in the input field | Message text appears in the input field |
| 3 | 3. Click the Send button | A clear error message is displayed and message is not sent |

**Final Expected Result:** User receives a verständliche Fehlermeldung and the message is not delivered

---

### TC-093: Prevent sending empty text message

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-011
**Requirement:** WA-MSG-001

**Description:** Validate that an empty message cannot be sent

**Preconditions:**
- User is logged in
- Stable internet connection is available
- Valid contact exists

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the chat with a valid contact | Chat thread loads and input field is enabled |
| 2 | 2. Leave the message input field empty | Input field remains empty |
| 3 | 3. Click the Send button | Message is not sent and validation feedback is shown |

**Final Expected Result:** Empty message is blocked and user is informed

---

### TC-094: Boundary test for maximum message length

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-011
**Requirement:** WA-MSG-001

**Description:** Verify that a message at maximum allowed length can be sent successfully

**Preconditions:**
- User is logged in
- Stable internet connection is available
- Valid contact exists
- Maximum message length is known

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the chat with a valid contact | Chat thread loads and input field is enabled |
| 2 | 2. Enter a message exactly at the maximum allowed length | Input accepts the full message length |
| 3 | 3. Click the Send button | Message appears in the chat thread with status 'gesendet' |

**Final Expected Result:** Max-length message is sent and confirmed as 'gesendet'

---

### TC-095: Boundary test for message exceeding maximum length

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-011
**Requirement:** WA-MSG-001

**Description:** Verify that a message exceeding max length is rejected or truncated per rules

**Preconditions:**
- User is logged in
- Stable internet connection is available
- Valid contact exists
- Maximum message length is known

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the chat with a valid contact | Chat thread loads and input field is enabled |
| 2 | 2. Enter a message exceeding the maximum allowed length by 1 character | App prevents additional input or shows validation |
| 3 | 3. Attempt to send the message | Message is not sent and user is informed of the limit |

**Final Expected Result:** Over-limit message is blocked or validated according to requirements

---

### TC-096: Send while reconnecting (flaky network)

**Type:** integration
**Priority:** medium
**Status:** manual
**User Story:** US-011
**Requirement:** WA-MSG-001

**Description:** Verify behavior when network drops during send and then quickly reconnects

**Preconditions:**
- User is logged in
- Valid contact exists
- Network can be rapidly toggled

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the chat with a valid contact | Chat thread loads and input field is enabled |
| 2 | 2. Enter a text message | Message text appears in the input field |
| 3 | 3. Disable internet immediately after clicking Send | Message status changes to 'ausstehend' |
| 4 | 4. Re-enable internet within a short interval | Connectivity is restored |
| 5 | 5. Observe the message status | Message transitions to 'gesendet' without duplication |

**Final Expected Result:** Message is eventually sent once and marked as 'gesendet'

---

### TC-097: Error message clarity for invalid recipient

**Type:** functional
**Priority:** low
**Status:** manual
**User Story:** US-011
**Requirement:** WA-MSG-001

**Description:** Ensure the error message is understandable and actionable

**Preconditions:**
- User is logged in
- Invalid recipient number is available for testing

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Enter an invalid recipient number and a text message | Inputs are accepted |
| 2 | 2. Click the Send button | A clear error message is displayed |

**Final Expected Result:** Error message is verständlich and indicates the recipient number is invalid

---

### TC-098: Send voice message successfully with microphone permission granted

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-012
**Requirement:** WA-MSG-002

**Description:** Verify a user can record and send a voice message when microphone access is allowed

**Preconditions:**
- User is logged in
- User is in an active chat with another user
- Microphone permission is granted
- Network connectivity is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Tap the voice message record button | Recording starts and a visible recording indicator/timer appears |
| 2 | 2. Speak for at least 2 seconds | Audio is captured and recording indicator continues |
| 3 | 3. Tap the Send button | Recording stops and the voice message begins uploading |
| 4 | 4. Observe the chat thread after send completes | The voice message appears in the chat as sent and is shown as received on the recipient side |

**Final Expected Result:** Voice message is sent successfully and displayed in the chat for both sender and recipient

---

### TC-099: Cancel voice message before sending

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-012
**Requirement:** WA-MSG-002

**Description:** Verify canceling a recording prevents the voice message from being sent

**Preconditions:**
- User is logged in
- User is in an active chat
- Microphone permission is granted

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Tap the voice message record button | Recording starts and a cancel option is visible |
| 2 | 2. Tap the Cancel/Discard control before sending | Recording stops and the recorded audio is discarded |
| 3 | 3. Check the chat thread | No new voice message appears in the chat |

**Final Expected Result:** Canceled recording is not sent and no message is added to the chat

---

### TC-100: Attempt to record with microphone permission denied

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-012
**Requirement:** WA-MSG-002

**Description:** Verify a clear error is shown and user is prompted to grant permission when access is denied

**Preconditions:**
- User is logged in
- User is in an active chat
- Microphone permission is denied

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Tap the voice message record button | System blocks recording and shows a permission error |
| 2 | 2. Select the option to grant permission from the error prompt | System opens the permission request or device settings to enable microphone access |

**Final Expected Result:** User is informed about missing permission and is guided to grant it

---

### TC-1000: Reply to notification with дикtiert (voice dictation)

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-118
**Requirement:** WA-INT-004

**Description:** Verify that dictating a response sends the message and shows confirmation

**Preconditions:**
- User is a registered user and logged in on phone app
- Smartwatch is paired with the phone app
- Smartwatch notifications are enabled
- Smartwatch has active internet connection
- A notification is visible on the smartwatch
- Microphone permission is granted

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the visible notification on the smartwatch | Notification details and response options are displayed |
| 2 | 2. Choose the dictation option | Voice input screen is displayed and recording starts |
| 3 | 3. диктиert a short message and confirm | Text is transcribed and ready to send |
| 4 | 4. Send the dictated response | Response is sent successfully |

**Final Expected Result:** Dictated response is delivered to the recipient and marked as sent

---

### TC-1001: Inform user and block actions when no internet connection

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-118
**Requirement:** WA-INT-004

**Description:** Verify that incoming messages and send actions are blocked and user is informed when no connection

**Preconditions:**
- User is a registered user and logged in on phone app
- Smartwatch is paired with the phone app
- Smartwatch notifications are enabled
- Smartwatch has no active internet connection

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Send a new message to the user from the system | System registers the message for delivery |
| 2 | 2. Observe the smartwatch | User is informed about missing connection; no notification is delivered |
| 3 | 3. Attempt to send a reply from the smartwatch | User is informed about missing connection; message is not sent |

**Final Expected Result:** User is notified about missing connection and no send action is executed

---

### TC-1002: Boundary: Notification delivery time near threshold

**Type:** performance
**Priority:** medium
**Status:** manual
**User Story:** US-118
**Requirement:** WA-INT-004

**Description:** Verify notification delivery time does not exceed the accepted boundary

**Preconditions:**
- User is a registered user and logged in on phone app
- Smartwatch is paired with the phone app
- Smartwatch notifications are enabled
- Smartwatch has active internet connection

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Send a new message to the user from the system and start a timer | Timer starts and message is queued for delivery |
| 2 | 2. Stop the timer when notification appears on smartwatch | Notification appears within the defined acceptable boundary (few seconds) |

**Final Expected Result:** Notification delivery time meets the performance expectation

---

### TC-1003: Multiple incoming messages are notified

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-118
**Requirement:** WA-INT-004

**Description:** Verify consecutive messages trigger corresponding notifications

**Preconditions:**
- User is a registered user and logged in on phone app
- Smartwatch is paired with the phone app
- Smartwatch notifications are enabled
- Smartwatch has active internet connection

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Send two messages to the user within a short interval | Both messages are received by the backend |
| 2 | 2. Observe the smartwatch notifications | Two notifications are displayed or a combined notification indicates multiple messages |

**Final Expected Result:** All incoming messages are represented on the smartwatch

---

### TC-1004: Attempt to send reply without visible notification

**Type:** negative
**Priority:** low
**Status:** manual
**User Story:** US-118
**Requirement:** WA-INT-004

**Description:** Verify reply is not possible if no notification is visible

**Preconditions:**
- User is a registered user and logged in on phone app
- Smartwatch is paired with the phone app
- Smartwatch notifications are enabled
- No notification is currently visible

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the messaging response screen on the smartwatch | No message context is available or response options are disabled |

**Final Expected Result:** User cannot send a reply without an active notification

---

### TC-1005: Security: Confirm sent status after successful delivery

**Type:** integration
**Priority:** high
**Status:** manual
**User Story:** US-118
**Requirement:** WA-INT-004

**Description:** Verify sent confirmation is displayed only after successful delivery

**Preconditions:**
- User is a registered user and logged in on phone app
- Smartwatch is paired with the phone app
- Smartwatch notifications are enabled
- Smartwatch has active internet connection
- A notification is visible on the smartwatch

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Select a preset response and send | Response is sent to the backend |
| 2 | 2. Wait for backend delivery confirmation | Backend confirms delivery to recipient |
| 3 | 3. Observe smartwatch status | Message status is shown as sent only after confirmation |

**Final Expected Result:** Sent status is displayed only after successful delivery confirmation

---

### TC-1006: Launch and login on supported platform - Windows

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-119
**Requirement:** WA-INT-005

**Description:** Verify desktop app starts and user can log in on Windows

**Preconditions:**
- Windows 10/11 supported version
- Desktop app installed successfully
- Valid user credentials available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Launch the desktop app from Start menu | App window opens without errors |
| 2 | 2. Enter valid username and password and click Login | User is authenticated and redirected to main dashboard |

**Final Expected Result:** User can launch and log in to the desktop app on Windows

---

### TC-1007: Launch and login on supported platform - macOS

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-119
**Requirement:** WA-INT-005

**Description:** Verify desktop app starts and user can log in on macOS

**Preconditions:**
- macOS supported version
- Desktop app installed successfully
- Valid user credentials available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Launch the desktop app from Applications folder or Dock | App window opens without errors |
| 2 | 2. Enter valid username and password and click Login | User is authenticated and redirected to main dashboard |

**Final Expected Result:** User can launch and log in to the desktop app on macOS

---

### TC-1008: Launch and login on supported platform - Linux

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-119
**Requirement:** WA-INT-005

**Description:** Verify desktop app starts and user can log in on Linux

**Preconditions:**
- Linux supported distribution/version
- Desktop app installed successfully
- Valid user credentials available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Launch the desktop app from application launcher | App window opens without errors |
| 2 | 2. Enter valid username and password and click Login | User is authenticated and redirected to main dashboard |

**Final Expected Result:** User can launch and log in to the desktop app on Linux

---

### TC-1009: Core feature parity with web version - messaging

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-119
**Requirement:** WA-INT-005

**Description:** Verify key messaging features are available and functional in desktop app

**Preconditions:**
- User is logged in on desktop app
- User has at least one contact/conversation

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open an existing conversation | Conversation thread loads with message history |
| 2 | 2. Type a message and click Send | Message appears in thread and is marked as sent |
| 3 | 3. Receive an incoming message from another user | Incoming message is displayed in the thread |

**Final Expected Result:** Messaging features in desktop app work as in web version

---

### TC-101: Grant permission after denial and send voice message

**Type:** e2e
**Priority:** medium
**Status:** manual
**User Story:** US-012
**Requirement:** WA-MSG-002

**Description:** Verify that granting permission after denial enables recording and sending

**Preconditions:**
- User is logged in
- User is in an active chat
- Microphone permission is denied initially

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Tap the voice message record button | Permission error prompt is displayed |
| 2 | 2. Enable microphone permission via prompt/settings and return to the app | App detects permission granted |
| 3 | 3. Tap the record button and record a 2-second message | Recording starts and audio is captured |
| 4 | 4. Tap Send | Voice message is sent and appears in the chat |

**Final Expected Result:** Voice message can be recorded and sent after granting permission

---

### TC-1010: Core feature parity with web version - notifications

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-119
**Requirement:** WA-INT-005

**Description:** Verify notifications are available and function similarly to web

**Preconditions:**
- User is logged in on desktop app
- Notifications enabled at OS level

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Send a message to the logged-in user from another account | Desktop notification is displayed with sender and message preview |
| 2 | 2. Click the notification | App focuses and opens the correct conversation |

**Final Expected Result:** Desktop notifications behave consistently with web version

---

### TC-1011: Offline send behavior - show clear connection warning

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-119
**Requirement:** WA-INT-005

**Description:** Verify a clear offline indicator when attempting to send during internet loss

**Preconditions:**
- User is logged in on desktop app
- Active session established
- Network connectivity available initially

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Disable internet connection | App detects offline state within a reasonable time |
| 2 | 2. Attempt to send a message | User receives a clear offline warning/indicator |

**Final Expected Result:** App clearly informs user of missing connection when sending

---

### TC-1012: Offline send behavior - auto-send after reconnection

**Type:** integration
**Priority:** high
**Status:** manual
**User Story:** US-119
**Requirement:** WA-INT-005

**Description:** Verify message is auto-sent once connectivity is restored

**Preconditions:**
- User is logged in on desktop app
- Active session established
- Network connectivity available initially

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Disable internet connection | App detects offline state |
| 2 | 2. Attempt to send a message | Message is queued and shows pending state |
| 3 | 3. Restore internet connection | App detects reconnection |
| 4 | 4. Observe the queued message | Message is automatically sent and marked as delivered |

**Final Expected Result:** Queued message is sent automatically after reconnection

---

### TC-1013: Offline duration boundary - short interruption

**Type:** integration
**Priority:** medium
**Status:** manual
**User Story:** US-119
**Requirement:** WA-INT-005

**Description:** Verify short network interruption still results in auto-send

**Preconditions:**
- User is logged in on desktop app
- Active session established

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Disable internet connection for 5 seconds | App detects offline state |
| 2 | 2. Attempt to send a message during the interruption | Message is queued and user is notified of offline state |
| 3 | 3. Restore internet connection after 5 seconds | App reconnects and sends queued message |

**Final Expected Result:** Short interruption still results in queued message being auto-sent

---

### TC-1014: Multiple queued messages during offline period

**Type:** integration
**Priority:** medium
**Status:** manual
**User Story:** US-119
**Requirement:** WA-INT-005

**Description:** Verify multiple messages are queued and sent in order after reconnection

**Preconditions:**
- User is logged in on desktop app
- Active session established

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Disable internet connection | App detects offline state |
| 2 | 2. Send three messages in the same conversation | All three messages show pending state and are queued |
| 3 | 3. Restore internet connection | All queued messages are sent in the order created |

**Final Expected Result:** Multiple queued messages are auto-sent in order after reconnection

---

### TC-1015: Unsupported platform installation attempt - clear error message

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-119
**Requirement:** WA-INT-005

**Description:** Verify installation on unsupported OS shows a clear error with supported platforms listed

**Preconditions:**
- Unsupported platform (e.g., Windows 7, macOS unsupported version, or non-supported Linux distro)
- Installer available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Start the desktop app installer on the unsupported platform | Installation halts or blocks |
| 2 | 2. Observe the error message | Error message clearly states unsupported platform and lists supported platforms (Windows, macOS, Linux) |

**Final Expected Result:** User receives a clear, understandable message about unsupported platform and supported OS list

---

### TC-1016: Login failure handling on desktop app

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-119
**Requirement:** WA-INT-005

**Description:** Verify incorrect credentials are handled with proper feedback

**Preconditions:**
- Desktop app installed on supported platform

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Launch the desktop app | Login screen is displayed |
| 2 | 2. Enter invalid username or password and click Login | Login is rejected with an error message |

**Final Expected Result:** User is informed of invalid credentials and not logged in

---

### TC-1017: App behavior when starting without internet - login attempt

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-119
**Requirement:** WA-INT-005

**Description:** Verify login flow provides clear feedback when no internet is available at start

**Preconditions:**
- Desktop app installed on supported platform
- Internet connection disabled

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Launch the desktop app while offline | App opens and indicates offline status |
| 2 | 2. Attempt to log in with valid credentials | Login fails with a clear message about missing connection |

**Final Expected Result:** User receives clear feedback that login requires internet connectivity

---

### TC-1018: Login and access core functions in web version

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-120
**Requirement:** WA-INT-006

**Description:** Verify that a user with a current browser and internet connection can log in and use all core functions in the web version.

**Preconditions:**
- User has a valid account
- User has a supported, up-to-date browser
- Stable internet connection is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to the web version URL | Login page loads without errors |
| 2 | 2. Enter valid credentials and submit | User is authenticated and redirected to the main dashboard |
| 3 | 3. Open the chat list and select an existing chat | Chat opens and messages are displayed correctly |
| 4 | 4. Send a new message | Message is sent and appears in the conversation |
| 5 | 5. Change a user setting (e.g., language or notification setting) | Setting is saved and persists after page refresh |

**Final Expected Result:** User can fully and performantly use core functions after logging in.

---

### TC-1019: Cross-device consistency of chats and settings

**Type:** integration
**Priority:** high
**Status:** manual
**User Story:** US-120
**Requirement:** WA-INT-006

**Description:** Verify that chats and settings are consistent when switching devices and logging into the web version.

**Preconditions:**
- User has an existing account with chats and customized settings
- User has access to a second device with a supported browser
- Stable internet connection is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. On device A, log in and confirm existing chats and a custom setting | Chats and settings are visible on device A |
| 2 | 2. Log out from device A | User is logged out successfully |
| 3 | 3. On device B, navigate to the web version and log in with the same account | User is authenticated and sees the main dashboard |
| 4 | 4. Open the chat list and settings | All existing chats and custom settings are present and consistent |

**Final Expected Result:** Chats and settings remain consistent across devices when using the web version.

---

### TC-102: Minimum-length recording boundary

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-012
**Requirement:** WA-MSG-002

**Description:** Verify behavior for very short recordings (boundary condition)

**Preconditions:**
- User is logged in
- User is in an active chat
- Microphone permission is granted

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Tap the record button and speak for less than 1 second | Recording captures a very short audio clip |
| 2 | 2. Tap Send | System either sends the short clip or shows a validation message if a minimum length is required |

**Final Expected Result:** System handles short recordings gracefully according to product rules

---

### TC-1020: Handle unstable internet during action with recovery

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-120
**Requirement:** WA-INT-006

**Description:** Verify user receives a clear error and app attempts recovery without data loss when connection drops during an action.

**Preconditions:**
- User is logged in
- Network throttling or disconnect simulation is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open an existing chat | Chat opens and messages are displayed |
| 2 | 2. Simulate network interruption | Connection is lost |
| 3 | 3. Attempt to send a message during the interruption | A clear error message is shown and message is queued or marked as unsent |
| 4 | 4. Restore the network connection | Application attempts recovery and resends queued message |
| 5 | 5. Refresh the chat view | Message is present once and no data is lost or duplicated |

**Final Expected Result:** User is informed of the issue, recovery is attempted, and no data is lost.

---

### TC-1021: Access denied on unsupported browser

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-120
**Requirement:** WA-INT-006

**Description:** Verify proper handling and messaging when using an outdated or unsupported browser.

**Preconditions:**
- User has access to an unsupported or outdated browser
- Internet connection is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to the web version URL using an unsupported browser | A compatibility warning or upgrade message is displayed |
| 2 | 2. Attempt to proceed to login | User is prevented from using the app or warned that functionality may be limited |

**Final Expected Result:** User receives a clear message about browser support and is guided accordingly.

---

### TC-1022: Login failure with invalid credentials

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-120
**Requirement:** WA-INT-006

**Description:** Verify error handling for invalid login attempts in the web version.

**Preconditions:**
- User is on the login page
- Internet connection is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Enter an invalid username or password | Login attempt is rejected |
| 2 | 2. Submit the login form | A clear error message is displayed and user remains on login page |

**Final Expected Result:** Invalid credentials are rejected with a clear error and no access is granted.

---

### TC-1023: Session persistence after refresh

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-120
**Requirement:** WA-INT-006

**Description:** Verify the user session remains active after a browser refresh.

**Preconditions:**
- User is logged in
- Stable internet connection is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Refresh the browser page while on the dashboard | Page reloads successfully |
| 2 | 2. Observe the authentication state | User remains logged in and dashboard is accessible |

**Final Expected Result:** Session persists after refresh without requiring re-login.

---

### TC-1024: Boundary: Large chat history loads performance

**Type:** performance
**Priority:** medium
**Status:** manual
**User Story:** US-120
**Requirement:** WA-INT-006

**Description:** Verify that large chat history loads and renders within acceptable performance limits.

**Preconditions:**
- User account has a chat with a large number of messages
- Supported browser and stable internet connection

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Log in and open the chat with large history | Chat opens and initial messages render without errors |
| 2 | 2. Scroll to load older messages | Older messages load within acceptable time without freezing |

**Final Expected Result:** Large chat history loads and performs within defined performance thresholds.

---

### TC-1025: Recovery after brief network fluctuation during settings update

**Type:** integration
**Priority:** high
**Status:** manual
**User Story:** US-120
**Requirement:** WA-INT-006

**Description:** Verify that settings changes are not lost when the network briefly fluctuates.

**Preconditions:**
- User is logged in
- Network fluctuation simulation is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to settings page | Settings page loads |
| 2 | 2. Change a setting and save | Save request is initiated |
| 3 | 3. Simulate brief network drop and restore within a few seconds | Application shows a recovery status and retries saving |
| 4 | 4. Refresh the page | Setting remains updated and consistent |

**Final Expected Result:** Settings changes persist despite brief network issues, with clear user feedback.

---

### TC-1026: Multi-device simultaneous login data consistency

**Type:** e2e
**Priority:** medium
**Status:** manual
**User Story:** US-120
**Requirement:** WA-INT-006

**Description:** Verify chat updates reflect across devices when both are logged in simultaneously.

**Preconditions:**
- User has access to two devices with supported browsers
- User is logged in on both devices

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. On device A, send a new message in a chat | Message appears on device A |
| 2 | 2. On device B, open the same chat | New message from device A appears on device B |
| 3 | 3. Change a setting on device B | Setting is updated on device B |
| 4 | 4. Refresh device A settings page | Updated setting is reflected on device A |

**Final Expected Result:** Chats and settings remain consistent across simultaneously logged-in devices.

---

### TC-1027: Activate AI assistant and receive response within SLA

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-121
**Requirement:** WA-AI-001

**Description:** Verify that a logged-in user can activate the AI assistant in a chat and receive a response within the defined response time.

**Preconditions:**
- User is logged in
- User is in an existing chat
- AI assistant feature is enabled for the account
- Supported platform/device
- Defined response time SLA is known

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the chat screen and locate the AI assistant activation control. | AI assistant activation control is visible and enabled. |
| 2 | 2. Activate the AI assistant. | AI assistant is marked as active (e.g., toggle on, icon highlighted). |
| 3 | 3. Enter a valid question and send it to the AI assistant. | The user’s message appears in the chat and is marked as sent. |
| 4 | 4. Observe the chat for the AI response within the defined response time. | AI response appears in the chat within the SLA time window. |

**Final Expected Result:** AI assistant responds within the defined response time after activation and question submission.

---

### TC-1028: AI assistant activation blocked on unsupported platform/device

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-121
**Requirement:** WA-AI-001

**Description:** Verify that users on unsupported platforms/devices receive a clear unavailability message when attempting to activate AI assistant.

**Preconditions:**
- User is logged in
- User is in a chat
- Platform/device is unsupported

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the chat screen on the unsupported platform/device. | Chat screen loads successfully. |
| 2 | 2. Attempt to activate the AI assistant. | A clear message indicates the feature is not available on this platform/device. |

**Final Expected Result:** User receives a clear unavailability message and AI assistant is not activated.

---

### TC-1029: AI integration unavailable shows error and message not marked as delivered

**Type:** integration
**Priority:** high
**Status:** manual
**User Story:** US-121
**Requirement:** WA-AI-001

**Description:** Verify that when the AI service is unavailable, an error is shown and the request is not marked as delivered.

**Preconditions:**
- User is logged in
- User is in a chat
- AI assistant is activated
- AI integration/external service is temporarily unavailable

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Send a question to the AI assistant. | The user’s message appears with a pending/sending state. |
| 2 | 2. Wait for the system to process the request. | An error message is displayed indicating the service disruption. |
| 3 | 3. Check the delivery state of the user’s message. | The message is not marked as delivered/sent to AI. |

**Final Expected Result:** User sees a service disruption error and the request is not marked as delivered.

---

### TC-103: Long recording boundary

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-012
**Requirement:** WA-MSG-002

**Description:** Verify system behavior at maximum allowed recording length

**Preconditions:**
- User is logged in
- User is in an active chat
- Microphone permission is granted
- Maximum recording length is configured/known

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Start recording and continue until the maximum allowed duration is reached | Recording duration indicator reaches maximum |
| 2 | 2. Observe system behavior at the limit | Recording automatically stops or prevents exceeding the limit with a clear indication |
| 3 | 3. Tap Send | Voice message is sent successfully if within allowed limits |

**Final Expected Result:** Recording length is constrained to the maximum and message sends correctly

---

### TC-1030: Activation toggle persists within session

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-121
**Requirement:** WA-AI-001

**Description:** Verify AI assistant activation status remains active during the session after activation.

**Preconditions:**
- User is logged in
- User is in a chat
- Supported platform/device

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Activate the AI assistant. | AI assistant shows active state. |
| 2 | 2. Navigate away from the chat and return within the same session. | AI assistant remains active in the chat. |

**Final Expected Result:** AI assistant activation state persists within the user session.

---

### TC-1031: Send question without activation shows prompt or blocks send

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-121
**Requirement:** WA-AI-001

**Description:** Verify that sending a question without activating the AI assistant is handled appropriately (prompt to activate or blocked).

**Preconditions:**
- User is logged in
- User is in a chat
- AI assistant is not activated
- Supported platform/device

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Enter a question intended for the AI assistant. | Text is entered in the message input. |
| 2 | 2. Attempt to send the question without activating the AI assistant. | System prompts to activate AI assistant or blocks sending with a clear message. |

**Final Expected Result:** System prevents or guides sending AI requests without activation.

---

### TC-1032: Boundary: Minimal question length

**Type:** functional
**Priority:** low
**Status:** manual
**User Story:** US-121
**Requirement:** WA-AI-001

**Description:** Verify that the shortest valid question is accepted and answered.

**Preconditions:**
- User is logged in
- User is in a chat
- AI assistant is activated
- Supported platform/device

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Send a minimal valid question (e.g., a single character or minimal allowed length). | Message is accepted and appears as sent. |
| 2 | 2. Wait for AI response within SLA. | AI response is returned within the defined time. |

**Final Expected Result:** Minimal valid question is processed and answered.

---

### TC-1033: Boundary: Maximum question length

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-121
**Requirement:** WA-AI-001

**Description:** Verify that the maximum allowed question length is handled correctly.

**Preconditions:**
- User is logged in
- User is in a chat
- AI assistant is activated
- Supported platform/device
- Maximum message length is known

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Enter a question at the maximum allowed length. | Input accepts the message without truncation. |
| 2 | 2. Send the question to the AI assistant. | Message is sent successfully. |
| 3 | 3. Wait for AI response within SLA. | AI response is returned within the defined time. |

**Final Expected Result:** Maximum length question is accepted and answered.

---

### TC-1034: Exceed maximum question length

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-121
**Requirement:** WA-AI-001

**Description:** Verify that questions exceeding the maximum length are rejected with a clear message.

**Preconditions:**
- User is logged in
- User is in a chat
- AI assistant is activated
- Supported platform/device
- Maximum message length is known

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Enter a question exceeding the maximum allowed length. | System prevents further input or indicates length exceeded. |
| 2 | 2. Attempt to send the over-length question. | Message is not sent and a clear validation message is shown. |

**Final Expected Result:** Over-length questions are not sent and the user is informed.

---

### TC-1035: Performance: AI response time within SLA under normal load

**Type:** performance
**Priority:** high
**Status:** manual
**User Story:** US-121
**Requirement:** WA-AI-001

**Description:** Measure AI response time to ensure it meets the defined SLA under normal load.

**Preconditions:**
- User is logged in
- User is in a chat
- AI assistant is activated
- Supported platform/device
- Normal load conditions

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Send a standard question to the AI assistant. | Message is sent and appears in the chat. |
| 2 | 2. Measure time until AI response appears. | Response time is within the defined SLA. |

**Final Expected Result:** AI response time meets SLA under normal load.

---

### TC-1036: Error message content clarity on service outage

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-121
**Requirement:** WA-AI-001

**Description:** Verify that the outage error message clearly indicates a temporary service disruption.

**Preconditions:**
- User is logged in
- User is in a chat
- AI assistant is activated
- AI integration/external service is temporarily unavailable

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Send a question to the AI assistant. | Message shows as pending/sending. |
| 2 | 2. Observe the error message displayed. | Error message explicitly mentions temporary disruption and suggests retry later. |

**Final Expected Result:** Error message is clear and informative about the temporary service issue.

---

### TC-1037: Display at least three smart replies within 2 seconds

**Type:** performance
**Priority:** high
**Status:** manual
**User Story:** US-122
**Requirement:** WA-AI-002

**Description:** Verify smart reply suggestions appear promptly for an active conversation with an incoming message

**Preconditions:**
- User is logged in as Kundenservice-Mitarbeiter
- Active customer conversation exists
- Incoming customer message is present
- Smart Reply service is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the active conversation with the incoming message | Conversation thread is displayed with the latest incoming message |
| 2 | 2. Open the smart reply function | Smart reply panel opens and starts loading suggestions |

**Final Expected Result:** At least three relevant reply suggestions are displayed within 2 seconds

---

### TC-1038: Select a suggested reply and edit before sending

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-122
**Requirement:** WA-AI-002

**Description:** Verify selected suggestion is inserted into input field and remains editable

**Preconditions:**
- User is logged in as Kundenservice-Mitarbeiter
- Smart reply suggestions are displayed

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Click on a suggested reply | Selected suggestion is inserted into the reply input field |
| 2 | 2. Edit the inserted text | Input field text updates to the edited content |

**Final Expected Result:** User can modify the suggested reply before sending

---

### TC-1039: Short message (single word) returns neutral or no-suggestion notice

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-122
**Requirement:** WA-AI-002

**Description:** Verify behavior for low-context incoming message

**Preconditions:**
- User is logged in as Kundenservice-Mitarbeiter
- Incoming message is a single short word (e.g., 'OK')

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the active conversation with the short incoming message | Conversation thread displays the short message |
| 2 | 2. Open the smart reply function | Smart reply panel opens |

**Final Expected Result:** System shows neutral, low-context suggestions or a notice that no meaningful suggestions are available

---

### TC-104: Network interruption during send

**Type:** integration
**Priority:** high
**Status:** manual
**User Story:** US-012
**Requirement:** WA-MSG-002

**Description:** Verify the app handles sending failures due to lost connectivity

**Preconditions:**
- User is logged in
- User is in an active chat
- Microphone permission is granted

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Record a 3-second voice message | Recording completes and send is available |
| 2 | 2. Disable network connectivity and tap Send | Message send fails with an error or retry status |
| 3 | 3. Re-enable network connectivity and retry send | Message is successfully sent and appears in the chat |

**Final Expected Result:** Send failures are handled gracefully with retry and eventual success

---

### TC-1040: Emoji-only message returns neutral or no-suggestion notice

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-122
**Requirement:** WA-AI-002

**Description:** Verify behavior for emoji-only incoming message

**Preconditions:**
- User is logged in as Kundenservice-Mitarbeiter
- Incoming message contains only an emoji (e.g., '👍')

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the conversation with the emoji-only message | Conversation thread displays the emoji-only message |
| 2 | 2. Open the smart reply function | Smart reply panel opens |

**Final Expected Result:** System shows neutral, low-context suggestions or a notice that no meaningful suggestions are available

---

### TC-1041: Smart reply service unavailable shows error and allows manual reply

**Type:** integration
**Priority:** high
**Status:** manual
**User Story:** US-122
**Requirement:** WA-AI-002

**Description:** Verify fallback when smart reply service is down

**Preconditions:**
- User is logged in as Kundenservice-Mitarbeiter
- Active customer conversation exists
- Smart reply service is unavailable or returning errors

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the active conversation | Conversation thread is displayed |
| 2 | 2. Open the smart reply function | A clear error message is displayed |
| 3 | 3. Type a manual response in the input field | Input field accepts manual text |

**Final Expected Result:** User sees a readable error and can still manually write a reply

---

### TC-1042: Exactly three suggestions are displayed

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-122
**Requirement:** WA-AI-002

**Description:** Verify boundary condition for minimum suggestions count

**Preconditions:**
- User is logged in as Kundenservice-Mitarbeiter
- Incoming message is present
- Smart reply service returns exactly three suggestions

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the smart reply function | Smart reply panel opens |

**Final Expected Result:** Exactly three suggestions are displayed and no fewer

---

### TC-1043: More than three suggestions are displayed without truncation issues

**Type:** functional
**Priority:** low
**Status:** manual
**User Story:** US-122
**Requirement:** WA-AI-002

**Description:** Verify UI handles more than three suggestions and remains usable

**Preconditions:**
- User is logged in as Kundenservice-Mitarbeiter
- Incoming message is present
- Smart reply service returns more than three suggestions

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the smart reply function | Smart reply panel opens |
| 2 | 2. Scroll or view all suggestions if needed | All suggestions are visible and selectable without layout issues |

**Final Expected Result:** More than three suggestions are displayed correctly and remain selectable

---

### TC-1044: Suggestion selection does not auto-send

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-122
**Requirement:** WA-AI-002

**Description:** Verify selecting a suggestion does not send the message automatically

**Preconditions:**
- User is logged in as Kundenservice-Mitarbeiter
- Smart reply suggestions are displayed

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Click on a suggested reply | Selected suggestion is inserted into the input field |
| 2 | 2. Observe the conversation thread | No new outgoing message is sent automatically |

**Final Expected Result:** Message is not sent until user explicitly sends it

---

### TC-1045: Contextual sticker suggestions appear for clear context

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-123
**Requirement:** WA-AI-003

**Description:** Verify that relevant sticker suggestions appear quickly when message has clear context

**Preconditions:**
- User is logged in
- Sticker suggestions are enabled in settings
- Context analysis service is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open an existing chat conversation | Chat screen is displayed with message input field |
| 2 | 2. Type a message with clear context (e.g., "Happy birthday!" ) | Typed text appears in the input field |
| 3 | 3. Pause typing for 1 second | System processes the input without interrupting typing |
| 4 | 4. Observe sticker suggestion area | Context-relevant sticker suggestions (e.g., birthday-themed) appear within the expected short time |

**Final Expected Result:** Relevant sticker suggestions are displayed quickly for a clear context message

---

### TC-1046: General sticker suggestions for ambiguous context

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-123
**Requirement:** WA-AI-003

**Description:** Verify that generic, non-intrusive suggestions appear for ambiguous/neutral messages

**Preconditions:**
- User is logged in
- Sticker suggestions are enabled in settings
- Context analysis service is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open a chat conversation | Chat screen is displayed with message input field |
| 2 | 2. Type a neutral message (e.g., "Okay" or "Hmm") | Typed text appears in the input field |
| 3 | 3. Wait briefly (up to defined short time) | System processes the input without delay |
| 4 | 4. Check sticker suggestion area | Generic, non-specific sticker suggestions appear (not aggressive or highly contextual) |

**Final Expected Result:** General sticker suggestions are shown for ambiguous/neutral context

---

### TC-1047: No sticker suggestions when feature is disabled

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-123
**Requirement:** WA-AI-003

**Description:** Verify that no suggestions are shown when the user disables sticker suggestions

**Preconditions:**
- User is logged in
- Sticker suggestions are disabled in settings
- Context analysis service is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open a chat conversation | Chat screen is displayed |
| 2 | 2. Type a message with clear context (e.g., "Congrats on the promotion!") | Typed text appears in the input field |
| 3 | 3. Wait briefly | System processes the input without delay |
| 4 | 4. Observe sticker suggestion area | No sticker suggestions are displayed |

**Final Expected Result:** Sticker suggestions are not shown when the feature is disabled

---

### TC-1048: No suggestions when context analysis service is unavailable

**Type:** integration
**Priority:** high
**Status:** manual
**User Story:** US-123
**Requirement:** WA-AI-003

**Description:** Verify that message input continues without delay and no suggestions appear when service is down

**Preconditions:**
- User is logged in
- Sticker suggestions are enabled in settings
- Context analysis service is unavailable

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open a chat conversation | Chat screen is displayed |
| 2 | 2. Type a message with clear context (e.g., "I am so excited!") | Typed text appears in the input field |
| 3 | 3. Continue typing additional characters | Input remains responsive with no noticeable delay |
| 4 | 4. Check sticker suggestion area | No sticker suggestions are displayed |

**Final Expected Result:** Message input remains responsive and no suggestions are shown when analysis service is unavailable

---

### TC-1049: Boundary: Very short input does not trigger suggestions prematurely

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-123
**Requirement:** WA-AI-003

**Description:** Verify behavior for very short inputs that may not provide context

**Preconditions:**
- User is logged in
- Sticker suggestions are enabled in settings
- Context analysis service is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open a chat conversation | Chat screen is displayed |
| 2 | 2. Type a single character (e.g., "H") | Single character appears in input field |
| 3 | 3. Wait briefly | System processes the input |
| 4 | 4. Check sticker suggestion area | No suggestions or only generic suggestions are shown, depending on design rules |

**Final Expected Result:** System does not show overly specific suggestions for extremely short inputs

---

### TC-105: UI indication during recording

**Type:** functional
**Priority:** low
**Status:** manual
**User Story:** US-012
**Requirement:** WA-MSG-002

**Description:** Verify recording UI feedback is present and accurate

**Preconditions:**
- User is logged in
- User is in an active chat
- Microphone permission is granted

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Tap the record button | Recording indicator, timer, and cancel option are displayed |
| 2 | 2. Stop recording | Recording indicator disappears and send/cancel options are shown |

**Final Expected Result:** Recording status is clearly communicated to the user

---

### TC-1050: Boundary: Long message still provides suggestions

**Type:** performance
**Priority:** medium
**Status:** manual
**User Story:** US-123
**Requirement:** WA-AI-003

**Description:** Verify that long inputs still trigger appropriate suggestions without performance issues

**Preconditions:**
- User is logged in
- Sticker suggestions are enabled in settings
- Context analysis service is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open a chat conversation | Chat screen is displayed |
| 2 | 2. Paste a long message with clear context (e.g., 500+ characters about a celebration) | Long text appears in input field without lag |
| 3 | 3. Wait briefly | System processes the input within acceptable time |
| 4 | 4. Observe sticker suggestion area | Relevant sticker suggestions appear within expected short time |

**Final Expected Result:** Long messages do not delay input and still produce relevant suggestions

---

### TC-1051: Negative: Empty input does not show suggestions

**Type:** functional
**Priority:** low
**Status:** manual
**User Story:** US-123
**Requirement:** WA-AI-003

**Description:** Verify that no suggestions appear when the input is empty

**Preconditions:**
- User is logged in
- Sticker suggestions are enabled in settings
- Context analysis service is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open a chat conversation | Chat screen is displayed |
| 2 | 2. Ensure the input field is empty | Input field is empty |
| 3 | 3. Wait briefly | No processing indicators appear |
| 4 | 4. Check sticker suggestion area | No sticker suggestions are displayed |

**Final Expected Result:** No sticker suggestions are shown for empty input

---

### TC-1052: Toggle settings: Enable suggestions and verify appearance

**Type:** e2e
**Priority:** medium
**Status:** manual
**User Story:** US-123
**Requirement:** WA-AI-003

**Description:** Verify that enabling suggestions in settings triggers normal behavior

**Preconditions:**
- User is logged in
- Sticker suggestions are disabled in settings
- Context analysis service is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open settings and enable sticker suggestions | Sticker suggestions setting is enabled |
| 2 | 2. Navigate back to a chat conversation | Chat screen is displayed |
| 3 | 3. Type a message with clear context (e.g., "Good job!") | Typed text appears in the input field |
| 4 | 4. Wait briefly | System processes the input without delay |
| 5 | 5. Observe sticker suggestion area | Relevant sticker suggestions appear |

**Final Expected Result:** Enabling the feature results in sticker suggestions for contextual messages

---

### TC-1053: Service recovery: Suggestions resume after context service becomes available

**Type:** integration
**Priority:** medium
**Status:** manual
**User Story:** US-123
**Requirement:** WA-AI-003

**Description:** Verify that suggestions resume after temporary service outage

**Preconditions:**
- User is logged in
- Sticker suggestions are enabled in settings
- Context analysis service is initially unavailable then restored

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. With service unavailable, type a clear context message | Input remains responsive and no suggestions are displayed |
| 2 | 2. Restore context analysis service availability | Service is reachable |
| 3 | 3. Type another clear context message | Typed text appears in the input field |
| 4 | 4. Wait briefly | System processes the input without delay |
| 5 | 5. Observe sticker suggestion area | Relevant sticker suggestions appear |

**Final Expected Result:** Suggestions are suppressed during outage and resume once service is restored

---

### TC-1054: RTL layout on main UI when system language is Arabic

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-124
**Requirement:** WA-LOC-001

**Description:** Verify full RTL alignment of layout, navigation, and text when system language is set to Arabic.

**Preconditions:**
- System language is set to Arabic
- User is logged in
- Application cache cleared

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Launch the application and open the main interface/home screen | Main interface loads without errors |
| 2 | 2. Observe global layout direction and alignment | Overall layout is right-to-left; content is aligned to the right |
| 3 | 3. Verify navigation menu position and order | Navigation appears on the right; menu items are in RTL order |
| 4 | 4. Verify header, footer, and primary text alignment | All visible text is right-aligned and reads RTL |

**Final Expected Result:** Layout, navigation, and text are fully RTL and correctly displayed on the main interface.

---

### TC-1055: LTR layout when system language is English (negative)

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-124
**Requirement:** WA-LOC-001

**Description:** Ensure RTL is not applied when system language is English.

**Preconditions:**
- System language is set to English
- User is logged in

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the main interface/home screen | Main interface loads |
| 2 | 2. Observe layout direction and alignment | Layout and text are left-to-right and left-aligned |

**Final Expected Result:** RTL layout is not applied in English; UI remains LTR.

---

### TC-1056: Mixed RTL/LTR message rendering in chat

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-124
**Requirement:** WA-LOC-001

**Description:** Verify correct bidirectional rendering for messages containing RTL and LTR text with punctuation.

**Preconditions:**
- System language is set to Arabic
- User is logged in
- Chat screen is accessible

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open a chat conversation | Chat conversation is displayed in RTL layout |
| 2 | 2. Send message: "مرحبا John! رقم الطلب 12345." | Message appears in the chat |
| 3 | 3. Inspect text direction and punctuation positions | Arabic text is RTL, English name and numbers are LTR, and punctuation appears correctly and is readable |

**Final Expected Result:** Mixed RTL/LTR content is displayed with correct directionality and punctuation.

---

### TC-1057: Mixed RTL/LTR message with leading LTR segment (boundary)

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-124
**Requirement:** WA-LOC-001

**Description:** Ensure correct display when message starts with LTR content followed by RTL.

**Preconditions:**
- System language is set to Arabic
- User is logged in
- Chat screen is accessible

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open a chat conversation | Chat conversation is displayed |
| 2 | 2. Send message: "Order #999 تم إرساله." | Message appears in the chat |
| 3 | 3. Verify readability of mixed direction text | LTR segment remains intact, RTL segment appears correctly, and punctuation placement is correct |

**Final Expected Result:** Message renders correctly even when LTR segment precedes RTL text.

---

### TC-1058: RTL form fields alignment with placeholders, labels, and errors

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-124
**Requirement:** WA-LOC-001

**Description:** Verify placeholders, labels, and validation messages align right and order correctly in RTL form.

**Preconditions:**
- System language is set to Arabic
- User is logged in
- A form with required fields is accessible

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the form with required fields | Form loads with RTL layout |
| 2 | 2. Inspect labels and placeholders for alignment | Labels and placeholders are right-aligned and positioned in RTL order |
| 3 | 3. Leave a required field empty and attempt to submit | Validation message appears |
| 4 | 4. Verify validation message alignment and order | Validation messages are right-aligned and aligned with the corresponding fields |

**Final Expected Result:** Form labels, placeholders, and error messages are correctly right-aligned and ordered in RTL.

---

### TC-1059: RTL form with mixed LTR input values

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-124
**Requirement:** WA-LOC-001

**Description:** Ensure LTR input values (e.g., email) are readable in RTL form while labels remain RTL.

**Preconditions:**
- System language is set to Arabic
- User is logged in
- Form with email field is accessible

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the form | Form loads in RTL |
| 2 | 2. Enter LTR email value in the email field (e.g., "user@example.com") | Input is accepted and displayed legibly |
| 3 | 3. Verify label and placeholder alignment | Label and placeholder remain right-aligned and RTL |

**Final Expected Result:** LTR input values are readable within RTL form without breaking alignment.

---

### TC-106: Loeschen gesendeter Nachricht aus Nachrichtenliste

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-013
**Requirement:** WA-MSG-003

**Description:** Verifiziert, dass eine gesendete Nachricht nach bestaetigtem Loeschen aus der Liste entfernt wird und nicht mehr abrufbar ist.

**Preconditions:**
- Nutzer ist angemeldet
- Nachrichtenliste ist sichtbar
- Mindestens eine gesendete Nachricht existiert

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Gesendete Nachricht in der Liste auswaehlen | Nachricht wird als ausgewaehlt markiert und Details sind sichtbar |
| 2 | 2. Loeschaktion ausloesen (z. B. Loeschen-Button) | Bestaetigungsdialog wird angezeigt |
| 3 | 3. Loeschen bestaetigen | Nachricht wird aus der Liste entfernt |
| 4 | 4. Versuch, die Nachricht ueber Suche oder Direktaufruf zu oeffnen | Nachricht ist nicht abrufbar |

**Final Expected Result:** Die Nachricht ist fuer den Nutzer geloescht und nicht mehr in der Liste oder abrufbar.

---

### TC-1060: RTL chat rendering of punctuation-only and numeric-only messages (boundary)

**Type:** functional
**Priority:** low
**Status:** manual
**User Story:** US-124
**Requirement:** WA-LOC-001

**Description:** Verify correct direction and readability for messages containing only punctuation or numbers.

**Preconditions:**
- System language is set to Arabic
- User is logged in
- Chat screen is accessible

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open a chat conversation | Chat conversation is displayed |
| 2 | 2. Send message: "!!!" | Message appears in the chat |
| 3 | 3. Send message: "123456" | Message appears in the chat |
| 4 | 4. Verify directionality and placement | Punctuation and numbers are displayed in a readable order without misplacement |

**Final Expected Result:** Punctuation-only and numeric-only messages render correctly in RTL chat.

---

### TC-1061: Switch language from English to Arabic and refresh layout

**Type:** integration
**Priority:** medium
**Status:** manual
**User Story:** US-124
**Requirement:** WA-LOC-001

**Description:** Validate that switching system language to Arabic updates UI to RTL on next load.

**Preconditions:**
- System language is set to English
- User is logged in

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the main interface | UI is in LTR |
| 2 | 2. Change system language to Arabic | System language updates to Arabic |
| 3 | 3. Refresh or relaunch the application | Main interface reloads |
| 4 | 4. Verify layout direction and alignment | UI switches to RTL with right alignment |

**Final Expected Result:** After switching to Arabic and reload, the UI renders RTL correctly.

---

### TC-1062: DE-Region format display for date, time, and amount

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-125
**Requirement:** WA-LOC-002

**Description:** Verify German regional formats are applied for date, time, and numeric values.

**Preconditions:**
- Application is installed and opened
- Device region is set to Germany
- A message exists with date, time, and amount fields

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to the message view containing date, time, and amount. | Message view is displayed with date, time, and amount fields visible. |
| 2 | 2. Observe the date format in the message. | Date is displayed as TT.MM.JJJJ. |
| 3 | 3. Observe the time format in the message. | Time is displayed in 24-hour format. |
| 4 | 4. Observe the amount format in the message. | Decimal separator is ',' (e.g., 1.234,56). |

**Final Expected Result:** All formats match German regional settings.

---

### TC-1063: US-Region format display for date, time, and amount

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-125
**Requirement:** WA-LOC-002

**Description:** Verify US regional formats are applied when device region is set to USA.

**Preconditions:**
- Application is installed and opened
- Device region is set to USA
- A message exists with date, time, and amount fields

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to the message view containing date, time, and amount. | Message view is displayed with date, time, and amount fields visible. |
| 2 | 2. Observe the date format in the message. | Date is displayed as MM/DD/YYYY. |
| 3 | 3. Observe the time format in the message. | Time is displayed in 12-hour format with AM/PM. |
| 4 | 4. Observe the amount format in the message. | Decimal separator is '.' (e.g., 1,234.56). |

**Final Expected Result:** All formats match US regional settings.

---

### TC-1064: Unsupported region fallback to default format with info message

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-125
**Requirement:** WA-LOC-002

**Description:** Verify fallback formatting and region info for unsupported device region.

**Preconditions:**
- Application is installed and opened
- Device region is set to an unsupported region (e.g., ZZ)
- A message exists with date, time, and amount fields
- Defined default format is documented

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to the message view containing date, time, and amount. | Message view is displayed with date, time, and amount fields visible. |
| 2 | 2. Observe the date, time, and amount formats. | Formats match the defined default format. |
| 3 | 3. Check for region information message or indicator. | An information message indicates the default region/format used. |

**Final Expected Result:** Default formatting is applied and region info is shown.

---

### TC-1065: Dynamic update when switching region from Germany to USA

**Type:** integration
**Priority:** high
**Status:** manual
**User Story:** US-125
**Requirement:** WA-LOC-002

**Description:** Verify formats update after device region change while app is open.

**Preconditions:**
- Application is opened and running
- Device region is set to Germany
- A message exists with date, time, and amount fields

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the message view and verify German formats are shown. | Date, time, and amount are shown in German formats. |
| 2 | 2. Change device region to USA while the app remains open. | Device region updates to USA. |
| 3 | 3. Return to or refresh the message view. | Formats update to US formats. |

**Final Expected Result:** Formats dynamically reflect the new region settings.

---

### TC-1066: Boundary date value formatting (Germany)

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-125
**Requirement:** WA-LOC-002

**Description:** Verify edge date values are correctly formatted for Germany.

**Preconditions:**
- Device region is set to Germany
- Message contains date value 01.01.1970 and 31.12.2099

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to the message containing boundary date values. | Message view is displayed. |
| 2 | 2. Observe the boundary date values. | Dates are displayed as 01.01.1970 and 31.12.2099 in TT.MM.JJJJ format. |

**Final Expected Result:** Boundary date values are formatted correctly for Germany.

---

### TC-1067: Boundary time values formatting (USA)

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-125
**Requirement:** WA-LOC-002

**Description:** Verify edge time values are correctly formatted for USA.

**Preconditions:**
- Device region is set to USA
- Message contains time values 12:00 AM and 11:59 PM

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to the message containing boundary time values. | Message view is displayed. |
| 2 | 2. Observe the boundary time values. | Times are displayed as 12:00 AM and 11:59 PM in 12-hour format. |

**Final Expected Result:** Boundary time values are formatted correctly for USA.

---

### TC-1068: Negative: Unsupported region without fallback info

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-125
**Requirement:** WA-LOC-002

**Description:** Ensure system does not omit region info when region is unsupported.

**Preconditions:**
- Device region is set to unsupported region
- Message exists with date, time, and amount
- Defined default format is documented

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the message view. | Message view is displayed. |
| 2 | 2. Verify default format is applied. | Date, time, and amount match the defined default format. |
| 3 | 3. Check for region info message. | Region info message is present and not missing. |

**Final Expected Result:** Default format is used and region info is always shown.

---

### TC-1069: Negative: Incorrect decimal separator for Germany

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-125
**Requirement:** WA-LOC-002

**Description:** Ensure numeric values do not use '.' as decimal separator in Germany.

**Preconditions:**
- Device region is set to Germany
- Message exists with amount containing decimals

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the message view and locate the amount field. | Amount field is visible. |
| 2 | 2. Verify the decimal separator. | Decimal separator is ',' and not '.'. |

**Final Expected Result:** German decimal separator is correctly applied.

---

### TC-107: Loeschen empfangener Nachricht aus Nachrichtenliste

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-013
**Requirement:** WA-MSG-003

**Description:** Verifiziert, dass eine empfangene Nachricht nach bestaetigtem Loeschen aus der Liste entfernt wird und nicht mehr abrufbar ist.

**Preconditions:**
- Nutzer ist angemeldet
- Nachrichtenliste ist sichtbar
- Mindestens eine empfangene Nachricht existiert

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Empfangene Nachricht in der Liste auswaehlen | Nachricht wird als ausgewaehlt markiert und Details sind sichtbar |
| 2 | 2. Loeschaktion ausloesen (z. B. Loeschen-Button) | Bestaetigungsdialog wird angezeigt |
| 3 | 3. Loeschen bestaetigen | Nachricht wird aus der Liste entfernt |
| 4 | 4. Versuch, die Nachricht ueber Suche oder Direktaufruf zu oeffnen | Nachricht ist nicht abrufbar |

**Final Expected Result:** Die Nachricht ist fuer den Nutzer geloescht und nicht mehr in der Liste oder abrufbar.

---

### TC-1070: Negative: Incorrect time format for USA

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-125
**Requirement:** WA-LOC-002

**Description:** Ensure time is not displayed in 24-hour format for USA region.

**Preconditions:**
- Device region is set to USA
- Message exists with time field

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the message view and locate the time field. | Time field is visible. |
| 2 | 2. Verify the time format includes AM/PM. | Time is displayed with AM/PM and not in 24-hour format. |

**Final Expected Result:** US time format is correctly applied.

---

### TC-1071: Performance: Format rendering time after region switch

**Type:** performance
**Priority:** low
**Status:** manual
**User Story:** US-125
**Requirement:** WA-LOC-002

**Description:** Ensure format rendering remains responsive after changing region.

**Preconditions:**
- Application is opened
- Message view with date, time, and amount exists

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Measure time to display formatted fields before region change. | Baseline rendering time is recorded. |
| 2 | 2. Change device region (e.g., Germany to USA) and return to the message view. | Formats update without noticeable delay. |
| 3 | 3. Measure time to display formatted fields after region change. | Rendering time remains within acceptable threshold. |

**Final Expected Result:** Formatting is rendered within acceptable performance limits after region switch.

---

### TC-1072: Regionale Sticker-Packs werden anhand Sprache/Region angezeigt

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-126
**Requirement:** WA-LOC-003

**Description:** Prüft, dass passende regionalspezifische Sticker-Packs in der Übersicht angezeigt und auswählbar sind.

**Preconditions:**
- User is logged in
- Sprache/Region ist auf Region mit verfügbaren lokalen Packs gesetzt
- Sticker-Server ist erreichbar

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Öffne den Sticker-Bereich | Sticker-Bereich wird geladen |
| 2 | 2. Rufe die Sticker-Pack-Übersicht auf | Übersicht wird angezeigt |
| 3 | 3. Prüfe die angezeigten Sticker-Packs | Regionalspezifische Sticker-Packs werden angezeigt |
| 4 | 4. Wähle ein regionalspezifisches Pack aus | Pack wird ausgewählt und Sticker werden angezeigt |

**Final Expected Result:** Passende regionale Sticker-Packs sind sichtbar und auswählbar.

---

### TC-1073: Keine lokalen Packs verfügbar – Standardauswahl und Hinweis

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-126
**Requirement:** WA-LOC-003

**Description:** Prüft, dass bei fehlenden lokalen Packs eine neutrale Standardauswahl und Hinweis angezeigt wird.

**Preconditions:**
- User is logged in
- Sprache/Region ist auf Region ohne verfügbare lokale Packs gesetzt
- Sticker-Server ist erreichbar

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Öffne den Sticker-Bereich | Sticker-Bereich wird geladen |
| 2 | 2. Rufe die Sticker-Pack-Übersicht auf | Übersicht wird angezeigt |
| 3 | 3. Prüfe die angezeigten Sticker-Packs und Hinweise | Neutrale Standardauswahl wird angezeigt und Hinweis erscheint, dass keine lokalen Packs verfügbar sind |

**Final Expected Result:** Standardauswahl und Hinweis werden korrekt angezeigt.

---

### TC-1074: Sticker-Server nicht erreichbar – Fehlermeldung und Fallback

**Type:** integration
**Priority:** high
**Status:** manual
**User Story:** US-126
**Requirement:** WA-LOC-003

**Description:** Prüft Fehlermeldung und Anzeige zwischengespeicherter/Standard-Sticker bei Serverausfall.

**Preconditions:**
- User is logged in
- Sprache/Region ist auf Region mit verfügbaren lokalen Packs gesetzt
- Sticker-Server ist nicht erreichbar
- Es existieren zwischengespeicherte Sticker oder Standard-Sticker

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Öffne den Sticker-Bereich | Sticker-Bereich wird geladen |
| 2 | 2. Versuche ein regionalspezifisches Sticker-Pack zu laden | Fehlermeldung wird angezeigt |
| 3 | 3. Prüfe angezeigte Sticker nach dem Fehler | Zwischengespeicherte oder Standard-Sticker werden angezeigt |

**Final Expected Result:** Fehlermeldung erscheint und Fallback-Sticker werden angeboten.

---

### TC-1075: Regionserkennung anhand Sprache/Region-Einstellungen

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-126
**Requirement:** WA-LOC-003

**Description:** Validiert, dass die Regionserkennung korrekt auf die Anzeige regionaler Packs wirkt.

**Preconditions:**
- User is logged in
- Sticker-Server ist erreichbar

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Setze Sprache/Region auf Region A mit lokalen Packs | Einstellungen gespeichert |
| 2 | 2. Öffne Sticker-Pack-Übersicht | Region A Packs werden angezeigt |
| 3 | 3. Ändere Sprache/Region auf Region B ohne lokale Packs | Einstellungen gespeichert |
| 4 | 4. Öffne Sticker-Pack-Übersicht erneut | Standardauswahl und Hinweis werden angezeigt |

**Final Expected Result:** Sticker-Packs ändern sich entsprechend der Regionseinstellung.

---

### TC-1076: Cache-Fallback bei Serverausfall ohne Cache

**Type:** integration
**Priority:** medium
**Status:** manual
**User Story:** US-126
**Requirement:** WA-LOC-003

**Description:** Negativer Test: Prüft Verhalten, wenn Server ausfällt und keine Cache-Daten vorhanden sind.

**Preconditions:**
- User is logged in
- Sticker-Server ist nicht erreichbar
- Kein Cache für Sticker vorhanden

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Öffne den Sticker-Bereich | Sticker-Bereich wird geladen |
| 2 | 2. Versuche Sticker-Pack-Übersicht aufzurufen | Fehlermeldung wird angezeigt |
| 3 | 3. Prüfe die angebotenen Sticker nach dem Fehler | Standard-Sticker werden angezeigt oder es wird ein klarer Hinweis auf fehlende Inhalte angezeigt |

**Final Expected Result:** Fehlermeldung erscheint und das System bietet einen nachvollziehbaren Fallback.

---

### TC-1077: Grenzfall: Region mit genau einem lokalen Pack

**Type:** functional
**Priority:** low
**Status:** manual
**User Story:** US-126
**Requirement:** WA-LOC-003

**Description:** Prüft, dass auch bei minimaler Anzahl regionaler Packs die Anzeige korrekt ist.

**Preconditions:**
- User is logged in
- Sprache/Region ist auf Region mit genau einem lokalen Pack gesetzt
- Sticker-Server ist erreichbar

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Öffne den Sticker-Bereich | Sticker-Bereich wird geladen |
| 2 | 2. Rufe die Sticker-Pack-Übersicht auf | Übersicht wird angezeigt |
| 3 | 3. Prüfe die Anzahl der regionalen Packs | Genau ein regionales Pack wird angezeigt und ist auswählbar |

**Final Expected Result:** Einzelnes regionales Pack wird korrekt angezeigt.

---

### TC-1078: E2E: Auswahl regionales Pack und Sticker in Nachricht verwenden

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-126
**Requirement:** WA-LOC-003

**Description:** End-to-End-Prüfung vom Öffnen der Übersicht bis zum Verwenden eines regionalen Stickers in einer Nachricht.

**Preconditions:**
- User is logged in
- Sprache/Region ist auf Region mit lokalen Packs gesetzt
- Sticker-Server ist erreichbar
- Nachrichtenkonversation ist vorhanden

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Öffne eine Nachrichtenkonversation | Konversation wird angezeigt |
| 2 | 2. Öffne den Sticker-Bereich | Sticker-Bereich wird geladen |
| 3 | 3. Wähle ein regionalspezifisches Sticker-Pack | Sticker des Packs werden angezeigt |
| 4 | 4. Tippe auf einen Sticker zum Senden | Sticker wird in der Konversation gesendet und angezeigt |

**Final Expected Result:** Regionaler Sticker kann erfolgreich ausgewählt und gesendet werden.

---

### TC-1079: Verify Passkey-Unterstuetzung

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-005
**Requirement:** WA-AUTH-005

**Description:** Stub test case for US-005

**Preconditions:**
- Endnutzer is authenticated

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | Endnutzer is on the relevant page |  |
| 2 | Endnutzer sich passwortlos per Passkey anmelden |  |
| 3 | damit die Anmeldung sicherer und schneller erfolgt und die Nutzung plattformuebergreifend bequem bleibt is verified |  |

**Final Expected Result:** damit die Anmeldung sicherer und schneller erfolgt und die Nutzung plattformuebergreifend bequem bleibt

---

### TC-108: Abbruch des Loeschens im Bestaetigungsdialog

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-013
**Requirement:** WA-MSG-003

**Description:** Verifiziert, dass das Abbrechen der Loeschaktion keine Aenderungen an der Nachrichtenliste bewirkt.

**Preconditions:**
- Nutzer ist angemeldet
- Nachrichtenliste ist sichtbar
- Mindestens eine Nachricht existiert

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Nachricht in der Liste auswaehlen | Nachricht wird als ausgewaehlt markiert und Details sind sichtbar |
| 2 | 2. Loeschaktion ausloesen | Bestaetigungsdialog wird angezeigt |
| 3 | 3. Abbrechen auswaehlen | Dialog schliesst sich, Nachricht bleibt in der Liste |

**Final Expected Result:** Keine Nachricht wurde geloescht.

---

### TC-1080: Verify Profilbild

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-006
**Requirement:** WA-PROF-001

**Description:** Stub test case for US-006

**Preconditions:**
- primaerer Nutzer is authenticated

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | primaerer Nutzer is on the relevant page |  |
| 2 | primaerer Nutzer ein Profilbild hochladen und verwalten |  |
| 3 | mein Profil persoenlich gestalten und vertrauenswuerdig auftreten zu koennen is verified |  |

**Final Expected Result:** mein Profil persoenlich gestalten und vertrauenswuerdig auftreten zu koennen

---

### TC-1081: Verify Anzeigename

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-007
**Requirement:** WA-PROF-002

**Description:** Stub test case for US-007

**Preconditions:**
- Business-Nutzer is authenticated

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | Business-Nutzer is on the relevant page |  |
| 2 | Business-Nutzer einen konfigurierbaren Anzeigenamen für mein Profil festlegen und aktualisieren |  |
| 3 | damit ich professionell kommuniziere und meine Identität klar erkennbar ist is verified |  |

**Final Expected Result:** damit ich professionell kommuniziere und meine Identität klar erkennbar ist

---

### TC-1082: Verify Info/Status Text

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-008
**Requirement:** WA-PROF-003

**Description:** Stub test case for US-008

**Preconditions:**
- Business-Profil-Nutzer is authenticated

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | Business-Profil-Nutzer is on the relevant page |  |
| 2 | Business-Profil-Nutzer einen kurzen Info-/Status-Text im Profil eingeben und aktualisieren |  |
| 3 | damit Kunden schnell aktuelle Informationen erhalten und die Kommunikation professionell wirkt is verified |  |

**Final Expected Result:** damit Kunden schnell aktuelle Informationen erhalten und die Kommunikation professionell wirkt

---

### TC-1083: Verify Telefonnummer anzeigen

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-009
**Requirement:** WA-PROF-004

**Description:** Stub test case for US-009

**Preconditions:**
- Endnutzer is authenticated

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | Endnutzer is on the relevant page |  |
| 2 | Endnutzer die Telefonnummer im Profil anzeigen lassen |  |
| 3 | die Kontaktaufnahme zu erleichtern und eine zuverlaessige Kommunikation zu ermoeglichen is verified |  |

**Final Expected Result:** die Kontaktaufnahme zu erleichtern und eine zuverlaessige Kommunikation zu ermoeglichen

---

### TC-1084: Verify QR-Code Profil

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-010
**Requirement:** WA-PROF-005

**Description:** Stub test case for US-010

**Preconditions:**
- Business-Profilinhaber is authenticated

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | Business-Profilinhaber is on the relevant page |  |
| 2 | Business-Profilinhaber einen scanbaren QR-Code für mein Profil generieren und anzeigen |  |
| 3 | damit Kunden mich schnell und plattformübergreifend hinzufügen können is verified |  |

**Final Expected Result:** damit Kunden mich schnell und plattformübergreifend hinzufügen können

---

### TC-1085: Verify Textnachricht senden

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-011
**Requirement:** WA-MSG-001

**Description:** Stub test case for US-011

**Preconditions:**
- registrierter Nutzer is authenticated

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | registrierter Nutzer is on the relevant page |  |
| 2 | registrierter Nutzer eine Textnachricht in Echtzeit senden |  |
| 3 | um schnell und zuverlässig mit Kontakten zu kommunizieren is verified |  |

**Final Expected Result:** um schnell und zuverlässig mit Kontakten zu kommunizieren

---

### TC-1086: Verify Sprachnachricht

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-012
**Requirement:** WA-MSG-002

**Description:** Stub test case for US-012

**Preconditions:**
- registrierter Endnutzer is authenticated

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | registrierter Endnutzer is on the relevant page |  |
| 2 | registrierter Endnutzer eine Sprachnachricht aufnehmen und senden |  |
| 3 | schnell und intuitiv kommunizieren, auch wenn Tippen unpraktisch ist is verified |  |

**Final Expected Result:** schnell und intuitiv kommunizieren, auch wenn Tippen unpraktisch ist

---

### TC-1087: Verify Nachricht loeschen

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-013
**Requirement:** WA-MSG-003

**Description:** Stub test case for US-013

**Preconditions:**
- registrierter Nutzer is authenticated

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | registrierter Nutzer is on the relevant page |  |
| 2 | registrierter Nutzer eine gesendete oder empfangene Nachricht loeschen |  |
| 3 | um Datenschutz zu wahren und die Unterhaltung uebersichtlich zu halten is verified |  |

**Final Expected Result:** um Datenschutz zu wahren und die Unterhaltung uebersichtlich zu halten

---

### TC-1088: Verify Nachricht bearbeiten

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-014
**Requirement:** WA-MSG-004

**Description:** Stub test case for US-014

**Preconditions:**
- registrierter Nutzer is authenticated

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | registrierter Nutzer is on the relevant page |  |
| 2 | registrierter Nutzer eine gesendete Nachricht bearbeiten |  |
| 3 | Fehler zu korrigieren und die Kommunikation professionell und zuverlässig zu halten is verified |  |

**Final Expected Result:** Fehler zu korrigieren und die Kommunikation professionell und zuverlässig zu halten

---

### TC-1089: Verify Nachricht weiterleiten

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-015
**Requirement:** WA-MSG-005

**Description:** Stub test case for US-015

**Preconditions:**
- registrierter Nutzer is authenticated

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | registrierter Nutzer is on the relevant page |  |
| 2 | registrierter Nutzer eine erhaltene Nachricht an einen anderen Kontakt weiterleiten |  |
| 3 | damit ich Informationen schnell teilen und die Kommunikation effizienter gestalten kann is verified |  |

**Final Expected Result:** damit ich Informationen schnell teilen und die Kommunikation effizienter gestalten kann

---

### TC-109: Loeschen einer bereits geloeschten Nachricht

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-013
**Requirement:** WA-MSG-003

**Description:** Verifiziert, dass das System bei einer Loeschaktion fuer eine nicht mehr existierende Nachricht eine Hinweis-Meldung anzeigt und keine Aenderung vornimmt.

**Preconditions:**
- Nutzer ist angemeldet
- Nachricht wurde zuvor geloescht oder existiert nicht mehr

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Loeschaktion fuer die nicht mehr existierende Nachricht ausloesen (z. B. ueber veralteten Link) | System verarbeitet die Anfrage |
| 2 | 2. Hinweis-Meldung beobachten | Meldung erscheint: Nachricht nicht gefunden |

**Final Expected Result:** System zeigt Hinweis-Meldung und nimmt keine Aenderungen vor.

---

### TC-1090: Verify Nachricht zitieren

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-016
**Requirement:** WA-MSG-006

**Description:** Stub test case for US-016

**Preconditions:**
- Endnutzer is authenticated

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | Endnutzer is on the relevant page |  |
| 2 | Endnutzer eine spezifische Nachricht in einem Chat zitieren und darauf antworten |  |
| 3 | damit der Kontext der Kommunikation klar bleibt und die Bedienung intuitiv ist is verified |  |

**Final Expected Result:** damit der Kontext der Kommunikation klar bleibt und die Bedienung intuitiv ist

---

### TC-1091: Verify Reaktionen

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-017
**Requirement:** WA-MSG-007

**Description:** Stub test case for US-017

**Preconditions:**
- Endnutzer is authenticated

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | Endnutzer is on the relevant page |  |
| 2 | Endnutzer eine Emoji-Reaktion zu einer Nachricht hinzufügen |  |
| 3 | um schnell und intuitiv auf Nachrichten zu reagieren und die Kommunikation effizienter zu gestalten is verified |  |

**Final Expected Result:** um schnell und intuitiv auf Nachrichten zu reagieren und die Kommunikation effizienter zu gestalten

---

### TC-1092: Verify Verschwindende Nachrichten

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-018
**Requirement:** WA-MSG-008

**Description:** Stub test case for US-018

**Preconditions:**
- registrierter Nutzer is authenticated

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | registrierter Nutzer is on the relevant page |  |
| 2 | registrierter Nutzer selbstlöschende Nachrichten senden und einen Ablaufzeitpunkt festlegen |  |
| 3 | damit sensible Inhalte automatisch verschwinden und Datenschutz sowie Sicherheit verbessert werden is verified |  |

**Final Expected Result:** damit sensible Inhalte automatisch verschwinden und Datenschutz sowie Sicherheit verbessert werden

---

### TC-1093: Verify Einmal-Ansicht Medien

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-019
**Requirement:** WA-MSG-009

**Description:** Stub test case for US-019

**Preconditions:**
- Endnutzer is authenticated

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | Endnutzer is on the relevant page |  |
| 2 | Endnutzer View-Once-Medien einmalig anzeigen |  |
| 3 | um Datenschutz und Kontrolle über sensible Inhalte sicherzustellen is verified |  |

**Final Expected Result:** um Datenschutz und Kontrolle über sensible Inhalte sicherzustellen

---

### TC-1094: Verify Chat sperren

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-020
**Requirement:** WA-MSG-010

**Description:** Stub test case for US-020

**Preconditions:**
- registrierter Nutzer is authenticated

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | registrierter Nutzer is on the relevant page |  |
| 2 | registrierter Nutzer einen einzelnen Chat mit zusaetzlicher Authentifizierung sperren |  |
| 3 | um meine Privatsphaere zu schuetzen und unbefugten Zugriff auf vertrauliche Konversationen zu verhindern is verified |  |

**Final Expected Result:** um meine Privatsphaere zu schuetzen und unbefugten Zugriff auf vertrauliche Konversationen zu verhindern

---

### TC-110: Unberechtigtes Loeschen einer Nachricht

**Type:** integration
**Priority:** high
**Status:** manual
**User Story:** US-013
**Requirement:** WA-MSG-003

**Description:** Verifiziert, dass das System eine Loeschaktion fuer eine Nachricht verweigert, die dem Nutzer nicht gehoert, und den Vorfall protokolliert.

**Preconditions:**
- Nutzer ist angemeldet
- Nachricht gehoert einem anderen Nutzer
- Audit-Logging ist aktiviert

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Loeschaktion fuer eine fremde Nachricht ausloesen | System prueft Berechtigungen |
| 2 | 2. Fehlermeldung anzeigen lassen | Klare Fehlermeldung zur fehlenden Berechtigung wird angezeigt |
| 3 | 3. Audit-Log pruefen | Vorfall ist im Log mit Nutzer-ID und Nachricht-ID protokolliert |

**Final Expected Result:** Loeschaktion wird verweigert, Fehlermeldung angezeigt und Vorfall protokolliert.

---

### TC-111: Grenzfall: Loeschen der letzten Nachricht in der Liste

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-013
**Requirement:** WA-MSG-003

**Description:** Verifiziert, dass die Liste korrekt aktualisiert wird, wenn die letzte verbleibende Nachricht geloescht wird.

**Preconditions:**
- Nutzer ist angemeldet
- Nachrichtenliste enthaelt genau eine Nachricht

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Einzige Nachricht auswaehlen | Nachricht wird als ausgewaehlt markiert und Details sind sichtbar |
| 2 | 2. Loeschaktion ausloesen und bestaetigen | Nachricht wird geloescht |
| 3 | 3. Nachrichtenliste anzeigen | Liste ist leer und zeigt ggf. einen Leerzustand |

**Final Expected Result:** Die Nachrichtenliste ist leer und der Leerzustand wird korrekt angezeigt.

---

### TC-112: E2E: Loeschen aus Nachrichtenliste und Persistenz nach Seitenreload

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-013
**Requirement:** WA-MSG-003

**Description:** Verifiziert, dass eine geloeschte Nachricht nach Seitenreload nicht wieder erscheint.

**Preconditions:**
- Nutzer ist angemeldet
- Nachrichtenliste enthaelt mehrere Nachrichten

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Nachricht auswaehlen und Loeschung bestaetigen | Nachricht wird aus der Liste entfernt |
| 2 | 2. Seite neu laden | Nachrichtenliste wird neu geladen |
| 3 | 3. Pruefen, ob die geloeschte Nachricht vorhanden ist | Geloeschte Nachricht erscheint nicht mehr |

**Final Expected Result:** Geloeschte Nachricht bleibt nach Reload entfernt.

---

### TC-113: Fehlermeldung bei Loeschversuch ohne Anmeldung

**Type:** integration
**Priority:** medium
**Status:** manual
**User Story:** US-013
**Requirement:** WA-MSG-003

**Description:** Verifiziert, dass eine Loeschaktion ohne gueltige Sitzung nicht durchgefuehrt wird.

**Preconditions:**
- Nutzer ist abgemeldet oder Sitzung ist abgelaufen

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Loeschaktion fuer eine Nachricht ausloesen | System erkennt fehlende Authentifizierung |
| 2 | 2. Fehlermeldung oder Redirect zur Anmeldung pruefen | Klare Meldung erscheint oder Nutzer wird zur Anmeldung weitergeleitet |

**Final Expected Result:** Loeschaktion wird nicht ausgefuehrt ohne gueltige Anmeldung.

---

### TC-114: Edit sent message within allowed time window

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-014
**Requirement:** WA-MSG-004

**Description:** Verify that a user can edit a sent message within the allowed edit window and changes are visible to all recipients

**Preconditions:**
- User is logged in
- User has previously sent a message to one or more recipients
- Message timestamp is within the allowed edit time window

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to the conversation containing the sent message | The conversation view loads and the sent message is visible |
| 2 | 2. Open the context menu for the sent message | Context menu shows an option to edit |
| 3 | 3. Select the edit option | Edit dialog opens with the current message text populated |
| 4 | 4. Modify the message text and click Save | Save action is accepted without error |
| 5 | 5. Verify the message content in the conversation view | The message displays the updated text and an edited indicator if applicable |
| 6 | 6. Verify from a recipient account or session | Recipients see the updated message content |

**Final Expected Result:** Message is updated successfully and visible to all recipients

---

### TC-115: Attempt to edit sent message outside allowed time window

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-014
**Requirement:** WA-MSG-004

**Description:** Verify that editing is prevented when the edit time window has expired

**Preconditions:**
- User is logged in
- User has previously sent a message
- Message timestamp is outside the allowed edit time window

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to the conversation containing the sent message | The conversation view loads and the sent message is visible |
| 2 | 2. Open the context menu for the sent message | Edit option is not available or is disabled |
| 3 | 3. If edit option is available, attempt to select it | Editing is prevented and a notice indicates the edit window has expired |

**Final Expected Result:** User cannot edit and receives a clear expiry notice

---

### TC-116: Handle network failure during message edit save

**Type:** integration
**Priority:** high
**Status:** manual
**User Story:** US-014
**Requirement:** WA-MSG-004

**Description:** Verify that a failed network save leaves the original message unchanged and displays an error

**Preconditions:**
- User is logged in
- User has previously sent a message within allowed edit time window
- Network can be simulated as unstable or request can be forced to fail

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to the conversation containing the sent message | The sent message is visible |
| 2 | 2. Open the edit dialog and modify the message text | Edit dialog shows modified text |
| 3 | 3. Simulate network failure and click Save | Save request fails and an error message is displayed |
| 4 | 4. Observe the message in the conversation view | Original message content remains unchanged |

**Final Expected Result:** Original message is preserved and a clear error is shown on failure

---

### TC-117: Boundary: Edit message exactly at the allowed time limit

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-014
**Requirement:** WA-MSG-004

**Description:** Verify that editing is allowed when the message is at the exact boundary of the edit window

**Preconditions:**
- User is logged in
- User has a sent message timestamped exactly at the edit window limit

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to the conversation containing the boundary-time message | The sent message is visible |
| 2 | 2. Open the edit dialog for the message | Edit dialog opens successfully |
| 3 | 3. Modify the text and click Save | Save succeeds without error |
| 4 | 4. Verify the updated message in conversation view | Updated text is displayed |

**Final Expected Result:** Editing is permitted at the exact time boundary and updates are visible

---

### TC-118: Boundary: Edit message just after the allowed time limit

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-014
**Requirement:** WA-MSG-004

**Description:** Verify that editing is blocked when the message is just past the edit window

**Preconditions:**
- User is logged in
- User has a sent message timestamped just past the edit window limit

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to the conversation containing the boundary-past message | The sent message is visible |
| 2 | 2. Attempt to open edit dialog | Edit option is unavailable or blocked |
| 3 | 3. If edit action is attempted via direct link or shortcut | System blocks edit and shows expiry notice |

**Final Expected Result:** Editing is not allowed once the time window has expired

---

### TC-119: Cancel edit without saving

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-014
**Requirement:** WA-MSG-004

**Description:** Verify that canceling edit leaves the message unchanged

**Preconditions:**
- User is logged in
- User has a sent message within allowed edit time window

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the edit dialog for the sent message | Edit dialog opens with the current text |
| 2 | 2. Modify the message text | Modified text is shown in the edit dialog |
| 3 | 3. Click Cancel or close the dialog | Dialog closes without saving |
| 4 | 4. Verify the message content in the conversation view | Original text remains unchanged |

**Final Expected Result:** Message remains unchanged when edit is canceled

---

### TC-120: Attempt to save empty message content

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-014
**Requirement:** WA-MSG-004

**Description:** Verify validation prevents saving an empty message during edit

**Preconditions:**
- User is logged in
- User has a sent message within allowed edit time window
- System requires non-empty message content

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the edit dialog for the sent message | Edit dialog opens with current text |
| 2 | 2. Remove all text from the message | Message field is empty |
| 3 | 3. Click Save | Validation error is displayed and save is blocked |
| 4 | 4. Verify message content in conversation view | Original message remains unchanged |

**Final Expected Result:** Empty content is not saved and user is notified

---

### TC-121: Weiterleiten an einen Empfänger

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-015
**Requirement:** WA-MSG-005

**Description:** Prüft, dass eine erhaltene Nachricht an einen einzelnen Empfänger weitergeleitet wird

**Preconditions:**
- Nutzer ist in der App angemeldet
- Nutzer hat eine erhaltene Nachricht im Posteingang
- Empfänger ist ein gültiger Kontakt

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Nachricht im Posteingang auswählen | Nachrichtendetails werden angezeigt |
| 2 | 2. Aktion „Weiterleiten“ wählen | Weiterleitungsdialog wird angezeigt |
| 3 | 3. Einen Empfänger auswählen | Empfänger erscheint in der Empfängerliste |
| 4 | 4. Weiterleitung bestätigen | System zeigt Bestätigung oder Senden-Status |

**Final Expected Result:** Nachricht wird zuverlässig an den ausgewählten Empfänger zugestellt

---

### TC-122: Weiterleiten an mehrere Empfänger

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-015
**Requirement:** WA-MSG-005

**Description:** Prüft, dass eine Nachricht an mehrere Empfänger weitergeleitet wird

**Preconditions:**
- Nutzer ist in der App angemeldet
- Nutzer hat eine erhaltene Nachricht im Posteingang
- Mehrere gültige Kontakte sind verfügbar

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Nachricht im Posteingang auswählen | Nachrichtendetails werden angezeigt |
| 2 | 2. Aktion „Weiterleiten“ wählen | Weiterleitungsdialog wird angezeigt |
| 3 | 3. Mehrere Empfänger auswählen | Alle Empfänger erscheinen in der Empfängerliste |
| 4 | 4. Weiterleitung bestätigen | System zeigt Bestätigung oder Senden-Status |

**Final Expected Result:** Nachricht wird zuverlässig an alle ausgewählten Empfänger zugestellt

---

### TC-123: Weiterleiten ohne Empfänger

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-015
**Requirement:** WA-MSG-005

**Description:** Prüft, dass die Weiterleitung ohne Empfänger blockiert wird

**Preconditions:**
- Nutzer ist in der App angemeldet
- Nutzer hat eine erhaltene Nachricht im Posteingang

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Nachricht im Posteingang auswählen | Nachrichtendetails werden angezeigt |
| 2 | 2. Aktion „Weiterleiten“ wählen | Weiterleitungsdialog wird angezeigt |
| 3 | 3. Empfängerauswahl leer lassen | Keine Empfänger sind ausgewählt |
| 4 | 4. Weiterleitung bestätigen | Hinweis wird angezeigt, dass mindestens ein Empfänger erforderlich ist |

**Final Expected Result:** Weiterleitung wird nicht ausgeführt und der Nutzer erhält einen Hinweis

---

### TC-124: Weiterleiten bei fehlender Berechtigung

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-015
**Requirement:** WA-MSG-005

**Description:** Prüft, dass die Weiterleitung bei fehlender Berechtigung blockiert wird

**Preconditions:**
- Nutzer ist in der App angemeldet
- Nutzer hat eine Nachricht ausgewählt
- Weiterleitung ist aufgrund Berechtigung/Datenschutzrichtlinie nicht erlaubt

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Nachricht auswählen | Nachrichtendetails werden angezeigt |
| 2 | 2. Aktion „Weiterleiten“ wählen | System prüft Berechtigung |
| 3 | 3. Weiterleitung bestätigen | Fehlermeldung wird angezeigt |

**Final Expected Result:** Weiterleitung wird blockiert und der Nutzer erhält eine verständliche Fehlermeldung

---

### TC-125: Empfänger-Auswahl zurücksetzen und bestätigen

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-015
**Requirement:** WA-MSG-005

**Description:** Prüft, dass das Entfernen aller Empfänger vor dem Bestätigen korrekt erkannt wird

**Preconditions:**
- Nutzer ist in der App angemeldet
- Nutzer hat eine erhaltene Nachricht im Posteingang
- Mindestens ein Kontakt ist verfügbar

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Nachricht auswählen | Nachrichtendetails werden angezeigt |
| 2 | 2. Aktion „Weiterleiten“ wählen | Weiterleitungsdialog wird angezeigt |
| 3 | 3. Einen Empfänger auswählen | Empfänger erscheint in der Empfängerliste |
| 4 | 4. Empfänger wieder entfernen | Empfängerliste ist leer |
| 5 | 5. Weiterleitung bestätigen | Hinweis wird angezeigt, dass mindestens ein Empfänger erforderlich ist |

**Final Expected Result:** Weiterleitung wird nicht ausgeführt und es wird ein Hinweis angezeigt

---

### TC-126: Weiterleiten mit maximaler Empfängeranzahl (Grenzwert)

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-015
**Requirement:** WA-MSG-005

**Description:** Prüft, dass die Weiterleitung bei maximal erlaubter Empfängeranzahl funktioniert

**Preconditions:**
- Nutzer ist in der App angemeldet
- Nutzer hat eine erhaltene Nachricht im Posteingang
- System hat eine definierte maximale Empfängeranzahl
- Genau die maximale Anzahl gültiger Kontakte ist verfügbar

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Nachricht auswählen | Nachrichtendetails werden angezeigt |
| 2 | 2. Aktion „Weiterleiten“ wählen | Weiterleitungsdialog wird angezeigt |
| 3 | 3. Maximale Anzahl Empfänger auswählen | Alle Empfänger erscheinen in der Empfängerliste |
| 4 | 4. Weiterleitung bestätigen | System zeigt Bestätigung oder Senden-Status |

**Final Expected Result:** Nachricht wird an alle Empfänger innerhalb des Grenzwerts zugestellt

---

### TC-127: Weiterleiten über maximaler Empfängeranzahl

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-015
**Requirement:** WA-MSG-005

**Description:** Prüft die Validierung, wenn mehr als die erlaubte Empfängeranzahl gewählt wird

**Preconditions:**
- Nutzer ist in der App angemeldet
- Nutzer hat eine erhaltene Nachricht im Posteingang
- System hat eine definierte maximale Empfängeranzahl
- Mehr als die maximale Anzahl gültiger Kontakte ist verfügbar

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Nachricht auswählen | Nachrichtendetails werden angezeigt |
| 2 | 2. Aktion „Weiterleiten“ wählen | Weiterleitungsdialog wird angezeigt |
| 3 | 3. Mehr als die maximale Anzahl Empfänger auswählen | System verhindert die Auswahl oder zeigt eine Begrenzungswarnung |
| 4 | 4. Weiterleitung bestätigen | Weiterleitung wird blockiert oder auf zulässige Empfänger reduziert |

**Final Expected Result:** System setzt den Empfängergrenzwert durch und informiert den Nutzer

---

### TC-128: Ende-zu-Ende Zustellung der weitergeleiteten Nachricht

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-015
**Requirement:** WA-MSG-005

**Description:** Prüft die tatsächliche Zustellung der weitergeleiteten Nachricht im Posteingang des Empfängers

**Preconditions:**
- Nutzer A ist in der App angemeldet
- Nutzer A hat eine erhaltene Nachricht im Posteingang
- Nutzer B ist ein gültiger Kontakt und erreichbar

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Nutzer A wählt eine Nachricht und startet „Weiterleiten“ | Weiterleitungsdialog wird angezeigt |
| 2 | 2. Nutzer A wählt Nutzer B als Empfänger und bestätigt | System zeigt Senden-Status oder Bestätigung |
| 3 | 3. Nutzer B öffnet seinen Posteingang | Weitergeleitete Nachricht ist sichtbar |

**Final Expected Result:** Nutzer B erhält die weitergeleitete Nachricht korrekt

---

### TC-129: Performance der Weiterleitung an mehrere Empfänger

**Type:** performance
**Priority:** low
**Status:** manual
**User Story:** US-015
**Requirement:** WA-MSG-005

**Description:** Prüft die Antwortzeit beim Weiterleiten an mehrere Empfänger

**Preconditions:**
- Nutzer ist in der App angemeldet
- Nutzer hat eine erhaltene Nachricht im Posteingang
- Mehrere gültige Kontakte sind verfügbar

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Nachricht auswählen | Nachrichtendetails werden angezeigt |
| 2 | 2. Aktion „Weiterleiten“ wählen | Weiterleitungsdialog wird angezeigt |
| 3 | 3. Mehrere Empfänger auswählen und Weiterleitung bestätigen | System startet den Sendevorgang |

**Final Expected Result:** Weiterleitung wird innerhalb der definierten Performance-Schwelle abgeschlossen

---

### TC-130: Quote and reply to an existing message

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-016
**Requirement:** WA-MSG-006

**Description:** Verify user can quote a specific message and send a reply with the quoted text shown

**Preconditions:**
- User is logged in
- User is in a chat with existing messages
- At least one message is visible in the chat

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Select a visible message in the chat | Message action menu is displayed |
| 2 | 2. Choose the 'Zitieren/Antworten' option | Composer shows the selected message as a quote preview |
| 3 | 3. Enter a reply text | Text is entered in the composer without removing the quote |
| 4 | 4. Send the message | New message is sent and displayed with the quoted message attached |

**Final Expected Result:** The reply is sent successfully and contains the correct quoted message.

---

### TC-131: Quote a deleted/unavailable message

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-016
**Requirement:** WA-MSG-006

**Description:** Verify user receives a clear message when trying to quote a deleted message and can still send a normal reply

**Preconditions:**
- User is logged in
- User is in a chat where a message was deleted or is unavailable
- UI still shows an entry or reference to the deleted message (e.g., placeholder)

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Attempt to select the deleted/unavailable message | Message action menu appears or selection is acknowledged |
| 2 | 2. Choose the 'Zitieren/Antworten' option | User sees a clear notification that the message is not available |
| 3 | 3. Enter a reply text in the composer | Composer allows a normal reply without a quote |
| 4 | 4. Send the message | Message is sent as a normal reply without a quote |

**Final Expected Result:** User is informed that the quoted message is unavailable and can send a normal reply.

---

### TC-132: Quote message when chat list is very long

**Type:** performance
**Priority:** medium
**Status:** manual
**User Story:** US-016
**Requirement:** WA-MSG-006

**Description:** Validate quote functionality works in a long message list without UI lag

**Preconditions:**
- User is logged in
- Chat contains a very long list of messages (e.g., 1000+)
- Device and network are within normal operational limits

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Scroll to an older message in the long list | Message is visible and selectable without excessive lag |
| 2 | 2. Select the message and choose 'Zitieren/Antworten' | Quote preview appears within acceptable response time (e.g., < 300 ms) |
| 3 | 3. Send a reply | Message is sent with quote and UI remains responsive |

**Final Expected Result:** Quote action completes quickly and the app remains stable in a long list.

---

### TC-133: Quote message in a high-traffic chat

**Type:** performance
**Priority:** medium
**Status:** manual
**User Story:** US-016
**Requirement:** WA-MSG-006

**Description:** Ensure quoting works when new messages are arriving frequently

**Preconditions:**
- User is logged in
- Chat is receiving frequent new messages (e.g., >10 per minute)

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. While new messages are arriving, select a message | Selected message remains targeted and menu is displayed |
| 2 | 2. Choose 'Zitieren/Antworten' | Quote preview appears correctly and promptly |
| 3 | 3. Send a reply | Reply is sent with the correct quoted message despite incoming traffic |

**Final Expected Result:** Quote functionality is stable and correct under high message throughput.

---

### TC-134: Attempt to quote without selecting a message

**Type:** functional
**Priority:** low
**Status:** manual
**User Story:** US-016
**Requirement:** WA-MSG-006

**Description:** Verify system prevents quoting when no message is selected

**Preconditions:**
- User is logged in
- User is in a chat with existing messages

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open message action menu without selecting a message (if possible) | Quote option is disabled or not shown |
| 2 | 2. Try to trigger quote via shortcut (e.g., keyboard) | System shows a message indicating a message must be selected |

**Final Expected Result:** User cannot initiate quote without selecting a message.

---

### TC-135: Quote message and cancel before sending

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-016
**Requirement:** WA-MSG-006

**Description:** Verify user can remove or cancel a quote before sending a reply

**Preconditions:**
- User is logged in
- User is in a chat with existing messages

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Select a message and choose 'Zitieren/Antworten' | Quote preview appears in the composer |
| 2 | 2. Remove the quote (e.g., click 'X' on quote preview) | Quote preview is removed from the composer |
| 3 | 3. Enter a reply and send | Message is sent as a normal reply without a quote |

**Final Expected Result:** User can cancel quoting and send a normal message.

---

### TC-136: Quote message sent by self

**Type:** functional
**Priority:** low
**Status:** manual
**User Story:** US-016
**Requirement:** WA-MSG-006

**Description:** Verify quoting works for messages authored by the user

**Preconditions:**
- User is logged in
- User is in a chat and has previously sent a message

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Select a message authored by the user | Message action menu is displayed |
| 2 | 2. Choose 'Zitieren/Antworten' | Quote preview shows the user's message correctly |
| 3 | 3. Send the reply | Reply is sent with the quoted message attached |

**Final Expected Result:** User can quote their own messages and send a reply successfully.

---

### TC-137: Quote message with special characters and emojis

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-016
**Requirement:** WA-MSG-006

**Description:** Ensure quoted message preserves formatting and special characters

**Preconditions:**
- User is logged in
- Chat contains a message with special characters/emojis and line breaks

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Select the message containing special characters/emojis | Message action menu is displayed |
| 2 | 2. Choose 'Zitieren/Antworten' | Quote preview shows the message with correct characters and formatting |
| 3 | 3. Send a reply | Sent message displays the quoted content without corruption |

**Final Expected Result:** Quoted messages preserve special characters, emojis, and formatting.

---

### TC-138: Add emoji reaction to a message (happy path)

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-017
**Requirement:** WA-MSG-007

**Description:** Verify that selecting an emoji adds a visible reaction to the message for all participants

**Preconditions:**
- User A is logged in
- User B is logged in on another device/session
- An open conversation exists with at least one message

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. User A opens the conversation containing a message | The message list is visible |
| 2 | 2. User A opens the reaction picker for a message | Emoji picker is displayed |
| 3 | 3. User A selects an emoji (e.g., 😀) | The emoji reaction appears on the message with a count of 1 and marked as reacted by User A |
| 4 | 4. User B views the same conversation | User B sees the same emoji reaction on the message |

**Final Expected Result:** Emoji reaction is displayed on the message for all participants

---

### TC-139: Remove own reaction by selecting same emoji again

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-017
**Requirement:** WA-MSG-007

**Description:** Verify that re-selecting the same emoji removes the user's reaction

**Preconditions:**
- User is logged in
- An open conversation exists with a message already reacted by the user with 😀

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the conversation with the reacted message | The message shows the 😀 reaction highlighted for the user |
| 2 | 2. User selects the same emoji (😀) on the message | The user’s reaction is removed and the count decreases accordingly |

**Final Expected Result:** User’s emoji reaction is removed and UI updates correctly

---

### TC-140: Do not remove reaction when selecting a different emoji

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-017
**Requirement:** WA-MSG-007

**Description:** Verify that selecting a different emoji adds another reaction and does not remove the previous one

**Preconditions:**
- User is logged in
- An open conversation exists with a message already reacted by the user with 😀

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the conversation with the reacted message | The message shows the 😀 reaction highlighted for the user |
| 2 | 2. User selects a different emoji (e.g., 👍) | A new 👍 reaction appears on the message; the 😀 reaction remains |

**Final Expected Result:** Different emoji adds an additional reaction without removing the existing one

---

### TC-141: Reaction send fails on no network

**Type:** integration
**Priority:** high
**Status:** manual
**User Story:** US-017
**Requirement:** WA-MSG-007

**Description:** Verify that a clear error is shown and reaction is not marked as sent when network is unavailable

**Preconditions:**
- User is logged in
- An open conversation exists with at least one message
- Network connectivity is disabled or unstable

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Disable network connectivity | Device shows no network |
| 2 | 2. Attempt to react to a message with an emoji | A clear error message is displayed |
| 3 | 3. Check the message reactions | The reaction is not shown as sent or counted |

**Final Expected Result:** Error is shown and reaction is not marked as sent

---

### TC-142: Recover from unstable network without duplicate reactions

**Type:** integration
**Priority:** medium
**Status:** manual
**User Story:** US-017
**Requirement:** WA-MSG-007

**Description:** Verify that retrying after a network failure does not create duplicate reactions

**Preconditions:**
- User is logged in
- An open conversation exists with at least one message
- Network connectivity can be toggled

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Disable network connectivity | Device shows no network |
| 2 | 2. Attempt to react to a message with an emoji | A clear error message is displayed |
| 3 | 3. Re-enable network connectivity | Network is restored |
| 4 | 4. React to the same message with the same emoji | Reaction is added once with count 1 |

**Final Expected Result:** Reaction is added only once after network is restored

---

### TC-143: Multiple users react with the same emoji

**Type:** e2e
**Priority:** medium
**Status:** manual
**User Story:** US-017
**Requirement:** WA-MSG-007

**Description:** Verify that reaction count reflects multiple participants using the same emoji

**Preconditions:**
- User A and User B are logged in
- An open conversation exists with at least one message

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. User A reacts to a message with 😀 | Message shows 😀 with count 1 |
| 2 | 2. User B reacts to the same message with 😀 | Message shows 😀 with count 2 for both users |

**Final Expected Result:** Reaction count increments correctly for multiple users

---

### TC-144: Toggle reaction when user is the only reactor

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-017
**Requirement:** WA-MSG-007

**Description:** Verify that reaction badge is removed when the only reaction is removed

**Preconditions:**
- User is logged in
- A message exists with only the user's 😀 reaction

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the conversation and view the message | 😀 reaction is shown with count 1 |
| 2 | 2. Select the same emoji (😀) again | The 😀 reaction is removed entirely from the message |

**Final Expected Result:** Reaction badge disappears when count becomes zero

---

### TC-145: Reaction visibility across participants after removal

**Type:** e2e
**Priority:** medium
**Status:** manual
**User Story:** US-017
**Requirement:** WA-MSG-007

**Description:** Verify that reaction removal by user updates for all participants

**Preconditions:**
- User A and User B are logged in
- A message exists with User A's 😀 reaction

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. User A removes their 😀 reaction | Reaction disappears or count decreases for User A |
| 2 | 2. User B views the same conversation | Reaction is removed or count decreased for User B as well |

**Final Expected Result:** Reaction removal is synchronized across participants

---

### TC-146: Boundary: react to the first message in the conversation

**Type:** functional
**Priority:** low
**Status:** manual
**User Story:** US-017
**Requirement:** WA-MSG-007

**Description:** Verify reaction works on the first message in the list

**Preconditions:**
- User is logged in
- An open conversation exists with multiple messages

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Scroll to the first message in the conversation | First message is visible |
| 2 | 2. React to the first message with an emoji | Reaction appears on the first message |

**Final Expected Result:** Emoji reaction works on the first message

---

### TC-147: Boundary: react to the most recent message

**Type:** functional
**Priority:** low
**Status:** manual
**User Story:** US-017
**Requirement:** WA-MSG-007

**Description:** Verify reaction works on the latest message in the list

**Preconditions:**
- User is logged in
- An open conversation exists with multiple messages

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to the most recent message | Latest message is visible |
| 2 | 2. React to the latest message with an emoji | Reaction appears on the latest message |

**Final Expected Result:** Emoji reaction works on the most recent message

---

### TC-148: Send self-destructing message with valid expiry deletes after expiry

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-018
**Requirement:** WA-MSG-008

**Description:** Verify message is delivered and auto-deleted from all views after valid expiry time.

**Preconditions:**
- User A and User B accounts exist
- User A is logged in
- User B is logged in
- A conversation between User A and User B is open for User A
- System time is synchronized

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. User A composes a message and selects an expiry time 5 minutes in the future | Expiry time is accepted and displayed for the message |
| 2 | 2. User A sends the message | Message appears in User A's conversation view with expiry indicator |
| 3 | 3. Verify User B receives the message before expiry | Message is visible in User B's conversation view with expiry indicator |
| 4 | 4. Wait until the expiry time is reached | System reaches configured expiry time |
| 5 | 5. Refresh/open the conversation for both users | Message is no longer visible in both User A and User B views |

**Final Expected Result:** Message is delivered and auto-deleted from all views after expiry.

---

### TC-149: Reject self-destructing message with past expiry time

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-018
**Requirement:** WA-MSG-008

**Description:** Verify invalid expiry time in the past prevents sending and shows error.

**Preconditions:**
- User A is logged in
- A conversation is open
- System time is synchronized

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. User A composes a message and selects an expiry time 1 minute in the past | Expiry time is marked invalid |
| 2 | 2. User A clicks Send | Message is not sent and an understandable error message is displayed |
| 3 | 3. Check conversation history | No new message appears in the conversation |

**Final Expected Result:** Message is blocked and user receives a clear error for invalid expiry.

---

### TC-150: Reject self-destructing message with empty expiry time

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-018
**Requirement:** WA-MSG-008

**Description:** Verify missing expiry time is treated as invalid for self-destructing messages.

**Preconditions:**
- User A is logged in
- A conversation is open

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. User A selects self-destruct option but leaves expiry time empty | UI indicates expiry time is required |
| 2 | 2. User A clicks Send | Message is not sent and a clear validation error is shown |

**Final Expected Result:** Message is not sent when expiry time is missing.

---

### TC-151: Reject self-destructing message with invalid format expiry time

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-018
**Requirement:** WA-MSG-008

**Description:** Verify non-date or malformed expiry values are rejected.

**Preconditions:**
- User A is logged in
- A conversation is open

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. User A inputs a malformed expiry time (e.g., text string) | Input is marked invalid |
| 2 | 2. User A clicks Send | Message is not sent and an error message is displayed |

**Final Expected Result:** Invalid expiry format prevents message send.

---

### TC-152: Boundary: expiry time set to minimum allowed value

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-018
**Requirement:** WA-MSG-008

**Description:** Verify message can be sent and deleted using the minimum valid expiry value.

**Preconditions:**
- Minimum expiry duration is configured (e.g., 1 minute)
- User A is logged in
- User B is logged in
- Conversation is open

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. User A sets expiry to the minimum allowed value | Expiry is accepted |
| 2 | 2. User A sends the message | Message is delivered to both users |
| 3 | 3. Wait until expiry time is reached | System reaches expiry time |
| 4 | 4. Refresh conversation views | Message is deleted from all views |

**Final Expected Result:** Message works correctly at the minimum expiry boundary.

---

### TC-153: Boundary: expiry time set to maximum allowed value

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-018
**Requirement:** WA-MSG-008

**Description:** Verify message can be sent with the maximum allowed expiry value.

**Preconditions:**
- Maximum expiry duration is configured (e.g., 30 days)
- User A is logged in
- User B is logged in
- Conversation is open

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. User A sets expiry to the maximum allowed value | Expiry is accepted |
| 2 | 2. User A sends the message | Message is delivered to both users with expiry indicator |

**Final Expected Result:** Message is sent successfully at the maximum expiry boundary.

---

### TC-154: Offline recipient: message auto-deletes before recipient opens conversation

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-018
**Requirement:** WA-MSG-008

**Description:** Verify message is deleted upon expiry even if recipient is offline and never viewed it.

**Preconditions:**
- User A is logged in
- User B is offline (logged out)
- Conversation is open for User A
- System time is synchronized

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. User A sends a self-destructing message with expiry in 2 minutes | Message appears in User A view |
| 2 | 2. Wait until expiry time is reached while User B remains offline | System reaches expiry time |
| 3 | 3. User B logs in and opens the conversation | The message is not visible in User B's conversation view |
| 4 | 4. User A refreshes conversation | Message is no longer visible for User A |

**Final Expected Result:** Message is deleted on expiry even when recipient is offline.

---

### TC-155: Deletion removes message from all devices for same user

**Type:** integration
**Priority:** medium
**Status:** manual
**User Story:** US-018
**Requirement:** WA-MSG-008

**Description:** Verify a self-destructing message is removed from multiple active sessions for the sender.

**Preconditions:**
- User A is logged in on Device 1 and Device 2
- User B is logged in
- Conversation is open on both devices

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. User A sends a self-destructing message with expiry in 3 minutes from Device 1 | Message appears on Device 1 and Device 2 |
| 2 | 2. Wait until expiry time is reached | System reaches expiry time |
| 3 | 3. Refresh/open conversation on both devices | Message is removed from both devices |

**Final Expected Result:** Message deletion is consistent across multiple sessions.

---

### TC-156: Validate error message clarity for invalid expiry

**Type:** functional
**Priority:** low
**Status:** manual
**User Story:** US-018
**Requirement:** WA-MSG-008

**Description:** Verify the user receives a clear, understandable error message for invalid expiry.

**Preconditions:**
- User A is logged in
- Conversation is open

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Enter an expiry time in the past and click Send | A readable error message explains the expiry time must be in the future |

**Final Expected Result:** User sees a clear, understandable error message.

---

### TC-157: Message is not retrievable after expiry via conversation reload

**Type:** integration
**Priority:** high
**Status:** manual
**User Story:** US-018
**Requirement:** WA-MSG-008

**Description:** Verify expired messages do not reappear after reload or history fetch.

**Preconditions:**
- User A is logged in
- User B is logged in
- Conversation is open
- A self-destructing message with near expiry is sent

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Wait until expiry time is reached | System reaches expiry time |
| 2 | 2. Reload the conversation history | Expired message does not appear in history |
| 3 | 3. Open conversation from another device/session | Expired message is not visible |

**Final Expected Result:** Expired messages are not retrievable after expiry.

---

### TC-158: View-Once Medien wird genau einmal angezeigt

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-019
**Requirement:** WA-MSG-009

**Description:** Prüft, dass View-Once Medien beim ersten Öffnen angezeigt und danach als angesehen markiert werden.

**Preconditions:**
- Endnutzer ist eingeloggt
- Eine View-Once-Mediennachricht ist im Chat vorhanden und ungesehen

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Öffne den Chat mit der View-Once-Mediennachricht | Die View-Once-Mediennachricht ist sichtbar und als ungesehen markiert |
| 2 | 2. Tippe auf die View-Once-Mediennachricht | Die Medien werden angezeigt |
| 3 | 3. Schließe die Medienansicht | Die Nachricht wird als angesehen markiert |

**Final Expected Result:** Die Medien werden genau einmal angezeigt und danach als angesehen markiert.

---

### TC-159: Erneutes Öffnen von View-Once Medien wird verhindert

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-019
**Requirement:** WA-MSG-009

**Description:** Stellt sicher, dass bereits angesehene View-Once Medien nicht erneut angezeigt werden.

**Preconditions:**
- Endnutzer ist eingeloggt
- Eine View-Once-Mediennachricht wurde bereits geöffnet

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Öffne den Chat mit der bereits angesehenen View-Once-Mediennachricht | Die Nachricht ist als angesehen markiert |
| 2 | 2. Tippe erneut auf die View-Once-Mediennachricht | Die Medien werden nicht angezeigt |
| 3 | 3. Prüfe die eingeblendete Hinweisnachricht | Eine Hinweisnachricht informiert, dass die Medien nicht erneut angezeigt werden können |

**Final Expected Result:** Das erneute Anzeigen wird verhindert und eine Hinweisnachricht wird angezeigt.

---

### TC-160: Speichern von View-Once Medien offline wird blockiert

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-019
**Requirement:** WA-MSG-009

**Description:** Prüft, dass das System das Offline-Speichern von View-Once Medien verhindert.

**Preconditions:**
- Endnutzer ist eingeloggt
- Eine View-Once-Mediennachricht ist vorhanden

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Öffne den Chat mit der View-Once-Mediennachricht | Die Nachricht ist sichtbar |
| 2 | 2. Versuche die Medien über die UI-Aktion 'Speichern' oder 'Download' zu speichern | Die Aktion wird blockiert |
| 3 | 3. Prüfe die Sicherheitsmeldung | Eine Sicherheitsmeldung informiert, dass Speichern nicht erlaubt ist |

**Final Expected Result:** Das System verhindert das Speichern und zeigt eine Sicherheitsmeldung an.

---

### TC-161: Weiterleiten von View-Once Medien wird blockiert

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-019
**Requirement:** WA-MSG-009

**Description:** Prüft, dass View-Once Medien nicht weitergeleitet werden können.

**Preconditions:**
- Endnutzer ist eingeloggt
- Eine View-Once-Mediennachricht ist vorhanden

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Öffne den Chat mit der View-Once-Mediennachricht | Die Nachricht ist sichtbar |
| 2 | 2. Versuche die Medien über die UI-Aktion 'Weiterleiten' zu teilen | Die Aktion wird blockiert |
| 3 | 3. Prüfe die Sicherheitsmeldung | Eine Sicherheitsmeldung informiert, dass Weiterleitung nicht erlaubt ist |

**Final Expected Result:** Das System verhindert die Weiterleitung und zeigt eine Sicherheitsmeldung an.

---

### TC-162: View-Once Medien öffnen bei instabiler Verbindung

**Type:** integration
**Priority:** medium
**Status:** manual
**User Story:** US-019
**Requirement:** WA-MSG-009

**Description:** Stellt sicher, dass die Anzeige bei kurzfristiger Netzwerkunterbrechung korrekt verarbeitet wird.

**Preconditions:**
- Endnutzer ist eingeloggt
- Eine View-Once-Mediennachricht ist vorhanden
- Netzwerkverbindung ist instabil

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Öffne den Chat mit der View-Once-Mediennachricht | Die Nachricht ist sichtbar |
| 2 | 2. Tippe auf die View-Once-Mediennachricht während einer kurzzeitigen Verbindungsunterbrechung | Entweder wird die Medienanzeige geladen oder eine Fehlermeldung angezeigt |
| 3 | 3. Stelle die Verbindung wieder her und tippe erneut auf die Nachricht | Die Medien werden genau einmal angezeigt, sofern sie zuvor nicht angezeigt wurden |

**Final Expected Result:** Die Medien werden nur einmal angezeigt und der Status wird konsistent gehandhabt.

---

### TC-163: Mehrfaches schnelles Tippen auf View-Once Medien

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-019
**Requirement:** WA-MSG-009

**Description:** Prüft das Verhalten bei schnellem, mehrfachen Öffnen (Boundary).

**Preconditions:**
- Endnutzer ist eingeloggt
- Eine View-Once-Mediennachricht ist vorhanden und ungesehen

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Öffne den Chat mit der View-Once-Mediennachricht | Die Nachricht ist sichtbar und ungesehen |
| 2 | 2. Tippe mehrfach schnell hintereinander auf die View-Once-Mediennachricht | Die Medien werden nur einmal angezeigt |
| 3 | 3. Schließe die Medienansicht | Die Nachricht wird als angesehen markiert |

**Final Expected Result:** Trotz mehrfachen Tippens wird die Medienanzeige nur einmal ausgelöst.

---

### TC-164: View-Once Status bleibt nach App-Neustart erhalten

**Type:** e2e
**Priority:** medium
**Status:** manual
**User Story:** US-019
**Requirement:** WA-MSG-009

**Description:** Verifiziert, dass der View-Once Status nach Neustart der App korrekt ist.

**Preconditions:**
- Endnutzer ist eingeloggt
- Eine View-Once-Mediennachricht wurde bereits geöffnet

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Beende die App vollständig | Die App ist geschlossen |
| 2 | 2. Starte die App neu und öffne den Chat | Die Nachricht ist weiterhin als angesehen markiert |
| 3 | 3. Versuche die View-Once-Mediennachricht erneut zu öffnen | Die Medien werden nicht angezeigt und eine Hinweisnachricht erscheint |

**Final Expected Result:** Der View-Once Status bleibt erhalten und erneutes Öffnen ist blockiert.

---

### TC-165: Keine View-Once Einschränkungen bei normalen Medien

**Type:** functional
**Priority:** low
**Status:** manual
**User Story:** US-019
**Requirement:** WA-MSG-009

**Description:** Negativtest: Normale Medien sollten weiterhin gespeichert und weitergeleitet werden können.

**Preconditions:**
- Endnutzer ist eingeloggt
- Eine normale Mediennachricht (nicht View-Once) ist im Chat vorhanden

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Öffne den Chat mit der normalen Mediennachricht | Die Nachricht ist sichtbar |
| 2 | 2. Öffne die Medien | Die Medien werden angezeigt |
| 3 | 3. Versuche die Medien zu speichern | Speichern ist erlaubt und erfolgreich |
| 4 | 4. Versuche die Medien weiterzuleiten | Weiterleitung ist erlaubt und erfolgreich |

**Final Expected Result:** Normale Medien unterliegen keinen View-Once Einschränkungen.

---

### TC-166: Lock chat with successful additional authentication

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-020
**Requirement:** WA-MSG-010

**Description:** Verify that a logged-in user can lock a chat after successful additional authentication and access is restricted

**Preconditions:**
- User is logged in
- User is in chat detail view
- Chat is currently unlocked
- Additional authentication method is configured (e.g., PIN/biometric)

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Select the 'Chat sperren' option in the chat detail view | Additional authentication prompt is displayed |
| 2 | 2. Provide valid additional authentication credentials | Authentication succeeds |
| 3 | 3. Return to the chat list and attempt to open the same chat | Chat content is not shown and a prompt for additional authentication appears |

**Final Expected Result:** Chat is locked and cannot be accessed without additional authentication

---

### TC-167: Lock chat when additional authentication fails

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-020
**Requirement:** WA-MSG-010

**Description:** Verify that the chat remains unlocked and a clear error message is shown when authentication fails

**Preconditions:**
- User is logged in
- User is in chat detail view
- Chat is currently unlocked
- Additional authentication method is configured

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Select the 'Chat sperren' option | Additional authentication prompt is displayed |
| 2 | 2. Provide invalid authentication credentials | Authentication fails and an error message is displayed |
| 3 | 3. Attempt to open the chat again from the chat list | Chat opens normally without requiring additional authentication |

**Final Expected Result:** Chat remains unlocked and a clear error message is shown

---

### TC-168: Cancel additional authentication during lock process

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-020
**Requirement:** WA-MSG-010

**Description:** Verify that cancelling authentication keeps the chat unlocked and shows a clear message

**Preconditions:**
- User is logged in
- User is in chat detail view
- Chat is currently unlocked
- Additional authentication method is configured

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Select the 'Chat sperren' option | Additional authentication prompt is displayed |
| 2 | 2. Cancel/close the authentication prompt | User returns to chat detail view and a cancellation message is displayed |
| 3 | 3. Navigate to the chat list and open the same chat | Chat opens normally without requiring additional authentication |

**Final Expected Result:** Chat remains unlocked and a clear cancellation message is shown

---

### TC-169: Attempt to lock an already locked chat

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-020
**Requirement:** WA-MSG-010

**Description:** Verify that attempting to lock an already locked chat shows an informational message and leaves state unchanged

**Preconditions:**
- User is logged in
- Chat is already locked
- User is in chat detail view

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Select the 'Chat sperren' option | Information message indicates the chat is already locked |
| 2 | 2. Attempt to open the chat content | Additional authentication is still required to access the chat |

**Final Expected Result:** User is informed the chat is already locked and lock status remains unchanged

---

### TC-170: Access locked chat without authentication

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-020
**Requirement:** WA-MSG-010

**Description:** Verify that a locked chat cannot be accessed without additional authentication

**Preconditions:**
- User is logged in
- Chat is locked
- User is at chat list view

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Tap the locked chat in the chat list | Additional authentication prompt is displayed and chat content is hidden |
| 2 | 2. Do not provide authentication and attempt to dismiss the prompt | Chat content remains inaccessible |

**Final Expected Result:** Locked chat remains inaccessible without additional authentication

---

### TC-171: Re-lock after unlocking session timeout boundary

**Type:** e2e
**Priority:** medium
**Status:** manual
**User Story:** US-020
**Requirement:** WA-MSG-010

**Description:** Verify locking persists across session boundary/timeout and still requires authentication

**Preconditions:**
- User is logged in
- Chat is locked
- Session timeout is configured

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Wait for session timeout or log out and log back in | User is authenticated to the app again |
| 2 | 2. Navigate to the locked chat from the chat list | Additional authentication prompt is displayed before showing content |

**Final Expected Result:** Lock state persists across session boundary and requires additional authentication

---

### TC-172: Multiple failed authentication attempts while locking

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-020
**Requirement:** WA-MSG-010

**Description:** Verify clear error messaging and no lock after repeated failed attempts

**Preconditions:**
- User is logged in
- Chat is currently unlocked
- Additional authentication method is configured

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Select the 'Chat sperren' option | Additional authentication prompt is displayed |
| 2 | 2. Enter invalid credentials three consecutive times | Each attempt fails with a clear error message |
| 3 | 3. Open the chat | Chat opens normally without requiring additional authentication |

**Final Expected Result:** Chat remains unlocked after multiple failed attempts and errors are clearly shown

---

### TC-173: Lock chat while offline (integration behavior)

**Type:** integration
**Priority:** low
**Status:** manual
**User Story:** US-020
**Requirement:** WA-MSG-010

**Description:** Verify behavior when attempting to lock a chat without network connectivity

**Preconditions:**
- User is logged in
- Chat is currently unlocked
- User is in chat detail view
- Network connectivity is unavailable

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Select the 'Chat sperren' option | System either proceeds with local authentication or shows a clear offline error |
| 2 | 2. If authentication is allowed, provide valid credentials | Chat lock status updates according to supported offline behavior |

**Final Expected Result:** User receives a clear outcome message and chat state is consistent with offline support rules

---

### TC-174: Send broadcast to all valid recipients

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-021
**Requirement:** WA-MSG-011

**Description:** Verify message is delivered to all valid recipients and per-recipient status is shown.

**Preconditions:**
- Administrator is logged in
- Broadcast list contains only valid recipients with consent and not blocked
- Message compose screen is accessible

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the Broadcast-Listen screen | Broadcast list management view is displayed |
| 2 | 2. Select an existing broadcast list with valid recipients | Selected list details and recipient count are shown |
| 3 | 3. Enter a message and click 'Send' | Send action is initiated and confirmation/processing indicator appears |
| 4 | 4. View the sending results | Each recipient shows a delivery status (e.g., sent/queued) |

**Final Expected Result:** Message is sent to all recipients and per-recipient delivery status is displayed.

---

### TC-175: Skip recipients without consent or blocked

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-021
**Requirement:** WA-MSG-011

**Description:** Verify non-consenting or blocked recipients are excluded and shown with reasons.

**Preconditions:**
- Administrator is logged in
- Broadcast list contains mixed recipients: valid, no-consent, blocked

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the Broadcast-Listen screen and select the mixed recipient list | Selected list details show recipient count |
| 2 | 2. Enter a message and click 'Send' | Send action begins and a results summary is prepared |
| 3 | 3. Review the excluded recipients summary | Recipients without consent or blocked are listed with exclusion reasons |
| 4 | 4. Review delivery status for valid recipients | Only valid recipients have delivery statuses displayed |

**Final Expected Result:** Excluded recipients are skipped and reported with reasons; valid recipients receive the message.

---

### TC-176: Prevent sending when broadcast list is empty

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-021
**Requirement:** WA-MSG-011

**Description:** Verify sending is blocked with a clear error message when list has no recipients.

**Preconditions:**
- Administrator is logged in
- Broadcast list is empty

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the Broadcast-Listen screen and select the empty list | Recipient count shows 0 |
| 2 | 2. Enter a message and click 'Send' | Send action is blocked |
| 3 | 3. Observe the system response | A clear error message indicates the list is empty |

**Final Expected Result:** Sending is prevented and a user-friendly error message is displayed.

---

### TC-177: Boundary: List with exactly one valid recipient

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-021
**Requirement:** WA-MSG-011

**Description:** Verify broadcast works with the minimum valid recipient count.

**Preconditions:**
- Administrator is logged in
- Broadcast list contains exactly one valid recipient with consent

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the Broadcast-Listen screen and select the one-recipient list | Recipient count shows 1 |
| 2 | 2. Enter a message and click 'Send' | Send action is initiated |
| 3 | 3. Check delivery status | The single recipient shows a delivery status |

**Final Expected Result:** Message is sent successfully and status is shown for the single recipient.

---

### TC-178: Mixed list where all recipients are excluded

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-021
**Requirement:** WA-MSG-011

**Description:** Verify behavior when all recipients are blocked or without consent.

**Preconditions:**
- Administrator is logged in
- Broadcast list contains only recipients without consent or blocked

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the Broadcast-Listen screen and select the list | Recipient count displays the total count |
| 2 | 2. Enter a message and click 'Send' | Send action is processed |
| 3 | 3. Review the excluded recipients summary | All recipients are listed as excluded with reasons |

**Final Expected Result:** No deliveries occur and the administrator sees a complete exclusion summary.

---

### TC-179: Status visibility after broadcast send

**Type:** integration
**Priority:** medium
**Status:** manual
**User Story:** US-021
**Requirement:** WA-MSG-011

**Description:** Verify per-recipient status is displayed after sending a broadcast.

**Preconditions:**
- Administrator is logged in
- Broadcast list contains valid recipients

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Send a broadcast message to the list | Send request is accepted by the system |
| 2 | 2. Open the broadcast sending results/details view | A status list per recipient is displayed |

**Final Expected Result:** Per-recipient delivery status is visible after sending.

---

### TC-180: Prevent sending without message content

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-021
**Requirement:** WA-MSG-011

**Description:** Verify validation prevents sending an empty message body.

**Preconditions:**
- Administrator is logged in
- Broadcast list contains valid recipients

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the Broadcast-Listen screen and select a valid list | List details and recipient count are shown |
| 2 | 2. Leave the message body empty and click 'Send' | Send action is blocked |
| 3 | 3. Observe validation feedback | A clear error message indicates message content is required |

**Final Expected Result:** Broadcast is not sent and validation message is shown for empty content.

---

### TC-181: TC01 - Single bold formatting renders correctly

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-022
**Requirement:** WA-MSG-012

**Description:** Verify that bold formatting is rendered for a valid marker.

**Preconditions:**
- User is logged in
- User has access to a message composer
- Recipient user is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the message composer | Composer is displayed and ready for input |
| 2 | 2. Enter text with bold marker (e.g., **bold**) in the message body | Text is entered in the composer |
| 3 | 3. Send the message | Message is sent successfully |
| 4 | 4. Open the message on the recipient side | Message content is visible to recipient |

**Final Expected Result:** The bold-marked text is displayed in bold formatting for the recipient

---

### TC-182: TC02 - Single italic formatting renders correctly

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-022
**Requirement:** WA-MSG-012

**Description:** Verify that italic formatting is rendered for a valid marker.

**Preconditions:**
- User is logged in
- User has access to a message composer
- Recipient user is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the message composer | Composer is displayed and ready for input |
| 2 | 2. Enter text with italic marker (e.g., *italic*) in the message body | Text is entered in the composer |
| 3 | 3. Send the message | Message is sent successfully |
| 4 | 4. Open the message on the recipient side | Message content is visible to recipient |

**Final Expected Result:** The italic-marked text is displayed in italic formatting for the recipient

---

### TC-183: TC03 - Single underline formatting renders correctly

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-022
**Requirement:** WA-MSG-012

**Description:** Verify that underline formatting is rendered for a valid marker.

**Preconditions:**
- User is logged in
- User has access to a message composer
- Recipient user is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the message composer | Composer is displayed and ready for input |
| 2 | 2. Enter text with underline marker (e.g., __underline__) in the message body | Text is entered in the composer |
| 3 | 3. Send the message | Message is sent successfully |
| 4 | 4. Open the message on the recipient side | Message content is visible to recipient |

**Final Expected Result:** The underline-marked text is displayed underlined for the recipient

---

### TC-184: TC04 - Multiple formatting types in one sentence render correctly

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-022
**Requirement:** WA-MSG-012

**Description:** Verify that bold, italic, and underline render correctly within the same sentence.

**Preconditions:**
- User is logged in
- User has access to a message composer
- Recipient user is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the message composer | Composer is displayed and ready for input |
| 2 | 2. Enter a sentence with multiple formats (e.g., This is **bold**, *italic*, and __underline__.) | Text is entered in the composer |
| 3 | 3. Send the message | Message is sent successfully |
| 4 | 4. Open the message on the recipient side | Message content is visible to recipient |

**Final Expected Result:** All supported formats render correctly and in the correct order

---

### TC-185: TC05 - Nested formatting renders in correct order

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-022
**Requirement:** WA-MSG-012

**Description:** Verify that nested or adjacent formatting is rendered in the correct order.

**Preconditions:**
- User is logged in
- User has access to a message composer
- Recipient user is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the message composer | Composer is displayed and ready for input |
| 2 | 2. Enter text with nested or adjacent markers (e.g., **bold and *italic* text**) | Text is entered in the composer |
| 3 | 3. Send the message | Message is sent successfully |
| 4 | 4. Open the message on the recipient side | Message content is visible to recipient |

**Final Expected Result:** Nested and adjacent formatting is rendered correctly according to supported rules

---

### TC-186: TC06 - Unsupported formatting markers are ignored with user notice

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-022
**Requirement:** WA-MSG-012

**Description:** Verify unsupported markers do not format the text and user receives a warning.

**Preconditions:**
- User is logged in
- User has access to a message composer

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the message composer | Composer is displayed and ready for input |
| 2 | 2. Enter text with unsupported marker (e.g., ~~strikethrough~~) | Text is entered in the composer |
| 3 | 3. Send the message | Message is sent successfully |
| 4 | 4. Observe any system feedback or warning | A notice appears indicating invalid/unsupported formatting |

**Final Expected Result:** The message is displayed without unsupported formatting and the user is notified of invalid markers

---

### TC-187: TC07 - Malformed formatting markers are ignored with user notice

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-022
**Requirement:** WA-MSG-012

**Description:** Verify malformed markers do not apply formatting and user receives a warning.

**Preconditions:**
- User is logged in
- User has access to a message composer

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the message composer | Composer is displayed and ready for input |
| 2 | 2. Enter text with malformed markers (e.g., **bold* or *italic**) | Text is entered in the composer |
| 3 | 3. Send the message | Message is sent successfully |
| 4 | 4. Observe any system feedback or warning | A notice appears indicating invalid/unsupported formatting |

**Final Expected Result:** The message is displayed without malformed formatting and the user is notified of invalid markers

---

### TC-188: TC08 - Mixed valid and invalid markers in one message

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-022
**Requirement:** WA-MSG-012

**Description:** Verify valid formatting renders while invalid markers are ignored with warning.

**Preconditions:**
- User is logged in
- User has access to a message composer
- Recipient user is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the message composer | Composer is displayed and ready for input |
| 2 | 2. Enter text with both valid and invalid markers (e.g., **bold** and ~~strike~~) | Text is entered in the composer |
| 3 | 3. Send the message | Message is sent successfully |
| 4 | 4. Open the message on the recipient side | Message content is visible to recipient |
| 5 | 5. Observe any system feedback or warning to the sender | A notice appears indicating invalid/unsupported formatting |

**Final Expected Result:** Valid formatting is displayed correctly, invalid formatting is ignored, and a warning is shown

---

### TC-189: TC09 - Boundary: Formatting at start and end of message

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-022
**Requirement:** WA-MSG-012

**Description:** Verify formatting markers at message boundaries are handled correctly.

**Preconditions:**
- User is logged in
- User has access to a message composer
- Recipient user is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the message composer | Composer is displayed and ready for input |
| 2 | 2. Enter text where formatting begins at start and ends at end (e.g., **Entire message**) | Text is entered in the composer |
| 3 | 3. Send the message | Message is sent successfully |
| 4 | 4. Open the message on the recipient side | Message content is visible to recipient |

**Final Expected Result:** Formatting is correctly applied across the full message boundary

---

### TC-190: TC10 - Boundary: Empty formatted content is handled gracefully

**Type:** functional
**Priority:** low
**Status:** manual
**User Story:** US-022
**Requirement:** WA-MSG-012

**Description:** Verify that empty formatting markers do not crash and are treated as invalid.

**Preconditions:**
- User is logged in
- User has access to a message composer

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the message composer | Composer is displayed and ready for input |
| 2 | 2. Enter empty formatted markers (e.g., **** or ____) | Text is entered in the composer |
| 3 | 3. Send the message | Message is sent successfully |
| 4 | 4. Observe any system feedback or warning | A notice appears indicating invalid/unsupported formatting |

**Final Expected Result:** No formatting is applied, no errors occur, and the user is notified of invalid markers

---

### TC-191: TC11 - Multiple formatting instances across lines

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-022
**Requirement:** WA-MSG-012

**Description:** Verify formatting renders correctly across multiple lines.

**Preconditions:**
- User is logged in
- User has access to a message composer
- Recipient user is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the message composer | Composer is displayed and ready for input |
| 2 | 2. Enter a multi-line message with formatting on each line (e.g., Line1 **bold**\nLine2 *italic*\nLine3 __underline__) | Multi-line text is entered in the composer |
| 3 | 3. Send the message | Message is sent successfully |
| 4 | 4. Open the message on the recipient side | Message content is visible to recipient |

**Final Expected Result:** Formatting is correctly applied on each line

---

### TC-192: TC12 - Performance: Rendering formatting on long message

**Type:** performance
**Priority:** low
**Status:** manual
**User Story:** US-022
**Requirement:** WA-MSG-012

**Description:** Verify formatting is applied within acceptable time for a long message.

**Preconditions:**
- User is logged in
- User has access to a message composer
- Recipient user is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the message composer | Composer is displayed and ready for input |
| 2 | 2. Enter a long message (e.g., 5000+ characters) with multiple valid formatting markers | Long text is entered in the composer |
| 3 | 3. Send the message | Message is sent successfully within acceptable time |
| 4 | 4. Open the message on the recipient side | Message content is visible without delay |

**Final Expected Result:** Formatting is correctly applied and message rendering meets performance expectations

---

### TC-193: Mention a participant from suggestion list

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-023
**Requirement:** WA-MSG-013

**Description:** Verify that selecting a user from @mention suggestions inserts @Name and renders as a mention after sending

**Preconditions:**
- User is logged in
- A group chat with multiple participants is open
- Network connection is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Focus the message input field | Cursor is visible in the message input |
| 2 | 2. Type '@' | Suggestion list of participants appears |
| 3 | 3. Select a participant from the suggestion list | The selected participant is inserted as '@Name' in the message input |
| 4 | 4. Send the message | Message is sent successfully |

**Final Expected Result:** The sent message shows the participant as a highlighted @mention

---

### TC-194: Send message with non-existent @name

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-023
**Requirement:** WA-MSG-013

**Description:** Verify that typing a non-existent @name does not create a mention or notification

**Preconditions:**
- User is logged in
- A group chat with multiple participants is open
- Network connection is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Focus the message input field | Cursor is visible in the message input |
| 2 | 2. Type '@NonExistentUser' (a name not in participants) | No matching participant is selected from suggestions |
| 3 | 3. Send the message | Message is sent successfully |

**Final Expected Result:** Message is delivered without any mention highlighting and no notifications are sent to non-existent users

---

### TC-195: Send @mention while offline

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-023
**Requirement:** WA-MSG-013

**Description:** Verify message is not sent and error shown when network is unavailable

**Preconditions:**
- User is logged in
- A group chat with multiple participants is open
- Network connection is unavailable

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Focus the message input field | Cursor is visible in the message input |
| 2 | 2. Type '@' and select a participant | Selected participant is inserted as '@Name' |
| 3 | 3. Send the message | Send action fails |

**Final Expected Result:** Message is not sent and an error message about delivery failure is displayed

---

### TC-196: Multiple mentions in a single message

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-023
**Requirement:** WA-MSG-013

**Description:** Verify multiple @mentions are inserted and displayed correctly

**Preconditions:**
- User is logged in
- A group chat with multiple participants is open
- Network connection is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Focus the message input field | Cursor is visible in the message input |
| 2 | 2. Type '@' and select Participant A | Participant A is inserted as '@Name' |
| 3 | 3. Type a space, then '@' and select Participant B | Participant B is inserted as '@Name' |
| 4 | 4. Send the message | Message is sent successfully |

**Final Expected Result:** Both Participant A and Participant B appear as highlighted mentions in the sent message

---

### TC-197: Boundary: @ mention at end of message

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-023
**Requirement:** WA-MSG-013

**Description:** Verify mention works when placed at the end of the message

**Preconditions:**
- User is logged in
- A group chat with multiple participants is open
- Network connection is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Type a message ending with '@' and select a participant | Participant is inserted as '@Name' at the end of the message |
| 2 | 2. Send the message | Message is sent successfully |

**Final Expected Result:** The mention at the end of the message is highlighted correctly after sending

---

### TC-198: Suggestion list filters by typed characters

**Type:** functional
**Priority:** low
**Status:** manual
**User Story:** US-023
**Requirement:** WA-MSG-013

**Description:** Verify suggestions narrow down based on characters after '@'

**Preconditions:**
- User is logged in
- A group chat with multiple participants is open
- Network connection is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Type '@' followed by the first 2 letters of a participant's name | Suggestion list filters to matching participants |
| 2 | 2. Select the intended participant | Selected participant is inserted as '@Name' |

**Final Expected Result:** Only matching participants are suggested and the selected user is correctly inserted

---

### TC-199: Negative: Typing '@' without selecting a user

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-023
**Requirement:** WA-MSG-013

**Description:** Verify that sending plain '@' or '@' + random text without selection does not create mention

**Preconditions:**
- User is logged in
- A group chat with multiple participants is open
- Network connection is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Type '@abc' where 'abc' does not match any participant and do not select from suggestions | No participant is selected |
| 2 | 2. Send the message | Message is sent successfully |

**Final Expected Result:** Message is sent without mention highlighting and no user is notified

---

### TC-200: TC1 - Share current location with permission granted

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-024
**Requirement:** WA-MSG-014

**Description:** Verify that the current location is shared as a map view with coordinates when permission is granted

**Preconditions:**
- User is logged in
- User is in an active chat
- Location permission granted
- Location services enabled and available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the chat conversation | Chat screen is displayed with message input |
| 2 | 2. Tap the attachment/menu option for sharing | Share options are displayed |
| 3 | 3. Select the “Standort teilen” option | Current location is retrieved and a preview is shown |
| 4 | 4. Tap Send | Message is sent successfully |

**Final Expected Result:** The message contains a map view with coordinates and is delivered to the recipient

---

### TC-201: TC2 - Attempt to share location without permission

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-024
**Requirement:** WA-MSG-014

**Description:** Verify system prompts for permission and does not send location when permission is not granted

**Preconditions:**
- User is logged in
- User is in an active chat
- Location permission not granted

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the chat conversation | Chat screen is displayed with message input |
| 2 | 2. Select “Standort teilen” | Permission prompt is displayed to grant location access |
| 3 | 3. Decline or dismiss the permission prompt | No location is retrieved |
| 4 | 4. Attempt to send | No location message is sent |

**Final Expected Result:** System requests permission and does not send any location data

---

### TC-202: TC3 - Location services unavailable

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-024
**Requirement:** WA-MSG-014

**Description:** Verify error message and manual selection option when location services are unavailable

**Preconditions:**
- User is logged in
- User is in an active chat
- Location permission granted
- Device location services disabled or unavailable

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the chat conversation | Chat screen is displayed with message input |
| 2 | 2. Select “Standort teilen” | System detects unavailable location services |
| 3 | 3. Observe the error prompt | A clear error message is displayed with an option to select location manually |

**Final Expected Result:** System shows an understandable error and offers manual location selection

---

### TC-203: TC4 - Manual location selection after services unavailable

**Type:** e2e
**Priority:** medium
**Status:** manual
**User Story:** US-024
**Requirement:** WA-MSG-014

**Description:** Verify user can manually select a location when services are unavailable

**Preconditions:**
- User is logged in
- User is in an active chat
- Location permission granted
- Device location services disabled or unavailable

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Select “Standort teilen” | Error message with manual selection option is displayed |
| 2 | 2. Tap the manual selection option | Map/manual selection interface opens |
| 3 | 3. Choose a location and confirm | A location preview is displayed |
| 4 | 4. Tap Send | Message is sent successfully |

**Final Expected Result:** Selected manual location is sent as a map view with coordinates

---

### TC-204: TC5 - Permission granted after initial denial

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-024
**Requirement:** WA-MSG-014

**Description:** Verify location can be shared after user grants permission from the prompt

**Preconditions:**
- User is logged in
- User is in an active chat
- Location permission not granted

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Select “Standort teilen” | Permission prompt is displayed |
| 2 | 2. Grant location permission | System proceeds to retrieve current location |
| 3 | 3. Tap Send | Message is sent successfully |

**Final Expected Result:** Location is shared as a map view with coordinates

---

### TC-205: TC6 - Boundary: Low GPS accuracy

**Type:** functional
**Priority:** low
**Status:** manual
**User Story:** US-024
**Requirement:** WA-MSG-014

**Description:** Verify location sharing works with low accuracy and still shows coordinates

**Preconditions:**
- User is logged in
- User is in an active chat
- Location permission granted
- Location services enabled with low GPS accuracy

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Select “Standort teilen” | Location retrieval completes with low accuracy |
| 2 | 2. Tap Send | Message is sent successfully |

**Final Expected Result:** Location message displays a map view and coordinates despite low accuracy

---

### TC-206: TC7 - Cancel location sharing before sending

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-024
**Requirement:** WA-MSG-014

**Description:** Verify no location is sent when user cancels after preview

**Preconditions:**
- User is logged in
- User is in an active chat
- Location permission granted
- Location services enabled

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Select “Standort teilen” | Location preview is displayed |
| 2 | 2. Tap Cancel/Back instead of Send | User returns to chat without sending |

**Final Expected Result:** No location message is sent

---

### TC-207: TC8 - Multiple location shares in succession

**Type:** integration
**Priority:** medium
**Status:** manual
**User Story:** US-024
**Requirement:** WA-MSG-014

**Description:** Verify system handles consecutive location shares and sends updated locations

**Preconditions:**
- User is logged in
- User is in an active chat
- Location permission granted
- Location services enabled

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Share location and send the message | First location message is sent successfully |
| 2 | 2. Move to a different location or simulate new coordinates | Device location updates |
| 3 | 3. Share location again and send | Second location message is sent successfully |

**Final Expected Result:** Both messages are delivered with their respective map views and updated coordinates

---

### TC-208: TC01 - Kontakt erfolgreich teilen

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-025
**Requirement:** WA-MSG-015

**Description:** Verify that a user can share a contact in a chat and the recipient receives the contact message.

**Preconditions:**
- User is logged in
- User has permission to access contacts
- At least one contact exists on the device
- User is in an active chat with another user

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the chat conversation. | Chat screen is displayed. |
| 2 | 2. Tap the attachment/share icon and choose 'Contact'. | Contact selection dialog opens. |
| 3 | 3. Select a contact from the list. | Selected contact is highlighted or shown as selected. |
| 4 | 4. Tap 'Teilen' (Share). | Contact message is sent and appears in the sender's chat. |
| 5 | 5. Verify on recipient side. | Recipient sees the contact message with contact details. |

**Final Expected Result:** Contact details are sent as a chat message and displayed to the recipient.

---

### TC-209: TC02 - Kontaktteildialog abbrechen

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-025
**Requirement:** WA-MSG-015

**Description:** Verify that canceling the contact share does not send a message and chat remains unchanged.

**Preconditions:**
- User is logged in
- User has permission to access contacts
- At least one contact exists on the device
- User is in an active chat

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the chat conversation. | Chat screen is displayed. |
| 2 | 2. Tap the attachment/share icon and choose 'Contact'. | Contact selection dialog opens. |
| 3 | 3. Tap 'Abbrechen' (Cancel). | Dialog closes. |
| 4 | 4. Review the chat message list. | No new contact message is added. |

**Final Expected Result:** No message is sent and the chat remains unchanged.

---

### TC-210: TC03 - Keine Kontakte vorhanden

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-025
**Requirement:** WA-MSG-015

**Description:** Verify error handling when no contacts exist on the device.

**Preconditions:**
- User is logged in
- User has permission to access contacts
- No contacts exist on the device
- User is in an active chat

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the chat conversation. | Chat screen is displayed. |
| 2 | 2. Tap the attachment/share icon and choose 'Contact'. | An error message is shown indicating no contacts are available. |

**Final Expected Result:** A clear error message is displayed and no sharing occurs.

---

### TC-211: TC04 - Kontaktzugriff verweigert

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-025
**Requirement:** WA-MSG-015

**Description:** Verify error handling when contact permission is denied.

**Preconditions:**
- User is logged in
- User has denied contact access permission
- User is in an active chat

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the chat conversation. | Chat screen is displayed. |
| 2 | 2. Tap the attachment/share icon and choose 'Contact'. | Permission error message is displayed with guidance to enable access. |

**Final Expected Result:** A clear error message is displayed and no sharing occurs.

---

### TC-212: TC05 - Kontaktliste lädt korrekt

**Type:** integration
**Priority:** medium
**Status:** manual
**User Story:** US-025
**Requirement:** WA-MSG-015

**Description:** Verify that the contact list is displayed when permission is granted and contacts exist.

**Preconditions:**
- User is logged in
- User has permission to access contacts
- Multiple contacts exist on the device
- User is in an active chat

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the chat conversation. | Chat screen is displayed. |
| 2 | 2. Tap the attachment/share icon and choose 'Contact'. | Contact list loads and is displayed. |
| 3 | 3. Scroll through the contact list. | All contacts load correctly without errors. |

**Final Expected Result:** Contact list displays correctly for selection.

---

### TC-213: TC06 - Kontakt teilen bei leerem Chat

**Type:** e2e
**Priority:** medium
**Status:** manual
**User Story:** US-025
**Requirement:** WA-MSG-015

**Description:** Verify contact sharing works in a new/empty chat thread.

**Preconditions:**
- User is logged in
- User has permission to access contacts
- At least one contact exists on the device
- User has opened a chat with no prior messages

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open an empty chat conversation. | Chat screen is displayed with no messages. |
| 2 | 2. Tap the attachment/share icon and choose 'Contact'. | Contact selection dialog opens. |
| 3 | 3. Select a contact and tap 'Teilen' (Share). | Contact message is sent and appears in the chat. |

**Final Expected Result:** Contact is shared successfully even when the chat is empty.

---

### TC-214: TC07 - Kontakt teilen bei minimalen Kontaktinformationen

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-025
**Requirement:** WA-MSG-015

**Description:** Verify sharing a contact that has only a name and no phone/email.

**Preconditions:**
- User is logged in
- User has permission to access contacts
- A contact exists with only a name and no phone/email
- User is in an active chat

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the chat conversation. | Chat screen is displayed. |
| 2 | 2. Tap the attachment/share icon and choose 'Contact'. | Contact selection dialog opens. |
| 3 | 3. Select the contact with minimal information and tap 'Teilen' (Share). | Contact message is sent. |
| 4 | 4. View the sent contact message. | Message displays available contact details without errors. |

**Final Expected Result:** Contact with minimal info can be shared and displayed correctly.

---

### TC-215: TC08 - Kontakt teilen mit Abbruch nach Auswahl

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-025
**Requirement:** WA-MSG-015

**Description:** Verify canceling after selecting a contact does not send a message.

**Preconditions:**
- User is logged in
- User has permission to access contacts
- At least one contact exists on the device
- User is in an active chat

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the chat conversation. | Chat screen is displayed. |
| 2 | 2. Tap the attachment/share icon and choose 'Contact'. | Contact selection dialog opens. |
| 3 | 3. Select a contact. | Selected contact is highlighted. |
| 4 | 4. Tap 'Abbrechen' (Cancel). | Dialog closes without sending. |
| 5 | 5. Review the chat message list. | No new contact message is added. |

**Final Expected Result:** No message is sent when canceling after selection.

---

### TC-216: TC09 - Fehleranzeige bei fehlender Berechtigung während Laufzeit

**Type:** integration
**Priority:** medium
**Status:** manual
**User Story:** US-025
**Requirement:** WA-MSG-015

**Description:** Verify behavior when contact permission is revoked while the app is running.

**Preconditions:**
- User is logged in
- User initially has permission to access contacts
- User is in an active chat

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Revoke contact permission in device settings while app is in background. | Permission is revoked. |
| 2 | 2. Return to the app and open the chat. | Chat screen is displayed. |
| 3 | 3. Tap the attachment/share icon and choose 'Contact'. | Error message indicates access is denied. |

**Final Expected Result:** App shows a clear permission error and does not proceed with sharing.

---

### TC-217: TC10 - Performance: Kontaktliste öffnet zeitnah

**Type:** performance
**Priority:** low
**Status:** manual
**User Story:** US-025
**Requirement:** WA-MSG-015

**Description:** Verify contact share dialog opens within acceptable time.

**Preconditions:**
- User is logged in
- User has permission to access contacts
- Device contains a large number of contacts (e.g., 1000+)
- User is in an active chat

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the chat conversation. | Chat screen is displayed. |
| 2 | 2. Tap the attachment/share icon and choose 'Contact'. | Contact selection dialog opens within acceptable response time (e.g., <= 2 seconds). |

**Final Expected Result:** Contact selection dialog opens within defined performance threshold.

---

### TC-218: Create group chat with valid name and two participants

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-026
**Requirement:** WA-GRP-001

**Description:** Verify group chat is created and appears in chat list with valid inputs

**Preconditions:**
- User is logged in
- User is on chat overview
- At least two contacts are available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the 'Create Group' dialog | Create Group dialog is displayed |
| 2 | 2. Enter a valid group name | Group name field accepts the input |
| 3 | 3. Select exactly two participants | Both participants are selected |
| 4 | 4. Click 'Create Group' | Group creation request is submitted |

**Final Expected Result:** A new group chat is created and displayed in the chat list

---

### TC-219: Create group chat with valid name and multiple participants

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-026
**Requirement:** WA-GRP-001

**Description:** Verify group chat creation with more than two participants

**Preconditions:**
- User is logged in
- User is on chat overview
- At least three contacts are available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the 'Create Group' dialog | Create Group dialog is displayed |
| 2 | 2. Enter a valid group name | Group name field accepts the input |
| 3 | 3. Select three or more participants | All selected participants are shown as selected |
| 4 | 4. Click 'Create Group' | Group creation request is submitted |

**Final Expected Result:** A new group chat with all selected participants is created and listed

---

### TC-220: Prevent group creation without group name

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-026
**Requirement:** WA-GRP-001

**Description:** Validate that group creation is blocked when the name is missing

**Preconditions:**
- User is logged in
- User is on chat overview
- At least two contacts are available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the 'Create Group' dialog | Create Group dialog is displayed |
| 2 | 2. Leave group name field empty | Group name field is empty |
| 3 | 3. Select two participants | Two participants are selected |
| 4 | 4. Click 'Create Group' | Validation is triggered |

**Final Expected Result:** Group creation is blocked and a clear validation message about missing name is shown

---

### TC-221: Prevent group creation with only one participant

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-026
**Requirement:** WA-GRP-001

**Description:** Validate that at least two participants are required

**Preconditions:**
- User is logged in
- User is on chat overview
- At least one contact is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the 'Create Group' dialog | Create Group dialog is displayed |
| 2 | 2. Enter a valid group name | Group name field accepts the input |
| 3 | 3. Select exactly one participant | One participant is selected |
| 4 | 4. Click 'Create Group' | Validation is triggered |

**Final Expected Result:** Group creation is blocked and a clear validation message about participant count is shown

---

### TC-222: Prevent group creation with zero participants

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-026
**Requirement:** WA-GRP-001

**Description:** Validate that selecting no participants is not allowed

**Preconditions:**
- User is logged in
- User is on chat overview
- Contacts are available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the 'Create Group' dialog | Create Group dialog is displayed |
| 2 | 2. Enter a valid group name | Group name field accepts the input |
| 3 | 3. Do not select any participants | No participants are selected |
| 4 | 4. Click 'Create Group' | Validation is triggered |

**Final Expected Result:** Group creation is blocked and a clear validation message about participant count is shown

---

### TC-223: Boundary: Group name with leading/trailing spaces

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-026
**Requirement:** WA-GRP-001

**Description:** Verify group name is handled correctly when it includes leading/trailing spaces

**Preconditions:**
- User is logged in
- User is on chat overview
- At least two contacts are available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the 'Create Group' dialog | Create Group dialog is displayed |
| 2 | 2. Enter a group name with leading/trailing spaces | Group name field accepts the input |
| 3 | 3. Select two participants | Two participants are selected |
| 4 | 4. Click 'Create Group' | Group creation request is submitted |

**Final Expected Result:** Group is created and displayed with a properly trimmed group name

---

### TC-224: Network instability during group creation

**Type:** integration
**Priority:** high
**Status:** manual
**User Story:** US-026
**Requirement:** WA-GRP-001

**Description:** Verify error handling and ability to retry without data loss on unstable network

**Preconditions:**
- User is logged in
- User is on chat overview
- At least two contacts are available
- Network is unstable or request failure can be simulated

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the 'Create Group' dialog | Create Group dialog is displayed |
| 2 | 2. Enter a valid group name | Group name field accepts the input |
| 3 | 3. Select two participants | Two participants are selected |
| 4 | 4. Click 'Create Group' while network is unstable | An error is displayed indicating the creation failed |
| 5 | 5. Verify the dialog retains the entered name and selected participants | Entered data remains unchanged |
| 6 | 6. Retry by clicking 'Create Group' after network is restored | Group creation request is resubmitted |

**Final Expected Result:** Error is shown on failure; user can retry without losing data and group is created on successful retry

---

### TC-225: Group appears in chat list after creation

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-026
**Requirement:** WA-GRP-001

**Description:** Verify the newly created group is visible in the chat list immediately

**Preconditions:**
- User is logged in
- User is on chat overview
- At least two contacts are available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Create a group with a unique name and two participants | Group creation succeeds |
| 2 | 2. Return to chat overview if not already visible | Chat list is displayed |
| 3 | 3. Search or scroll in the chat list for the group name | New group is visible in the list |

**Final Expected Result:** Newly created group appears in chat list and is accessible

---

### TC-226: Assign role to group member and verify visibility

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-027
**Requirement:** WA-GRP-002

**Description:** Verify role assignment is saved immediately and visible to all group members

**Preconditions:**
- Support-Administrator has admin rights in the existing group
- At least two group members exist, including target user
- Group members can view member list

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to the group member management page as Support-Administrator | Member list is displayed with current roles |
| 2 | 2. Select target user and assign a new role (e.g., Moderator) | Role assignment action is accepted |
| 3 | 3. Save the role change | Confirmation of saved role change is shown |
| 4 | 4. Refresh the member list | Target user shows updated role |
| 5 | 5. Log in as another group member and view the member list | Target user’s updated role is visible to the member |

**Final Expected Result:** Role change is immediately saved and visible to all members

---

### TC-227: Remove role from group member and verify visibility

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-027
**Requirement:** WA-GRP-002

**Description:** Verify role removal is saved immediately and visible to all group members

**Preconditions:**
- Support-Administrator has admin rights in the existing group
- Target user currently has a non-default role

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to the group member management page | Member list is displayed with current roles |
| 2 | 2. Select target user and remove assigned role (set to default member) | Role removal action is accepted |
| 3 | 3. Save the role change | Confirmation of saved role change is shown |
| 4 | 4. Refresh the member list | Target user shows default role |
| 5 | 5. Log in as another group member and view the member list | Target user’s role removal is visible |

**Final Expected Result:** Role removal is immediately saved and visible to all members

---

### TC-228: Change group visibility setting and verify activity log

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-027
**Requirement:** WA-GRP-002

**Description:** Verify changes to group visibility take effect immediately and are logged

**Preconditions:**
- Support-Administrator has admin rights in the group
- Group has configurable privacy settings
- Activity log is enabled

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to group privacy settings | Current visibility and join rules are displayed |
| 2 | 2. Change group visibility from Private to Public | New visibility value is selected |
| 3 | 3. Save settings | Success message indicates settings saved |
| 4 | 4. Check group visibility on the group header/page | Group visibility reflects Public immediately |
| 5 | 5. Open the activity log | An entry exists for the visibility change with timestamp and actor |

**Final Expected Result:** Visibility changes are immediately effective and recorded in activity log

---

### TC-229: Change group join rules and verify activity log

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-027
**Requirement:** WA-GRP-002

**Description:** Verify changes to join rules take effect immediately and are logged

**Preconditions:**
- Support-Administrator has admin rights in the group
- Group has configurable join rules
- Activity log is enabled

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to group privacy settings | Current join rules are displayed |
| 2 | 2. Change join rules from 'Approval Required' to 'Open' | New join rule is selected |
| 3 | 3. Save settings | Success message indicates settings saved |
| 4 | 4. Attempt to join the group as a new user (if allowed by rules) | Join behavior reflects new rule immediately |
| 5 | 5. Open the activity log | An entry exists for the join rule change with timestamp and actor |

**Final Expected Result:** Join rule changes are immediately effective and recorded in activity log

---

### TC-230: Remove policy-violating post and notify creator

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-027
**Requirement:** WA-GRP-002

**Description:** Verify content moderation removes violating post and notifies creator with reason

**Preconditions:**
- Group has content moderation enabled
- A post exists that violates guidelines
- Support-Administrator has admin rights

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to the violating post as Support-Administrator | Post details are displayed with moderation options |
| 2 | 2. Select 'Remove post' and provide a reason | Removal action is accepted |
| 3 | 3. Confirm removal | Post is removed from the group feed |
| 4 | 4. Log in as the post creator and check notifications | Notification is received with the specified reason |

**Final Expected Result:** Violating post is deleted and creator is notified with reason

---

### TC-231: Attempt to remove user without sufficient permission

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-027
**Requirement:** WA-GRP-002

**Description:** Verify unauthorized removal is rejected with a clear error message

**Preconditions:**
- Support-Administrator does not have sufficient permission to remove a specific user
- Target user exists in the group

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to member management | Member list is displayed |
| 2 | 2. Attempt to remove the target user | System prompts or attempts to execute removal |
| 3 | 3. Confirm the removal action | Action is rejected and an error message is shown |

**Final Expected Result:** Removal is blocked with a clear, understandable error message

---

### TC-232: Boundary: Assign role to user already in the role

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-027
**Requirement:** WA-GRP-002

**Description:** Verify system handles role assignment when the user already has the target role

**Preconditions:**
- Support-Administrator has admin rights
- Target user already has the role to be assigned

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to member management | Member list is displayed with current roles |
| 2 | 2. Attempt to assign the same role to the target user | System processes the action |
| 3 | 3. Save the change | System indicates no change was necessary or confirms idempotent save |

**Final Expected Result:** System handles duplicate role assignment gracefully without error

---

### TC-233: Boundary: Change privacy settings with minimum required fields

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-027
**Requirement:** WA-GRP-002

**Description:** Verify saving privacy settings works with minimal valid configuration

**Preconditions:**
- Support-Administrator has admin rights
- Group privacy settings available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to group privacy settings | Settings form is displayed |
| 2 | 2. Set visibility and join rules to valid minimum values | Values are accepted by the UI |
| 3 | 3. Save settings | Success message indicates settings saved |

**Final Expected Result:** Privacy settings save successfully with minimal valid configuration

---

### TC-234: Activity log entry for role change

**Type:** integration
**Priority:** low
**Status:** manual
**User Story:** US-027
**Requirement:** WA-GRP-002

**Description:** Verify role assignment/removal is logged in activity log (if applicable)

**Preconditions:**
- Activity log is enabled for the group
- Support-Administrator has admin rights

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Assign a role to a user | Role change is saved |
| 2 | 2. Open the activity log | An entry exists for the role change with timestamp and actor |

**Final Expected Result:** Role changes are recorded in the activity log

---

### TC-235: Save valid group settings as administrator

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-028
**Requirement:** WA-GRP-003

**Description:** Verify that an administrator can save valid settings and they apply immediately

**Preconditions:**
- User is logged in as Gruppenadministrator
- Existing group is accessible
- User has Administratorrechte for the group

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to the group's settings page | Group settings page is displayed with current configuration |
| 2 | 2. Change settings to valid values (e.g., communication mode, privacy level, notification frequency) | New values are accepted by the UI without validation errors |
| 3 | 3. Click 'Speichern' (Save) | Success confirmation is shown |
| 4 | 4. Open group overview or relevant section affected by settings | Settings effects are immediately reflected in the group behavior |

**Final Expected Result:** Valid settings are saved persistently and applied immediately

---

### TC-236: Persisted settings remain after page reload

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-028
**Requirement:** WA-GRP-003

**Description:** Verify that saved settings persist after refresh or re-login

**Preconditions:**
- User is logged in as Gruppenadministrator
- Existing group is accessible
- User has already saved non-default valid settings

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Refresh the group settings page | Page reloads without error |
| 2 | 2. Verify previously saved settings values | Saved settings are displayed and unchanged |
| 3 | 3. Log out and log back in, then navigate to group settings | Group settings page is displayed |
| 4 | 4. Verify the saved settings again | Saved settings persist across sessions |

**Final Expected Result:** Settings are stored persistently and survive reloads and sessions

---

### TC-237: Reset a setting to default and save

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-028
**Requirement:** WA-GRP-003

**Description:** Verify that resetting a setting to its default value is saved and shown correctly

**Preconditions:**
- User is logged in as Gruppenadministrator
- Existing group is accessible
- A setting has been changed from its default

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to group settings | Settings page loads with current values |
| 2 | 2. Use the 'Reset to default' option for a setting | Setting value changes to the default value in the UI |
| 3 | 3. Click 'Speichern' (Save) | Success confirmation is shown |
| 4 | 4. Check settings overview | Default value is displayed correctly in the overview |

**Final Expected Result:** Default value is applied and displayed correctly after saving

---

### TC-238: Non-admin user attempts to change settings

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-028
**Requirement:** WA-GRP-003

**Description:** Verify that users without admin rights cannot modify group settings

**Preconditions:**
- User is logged in without Gruppenadministrator rights
- Existing group is accessible

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to group settings page | Settings page access is restricted or read-only view is shown |
| 2 | 2. Attempt to modify a setting | Change is prevented in the UI or blocked on save |
| 3 | 3. Click 'Speichern' (Save) if available | Action is refused and a clear error message is displayed |

**Final Expected Result:** Unauthorized changes are blocked and an understandable error message is shown

---

### TC-239: Validation error for invalid setting value

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-028
**Requirement:** WA-GRP-003

**Description:** Verify validation prevents saving invalid settings

**Preconditions:**
- User is logged in as Gruppenadministrator
- Existing group is accessible

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to group settings | Settings page loads |
| 2 | 2. Enter an invalid value for a setting (e.g., out-of-range numeric value) | Validation message is displayed indicating invalid input |
| 3 | 3. Click 'Speichern' (Save) | Save is blocked and validation error remains visible |

**Final Expected Result:** Invalid settings are not saved and user receives validation feedback

---

### TC-240: Boundary values for numeric settings

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-028
**Requirement:** WA-GRP-003

**Description:** Verify minimum and maximum allowable values are accepted

**Preconditions:**
- User is logged in as Gruppenadministrator
- Existing group is accessible
- A numeric setting with defined min/max exists

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Set numeric setting to its minimum allowed value | Value is accepted without error |
| 2 | 2. Click 'Speichern' (Save) | Settings save successfully |
| 3 | 3. Set numeric setting to its maximum allowed value | Value is accepted without error |
| 4 | 4. Click 'Speichern' (Save) | Settings save successfully |

**Final Expected Result:** Boundary values are accepted and saved correctly

---

### TC-241: Immediate effect of settings on group communication

**Type:** integration
**Priority:** high
**Status:** manual
**User Story:** US-028
**Requirement:** WA-GRP-003

**Description:** Verify that settings changes take effect immediately after saving

**Preconditions:**
- User is logged in as Gruppenadministrator
- Existing group is accessible
- Group has active communication features

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to group settings | Settings page loads |
| 2 | 2. Change a setting that affects communication (e.g., disable media sharing) | New value is selected |
| 3 | 3. Click 'Speichern' (Save) | Success confirmation is shown |
| 4 | 4. Attempt the affected action in the group (e.g., try to share media) | Action behavior reflects new setting immediately |

**Final Expected Result:** Group behavior updates immediately after saving settings

---

### TC-242: Unauthorized API call to update settings

**Type:** integration
**Priority:** high
**Status:** manual
**User Story:** US-028
**Requirement:** WA-GRP-003

**Description:** Verify backend rejects settings updates without admin rights

**Preconditions:**
- User is authenticated without Gruppenadministrator rights
- API endpoint for saving settings is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Submit a settings update request to the API | Request is processed by the server |
| 2 | 2. Inspect API response | Response indicates unauthorized/forbidden and no settings are changed |

**Final Expected Result:** Server blocks unauthorized settings updates and returns a clear error

---

### TC-243: Concurrent update conflict handling

**Type:** integration
**Priority:** medium
**Status:** manual
**User Story:** US-028
**Requirement:** WA-GRP-003

**Description:** Verify latest saved settings are consistent when two admins update

**Preconditions:**
- Two users are logged in as Gruppenadministrator for the same group
- Existing group is accessible

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Admin A opens group settings | Settings page loads for Admin A |
| 2 | 2. Admin B opens group settings | Settings page loads for Admin B |
| 3 | 3. Admin A changes a setting and saves | Admin A receives success confirmation |
| 4 | 4. Admin B changes the same setting to a different value and saves | Admin B receives success confirmation |
| 5 | 5. Reload settings page | Settings reflect the system's final applied value (e.g., last write wins or conflict resolution) |

**Final Expected Result:** System handles concurrent updates predictably and displays the final saved state

---

### TC-244: Generate invitation link as authorized group admin

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-029
**Requirement:** WA-GRP-004

**Description:** Verify an authenticated group admin can generate a unique, shareable invitation link

**Preconditions:**
- Group exists
- User is authenticated
- User has group admin permissions
- User is on group management page

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Click 'Create Invitation Link' for the group | A new invitation link is generated and displayed |
| 2 | 2. Copy the generated link | Link is copyable without errors |

**Final Expected Result:** A unique, shareable invitation link is generated and displayed to the admin

---

### TC-245: Prevent invitation link generation by non-admin

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-029
**Requirement:** WA-GRP-004

**Description:** Verify users without group admin permission cannot generate invitation links

**Preconditions:**
- Group exists
- User is authenticated
- User does not have group admin permissions
- User is on group page

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Attempt to access invitation link generation action | Action is hidden or access denied |
| 2 | 2. If accessible, click 'Create Invitation Link' | Request is blocked and an authorization error is shown |

**Final Expected Result:** Non-admin users cannot generate invitation links

---

### TC-246: Join group using valid invitation link

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-029
**Requirement:** WA-GRP-004

**Description:** Verify invited user can join the group using a valid link

**Preconditions:**
- Valid invitation link exists
- Invited user is authenticated or can authenticate during flow
- Invited user is not already a group member

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the valid invitation link | Join group page is displayed |
| 2 | 2. Confirm join action | User is added to the group |
| 3 | 3. Navigate to group page | User sees group content and membership status |

**Final Expected Result:** User joins the group and receives a confirmation

---

### TC-247: Open valid invitation link on different platform

**Type:** e2e
**Priority:** medium
**Status:** manual
**User Story:** US-029
**Requirement:** WA-GRP-004

**Description:** Verify cross-platform access works for invitation link

**Preconditions:**
- Valid invitation link exists
- Invited user has access to a different platform/device
- Invited user is authenticated or can authenticate during flow

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the invitation link on a different platform/device | Join group page loads correctly |
| 2 | 2. Complete join action | User is added to the group |

**Final Expected Result:** Invitation link works across platforms for joining the group

---

### TC-248: Prevent join with expired invitation link

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-029
**Requirement:** WA-GRP-004

**Description:** Verify an expired invitation link blocks joining with a clear error

**Preconditions:**
- Invitation link exists and is expired
- User is authenticated or can authenticate during flow

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the expired invitation link | User sees an error indicating the link is expired |
| 2 | 2. Attempt to proceed with join action if available | Join action is blocked |

**Final Expected Result:** Joining is prevented and a clear expired-link message is shown

---

### TC-249: Prevent join with deactivated invitation link

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-029
**Requirement:** WA-GRP-004

**Description:** Verify a deactivated invitation link blocks joining with a clear error

**Preconditions:**
- Invitation link exists and is deactivated
- User is authenticated or can authenticate during flow

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the deactivated invitation link | User sees an error indicating the link is deactivated |
| 2 | 2. Attempt to proceed with join action if available | Join action is blocked |

**Final Expected Result:** Joining is prevented and a clear deactivated-link message is shown

---

### TC-250: Prevent join with malformed invitation link

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-029
**Requirement:** WA-GRP-004

**Description:** Verify a malformed or invalid invitation link does not allow joining

**Preconditions:**
- User is authenticated or can authenticate during flow

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open a malformed or tampered invitation link | User sees an error indicating the link is invalid |

**Final Expected Result:** Joining is prevented and an invalid-link error is shown

---

### TC-251: Invitation link uniqueness per generation

**Type:** integration
**Priority:** medium
**Status:** manual
**User Story:** US-029
**Requirement:** WA-GRP-004

**Description:** Verify each generated link is unique for the group

**Preconditions:**
- Group exists
- User is authenticated
- User has group admin permissions

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Generate an invitation link for the group | A link is generated and displayed |
| 2 | 2. Generate a second invitation link for the same group | A new link is generated and displayed |
| 3 | 3. Compare the two generated links | Links are different |

**Final Expected Result:** Each generated invitation link is unique

---

### TC-252: Reusing valid link after successful join

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-029
**Requirement:** WA-GRP-004

**Description:** Verify a valid link can be used by another user after one user joins

**Preconditions:**
- Valid invitation link exists
- User A is authenticated and not a group member
- User B is authenticated and not a group member

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. User A opens the valid invitation link and joins the group | User A is added to the group with confirmation |
| 2 | 2. User B opens the same invitation link | Join group page is displayed |
| 3 | 3. User B confirms join action | User B is added to the group with confirmation |

**Final Expected Result:** Valid invitation link can be used by multiple users until deactivated/expired

---

### TC-253: Prevent duplicate join for existing member

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-029
**Requirement:** WA-GRP-004

**Description:** Verify a user already in the group cannot join again via valid link

**Preconditions:**
- Valid invitation link exists
- User is authenticated
- User is already a group member

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the valid invitation link | System detects existing membership |
| 2 | 2. Attempt to confirm join action | Join action is blocked with a message indicating existing membership |

**Final Expected Result:** User is not added again and receives a clear message

---

### TC-254: Unauthenticated user opens valid invitation link

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-029
**Requirement:** WA-GRP-004

**Description:** Verify unauthenticated users are prompted to authenticate before joining

**Preconditions:**
- Valid invitation link exists
- User is not authenticated

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the valid invitation link | User is prompted to log in or register |
| 2 | 2. Complete authentication | User is returned to join flow |
| 3 | 3. Confirm join action | User is added to the group with confirmation |

**Final Expected Result:** Unauthenticated users can authenticate and then join successfully

---

### TC-255: Performance of invitation link generation

**Type:** performance
**Priority:** low
**Status:** manual
**User Story:** US-029
**Requirement:** WA-GRP-004

**Description:** Verify invitation link generation completes within acceptable time

**Preconditions:**
- Group exists
- User is authenticated
- User has group admin permissions

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Click 'Create Invitation Link' and measure response time | Link is generated within the defined performance threshold |

**Final Expected Result:** Invitation link generation meets performance requirements

---

### TC-256: Leave group successfully without notifications

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-030
**Requirement:** WA-GRP-005

**Description:** Verify an active group member can leave and no notifications are sent to other members

**Preconditions:**
- User is logged in
- User is an active member of Group A
- At least one other member exists in Group A
- Network connection is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to Group A details page | Group A details page is displayed |
| 2 | 2. Click on the 'Gruppe verlassen' (Leave group) action | A confirmation prompt is displayed (if applicable) |
| 3 | 3. Confirm leaving the group | User is removed from Group A and redirected/updated to non-member state |
| 4 | 4. Check notifications/feed for other members in Group A | No notification about the user leaving is present |

**Final Expected Result:** User is removed from the group and no notification is sent to other members

---

### TC-257: Leave group with no network connection

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-030
**Requirement:** WA-GRP-005

**Description:** Verify error is shown and membership is unchanged when offline

**Preconditions:**
- User is logged in
- User is an active member of Group A
- Device has no network connection

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to Group A details page | Group A details page is displayed |
| 2 | 2. Click on the 'Gruppe verlassen' (Leave group) action | An error message indicating no network connection is displayed |
| 3 | 3. Refresh or re-open Group A details page | User is still shown as a member of Group A |

**Final Expected Result:** User remains a member and receives an appropriate offline error message

---

### TC-258: Attempt to leave a group when not a member

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-030
**Requirement:** WA-GRP-005

**Description:** Verify informative message is shown and no changes occur when user is not in the group

**Preconditions:**
- User is logged in
- User is not a member of Group A
- Network connection is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to Group A details page | Group A details page is displayed |
| 2 | 2. Trigger 'Gruppe verlassen' (Leave group) action if available | System displays a message indicating the user is not a member or cannot leave |
| 3 | 3. Verify membership status for Group A | User remains not a member and no changes are made |

**Final Expected Result:** User is informed they are not a member and no state changes occur

---

### TC-259: Leave group action is idempotent (repeated attempts)

**Type:** integration
**Priority:** medium
**Status:** manual
**User Story:** US-030
**Requirement:** WA-GRP-005

**Description:** Verify repeated leave requests after a successful leave do not cause errors or state changes

**Preconditions:**
- User is logged in
- User has just left Group A successfully
- Network connection is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Attempt to access Group A leave action again | System shows user is not a member or action is disabled |
| 2 | 2. Confirm no membership change occurs | User remains not a member of Group A |

**Final Expected Result:** No errors; user remains not a member and action is safely handled

---

### TC-260: Leave group confirmation flow cancellation

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-030
**Requirement:** WA-GRP-005

**Description:** Verify canceling the leave action keeps user as member

**Preconditions:**
- User is logged in
- User is an active member of Group A
- Network connection is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to Group A details page | Group A details page is displayed |
| 2 | 2. Click on 'Gruppe verlassen' (Leave group) | A confirmation prompt is displayed (if applicable) |
| 3 | 3. Cancel the confirmation | User remains a member and no changes are made |

**Final Expected Result:** Membership remains unchanged when the leave action is canceled

---

### TC-261: Leave group removes access to group content

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-030
**Requirement:** WA-GRP-005

**Description:** Verify user no longer has access to group content after leaving

**Preconditions:**
- User is logged in
- User is an active member of Group A
- Network connection is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Leave Group A successfully | User is removed from Group A |
| 2 | 2. Attempt to access Group A content (posts/members list) | Access is denied or user is prompted to join |

**Final Expected Result:** User cannot access group content after leaving

---

### TC-262: Leave group with unstable network during request

**Type:** integration
**Priority:** medium
**Status:** manual
**User Story:** US-030
**Requirement:** WA-GRP-005

**Description:** Verify proper error handling and membership consistency when network drops mid-request

**Preconditions:**
- User is logged in
- User is an active member of Group A
- Network connection is initially available but can be interrupted

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Initiate 'Gruppe verlassen' action | Leave request is sent |
| 2 | 2. Simulate network drop before response | User receives a failure/error message |
| 3 | 3. Reconnect and refresh Group A details page | Membership status is consistent (either still member if request failed or not a member if succeeded); no partial state |

**Final Expected Result:** System maintains consistent membership state and provides a clear error message

---

### TC-263: No notification sent to other members upon leave

**Type:** integration
**Priority:** high
**Status:** manual
**User Story:** US-030
**Requirement:** WA-GRP-005

**Description:** Verify notification service is not triggered when a member leaves

**Preconditions:**
- User is logged in
- User is an active member of Group A
- Notification service logging is accessible
- Network connection is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Leave Group A successfully | User is removed from Group A |
| 2 | 2. Check notification service logs or queues for Group A | No notification event related to the user leaving is present |

**Final Expected Result:** No notifications are generated for other members

---

### TC-264: Create community with at least two groups

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-031
**Requirement:** WA-GRP-006

**Description:** Verify a community manager can create a community with multiple groups and it appears in overview

**Preconditions:**
- User has Community-Manager role
- User is logged in
- User is in Community area

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Click 'Create Community' | Community creation form is displayed |
| 2 | 2. Enter community name and description | Community details are accepted |
| 3 | 3. Add Group A and Group B | Both groups are listed in the form |
| 4 | 4. Click 'Save' | Community is saved successfully |
| 5 | 5. Open community overview | New community appears with Group A and Group B listed |

**Final Expected Result:** Community is created, saved with all groups, and visible in overview

---

### TC-265: Create community with more than two groups

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-031
**Requirement:** WA-GRP-006

**Description:** Verify creation works with multiple groups beyond the minimum

**Preconditions:**
- User has Community-Manager role
- User is logged in
- User is in Community area

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Click 'Create Community' | Community creation form is displayed |
| 2 | 2. Enter community name | Community name is accepted |
| 3 | 3. Add Group A, Group B, Group C, Group D | All four groups are listed in the form |
| 4 | 4. Click 'Save' | Community is saved successfully |
| 5 | 5. Open community overview | Community appears with all four groups listed |

**Final Expected Result:** Community is created and saved with all groups

---

### TC-266: Prevent community creation without groups

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-031
**Requirement:** WA-GRP-006

**Description:** Verify validation blocks saving a community without any group

**Preconditions:**
- User has Community-Manager role
- User is logged in
- User is in Community area

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Click 'Create Community' | Community creation form is displayed |
| 2 | 2. Enter community name | Community name is accepted |
| 3 | 3. Ensure no groups are added | Group list remains empty |
| 4 | 4. Click 'Save' | Error message is shown indicating at least one group is required |

**Final Expected Result:** Community is not created and user sees a validation error

---

### TC-267: Rename existing group and save immediately

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-031
**Requirement:** WA-GRP-006

**Description:** Verify group rename is saved and visible

**Preconditions:**
- User has Community-Manager role
- User is logged in
- A community exists with at least two groups
- User is in Community area

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open existing community details | Community details and groups are displayed |
| 2 | 2. Rename Group A to Group A1 | Group name updates in the UI |
| 3 | 3. Navigate away and return to community details | Renamed group persists as Group A1 |

**Final Expected Result:** Renamed group is saved immediately and persists on reload

---

### TC-268: Add a new group to existing community

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-031
**Requirement:** WA-GRP-006

**Description:** Verify adding a group to an existing community saves immediately

**Preconditions:**
- User has Community-Manager role
- User is logged in
- A community exists with at least two groups
- User is in Community area

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open existing community details | Community details and groups are displayed |
| 2 | 2. Add Group C | Group C appears in the group list |
| 3 | 3. Refresh the page | Group C remains in the group list |

**Final Expected Result:** New group is saved immediately and persists after refresh

---

### TC-269: Platform-wide visibility after group change

**Type:** integration
**Priority:** medium
**Status:** manual
**User Story:** US-031
**Requirement:** WA-GRP-006

**Description:** Verify changes are visible across different platforms/sessions

**Preconditions:**
- User has Community-Manager role
- User is logged in on Web
- A community exists with multiple groups
- A second session is available (e.g., mobile or another browser)

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. In Web session, rename Group A to Group A1 | Group name updates in Web UI |
| 2 | 2. In second session, open the same community | Group name appears as Group A1 |

**Final Expected Result:** Group changes are visible across sessions/platforms

---

### TC-270: Boundary: attempt to save with exactly one group

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-031
**Requirement:** WA-GRP-006

**Description:** Verify behavior when creating a community with only one group (boundary condition)

**Preconditions:**
- User has Community-Manager role
- User is logged in
- User is in Community area

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Click 'Create Community' | Community creation form is displayed |
| 2 | 2. Enter community name | Community name is accepted |
| 3 | 3. Add only Group A | Group A is listed in the form |
| 4 | 4. Click 'Save' | Validation should prevent save if minimum is two groups, or allow if only at least one is required |

**Final Expected Result:** System enforces group count rule as defined; save is blocked if two groups are required

---

### TC-271: Create One-Way-Broadcast-Kanal and send message to all subscribers

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-032
**Requirement:** WA-GRP-007

**Description:** Verify admin can create a one-way broadcast channel and send a message to all subscribers; only admins can post

**Preconditions:**
- Administrator is authenticated
- Administrator has channel management permission
- At least 3 subscribers exist

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to channel management | Channel management page is displayed |
| 2 | 2. Create a new channel with type 'One-Way-Broadcast' and save | Channel is created and visible in channel list |
| 3 | 3. Add 3 subscribers to the channel | Subscribers are listed as members of the channel |
| 4 | 4. Send a message from the admin account | Message is accepted and marked as sent |
| 5 | 5. Check each subscriber's inbox | Each subscriber receives the message |
| 6 | 6. Attempt to post from a non-admin member account | Post action is blocked |

**Final Expected Result:** Message is delivered to all subscribers and only admins can post in the channel

---

### TC-272: Block subscriber from posting in One-Way-Broadcast-Kanal

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-032
**Requirement:** WA-GRP-007

**Description:** Ensure a subscriber cannot send messages and receives a clear error

**Preconditions:**
- Subscriber is registered in One-Way-Broadcast channel
- Subscriber is authenticated

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the One-Way-Broadcast channel as subscriber | Channel view is displayed with read-only indicator |
| 2 | 2. Attempt to type and send a message | Send action is blocked |
| 3 | 3. Observe system response | Clear error message indicates only admins can post |

**Final Expected Result:** Subscriber is blocked from posting and receives a clear error message

---

### TC-273: Notify admin on partial delivery failure and retry delivery

**Type:** integration
**Priority:** high
**Status:** manual
**User Story:** US-032
**Requirement:** WA-GRP-007

**Description:** Verify admin is informed about failed deliveries and system retries for affected recipients

**Preconditions:**
- Administrator is authenticated with permissions
- One-Way-Broadcast channel exists
- At least 2 subscribers are configured with one unreachable endpoint

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Trigger a message send from admin | Message sending process starts |
| 2 | 2. Simulate delivery failure to one subscriber | System records failed delivery for that subscriber |
| 3 | 3. Check admin notifications/logs | Admin is informed about failed deliveries with details |
| 4 | 4. Verify retry mechanism is executed for failed recipient | System retries delivery for the failed recipient |
| 5 | 5. Confirm eventual delivery after endpoint becomes reachable | Failed recipient receives the message after retry |

**Final Expected Result:** Admin is informed of failures and system retries delivery for affected recipients

---

### TC-274: Non-admin attempt to create One-Way-Broadcast-Kanal

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-032
**Requirement:** WA-GRP-007

**Description:** Ensure users without channel management permission cannot create broadcast channels

**Preconditions:**
- User is authenticated
- User lacks channel management permission

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to channel management | Access is denied or restricted view is shown |
| 2 | 2. Attempt to create a One-Way-Broadcast channel | Creation is blocked |
| 3 | 3. Observe system response | Clear error or permission message is displayed |

**Final Expected Result:** Unauthorized user cannot create One-Way-Broadcast channels

---

### TC-275: Admin can post in One-Way-Broadcast-Kanal

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-032
**Requirement:** WA-GRP-007

**Description:** Verify administrators can post messages in a One-Way-Broadcast channel

**Preconditions:**
- Administrator is authenticated
- One-Way-Broadcast channel exists

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the One-Way-Broadcast channel as admin | Channel view allows posting |
| 2 | 2. Post a message | Message is accepted and appears in channel |

**Final Expected Result:** Admin can post messages in the channel

---

### TC-276: Boundary: Send message with maximum allowed length

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-032
**Requirement:** WA-GRP-007

**Description:** Ensure message at maximum length is accepted and delivered

**Preconditions:**
- Administrator is authenticated
- One-Way-Broadcast channel exists
- System max message length is known (e.g., 1000 characters)

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Compose a message with exactly the maximum allowed length | Message input accepts the content without validation error |
| 2 | 2. Send the message | Message is sent successfully |
| 3 | 3. Verify delivery to subscribers | All subscribers receive the full message |

**Final Expected Result:** Maximum-length message is successfully delivered

---

### TC-277: Boundary: Send message exceeding maximum allowed length

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-032
**Requirement:** WA-GRP-007

**Description:** Ensure message exceeding max length is rejected with clear error

**Preconditions:**
- Administrator is authenticated
- One-Way-Broadcast channel exists
- System max message length is known (e.g., 1000 characters)

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Compose a message with length greater than the maximum | Validation triggers before send or at send time |
| 2 | 2. Attempt to send the message | Send is blocked |
| 3 | 3. Observe system response | Clear error indicates message length exceeds limit |

**Final Expected Result:** Over-limit message is rejected with a clear error

---

### TC-278: Subscriber view is read-only for broadcast channel

**Type:** functional
**Priority:** low
**Status:** manual
**User Story:** US-032
**Requirement:** WA-GRP-007

**Description:** Validate UI indicates read-only access for subscribers in broadcast channel

**Preconditions:**
- Subscriber is authenticated
- Subscriber is registered in One-Way-Broadcast channel

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the One-Way-Broadcast channel as subscriber | Read-only indicator is visible |
| 2 | 2. Verify message input is disabled or hidden | Message input is disabled or not present |

**Final Expected Result:** Subscriber sees read-only UI state for the channel

---

### TC-279: Retry delivery after transient failure without duplicate delivery

**Type:** integration
**Priority:** medium
**Status:** manual
**User Story:** US-032
**Requirement:** WA-GRP-007

**Description:** Ensure retries do not cause duplicate messages after a transient failure

**Preconditions:**
- Administrator is authenticated
- One-Way-Broadcast channel exists
- A subscriber has intermittent connectivity

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Send a message as admin | Message send initiated |
| 2 | 2. Simulate transient failure then recovery | System marks initial delivery as failed then retries |
| 3 | 3. Check subscriber inbox | Subscriber receives only one instance of the message |

**Final Expected Result:** Retry mechanism delivers exactly one message per subscriber

---

### TC-280: Create and send poll in group chat with valid title and two options

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-033
**Requirement:** WA-GRP-008

**Description:** Verify a logged-in user can create and send a poll in a group chat and all members can vote

**Preconditions:**
- User is logged in
- User is a member of a group chat with at least 3 members
- User has permission to post in the group chat

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the group chat | Group chat conversation is displayed |
| 2 | 2. Click on 'Create Poll' action | Poll creation UI is displayed |
| 3 | 3. Enter a poll title and at least two answer options | Poll form accepts the input without validation errors |
| 4 | 4. Click 'Send' | Poll is sent to the group chat |
| 5 | 5. Verify visibility as another group member and cast a vote | Poll is visible and vote can be submitted successfully |

**Final Expected Result:** The poll appears in the group chat and all group members can vote

---

### TC-281: Create and send poll in one-to-one chat

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-033
**Requirement:** WA-GRP-008

**Description:** Verify a user can create and send a poll in a direct chat and both participants can vote

**Preconditions:**
- User is logged in
- User has an existing one-to-one chat with another user

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the one-to-one chat | Direct chat conversation is displayed |
| 2 | 2. Click on 'Create Poll' action | Poll creation UI is displayed |
| 3 | 3. Enter a poll title and two answer options | Poll form accepts the input without validation errors |
| 4 | 4. Click 'Send' | Poll is sent to the direct chat |
| 5 | 5. Verify the other participant can see and vote | Poll is visible and vote can be submitted successfully |

**Final Expected Result:** The poll appears in the one-to-one chat and both participants can vote

---

### TC-282: Prevent sending poll without answer options

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-033
**Requirement:** WA-GRP-008

**Description:** Verify validation prevents sending a poll with no options

**Preconditions:**
- User is logged in
- User is in any chat (group or one-to-one)

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open a chat | Chat conversation is displayed |
| 2 | 2. Click on 'Create Poll' action | Poll creation UI is displayed |
| 3 | 3. Enter a poll title and leave options empty | No options are present in the form |
| 4 | 4. Click 'Send' | Validation message appears indicating at least two options are required |

**Final Expected Result:** Poll is not sent and a validation message is shown

---

### TC-283: Prevent sending poll with only one option

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-033
**Requirement:** WA-GRP-008

**Description:** Verify validation requires at least two options (boundary condition)

**Preconditions:**
- User is logged in
- User is in any chat (group or one-to-one)

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open a chat | Chat conversation is displayed |
| 2 | 2. Click on 'Create Poll' action | Poll creation UI is displayed |
| 3 | 3. Enter a poll title and add only one option | Form shows a single option entry |
| 4 | 4. Click 'Send' | Validation message appears indicating at least two options are required |

**Final Expected Result:** Poll is not sent and a validation message is shown

---

### TC-284: Send poll in moderated group without posting permission

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-033
**Requirement:** WA-GRP-008

**Description:** Verify a user without posting permissions cannot send a poll in a moderated group

**Preconditions:**
- User is logged in
- User is a member of a moderated group chat
- User does not have permission to post in the group chat

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the moderated group chat | Group chat conversation is displayed |
| 2 | 2. Click on 'Create Poll' action | Poll creation UI is displayed |
| 3 | 3. Enter a poll title and at least two options | Poll form accepts the input |
| 4 | 4. Click 'Send' | Action is rejected and an error message is displayed |

**Final Expected Result:** Poll is not sent and a permission error message is shown

---

### TC-285: Poll is visible to all current group members after sending

**Type:** integration
**Priority:** medium
**Status:** manual
**User Story:** US-033
**Requirement:** WA-GRP-008

**Description:** Verify poll visibility for all members in a group chat after creation

**Preconditions:**
- User is logged in
- Group chat exists with at least 3 members
- User has permission to post in the group chat

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. User A creates and sends a poll with title and two options in the group chat | Poll is posted in the group chat |
| 2 | 2. User B opens the same group chat | Poll is visible in the conversation |
| 3 | 3. User C opens the same group chat | Poll is visible in the conversation |

**Final Expected Result:** All current group members can see the poll

---

### TC-286: Poll creation UI validation message for empty title

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-033
**Requirement:** WA-GRP-008

**Description:** Verify poll cannot be sent without a title (boundary condition)

**Preconditions:**
- User is logged in
- User is in any chat (group or one-to-one)

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open a chat | Chat conversation is displayed |
| 2 | 2. Click on 'Create Poll' action | Poll creation UI is displayed |
| 3 | 3. Leave the title empty and add two options | Form shows empty title and two options |
| 4 | 4. Click 'Send' | Validation message appears indicating title is required |

**Final Expected Result:** Poll is not sent and a title validation message is shown

---

### TC-287: Vote submission in group chat

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-033
**Requirement:** WA-GRP-008

**Description:** Verify a member can submit a vote after poll creation in group chat

**Preconditions:**
- User is logged in
- Group chat exists with an active poll
- User is a member of the group chat

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the group chat containing the poll | Poll is visible in the conversation |
| 2 | 2. Select an answer option | Selected option is highlighted |
| 3 | 3. Submit the vote | Vote is recorded and confirmation is shown |

**Final Expected Result:** User can vote successfully in the group chat poll

---

### TC-288: Vote submission in one-to-one chat

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-033
**Requirement:** WA-GRP-008

**Description:** Verify a participant can submit a vote after poll creation in direct chat

**Preconditions:**
- User is logged in
- One-to-one chat exists with an active poll

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the one-to-one chat containing the poll | Poll is visible in the conversation |
| 2 | 2. Select an answer option | Selected option is highlighted |
| 3 | 3. Submit the vote | Vote is recorded and confirmation is shown |

**Final Expected Result:** User can vote successfully in the direct chat poll

---

### TC-289: Create event with valid required fields

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-034
**Requirement:** WA-GRP-009

**Description:** Verify that a group member with permission can create and publish an event and that it appears in group view with notifications sent.

**Preconditions:**
- User is logged in as a group member with event planning permission
- User is a member of a group
- Event feature is enabled for the group
- Notification service is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to the group page | Group page loads with Events section visible |
| 2 | 2. Click on 'Create Event' | Event creation form is displayed |
| 3 | 3. Enter a valid Title, Date/Time in the future, and Location | Form fields accept input without errors |
| 4 | 4. Click 'Save' or 'Publish' | Success confirmation is shown |
| 5 | 5. Return to the Events list in the group view | New event appears in the list with correct details |
| 6 | 6. Check notifications for another group member | Notification about the new event is received |

**Final Expected Result:** Event is created, displayed in group view, and notifications are delivered to all group members.

---

### TC-290: Validation error when Title is missing

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-034
**Requirement:** WA-GRP-009

**Description:** Verify that the system prevents saving an event without a title and shows a clear validation message.

**Preconditions:**
- User is logged in as a group member with event planning permission
- User is a member of a group
- Event feature is enabled for the group

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to the group page and open 'Create Event' | Event creation form is displayed |
| 2 | 2. Leave the Title field empty and fill Date/Time and Location | Form accepts input for Date/Time and Location |
| 3 | 3. Click 'Save' or 'Publish' | A validation error message for Title is shown |

**Final Expected Result:** Event is not saved and a clear validation error for missing Title is displayed.

---

### TC-291: Validation error when Date/Time is missing

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-034
**Requirement:** WA-GRP-009

**Description:** Verify that the system prevents saving an event without date/time and shows a clear validation message.

**Preconditions:**
- User is logged in as a group member with event planning permission
- User is a member of a group
- Event feature is enabled for the group

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open 'Create Event' form | Event creation form is displayed |
| 2 | 2. Enter a Title and Location but leave Date/Time empty | Form accepts input for Title and Location |
| 3 | 3. Click 'Save' or 'Publish' | A validation error message for Date/Time is shown |

**Final Expected Result:** Event is not saved and a clear validation error for missing Date/Time is displayed.

---

### TC-292: Access denied for user without event planning permission

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-034
**Requirement:** WA-GRP-009

**Description:** Verify that a group member without permission cannot create an event and is informed.

**Preconditions:**
- User is logged in as a group member without event planning permission
- User is a member of a group
- Event feature is enabled for the group

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to the group page | Group page loads |
| 2 | 2. Attempt to access the 'Create Event' action (button/menu/direct URL) | Access is blocked or creation UI is disabled |
| 3 | 3. If access is attempted, proceed to submit an event creation request | System returns a permission error message |

**Final Expected Result:** User is prevented from creating an event and is informed about missing permissions.

---

### TC-293: Boundary: Minimum valid Title length

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-034
**Requirement:** WA-GRP-009

**Description:** Verify that the system accepts the minimum valid title length and saves successfully.

**Preconditions:**
- User is logged in as a group member with event planning permission
- User is a member of a group
- Event feature is enabled for the group
- Minimum title length requirement is defined

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open 'Create Event' form | Event creation form is displayed |
| 2 | 2. Enter a Title with the minimum allowed characters, valid Date/Time and Location | No validation errors are shown |
| 3 | 3. Click 'Save' or 'Publish' | Event is saved successfully |

**Final Expected Result:** Event is created with a minimum-length title.

---

### TC-294: Boundary: Event date/time in the past

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-034
**Requirement:** WA-GRP-009

**Description:** Verify system behavior when date/time is set in the past (should be rejected if not allowed).

**Preconditions:**
- User is logged in as a group member with event planning permission
- User is a member of a group
- Event feature is enabled for the group
- System rules for past dates are defined

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open 'Create Event' form | Event creation form is displayed |
| 2 | 2. Enter valid Title and Location and set Date/Time to a past value | Form accepts input |
| 3 | 3. Click 'Save' or 'Publish' | Validation error is shown if past dates are not allowed; otherwise event is saved |

**Final Expected Result:** System enforces business rule for past dates according to specification.

---

### TC-295: Notification sent to all group members upon event creation

**Type:** integration
**Priority:** high
**Status:** manual
**User Story:** US-034
**Requirement:** WA-GRP-009

**Description:** Verify that all group members receive notifications after event is created.

**Preconditions:**
- User is logged in as a group member with event planning permission
- Group has at least two other members with notification channels enabled
- Notification service is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Create an event with valid Title, Date/Time, and Location | Event is saved successfully |
| 2 | 2. Check notification inboxes for other group members | Each member receives a notification about the new event |

**Final Expected Result:** Notifications are delivered to all group members when a new event is created.

---

### TC-296: Start encrypted voice call when both users are online

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-035
**Requirement:** WA-CALL-001

**Description:** Verify that a voice call is established and remains encrypted when both users are online and have the app installed.

**Preconditions:**
- End user and contact accounts exist
- Both users are logged in on supported devices
- Both users are online
- Both users have the app installed
- Network connection is stable

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. End user opens the contact profile and taps the voice call button | Outgoing call screen is displayed and call initiation begins |
| 2 | 2. Contact accepts the incoming call | Call connects successfully for both users |
| 3 | 3. Observe call status and encryption indicator during the call | Encryption indicator shows active throughout the call |
| 4 | 4. End user speaks and contact hears audio clearly | Two-way audio is transmitted without interruption |
| 5 | 5. End user ends the call | Call ends cleanly and call summary is displayed |

**Final Expected Result:** The call is established successfully and remains encrypted for the entire duration.

---

### TC-297: Cross-platform encrypted voice call

**Type:** integration
**Priority:** high
**Status:** manual
**User Story:** US-035
**Requirement:** WA-CALL-001

**Description:** Verify that a voice call between different platforms connects successfully and stays encrypted.

**Preconditions:**
- End user is on Platform A (e.g., iOS) and logged in
- Contact is on Platform B (e.g., Android) and logged in
- Both users are online
- Both users have the app installed
- Network connection is stable

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. End user initiates a voice call to the contact on the other platform | Outgoing call screen is displayed and call is placed |
| 2 | 2. Contact accepts the call | Call connects successfully across platforms |
| 3 | 3. Verify encryption status on both devices | Encryption indicator is active on both devices |
| 4 | 4. Conduct a 1-minute conversation | Audio quality is acceptable and no call drops occur |

**Final Expected Result:** Cross-platform call connects successfully and remains encrypted.

---

### TC-298: Call attempt with unstable network shows error and no unencrypted call

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-035
**Requirement:** WA-CALL-001

**Description:** Verify that with unstable network the user receives a clear error and no unencrypted call is established.

**Preconditions:**
- End user is logged in
- Contact is logged in and online
- Network for end user is unstable (packet loss/poor signal simulated)

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. End user initiates a voice call to the contact | Call initiation starts but connection struggles |
| 2 | 2. Observe the system behavior during connection attempt | A clear error message is displayed indicating network issue |
| 3 | 3. Check call status after error message | Call is not connected and no audio session is established |

**Final Expected Result:** The app displays a clear error and does not establish an unencrypted call.

---

### TC-299: Attempt call when contact is offline

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-035
**Requirement:** WA-CALL-001

**Description:** Verify appropriate handling when the contact is offline.

**Preconditions:**
- End user is logged in and online
- Contact is offline
- End user has stable network

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. End user initiates a voice call to the offline contact | Call attempt is initiated |
| 2 | 2. Observe the response from the app | App shows message that contact is offline or unavailable |
| 3 | 3. Verify call state | Call does not connect and no audio session is created |

**Final Expected Result:** The call is not established and the user is informed that the contact is offline.

---

### TC-300: Call encryption persists during brief network fluctuation

**Type:** e2e
**Priority:** medium
**Status:** manual
**User Story:** US-035
**Requirement:** WA-CALL-001

**Description:** Verify that during minor network fluctuation the call remains encrypted and continues if connection recovers.

**Preconditions:**
- Both users are logged in and online
- Call is established successfully
- Network fluctuation can be simulated (brief latency spike)

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Establish a voice call between end user and contact | Call is connected and encryption indicator is active |
| 2 | 2. Introduce a brief network latency spike for end user | Audio may briefly degrade but call remains connected |
| 3 | 3. Observe encryption indicator during and after fluctuation | Encryption indicator remains active throughout |

**Final Expected Result:** The call remains encrypted and connected during brief network fluctuation.

---

### TC-301: Call termination by remote user

**Type:** functional
**Priority:** low
**Status:** manual
**User Story:** US-035
**Requirement:** WA-CALL-001

**Description:** Verify that the call ends properly when the remote contact ends it and encryption session is terminated.

**Preconditions:**
- Both users are logged in and online
- Call is established successfully

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Contact ends the call | End user receives call ended notification |
| 2 | 2. Check call UI state for end user | Call screen closes or shows call summary |
| 3 | 3. Verify encryption session status | Encryption indicator is removed and session is terminated |

**Final Expected Result:** The call ends cleanly and encryption is terminated.

---

### TC-302: Attempt voice call without app installed on contact device

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-035
**Requirement:** WA-CALL-001

**Description:** Verify that a call cannot be placed if the contact does not have the app installed.

**Preconditions:**
- End user is logged in and online
- Contact does not have the app installed
- End user has stable network

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. End user attempts to initiate a voice call to the contact | Call attempt is blocked or fails to initiate |
| 2 | 2. Observe system message | App displays a clear message indicating the contact is unavailable or not using the app |

**Final Expected Result:** The call is not initiated and the user is informed appropriately.

---

### TC-303: Boundary test: long-duration encrypted call stability

**Type:** performance
**Priority:** medium
**Status:** manual
**User Story:** US-035
**Requirement:** WA-CALL-001

**Description:** Verify encryption and connection stability during a long-duration call.

**Preconditions:**
- Both users are logged in and online
- Stable network connection for both users

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Establish a voice call between end user and contact | Call connects and encryption indicator is active |
| 2 | 2. Maintain the call for 60 minutes | Call remains connected with acceptable audio quality |
| 3 | 3. Monitor encryption status throughout the call | Encryption indicator remains active for the entire duration |

**Final Expected Result:** The call stays connected and encrypted for a long duration without degradation.

---

### TC-304: Start encrypted video call with stable connection

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-036
**Requirement:** WA-CALL-002

**Description:** Verify a user can start a video call and it is end-to-end encrypted when network is stable

**Preconditions:**
- Caller is logged in
- Callee is logged in
- Both users have stable internet connection
- Both users have granted camera and microphone permissions

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Caller opens the chat with the callee | Chat screen with call controls is displayed |
| 2 | 2. Caller taps the video call button | Outgoing call screen is shown and call attempt starts |
| 3 | 3. Callee accepts the incoming video call | Video call connects successfully |
| 4 | 4. Verify encryption indicator/status in the call UI or logs | End-to-end encryption is indicated as active |

**Final Expected Result:** Video call is established successfully and end-to-end encryption is active

---

### TC-305: Accept incoming video call within 3 seconds

**Type:** performance
**Priority:** high
**Status:** manual
**User Story:** US-036
**Requirement:** WA-CALL-002

**Description:** Verify that accepting an incoming call starts the video call within 3 seconds and encryption is active

**Preconditions:**
- Callee is logged in
- Caller is logged in
- Both users have stable internet connection
- Both users have granted camera and microphone permissions

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Caller initiates a video call to callee | Incoming call notification is shown on callee device |
| 2 | 2. Callee taps Accept | Call connects and video starts within 3 seconds |
| 3 | 3. Verify encryption indicator/status in the call UI or logs | End-to-end encryption is indicated as active |

**Final Expected Result:** Video call starts within 3 seconds after acceptance with encryption active

---

### TC-306: Fail to start call on weak network

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-036
**Requirement:** WA-CALL-002

**Description:** Verify error handling and secure termination when network is too weak to start a call

**Preconditions:**
- Caller is logged in
- Network is weak or unstable (below minimum threshold)
- Callee is logged in

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Caller taps the video call button | Call attempt starts |
| 2 | 2. Simulate or maintain weak network during call setup | Call setup fails |
| 3 | 3. Observe the UI message | A clear error message indicates network issue |
| 4 | 4. Verify no media session is established | Call is terminated securely without unencrypted data transfer |

**Final Expected Result:** User receives an error and the call is securely terminated without unencrypted data

---

### TC-307: Network interruption during ongoing call

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-036
**Requirement:** WA-CALL-002

**Description:** Verify that an ongoing call ends securely when the connection is interrupted

**Preconditions:**
- Caller and callee are in an active encrypted video call
- Both users have granted camera and microphone permissions

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Disrupt the network connection for the caller device | Call quality degrades or connection drops |
| 2 | 2. Observe the call status and error message | Error message indicates connection lost |
| 3 | 3. Verify call termination behavior | Call ends securely and no unencrypted media is transmitted |

**Final Expected Result:** Call is ended securely with an appropriate error message on network interruption

---

### TC-308: Start call without login

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-036
**Requirement:** WA-CALL-002

**Description:** Verify that an unauthenticated user cannot start a video call

**Preconditions:**
- Caller is not logged in
- App is installed and opened

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Attempt to access a chat or call feature | User is prompted to log in |
| 2 | 2. Attempt to initiate a video call | Call initiation is blocked |

**Final Expected Result:** Unauthenticated users are prevented from starting a video call

---

### TC-309: Accept call without media permissions

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-036
**Requirement:** WA-CALL-002

**Description:** Verify behavior when user has not granted camera/microphone permissions

**Preconditions:**
- Callee is logged in
- Camera and microphone permissions are denied
- Caller is logged in

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Caller initiates a video call | Incoming call notification appears on callee device |
| 2 | 2. Callee taps Accept | Permission prompt appears or call fails with a clear message |
| 3 | 3. Deny permissions if prompted | Call does not start and user is informed about required permissions |

**Final Expected Result:** Call does not start without required permissions and user receives guidance

---

### TC-310: Encryption indicator not present

**Type:** integration
**Priority:** high
**Status:** manual
**User Story:** US-036
**Requirement:** WA-CALL-002

**Description:** Verify that a missing encryption indicator is treated as a failure

**Preconditions:**
- Caller and callee are logged in
- Stable network connection is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Start a video call between caller and callee | Video call connects successfully |
| 2 | 2. Check the call UI for encryption indicator or verify via logs | Encryption indicator is visible or logs confirm E2E encryption |

**Final Expected Result:** Encryption must be visible/confirmed; absence is treated as failure

---

### TC-311: Boundary: call start time at 3-second threshold

**Type:** performance
**Priority:** medium
**Status:** manual
**User Story:** US-036
**Requirement:** WA-CALL-002

**Description:** Verify that the call start time meets the 3-second boundary condition

**Preconditions:**
- Caller and callee are logged in
- Network is stable with average latency near acceptable threshold

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Caller initiates a video call | Incoming call notification appears on callee device |
| 2 | 2. Callee accepts immediately | Call connects within 3 seconds |
| 3 | 3. Measure call start time | Start time is less than or equal to 3 seconds |

**Final Expected Result:** Call start time meets the 3-second requirement at boundary conditions

---

### TC-312: Start group voice call with minimum participants

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-037
**Requirement:** WA-CALL-003

**Description:** Verify a group voice call can be started with at least two contacts and all invited participants can join

**Preconditions:**
- User is logged in
- Stable internet connection
- Contact list contains at least three online contacts
- User has microphone permission enabled

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the contacts list and select two online contacts | Two contacts are selected and shown in the group call invite list |
| 2 | 2. Choose 'Start group voice call' | Call setup screen is displayed and invitations are sent |
| 3 | 3. Have both invited contacts accept the call | Both contacts join the group call successfully |

**Final Expected Result:** Group voice call is established with all invited participants connected

---

### TC-313: Start group video call with multiple participants

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-037
**Requirement:** WA-CALL-003

**Description:** Verify a group video call can be started with multiple participants and all can join

**Preconditions:**
- User is logged in
- Stable internet connection
- Contact list contains at least four online contacts
- User has camera and microphone permission enabled

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Select three online contacts from the contact list | Three contacts are selected in the group call invite list |
| 2 | 2. Choose 'Start group video call' | Video call setup screen is displayed and invitations are sent |
| 3 | 3. Have all invited contacts accept the call | All contacts join the video call with video and audio active |

**Final Expected Result:** Group video call is established with all invited participants connected

---

### TC-314: Group call remains active when an invited participant is offline

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-037
**Requirement:** WA-CALL-003

**Description:** Verify the call remains active for other participants and shows offline status for the unavailable participant

**Preconditions:**
- User is logged in
- Stable internet connection
- At least two contacts are online
- At least one contact is offline

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Select two online contacts and one offline contact | Three contacts are selected in the invite list |
| 2 | 2. Start a group voice call | Call setup begins and invitations are sent |
| 3 | 3. Have the two online contacts accept the call | Two contacts join the call |

**Final Expected Result:** Call remains active with joined participants and the offline participant shows an offline/unavailable status

---

### TC-315: Group call remains active when an invited participant declines

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-037
**Requirement:** WA-CALL-003

**Description:** Verify the call continues for other participants and shows declined status for the rejecting participant

**Preconditions:**
- User is logged in
- Stable internet connection
- At least three online contacts

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Select three online contacts and start a group voice call | Call setup screen is displayed and invitations are sent |
| 2 | 2. Have two contacts accept and one contact decline the invitation | Two contacts join the call and one is marked as declined |

**Final Expected Result:** Call remains active with joined participants and the declined participant shows a declined status

---

### TC-316: Error when starting group call below minimum participants

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-037
**Requirement:** WA-CALL-003

**Description:** Verify system prevents starting a group call with fewer than the supported minimum number of participants

**Preconditions:**
- User is logged in
- Stable internet connection
- Contact list contains at least one online contact

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Select one contact | One contact is selected in the invite list |
| 2 | 2. Attempt to start a group call | System blocks the action and displays a clear error message |

**Final Expected Result:** Group call does not start and a clear error message indicates unsupported participant count

---

### TC-317: Error when starting group call above maximum participants

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-037
**Requirement:** WA-CALL-003

**Description:** Verify system prevents starting a group call that exceeds the supported maximum number of participants

**Preconditions:**
- User is logged in
- Stable internet connection
- Contact list contains more than the maximum supported participants
- Maximum supported participants is known

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Select a number of contacts that exceeds the maximum supported participants | Selected contacts exceed the allowed limit |
| 2 | 2. Attempt to start a group call | System blocks the action and displays a clear error message |

**Final Expected Result:** Group call does not start and a clear error message indicates the participant limit

---

### TC-318: Boundary test at maximum supported participants

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-037
**Requirement:** WA-CALL-003

**Description:** Verify a group call starts successfully at the maximum supported participant limit

**Preconditions:**
- User is logged in
- Stable internet connection
- Contact list contains at least the maximum supported participants
- Maximum supported participants is known

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Select exactly the maximum supported number of contacts | Selected contacts match the maximum limit |
| 2 | 2. Start a group call | Call setup starts and invitations are sent |
| 3 | 3. Have all invited contacts accept | All contacts join the call |

**Final Expected Result:** Group call is established successfully with the maximum supported participants

---

### TC-319: Network instability prevents group call setup

**Type:** integration
**Priority:** medium
**Status:** manual
**User Story:** US-037
**Requirement:** WA-CALL-003

**Description:** Verify that group call setup fails gracefully when the user does not have a stable internet connection

**Preconditions:**
- User is logged in
- Network is unstable or disconnected
- Contact list contains at least two online contacts

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Select two online contacts | Two contacts are selected in the invite list |
| 2 | 2. Attempt to start a group call | System attempts to establish the call and detects network issues |

**Final Expected Result:** Group call does not start and a clear error message indicates connectivity issues

---

### TC-320: Participant status updates are displayed during active group call

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-037
**Requirement:** WA-CALL-003

**Description:** Verify that participant statuses (connected, offline, declined) are displayed correctly during an active call

**Preconditions:**
- User is logged in
- Stable internet connection
- At least three contacts are available with mixed statuses (online, offline)

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Start a group call with two online contacts and one offline contact | Call setup begins and invitations are sent |
| 2 | 2. Have the online contacts join the call | Online contacts show connected status |
| 3 | 3. Observe the offline contact status | Offline contact shows offline/unavailable status |

**Final Expected Result:** Participant status indicators correctly reflect connected and offline states during the active call

---

### TC-321: Switch between voice and video within supported group call

**Type:** integration
**Priority:** low
**Status:** manual
**User Story:** US-037
**Requirement:** WA-CALL-003

**Description:** Verify the group call remains active when switching from voice to video (if supported) and all participants stay connected

**Preconditions:**
- User is logged in
- Stable internet connection
- At least two online contacts
- User has camera and microphone permissions enabled
- Group call mode supports switching from voice to video

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Start a group voice call with two contacts | Group voice call is active with both contacts connected |
| 2 | 2. Switch the call to video mode | System transitions to video mode and requests camera access if needed |
| 3 | 3. Confirm video mode for all participants | All participants remain connected with video enabled |

**Final Expected Result:** Call remains active and transitions to video with all participants still connected

---

### TC-322: Start screen sharing during active call - successful

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-038
**Requirement:** WA-CALL-004

**Description:** Verify that a user can start screen sharing during an active call and the selected screen is visible in real time to the other participant

**Preconditions:**
- Two users are logged in on separate devices
- An active call is established between the two users
- OS screen sharing permission is granted

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. User A clicks the Screen Share button during the active call | OS screen selection dialog is displayed |
| 2 | 2. User A selects an entire screen and confirms sharing | Screen sharing starts and a sharing indicator is shown for User A |
| 3 | 3. User B views the call window | User B sees User A’s selected screen in real time without noticeable delay |

**Final Expected Result:** Selected screen is shared in real time and both users see appropriate sharing indicators

---

### TC-323: Stop screen sharing during active call - successful

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-038
**Requirement:** WA-CALL-004

**Description:** Verify that stopping screen sharing immediately ends the shared content for the other participant

**Preconditions:**
- Two users are logged in on separate devices
- An active call is established between the two users
- Screen sharing is currently active from User A to User B

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. User A clicks the Stop Screen Share button | Screen sharing stops and sharing indicator is removed for User A |
| 2 | 2. User B views the call window | Shared content is removed immediately and no screen content is visible |

**Final Expected Result:** Screen sharing is stopped instantly and the other participant sees no shared content

---

### TC-324: Screen sharing start denied by OS permission

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-038
**Requirement:** WA-CALL-004

**Description:** Verify that a clear error message is shown and sharing does not start when OS permission is denied

**Preconditions:**
- Two users are logged in on separate devices
- An active call is established between the two users
- OS screen sharing permission is set to deny

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. User A clicks the Screen Share button during the active call | OS permission prompt is shown or a denial is enforced |
| 2 | 2. User A denies screen sharing permission | An understandable error message is displayed indicating permission is required |
| 3 | 3. User B views the call window | No shared content appears for User B |

**Final Expected Result:** Sharing does not start and a clear permission-related error message is displayed

---

### TC-325: Network drop during active screen sharing

**Type:** integration
**Priority:** high
**Status:** manual
**User Story:** US-038
**Requirement:** WA-CALL-004

**Description:** Verify that screen sharing automatically ends and the user is notified when the network connection drops

**Preconditions:**
- Two users are logged in on separate devices
- An active call is established between the two users
- Screen sharing is currently active
- Network condition is unstable or can be interrupted

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Simulate a network drop for User A while sharing | Connection interruption is detected by the application |
| 2 | 2. Observe User A’s UI | Screen sharing ends automatically and a hint to restore the connection is shown |
| 3 | 3. Observe User B’s UI | Shared content disappears and no stale frames remain |

**Final Expected Result:** Sharing stops automatically and the user receives a recovery notification

---

### TC-326: Attempt to start screen sharing without an active call

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-038
**Requirement:** WA-CALL-004

**Description:** Verify that screen sharing cannot be started when there is no active call

**Preconditions:**
- User is logged in
- No active call exists

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. User attempts to click the Screen Share button | Screen Share action is disabled or prompts to start a call first |

**Final Expected Result:** Screen sharing cannot be started without an active call

---

### TC-327: Start sharing and cancel screen selection dialog

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-038
**Requirement:** WA-CALL-004

**Description:** Verify that canceling the screen selection dialog does not start sharing

**Preconditions:**
- Two users are logged in on separate devices
- An active call is established between the two users
- OS screen sharing permission is granted

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. User A clicks the Screen Share button | OS screen selection dialog is displayed |
| 2 | 2. User A cancels the dialog | No sharing indicator is shown and sharing does not start |
| 3 | 3. User B views the call window | No shared content is displayed |

**Final Expected Result:** Canceling the selection dialog prevents screen sharing from starting

---

### TC-328: Switch between different shared screens (boundary - change selection)

**Type:** e2e
**Priority:** medium
**Status:** manual
**User Story:** US-038
**Requirement:** WA-CALL-004

**Description:** Verify that switching shared screen updates the content for the other participant

**Preconditions:**
- Two users are logged in on separate devices
- An active call is established between the two users
- Screen sharing is currently active for User A

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. User A opens the screen sharing options and selects a different screen to share | Sharing transitions to the newly selected screen |
| 2 | 2. User B observes the shared content | User B sees the newly selected screen content in real time |

**Final Expected Result:** Screen sharing updates to the new selected screen without disrupting the call

---

### TC-329: Performance check: initial frame latency on share start

**Type:** performance
**Priority:** low
**Status:** manual
**User Story:** US-038
**Requirement:** WA-CALL-004

**Description:** Verify that the first shared frame appears within an acceptable time after starting sharing

**Preconditions:**
- Two users are logged in on separate devices
- An active call is established between the two users
- Network is stable

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. User A starts screen sharing and selects a screen | Sharing starts and a timestamp is recorded |
| 2 | 2. User B observes the shared screen appearance | First frame is visible within the defined performance threshold (e.g., <= 2 seconds) |

**Final Expected Result:** Initial shared content appears within the acceptable latency threshold

---

### TC-330: Create call link for a valid scheduled call

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-039
**Requirement:** WA-CALL-005

**Description:** Verify a unique, shareable link is generated and displayed for a scheduled call with valid date/time

**Preconditions:**
- User is logged in
- A scheduled call exists with a future date and time

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to the scheduled call details page | Scheduled call details are displayed |
| 2 | 2. Click on 'Create Call Link' | System generates a link |
| 3 | 3. Observe the displayed link | A unique, shareable call link is displayed |

**Final Expected Result:** User receives a unique, shareable link for the scheduled call

---

### TC-331: Prevent link creation for past scheduled call

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-039
**Requirement:** WA-CALL-005

**Description:** Verify the system blocks link creation for a scheduled call in the past and shows a clear error

**Preconditions:**
- User is logged in
- A scheduled call exists with a past date and time

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to the past scheduled call details page | Past scheduled call details are displayed |
| 2 | 2. Click on 'Create Call Link' | System validates the date/time |
| 3 | 3. Review the response message | A clear error message is shown and no link is created |

**Final Expected Result:** Call link creation is prevented for past calls

---

### TC-332: Open call link and view call details

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-039
**Requirement:** WA-CALL-005

**Description:** Verify that opening a generated link displays call details

**Preconditions:**
- A call link has been created for a scheduled call in the future
- Recipient has access to a browser

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Paste the call link into the browser and open it | Call link page loads successfully |
| 2 | 2. Review displayed information on the page | Call details (title/date/time) are visible |

**Final Expected Result:** Recipient can view the scheduled call details via the link

---

### TC-333: Join call at scheduled time via link

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-039
**Requirement:** WA-CALL-005

**Description:** Verify that the recipient can join the call at the planned time

**Preconditions:**
- A call link has been created for a scheduled call
- Current time is at or after the scheduled start time

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the call link | Call details and join option are displayed |
| 2 | 2. Click on 'Join Call' | Recipient joins the call successfully |

**Final Expected Result:** Recipient can join the call at the scheduled time

---

### TC-334: Access call link before scheduled time

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-039
**Requirement:** WA-CALL-005

**Description:** Verify user sees call details and cannot join before the scheduled time

**Preconditions:**
- A call link has been created for a scheduled call in the future
- Current time is before the scheduled start time

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the call link | Call details are displayed |
| 2 | 2. Observe the join option availability | Join option is disabled or indicates the call is not yet available |

**Final Expected Result:** Recipient can view details but cannot join before the scheduled time

---

### TC-335: Ensure link uniqueness for different calls

**Type:** integration
**Priority:** medium
**Status:** manual
**User Story:** US-039
**Requirement:** WA-CALL-005

**Description:** Verify each scheduled call generates a unique link

**Preconditions:**
- User is logged in
- Two different scheduled calls exist with future dates

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Create a call link for the first scheduled call | A link is generated and displayed |
| 2 | 2. Create a call link for the second scheduled call | A link is generated and displayed |
| 3 | 3. Compare the two links | Links are different |

**Final Expected Result:** Each scheduled call has a unique link

---

### TC-336: Boundary test: scheduled call at current time

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-039
**Requirement:** WA-CALL-005

**Description:** Verify link creation when call is scheduled at the current time

**Preconditions:**
- User is logged in
- A scheduled call exists with date/time equal to the current system time

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to the scheduled call details page | Call details are displayed |
| 2 | 2. Click on 'Create Call Link' | System validates the date/time |
| 3 | 3. Observe the link generation result | A link is generated and displayed |

**Final Expected Result:** Link creation succeeds at boundary time (now)

---

### TC-337: Invalid link access

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-039
**Requirement:** WA-CALL-005

**Description:** Verify system response when an invalid or malformed link is opened

**Preconditions:**
- Recipient has access to a browser

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open an invalid or malformed call link URL | System attempts to resolve the link |
| 2 | 2. Review the response | A clear error or not-found message is displayed |

**Final Expected Result:** Invalid links are handled gracefully with an understandable message

---

### TC-338: Authorization: create call link without login

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-039
**Requirement:** WA-CALL-005

**Description:** Verify that only registered/logged-in users can create call links

**Preconditions:**
- User is not logged in
- A scheduled call exists with a future date and time

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Attempt to access the scheduled call details page | User is prompted to log in or access is denied |
| 2 | 2. Attempt to create a call link | System blocks the action |

**Final Expected Result:** Unauthorized users cannot create call links

---

### TC-339: Reject incoming call with predefined quick response (happy path)

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-040
**Requirement:** WA-CALL-006

**Description:** Verify that an incoming call can be rejected with a selected quick response and message is sent immediately

**Preconditions:**
- User is logged in
- Incoming call is displayed
- At least one predefined quick response is configured
- Message delivery service is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the incoming call UI | Incoming call screen is visible with option to reject with message |
| 2 | 2. Select a predefined quick response from the list | Selected quick response is highlighted/confirmed |
| 3 | 3. Tap 'Reject with message' | Call is rejected and a sending indicator is shown |

**Final Expected Result:** Call is rejected and the selected quick response is sent immediately to the caller

---

### TC-340: Reject incoming call with quick response when none are configured

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-040
**Requirement:** WA-CALL-006

**Description:** Verify system shows a clear message and offers rejection without message when no quick responses exist

**Preconditions:**
- User is logged in
- Incoming call is displayed
- No predefined quick responses are configured

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the incoming call UI | Incoming call screen is visible with option to reject with message |
| 2 | 2. Attempt to reject with message | System displays a clear notification that no quick responses are configured |
| 3 | 3. Choose 'Reject without message' | Call is rejected without sending any message |

**Final Expected Result:** User receives a clear hint about missing quick responses and can reject the call without message

---

### TC-341: Reject incoming call with quick response when message delivery temporarily fails

**Type:** integration
**Priority:** high
**Status:** manual
**User Story:** US-040
**Requirement:** WA-CALL-006

**Description:** Verify call is rejected and user is informed of message delivery failure

**Preconditions:**
- User is logged in
- Incoming call is displayed
- At least one predefined quick response is configured
- Message delivery service is temporarily unavailable

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the incoming call UI | Incoming call screen is visible with option to reject with message |
| 2 | 2. Select a predefined quick response | Selected quick response is highlighted/confirmed |
| 3 | 3. Tap 'Reject with message' | Call is rejected and a delivery failure notification is shown |

**Final Expected Result:** Call is rejected and user is informed that the message could not be delivered

---

### TC-342: Attempt to reject with message while not logged in

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-040
**Requirement:** WA-CALL-006

**Description:** Verify behavior when user is not authenticated

**Preconditions:**
- User is not logged in
- Incoming call is displayed
- At least one predefined quick response is configured

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the incoming call UI | Incoming call screen is visible |
| 2 | 2. Select a predefined quick response | Selection is blocked or prompts login |
| 3 | 3. Attempt to reject with message | System blocks action and prompts user to log in |

**Final Expected Result:** User cannot reject with message without authentication and is prompted to log in

---

### TC-343: Boundary: Only one quick response configured

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-040
**Requirement:** WA-CALL-006

**Description:** Verify selection and rejection works when exactly one quick response exists

**Preconditions:**
- User is logged in
- Incoming call is displayed
- Exactly one predefined quick response is configured
- Message delivery service is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the incoming call UI | Incoming call screen shows exactly one quick response |
| 2 | 2. Select the only quick response | The response is selected without error |
| 3 | 3. Tap 'Reject with message' | Call is rejected and message is sent |

**Final Expected Result:** Call is rejected and the only quick response is sent successfully

---

### TC-344: UI feedback: No quick response selection made

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-040
**Requirement:** WA-CALL-006

**Description:** Verify user cannot reject with message without selecting a response

**Preconditions:**
- User is logged in
- Incoming call is displayed
- At least one predefined quick response is configured

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the incoming call UI | Incoming call screen shows quick responses and action buttons |
| 2 | 2. Do not select any quick response and tap 'Reject with message' | System prompts user to select a quick response or prevents the action |

**Final Expected Result:** User is guided to select a quick response before rejecting with message

---

### TC-345: Performance: Message sent within acceptable time after rejection

**Type:** performance
**Priority:** medium
**Status:** manual
**User Story:** US-040
**Requirement:** WA-CALL-006

**Description:** Verify message is sent immediately after rejecting the call

**Preconditions:**
- User is logged in
- Incoming call is displayed
- At least one predefined quick response is configured
- Message delivery service is available
- Performance monitoring enabled

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the incoming call UI | Incoming call screen is visible |
| 2 | 2. Select a predefined quick response | Selected response is confirmed |
| 3 | 3. Tap 'Reject with message' and measure time to delivery confirmation | Delivery confirmation occurs within defined SLA (e.g., 2 seconds) |

**Final Expected Result:** Message delivery confirmation is received within the acceptable time threshold

---

### TC-346: Chronological display of call history with required fields

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-041
**Requirement:** WA-CALL-007

**Description:** Verify call history lists successful inbound and outbound calls in chronological order with date, time, direction, and contact.

**Preconditions:**
- User is logged in
- There are successful inbound and outbound calls in the user's history

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to the call history (Anrufverlauf) screen | Call history screen loads without error |
| 2 | 2. Observe the list of call entries | Each entry shows date, time, direction (incoming/outgoing), and contact |
| 3 | 3. Check the order of entries | Entries are sorted chronologically (most recent first or as specified by product) |

**Final Expected Result:** Call history displays all required fields and is chronologically ordered.

---

### TC-347: Display of missed and aborted call statuses

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-041
**Requirement:** WA-CALL-007

**Description:** Verify missed or aborted calls are labeled with a clear status.

**Preconditions:**
- User is logged in
- There is at least one missed call and one aborted call in the user's history

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the call history screen | Call history screen loads |
| 2 | 2. Locate entries for missed or aborted calls | Missed and aborted calls are present in the list |
| 3 | 3. Inspect the status label for these entries | Status is clearly shown as "verpasst" (missed) or "abgebrochen" (aborted) |

**Final Expected Result:** Missed and aborted calls are displayed with explicit, correct statuses.

---

### TC-348: Performance: Lazy loading with large call history

**Type:** performance
**Priority:** high
**Status:** manual
**User Story:** US-041
**Requirement:** WA-CALL-007

**Description:** Verify that additional entries load smoothly when scrolling in a large call history.

**Preconditions:**
- User is logged in
- User has a very large call history (e.g., >1000 entries)

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the call history screen | Initial set of entries loads within acceptable time |
| 2 | 2. Scroll toward the end of the currently loaded entries | Additional entries load automatically without UI freezes or errors |
| 3 | 3. Continue scrolling to trigger multiple load cycles | Each load is performant and the UI remains responsive |

**Final Expected Result:** Additional entries are loaded seamlessly without impacting usability.

---

### TC-349: Boundary: Call history with exactly one entry

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-041
**Requirement:** WA-CALL-007

**Description:** Verify correct display when only one call exists.

**Preconditions:**
- User is logged in
- User has exactly one call in history

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the call history screen | Call history screen loads |
| 2 | 2. Observe the list | Exactly one call entry is shown with all required fields |

**Final Expected Result:** Single call entry is displayed correctly without layout issues.

---

### TC-350: Boundary: No call history entries

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-041
**Requirement:** WA-CALL-007

**Description:** Verify user sees an appropriate empty state when no calls exist.

**Preconditions:**
- User is logged in
- User has no call history entries

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the call history screen | Call history screen loads |
| 2 | 2. Observe the content area | An empty state message is displayed and no entries are shown |

**Final Expected Result:** Empty state is shown clearly when there are no entries.

---

### TC-351: Access control: Deny access to another user's call history

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-041
**Requirement:** WA-CALL-007

**Description:** Verify unauthorized access to another user's call history is blocked with a clear error.

**Preconditions:**
- User A is logged in
- User B exists with call history entries
- User A does not have permission to access User B's call history

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Attempt to access User B's call history via direct URL or UI manipulation | Access is denied |
| 2 | 2. Observe the system response | A clear, understandable error message is displayed |

**Final Expected Result:** Unauthorized access is blocked and a readable error message is shown.

---

### TC-352: Chronological ordering across date boundaries

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-041
**Requirement:** WA-CALL-007

**Description:** Verify correct ordering when calls span multiple dates and times.

**Preconditions:**
- User is logged in
- Call history contains entries across different days and times

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the call history screen | Call history screen loads |
| 2 | 2. Compare entries across date boundaries | Entries are correctly ordered by date and time |

**Final Expected Result:** Ordering is accurate across multiple dates.

---

### TC-353: Correct labeling of direction for inbound and outbound calls

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-041
**Requirement:** WA-CALL-007

**Description:** Verify that incoming and outgoing calls are displayed with correct direction labels.

**Preconditions:**
- User is logged in
- Call history includes both incoming and outgoing calls

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the call history screen | Call history screen loads |
| 2 | 2. Identify incoming call entries | Incoming calls are labeled correctly as incoming |
| 3 | 3. Identify outgoing call entries | Outgoing calls are labeled correctly as outgoing |

**Final Expected Result:** Call direction labels are accurate for all entries.

---

### TC-354: Resilience: Load additional entries under poor network conditions

**Type:** performance
**Priority:** low
**Status:** manual
**User Story:** US-041
**Requirement:** WA-CALL-007

**Description:** Verify loading more entries remains usable with degraded network.

**Preconditions:**
- User is logged in
- User has large call history
- Network is throttled to a slow speed

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the call history screen | Initial entries load, possibly slower but without failure |
| 2 | 2. Scroll to trigger loading additional entries | Loading indicator is shown and entries eventually load |

**Final Expected Result:** Additional entries load without errors; UI remains responsive.

---

### TC-355: Create text status successfully

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-042
**Requirement:** WA-STS-001

**Description:** Verify a user can publish a text-only status and it becomes visible for 24 hours.

**Preconditions:**
- User is logged in
- User has opened the Status feature
- Internet connection is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Tap the text input field | Text cursor appears in the input field |
| 2 | 2. Enter a valid text (e.g., 'Hello status') | Entered text is displayed in the input field |
| 3 | 3. Tap 'Veröffentlichen' | Status is created and appears in the status list |

**Final Expected Result:** Text status is published and visible to contacts for 24 hours.

---

### TC-356: Create image status successfully

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-042
**Requirement:** WA-STS-001

**Description:** Verify a user can publish an image-only status and it becomes visible for 24 hours.

**Preconditions:**
- User is logged in
- User has opened the Status feature
- Internet connection is available
- Device has at least one image accessible

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Tap the image add button | Image picker/gallery is displayed |
| 2 | 2. Select an image | Selected image is attached to the status |
| 3 | 3. Tap 'Veröffentlichen' | Status is created and appears in the status list |

**Final Expected Result:** Image status is published and visible to contacts for 24 hours.

---

### TC-357: Prevent publishing empty status

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-042
**Requirement:** WA-STS-001

**Description:** Verify that an empty status cannot be published and an error message is shown.

**Preconditions:**
- User is logged in
- User has opened the Status feature
- Internet connection is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Ensure the status input has no text and no image attached | Status input is empty |
| 2 | 2. Tap 'Veröffentlichen' | Status is not created and an understandable error message is displayed |

**Final Expected Result:** Empty status is blocked and user is informed with a clear error message.

---

### TC-358: Handle publish attempt without internet connection

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-042
**Requirement:** WA-STS-001

**Description:** Verify that publishing while offline is prevented and user is notified.

**Preconditions:**
- User is logged in
- User has opened the Status feature
- Internet connection is unavailable

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Enter valid text or attach an image | Status content is prepared for publishing |
| 2 | 2. Tap 'Veröffentlichen' | User is notified about missing connection and status is not published |

**Final Expected Result:** Status is not published when offline and user receives a connectivity warning.

---

### TC-359: Verify status visibility duration (24 hours)

**Type:** e2e
**Priority:** medium
**Status:** manual
**User Story:** US-042
**Requirement:** WA-STS-001

**Description:** Ensure a created status is visible for 24 hours and then expires.

**Preconditions:**
- User is logged in
- User has opened the Status feature
- Internet connection is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Create and publish a valid status | Status is created and visible in the status list |
| 2 | 2. Verify status is visible before 24 hours elapse | Status remains visible |
| 3 | 3. Wait until 24 hours have elapsed or simulate time passage | Status is no longer visible/accessible |

**Final Expected Result:** Status remains visible for 24 hours and expires afterward.

---

### TC-360: Boundary: Publish maximum allowed text length

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-042
**Requirement:** WA-STS-001

**Description:** Verify that a status with the maximum allowed text length can be published.

**Preconditions:**
- User is logged in
- User has opened the Status feature
- Internet connection is available
- Maximum text length is defined by requirements

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Enter text at the maximum allowed length | Text is accepted without truncation or error |
| 2 | 2. Tap 'Veröffentlichen' | Status is created and appears in the status list |

**Final Expected Result:** Maximum-length text status is published successfully.

---

### TC-361: Display status for all contacts in list

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-043
**Requirement:** WA-STS-002

**Description:** Verify each contact's status is visible and correct when opening contact list

**Preconditions:**
- User is logged in
- User has a contact list with multiple contacts and known statuses

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to the contact list screen | Contact list loads successfully |
| 2 | 2. Observe the status indicator for each contact | Each contact shows a visible status matching the backend data |

**Final Expected Result:** All contacts display the correct status in the contact list

---

### TC-362: Neutral placeholder status for contacts without status

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-043
**Requirement:** WA-STS-002

**Description:** Verify neutral placeholder appears when a contact has no available status

**Preconditions:**
- User is logged in
- User has at least one contact with no status set

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the contact list | Contact list loads successfully |
| 2 | 2. Locate the contact without status | Contact is visible in the list |
| 3 | 3. Check the status indicator for that contact | A neutral placeholder status is shown with no personal details |

**Final Expected Result:** Contacts without status show a neutral placeholder

---

### TC-363: Neutral placeholder status when contact blocks status visibility

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-043
**Requirement:** WA-STS-002

**Description:** Ensure privacy is respected and placeholder is shown when status sharing is disabled

**Preconditions:**
- User is logged in
- User has a contact who has disabled status sharing

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the contact list | Contact list loads successfully |
| 2 | 2. Locate the contact with status sharing disabled | Contact is visible in the list |
| 3 | 3. Check the status indicator for that contact | A neutral placeholder status is shown with no personal details |

**Final Expected Result:** Contacts with status sharing disabled show a neutral placeholder

---

### TC-364: Network disruption during status retrieval

**Type:** integration
**Priority:** high
**Status:** manual
**User Story:** US-043
**Requirement:** WA-STS-002

**Description:** Verify an understandable error message is shown and last known status remains

**Preconditions:**
- User is logged in
- User has contacts with known last statuses
- Network throttling or interruption can be simulated

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the contact list with network available | Contact list loads with current statuses |
| 2 | 2. Simulate a temporary network disruption | Network is unavailable or unstable |
| 3 | 3. Trigger status refresh (e.g., pull-to-refresh or reopen list) | A clear error message is displayed |
| 4 | 4. Observe statuses in the list | Last known statuses remain visible |

**Final Expected Result:** Error message displayed and last known status persists during network issues

---

### TC-365: Recovery after network restoration

**Type:** integration
**Priority:** medium
**Status:** manual
**User Story:** US-043
**Requirement:** WA-STS-002

**Description:** Verify statuses update correctly after network connectivity is restored

**Preconditions:**
- User is logged in
- Network disruption was previously simulated

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Restore network connectivity | Network becomes available |
| 2 | 2. Trigger status refresh | Contact list updates without error |
| 3 | 3. Observe status indicators | Statuses reflect current backend data |

**Final Expected Result:** Statuses update correctly after network restoration

---

### TC-366: Empty contact list handling

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-043
**Requirement:** WA-STS-002

**Description:** Verify no errors occur and no status indicators are shown when contact list is empty

**Preconditions:**
- User is logged in
- User has an empty contact list

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the contact list | Contact list loads successfully |
| 2 | 2. Observe the list content | No contacts are displayed and no status indicators are shown |

**Final Expected Result:** Empty contact list displays without errors or misleading status indicators

---

### TC-367: Large contact list performance for status rendering

**Type:** performance
**Priority:** medium
**Status:** manual
**User Story:** US-043
**Requirement:** WA-STS-002

**Description:** Verify statuses render correctly and within acceptable time for large lists

**Preconditions:**
- User is logged in
- User has a contact list with 500+ contacts and statuses

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the contact list | Contact list starts rendering |
| 2 | 2. Measure time to display statuses for visible contacts | Statuses for visible contacts appear within acceptable performance threshold (e.g., <2 seconds) |
| 3 | 3. Scroll through the list | Statuses continue to load correctly without major lag or incorrect data |

**Final Expected Result:** Status rendering is accurate and performant for large lists

---

### TC-368: Status display on list refresh

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-043
**Requirement:** WA-STS-002

**Description:** Verify statuses remain correct after manual refresh

**Preconditions:**
- User is logged in
- User has contacts with known statuses

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the contact list | Statuses are displayed |
| 2 | 2. Perform a manual refresh action | Refresh indicator appears and completes |
| 3 | 3. Verify statuses post-refresh | Statuses are updated and remain correct |

**Final Expected Result:** Statuses refresh correctly without inconsistencies

---

### TC-369: Privacy compliance in placeholder status

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-043
**Requirement:** WA-STS-002

**Description:** Ensure placeholder status does not reveal personal details or metadata

**Preconditions:**
- User is logged in
- User has at least one contact with no status or blocked status visibility

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the contact list | Contact list loads successfully |
| 2 | 2. Locate contacts with placeholder status | Neutral placeholder is shown |
| 3 | 3. Inspect placeholder text and UI details | No personal or sensitive information is displayed |

**Final Expected Result:** Placeholder status is neutral and privacy-safe

---

### TC-370: Partial status retrieval failure

**Type:** integration
**Priority:** medium
**Status:** manual
**User Story:** US-043
**Requirement:** WA-STS-002

**Description:** Verify that when some statuses fail to load, others still show and placeholders or errors are handled

**Preconditions:**
- User is logged in
- Backend can simulate partial status API failures

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the contact list while simulating partial status API failure | Contact list loads |
| 2 | 2. Observe status indicators for contacts | Contacts with successful status retrieval show correct statuses |
| 3 | 3. Observe contacts with failed status retrieval | Neutral placeholder or last known status is shown with an appropriate message if applicable |

**Final Expected Result:** Partial failures are handled gracefully without affecting other statuses

---

### TC-371: Send linked reply to visible status message

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-044
**Requirement:** WA-STS-003

**Description:** Verify a reply to a visible status message is sent as a linked reply and delivered to sender

**Preconditions:**
- User is logged in as Endnutzer
- Chat with sender exists
- A status message from sender is visible and available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the chat containing the status message | Status message is visible in the chat timeline |
| 2 | 2. Select the status message and choose the reply action | Reply composer opens with reference to the selected status message |
| 3 | 3. Enter a reply text and tap send | Reply is sent and displayed as linked to the original status message |
| 4 | 4. Verify sender receives the reply | Sender receives the reply with a link/quote to the status message |

**Final Expected Result:** Reply is delivered and correctly linked to the status message

---

### TC-372: Reply option disabled for expired status message

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-044
**Requirement:** WA-STS-003

**Description:** Verify reply action is disabled when the status message is expired

**Preconditions:**
- User is logged in as Endnutzer
- Chat contains a status message that is expired/not available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the chat with the expired status message | Expired status message is visible with expired indicator |
| 2 | 2. Attempt to access reply action on the expired status message | Reply option is disabled or non-interactive |

**Final Expected Result:** User cannot initiate a reply to an expired status message

---

### TC-373: Clear notification shown when replying to expired status message

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-044
**Requirement:** WA-STS-003

**Description:** Verify a clear warning is shown if user attempts to reply to an expired status message

**Preconditions:**
- User is logged in as Endnutzer
- Chat contains a status message that is expired/not available
- UI allows attempt to reply via long-press/context menu

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the chat with the expired status message | Expired status message is visible |
| 2 | 2. Attempt to reply via context menu or reply shortcut | A clear warning/notice is displayed indicating the status is no longer available |

**Final Expected Result:** User receives a clear notice and no reply is created

---

### TC-374: Handle network interruption when sending status reply

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-044
**Requirement:** WA-STS-003

**Description:** Verify error handling and message state when network is disconnected during send

**Preconditions:**
- User is logged in as Endnutzer
- A status message is visible and available
- Network connection is unstable or disconnected

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the chat with the available status message | Status message is visible |
| 2 | 2. Reply to the status message with text and tap send while offline | An error message is shown indicating the send failed |
| 3 | 3. Check message state in chat | Reply is not marked as sent; it shows failed/unsent state |

**Final Expected Result:** User sees an error and the reply is not marked as sent

---

### TC-375: Reply action unavailable when status message is removed

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-044
**Requirement:** WA-STS-003

**Description:** Verify reply action is not possible when the status message is removed from chat

**Preconditions:**
- User is logged in as Endnutzer
- Status message has been removed and no longer appears in chat

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the chat where the status message existed | Status message is not present in the chat timeline |
| 2 | 2. Attempt to reply using any available UI entry points | No reply option is available for the removed status message |

**Final Expected Result:** User cannot reply to a removed status message

---

### TC-376: Boundary: Reply with minimum content

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-044
**Requirement:** WA-STS-003

**Description:** Verify reply with minimum allowed content is sent and linked

**Preconditions:**
- User is logged in as Endnutzer
- A status message is visible and available
- Minimum reply content is allowed (e.g., 1 character)

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the chat with the available status message | Status message is visible |
| 2 | 2. Reply with minimum content and send | Reply is sent successfully and linked to the status message |

**Final Expected Result:** Minimum content reply is delivered and linked correctly

---

### TC-377: Boundary: Reply with maximum allowed content

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-044
**Requirement:** WA-STS-003

**Description:** Verify reply with maximum allowed content is sent and linked

**Preconditions:**
- User is logged in as Endnutzer
- A status message is visible and available
- Maximum reply content length is defined

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the chat with the available status message | Status message is visible |
| 2 | 2. Reply with content at maximum allowed length and send | Reply is sent successfully and linked to the status message |

**Final Expected Result:** Maximum length reply is delivered and linked correctly

---

### TC-378: Integration: Linked reply metadata stored and displayed

**Type:** integration
**Priority:** high
**Status:** manual
**User Story:** US-044
**Requirement:** WA-STS-003

**Description:** Verify backend and UI preserve linked reply metadata for status responses

**Preconditions:**
- User is logged in as Endnutzer
- A status message is visible and available
- Backend supports linked reply metadata

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Reply to the status message and send | Reply appears in chat linked to the status message |
| 2 | 2. Refresh/reopen the chat | Linked reply still shows reference to the original status message |
| 3 | 3. Verify sender view for the reply | Sender sees the reply linked to the status message |

**Final Expected Result:** Linked reply metadata is stored and displayed correctly for both users

---

### TC-379: Save status visibility option successfully

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-045
**Requirement:** WA-STS-004

**Description:** Verify that selecting a visibility option and saving applies immediately to status display

**Preconditions:**
- User is logged in
- User is on privacy settings page
- User has permission to change settings
- User has at least one contact

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Select the visibility option 'Contacts only' | Option 'Contacts only' is selected |
| 2 | 2. Click the Save button | Settings are saved successfully |
| 3 | 3. Navigate to a contact's view of the user's status | Status is visible to the contact |
| 4 | 4. Navigate to a non-contact user's view of the user's status | Status is not visible to the non-contact user |

**Final Expected Result:** Selected visibility option is saved and applied immediately to status display

---

### TC-380: Save custom contact list with all contacts removed

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-045
**Requirement:** WA-STS-004

**Description:** Verify that removing all contacts from a custom list makes status visible to no one and confirms the change

**Preconditions:**
- User is logged in
- User is on privacy settings page
- User has permission to change settings
- User has a custom contact list selected with at least one contact

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Remove all contacts from the selected custom list | Custom list becomes empty |
| 2 | 2. Click the Save button | Settings are saved and a confirmation message is displayed |
| 3 | 3. Navigate to a contact's view of the user's status | Status is not visible to the contact |

**Final Expected Result:** Status is visible to no one and the system confirms the change

---

### TC-381: Save status visibility without permission

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-045
**Requirement:** WA-STS-004

**Description:** Verify that changes are rejected and an error message is shown when the user lacks permission

**Preconditions:**
- User is logged in
- User is on privacy settings page
- User does not have permission to change settings

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Select any visibility option | Option is selected |
| 2 | 2. Click the Save button | Save is rejected |

**Final Expected Result:** Change is not saved and a clear, understandable error message is displayed

---

### TC-382: Immediate application after saving visibility setting

**Type:** e2e
**Priority:** medium
**Status:** manual
**User Story:** US-045
**Requirement:** WA-STS-004

**Description:** Verify that the status visibility change takes effect immediately without re-login

**Preconditions:**
- User is logged in
- User is on privacy settings page
- User has permission to change settings
- Another user session is active to view status

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Set visibility to 'Everyone' and save | Settings are saved successfully |
| 2 | 2. In the other user's session, refresh the page | Status becomes visible immediately |
| 3 | 3. Change visibility to 'No one' and save | Settings are saved successfully |
| 4 | 4. In the other user's session, refresh the page | Status becomes hidden immediately |

**Final Expected Result:** Visibility changes apply immediately without re-authentication

---

### TC-383: Boundary condition: Empty custom list cannot be used without confirmation

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-045
**Requirement:** WA-STS-004

**Description:** Verify system behavior when saving an empty custom list

**Preconditions:**
- User is logged in
- User is on privacy settings page
- User has permission to change settings
- User has a custom contact list selected

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Ensure the custom list is empty | No contacts are shown in the list |
| 2 | 2. Click the Save button | System saves the setting and shows confirmation |

**Final Expected Result:** Empty list is accepted and results in status visibility to no one

---

### TC-384: Negative: Save without selecting a visibility option

**Type:** functional
**Priority:** low
**Status:** manual
**User Story:** US-045
**Requirement:** WA-STS-004

**Description:** Verify validation when no visibility option is selected

**Preconditions:**
- User is logged in
- User is on privacy settings page
- User has permission to change settings

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Deselect any selected visibility option if possible | No visibility option is selected |
| 2 | 2. Click the Save button | Validation message is shown |

**Final Expected Result:** Save is blocked and a validation message prompts the user to select a visibility option

---

### TC-385: Persistence of saved visibility setting

**Type:** integration
**Priority:** medium
**Status:** manual
**User Story:** US-045
**Requirement:** WA-STS-004

**Description:** Verify that saved visibility setting persists after re-login

**Preconditions:**
- User is logged in
- User is on privacy settings page
- User has permission to change settings

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Set visibility to 'Contacts only' and save | Settings are saved successfully |
| 2 | 2. Log out and log back in | User is authenticated and returned to the app |
| 3 | 3. Open privacy settings page | Previously saved visibility option is selected |

**Final Expected Result:** Visibility setting persists across sessions

---

### TC-386: Mute contact status successfully

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-046
**Requirement:** WA-STS-005

**Description:** Verify that muting a contact hides their status updates for the user

**Preconditions:**
- User is logged in
- User has an active contact with visible status updates
- User has permission to mute the contact's status

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the contact profile or contact settings for the active contact | Contact profile/settings page is displayed with status-related options |
| 2 | 2. Select the option to mute the contact's status | Mute action is applied and UI indicates status is muted |
| 3 | 3. Navigate to the status updates feed or area where status updates appear | No new status updates from the muted contact are displayed |

**Final Expected Result:** Contact status updates are no longer shown after muting

---

### TC-387: Unmute contact status successfully

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-046
**Requirement:** WA-STS-005

**Description:** Verify that unmuting restores status updates visibility

**Preconditions:**
- User is logged in
- Contact status is currently muted
- User has permission to unmute the contact's status

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the contact profile or contact settings for the muted contact | Contact profile/settings page is displayed and shows status is muted |
| 2 | 2. Select the option to unmute the contact's status | Unmute action is applied and UI indicates status is unmuted |
| 3 | 3. Navigate to the status updates feed or area where status updates appear | Status updates from the contact are visible again |

**Final Expected Result:** Contact status updates are shown again after unmuting

---

### TC-388: Mute contact status without permission

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-046
**Requirement:** WA-STS-005

**Description:** Verify that the system blocks muting when the user lacks permission

**Preconditions:**
- User is logged in
- User has a contact for which they do not have mute permission

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the contact profile or settings for the restricted contact | Contact profile/settings page is displayed |
| 2 | 2. Attempt to mute the contact's status | System blocks the action and displays a clear error message |

**Final Expected Result:** Mute action is denied and an understandable error message is shown

---

### TC-389: Performance when muting with a very large contact list

**Type:** performance
**Priority:** high
**Status:** manual
**User Story:** US-046
**Requirement:** WA-STS-005

**Description:** Verify muting a contact status performs without noticeable delay in large lists

**Preconditions:**
- User is logged in
- User has a very large contact list (e.g., 5,000+ contacts)
- Target contact is in the list and has status updates
- User has permission to mute the contact's status

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Locate a contact in the large list and open their profile/settings | Contact profile/settings page opens without significant delay |
| 2 | 2. Mute the contact's status | Mute action completes immediately with no noticeable delay |
| 3 | 3. Check the status updates feed | Muted contact's status updates are not displayed |

**Final Expected Result:** Muting completes quickly and status is immediately muted even with a large contact list

---

### TC-390: Attempt to mute an already muted contact

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-046
**Requirement:** WA-STS-005

**Description:** Verify system behavior when muting a contact already muted (idempotent action)

**Preconditions:**
- User is logged in
- Contact status is already muted
- User has permission to mute the contact's status

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the contact profile or settings for the already muted contact | Contact profile/settings page indicates status is muted |
| 2 | 2. Attempt to mute the contact's status again | System confirms status remains muted without errors |
| 3 | 3. Check the status updates feed | No status updates from the contact are displayed |

**Final Expected Result:** System handles repeated mute gracefully and remains muted

---

### TC-391: Attempt to unmute a contact that is not muted

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-046
**Requirement:** WA-STS-005

**Description:** Verify system behavior when unmuting a contact that is not muted

**Preconditions:**
- User is logged in
- Contact status is not muted
- User has permission to unmute the contact's status

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the contact profile or settings for the contact | Contact profile/settings page indicates status is not muted |
| 2 | 2. Attempt to unmute the contact's status | System provides a no-op response or indicates status is already unmuted |
| 3 | 3. Check the status updates feed | Status updates from the contact are visible |

**Final Expected Result:** System handles unmute gracefully without changing visibility

---

### TC-392: Mute status does not affect message delivery

**Type:** integration
**Priority:** high
**Status:** manual
**User Story:** US-046
**Requirement:** WA-STS-005

**Description:** Verify that muting a contact's status does not impact message sending/receiving

**Preconditions:**
- User is logged in
- User has an active contact with messaging enabled
- User has permission to mute the contact's status

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Mute the contact's status | Status mute is applied |
| 2 | 2. Send a message to the contact | Message is sent successfully |
| 3 | 3. Receive a message from the contact | Incoming message is received and displayed |

**Final Expected Result:** Muting status does not affect message delivery

---

### TC-393: Mute status persists after logout/login

**Type:** e2e
**Priority:** medium
**Status:** manual
**User Story:** US-046
**Requirement:** WA-STS-005

**Description:** Verify that mute state is persisted across sessions

**Preconditions:**
- User is logged in
- User has an active contact with visible status updates
- User has permission to mute the contact's status

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Mute the contact's status | Status mute is applied |
| 2 | 2. Log out of the application | User is logged out successfully |
| 3 | 3. Log back in and navigate to status updates feed | Muted contact's status updates are still not displayed |

**Final Expected Result:** Mute state persists across sessions

---

### TC-394: Send supported image successfully

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-047
**Requirement:** WA-MED-001

**Description:** Verify a supported image can be sent and shows delivery confirmation

**Preconditions:**
- User is logged in
- User is in an existing chat
- Stable internet connection
- Supported image file (e.g., JPG) is available on device

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Tap the attach/image icon in the chat composer | Image picker opens |
| 2 | 2. Select a supported image (JPG/PNG) | Image preview appears in the composer |
| 3 | 3. Tap Send | Message is sent and appears in the chat |
| 4 | 4. Observe the message status indicator | Delivery confirmation is displayed for the image message |

**Final Expected Result:** The supported image is sent successfully and displayed with delivery confirmation

---

### TC-395: Reject unsupported image format

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-047
**Requirement:** WA-MED-001

**Description:** Verify unsupported file formats are not sent and show an error

**Preconditions:**
- User is logged in
- User is in an existing chat
- Unsupported file format (e.g., .bmp or .tiff) is available on device

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Tap the attach/image icon in the chat composer | Image picker opens |
| 2 | 2. Select an unsupported image format | Image selection is shown in composer or validation is triggered |
| 3 | 3. Tap Send | A clear error message is displayed and send is blocked |

**Final Expected Result:** Unsupported image is not sent and a clear error message is shown

---

### TC-396: Reject oversized image

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-047
**Requirement:** WA-MED-001

**Description:** Verify images above size limit are not sent and show an error

**Preconditions:**
- User is logged in
- User is in an existing chat
- Oversized image file above maximum limit is available on device

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Tap the attach/image icon in the chat composer | Image picker opens |
| 2 | 2. Select an oversized image file | Image preview appears in the composer |
| 3 | 3. Tap Send | A clear error message is displayed and the image is not sent |

**Final Expected Result:** Oversized image is not sent and a clear error message is shown

---

### TC-397: Send image with intermittent connection fails and offers resend

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-047
**Requirement:** WA-MED-001

**Description:** Verify sending fails with unstable or disconnected internet and offers resend option

**Preconditions:**
- User is logged in
- User is in an existing chat
- Supported image file is available on device
- Internet connection is unstable or disconnected

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Tap the attach/image icon in the chat composer | Image picker opens |
| 2 | 2. Select a supported image | Image preview appears in the composer |
| 3 | 3. Tap Send | Message shows a failed status indicator |
| 4 | 4. Observe available actions for the failed message | A resend option is displayed |

**Final Expected Result:** Image send fails due to connectivity issues and offers a resend option

---

### TC-398: Resend failed image after reconnecting

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-047
**Requirement:** WA-MED-001

**Description:** Verify resend succeeds after network is restored

**Preconditions:**
- User is logged in
- User is in an existing chat
- A previously failed image message is present
- Internet connection is restored

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Tap the resend option for the failed image | Resend is initiated |
| 2 | 2. Observe the message status indicator | Delivery confirmation is displayed |

**Final Expected Result:** Failed image is successfully resent and shows delivery confirmation

---

### TC-399: Boundary test: image at maximum allowed size

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-047
**Requirement:** WA-MED-001

**Description:** Verify an image exactly at the maximum size limit can be sent

**Preconditions:**
- User is logged in
- User is in an existing chat
- Stable internet connection
- Image file at exact maximum size limit is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Tap the attach/image icon in the chat composer | Image picker opens |
| 2 | 2. Select the image at the maximum size limit | Image preview appears in the composer |
| 3 | 3. Tap Send | Message is sent and appears in the chat |
| 4 | 4. Observe the message status indicator | Delivery confirmation is displayed |

**Final Expected Result:** Image at size limit is sent successfully with delivery confirmation

---

### TC-400: Boundary test: image just above maximum size

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-047
**Requirement:** WA-MED-001

**Description:** Verify an image slightly above the maximum size is rejected

**Preconditions:**
- User is logged in
- User is in an existing chat
- Image file slightly above maximum size limit is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Tap the attach/image icon in the chat composer | Image picker opens |
| 2 | 2. Select the image slightly above the size limit | Image preview appears in the composer |
| 3 | 3. Tap Send | A clear error message is displayed and the image is not sent |

**Final Expected Result:** Image above the maximum size is not sent and a clear error message is shown

---

### TC-401: Multiple supported images sequentially

**Type:** e2e
**Priority:** medium
**Status:** manual
**User Story:** US-047
**Requirement:** WA-MED-001

**Description:** Verify multiple supported images can be sent one after another

**Preconditions:**
- User is logged in
- User is in an existing chat
- Stable internet connection
- Multiple supported image files are available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Select and send the first supported image | First image is sent and displayed with delivery confirmation |
| 2 | 2. Select and send the second supported image | Second image is sent and displayed with delivery confirmation |

**Final Expected Result:** Each supported image is sent successfully with delivery confirmations

---

### TC-402: Unsupported file disguised with image extension

**Type:** functional
**Priority:** low
**Status:** manual
**User Story:** US-047
**Requirement:** WA-MED-001

**Description:** Verify validation rejects a non-image file renamed as an image

**Preconditions:**
- User is logged in
- User is in an existing chat
- A non-image file renamed with .jpg extension is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Tap the attach/image icon in the chat composer | Image picker opens |
| 2 | 2. Select the renamed file | Validation occurs on selection or send |
| 3 | 3. Tap Send | A clear error message is displayed and the file is not sent |

**Final Expected Result:** Non-image file is rejected and not sent

---

### TC-403: Send supported video successfully in existing chat

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-048
**Requirement:** WA-MED-002

**Description:** Verify a logged-in user can send a supported video and it appears for all participants

**Preconditions:**
- User is logged in
- User is in an existing chat with at least one other participant
- A supported video file is available on the device and within size limit
- Network connection is stable

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the chat conversation screen | Chat conversation is displayed with message input and attachments options |
| 2 | 2. Tap the attachment/add media button | Media picker opens |
| 3 | 3. Select a supported video file within the size limit | Selected video is attached and previewed in the message composer |
| 4 | 4. Tap the Send button | Upload starts and a sending indicator is shown |
| 5 | 5. Wait for upload to complete | Video message appears in the chat with a playable thumbnail |
| 6 | 6. Verify from another participant's view | Video message is visible to other participants in the same chat |

**Final Expected Result:** The supported video is successfully sent and visible to all chat participants

---

### TC-404: Reject video exceeding maximum size

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-048
**Requirement:** WA-MED-002

**Description:** Verify sending a video larger than the allowed size is blocked with a clear error message

**Preconditions:**
- User is logged in
- User is in an existing chat
- A video file larger than the max allowed size is available on the device
- Network connection is stable

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the chat conversation screen | Chat conversation is displayed with message input and attachments options |
| 2 | 2. Tap the attachment/add media button | Media picker opens |
| 3 | 3. Select a video file that exceeds the maximum allowed size | The app either prevents selection or marks the file as too large in the picker |
| 4 | 4. Attempt to send the oversized video | Upload is rejected and an error message is displayed stating the maximum size limit |
| 5 | 5. Observe the chat content | No video message is added to the chat |

**Final Expected Result:** Oversized video is not sent and a clear max-size error message is shown

---

### TC-405: Handle network unavailable during video send

**Type:** integration
**Priority:** high
**Status:** manual
**User Story:** US-048
**Requirement:** WA-MED-002

**Description:** Verify sending a video fails gracefully when network is unavailable and offers retry

**Preconditions:**
- User is logged in
- User is in an existing chat
- A supported video file within size limit is available
- Network is disabled or unavailable

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the chat conversation screen | Chat conversation is displayed with message input and attachments options |
| 2 | 2. Tap the attachment/add media button | Media picker opens |
| 3 | 3. Select a supported video file within the size limit | Selected video is attached and previewed in the message composer |
| 4 | 4. Tap the Send button with network unavailable | Send operation is aborted and an error message is shown |
| 5 | 5. Check for retry option | User is presented with an option to retry sending |

**Final Expected Result:** Send operation fails due to network issues with a clear error and retry option

---

### TC-406: Retry sending video after network recovery

**Type:** e2e
**Priority:** medium
**Status:** manual
**User Story:** US-048
**Requirement:** WA-MED-002

**Description:** Verify a user can retry sending a video after network becomes available

**Preconditions:**
- User is logged in
- User is in an existing chat
- A supported video file within size limit is available
- Network was unavailable during initial send attempt and is now restored

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Attempt to send a supported video while network is unavailable | Send fails with an error and retry option |
| 2 | 2. Re-enable network connectivity | Device shows active network connection |
| 3 | 3. Tap the retry option for the failed video send | Upload restarts and a sending indicator is shown |
| 4 | 4. Wait for upload to complete | Video message appears in the chat with a playable thumbnail |

**Final Expected Result:** Video is successfully sent after retry when network is restored

---

### TC-407: Send video at maximum allowed size boundary

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-048
**Requirement:** WA-MED-002

**Description:** Verify a video exactly at the maximum allowed size can be sent successfully

**Preconditions:**
- User is logged in
- User is in an existing chat
- A supported video file exactly at the maximum allowed size is available
- Network connection is stable

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the chat conversation screen | Chat conversation is displayed with message input and attachments options |
| 2 | 2. Select a supported video file at the maximum size limit | Selected video is attached and previewed in the message composer |
| 3 | 3. Tap the Send button | Upload starts and a sending indicator is shown |
| 4 | 4. Wait for upload to complete | Video message appears in the chat and is playable |

**Final Expected Result:** Video at the maximum size limit is sent successfully

---

### TC-408: Attempt to send unsupported video format

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-048
**Requirement:** WA-MED-002

**Description:** Verify unsupported video file types are rejected with a clear error message

**Preconditions:**
- User is logged in
- User is in an existing chat
- An unsupported video file format is available on the device
- Network connection is stable

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the chat conversation screen | Chat conversation is displayed with message input and attachments options |
| 2 | 2. Open media picker and select an unsupported video file | The app prevents selection or marks the file as unsupported |
| 3 | 3. Attempt to send the unsupported video | Send is blocked and an error message indicates unsupported format |

**Final Expected Result:** Unsupported video formats cannot be sent and a clear error message is shown

---

### TC-409: Handle network instability during upload

**Type:** integration
**Priority:** high
**Status:** manual
**User Story:** US-048
**Requirement:** WA-MED-002

**Description:** Verify upload fails gracefully when network becomes unstable mid-upload

**Preconditions:**
- User is logged in
- User is in an existing chat
- A supported video file within size limit is available
- Network connection can be toggled to simulate instability

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Start sending a supported video file | Upload starts and a sending indicator is shown |
| 2 | 2. Simulate network instability or disconnect during upload | Upload is interrupted |
| 3 | 3. Observe the UI after interruption | Send is aborted and an error message is displayed with retry option |

**Final Expected Result:** Upload is aborted due to network instability and user is offered retry

---

### TC-410: Performance: Send small supported video under stable network

**Type:** performance
**Priority:** low
**Status:** manual
**User Story:** US-048
**Requirement:** WA-MED-002

**Description:** Measure that small video upload completes within acceptable time under stable network

**Preconditions:**
- User is logged in
- User is in an existing chat
- A small supported video file within size limit is available
- Network connection is stable and meets baseline bandwidth

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Start sending a small supported video | Upload starts and progress indicator appears |
| 2 | 2. Measure time until upload completes | Upload completes within defined performance threshold |
| 3 | 3. Confirm video appears in chat | Video message is visible and playable |

**Final Expected Result:** Small video upload completes within acceptable time and is visible in chat

---

### TC-411: Send supported document successfully

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-049
**Requirement:** WA-MED-003

**Description:** Verify that a supported document can be sent in an open conversation and appears as sent

**Preconditions:**
- User is logged in
- User has an existing conversation open
- Document type is supported (e.g., PDF, DOCX)
- Network connection is stable

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Click the attachment/add document button in the conversation | File picker opens |
| 2 | 2. Select a supported document within the size limit | Selected document is shown as ready to send |
| 3 | 3. Click the “Senden” (Send) button | Upload starts and a sending indicator is shown |
| 4 | 4. Wait for completion | Document appears in the conversation as sent with a timestamp |

**Final Expected Result:** Document is successfully transmitted and displayed as sent in the conversation

---

### TC-412: Reject document exceeding maximum size

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-049
**Requirement:** WA-MED-003

**Description:** Ensure a document larger than the maximum allowed size cannot be sent and shows a clear error

**Preconditions:**
- User is logged in
- User has an existing conversation open
- Document exceeds the maximum allowed size

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Click the attachment/add document button in the conversation | File picker opens |
| 2 | 2. Select a document larger than the maximum size limit | Document is selected and shown as ready to send |
| 3 | 3. Click the “Senden” (Send) button | An understandable error message is displayed indicating file size limit |

**Final Expected Result:** Sending is blocked and no upload is performed

---

### TC-413: Handle network loss during document send

**Type:** integration
**Priority:** high
**Status:** manual
**User Story:** US-049
**Requirement:** WA-MED-003

**Description:** Verify sending fails gracefully when there is no stable network connection

**Preconditions:**
- User is logged in
- User has an existing conversation open
- Document type is supported
- Network connection is unstable or disconnected during send

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Click the attachment/add document button and select a supported document | Selected document is shown as ready to send |
| 2 | 2. Click the “Senden” (Send) button | Upload starts and a sending indicator is shown |
| 3 | 3. Simulate network loss during upload | Sending fails and an error notification is shown |

**Final Expected Result:** Document is not partially sent and user is informed of the failure

---

### TC-414: Send document exactly at maximum size limit

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-049
**Requirement:** WA-MED-003

**Description:** Validate boundary condition where document size equals the maximum allowed size

**Preconditions:**
- User is logged in
- User has an existing conversation open
- Document size equals maximum allowed size
- Network connection is stable

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Click the attachment/add document button | File picker opens |
| 2 | 2. Select a document with size equal to the max limit | Selected document is shown as ready to send |
| 3 | 3. Click the “Senden” (Send) button | Upload starts and proceeds without error |
| 4 | 4. Wait for completion | Document appears in the conversation as sent |

**Final Expected Result:** Document at maximum size limit is sent successfully

---

### TC-415: Prevent sending unsupported document format

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-049
**Requirement:** WA-MED-003

**Description:** Ensure unsupported document formats cannot be sent and provide a clear error

**Preconditions:**
- User is logged in
- User has an existing conversation open
- Document type is unsupported (e.g., .exe)

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Click the attachment/add document button | File picker opens |
| 2 | 2. Select an unsupported document format | The system rejects selection or marks it as invalid |
| 3 | 3. Attempt to click the “Senden” (Send) button | An understandable error message is displayed and sending is blocked |

**Final Expected Result:** Unsupported documents cannot be sent and user is informed

---

### TC-416: Verify sent document appears with correct metadata

**Type:** e2e
**Priority:** medium
**Status:** manual
**User Story:** US-049
**Requirement:** WA-MED-003

**Description:** Check that the sent document shows filename and timestamp after successful send

**Preconditions:**
- User is logged in
- User has an existing conversation open
- Document type is supported
- Network connection is stable

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Select a supported document and click “Senden” | Upload starts and completes successfully |
| 2 | 2. Observe the message bubble in the conversation | Filename and timestamp are displayed correctly |

**Final Expected Result:** Sent document shows correct metadata in the conversation view

---

### TC-417: Crop and save image updates preview and send payload

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-050
**Requirement:** WA-MED-004

**Description:** Verify cropping and saving displays edited image in preview and uses it for sending

**Preconditions:**
- User is logged in
- User has selected a supported image for sending

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the image editing screen for the selected image | Editing tools including crop are visible |
| 2 | 2. Apply a crop that removes a noticeable portion of the image | Crop box is updated and reflects the selected area |
| 3 | 3. Save the crop | Preview updates to show the cropped image |
| 4 | 4. Proceed to send the image | Send action uses the cropped image |

**Final Expected Result:** The cropped image is shown in preview and is the one sent

---

### TC-418: Rotate image updates preview immediately without quality loss

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-050
**Requirement:** WA-MED-004

**Description:** Verify rotation applies immediately and retains quality

**Preconditions:**
- User is logged in
- User has selected a supported image for sending

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the image editing screen | Rotate control is available |
| 2 | 2. Rotate the image 90 degrees | Preview updates immediately with the 90-degree rotation |
| 3 | 3. Confirm the rotation | Rotated image remains crisp with no visible quality degradation |

**Final Expected Result:** Rotation is applied instantly and can be used without quality loss

---

### TC-419: Undo last editing step reverts image immediately

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-050
**Requirement:** WA-MED-004

**Description:** Verify undo operation reverts the most recent edit and updates preview

**Preconditions:**
- User is logged in
- User has selected a supported image for sending

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Crop the image and save | Preview shows the cropped image |
| 2 | 2. Rotate the image 90 degrees | Preview shows the rotated, cropped image |
| 3 | 3. Trigger Undo | Preview reverts to the cropped (pre-rotation) image immediately |

**Final Expected Result:** Undo immediately restores the previous edit state

---

### TC-420: Multiple undo operations restore original image

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-050
**Requirement:** WA-MED-004

**Description:** Verify multiple undo steps revert edits in reverse order to the original image

**Preconditions:**
- User is logged in
- User has selected a supported image for sending

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Apply crop and save | Preview shows cropped image |
| 2 | 2. Rotate image 180 degrees | Preview shows rotated and cropped image |
| 3 | 3. Apply an additional crop and save | Preview shows the second crop |
| 4 | 4. Tap Undo three times | Preview returns to the original unedited image |

**Final Expected Result:** All edits are reverted in correct order back to the original image

---

### TC-421: Unsupported format shows error and allows selecting another image

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-050
**Requirement:** WA-MED-004

**Description:** Verify user receives a clear error message for unsupported formats and can choose another image

**Preconditions:**
- User is logged in
- User attempts to select an unsupported image format

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Select an image with an unsupported format (e.g., .tiff if unsupported) | System detects unsupported format |
| 2 | 2. Attempt to open the editor | A clear error message is displayed |
| 3 | 3. Choose a different supported image | Editor opens successfully for the new image |

**Final Expected Result:** User is informed of the unsupported format and can select another image

---

### TC-422: Editing failure shows error and preserves ability to pick another image

**Type:** integration
**Priority:** high
**Status:** manual
**User Story:** US-050
**Requirement:** WA-MED-004

**Description:** Verify system handles editing failure gracefully and allows new selection

**Preconditions:**
- User is logged in
- User has selected a supported image
- Simulated editing service failure is enabled

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open image editing screen | Editing tools are visible |
| 2 | 2. Apply a crop and attempt to save | Save operation fails due to simulated error |
| 3 | 3. Observe the system response | A clear, user-friendly error message is shown |
| 4 | 4. Select a different image | New image loads into the editor |

**Final Expected Result:** Failure is communicated clearly and user can choose another image

---

### TC-423: Boundary: minimal crop size allowed

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-050
**Requirement:** WA-MED-004

**Description:** Verify cropping to the minimum allowed size works and updates preview

**Preconditions:**
- User is logged in
- User has selected a supported image for sending

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open image editing screen | Crop tool is available |
| 2 | 2. Resize crop box to the minimum allowed dimensions | Crop box stops at the defined minimum size |
| 3 | 3. Save the crop | Preview updates to show the minimally cropped image |

**Final Expected Result:** Minimum crop size is enforced and the preview updates correctly

---

### TC-424: Boundary: full image crop (no change) does not alter image

**Type:** functional
**Priority:** low
**Status:** manual
**User Story:** US-050
**Requirement:** WA-MED-004

**Description:** Verify that cropping to full size does not change the image

**Preconditions:**
- User is logged in
- User has selected a supported image for sending

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open image editing screen | Crop tool is available |
| 2 | 2. Set crop box to cover the entire image | Crop box matches full image dimensions |
| 3 | 3. Save the crop | Preview remains visually identical to original |

**Final Expected Result:** No change occurs when cropping the full image

---

### TC-425: Quality check after multiple rotations and save

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-050
**Requirement:** WA-MED-004

**Description:** Verify no visible quality loss after multiple rotations and saving

**Preconditions:**
- User is logged in
- User has selected a supported high-resolution image for sending

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Rotate the image 90 degrees four times | Preview updates after each rotation |
| 2 | 2. Save the edits | Preview shows the final image |
| 3 | 3. Compare the final image to the original visually or via pixel-difference threshold | No significant quality degradation is observed |

**Final Expected Result:** Multiple rotations do not introduce visible quality loss

---

### TC-426: Send sticker successfully with stable connection

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-051
**Requirement:** WA-MED-005

**Description:** Verify a sticker can be selected and sent in an active chat with stable internet

**Preconditions:**
- User is logged in
- An active chat is open with another user
- Stable internet connection is available
- Sticker menu is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | Open the sticker menu in the chat | Sticker menu is displayed with available stickers |
| 2 | Select a sticker from the menu | Selected sticker is highlighted or shown as selected |
| 3 | Tap the send button | Sticker is sent and appears in the chat timeline |
| 4 | Check the recipient chat view | Recipient receives and sees the sticker |

**Final Expected Result:** Sticker is displayed in sender chat and delivered to recipient

---

### TC-427: Prevent sending when no sticker is selected

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-051
**Requirement:** WA-MED-005

**Description:** Verify system blocks sending without selecting a sticker and shows guidance

**Preconditions:**
- User is logged in
- An active chat is open
- Stable internet connection is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | Open the sticker menu | Sticker menu is displayed |
| 2 | Do not select any sticker | No sticker is highlighted or selected |
| 3 | Tap the send button | Sending is blocked and a hint to select a sticker is shown |

**Final Expected Result:** Sticker is not sent and user receives a prompt to choose a sticker

---

### TC-428: Handle sending sticker with interrupted connection

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-051
**Requirement:** WA-MED-005

**Description:** Verify error message and retry option when connection is lost during send

**Preconditions:**
- User is logged in
- An active chat is open
- Sticker menu is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | Disable or simulate loss of internet connection | Device/app shows no internet connectivity |
| 2 | Open the sticker menu and select a sticker | Sticker is selected |
| 3 | Tap the send button | Error message is displayed and a retry option is shown |

**Final Expected Result:** Sticker is not sent and the user is prompted to retry

---

### TC-429: Retry sending sticker after connection is restored

**Type:** integration
**Priority:** high
**Status:** manual
**User Story:** US-051
**Requirement:** WA-MED-005

**Description:** Verify retry option successfully sends the sticker after restoring connection

**Preconditions:**
- User is logged in
- An active chat is open
- A sticker send attempt failed due to no connection and retry option is visible

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | Restore internet connection | Device/app shows stable connectivity |
| 2 | Tap the retry option | Sticker send is re-attempted |
| 3 | Observe the chat timeline | Sticker appears in the chat |

**Final Expected Result:** Sticker is sent successfully after retry and delivered to recipient

---

### TC-430: Prevent sending when sticker menu is opened but not selected

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-051
**Requirement:** WA-MED-005

**Description:** Verify that simply opening sticker menu without selection does not allow sending

**Preconditions:**
- User is logged in
- An active chat is open
- Stable internet connection is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | Open the sticker menu | Sticker menu is displayed |
| 2 | Close the menu without selecting a sticker | Sticker menu is closed and no sticker is selected |
| 3 | Tap the send button | Sending is blocked and a hint to select a sticker is shown |

**Final Expected Result:** Sticker is not sent and user is prompted to select a sticker

---

### TC-431: Sticker rendering in chat bubble

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-051
**Requirement:** WA-MED-005

**Description:** Verify the sent sticker renders correctly in the chat UI

**Preconditions:**
- User is logged in
- An active chat is open
- Stable internet connection is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | Select a sticker and send it | Sticker appears in the chat timeline |
| 2 | Inspect the sticker in the chat bubble | Sticker is fully visible, not cropped, and has correct size |

**Final Expected Result:** Sticker displays correctly without UI defects

---

### TC-432: Boundary test: Send the first sticker in the list

**Type:** functional
**Priority:** low
**Status:** manual
**User Story:** US-051
**Requirement:** WA-MED-005

**Description:** Verify selecting the first sticker works correctly

**Preconditions:**
- User is logged in
- An active chat is open
- Stable internet connection is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | Open the sticker menu | Sticker list is shown |
| 2 | Select the first sticker in the list | First sticker is selected |
| 3 | Tap the send button | Sticker is sent and displayed in the chat |

**Final Expected Result:** First sticker in the list can be sent successfully

---

### TC-433: Boundary test: Send the last sticker in the list

**Type:** functional
**Priority:** low
**Status:** manual
**User Story:** US-051
**Requirement:** WA-MED-005

**Description:** Verify selecting the last sticker works correctly

**Preconditions:**
- User is logged in
- An active chat is open
- Stable internet connection is available
- Sticker list has multiple pages or is scrollable

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | Open the sticker menu | Sticker list is shown |
| 2 | Scroll to the last sticker and select it | Last sticker is selected |
| 3 | Tap the send button | Sticker is sent and displayed in the chat |

**Final Expected Result:** Last sticker in the list can be sent successfully

---

### TC-434: Search and send GIF successfully with network connection

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-052
**Requirement:** WA-MED-006

**Description:** Verify that a GIF can be searched, selected, inserted into message, and delivered when network is available

**Preconditions:**
- User is logged in
- User is in an active chat
- Network connection is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the GIF search panel in the chat input | GIF search UI is displayed with a search field |
| 2 | 2. Enter a valid search term (e.g., 'happy') | Search term appears in the input field |
| 3 | 3. Execute the search | GIF results are displayed |
| 4 | 4. Select a GIF from the results | Selected GIF is inserted into the message composer |
| 5 | 5. Send the message | Message is sent and shows delivered status with the GIF visible in the chat |

**Final Expected Result:** GIF is successfully searched, inserted, sent, and delivered

---

### TC-435: No results for GIF search term

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-052
**Requirement:** WA-MED-006

**Description:** Verify system behavior when no GIFs match the search term

**Preconditions:**
- User is logged in
- User is in an active chat
- Network connection is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the GIF search panel | GIF search UI is displayed |
| 2 | 2. Enter a rare/invalid search term (e.g., 'asdkjasd12345') | Search term appears in the input field |
| 3 | 3. Execute the search | No GIF results are returned |
| 4 | 4. Observe the results area | Empty result list is shown with a hint and option to modify the search |

**Final Expected Result:** User sees a no-results state with guidance to change the search

---

### TC-436: GIF search service error handling

**Type:** integration
**Priority:** high
**Status:** manual
**User Story:** US-052
**Requirement:** WA-MED-006

**Description:** Verify that a service error shows an error message without blocking chat functions

**Preconditions:**
- User is logged in
- User is in an active chat
- GIF service is unavailable or returns error

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the GIF search panel | GIF search UI is displayed |
| 2 | 2. Enter any search term and execute the search | System attempts to fetch GIFs |
| 3 | 3. Observe the response | An error message is displayed with an option to retry |
| 4 | 4. Attempt to send a normal text message | Text message can be sent successfully without blockage |

**Final Expected Result:** Service error is handled gracefully and chat remains functional

---

### TC-437: Retry GIF search after service error

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-052
**Requirement:** WA-MED-006

**Description:** Verify retry functionality after a temporary service error

**Preconditions:**
- User is logged in
- User is in an active chat
- GIF service temporarily unavailable, then restored

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Perform a GIF search while the service is down | Error message with retry option is shown |
| 2 | 2. Restore GIF service availability | Service is available for requests |
| 3 | 3. Click the retry option | Search is re-executed |
| 4 | 4. Select a GIF and send the message | GIF is inserted and message is sent successfully |

**Final Expected Result:** Retry successfully retrieves GIFs and allows sending

---

### TC-438: Search with empty input

**Type:** functional
**Priority:** low
**Status:** manual
**User Story:** US-052
**Requirement:** WA-MED-006

**Description:** Verify behavior when the search term is empty

**Preconditions:**
- User is logged in
- User is in an active chat
- Network connection is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the GIF search panel | GIF search UI is displayed |
| 2 | 2. Leave the search field empty and attempt to search | System prevents search or shows validation prompting for input |

**Final Expected Result:** Empty search is handled with validation and no request is made

---

### TC-439: Boundary test: minimum length search term

**Type:** functional
**Priority:** low
**Status:** manual
**User Story:** US-052
**Requirement:** WA-MED-006

**Description:** Verify behavior for very short search terms (e.g., 1 character)

**Preconditions:**
- User is logged in
- User is in an active chat
- Network connection is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the GIF search panel | GIF search UI is displayed |
| 2 | 2. Enter a 1-character search term (e.g., 'a') | Search term appears in the input field |
| 3 | 3. Execute the search | System returns results or shows a validation message if min length enforced |

**Final Expected Result:** System handles minimum-length search term according to validation rules

---

### TC-440: Send GIF with intermittent network during delivery

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-052
**Requirement:** WA-MED-006

**Description:** Verify that sending a selected GIF handles transient network issues gracefully

**Preconditions:**
- User is logged in
- User is in an active chat
- Network connection is unstable

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Search and select a GIF | GIF is inserted into the message composer |
| 2 | 2. Send the message while network drops | Message shows pending/failed state with retry option |
| 3 | 3. Restore network and retry sending | Message is delivered successfully with the GIF visible |

**Final Expected Result:** GIF message delivery recovers correctly after network interruption

---

### TC-441: Open camera, take photo, preview shown and can send

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-053
**Requirement:** WA-MED-007

**Description:** Verify user can access camera in chat, take a photo, see preview, and send

**Preconditions:**
- User is logged in
- User is in an open chat
- Device has a working camera
- Camera permission already granted to the app

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Tap the camera icon/function within the chat UI | Camera interface opens within or over the chat |
| 2 | 2. Capture a photo using the camera shutter | Photo is captured successfully |
| 3 | 3. Confirm/accept the captured photo | Photo preview appears as a message draft in the chat |
| 4 | 4. Tap the send button | Photo is sent and appears as a message in the chat thread |

**Final Expected Result:** User can take a photo from chat, see preview, and send it successfully

---

### TC-442: Camera permission prompt shown when not yet granted

**Type:** integration
**Priority:** high
**Status:** manual
**User Story:** US-053
**Requirement:** WA-MED-007

**Description:** Verify system permission prompt appears and chat remains open

**Preconditions:**
- User is logged in
- User is in an open chat
- Device has a working camera
- Camera permission has not been granted to the app

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Tap the camera icon/function within the chat UI | System permission prompt for camera access is displayed |
| 2 | 2. Observe the chat screen while the prompt is shown | Chat remains open and is not dismissed or navigated away |

**Final Expected Result:** Permission prompt is displayed and the chat stays open

---

### TC-443: Deny camera permission shows error and alternative media option

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-053
**Requirement:** WA-MED-007

**Description:** Verify denial of permission results in a clear error and alternative media option

**Preconditions:**
- User is logged in
- User is in an open chat
- Device has a working camera
- Camera permission has not been granted to the app

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Tap the camera icon/function within the chat UI | System permission prompt for camera access is displayed |
| 2 | 2. Select 'Deny' on the permission prompt | App shows a clear error message indicating camera access is denied |
| 3 | 3. Check available options in the error state | An alternative option to send media (e.g., gallery/file picker) is presented |

**Final Expected Result:** User sees an understandable error and an alternative media option

---

### TC-444: No camera available shows error and alternative media option

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-053
**Requirement:** WA-MED-007

**Description:** Verify behavior when device has no camera or camera is unavailable

**Preconditions:**
- User is logged in
- User is in an open chat
- Device has no camera or camera is not available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Tap the camera icon/function within the chat UI | App detects no available camera |
| 2 | 2. Observe the UI response | A clear error message is displayed |
| 3 | 3. Check for alternative media options | An alternative option to send media is offered |

**Final Expected Result:** User is informed of the issue and can use an alternative media option

---

### TC-445: Cancel photo capture returns to chat without draft

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-053
**Requirement:** WA-MED-007

**Description:** Verify canceling the camera does not create a draft or send

**Preconditions:**
- User is logged in
- User is in an open chat
- Device has a working camera
- Camera permission already granted to the app

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Tap the camera icon/function within the chat UI | Camera interface opens |
| 2 | 2. Tap cancel/back to exit the camera without taking a photo | User is returned to the chat screen |
| 3 | 3. Check the chat input area | No photo preview or draft is present |

**Final Expected Result:** Canceling camera returns to chat without creating a message draft

---

### TC-446: Retake photo replaces preview before sending

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-053
**Requirement:** WA-MED-007

**Description:** Verify retake functionality updates the preview correctly

**Preconditions:**
- User is logged in
- User is in an open chat
- Device has a working camera
- Camera permission already granted to the app

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Tap the camera icon/function within the chat UI | Camera interface opens |
| 2 | 2. Capture a photo | Photo is captured and shown in a preview |
| 3 | 3. Choose 'Retake' and capture a new photo | Preview updates to the newly captured photo |
| 4 | 4. Send the photo | Only the retaken photo is sent in the chat |

**Final Expected Result:** Retake replaces the preview and only the final photo is sent

---

### TC-447: Permission previously denied: prompt or settings guidance displayed

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-053
**Requirement:** WA-MED-007

**Description:** Verify behavior when permission is previously denied with 'Don't ask again'

**Preconditions:**
- User is logged in
- User is in an open chat
- Device has a working camera
- Camera permission is denied with 'Don't ask again'

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Tap the camera icon/function within the chat UI | No system prompt appears |
| 2 | 2. Observe the app response | App shows a clear error with guidance to enable camera in settings and provides an alternative media option |

**Final Expected Result:** User receives guidance to enable permission and an alternative media option is offered

---

### TC-448: Chat remains open when permission prompt is dismissed

**Type:** integration
**Priority:** medium
**Status:** manual
**User Story:** US-053
**Requirement:** WA-MED-007

**Description:** Verify chat stays open if user dismisses the system prompt

**Preconditions:**
- User is logged in
- User is in an open chat
- Device has a working camera
- Camera permission has not been granted to the app

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Tap the camera icon/function within the chat UI | System permission prompt appears |
| 2 | 2. Dismiss the permission prompt without selecting allow/deny | User remains in the chat screen |
| 3 | 3. Check for error or alternative option | App provides feedback and/or alternative media option as per design |

**Final Expected Result:** Chat remains open and user is not navigated away

---

### TC-449: Large photo preview and send boundary condition

**Type:** performance
**Priority:** low
**Status:** manual
**User Story:** US-053
**Requirement:** WA-MED-007

**Description:** Verify handling of a high-resolution photo within chat

**Preconditions:**
- User is logged in
- User is in an open chat
- Device has a working camera
- Camera permission already granted to the app
- Device camera set to highest available resolution

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Tap the camera icon/function within the chat UI | Camera interface opens |
| 2 | 2. Capture a high-resolution photo | Photo is captured without app crash or freeze |
| 3 | 3. Confirm the photo to return to chat | Preview loads within acceptable time and is displayed correctly |
| 4 | 4. Send the photo | Photo sends successfully and appears in chat |

**Final Expected Result:** High-resolution photo can be previewed and sent without failures

---

### TC-450: Send supported audio file successfully in chat

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-054
**Requirement:** WA-MED-008

**Description:** Verify that a supported audio file can be selected, uploaded, and delivered as a message.

**Preconditions:**
- User is logged in
- User is in an existing chat with another user
- Device has at least one supported audio file (e.g., .mp3)

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Tap the attachment icon in the chat input area | Attachment options are displayed |
| 2 | 2. Choose the option to select a file from device storage | File picker opens |
| 3 | 3. Select a supported audio file (e.g., sample.mp3) and confirm | Selected file appears in the message composer with a send option |
| 4 | 4. Tap the send button | Upload starts and progress indicator is shown |
| 5 | 5. Wait for upload to complete | Audio message appears in the chat with playback controls |

**Final Expected Result:** The supported audio file is successfully uploaded and delivered as a chat message.

---

### TC-451: Reject unsupported audio file type

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-054
**Requirement:** WA-MED-008

**Description:** Verify that selecting an unsupported audio file results in a clear error and no message is sent.

**Preconditions:**
- User is logged in
- User is in an existing chat
- Device has at least one unsupported audio file (e.g., .wma if unsupported)

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Tap the attachment icon in the chat input area | Attachment options are displayed |
| 2 | 2. Open the file picker and select an unsupported audio file | System attempts to attach the file |
| 3 | 3. Confirm the selection | A clear error message is displayed indicating the file type is unsupported |

**Final Expected Result:** Unsupported audio file is not sent and an understandable error is shown.

---

### TC-452: Handle unstable network during audio upload

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-054
**Requirement:** WA-MED-008

**Description:** Verify that an unstable network shows a clear error and allows retry.

**Preconditions:**
- User is logged in
- User is in an existing chat
- Device has a supported audio file
- Network is unstable or throttled to induce failure

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Select a supported audio file for sending | File appears in the composer with send option |
| 2 | 2. Tap the send button while network is unstable | Upload attempts start and may show progress |
| 3 | 3. Wait for the upload to fail due to network issues | A clear error message is displayed with a retry option |
| 4 | 4. Tap the retry option | Upload restarts |

**Final Expected Result:** User receives a clear error on failure and can retry sending the audio file.

---

### TC-453: Boundary: Send maximum allowed audio file size

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-054
**Requirement:** WA-MED-008

**Description:** Verify that an audio file at the maximum size limit can be sent successfully.

**Preconditions:**
- User is logged in
- User is in an existing chat
- Device has a supported audio file at the maximum allowed size

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Select the maximum-size supported audio file | File is attached and ready to send |
| 2 | 2. Tap send | Upload starts with progress indicator |
| 3 | 3. Wait for upload completion | Audio message appears in the chat |

**Final Expected Result:** Maximum-size supported audio file is uploaded and delivered successfully.

---

### TC-454: Boundary: Reject audio file exceeding size limit

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-054
**Requirement:** WA-MED-008

**Description:** Verify that an audio file larger than the allowed limit is blocked with a clear error.

**Preconditions:**
- User is logged in
- User is in an existing chat
- Device has a supported audio file exceeding size limit

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Select the oversized supported audio file | System attempts to attach the file |
| 2 | 2. Confirm the selection | A clear error message about file size is shown |

**Final Expected Result:** Oversized audio file is not sent and an understandable size error is displayed.

---

### TC-455: Cancel audio upload before completion

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-054
**Requirement:** WA-MED-008

**Description:** Verify that the user can cancel an in-progress audio upload and no message is sent.

**Preconditions:**
- User is logged in
- User is in an existing chat
- Device has a supported audio file
- Network is stable

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Select a supported audio file and tap send | Upload starts with progress indicator |
| 2 | 2. Tap the cancel/stop upload control during upload | Upload stops and progress indicator disappears |

**Final Expected Result:** Upload is canceled and no audio message is delivered.

---

### TC-456: Retry after network recovery succeeds

**Type:** integration
**Priority:** high
**Status:** manual
**User Story:** US-054
**Requirement:** WA-MED-008

**Description:** Verify that retrying after network stabilizes successfully sends the audio message.

**Preconditions:**
- User is logged in
- User is in an existing chat
- Device has a supported audio file
- Network can be toggled between unstable and stable

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Start sending a supported audio file while network is unstable | Upload fails and retry option is shown |
| 2 | 2. Stabilize the network connection | Network becomes stable |
| 3 | 3. Tap retry | Upload restarts successfully |
| 4 | 4. Wait for upload to complete | Audio message appears in the chat |

**Final Expected Result:** Retry after network recovery results in successful upload and message delivery.

---

### TC-457: Öffnen der Galerie und Bildauswahl aus Medienauswahl-Dialog

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-055
**Requirement:** WA-MED-009

**Description:** Verifiziert, dass die Geräte-Galerie geöffnet wird und ein Bild ausgewählt werden kann, wenn die Berechtigung bereits erteilt ist.

**Preconditions:**
- Nutzer ist in der App eingeloggt
- Nutzer befindet sich im Medienauswahl-Dialog
- Galeriezugriff ist in den Systemeinstellungen erlaubt

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Tippe im Medienauswahl-Dialog auf die Option „Galerie“ | Die Geräte-Galerie öffnet sich |
| 2 | 2. Wähle ein vorhandenes Bild aus der Galerie aus | Das Bild wird ausgewählt und an die App übergeben |

**Final Expected Result:** Die App erhält das ausgewählte Bild und kehrt zum vorgesehenen Workflow zurück (z. B. Vorschau/Anhängen).

---

### TC-458: Berechtigungsdialog bei erstem Galerie-Zugriff

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-055
**Requirement:** WA-MED-009

**Description:** Verifiziert, dass beim ersten Zugriff auf die Galerie ein Systemdialog zur Berechtigung angezeigt wird.

**Preconditions:**
- Nutzer ist in der App eingeloggt
- Nutzer befindet sich im Medienauswahl-Dialog
- Galeriezugriff wurde der App noch nicht erlaubt oder verweigert

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Tippe im Medienauswahl-Dialog auf die Option „Galerie“ | Ein Systemdialog zur Berechtigungsanfrage wird angezeigt |

**Final Expected Result:** Das System bittet den Nutzer um Erlaubnis für den Galeriezugriff.

---

### TC-459: Zugriff verweigert: Fehlermeldung mit Hinweis zur Berechtigungsaktivierung

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-055
**Requirement:** WA-MED-009

**Description:** Verifiziert, dass nach verweigerter Berechtigung eine verständliche Fehlermeldung erscheint.

**Preconditions:**
- Nutzer ist in der App eingeloggt
- Nutzer befindet sich im Medienauswahl-Dialog
- Galeriezugriff wurde zuvor verweigert

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Tippe im Medienauswahl-Dialog auf die Option „Galerie“ | Die Galerie öffnet sich nicht |
| 2 | 2. Beobachte die angezeigte Fehlermeldung | Es erscheint eine verständliche Fehlermeldung mit Hinweis, wie die Berechtigung in den Systemeinstellungen aktiviert werden kann |

**Final Expected Result:** Der Nutzer erhält eine klare Handlungsanweisung zur Aktivierung der Berechtigung.

---

### TC-460: Berechtigung erteilt im Systemdialog und Galerie öffnet sich

**Type:** integration
**Priority:** high
**Status:** manual
**User Story:** US-055
**Requirement:** WA-MED-009

**Description:** Verifiziert, dass die Galerie nach Erteilung der Berechtigung aus dem Systemdialog geöffnet wird.

**Preconditions:**
- Nutzer ist in der App eingeloggt
- Nutzer befindet sich im Medienauswahl-Dialog
- Galeriezugriff wurde der App noch nicht erlaubt oder verweigert

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Tippe im Medienauswahl-Dialog auf die Option „Galerie“ | Ein Systemdialog zur Berechtigungsanfrage wird angezeigt |
| 2 | 2. Wähle im Systemdialog „Erlauben“ | Die Geräte-Galerie öffnet sich |

**Final Expected Result:** Die Galerie wird geöffnet und der Nutzer kann ein Bild auswählen.

---

### TC-461: Berechtigung verweigert im Systemdialog und Fehlerhinweis angezeigt

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-055
**Requirement:** WA-MED-009

**Description:** Verifiziert, dass nach Ablehnung im Systemdialog kein Zugriff möglich ist und eine Fehlermeldung angezeigt wird.

**Preconditions:**
- Nutzer ist in der App eingeloggt
- Nutzer befindet sich im Medienauswahl-Dialog
- Galeriezugriff wurde der App noch nicht erlaubt oder verweigert

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Tippe im Medienauswahl-Dialog auf die Option „Galerie“ | Ein Systemdialog zur Berechtigungsanfrage wird angezeigt |
| 2 | 2. Wähle im Systemdialog „Nicht erlauben“ | Die Galerie öffnet sich nicht |
| 3 | 3. Beobachte die Anzeige in der App | Es erscheint eine verständliche Fehlermeldung mit Hinweis zur Aktivierung der Berechtigung |

**Final Expected Result:** Der Zugriff bleibt gesperrt und der Nutzer wird korrekt informiert.

---

### TC-462: Abbruch der Galerieauswahl durch Nutzer

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-055
**Requirement:** WA-MED-009

**Description:** Verifiziert, dass die App korrekt reagiert, wenn der Nutzer die Galerie ohne Auswahl verlässt.

**Preconditions:**
- Nutzer ist in der App eingeloggt
- Nutzer befindet sich im Medienauswahl-Dialog
- Galeriezugriff ist erlaubt

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Tippe im Medienauswahl-Dialog auf „Galerie“ | Die Geräte-Galerie öffnet sich |
| 2 | 2. Beende die Galerieansicht ohne Bildauswahl (z. B. Zurück/Abbrechen) | Die App kehrt zum Medienauswahl-Dialog zurück |

**Final Expected Result:** Es wird kein Bild ausgewählt, und die App bleibt in einem konsistenten Zustand.

---

### TC-463: Grenzfall: Galerie enthält keine Bilder

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-055
**Requirement:** WA-MED-009

**Description:** Verifiziert die Darstellung und das Verhalten, wenn keine Bilder verfügbar sind.

**Preconditions:**
- Nutzer ist in der App eingeloggt
- Nutzer befindet sich im Medienauswahl-Dialog
- Galeriezugriff ist erlaubt
- Galerie enthält keine Bilder

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Tippe im Medienauswahl-Dialog auf „Galerie“ | Die Geräte-Galerie öffnet sich |
| 2 | 2. Prüfe die Anzeige in der Galerie | Es wird ein leerer Zustand angezeigt (z. B. Hinweis „Keine Bilder vorhanden“) |

**Final Expected Result:** Der Nutzer erhält einen klaren Hinweis, dass keine Bilder verfügbar sind.

---

### TC-464: Fehlerfall: Systemdialog unterdrückt (Berechtigung permanent verweigert)

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-055
**Requirement:** WA-MED-009

**Description:** Verifiziert den Hinweisfluss, wenn das System keinen Dialog mehr zeigt (z. B. „Nicht erneut fragen“ aktiviert).

**Preconditions:**
- Nutzer ist in der App eingeloggt
- Nutzer befindet sich im Medienauswahl-Dialog
- Galeriezugriff wurde permanent verweigert (Systemdialog erscheint nicht mehr)

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Tippe im Medienauswahl-Dialog auf „Galerie“ | Es erscheint kein Systemdialog |
| 2 | 2. Beobachte die App-Reaktion | Es erscheint eine verständliche Fehlermeldung mit Hinweis auf die Systemeinstellungen |

**Final Expected Result:** Der Nutzer wird korrekt informiert, wie der Zugriff manuell aktiviert werden kann.

---

### TC-465: Performance: Galerie öffnet innerhalb akzeptabler Zeit

**Type:** performance
**Priority:** low
**Status:** manual
**User Story:** US-055
**Requirement:** WA-MED-009

**Description:** Stellt sicher, dass die Galerie ohne wahrnehmbare Verzögerung geöffnet wird.

**Preconditions:**
- Nutzer ist in der App eingeloggt
- Nutzer befindet sich im Medienauswahl-Dialog
- Galeriezugriff ist erlaubt

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Tippe im Medienauswahl-Dialog auf „Galerie“ | Die Galerie öffnet sich innerhalb der definierten Zeitvorgabe (z. B. < 2 Sekunden) |

**Final Expected Result:** Die Galerie öffnet sich schnell und ohne UI-Blockierung.

---

### TC-466: Send supported image in HD

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-056
**Requirement:** WA-MED-010

**Description:** Verify that a supported image is sent and displayed in HD when HD option is enabled

**Preconditions:**
- User is logged in
- User has a supported image file (e.g., JPEG/PNG)
- Recipient is reachable

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the media attach dialog in a chat | Media attach dialog is displayed |
| 2 | 2. Select a supported image file | Selected image is shown in preview |
| 3 | 3. Enable the HD quality option | HD option is toggled on |
| 4 | 4. Send the message | Send action is initiated and upload starts |
| 5 | 5. Open the sent media on recipient side | Media renders correctly and is marked/verified as HD |

**Final Expected Result:** Supported image is delivered and displayed in HD quality

---

### TC-467: Send supported video in HD

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-056
**Requirement:** WA-MED-010

**Description:** Verify that a supported video is sent and displayed in HD when HD option is enabled

**Preconditions:**
- User is logged in
- User has a supported video file (e.g., MP4)
- Recipient is reachable

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the media attach dialog in a chat | Media attach dialog is displayed |
| 2 | 2. Select a supported video file | Selected video is shown in preview |
| 3 | 3. Enable the HD quality option | HD option is toggled on |
| 4 | 4. Send the message | Send action is initiated and upload starts |
| 5 | 5. Play the sent video on recipient side | Video plays correctly and is marked/verified as HD |

**Final Expected Result:** Supported video is delivered and displayed in HD quality

---

### TC-468: HD send on limited bandwidth with user warning

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-056
**Requirement:** WA-MED-010

**Description:** Verify user is warned about longer transfer time on limited bandwidth and HD send proceeds

**Preconditions:**
- User is logged in
- Device/network is throttled to limited bandwidth
- User has a supported media file

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the media attach dialog in a chat | Media attach dialog is displayed |
| 2 | 2. Select a supported media file | Selected media is shown in preview |
| 3 | 3. Enable the HD quality option | HD option is toggled on |
| 4 | 4. Attempt to send the message | System displays a warning about longer transfer time |
| 5 | 5. Confirm to continue sending in HD | HD send proceeds and upload starts |

**Final Expected Result:** User is warned about longer transfer time and media is sent in HD

---

### TC-469: HD send on limited bandwidth with quality reduction option

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-056
**Requirement:** WA-MED-010

**Description:** Verify system offers quality reduction on limited bandwidth and handles user selection

**Preconditions:**
- User is logged in
- Device/network is throttled to limited bandwidth
- User has a supported media file

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the media attach dialog in a chat | Media attach dialog is displayed |
| 2 | 2. Select a supported media file | Selected media is shown in preview |
| 3 | 3. Enable the HD quality option | HD option is toggled on |
| 4 | 4. Attempt to send the message | System displays a warning and offers a quality reduction option |
| 5 | 5. Choose to reduce quality and send | Media is sent with reduced quality |

**Final Expected Result:** System offers reduction and sends media in reduced quality when selected

---

### TC-470: Block unsupported format for HD send

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-056
**Requirement:** WA-MED-010

**Description:** Verify that unsupported file formats are blocked and informative error is shown

**Preconditions:**
- User is logged in
- User has an unsupported media file (e.g., TIFF/AVI if unsupported)

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the media attach dialog in a chat | Media attach dialog is displayed |
| 2 | 2. Select an unsupported media file | Selected media is shown in preview or selection is attempted |
| 3 | 3. Enable the HD quality option | HD option is toggled on |
| 4 | 4. Attempt to send the message | System blocks sending and shows an error with supported formats |

**Final Expected Result:** Unsupported file cannot be sent in HD and user sees supported formats

---

### TC-471: Boundary: minimum supported resolution image sent in HD

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-056
**Requirement:** WA-MED-010

**Description:** Verify HD send behavior for minimum supported resolution boundaries

**Preconditions:**
- User is logged in
- User has a supported image at minimum HD threshold (e.g., 1280x720)

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the media attach dialog in a chat | Media attach dialog is displayed |
| 2 | 2. Select the minimum HD resolution image | Selected image is shown in preview |
| 3 | 3. Enable the HD quality option | HD option is toggled on |
| 4 | 4. Send the message | Send action is initiated and upload starts |
| 5 | 5. Verify received image resolution | Image is delivered and displayed with HD resolution |

**Final Expected Result:** Minimum HD resolution image is delivered in HD without degradation

---

### TC-472: Boundary: large file size HD send

**Type:** performance
**Priority:** medium
**Status:** manual
**User Story:** US-056
**Requirement:** WA-MED-010

**Description:** Verify HD send behavior for a large but supported file size

**Preconditions:**
- User is logged in
- User has a supported media file at maximum allowed size
- Recipient is reachable

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the media attach dialog in a chat | Media attach dialog is displayed |
| 2 | 2. Select the large supported media file | Selected media is shown in preview |
| 3 | 3. Enable the HD quality option | HD option is toggled on |
| 4 | 4. Send the message | Upload starts and progress is visible |
| 5 | 5. Verify delivery and playback/rendering | Media is delivered and displayed correctly in HD |

**Final Expected Result:** Large supported file is sent and delivered in HD within acceptable time

---

### TC-473: Toggle HD option off and send standard quality

**Type:** functional
**Priority:** low
**Status:** manual
**User Story:** US-056
**Requirement:** WA-MED-010

**Description:** Verify sending without HD option delivers standard quality media

**Preconditions:**
- User is logged in
- User has a supported media file

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the media attach dialog in a chat | Media attach dialog is displayed |
| 2 | 2. Select a supported media file | Selected media is shown in preview |
| 3 | 3. Ensure HD quality option is off | HD option is toggled off |
| 4 | 4. Send the message | Send action is initiated and upload starts |
| 5 | 5. Verify received media quality | Media is delivered in standard quality |

**Final Expected Result:** Media is sent in standard quality when HD is disabled

---

### TC-474: E2E-001: Textnachricht wird Ende-zu-Ende verschlüsselt übertragen

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-057
**Requirement:** WA-SEC-001

**Description:** Validiert, dass eine einfache Textnachricht zwischen zwei angemeldeten Nutzern E2E-verschlüsselt übertragen und nur vom Empfänger entschlüsselt wird.

**Preconditions:**
- Absender ist registriert und angemeldet
- Empfänger ist registriert, angemeldet und erreichbar
- Stabile Netzwerkverbindung
- E2E-Verschlüsselung ist aktiv

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Absender öffnet den Chat mit dem Empfänger. | Chat-Ansicht mit Eingabefeld wird angezeigt. |
| 2 | 2. Absender gibt die Nachricht "Hallo Empfänger" ein. | Text wird im Eingabefeld korrekt angezeigt. |
| 3 | 3. Absender sendet die Nachricht. | Nachricht erscheint im Chat als gesendet. |
| 4 | 4. Empfänger öffnet den Chat. | Empfänger sieht die Nachricht im Klartext. |
| 5 | 5. Prüfe Transportdaten (z. B. Netzwerk-Trace) auf Klartext. | Nachrichtentext ist im Transport nicht im Klartext lesbar. |

**Final Expected Result:** Nachricht wird nur beim Empfänger entschlüsselt angezeigt; Transportdaten enthalten keinen Klartext.

---

### TC-475: E2E-002: Nachricht mit Sonderzeichen wird korrekt verschlüsselt und angezeigt

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-057
**Requirement:** WA-SEC-001

**Description:** Stellt sicher, dass Sonderzeichen E2E-verschlüsselt übertragen und korrekt dargestellt werden.

**Preconditions:**
- Absender ist registriert und angemeldet
- Empfänger ist registriert, angemeldet und erreichbar
- E2E-Verschlüsselung ist aktiv

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Absender öffnet den Chat mit dem Empfänger. | Chat-Ansicht ist sichtbar. |
| 2 | 2. Absender gibt die Nachricht "äöüß€漢字🙂" ein. | Sonderzeichen und Emoji werden korrekt im Eingabefeld angezeigt. |
| 3 | 3. Absender sendet die Nachricht. | Nachricht erscheint als gesendet. |
| 4 | 4. Empfänger öffnet den Chat. | Empfänger sieht die Nachricht mit allen Sonderzeichen korrekt. |
| 5 | 5. Prüfe Transportdaten auf Klartext-Sonderzeichen. | Sonderzeichen sind im Transport nicht als Klartext sichtbar. |

**Final Expected Result:** Sonderzeichen werden verschlüsselt übertragen und korrekt beim Empfänger angezeigt.

---

### TC-476: E2E-003: Nachricht mit Anhang wird E2E-verschlüsselt übertragen

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-057
**Requirement:** WA-SEC-001

**Description:** Validiert die E2E-Verschlüsselung von Nachrichten mit Dateianhang.

**Preconditions:**
- Absender ist registriert und angemeldet
- Empfänger ist registriert, angemeldet und erreichbar
- E2E-Verschlüsselung ist aktiv
- Testdatei (z. B. PDF) ist verfügbar

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Absender öffnet den Chat mit dem Empfänger. | Chat-Ansicht ist sichtbar. |
| 2 | 2. Absender hängt eine PDF-Datei an und fügt eine kurze Nachricht hinzu. | Anhang wird in der Vorschau angezeigt; Nachricht ist im Eingabefeld. |
| 3 | 3. Absender sendet die Nachricht mit Anhang. | Nachricht und Anhang erscheinen als gesendet. |
| 4 | 4. Empfänger öffnet den Chat und lädt den Anhang. | Anhang wird erfolgreich heruntergeladen und geöffnet. |
| 5 | 5. Prüfe Transportdaten auf Klartextinhalte aus dem Anhang. | Kein Klartext aus der Datei ist im Transport sichtbar. |

**Final Expected Result:** Nachricht und Anhang werden E2E-verschlüsselt übertragen und korrekt angezeigt.

---

### TC-477: E2E-004: Unbefugter Dritter kann Nachricht nicht lesen

**Type:** integration
**Priority:** high
**Status:** manual
**User Story:** US-057
**Requirement:** WA-SEC-001

**Description:** Simuliert einen unbefugten Dritten, der die Übertragung mitliest.

**Preconditions:**
- Absender und Empfänger sind registriert und angemeldet
- E2E-Verschlüsselung ist aktiv
- Netzwerk-Trace-Tool verfügbar

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Starte Netzwerk-Trace am Transportweg (simulierter Dritter). | Trace läuft und zeichnet den Datenverkehr auf. |
| 2 | 2. Absender sendet eine Nachricht an den Empfänger. | Nachricht wird gesendet und beim Empfänger angezeigt. |
| 3 | 3. Analysiere den Trace auf Klartext der Nachricht. | Kein Klartext ist im Trace sichtbar. |

**Final Expected Result:** Daten im Transport sind unlesbar; keine Klartextdaten werden übertragen.

---

### TC-478: E2E-005: Sehr lange Nachricht wird E2E-verschlüsselt übertragen

**Type:** e2e
**Priority:** medium
**Status:** manual
**User Story:** US-057
**Requirement:** WA-SEC-001

**Description:** Boundary-Test für maximale/nahe maximale Nachrichtenlänge.

**Preconditions:**
- Absender und Empfänger sind registriert und angemeldet
- E2E-Verschlüsselung ist aktiv
- Maximale Nachrichtenlänge ist bekannt

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Absender erstellt eine Nachricht mit der maximal erlaubten Länge. | Nachricht wird im Eingabefeld vollständig angezeigt. |
| 2 | 2. Absender sendet die Nachricht. | Nachricht wird gesendet ohne Fehler. |
| 3 | 3. Empfänger öffnet den Chat. | Empfänger sieht die vollständige Nachricht korrekt. |
| 4 | 4. Prüfe Transportdaten auf Klartext. | Inhalte sind nicht im Klartext sichtbar. |

**Final Expected Result:** Maximallange Nachricht wird verschlüsselt übertragen und korrekt angezeigt.

---

### TC-479: E2E-006: Leere Nachricht darf nicht gesendet werden

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-057
**Requirement:** WA-SEC-001

**Description:** Negativtest: verhindert das Senden leerer Nachrichten.

**Preconditions:**
- Absender ist registriert und angemeldet
- Empfänger ist erreichbar

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Absender öffnet den Chat. | Chat-Ansicht ist sichtbar. |
| 2 | 2. Absender lässt das Eingabefeld leer und klickt auf Senden. | Senden ist deaktiviert oder es erscheint eine Validierungsmeldung. |

**Final Expected Result:** Leere Nachricht wird nicht gesendet.

---

### TC-480: E2E-007: Versand schlägt fehl, wenn Empfänger nicht erreichbar ist

**Type:** integration
**Priority:** high
**Status:** manual
**User Story:** US-057
**Requirement:** WA-SEC-001

**Description:** Negativtest für Unreachability des Empfängers.

**Preconditions:**
- Absender ist registriert und angemeldet
- Empfänger ist offline oder nicht erreichbar
- E2E-Verschlüsselung ist aktiv

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Absender öffnet den Chat mit dem Empfänger. | Chat-Ansicht ist sichtbar. |
| 2 | 2. Absender sendet eine Nachricht. | System zeigt Fehler oder Nachricht wird als nicht zugestellt markiert. |

**Final Expected Result:** Nachricht wird nicht erfolgreich zugestellt; geeignete Fehlermeldung/Status wird angezeigt.

---

### TC-481: E2E-008: Nachricht mit mehreren Anhängen wird korrekt verschlüsselt

**Type:** e2e
**Priority:** medium
**Status:** manual
**User Story:** US-057
**Requirement:** WA-SEC-001

**Description:** Testet die Verschlüsselung mehrerer Anhänge gleichzeitig.

**Preconditions:**
- Absender und Empfänger sind registriert und angemeldet
- E2E-Verschlüsselung ist aktiv
- Mehrere Testdateien (z. B. JPG, PDF) sind verfügbar

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Absender fügt mehrere Anhänge hinzu und erstellt eine Nachricht. | Alle Anhänge werden in der Vorschau angezeigt. |
| 2 | 2. Absender sendet die Nachricht. | Nachricht mit Anhängen wird gesendet. |
| 3 | 3. Empfänger lädt alle Anhänge herunter. | Alle Dateien werden korrekt heruntergeladen und geöffnet. |
| 4 | 4. Prüfe Transportdaten auf Klartext der Anhänge. | Keine Klartextinhalte der Dateien sichtbar. |

**Final Expected Result:** Alle Anhänge werden E2E-verschlüsselt übertragen und korrekt angezeigt.

---

### TC-482: E2E-009: Schlüsselwechsel des Empfängers – alte Nachrichten bleiben sicher

**Type:** integration
**Priority:** medium
**Status:** manual
**User Story:** US-057
**Requirement:** WA-SEC-001

**Description:** Stellt sicher, dass bei Schlüsselwechsel keine Klartextdaten übertragbar sind und neue Nachrichten korrekt verschlüsselt werden.

**Preconditions:**
- Absender und Empfänger sind registriert und angemeldet
- E2E-Verschlüsselung ist aktiv
- Empfänger kann seinen Schlüssel erneuern

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Empfänger erneuert seinen Schlüssel (z. B. Reinstallation/Key-Rotation). | Neuer Schlüssel wird erzeugt und aktiv. |
| 2 | 2. Absender sendet eine neue Nachricht. | Nachricht wird gesendet und beim Empfänger korrekt angezeigt. |
| 3 | 3. Prüfe Transportdaten auf Klartext. | Nachricht ist im Transport nicht lesbar. |

**Final Expected Result:** Neue Nachrichten werden mit dem neuen Schlüssel E2E-verschlüsselt übertragen.

---

### TC-483: E2E-010: Performance – E2E-Verschlüsselung unter Last

**Type:** performance
**Priority:** low
**Status:** manual
**User Story:** US-057
**Requirement:** WA-SEC-001

**Description:** Überprüft die Übertragungsgeschwindigkeit bei mehreren Nachrichten mit E2E-Verschlüsselung.

**Preconditions:**
- Absender und Empfänger sind registriert und angemeldet
- E2E-Verschlüsselung ist aktiv
- Lasttest-Tool verfügbar

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Sende 100 Nachrichten innerhalb von 1 Minute. | Alle Nachrichten werden ohne Fehler gesendet. |
| 2 | 2. Empfänger überprüft den Erhalt aller Nachrichten. | Alle Nachrichten werden korrekt angezeigt. |

**Final Expected Result:** E2E-Verschlüsselung bleibt stabil; keine Nachrichtenverluste.

---

### TC-484: Verify encryption metadata successfully shows verified status

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-058
**Requirement:** WA-SEC-002

**Description:** Support-Administrator verifies a sent message with complete encryption metadata

**Preconditions:**
- User is logged in as Support-Administrator
- A sent message exists with complete encryption metadata (key ID, algorithm, timestamp, signature)
- User has access to the message details page

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the message details page for the sent message with complete encryption metadata | Message details page displays encryption metadata section |
| 2 | 2. Click on 'Manuelle Verifizierung starten' | System starts verification and shows processing indicator |
| 3 | 3. Wait for verification to complete | Verification result is displayed |

**Final Expected Result:** System shows verification result as 'verifiziert' and displays used key and algorithm details

---

### TC-485: Verification fails when encryption metadata is missing

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-058
**Requirement:** WA-SEC-002

**Description:** Support-Administrator verifies a message without encryption metadata

**Preconditions:**
- User is logged in as Support-Administrator
- A sent message exists without encryption metadata
- User has access to the message details page

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the message details page for the message without encryption metadata | Message details page displays that encryption metadata is absent |
| 2 | 2. Click on 'Manuelle Verifizierung starten' | System starts verification and then stops with a warning |

**Final Expected Result:** System indicates missing data and marks verification as 'nicht möglich'

---

### TC-486: Verification fails when encryption metadata is incomplete

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-058
**Requirement:** WA-SEC-002

**Description:** Support-Administrator verifies a message with partial encryption metadata

**Preconditions:**
- User is logged in as Support-Administrator
- A sent message exists with incomplete encryption metadata (e.g., missing algorithm or key ID)
- User has access to the message details page

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the message details page for the message with incomplete encryption metadata | Message details page shows partial encryption metadata |
| 2 | 2. Click on 'Manuelle Verifizierung starten' | System starts verification and then stops with a warning |

**Final Expected Result:** System indicates which data is missing and marks verification as 'nicht möglich'

---

### TC-487: Verification fails due to invalid or manipulated data and logs incident

**Type:** integration
**Priority:** high
**Status:** manual
**User Story:** US-058
**Requirement:** WA-SEC-002

**Description:** Support-Administrator verifies a message with manipulated encryption metadata

**Preconditions:**
- User is logged in as Support-Administrator
- A sent message exists with encryption metadata that does not match the message payload (tampered signature)
- Logging/audit system is enabled
- User has access to the message details page

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the message details page for the message with manipulated metadata | Message details page displays encryption metadata section |
| 2 | 2. Click on 'Manuelle Verifizierung starten' | System starts verification and detects invalid data |
| 3 | 3. Open the audit/logs view or check the incident log entry for this verification | A log entry is created with error details and message ID |

**Final Expected Result:** System shows a clear error message indicating verification failure and logs the incident

---

### TC-488: Boundary: Verification with maximum metadata size succeeds

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-058
**Requirement:** WA-SEC-002

**Description:** Verify that the system can handle maximum allowed size of encryption metadata

**Preconditions:**
- User is logged in as Support-Administrator
- A sent message exists with encryption metadata at maximum allowed size
- User has access to the message details page

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the message details page for the message with maximum size metadata | Message details page displays full encryption metadata |
| 2 | 2. Click on 'Manuelle Verifizierung starten' | System starts verification and completes without error |

**Final Expected Result:** System shows verification result as 'verifiziert' and displays key and algorithm details correctly

---

### TC-489: Boundary: Verification with unsupported algorithm shows clear error

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-058
**Requirement:** WA-SEC-002

**Description:** Verify error handling when metadata contains an unsupported algorithm

**Preconditions:**
- User is logged in as Support-Administrator
- A sent message exists with encryption metadata containing an unsupported algorithm
- User has access to the message details page

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the message details page for the message with unsupported algorithm metadata | Message details page displays algorithm field with unsupported value |
| 2 | 2. Click on 'Manuelle Verifizierung starten' | System starts verification and fails with a specific error |

**Final Expected Result:** System shows a clear error message and marks verification as failed; incident is logged if defined by system policy

---

### TC-490: Access control: Non-support administrator cannot start verification

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-058
**Requirement:** WA-SEC-002

**Description:** Verify that only Support-Administrator can initiate manual verification

**Preconditions:**
- User is logged in with a role that is not Support-Administrator
- A sent message exists with encryption metadata
- User has access to the message list but not verification privileges

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the message details page for a sent message | Message details page loads |
| 2 | 2. Locate the manual verification action | Verification action is hidden or disabled |

**Final Expected Result:** User cannot start manual verification without Support-Administrator privileges

---

### TC-491: Repeated verification shows consistent result

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-058
**Requirement:** WA-SEC-002

**Description:** Verify that running manual verification multiple times yields consistent results

**Preconditions:**
- User is logged in as Support-Administrator
- A sent message exists with complete and valid encryption metadata
- User has access to the message details page

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the message details page for the sent message | Message details page displays encryption metadata section |
| 2 | 2. Click on 'Manuelle Verifizierung starten' and wait for completion | Verification result shows 'verifiziert' |
| 3 | 3. Click on 'Manuelle Verifizierung starten' again | Verification completes successfully again |

**Final Expected Result:** System consistently shows 'verifiziert' with correct key and algorithm details across repeated verifications

---

### TC-492: System behavior when verification service is unavailable

**Type:** integration
**Priority:** medium
**Status:** manual
**User Story:** US-058
**Requirement:** WA-SEC-002

**Description:** Verify error handling when verification service cannot be reached

**Preconditions:**
- User is logged in as Support-Administrator
- A sent message exists with complete encryption metadata
- Verification service is unavailable or returns a timeout
- User has access to the message details page

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the message details page for the sent message | Message details page displays encryption metadata section |
| 2 | 2. Click on 'Manuelle Verifizierung starten' | System attempts verification and encounters a timeout or service error |

**Final Expected Result:** System shows a clear error message indicating service unavailability and does not mark as verified

---

### TC-493: App launch prompts authentication when Nachrichtensperre is enabled

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-059
**Requirement:** WA-SEC-003

**Description:** Verify that opening the app with message lock enabled requires authentication before accessing messages

**Preconditions:**
- App is installed
- User is registered and logged in at least once
- Nachrichtensperre is enabled
- Valid authentication method is configured (e.g., PIN/biometric)

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Close the app completely | App is not running in foreground or background |
| 2 | 2. Open the app from the device home screen | Authentication prompt is displayed |
| 3 | 3. Provide valid authentication | User is granted access to messages |

**Final Expected Result:** Access to messages is blocked until successful authentication

---

### TC-494: Repeated incorrect authentication denies access

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-059
**Requirement:** WA-SEC-003

**Description:** Verify that incorrect authentication attempts show an error and deny access

**Preconditions:**
- App is installed
- User is registered
- Nachrichtensperre is enabled
- Authentication method is configured

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the app | Authentication prompt is displayed |
| 2 | 2. Enter an incorrect authentication value | Access is denied and an error message is shown |
| 3 | 3. Repeat incorrect authentication multiple times | Access remains denied and error message is shown each time |

**Final Expected Result:** User cannot access messages and receives a clear error message after incorrect attempts

---

### TC-495: Access remains after short inactivity without re-authentication

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-059
**Requirement:** WA-SEC-003

**Description:** Verify that returning after short inactivity does not require re-authentication

**Preconditions:**
- App is installed
- User is registered
- Nachrichtensperre is enabled
- User has successfully authenticated

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to messages after successful authentication | Messages are visible |
| 2 | 2. Put the app in background for a short inactivity period (e.g., 30 seconds) | App is backgrounded |
| 3 | 3. Return to the app | Messages remain accessible without re-authentication |

**Final Expected Result:** Short inactivity does not trigger re-authentication

---

### TC-496: Re-authentication required after long inactivity (boundary condition)

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-059
**Requirement:** WA-SEC-003

**Description:** Verify that after a long inactivity period, authentication is required again

**Preconditions:**
- App is installed
- User is registered
- Nachrichtensperre is enabled
- User has successfully authenticated

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to messages after successful authentication | Messages are visible |
| 2 | 2. Put the app in background for a long inactivity period (e.g., 10 minutes or per app policy) | App is backgrounded |
| 3 | 3. Return to the app | Authentication prompt is displayed |

**Final Expected Result:** Long inactivity triggers re-authentication

---

### TC-497: Disable Nachrichtensperre removes authentication prompt

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-059
**Requirement:** WA-SEC-003

**Description:** Verify that disabling message lock allows direct access to messages

**Preconditions:**
- App is installed
- User is registered
- Nachrichtensperre is enabled

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the app and authenticate successfully | Messages are visible |
| 2 | 2. Navigate to settings and disable Nachrichtensperre | Nachrichtensperre is disabled |
| 3 | 3. Close and reopen the app | No authentication prompt is shown |

**Final Expected Result:** Messages are accessible without authentication when lock is disabled

---

### TC-498: Authentication prompt appears on app launch after device restart

**Type:** integration
**Priority:** medium
**Status:** manual
**User Story:** US-059
**Requirement:** WA-SEC-003

**Description:** Verify that message lock persists across device restart

**Preconditions:**
- App is installed
- User is registered
- Nachrichtensperre is enabled

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Restart the device | Device restarts successfully |
| 2 | 2. Open the app | Authentication prompt is displayed |
| 3 | 3. Provide valid authentication | User is granted access to messages |

**Final Expected Result:** Nachrichtensperre remains enabled and requires authentication after restart

---

### TC-499: Attempt to access messages via deep link without authentication

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-059
**Requirement:** WA-SEC-003

**Description:** Verify that deep links to messages still require authentication when lock is enabled

**Preconditions:**
- App is installed
- User is registered
- Nachrichtensperre is enabled
- Valid message deep link exists

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Close the app completely | App is not running |
| 2 | 2. Open a deep link to a specific message | Authentication prompt is displayed |
| 3 | 3. Provide valid authentication | User is taken to the targeted message |

**Final Expected Result:** Deep link access is blocked until authentication succeeds

---

### TC-500: Cancel authentication keeps access blocked

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-059
**Requirement:** WA-SEC-003

**Description:** Verify that canceling authentication does not grant access

**Preconditions:**
- App is installed
- User is registered
- Nachrichtensperre is enabled

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the app | Authentication prompt is displayed |
| 2 | 2. Cancel or dismiss the authentication prompt | User remains on lock screen or is returned to previous screen without message access |

**Final Expected Result:** Messages remain inaccessible when authentication is canceled

---

### TC-501: Block existing contact successfully

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-060
**Requirement:** WA-SEC-004

**Description:** Verify that blocking an existing contact marks it as blocked and prevents further messages

**Preconditions:**
- User is logged in
- Contact A exists in user's contact list
- Contact A is not blocked

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open Contact A details page | Contact A details are displayed with Block option available |
| 2 | 2. Tap 'Block' for Contact A | System shows confirmation dialog (if applicable) |
| 3 | 3. Confirm blocking | Contact A status changes to blocked and UI indicates blocked state |
| 4 | 4. Attempt to send a message from Contact A to the user | Message is rejected or not delivered; user does not receive the message |

**Final Expected Result:** Contact A is marked blocked and cannot send messages to the user

---

### TC-502: Block already blocked contact

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-060
**Requirement:** WA-SEC-004

**Description:** Verify that attempting to block an already blocked contact shows an informative message and does not change status

**Preconditions:**
- User is logged in
- Contact B exists in user's contact list
- Contact B is already blocked

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open Contact B details page | Contact B details are displayed with blocked state indicated |
| 2 | 2. Tap 'Block' for Contact B | System displays an informative message that the contact is already blocked |

**Final Expected Result:** Blocked status remains unchanged and user is informed

---

### TC-503: Network failure during block operation

**Type:** integration
**Priority:** high
**Status:** manual
**User Story:** US-060
**Requirement:** WA-SEC-004

**Description:** Verify system behavior when a network or system error occurs while blocking

**Preconditions:**
- User is logged in
- Contact C exists in user's contact list
- Contact C is not blocked
- Network is unavailable or API responds with error

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open Contact C details page | Contact C details are displayed with Block option available |
| 2 | 2. Tap 'Block' for Contact C | System attempts to block and receives an error |

**Final Expected Result:** Error message is shown and Contact C remains unblocked

---

### TC-504: Block action disabled for non-existing contact

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-060
**Requirement:** WA-SEC-004

**Description:** Verify boundary behavior when attempting to block a contact that is not in the contact list

**Preconditions:**
- User is logged in
- Contact D does not exist in user's contact list

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Search for Contact D using the contact search | Contact D is not found in the user's contact list |
| 2 | 2. Attempt to access a block option for Contact D | Block option is not available or system prevents the action |

**Final Expected Result:** User cannot block a non-existing contact

---

### TC-505: Persistence of blocked state after app restart

**Type:** e2e
**Priority:** medium
**Status:** manual
**User Story:** US-060
**Requirement:** WA-SEC-004

**Description:** Verify that blocked status persists across sessions

**Preconditions:**
- User is logged in
- Contact E exists in user's contact list
- Contact E is not blocked

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Block Contact E | Contact E is marked as blocked in UI |
| 2 | 2. Log out and log back in or restart the app | User returns to the app successfully |
| 3 | 3. Open Contact E details page | Contact E is still marked as blocked |

**Final Expected Result:** Blocked status persists after session restart

---

### TC-506: Performance of block action under normal conditions

**Type:** performance
**Priority:** low
**Status:** manual
**User Story:** US-060
**Requirement:** WA-SEC-004

**Description:** Verify the block action completes within acceptable time

**Preconditions:**
- User is logged in
- Contact F exists in user's contact list
- Contact F is not blocked
- Network is stable

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Tap 'Block' for Contact F and start timer | System begins processing the block request |
| 2 | 2. Observe completion time of block operation | Operation completes within the defined SLA (e.g., <= 2 seconds) |

**Final Expected Result:** Block operation completes within acceptable performance threshold

---

### TC-507: Erfolgreiches Melden einer erhaltenen Nachricht

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-061
**Requirement:** WA-SEC-005

**Description:** Validates that a user can report a received message with a selected reason and receives confirmation

**Preconditions:**
- User is logged in
- User has received at least one message
- Message detail view is accessible

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the received message detail view | Message content and actions are visible |
| 2 | 2. Click the 'Melden' (Report) action | Report dialog/panel opens |
| 3 | 3. Select a valid reason (e.g., 'Spam') | Selected reason is highlighted |
| 4 | 4. Click 'Senden' (Submit) in the report dialog | Submission is processed without errors |

**Final Expected Result:** Report is successfully created and a confirmation message is displayed

---

### TC-508: Erfolgreiches Melden eines Kontakts

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-061
**Requirement:** WA-SEC-005

**Description:** Validates that a user can report a contact with a selected reason and receives confirmation

**Preconditions:**
- User is logged in
- User has a contact in the contact list
- Contact detail view is accessible

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the contact detail view | Contact profile and actions are visible |
| 2 | 2. Click the 'Melden' (Report) action | Report dialog/panel opens |
| 3 | 3. Select a valid reason (e.g., 'Belästigung') | Selected reason is highlighted |
| 4 | 4. Click 'Senden' (Submit) in the report dialog | Submission is processed without errors |

**Final Expected Result:** Report is successfully created and a confirmation message is displayed

---

### TC-509: Doppelte Meldung derselben Nachricht verhindern

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-061
**Requirement:** WA-SEC-005

**Description:** Ensures that a message already reported cannot be reported again by the same user

**Preconditions:**
- User is logged in
- User has already reported the same message
- Message detail view is accessible

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the reported message detail view | Message content and actions are visible |
| 2 | 2. Click the 'Melden' (Report) action | Report dialog/panel opens |
| 3 | 3. Select any reason | Selected reason is highlighted |
| 4 | 4. Click 'Senden' (Submit) | Submission is blocked |

**Final Expected Result:** A warning is shown indicating the message has already been reported and no new report is created

---

### TC-510: Doppelte Meldung desselben Kontakts verhindern

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-061
**Requirement:** WA-SEC-005

**Description:** Ensures that a contact already reported cannot be reported again by the same user

**Preconditions:**
- User is logged in
- User has already reported the same contact
- Contact detail view is accessible

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the reported contact detail view | Contact profile and actions are visible |
| 2 | 2. Click the 'Melden' (Report) action | Report dialog/panel opens |
| 3 | 3. Select any reason | Selected reason is highlighted |
| 4 | 4. Click 'Senden' (Submit) | Submission is blocked |

**Final Expected Result:** A warning is shown indicating the contact has already been reported and no new report is created

---

### TC-511: Meldung ohne Auswahl eines Grundes

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-061
**Requirement:** WA-SEC-005

**Description:** Validates that submitting a report without selecting a reason shows an error and does not save the report

**Preconditions:**
- User is logged in
- User is viewing a message or contact detail
- Report dialog can be opened

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the report dialog | Report dialog/panel opens with a list of reasons |
| 2 | 2. Do not select any reason | No reason is selected |
| 3 | 3. Click 'Senden' (Submit) | Client-side or server-side validation is triggered |

**Final Expected Result:** An error message is displayed and the report is not saved

---

### TC-512: Abbrechen der Meldung

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-061
**Requirement:** WA-SEC-005

**Description:** Ensures cancelling a report does not create a report record

**Preconditions:**
- User is logged in
- User is viewing a message or contact detail
- Report dialog can be opened

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the report dialog | Report dialog/panel opens |
| 2 | 2. Select a valid reason | Selected reason is highlighted |
| 3 | 3. Click 'Abbrechen' (Cancel) or close the dialog | Dialog closes without submission |

**Final Expected Result:** No report is created and no confirmation is shown

---

### TC-513: Grenzfall: Längster zulässiger Freitext-Grund (falls vorhanden)

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-061
**Requirement:** WA-SEC-005

**Description:** Validates boundary conditions for optional free-text reason input (max length)

**Preconditions:**
- User is logged in
- Report dialog supports an optional free-text reason field
- User is viewing a message or contact detail

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the report dialog | Report dialog/panel opens |
| 2 | 2. Select a valid reason that enables free-text input | Free-text input becomes available |
| 3 | 3. Enter text at the maximum allowed length | Input accepts the maximum length without errors |
| 4 | 4. Click 'Senden' (Submit) | Submission is processed without validation errors |

**Final Expected Result:** Report is saved successfully and a confirmation message is displayed

---

### TC-514: Grenzfall: Überschreitung der maximalen Freitext-Länge (falls vorhanden)

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-061
**Requirement:** WA-SEC-005

**Description:** Validates that exceeding max length in free-text reason is rejected

**Preconditions:**
- User is logged in
- Report dialog supports an optional free-text reason field
- User is viewing a message or contact detail

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the report dialog | Report dialog/panel opens |
| 2 | 2. Select a valid reason that enables free-text input | Free-text input becomes available |
| 3 | 3. Enter text exceeding the maximum allowed length | Input is rejected or validation error appears |
| 4 | 4. Click 'Senden' (Submit) | Submission is blocked |

**Final Expected Result:** An error message is displayed and the report is not saved

---

### TC-515: Activate PIN security with valid PIN

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-062
**Requirement:** WA-SEC-006

**Description:** Verify that a logged-in user can enable PIN security with a valid PIN and it is enforced on next login.

**Preconditions:**
- User account exists
- User is logged in
- User is on Security Settings page
- PIN security is currently disabled

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Toggle ON the PIN security option | PIN setup form is displayed |
| 2 | 2. Enter a valid PIN (e.g., 1234) in the PIN field | PIN input is accepted with no validation errors |
| 3 | 3. Confirm the same PIN in the confirmation field | Confirmation input is accepted with no validation errors |
| 4 | 4. Save the security settings | Success message is shown and PIN security status is enabled |
| 5 | 5. Log out | User is logged out |
| 6 | 6. Log in with valid username and password | PIN entry prompt appears after credential validation |
| 7 | 7. Enter the correct PIN | User is granted access and logged in successfully |

**Final Expected Result:** PIN security is enabled and required for subsequent logins.

---

### TC-516: Reject login with incorrect PIN

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-062
**Requirement:** WA-SEC-006

**Description:** Verify that access is denied when an incorrect PIN is entered after enabling PIN security.

**Preconditions:**
- User account exists
- PIN security is enabled for the account
- User is logged out

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Log in with valid username and password | PIN entry prompt appears |
| 2 | 2. Enter an incorrect PIN (e.g., 9999) | Access is denied and an error message is displayed |

**Final Expected Result:** Login is blocked and user remains unauthenticated.

---

### TC-517: Deactivate PIN security

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-062
**Requirement:** WA-SEC-006

**Description:** Verify that a user can disable PIN security and it is no longer required on subsequent logins.

**Preconditions:**
- User account exists
- User is logged in
- User is on Security Settings page
- PIN security is enabled

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Toggle OFF the PIN security option | Deactivation confirmation prompt is displayed |
| 2 | 2. Confirm deactivation | Success message is shown and PIN security status is disabled |
| 3 | 3. Log out | User is logged out |
| 4 | 4. Log in with valid username and password | User is logged in without a PIN prompt |

**Final Expected Result:** PIN security is disabled and not requested on future logins.

---

### TC-518: PIN setup fails with mismatched confirmation

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-062
**Requirement:** WA-SEC-006

**Description:** Verify validation when PIN and confirmation do not match.

**Preconditions:**
- User account exists
- User is logged in
- User is on Security Settings page
- PIN security is currently disabled

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Toggle ON the PIN security option | PIN setup form is displayed |
| 2 | 2. Enter a valid PIN (e.g., 1234) | PIN input is accepted |
| 3 | 3. Enter a different PIN in confirmation (e.g., 1235) | Validation error indicates PINs do not match |
| 4 | 4. Attempt to save the security settings | Save is blocked and PIN security remains disabled |

**Final Expected Result:** PIN security is not enabled until matching PINs are provided.

---

### TC-519: PIN setup fails with invalid length (boundary)

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-062
**Requirement:** WA-SEC-006

**Description:** Verify that PIN setup enforces valid length boundaries (too short/too long).

**Preconditions:**
- User account exists
- User is logged in
- User is on Security Settings page
- PIN security is currently disabled
- PIN policy requires 4 digits

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Toggle ON the PIN security option | PIN setup form is displayed |
| 2 | 2. Enter a 3-digit PIN (e.g., 123) | Validation error indicates PIN length is invalid |
| 3 | 3. Enter a 5-digit PIN (e.g., 12345) | Validation error indicates PIN length is invalid |
| 4 | 4. Enter a 4-digit PIN (e.g., 1234) and confirm it | PIN inputs are accepted with no errors |
| 5 | 5. Save the security settings | PIN security is enabled successfully |

**Final Expected Result:** Only valid-length PINs are accepted; invalid lengths are rejected.

---

### TC-520: PIN setup rejects non-numeric characters

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-062
**Requirement:** WA-SEC-006

**Description:** Verify that the PIN field only accepts numeric input.

**Preconditions:**
- User account exists
- User is logged in
- User is on Security Settings page
- PIN security is currently disabled
- PIN policy requires numeric digits only

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Toggle ON the PIN security option | PIN setup form is displayed |
| 2 | 2. Enter a PIN with letters/symbols (e.g., 12a4 or 12!4) | Validation error indicates non-numeric characters are not allowed |
| 3 | 3. Enter a valid numeric PIN (e.g., 5678) and confirm it | PIN inputs are accepted with no errors |
| 4 | 4. Save the security settings | PIN security is enabled successfully |

**Final Expected Result:** Non-numeric PINs are rejected; numeric-only PINs are accepted.

---

### TC-521: PIN prompt appears on every login when enabled

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-062
**Requirement:** WA-SEC-006

**Description:** Verify that PIN is consistently requested on subsequent logins once enabled.

**Preconditions:**
- User account exists
- PIN security is enabled
- User is logged out

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Log in with valid username and password | PIN entry prompt appears |
| 2 | 2. Enter the correct PIN and complete login | User is logged in successfully |
| 3 | 3. Log out | User is logged out |
| 4 | 4. Log in again with valid username and password | PIN entry prompt appears again |

**Final Expected Result:** PIN prompt is shown on every login while enabled.

---

### TC-522: Spam-Erkennung markiert typische Spam-Nachricht

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-063
**Requirement:** WA-SEC-007

**Description:** Verifiziert, dass eine Nachricht mit typischen Spam-Merkmalen automatisch als Spam markiert und verschoben wird

**Preconditions:**
- Spam-Erkennung ist aktiviert
- Support-Mitarbeiter ist eingeloggt
- Spam-Ordner/Bereich ist verfügbar

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Sende eine eingehende Nachricht mit typischen Spam-Merkmalen (z. B. viele Links, verdächtige Betreffzeile) | Nachricht wird vom System analysiert |
| 2 | 2. Öffne den Posteingang | Die Nachricht erscheint nicht im normalen Posteingang |
| 3 | 3. Öffne den Spam-Bereich | Die Nachricht ist als Spam markiert und im Spam-Bereich vorhanden |

**Final Expected Result:** Spam-Nachricht wird automatisch erkannt, markiert und verschoben

---

### TC-523: Legitime Nachricht wird normal zugestellt

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-063
**Requirement:** WA-SEC-007

**Description:** Stellt sicher, dass legitime Nachrichten ohne Spam-Merkmale nicht blockiert werden

**Preconditions:**
- Spam-Erkennung ist aktiviert
- Support-Mitarbeiter ist eingeloggt

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Sende eine legitime eingehende Nachricht ohne Spam-Merkmale | Nachricht wird vom System analysiert |
| 2 | 2. Öffne den Posteingang | Die Nachricht ist im Posteingang sichtbar und nicht als Spam markiert |

**Final Expected Result:** Legitime Nachricht wird normal zugestellt

---

### TC-524: Falsch-positiv markierte Nachricht manuell als legitim kennzeichnen

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-063
**Requirement:** WA-SEC-007

**Description:** Prüft, dass eine fälschlich als Spam markierte Nachricht manuell freigegeben wird

**Preconditions:**
- Spam-Erkennung ist aktiviert
- Support-Mitarbeiter ist eingeloggt
- Eine legitime Nachricht wurde fälschlicherweise als Spam markiert

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Öffne den Spam-Bereich | Falsch-positiv markierte Nachricht ist sichtbar |
| 2 | 2. Markiere die Nachricht als legitim (z. B. Aktion 'Kein Spam') | System bestätigt die Änderung |
| 3 | 3. Öffne den Posteingang | Die Nachricht wurde in den Posteingang zugestellt |

**Final Expected Result:** Nachricht wird zugestellt und als legitim gekennzeichnet

---

### TC-525: Lernmechanismus verbessert Erkennung für ähnliche Nachrichten

**Type:** integration
**Priority:** medium
**Status:** manual
**User Story:** US-063
**Requirement:** WA-SEC-007

**Description:** Validiert, dass das System nach manueller Freigabe ähnliche Nachrichten korrekt behandelt

**Preconditions:**
- Spam-Erkennung ist aktiviert
- Support-Mitarbeiter ist eingeloggt
- Eine Nachricht wurde zuvor als legitim markiert, obwohl sie als Spam erkannt wurde

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Sende eine neue Nachricht mit ähnlichen Merkmalen wie die zuvor freigegebene Nachricht | Nachricht wird vom System analysiert |
| 2 | 2. Öffne den Posteingang | Die Nachricht wird normal zugestellt oder nicht mehr als Spam markiert |

**Final Expected Result:** Erkennung berücksichtigt die manuelle Korrektur für ähnliche Nachrichten

---

### TC-526: Spam-Erkennungsdienst ist nicht verfügbar

**Type:** integration
**Priority:** high
**Status:** manual
**User Story:** US-063
**Requirement:** WA-SEC-007

**Description:** Stellt sicher, dass Nachrichten zugestellt werden und eine Warnung protokolliert wird

**Preconditions:**
- Spam-Erkennungsdienst ist vorübergehend nicht verfügbar
- Support-Mitarbeiter ist eingeloggt

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Sende eine eingehende Nachricht während der Nichtverfügbarkeit | System kann die Nachricht nicht durch den Spam-Dienst prüfen |
| 2 | 2. Öffne den Posteingang | Die Nachricht wird zugestellt |
| 3 | 3. Prüfe Monitoring/Logs | Es wurde eine Warnung über den Ausfall protokolliert |

**Final Expected Result:** Nachricht wird zugestellt und Warnung wird geloggt

---

### TC-527: Grenzfall: Nachricht mit minimalen Spam-Merkmalen

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-063
**Requirement:** WA-SEC-007

**Description:** Prüft das Verhalten bei Nachrichten, die knapp an der Spam-Schwelle liegen

**Preconditions:**
- Spam-Erkennung ist aktiviert
- Support-Mitarbeiter ist eingeloggt
- Spam-Schwellenwerte sind konfiguriert

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Sende eine Nachricht mit genau dem Schwellenwert an Spam-Indikatoren | Nachricht wird analysiert |
| 2 | 2. Öffne Posteingang und Spam-Bereich | Nachricht erscheint gemäß definierter Schwellenlogik (entweder zugestellt oder als Spam markiert) |

**Final Expected Result:** System verarbeitet Grenzfälle konsistent mit der Schwellenwertkonfiguration

---

### TC-528: Ausgehende Nachricht mit Spam-Merkmalen wird markiert

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-063
**Requirement:** WA-SEC-007

**Description:** Verifiziert, dass auch ausgehende Nachrichten mit Spam-Merkmalen erkannt und separiert werden

**Preconditions:**
- Spam-Erkennung ist aktiviert
- Support-Mitarbeiter ist eingeloggt
- Ausgehende Nachrichten werden geprüft

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Erstelle und sende eine ausgehende Nachricht mit typischen Spam-Merkmalen | Nachricht wird vom System analysiert |
| 2 | 2. Öffne den Bereich für ausgehende Nachrichten/Spam-Quarantäne | Nachricht ist als Spam markiert und verschoben |

**Final Expected Result:** Ausgehende Spam-Nachricht wird erkannt und separiert

---

### TC-529: Deaktivierte Spam-Erkennung lässt alle Nachrichten durch (Negativtest)

**Type:** functional
**Priority:** low
**Status:** manual
**User Story:** US-063
**Requirement:** WA-SEC-007

**Description:** Stellt sicher, dass bei deaktivierter Spam-Erkennung keine Markierung erfolgt

**Preconditions:**
- Spam-Erkennung ist deaktiviert
- Support-Mitarbeiter ist eingeloggt

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Sende eine eingehende Nachricht mit typischen Spam-Merkmalen | Nachricht wird nicht durch Spam-Dienst geprüft |
| 2 | 2. Öffne den Posteingang | Die Nachricht ist im normalen Posteingang sichtbar |

**Final Expected Result:** Bei deaktivierter Erkennung werden Nachrichten nicht als Spam markiert

---

### TC-530: Leere oder sehr kurze Nachricht wird korrekt behandelt

**Type:** functional
**Priority:** low
**Status:** manual
**User Story:** US-063
**Requirement:** WA-SEC-007

**Description:** Prüft die Verarbeitung bei minimalem Inhalt (Boundary Condition)

**Preconditions:**
- Spam-Erkennung ist aktiviert
- Support-Mitarbeiter ist eingeloggt

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Sende eine leere oder sehr kurze Nachricht | Nachricht wird analysiert |
| 2 | 2. Öffne den Posteingang | Nachricht wird zugestellt und nicht als Spam markiert |

**Final Expected Result:** Minimalinhalte führen nicht zu fälschlicher Spam-Klassifizierung

---

### TC-531: Mask IPs in signaling for outgoing call (positive)

**Type:** integration
**Priority:** high
**Status:** manual
**User Story:** US-064
**Requirement:** WA-SEC-008

**Description:** Verify IP addresses are masked in signaling and metadata for an outgoing call.

**Preconditions:**
- Support-Mitarbeiter is logged in
- IP-Verschleierungsdienst is available
- Test caller and callee endpoints are configured

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | Initiate an outgoing call from the system to a test endpoint | Call setup starts and connection is established |
| 2 | Capture signaling messages and metadata exchanged with the counterparty | Signaling and metadata are captured successfully |
| 3 | Inspect captured signaling and metadata for IP address fields | IP addresses are masked and do not reveal real endpoint IPs |

**Final Expected Result:** Outgoing call signaling and metadata show masked IPs only.

---

### TC-532: Mask IPs in signaling for incoming call (positive)

**Type:** integration
**Priority:** high
**Status:** manual
**User Story:** US-064
**Requirement:** WA-SEC-008

**Description:** Verify IP addresses are masked in signaling and metadata for an incoming call.

**Preconditions:**
- Support-Mitarbeiter is logged in
- IP-Verschleierungsdienst is available
- External test endpoint can place calls into the system

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | Place an incoming call from an external test endpoint to the system | Call setup starts and connection is established |
| 2 | Capture signaling messages and metadata received by the external counterparty | Signaling and metadata are captured successfully |
| 3 | Inspect captured signaling and metadata for IP address fields | IP addresses are masked and do not reveal real endpoint IPs |

**Final Expected Result:** Incoming call signaling and metadata show masked IPs only.

---

### TC-533: Mask IPs in call logs and analytics (positive)

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-064
**Requirement:** WA-SEC-008

**Description:** Verify stored logs and analytics display only masked IP addresses.

**Preconditions:**
- Support-Mitarbeiter is logged in with access to logs/analytics
- IP-Verschleierungsdienst is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | Complete a call (incoming or outgoing) through the system | Call completes and is recorded |
| 2 | Open call logs/analytics for the completed call | Call details are displayed |
| 3 | Review IP address fields in logs/analytics | Only masked IP addresses are stored and displayed |

**Final Expected Result:** Logs and analytics do not expose real IP addresses.

---

### TC-534: Prevent call when IP masking service is unavailable (negative)

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-064
**Requirement:** WA-SEC-008

**Description:** Ensure calls are blocked and a clear error message is shown when the IP masking service is down.

**Preconditions:**
- Support-Mitarbeiter is logged in
- IP-Verschleierungsdienst is unavailable

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | Attempt to initiate an outgoing call | Call is not initiated |
| 2 | Observe the user-facing error message | A clear error message indicates a service outage for IP masking |

**Final Expected Result:** Call is prevented and user receives a clear outage message.

---

### TC-535: Prevent incoming call when IP masking service is unavailable (negative)

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-064
**Requirement:** WA-SEC-008

**Description:** Ensure inbound calls are blocked when IP masking service is unavailable and a clear error is shown.

**Preconditions:**
- Support-Mitarbeiter is logged in
- IP-Verschleierungsdienst is unavailable
- External test endpoint can place calls into the system

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | Place an incoming call from an external endpoint to the system | Call is rejected and not connected |
| 2 | Check user-facing notification or UI message | A clear error message indicates IP masking service outage |

**Final Expected Result:** Incoming call is blocked and user sees outage message.

---

### TC-536: Verify no real IPs stored when masking enabled (negative validation)

**Type:** integration
**Priority:** high
**Status:** manual
**User Story:** US-064
**Requirement:** WA-SEC-008

**Description:** Ensure raw IP addresses are never stored in logs when masking is enabled.

**Preconditions:**
- Support-Mitarbeiter is logged in with access to log storage
- IP-Verschleierungsdienst is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | Complete a call through the system | Call completes and is recorded |
| 2 | Query backend log storage for the call record | Log record is retrieved |
| 3 | Validate IP address fields against known real endpoint IPs | No log entries contain real IP addresses |

**Final Expected Result:** Backend logs store only masked IPs, never real IPs.

---

### TC-537: Boundary: Masking format consistency for IPv4

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-064
**Requirement:** WA-SEC-008

**Description:** Verify masking format for IPv4 addresses is consistent and compliant.

**Preconditions:**
- Support-Mitarbeiter is logged in
- IP-Verschleierungsdienst is available
- Test endpoint uses IPv4

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | Place a call using an IPv4 endpoint | Call connects successfully |
| 2 | Check signaling/metadata and logs for the call | IPv4 addresses are masked using the approved format |

**Final Expected Result:** IPv4 masking format is consistent across signaling, metadata, and logs.

---

### TC-538: Boundary: Masking format consistency for IPv6

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-064
**Requirement:** WA-SEC-008

**Description:** Verify masking format for IPv6 addresses is consistent and compliant.

**Preconditions:**
- Support-Mitarbeiter is logged in
- IP-Verschleierungsdienst is available
- Test endpoint uses IPv6

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | Place a call using an IPv6 endpoint | Call connects successfully |
| 2 | Check signaling/metadata and logs for the call | IPv6 addresses are masked using the approved format |

**Final Expected Result:** IPv6 masking format is consistent across signaling, metadata, and logs.

---

### TC-539: Service recovery: Calls succeed after masking service restored

**Type:** e2e
**Priority:** medium
**Status:** manual
**User Story:** US-064
**Requirement:** WA-SEC-008

**Description:** Ensure calls are allowed once the IP masking service is back online.

**Preconditions:**
- Support-Mitarbeiter is logged in
- IP-Verschleierungsdienst has been unavailable and is restored

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | Initiate an outgoing call after service restoration | Call connects successfully |
| 2 | Inspect signaling/metadata for IP masking | IP addresses are masked |

**Final Expected Result:** Calls succeed and IPs are masked after service recovery.

---

### TC-540: Performance: Call setup latency with IP masking enabled

**Type:** performance
**Priority:** low
**Status:** manual
**User Story:** US-064
**Requirement:** WA-SEC-008

**Description:** Measure call setup time impact with IP masking enabled.

**Preconditions:**
- Support-Mitarbeiter is logged in
- IP-Verschleierungsdienst is available
- Baseline call setup metrics are defined

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | Initiate multiple calls with IP masking enabled | Calls connect successfully |
| 2 | Measure call setup time for each call | Metrics are captured |
| 3 | Compare metrics against baseline thresholds | Setup times are within acceptable limits |

**Final Expected Result:** IP masking does not cause unacceptable call setup latency.

---

### TC-541: Push-Benachrichtigung bei aktiviertem Push und Online-Geraet

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-065
**Requirement:** WA-NOT-001

**Description:** Validiert, dass eine Push-Benachrichtigung innerhalb von 5 Sekunden zugestellt und angezeigt wird, wenn Push aktiviert ist und das Geraet online ist.

**Preconditions:**
- Nutzer ist registriert und eingeloggt
- Push-Benachrichtigungen sind in der App und im Betriebssystem aktiviert
- Geraet ist online
- Testnachricht kann vom System gesendet werden

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Sende eine neue Nachricht vom System an den Nutzer. | Nachricht wird vom System akzeptiert und Versand gestartet. |
| 2 | 2. Starte einen Timer beim Versand und beobachte das Geraet. | Eine Push-Benachrichtigung erscheint auf dem Geraet. |
| 3 | 3. Stoppe den Timer beim Erscheinen der Benachrichtigung. | Benachrichtigung erscheint innerhalb von 5 Sekunden. |

**Final Expected Result:** Die Push-Benachrichtigung wird innerhalb von 5 Sekunden zugestellt und angezeigt.

---

### TC-542: Push-Benachrichtigung bei Offline-Geraet und nach Wiederverbindung

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-065
**Requirement:** WA-NOT-001

**Description:** Validiert, dass eine Benachrichtigung nach Wiederherstellung der Verbindung automatisch zugestellt wird.

**Preconditions:**
- Nutzer ist registriert und eingeloggt
- Push-Benachrichtigungen sind in der App und im Betriebssystem aktiviert
- Geraet kann offline geschaltet werden

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Schalte das Geraet in den Offline-Modus. | Geraet hat keine Netzwerkverbindung. |
| 2 | 2. Sende eine neue Nachricht vom System an den Nutzer. | Nachricht wird vom System akzeptiert und Versand gestartet. |
| 3 | 3. Warte 10 Sekunden und beobachte das Geraet. | Keine Push-Benachrichtigung erscheint, solange das Geraet offline ist. |
| 4 | 4. Stelle die Netzwerkverbindung wieder her. | Geraet ist online. |
| 5 | 5. Beobachte das Geraet nach Wiederverbindung. | Die ausstehende Push-Benachrichtigung wird automatisch zugestellt und angezeigt. |

**Final Expected Result:** Die Benachrichtigung wird nach Wiederherstellung der Verbindung automatisch zugestellt.

---

### TC-543: Kein Push bei deaktivierten Push-Benachrichtigungen

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-065
**Requirement:** WA-NOT-001

**Description:** Validiert, dass keine Push-Benachrichtigung zugestellt wird und der Versand protokolliert wird, wenn Push deaktiviert ist.

**Preconditions:**
- Nutzer ist registriert und eingeloggt
- Push-Benachrichtigungen sind in der App deaktiviert
- Geraet ist online
- Zugriff auf System-Logs ist vorhanden

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Sende eine neue Nachricht vom System an den Nutzer. | Nachricht wird vom System akzeptiert und Versand gestartet. |
| 2 | 2. Beobachte das Geraet für 10 Sekunden. | Keine Push-Benachrichtigung erscheint. |
| 3 | 3. Pruefe die System-Logs fuer den Versand. | Der Versandversuch ist im System protokolliert. |

**Final Expected Result:** Keine Push-Benachrichtigung wird zugestellt und der Versand ist protokolliert.

---

### TC-544: Grenzfall: Zustellung genau bei 5 Sekunden

**Type:** performance
**Priority:** medium
**Status:** manual
**User Story:** US-065
**Requirement:** WA-NOT-001

**Description:** Validiert den Grenzfall, dass die Benachrichtigung innerhalb der maximal erlaubten 5 Sekunden zugestellt wird.

**Preconditions:**
- Nutzer ist registriert und eingeloggt
- Push-Benachrichtigungen sind aktiviert
- Geraet ist online
- Messwerkzeug fuer Zustellzeit ist vorhanden

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Sende eine neue Nachricht vom System an den Nutzer unter kontrollierten Bedingungen (Last normal). | Nachricht wird vom System akzeptiert und Versand gestartet. |
| 2 | 2. Messe die Zeit bis zum Anzeigen der Push-Benachrichtigung. | Zustellzeit ist <= 5 Sekunden. |

**Final Expected Result:** Die Benachrichtigung wird spaetestens nach 5 Sekunden angezeigt.

---

### TC-545: Mehrfachzustellung bei kurzer Offline-Phase

**Type:** integration
**Priority:** medium
**Status:** manual
**User Story:** US-065
**Requirement:** WA-NOT-001

**Description:** Validiert, dass mehrere Nachrichten waehrend der Offline-Phase nach Wiederverbindung zugestellt werden.

**Preconditions:**
- Nutzer ist registriert und eingeloggt
- Push-Benachrichtigungen sind aktiviert
- Geraet kann offline geschaltet werden

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Schalte das Geraet in den Offline-Modus. | Geraet hat keine Netzwerkverbindung. |
| 2 | 2. Sende zwei neue Nachrichten vom System an den Nutzer im Abstand von 5 Sekunden. | Beide Nachrichten werden vom System akzeptiert. |
| 3 | 3. Stelle die Netzwerkverbindung wieder her. | Geraet ist online. |
| 4 | 4. Beobachte die Benachrichtigungen auf dem Geraet. | Beide ausstehenden Push-Benachrichtigungen werden zugestellt. |

**Final Expected Result:** Alle waehrend der Offline-Phase gesendeten Benachrichtigungen werden nach Wiederverbindung zugestellt.

---

### TC-546: Deaktivierung von Push auf Betriebssystem-Ebene

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-065
**Requirement:** WA-NOT-001

**Description:** Negativfall: Wenn OS-Push deaktiviert ist, darf keine Benachrichtigung erscheinen, und der Versand wird protokolliert.

**Preconditions:**
- Nutzer ist registriert und eingeloggt
- Push-Benachrichtigungen sind in der App aktiviert
- Push-Benachrichtigungen sind im Betriebssystem deaktiviert
- Geraet ist online
- Zugriff auf System-Logs ist vorhanden

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Sende eine neue Nachricht vom System an den Nutzer. | Nachricht wird vom System akzeptiert und Versand gestartet. |
| 2 | 2. Beobachte das Geraet fuer 10 Sekunden. | Keine Push-Benachrichtigung erscheint. |
| 3 | 3. Pruefe die System-Logs fuer den Versand. | Der Versandversuch ist im System protokolliert. |

**Final Expected Result:** Keine Push-Benachrichtigung wird angezeigt und der Versand ist protokolliert.

---

### TC-547: Schnelles Umschalten: Push deaktivieren vor Versand

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-065
**Requirement:** WA-NOT-001

**Description:** Validiert, dass bei Deaktivierung unmittelbar vor dem Versand keine Benachrichtigung zugestellt wird.

**Preconditions:**
- Nutzer ist registriert und eingeloggt
- Geraet ist online
- Push-Benachrichtigungen sind initial aktiviert
- Zugriff auf System-Logs ist vorhanden

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Deaktiviere Push-Benachrichtigungen in der App. | Push-Benachrichtigungen sind deaktiviert. |
| 2 | 2. Sende eine neue Nachricht vom System an den Nutzer. | Nachricht wird vom System akzeptiert und Versand gestartet. |
| 3 | 3. Beobachte das Geraet fuer 10 Sekunden. | Keine Push-Benachrichtigung erscheint. |
| 4 | 4. Pruefe die System-Logs fuer den Versand. | Der Versandversuch ist im System protokolliert. |

**Final Expected Result:** Keine Push-Benachrichtigung wird zugestellt und der Versand ist protokolliert.

---

### TC-548: Speichern und Anzeigen der Vorschaukonfiguration - Vollständige Vorschau

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-066
**Requirement:** WA-NOT-002

**Description:** Verify that selecting and saving a full-content preview configuration displays the correct preview.

**Preconditions:**
- User is logged in
- User is on notification settings page
- At least one notification exists

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Select preview configuration 'Full content' from available options | The 'Full content' option is selected |
| 2 | 2. Click the 'Save' button | A success message is displayed |
| 3 | 3. Navigate to the notification preview area | A preview is shown according to the 'Full content' configuration |

**Final Expected Result:** System displays notification previews including full message content as configured.

---

### TC-549: Speichern und Anzeigen der Vorschaukonfiguration - Metadaten-only

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-066
**Requirement:** WA-NOT-002

**Description:** Verify that selecting a metadata-only preview configuration shows only sender and time.

**Preconditions:**
- User is logged in
- User is on notification settings page
- At least one notification exists

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Select preview configuration 'Metadata only' from available options | The 'Metadata only' option is selected |
| 2 | 2. Click the 'Save' button | A success message is displayed |
| 3 | 3. Navigate to the notification preview area | Only sender and time are visible in the preview |

**Final Expected Result:** System displays notification previews containing only sender and time metadata.

---

### TC-550: Sensible Inhalte werden ausgeblendet bei Metadaten-only

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-066
**Requirement:** WA-NOT-002

**Description:** Verify that sensitive content is hidden when preview is configured to hide contents.

**Preconditions:**
- User is logged in
- User is on notification settings page
- At least one notification exists with sensitive content

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Select preview configuration 'Metadata only' from available options | The 'Metadata only' option is selected |
| 2 | 2. Click the 'Save' button | A success message is displayed |
| 3 | 3. Navigate to the notification preview area for a sensitive notification | Only sender and time are visible; message text is hidden |

**Final Expected Result:** Sensitive notification content is not displayed; only metadata is shown.

---

### TC-551: Ungültige Vorschaukonfiguration wird abgelehnt

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-066
**Requirement:** WA-NOT-002

**Description:** Verify that the system rejects invalid preview configuration values and displays an error message.

**Preconditions:**
- User is logged in
- User is on notification settings page

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Submit a preview configuration with an invalid value (e.g., via API or tampered request) | The system detects the invalid configuration |
| 2 | 2. Observe the system response | A clear, user-friendly error message is displayed and the configuration is not saved |

**Final Expected Result:** Invalid configuration is rejected and a comprehensible error message is shown.

---

### TC-552: Boundary: Save configuration with no change

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-066
**Requirement:** WA-NOT-002

**Description:** Verify that saving the already selected configuration behaves correctly (idempotent).

**Preconditions:**
- User is logged in
- User is on notification settings page
- A preview configuration is already saved

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Click the 'Save' button without changing the configuration | The system processes the request without error |
| 2 | 2. Navigate to the notification preview area | The preview remains consistent with the saved configuration |

**Final Expected Result:** Configuration remains unchanged and preview displays correctly.

---

### TC-553: Boundary: Switching configurations updates preview immediately after save

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-066
**Requirement:** WA-NOT-002

**Description:** Verify that switching from full content to metadata-only updates the preview accordingly after saving.

**Preconditions:**
- User is logged in
- User is on notification settings page
- At least one notification exists

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Select 'Full content' and click 'Save' | Success message is displayed |
| 2 | 2. Verify preview shows full content | Full content is visible in preview |
| 3 | 3. Select 'Metadata only' and click 'Save' | Success message is displayed |
| 4 | 4. Verify preview shows only metadata | Only sender and time are visible; message text hidden |

**Final Expected Result:** Preview updates correctly when switching between configurations.

---

### TC-554: Integration: Persisted configuration across sessions

**Type:** integration
**Priority:** medium
**Status:** manual
**User Story:** US-066
**Requirement:** WA-NOT-002

**Description:** Verify that saved preview configuration persists after logout and login.

**Preconditions:**
- User is logged in
- User is on notification settings page
- At least one notification exists

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Select 'Metadata only' and click 'Save' | Success message is displayed |
| 2 | 2. Log out from the application | User is logged out and redirected to login page |
| 3 | 3. Log in again with the same user | User is logged in successfully |
| 4 | 4. Navigate to notification preview area | Preview shows metadata only as previously saved |

**Final Expected Result:** Saved configuration persists across sessions and displays correctly.

---

### TC-555: Negative: Missing configuration value on save

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-066
**Requirement:** WA-NOT-002

**Description:** Verify system handles empty/blank configuration submission.

**Preconditions:**
- User is logged in
- User is on notification settings page

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Attempt to save with no configuration selected (blank or null value) | System rejects the save attempt |
| 2 | 2. Observe error message | A clear message indicates that a valid configuration must be selected |

**Final Expected Result:** Blank configuration is not saved and an error is displayed.

---

### TC-556: E2E: Preview configuration and display workflow

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-066
**Requirement:** WA-NOT-002

**Description:** Verify end-to-end flow from configuration selection to preview display for a typical user.

**Preconditions:**
- User is logged in
- At least one notification exists

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open notification settings | Notification settings page is displayed |
| 2 | 2. Select 'Metadata only' configuration and save | Success message is displayed |
| 3 | 3. Go to notifications list or preview area | Notification preview displays only sender and time |

**Final Expected Result:** User can configure and view notification preview according to selected settings.

---

### TC-557: Schnellantwort erfolgreich senden und in Konversation anzeigen

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-067
**Requirement:** WA-NOT-003

**Description:** Validiert das erfolgreiche Senden einer Schnellantwort aus der Benachrichtigung und die Anzeige in der Konversation

**Preconditions:**
- User A ist eingeloggt
- User B hat User A eine neue Nachricht gesendet
- Eine Benachrichtigung mit Schnellantwortfeld ist sichtbar
- User A hat Schreibberechtigung für den Chat
- Netzwerkverbindung ist stabil

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Tippe eine gültige Antwort in das Schnellantwortfeld der Benachrichtigung | Der eingegebene Text wird im Schnellantwortfeld angezeigt |
| 2 | 2. Tippe auf Senden | Die Benachrichtigung bestätigt den Versand (z. B. kurzer Ladeindikator oder Erfolgshinweis) |
| 3 | 3. Öffne die Konversation mit User B | Die gesendete Antwort wird in der Konversation angezeigt |
| 4 | 4. Prüfe bei User B den Eingang der Nachricht | User B erhält die Schnellantwort |

**Final Expected Result:** Die Schnellantwort wird zugestellt und in der Konversation angezeigt

---

### TC-558: Schnellantwort blockiert ohne Schreibberechtigung

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-067
**Requirement:** WA-NOT-003

**Description:** Stellt sicher, dass das System das Senden ohne Schreibberechtigung verhindert und eine Fehlermeldung anzeigt

**Preconditions:**
- User A ist eingeloggt
- User A hat keine Schreibberechtigung für den Chat (z. B. gesperrt/Read-only)
- Eine Benachrichtigung mit Schnellantwortfeld ist sichtbar

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Tippe eine Antwort in das Schnellantwortfeld | Der eingegebene Text wird im Schnellantwortfeld angezeigt |
| 2 | 2. Tippe auf Senden | Das System verhindert das Senden |
| 3 | 3. Beobachte die Benachrichtigung oder UI-Feedback | Eine verständliche Fehlermeldung zur fehlenden Schreibberechtigung wird angezeigt |

**Final Expected Result:** Senden wird blockiert und eine passende Fehlermeldung erscheint

---

### TC-559: Schnellantwort bei unterbrochener Netzwerkverbindung

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-067
**Requirement:** WA-NOT-003

**Description:** Prüft das Verhalten bei fehlender Netzwerkverbindung während des Sendens

**Preconditions:**
- User A ist eingeloggt
- Eine Benachrichtigung mit Schnellantwortfeld ist sichtbar
- User A hat Schreibberechtigung für den Chat
- Netzwerkverbindung ist unterbrochen

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Tippe eine Antwort in das Schnellantwortfeld | Der eingegebene Text wird im Schnellantwortfeld angezeigt |
| 2 | 2. Tippe auf Senden | Der Versand schlägt fehl |
| 3 | 3. Beobachte die Benachrichtigung oder UI-Feedback | Ein Hinweis zur fehlgeschlagenen Zustellung wird angezeigt |

**Final Expected Result:** Nachricht wird nicht zugestellt und Nutzer erhält einen Fehlerhinweis

---

### TC-560: Grenzfall: Leere Schnellantwort nicht sendbar

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-067
**Requirement:** WA-NOT-003

**Description:** Stellt sicher, dass leere Antworten nicht gesendet werden

**Preconditions:**
- User A ist eingeloggt
- Eine Benachrichtigung mit Schnellantwortfeld ist sichtbar
- User A hat Schreibberechtigung für den Chat
- Netzwerkverbindung ist stabil

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Lasse das Schnellantwortfeld leer | Kein Text ist im Schnellantwortfeld sichtbar |
| 2 | 2. Tippe auf Senden | Senden wird blockiert oder ein Hinweis auf leere Nachricht wird angezeigt |

**Final Expected Result:** Leere Schnellantwort wird nicht gesendet

---

### TC-561: Grenzfall: Maximale Nachrichtenlänge in Schnellantwort

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-067
**Requirement:** WA-NOT-003

**Description:** Verifiziert das Verhalten beim Senden einer Antwort mit maximal erlaubter Länge

**Preconditions:**
- User A ist eingeloggt
- Eine Benachrichtigung mit Schnellantwortfeld ist sichtbar
- User A hat Schreibberechtigung für den Chat
- Netzwerkverbindung ist stabil
- Maximale Nachrichtenlänge ist definiert

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Tippe eine Antwort mit genau der maximal erlaubten Länge in das Schnellantwortfeld | Der gesamte Text wird im Schnellantwortfeld angezeigt |
| 2 | 2. Tippe auf Senden | Der Versand wird erfolgreich initiiert |
| 3 | 3. Öffne die Konversation | Die Antwort wird vollständig angezeigt |

**Final Expected Result:** Antwort mit maximaler Länge wird erfolgreich zugestellt

---

### TC-562: Grenzfall: Überschreitung der maximalen Nachrichtenlänge

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-067
**Requirement:** WA-NOT-003

**Description:** Prüft, dass das System die Eingabe über der maximalen Länge verhindert oder entsprechend validiert

**Preconditions:**
- User A ist eingeloggt
- Eine Benachrichtigung mit Schnellantwortfeld ist sichtbar
- User A hat Schreibberechtigung für den Chat
- Netzwerkverbindung ist stabil
- Maximale Nachrichtenlänge ist definiert

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Tippe eine Antwort, die die maximale Länge überschreitet | Die Eingabe wird begrenzt oder ein Validierungshinweis erscheint |
| 2 | 2. Versuche auf Senden zu tippen | Senden wird verhindert oder Validierung wird angezeigt |

**Final Expected Result:** Überlange Antwort wird nicht gesendet

---

### TC-563: Benachrichtigung nicht sichtbar: Schnellantwort nicht verfügbar

**Type:** functional
**Priority:** low
**Status:** manual
**User Story:** US-067
**Requirement:** WA-NOT-003

**Description:** Stellt sicher, dass Schnellantwort nur bei sichtbarer Benachrichtigung möglich ist

**Preconditions:**
- User A ist eingeloggt
- Keine Benachrichtigung ist sichtbar

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Versuche Schnellantwort ohne sichtbare Benachrichtigung zu senden | Es gibt kein Schnellantwortfeld oder keine Möglichkeit zum Senden |

**Final Expected Result:** Schnellantwort ist ohne Benachrichtigung nicht verfügbar

---

### TC-564: Mehrere Benachrichtigungen: Schnellantwort an korrekten Absender

**Type:** integration
**Priority:** medium
**Status:** manual
**User Story:** US-067
**Requirement:** WA-NOT-003

**Description:** Validiert, dass die Schnellantwort der richtigen Konversation zugeordnet wird

**Preconditions:**
- User A ist eingeloggt
- Benachrichtigungen von User B und User C sind sichtbar
- User A hat Schreibberechtigung für beide Chats
- Netzwerkverbindung ist stabil

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Wähle die Benachrichtigung von User B und tippe eine Antwort | Der Text wird im Schnellantwortfeld der Benachrichtigung von User B angezeigt |
| 2 | 2. Tippe auf Senden | Versand wird bestätigt |
| 3 | 3. Öffne die Konversationen mit User B und User C | Die Antwort erscheint nur in der Konversation mit User B |

**Final Expected Result:** Schnellantwort wird an den korrekten Absender gesendet

---

### TC-565: Schnellantwort nach Wiederherstellung der Netzwerkverbindung

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-067
**Requirement:** WA-NOT-003

**Description:** Prüft, ob nach Netzwerkwiederherstellung eine erneute Schnellantwort erfolgreich gesendet werden kann

**Preconditions:**
- User A ist eingeloggt
- Eine Benachrichtigung mit Schnellantwortfeld ist sichtbar
- User A hat Schreibberechtigung für den Chat
- Netzwerkverbindung ist unterbrochen

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Sende eine Schnellantwort während das Netzwerk unterbrochen ist | Der Versand schlägt fehl und es wird ein Fehlerhinweis angezeigt |
| 2 | 2. Stelle die Netzwerkverbindung wieder her | Die App erkennt die wiederhergestellte Verbindung |
| 3 | 3. Sende erneut eine Schnellantwort | Der Versand wird erfolgreich bestätigt |
| 4 | 4. Öffne die Konversation | Die Antwort wird in der Konversation angezeigt |

**Final Expected Result:** Nach Wiederherstellung der Verbindung wird die Schnellantwort erfolgreich gesendet

---

### TC-566: Aktivierung des Nicht-Stoeren-Modus zeigt Status sofort und unterdrueckt Benachrichtigungen

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-068
**Requirement:** WA-NOT-004

**Description:** Prueft, dass der Modus aktiviert wird, Status sichtbar ist und Benachrichtigungen unterdrueckt werden.

**Preconditions:**
- Nutzer ist angemeldet
- Nutzer befindet sich in den Einstellungen
- Benachrichtigungen sind fuer das Konto aktiviert

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Nicht-Stoeren-Modus-Schalter auf 'Ein' stellen | Statusanzeige zeigt sofort 'Nicht-Stoeren aktiv' |
| 2 | 2. Testbenachrichtigung ausloesen (z. B. Nachricht senden) | Benachrichtigung wird nicht angezeigt/zugestellt |

**Final Expected Result:** Nicht-Stoeren ist aktiv, Status sichtbar, Benachrichtigungen sind unterdrueckt.

---

### TC-567: Manuelle Deaktivierung des Nicht-Stoeren-Modus stellt Benachrichtigungen wieder her

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-068
**Requirement:** WA-NOT-004

**Description:** Prueft, dass der Modus manuell deaktiviert werden kann und Benachrichtigungen wieder zugestellt werden.

**Preconditions:**
- Nutzer ist angemeldet
- Nicht-Stoeren-Modus ist aktiv
- Nutzer befindet sich in den Einstellungen

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Nicht-Stoeren-Modus-Schalter auf 'Aus' stellen | Statusanzeige zeigt sofort 'Nicht-Stoeren deaktiviert' |
| 2 | 2. Testbenachrichtigung ausloesen | Benachrichtigung wird normal zugestellt |

**Final Expected Result:** Nicht-Stoeren ist deaktiviert, Status sichtbar, Benachrichtigungen werden zugestellt.

---

### TC-568: Automatische Deaktivierung bei Endzeit

**Type:** integration
**Priority:** high
**Status:** manual
**User Story:** US-068
**Requirement:** WA-NOT-004

**Description:** Prueft, dass der Modus bei Erreichen der Endzeit automatisch deaktiviert wird.

**Preconditions:**
- Nutzer ist angemeldet
- Nicht-Stoeren-Modus ist aktiv
- Eine Endzeit ist in naher Zukunft gesetzt
- Nutzer befindet sich in den Einstellungen oder App laeuft im Hintergrund

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Warten bis die festgelegte Endzeit erreicht ist | Statusanzeige wechselt automatisch zu 'Nicht-Stoeren deaktiviert' |
| 2 | 2. Testbenachrichtigung ausloesen | Benachrichtigung wird normal zugestellt |

**Final Expected Result:** Modus wird bei Endzeit automatisch deaktiviert und Benachrichtigungen funktionieren normal.

---

### TC-569: Fehlgeschlagene Speicherung bei Aktivierung zeigt Fehler und behaelt vorherigen Status

**Type:** integration
**Priority:** high
**Status:** manual
**User Story:** US-068
**Requirement:** WA-NOT-004

**Description:** Prueft, dass bei Speicherausfall eine Fehlermeldung angezeigt wird und der Modus unveraendert bleibt.

**Preconditions:**
- Nutzer ist angemeldet
- Nutzer befindet sich in den Einstellungen
- Backend/Speicher ist nicht erreichbar oder gibt Fehler zurueck

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Nicht-Stoeren-Modus-Schalter auf 'Ein' stellen | Fehlermeldung zur Speicherung wird angezeigt |
| 2 | 2. Statusanzeige pruefen | Status bleibt im vorherigen Zustand (z. B. 'deaktiviert') |

**Final Expected Result:** Fehler wird angezeigt und der Modus bleibt unveraendert.

---

### TC-570: Fehlgeschlagene Speicherung bei Deaktivierung zeigt Fehler und behaelt vorherigen Status

**Type:** integration
**Priority:** medium
**Status:** manual
**User Story:** US-068
**Requirement:** WA-NOT-004

**Description:** Prueft, dass bei Speicherausfall die Deaktivierung nicht greift und eine Fehlermeldung erscheint.

**Preconditions:**
- Nutzer ist angemeldet
- Nicht-Stoeren-Modus ist aktiv
- Nutzer befindet sich in den Einstellungen
- Backend/Speicher ist nicht erreichbar oder gibt Fehler zurueck

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Nicht-Stoeren-Modus-Schalter auf 'Aus' stellen | Fehlermeldung zur Speicherung wird angezeigt |
| 2 | 2. Statusanzeige pruefen | Status bleibt 'Nicht-Stoeren aktiv' |

**Final Expected Result:** Fehler wird angezeigt und der Modus bleibt aktiv.

---

### TC-571: Sofortige Sichtbarkeit des Status nach Aktivierung in der UI

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-068
**Requirement:** WA-NOT-004

**Description:** Prueft UI-Feedback und Statusindikator bei Aktivierung.

**Preconditions:**
- Nutzer ist angemeldet
- Nutzer befindet sich in den Einstellungen

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Nicht-Stoeren-Modus aktivieren | Statusindikator/Label aktualisiert sich ohne Verzoegerung |
| 2 | 2. Einstellungen verlassen und erneut oeffnen | Statusindikator zeigt weiterhin 'aktiv' |

**Final Expected Result:** Status ist sofort und konsistent sichtbar.

---

### TC-572: Grenzfall: Endzeit ist bereits erreicht

**Type:** functional
**Priority:** low
**Status:** manual
**User Story:** US-068
**Requirement:** WA-NOT-004

**Description:** Prueft Verhalten, wenn Endzeit in der Vergangenheit liegt.

**Preconditions:**
- Nutzer ist angemeldet
- Nutzer befindet sich in den Einstellungen
- Endzeit ist in der Vergangenheit gesetzt

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Nicht-Stoeren-Modus aktivieren | System deaktiviert den Modus sofort oder verhindert Aktivierung |
| 2 | 2. Statusanzeige pruefen | Status zeigt 'deaktiviert' |

**Final Expected Result:** Modus ist nicht aktiv, Benachrichtigungen werden normal zugestellt.

---

### TC-573: Benachrichtigungen werden waehrend aktivem Modus dauerhaft unterdrueckt

**Type:** e2e
**Priority:** medium
**Status:** manual
**User Story:** US-068
**Requirement:** WA-NOT-004

**Description:** Prueft die anhaltende Unterdrueckung ueber einen Zeitraum.

**Preconditions:**
- Nutzer ist angemeldet
- Nicht-Stoeren-Modus ist aktiv
- Mehrere Benachrichtigungstypen sind aktiviert

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Mehrere Benachrichtigungen nacheinander ausloesen | Keine der Benachrichtigungen wird angezeigt/zugestellt |
| 2 | 2. Modus deaktivieren und erneut Benachrichtigungen ausloesen | Benachrichtigungen werden wieder angezeigt/zugestellt |

**Final Expected Result:** Unterdrueckung gilt waehrend aktivem Modus und endet nach Deaktivierung.

---

### TC-574: Immediate notification on reaction to user's message

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-069
**Requirement:** WA-NOT-005

**Description:** Verify that the message author receives an immediate notification when another user reacts to their message.

**Preconditions:**
- User A and User B have accounts
- User A is logged in
- User A has sent a message in a channel where User B can react
- Notifications are enabled for User A

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. User B reacts to User A's message with a valid reaction | The reaction is registered in the system |
| 2 | 2. Observe User A's notification feed | A new notification appears immediately indicating the reaction |

**Final Expected Result:** User A receives an immediate notification referencing the specific reaction.

---

### TC-575: Multiple reactions in quick succession with per-reaction notifications

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-069
**Requirement:** WA-NOT-005

**Description:** Verify each reaction triggers a separate notification when per-reaction setting is enabled.

**Preconditions:**
- User A is logged in
- User A has sent a message
- User B and User C can react
- User A's notification setting is configured to receive per-reaction notifications

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. User B reacts to User A's message | Reaction from User B is registered |
| 2 | 2. User C reacts to the same message within 5 seconds | Reaction from User C is registered |
| 3 | 3. Check User A's notification feed | Two distinct notifications are displayed, one for each reaction |

**Final Expected Result:** User A receives individual notifications for each reaction.

---

### TC-576: Multiple reactions in quick succession with aggregated notifications

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-069
**Requirement:** WA-NOT-005

**Description:** Verify aggregated notification is sent when aggregation setting is enabled.

**Preconditions:**
- User A is logged in
- User A has sent a message
- User B and User C can react
- User A's notification setting is configured to receive aggregated notifications

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. User B reacts to User A's message | Reaction from User B is registered |
| 2 | 2. User C reacts to the same message within the aggregation window | Reaction from User C is registered |
| 3 | 3. Check User A's notification feed after the aggregation window expires | A single aggregated notification appears summarizing both reactions |

**Final Expected Result:** User A receives one aggregated notification consistent with settings.

---

### TC-577: Reaction removed should not trigger new notification

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-069
**Requirement:** WA-NOT-005

**Description:** Verify removing a reaction does not create a new notification.

**Preconditions:**
- User A is logged in
- User A has sent a message
- User B has already reacted to User A's message
- User A has received the initial reaction notification

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. User B removes their reaction | Reaction removal is registered |
| 2 | 2. Check User A's notification feed | No new notification is created |

**Final Expected Result:** No additional notification is created for reaction removal.

---

### TC-578: Reaction removed updates existing notification when supported

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-069
**Requirement:** WA-NOT-005

**Description:** Verify existing notification is updated to indicate removal when the system supports update behavior.

**Preconditions:**
- User A is logged in
- User A has sent a message
- User B has reacted to the message
- System supports notification updates on reaction removal

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. User B removes the reaction | Reaction removal is registered |
| 2 | 2. Check User A's notification feed for the original notification | The existing notification is updated to clearly indicate the reaction was removed |

**Final Expected Result:** The notification is updated to reflect removal without creating a new notification.

---

### TC-579: Notification delivery after temporary service outage

**Type:** integration
**Priority:** high
**Status:** manual
**User Story:** US-069
**Requirement:** WA-NOT-005

**Description:** Verify notifications are delivered after notification service recovery.

**Preconditions:**
- User A is logged in
- User A has sent a message
- Notification service is unavailable
- System is configured to queue notifications for later delivery

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. User B reacts to User A's message while notification service is down | Reaction is registered and notification is queued |
| 2 | 2. Restore notification service | Notification service is operational |
| 3 | 3. Check User A's notification feed | Queued notification is delivered after recovery |

**Final Expected Result:** Notification is reliably delivered after service restoration.

---

### TC-580: No notification for reactions to others' messages

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-069
**Requirement:** WA-NOT-005

**Description:** Verify user does not receive notifications for reactions to messages they did not author.

**Preconditions:**
- User A is logged in
- User B has sent a message
- User C can react

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. User C reacts to User B's message | Reaction is registered |
| 2 | 2. Check User A's notification feed | No notification related to User B's message appears |

**Final Expected Result:** User A receives no notification for reactions on others' messages.

---

### TC-581: Notification content references correct message and reaction

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-069
**Requirement:** WA-NOT-005

**Description:** Verify the notification includes correct message context and reaction details.

**Preconditions:**
- User A is logged in
- User A has sent a message
- User B can react

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. User B reacts with a specific emoji to User A's message | Reaction is registered with the emoji |
| 2 | 2. View the notification received by User A | Notification indicates the reacting user, the emoji, and the message context |

**Final Expected Result:** Notification accurately reflects reaction and message context.

---

### TC-582: Boundary: high volume reactions within aggregation window

**Type:** performance
**Priority:** medium
**Status:** manual
**User Story:** US-069
**Requirement:** WA-NOT-005

**Description:** Verify system handles a burst of reactions and aggregates or lists them based on settings.

**Preconditions:**
- User A is logged in
- User A has sent a message
- Aggregation setting enabled for User A

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Trigger 50 reactions from different users within the aggregation window | All reactions are registered without errors |
| 2 | 2. Check User A's notification feed after aggregation window | A single aggregated notification summarizes the 50 reactions |

**Final Expected Result:** System handles high volume reactions and delivers a correct aggregated notification.

---

### TC-583: Negative: notification not delivered when user notifications disabled

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-069
**Requirement:** WA-NOT-005

**Description:** Verify no notification is sent when user has disabled reaction notifications.

**Preconditions:**
- User A is logged in
- User A has sent a message
- User A has disabled reaction notifications

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. User B reacts to User A's message | Reaction is registered |
| 2 | 2. Check User A's notification feed | No new notification appears |

**Final Expected Result:** No notification is delivered when reaction notifications are disabled.

---

### TC-584: Activate call notifications and persist setting

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-070
**Requirement:** WA-NOT-006

**Description:** Verify enabling call notifications in settings saves and activates them

**Preconditions:**
- User is logged in
- User is on notification settings page
- Call notifications are currently disabled
- Network connection is stable

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Toggle the call notifications switch to ON | Call notifications toggle displays ON state |
| 2 | 2. Click the Save button | A success confirmation is shown |
| 3 | 3. Refresh or re-open the notification settings page | Call notifications toggle remains ON |

**Final Expected Result:** Call notifications are enabled and the setting is persisted

---

### TC-585: Disable call notifications and ensure no call alert is received

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-070
**Requirement:** WA-NOT-006

**Description:** Verify no call notification is delivered when call notifications are disabled and other notifications are unchanged

**Preconditions:**
- User is logged in
- User is on notification settings page
- Call notifications are currently enabled
- At least one other notification type is enabled
- Test system can simulate an incoming call

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Toggle the call notifications switch to OFF | Call notifications toggle displays OFF state |
| 2 | 2. Click the Save button | A success confirmation is shown |
| 3 | 3. Trigger an incoming call to the user | No call notification is received |
| 4 | 4. Trigger a different notification type (e.g., message) | The other notification is received normally |

**Final Expected Result:** Call notifications are suppressed while other notifications remain unaffected

---

### TC-586: Network interruption during call notification setting change

**Type:** integration
**Priority:** high
**Status:** manual
**User Story:** US-070
**Requirement:** WA-NOT-006

**Description:** Verify error handling and no change persisted when network is temporarily unavailable

**Preconditions:**
- User is logged in
- User is on notification settings page
- Call notifications are currently enabled
- Network connection can be interrupted

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Simulate a temporary network interruption | Network is unavailable for the client |
| 2 | 2. Toggle the call notifications switch to OFF | Call notifications toggle displays OFF state locally |
| 3 | 3. Click the Save button | An error message is displayed indicating the save failed |
| 4 | 4. Restore network and refresh the settings page | Call notifications toggle reverts to ON (previous setting) |

**Final Expected Result:** A failure message is shown and the original setting is retained

---

### TC-587: Ensure separate settings do not impact other notifications when enabling call notifications

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-070
**Requirement:** WA-NOT-006

**Description:** Verify enabling call notifications does not change other notification preferences

**Preconditions:**
- User is logged in
- User is on notification settings page
- Call notifications are disabled
- Email notifications are enabled
- Push notifications are disabled

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Toggle the call notifications switch to ON | Call notifications toggle displays ON state |
| 2 | 2. Click the Save button | A success confirmation is shown |
| 3 | 3. Verify email notifications setting | Email notifications remain enabled |
| 4 | 4. Verify push notifications setting | Push notifications remain disabled |

**Final Expected Result:** Only call notifications change; all other notification settings remain unchanged

---

### TC-588: Attempt to save without changing call notifications

**Type:** functional
**Priority:** low
**Status:** manual
**User Story:** US-070
**Requirement:** WA-NOT-006

**Description:** Verify saving without changes does not alter call notification state

**Preconditions:**
- User is logged in
- User is on notification settings page
- Call notifications are enabled
- Network connection is stable

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Click the Save button without changing any settings | System indicates no changes saved or shows success without changes |
| 2 | 2. Refresh or re-open the notification settings page | Call notifications remain enabled |

**Final Expected Result:** No unintended changes occur when saving without modifications

---

### TC-589: Boundary: Rapid toggle before saving

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-070
**Requirement:** WA-NOT-006

**Description:** Verify final state is saved when user toggles call notifications multiple times before saving

**Preconditions:**
- User is logged in
- User is on notification settings page
- Call notifications are disabled
- Network connection is stable

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Toggle call notifications to ON | Toggle shows ON |
| 2 | 2. Toggle call notifications back to OFF | Toggle shows OFF |
| 3 | 3. Toggle call notifications to ON again | Toggle shows ON |
| 4 | 4. Click the Save button | A success confirmation is shown |
| 5 | 5. Refresh or re-open the notification settings page | Call notifications remain ON |

**Final Expected Result:** The final toggle state before save is persisted correctly

---

### TC-590: Synchronisierung zeigt übereinstimmende WhatsApp-Kontakte bei erteilter Berechtigung

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-071
**Requirement:** WA-CON-001

**Description:** Verifiziert, dass bei erteilter Kontaktberechtigung die Synchronisierung passende WhatsApp-Nutzer anzeigt.

**Preconditions:**
- User ist in der App angemeldet
- Kontaktberechtigung für die App ist erteilt
- Gerät enthält Kontakte mit WhatsApp-Registrierung
- Netzwerkverbindung ist verfügbar

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigiere zur Kontakte-Ansicht. | Kontakte-Ansicht wird angezeigt. |
| 2 | 2. Tippe auf "Synchronisieren". | Synchronisierung startet und ein Fortschrittsindikator wird angezeigt. |
| 3 | 3. Warte, bis die Synchronisierung abgeschlossen ist. | Übereinstimmende WhatsApp-Kontakte werden in der Liste angezeigt. |

**Final Expected Result:** Alle Kontakte, die WhatsApp-Nutzer sind, werden korrekt angezeigt.

---

### TC-591: Nicht-WhatsApp-Kontakte werden nicht als WhatsApp-Nutzer angezeigt

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-071
**Requirement:** WA-CON-001

**Description:** Stellt sicher, dass Kontakte ohne WhatsApp-Konto nicht fälschlich angezeigt werden.

**Preconditions:**
- User ist in der App angemeldet
- Kontaktberechtigung für die App ist erteilt
- Gerät enthält Kontakte ohne WhatsApp-Registrierung
- Netzwerkverbindung ist verfügbar

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigiere zur Kontakte-Ansicht. | Kontakte-Ansicht wird angezeigt. |
| 2 | 2. Tippe auf "Synchronisieren". | Synchronisierung startet und ein Fortschrittsindikator wird angezeigt. |
| 3 | 3. Warte, bis die Synchronisierung abgeschlossen ist. | Nur WhatsApp-Kontakte werden angezeigt. |

**Final Expected Result:** Kontakte ohne WhatsApp-Konto werden nicht als WhatsApp-Nutzer angezeigt.

---

### TC-592: Fehlermeldung bei verweigerter Kontaktberechtigung

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-071
**Requirement:** WA-CON-001

**Description:** Validiert, dass bei fehlender Berechtigung eine klare Fehlermeldung und ein Hinweis auf Einstellungen angezeigt wird.

**Preconditions:**
- User ist in der App angemeldet
- Kontaktberechtigung für die App ist verweigert oder entzogen

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigiere zur Kontakte-Ansicht. | Kontakte-Ansicht wird angezeigt. |
| 2 | 2. Tippe auf "Synchronisieren". | Eine klare Fehlermeldung wird angezeigt. |
| 3 | 3. Prüfe die Fehlermeldung auf einen Hinweis zu den Einstellungen. | Die Meldung bietet eine Option/Anweisung zur Berechtigungsvergabe in den Einstellungen. |

**Final Expected Result:** Synchronisierung wird blockiert, und der Nutzer wird zur Berechtigungsvergabe angeleitet.

---

### TC-593: Synchronisierung mit leerem Kontaktbuch

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-071
**Requirement:** WA-CON-001

**Description:** Testet das Verhalten, wenn keine Kontakte vorhanden sind.

**Preconditions:**
- User ist in der App angemeldet
- Kontaktberechtigung für die App ist erteilt
- Kontaktbuch ist leer
- Netzwerkverbindung ist verfügbar

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigiere zur Kontakte-Ansicht. | Kontakte-Ansicht wird angezeigt. |
| 2 | 2. Tippe auf "Synchronisieren". | Synchronisierung startet und ein Fortschrittsindikator wird angezeigt. |
| 3 | 3. Warte, bis die Synchronisierung abgeschlossen ist. | Eine leere Liste oder ein Hinweis wie "Keine WhatsApp-Kontakte gefunden" wird angezeigt. |

**Final Expected Result:** Die App zeigt korrekt an, dass keine WhatsApp-Kontakte vorhanden sind.

---

### TC-594: Synchronisierung nach erneuter Berechtigungsvergabe

**Type:** e2e
**Priority:** medium
**Status:** manual
**User Story:** US-071
**Requirement:** WA-CON-001

**Description:** Stellt sicher, dass nach dem Erteilen der Berechtigung die Synchronisierung erfolgreich möglich ist.

**Preconditions:**
- User ist in der App angemeldet
- Kontaktberechtigung für die App ist zunächst verweigert
- Gerät enthält Kontakte mit WhatsApp-Registrierung
- Netzwerkverbindung ist verfügbar

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigiere zur Kontakte-Ansicht und tippe auf "Synchronisieren". | Eine Fehlermeldung zur fehlenden Berechtigung wird angezeigt. |
| 2 | 2. Öffne die Geräteeinstellungen und erteile der App Kontaktzugriff. | Berechtigung wird in den Einstellungen erteilt. |
| 3 | 3. Kehre zur App zurück und starte die Synchronisierung erneut. | Synchronisierung startet und zeigt die übereinstimmenden WhatsApp-Kontakte. |

**Final Expected Result:** Nach Berechtigungsvergabe funktioniert die Synchronisierung wie erwartet.

---

### TC-595: Abbruch der Synchronisierung bei fehlender Netzwerkverbindung

**Type:** integration
**Priority:** medium
**Status:** manual
**User Story:** US-071
**Requirement:** WA-CON-001

**Description:** Validiert das Verhalten, wenn während der Synchronisierung keine Verbindung besteht.

**Preconditions:**
- User ist in der App angemeldet
- Kontaktberechtigung für die App ist erteilt
- Gerät enthält Kontakte mit WhatsApp-Registrierung
- Netzwerkverbindung ist instabil oder nicht verfügbar

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigiere zur Kontakte-Ansicht. | Kontakte-Ansicht wird angezeigt. |
| 2 | 2. Deaktiviere die Netzwerkverbindung. | Netzwerk ist nicht verfügbar. |
| 3 | 3. Tippe auf "Synchronisieren". | Eine Fehlermeldung oder ein Hinweis auf fehlende Verbindung wird angezeigt. |

**Final Expected Result:** Die App informiert den Nutzer über die fehlende Verbindung und verhindert inkonsistente Ergebnisse.

---

### TC-596: Synchronisierung mit großer Kontaktliste

**Type:** performance
**Priority:** low
**Status:** manual
**User Story:** US-071
**Requirement:** WA-CON-001

**Description:** Überprüft die Performance und korrekte Anzeige bei vielen Kontakten.

**Preconditions:**
- User ist in der App angemeldet
- Kontaktberechtigung für die App ist erteilt
- Gerät enthält eine große Kontaktliste (z. B. 5000 Kontakte)
- Netzwerkverbindung ist verfügbar

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigiere zur Kontakte-Ansicht. | Kontakte-Ansicht wird angezeigt. |
| 2 | 2. Tippe auf "Synchronisieren". | Synchronisierung startet und ein Fortschrittsindikator wird angezeigt. |
| 3 | 3. Messe die Synchronisierungsdauer und prüfe die Anzeige der Ergebnisse. | Synchronisierung beendet sich in akzeptabler Zeit und Ergebnisse sind korrekt. |

**Final Expected Result:** Die App bleibt responsiv und zeigt korrekte WhatsApp-Kontakte bei großer Datenmenge.

---

### TC-597: Add contact via phone number successfully

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-072
**Requirement:** WA-CON-002

**Description:** Verify a logged-in user can add a new contact using a valid phone number and it appears in the contact list

**Preconditions:**
- User is logged in
- User is in the Kontakte section
- No existing contact with the test phone number

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Select the option to add a contact via phone number | Phone number input form is displayed |
| 2 | 2. Enter a valid phone number and required fields (e.g., name) | Inputs are accepted without validation errors |
| 3 | 3. Confirm the add contact action | System processes the request without errors |

**Final Expected Result:** The new contact is saved and displayed in the contact list

---

### TC-598: Add contact via QR code successfully

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-072
**Requirement:** WA-CON-002

**Description:** Verify a logged-in user can add a new contact by scanning a valid QR code

**Preconditions:**
- User is logged in
- User is in the Kontakte section
- A valid QR code for a new contact is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Select the option to add a contact via QR code | QR code scanner interface is displayed |
| 2 | 2. Scan a valid QR code containing contact data | Contact data is populated or confirmed |
| 3 | 3. Confirm the add contact action | System processes the request without errors |

**Final Expected Result:** The new contact is saved and displayed in the contact list

---

### TC-599: Add contact via invite link successfully

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-072
**Requirement:** WA-CON-002

**Description:** Verify a logged-in user can add a new contact using a valid link

**Preconditions:**
- User is logged in
- User is in the Kontakte section
- A valid contact invite link is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Select the option to add a contact via link | Link input field is displayed |
| 2 | 2. Paste a valid contact link | Link is accepted without validation errors |
| 3 | 3. Confirm the add contact action | System processes the request without errors |

**Final Expected Result:** The new contact is saved and displayed in the contact list

---

### TC-600: Prevent add with missing required data

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-072
**Requirement:** WA-CON-002

**Description:** Verify system blocks adding a contact when required data is missing

**Preconditions:**
- User is logged in
- User is in the Kontakte section

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Select the option to add a contact via phone number | Phone number input form is displayed |
| 2 | 2. Leave the phone number field empty and enter other fields if any | Validation state remains pending until submission |
| 3 | 3. Submit the add contact form | System displays a clear validation error for missing phone number |

**Final Expected Result:** Contact is not saved and a clear error message is shown

---

### TC-601: Prevent add with invalid phone number format

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-072
**Requirement:** WA-CON-002

**Description:** Verify system blocks adding a contact with an invalid phone number

**Preconditions:**
- User is logged in
- User is in the Kontakte section

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Select the option to add a contact via phone number | Phone number input form is displayed |
| 2 | 2. Enter an invalid phone number format (e.g., letters or too short) | Field is marked invalid or validation message is prepared |
| 3 | 3. Submit the add contact form | System displays a clear validation error for invalid format |

**Final Expected Result:** Contact is not saved and a clear error message is shown

---

### TC-602: Prevent duplicate contact by phone number

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-072
**Requirement:** WA-CON-002

**Description:** Verify system blocks adding a contact that already exists

**Preconditions:**
- User is logged in
- User is in the Kontakte section
- A contact with the test phone number already exists

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Select the option to add a contact via phone number | Phone number input form is displayed |
| 2 | 2. Enter the phone number of an existing contact | Inputs are accepted without immediate errors |
| 3 | 3. Confirm the add contact action | System detects duplicate and blocks the action |

**Final Expected Result:** Duplicate is prevented and user is informed; contact list remains unchanged

---

### TC-603: Prevent duplicate contact by QR code

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-072
**Requirement:** WA-CON-002

**Description:** Verify system blocks adding a contact via QR code if it already exists

**Preconditions:**
- User is logged in
- User is in the Kontakte section
- A valid QR code for an existing contact is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Select the option to add a contact via QR code | QR code scanner interface is displayed |
| 2 | 2. Scan a QR code corresponding to an existing contact | System identifies the contact data |
| 3 | 3. Confirm the add contact action | System detects duplicate and blocks the action |

**Final Expected Result:** Duplicate is prevented and user is informed; contact list remains unchanged

---

### TC-604: Invalid QR code handling

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-072
**Requirement:** WA-CON-002

**Description:** Verify system shows an error for an invalid or unreadable QR code

**Preconditions:**
- User is logged in
- User is in the Kontakte section

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Select the option to add a contact via QR code | QR code scanner interface is displayed |
| 2 | 2. Scan an invalid or unreadable QR code | System fails to parse the QR code |
| 3 | 3. Attempt to confirm the add contact action if prompted | System displays a clear error message |

**Final Expected Result:** Contact is not saved and a clear error message is shown

---

### TC-605: Invalid invite link handling

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-072
**Requirement:** WA-CON-002

**Description:** Verify system blocks adding a contact with an invalid link

**Preconditions:**
- User is logged in
- User is in the Kontakte section

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Select the option to add a contact via link | Link input field is displayed |
| 2 | 2. Enter an invalid or malformed link | Field accepts input without immediate errors |
| 3 | 3. Submit the add contact form | System displays a clear validation error for invalid link |

**Final Expected Result:** Contact is not saved and a clear error message is shown

---

### TC-606: Boundary test for phone number length

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-072
**Requirement:** WA-CON-002

**Description:** Verify system enforces minimum and maximum phone number length constraints

**Preconditions:**
- User is logged in
- User is in the Kontakte section

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Select the option to add a contact via phone number | Phone number input form is displayed |
| 2 | 2. Enter a phone number at minimum allowed length and submit | If valid, submission is accepted |
| 3 | 3. Enter a phone number exceeding maximum allowed length and submit | System displays a clear validation error for length |

**Final Expected Result:** Valid boundary values are accepted and invalid length is rejected without saving

---

### TC-607: Mark contact as favorite adds to favorites list

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-073
**Requirement:** WA-CON-003

**Description:** Verify a logged-in user can mark an existing contact as favorite and it appears immediately in the favorites list with favorite indicator.

**Preconditions:**
- User is logged in
- At least one contact exists and is not marked as favorite
- Favorites list is accessible

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to the contacts list. | Contacts list is displayed with at least one non-favorite contact. |
| 2 | 2. Select a contact and click the favorite (star/heart) toggle. | The contact is marked as favorite (icon state changes). |
| 3 | 3. Open the favorites list/section. | The selected contact appears in the favorites list immediately. |

**Final Expected Result:** The contact is marked as favorite and appears in the favorites list without delay.

---

### TC-608: Unmark favorite removes from favorites list

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-073
**Requirement:** WA-CON-003

**Description:** Verify removing favorite status from a contact removes it from the favorites list and removes the indicator.

**Preconditions:**
- User is logged in
- At least one contact is already marked as favorite
- Favorites list is accessible

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the favorites list. | Favorites list shows at least one contact. |
| 2 | 2. Select a favorite contact and click the favorite toggle to remove. | Favorite indicator disappears for the contact. |
| 3 | 3. Refresh or reopen the favorites list. | The contact is no longer present in the favorites list. |

**Final Expected Result:** Contact is removed from favorites list and no longer marked as favorite.

---

### TC-609: Empty favorites list shows empty state

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-073
**Requirement:** WA-CON-003

**Description:** Verify opening favorites view when no favorites exist shows an empty state without errors.

**Preconditions:**
- User is logged in
- No contacts are marked as favorite

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to the favorites view. | Favorites view opens successfully. |
| 2 | 2. Observe the content of the favorites view. | An empty state message or hint is displayed and no errors are shown. |

**Final Expected Result:** Empty state is displayed correctly with no errors.

---

### TC-610: Favorite toggle is immediate and persistent after refresh

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-073
**Requirement:** WA-CON-003

**Description:** Verify favorite marking persists after page/app refresh and remains in favorites list.

**Preconditions:**
- User is logged in
- At least one contact exists and is not marked as favorite

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Mark a contact as favorite. | Contact is marked as favorite and appears in favorites list. |
| 2 | 2. Refresh the page or restart the app. | User remains logged in or can log in again if required. |
| 3 | 3. Open the favorites list. | The contact is still marked as favorite and listed. |

**Final Expected Result:** Favorite status persists across refresh/relaunch.

---

### TC-611: Prevent favorite for non-existent contact

**Type:** integration
**Priority:** medium
**Status:** manual
**User Story:** US-073
**Requirement:** WA-CON-003

**Description:** Verify system handles attempt to favorite a contact that no longer exists (negative test).

**Preconditions:**
- User is logged in
- A contact was deleted or becomes unavailable

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Attempt to mark the deleted/unavailable contact as favorite via UI or stale list. | Operation is rejected or fails gracefully with a user-friendly message. |
| 2 | 2. Open the favorites list. | The deleted contact is not present in the favorites list. |

**Final Expected Result:** System prevents favoriting unavailable contacts and avoids errors.

---

### TC-612: Unauthenticated user cannot mark favorites

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-073
**Requirement:** WA-CON-003

**Description:** Verify user must be authenticated to mark a contact as favorite (negative test).

**Preconditions:**
- User is logged out
- At least one contact exists

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to the contacts list. | Contacts list is visible or access is restricted based on app design. |
| 2 | 2. Attempt to mark a contact as favorite. | User is prompted to log in or action is disabled. |

**Final Expected Result:** Unauthenticated users cannot mark favorites and receive appropriate prompt.

---

### TC-613: Favorites list updates after unmarking from contact detail

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-073
**Requirement:** WA-CON-003

**Description:** Verify removing favorite from contact detail view updates favorites list immediately.

**Preconditions:**
- User is logged in
- A contact is marked as favorite

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the favorite contact's detail view. | Contact detail is displayed with favorite indicator active. |
| 2 | 2. Click to remove the favorite indicator. | Indicator toggles off in detail view. |
| 3 | 3. Return to favorites list. | The contact is no longer listed. |

**Final Expected Result:** Favorites list reflects changes made in contact detail view.

---

### TC-614: Boundary: Marking maximum number of favorites supported

**Type:** functional
**Priority:** low
**Status:** manual
**User Story:** US-073
**Requirement:** WA-CON-003

**Description:** Verify the system handles the upper boundary of favorites count according to configured limit (if any).

**Preconditions:**
- User is logged in
- System has a known maximum favorites limit or a large number of contacts available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Mark contacts as favorites up to the maximum allowed. | Each contact is successfully marked as favorite and listed. |
| 2 | 2. Attempt to mark one more contact beyond the limit. | System prevents the action or shows a clear message if a limit exists; otherwise it succeeds. |

**Final Expected Result:** System enforces limit or continues to function without errors when adding many favorites.

---

### TC-615: Performance: Favorites list loads quickly with many favorites

**Type:** performance
**Priority:** low
**Status:** manual
**User Story:** US-073
**Requirement:** WA-CON-003

**Description:** Verify favorites list performance with a large number of favorites.

**Preconditions:**
- User is logged in
- A large number of contacts are marked as favorites (e.g., 100+)

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the favorites list. | Favorites list loads within acceptable performance threshold. |
| 2 | 2. Scroll through the list. | Scrolling is smooth and no errors occur. |

**Final Expected Result:** Favorites list remains responsive and stable with many entries.

---

### TC-616: Create label with valid name and assign to contact

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-074
**Requirement:** WA-CON-004

**Description:** Verify a business user can create a valid label and assign it to a contact, and it is visible on the contact

**Preconditions:**
- Business user is logged in
- User is in contact area
- At least one contact exists

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the contact detail view for an existing contact | Contact detail view is displayed |
| 2 | 2. Open the label management/assignment UI | Label input/selection control is displayed |
| 3 | 3. Enter a new label name "VIP" and choose to create it | Label appears as created in the label list |
| 4 | 4. Assign the newly created label to the contact and save | Label is shown on the contact and assignment is saved |
| 5 | 5. Refresh the page and reopen the contact | Label "VIP" remains visible on the contact |

**Final Expected Result:** New label is saved and visible on the assigned contact after refresh

---

### TC-617: Prevent creation of duplicate label name

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-074
**Requirement:** WA-CON-004

**Description:** Verify a duplicate label name cannot be created and a clear error is shown

**Preconditions:**
- Business user is logged in
- User is in contact area
- A label named "VIP" already exists

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the label management UI | Label input/selection control is displayed |
| 2 | 2. Enter label name "VIP" and attempt to save | An error message is displayed indicating the label already exists |
| 3 | 3. Check the label list | No additional duplicate label named "VIP" is created |

**Final Expected Result:** Duplicate label creation is blocked with a clear error message

---

### TC-618: Edit existing label name and update all assigned contacts

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-074
**Requirement:** WA-CON-004

**Description:** Verify editing a label updates it across all contacts assigned to it

**Preconditions:**
- Business user is logged in
- User is in contact area
- Label "VIP" exists and is assigned to multiple contacts

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open label management UI and select label "VIP" | Label edit options are displayed |
| 2 | 2. Change label name to "Premium" and save | Success confirmation is shown and label list shows "Premium" |
| 3 | 3. Open a contact previously assigned "VIP" | Contact now shows label "Premium" |
| 4 | 4. Open another contact previously assigned "VIP" | Contact now shows label "Premium" |

**Final Expected Result:** Edited label name is saved and updated for all assigned contacts

---

### TC-619: Delete label assigned to contacts and auto-unassign

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-074
**Requirement:** WA-CON-004

**Description:** Verify deleting a label removes it and unassigns it from all contacts

**Preconditions:**
- Business user is logged in
- User is in contact area
- Label "Seasonal" exists and is assigned to at least one contact

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open label management UI and select label "Seasonal" | Label delete option is visible |
| 2 | 2. Click delete and confirm deletion | Deletion confirmation is accepted and label is removed from list |
| 3 | 3. Open a contact previously assigned "Seasonal" | Label "Seasonal" is no longer shown on the contact |

**Final Expected Result:** Label is deleted and unassigned from all contacts

---

### TC-620: Attempt to create label with empty name

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-074
**Requirement:** WA-CON-004

**Description:** Validate that empty label names are rejected

**Preconditions:**
- Business user is logged in
- User is in contact area

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open label creation UI | Label input field is displayed |
| 2 | 2. Leave the label name empty and attempt to save | Validation message is displayed indicating name is required |

**Final Expected Result:** Label is not created and a required-field error is shown

---

### TC-621: Create label with maximum allowed length

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-074
**Requirement:** WA-CON-004

**Description:** Verify labels at the maximum allowed length are accepted and saved

**Preconditions:**
- Business user is logged in
- User is in contact area
- Maximum label length requirement is known

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open label creation UI | Label input field is displayed |
| 2 | 2. Enter a label name with exactly the maximum allowed characters and save | Label is created successfully and appears in the list |

**Final Expected Result:** Label with maximum allowed length is saved successfully

---

### TC-622: Reject label name exceeding maximum length

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-074
**Requirement:** WA-CON-004

**Description:** Verify labels exceeding maximum allowed length are rejected

**Preconditions:**
- Business user is logged in
- User is in contact area
- Maximum label length requirement is known

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open label creation UI | Label input field is displayed |
| 2 | 2. Enter a label name that exceeds the maximum length and attempt to save | Validation error is displayed and label is not created |

**Final Expected Result:** Label name exceeding maximum length is rejected

---

### TC-623: Assign existing label to contact from list

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-074
**Requirement:** WA-CON-004

**Description:** Verify existing labels can be assigned to contacts without creation

**Preconditions:**
- Business user is logged in
- User is in contact area
- Label "VIP" exists
- At least one contact exists

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open a contact detail view | Contact detail view is displayed |
| 2 | 2. Open label assignment control and select existing label "VIP" | Label "VIP" is selected for the contact |
| 3 | 3. Save the contact changes | Label "VIP" appears on the contact and remains after refresh |

**Final Expected Result:** Existing label is assigned and visible on the contact

---

### TC-624: Cancel delete label action

**Type:** functional
**Priority:** low
**Status:** manual
**User Story:** US-074
**Requirement:** WA-CON-004

**Description:** Verify canceling the delete confirmation keeps the label and assignments intact

**Preconditions:**
- Business user is logged in
- User is in contact area
- Label "Seasonal" exists and is assigned to at least one contact

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open label management UI and select label "Seasonal" | Label delete option is visible |
| 2 | 2. Click delete and then cancel the confirmation dialog | Deletion is canceled and label remains in the list |
| 3 | 3. Open a contact previously assigned "Seasonal" | Label "Seasonal" remains visible on the contact |

**Final Expected Result:** Label and assignments remain unchanged after canceling delete

---

### TC-625: Mark unknown sender and move to unknown area

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-075
**Requirement:** WA-CON-005

**Description:** Verify that a message from an unverified/unknown sender is marked as unknown and moved to the unknown sender area.

**Preconditions:**
- System has a defined unknown sender area
- Sender ID is not in verified/known list

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Submit an incoming message with an unverified sender ID. | Message is accepted for processing. |
| 2 | 2. Process the incoming message in the system. | Sender is marked as unknown. |
| 3 | 3. Open the unknown sender area. | The message appears in the unknown sender area. |

**Final Expected Result:** Unknown sender message is marked and stored in the unknown sender area.

---

### TC-626: Known verified sender message stays in regular inbox

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-075
**Requirement:** WA-CON-005

**Description:** Verify that messages from known verified senders are processed normally.

**Preconditions:**
- Sender ID is in verified/known list
- Regular inbox is accessible

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Submit an incoming message with a verified sender ID. | Message is accepted for processing. |
| 2 | 2. Process the incoming message. | No unknown sender flag is applied. |
| 3 | 3. Open the regular inbox. | The message appears in the regular inbox. |

**Final Expected Result:** Verified sender message is stored in the regular inbox without special handling.

---

### TC-627: Repeated unknown sender messages are grouped within time window

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-075
**Requirement:** WA-CON-005

**Description:** Verify grouping of multiple messages from the same unknown sender within the defined time window.

**Preconditions:**
- A defined grouping time window exists (e.g., 10 minutes)
- Sender ID is not in verified/known list

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Submit the first message from an unknown sender. | Message is accepted for processing. |
| 2 | 2. Submit a second message from the same unknown sender within the defined time window. | Second message is accepted for processing. |
| 3 | 3. Open the unknown sender area and view grouped messages. | Messages from the same unknown sender are shown as a single grouped entry. |

**Final Expected Result:** Multiple unknown sender messages within the time window are grouped together.

---

### TC-628: Optional moderation notification on repeated unknown sender messages

**Type:** integration
**Priority:** medium
**Status:** manual
**User Story:** US-075
**Requirement:** WA-CON-005

**Description:** Verify optional moderation notification is triggered when repeated unknown sender messages occur.

**Preconditions:**
- Moderation notifications are enabled
- Notification channel is configured
- Sender ID is not in verified/known list

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Submit multiple messages from the same unknown sender within the defined time window. | Messages are accepted for processing. |
| 2 | 2. Process the messages and check notification system logs. | A moderation notification is triggered. |

**Final Expected Result:** Moderation receives a notification when repeated unknown sender messages are detected.

---

### TC-629: No grouping when messages are outside time window

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-075
**Requirement:** WA-CON-005

**Description:** Verify that messages from an unknown sender outside the time window are not grouped.

**Preconditions:**
- A defined grouping time window exists (e.g., 10 minutes)
- Sender ID is not in verified/known list

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Submit a message from an unknown sender. | Message is accepted for processing. |
| 2 | 2. Wait until the time window expires. | Time window has elapsed. |
| 3 | 3. Submit another message from the same unknown sender. | Second message is accepted for processing. |
| 4 | 4. Open the unknown sender area. | Messages appear as separate entries (not grouped). |

**Final Expected Result:** Unknown sender messages outside the time window are not grouped.

---

### TC-630: Message with missing metadata goes to quarantine

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-075
**Requirement:** WA-CON-005

**Description:** Verify that unclassifiable messages are quarantined and an error log is created.

**Preconditions:**
- Quarantine area is configured
- Monitoring/error logging is enabled

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Submit an incoming message missing required metadata for classification. | Message is accepted for processing. |
| 2 | 2. Process the incoming message. | Processing fails due to missing metadata. |
| 3 | 3. Open the quarantine area. | The message appears in quarantine. |
| 4 | 4. Check monitoring/error logs. | An error log entry is created for the failed classification. |

**Final Expected Result:** Unclassifiable message is quarantined and a monitoring log is created.

---

### TC-631: Verified sender not marked as unknown (negative test)

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-075
**Requirement:** WA-CON-005

**Description:** Ensure verified senders are never incorrectly marked as unknown.

**Preconditions:**
- Sender ID is in verified/known list

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Submit a message from a verified sender. | Message is accepted for processing. |
| 2 | 2. Process the message and inspect sender classification. | Sender is classified as known/verified. |
| 3 | 3. Search the unknown sender area. | The message is not present in the unknown sender area. |

**Final Expected Result:** Verified sender message is not marked or stored as unknown.

---

### TC-632: Unknown sender marked even with borderline metadata

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-075
**Requirement:** WA-CON-005

**Description:** Verify that a minimally valid message from an unknown sender is still classified as unknown and not quarantined.

**Preconditions:**
- Sender ID is not in verified/known list
- Message contains minimal required metadata

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Submit an incoming message with minimal valid metadata from an unknown sender. | Message is accepted for processing. |
| 2 | 2. Process the message. | Sender is marked as unknown without classification failure. |
| 3 | 3. Open the unknown sender area. | The message appears in the unknown sender area. |

**Final Expected Result:** Minimally valid unknown sender message is classified as unknown and not quarantined.

---

### TC-633: Boundary test for grouping threshold

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-075
**Requirement:** WA-CON-005

**Description:** Verify grouping behavior at the exact time window boundary.

**Preconditions:**
- A defined grouping time window exists (e.g., 10 minutes)
- Sender ID is not in verified/known list

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Submit a message from an unknown sender. | Message is accepted for processing. |
| 2 | 2. Submit a second message exactly at the time window boundary. | Second message is accepted for processing. |
| 3 | 3. Open the unknown sender area. | Grouping behavior matches specification for boundary time. |

**Final Expected Result:** Messages at the boundary follow the defined grouping rule.

---

### TC-634: Performance check for processing multiple unknown sender messages

**Type:** performance
**Priority:** low
**Status:** manual
**User Story:** US-075
**Requirement:** WA-CON-005

**Description:** Ensure the system processes a burst of unknown sender messages within acceptable time.

**Preconditions:**
- Performance thresholds are defined
- Sender IDs are not in verified/known list

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Send a burst of 100 messages from unknown sender(s) within the time window. | Messages are accepted for processing. |
| 2 | 2. Measure processing time and system responsiveness. | Processing time remains within defined thresholds. |
| 3 | 3. Open the unknown sender area. | Messages are grouped appropriately and visible. |

**Final Expected Result:** System handles burst of unknown sender messages within performance limits.

---

### TC-635: Search returns messages containing the search term

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-076
**Requirement:** WA-SRC-001

**Description:** Verify that full-text search returns all messages containing the entered term.

**Preconditions:**
- User is logged in
- Message history contains multiple messages, some including the term 'Projekt' in the text

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to the message search input field. | Search input field is visible and enabled. |
| 2 | 2. Enter the term 'Projekt' in the search input. | The term 'Projekt' appears in the search input. |
| 3 | 3. Start the search (e.g., click search button or press Enter). | Search is initiated. |

**Final Expected Result:** All messages containing the term 'Projekt' in their text are listed in the results.

---

### TC-636: Search returns empty list and no-results hint when term not found

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-076
**Requirement:** WA-SRC-001

**Description:** Verify the system shows an empty result list and a no-results hint when the term does not exist.

**Preconditions:**
- User is logged in
- Message history contains no messages with the term 'QZXY123'

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to the message search input field. | Search input field is visible and enabled. |
| 2 | 2. Enter the term 'QZXY123' in the search input. | The term 'QZXY123' appears in the search input. |
| 3 | 3. Start the search. | Search is initiated. |

**Final Expected Result:** An empty result list is displayed with a hint indicating no results were found.

---

### TC-637: Search without input prompts for a term and does not run search

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-076
**Requirement:** WA-SRC-001

**Description:** Verify that the system prompts for input and does not execute search when the field is empty.

**Preconditions:**
- User is logged in
- Search input field is empty

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Ensure the search input field is empty. | Search input field shows no text. |
| 2 | 2. Start the search (e.g., click search button or press Enter). | No search is executed. |

**Final Expected Result:** User is prompted to enter a search term and no search results are displayed.

---

### TC-638: Search is case-insensitive

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-076
**Requirement:** WA-SRC-001

**Description:** Verify that search finds messages regardless of letter casing.

**Preconditions:**
- User is logged in
- Message history includes a message with the text 'Projektplan final'

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Enter the term 'projektplan' in the search input. | The term 'projektplan' appears in the search input. |
| 2 | 2. Start the search. | Search is initiated. |

**Final Expected Result:** The message containing 'Projektplan final' is returned in the results.

---

### TC-639: Search with special characters

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-076
**Requirement:** WA-SRC-001

**Description:** Verify that search handles special characters and finds matching messages.

**Preconditions:**
- User is logged in
- Message history includes a message containing the text 'Budget: 1.000€'

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Enter the term '1.000€' in the search input. | The term '1.000€' appears in the search input. |
| 2 | 2. Start the search. | Search is initiated. |

**Final Expected Result:** The message containing 'Budget: 1.000€' is displayed in the results.

---

### TC-640: Search returns all matching messages (multiple matches)

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-076
**Requirement:** WA-SRC-001

**Description:** Verify that all messages containing the term are returned.

**Preconditions:**
- User is logged in
- Message history contains at least three messages with the term 'Meeting' in their text

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Enter the term 'Meeting' in the search input. | The term 'Meeting' appears in the search input. |
| 2 | 2. Start the search. | Search is initiated. |

**Final Expected Result:** All messages containing 'Meeting' are listed in the results.

---

### TC-641: Search with leading/trailing spaces

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-076
**Requirement:** WA-SRC-001

**Description:** Verify that leading/trailing spaces do not affect search results.

**Preconditions:**
- User is logged in
- Message history contains a message with the text 'Status update'

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Enter the term '  Status update  ' (with leading/trailing spaces) in the search input. | The term appears in the input including spaces. |
| 2 | 2. Start the search. | Search is initiated. |

**Final Expected Result:** The message containing 'Status update' is returned despite leading/trailing spaces.

---

### TC-642: Search with a very long term (boundary condition)

**Type:** functional
**Priority:** low
**Status:** manual
**User Story:** US-076
**Requirement:** WA-SRC-001

**Description:** Verify that the system handles long search terms gracefully.

**Preconditions:**
- User is logged in
- Message history exists

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Enter a very long string (e.g., 256 characters) in the search input. | The long term appears in the input without UI issues. |
| 2 | 2. Start the search. | Search is initiated without errors. |

**Final Expected Result:** System processes the search without crashing and returns appropriate results or a no-results message.

---

### TC-643: Search when user has no message history

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-076
**Requirement:** WA-SRC-001

**Description:** Verify behavior when no messages exist for the user.

**Preconditions:**
- User is logged in
- User has no messages in history

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Enter any search term (e.g., 'Test') in the search input. | The term 'Test' appears in the input. |
| 2 | 2. Start the search. | Search is initiated. |

**Final Expected Result:** An empty result list is displayed with a hint indicating no results were found.

---

### TC-644: Search performance for typical dataset

**Type:** performance
**Priority:** medium
**Status:** manual
**User Story:** US-076
**Requirement:** WA-SRC-001

**Description:** Verify that search returns results within acceptable time for a typical message history.

**Preconditions:**
- User is logged in
- Message history contains at least 1,000 messages including the term 'Update'

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Enter the term 'Update' in the search input. | The term 'Update' appears in the input. |
| 2 | 2. Start the search and measure response time. | Search is initiated and results begin to load. |

**Final Expected Result:** Search results are displayed within the defined performance threshold (e.g., <= 2 seconds).

---

### TC-645: Filter by single media type shows only that type

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-077
**Requirement:** WA-SRC-002

**Description:** Verify that selecting one media type filter limits results to that type

**Preconditions:**
- User is logged in
- User is on the media search page
- Media library contains multiple media types (e.g., Video, Audio, Document)

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | Open the media type filter dropdown/panel | Available media type options are displayed |
| 2 | Select the 'Video' media type filter | The filter is marked as active |
| 3 | Apply the filter | The results list refreshes |

**Final Expected Result:** Only media items of type 'Video' are displayed

---

### TC-646: Single media type filter with no results shows empty state

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-077
**Requirement:** WA-SRC-002

**Description:** Verify empty result list and hint message when no media of the selected type exists

**Preconditions:**
- User is logged in
- User is on the media search page
- There are no items of type 'Podcast' in the library

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | Select the 'Podcast' media type filter | The filter is marked as active |
| 2 | Apply the filter | The results list refreshes and displays no items |

**Final Expected Result:** An empty result list with a user-friendly hint is displayed

---

### TC-647: Multiple media type filters show union of selected types

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-077
**Requirement:** WA-SRC-002

**Description:** Verify results include media items that match any of the selected types

**Preconditions:**
- User is logged in
- User is on the media search page
- Media library contains items for types Video, Audio, and Document

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | Select 'Video' and 'Audio' media type filters | Both filters are marked as active |
| 2 | Apply the filters | The results list refreshes |

**Final Expected Result:** Only media items of type 'Video' or 'Audio' are displayed; no 'Document' items appear

---

### TC-648: Deselecting a media type updates results accordingly

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-077
**Requirement:** WA-SRC-002

**Description:** Verify results update when one of multiple selected filters is removed

**Preconditions:**
- User is logged in
- User is on the media search page
- Media library contains items for types Video and Audio

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | Select 'Video' and 'Audio' filters and apply | Results show both Video and Audio items |
| 2 | Deselect the 'Audio' filter | Only 'Video' filter remains active |
| 3 | Apply the filter change | The results list refreshes |

**Final Expected Result:** Only media items of type 'Video' are displayed

---

### TC-649: No filter selected shows all media types

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-077
**Requirement:** WA-SRC-002

**Description:** Verify that clearing all media type filters shows unfiltered results

**Preconditions:**
- User is logged in
- User is on the media search page
- Media library contains multiple media types

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | Ensure no media type filters are selected | No filters are marked as active |
| 2 | Apply the filter state or refresh results | The results list refreshes |

**Final Expected Result:** All media items across all types are displayed

---

### TC-650: Boundary: Only one media type available

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-077
**Requirement:** WA-SRC-002

**Description:** Verify filtering behavior when only one media type exists in the library

**Preconditions:**
- User is logged in
- User is on the media search page
- Only 'Document' media type exists in the library

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | Open media type filter options | Only 'Document' is available |
| 2 | Select 'Document' and apply the filter | The results list refreshes |

**Final Expected Result:** All displayed items are of type 'Document' and no other types are shown

---

### TC-651: Filter persistence when navigating back to search results

**Type:** e2e
**Priority:** medium
**Status:** manual
**User Story:** US-077
**Requirement:** WA-SRC-002

**Description:** Verify selected media type filters remain applied when returning to results

**Preconditions:**
- User is logged in
- User is on the media search page
- Media library contains multiple media types

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | Select 'Video' filter and apply | Results show only Video items |
| 2 | Open a media item detail page from the results | Media detail page opens |
| 3 | Navigate back to the search results | Search results page loads |

**Final Expected Result:** The 'Video' filter remains active and results still show only Video items

---

### TC-652: Negative: Selecting invalid media type does not crash and shows no results

**Type:** integration
**Priority:** low
**Status:** manual
**User Story:** US-077
**Requirement:** WA-SRC-002

**Description:** Verify robust handling when an unsupported media type filter is attempted (e.g., via deep link or API)

**Preconditions:**
- User is logged in
- User is on the media search page
- Media library contains multiple valid media types

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | Manually set the media type filter parameter to an unsupported value (e.g., 'UnknownType') and load results | The system loads the search page without errors |

**Final Expected Result:** No results are shown and a user-friendly hint is displayed; the system remains stable

---

### TC-653: Search returns matching chats and contacts by full name

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-078
**Requirement:** WA-SRC-003

**Description:** Verify that entering a full name returns matching chats and contacts in results list.

**Preconditions:**
- User is logged in
- User is on Chat-Übersicht
- Chats/contacts exist with names 'Anna Müller' and 'Anna Schmidt'

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Click on the search field in the Chat-Übersicht | Search field is focused and ready for input |
| 2 | 2. Enter the full name 'Anna Müller' | Input is accepted and search is triggered |
| 3 | 3. Observe the results list | Chats and contacts matching 'Anna Müller' are displayed |

**Final Expected Result:** Matching chats/contacts for the full name are shown in the results list.

---

### TC-654: Search returns matching results by partial name

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-078
**Requirement:** WA-SRC-003

**Description:** Verify that entering a partial name returns relevant chats and contacts.

**Preconditions:**
- User is logged in
- User is on Chat-Übersicht
- Chats/contacts exist with names 'Michael Weber', 'Michaela Kraus'

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Focus the search field | Search field is focused |
| 2 | 2. Enter partial text 'Mich' | Input is accepted and search is triggered |
| 3 | 3. Review results list | Results include 'Michael Weber' and 'Michaela Kraus' |

**Final Expected Result:** Partial name search returns all relevant matches.

---

### TC-655: Search with no matches shows 'no results' message

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-078
**Requirement:** WA-SRC-003

**Description:** Verify that a clear message is displayed when no matches are found.

**Preconditions:**
- User is logged in
- User is on Chat-Übersicht
- No chats/contacts exist with name 'Zyxq'

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Focus the search field | Search field is focused |
| 2 | 2. Enter 'Zyxq' | Input is accepted and search is triggered |
| 3 | 3. Observe results area | A clear 'no results found' message is displayed |

**Final Expected Result:** User is informed clearly that no results were found.

---

### TC-656: Search handles special characters without error

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-078
**Requirement:** WA-SRC-003

**Description:** Verify system handles special characters and returns valid results or a hint message.

**Preconditions:**
- User is logged in
- User is on Chat-Übersicht
- Contact exists with name 'Jörg@Work'

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Focus the search field | Search field is focused |
| 2 | 2. Enter special characters '@' | Input is accepted without error |
| 3 | 3. Observe results list | Valid matches are shown or a hint message appears if none |

**Final Expected Result:** System handles special characters gracefully and displays valid results or a hint.

---

### TC-657: Very short search query is processed without error

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-078
**Requirement:** WA-SRC-003

**Description:** Verify that a very short query is handled and returns valid results or a hint message.

**Preconditions:**
- User is logged in
- User is on Chat-Übersicht
- Contacts exist with names 'Al', 'Alex'

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Focus the search field | Search field is focused |
| 2 | 2. Enter 'A' | Input is accepted and search is triggered |
| 3 | 3. Observe results area | Valid matches are shown or a hint about minimum length is displayed |

**Final Expected Result:** Very short query is processed without errors and provides valid feedback.

---

### TC-658: Search is case-insensitive

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-078
**Requirement:** WA-SRC-003

**Description:** Verify search results are case-insensitive for names.

**Preconditions:**
- User is logged in
- User is on Chat-Übersicht
- Contact exists with name 'Laura König'

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Focus the search field | Search field is focused |
| 2 | 2. Enter 'laura könig' in lowercase | Input is accepted and search is triggered |
| 3 | 3. Observe results list | Contact 'Laura König' appears in results |

**Final Expected Result:** Search returns results regardless of input case.

---

### TC-659: Search with umlauts and special letters

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-078
**Requirement:** WA-SRC-003

**Description:** Verify search supports localized characters (e.g., ä, ö, ü, ß).

**Preconditions:**
- User is logged in
- User is on Chat-Übersicht
- Contact exists with name 'Björn Weiß'

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Focus the search field | Search field is focused |
| 2 | 2. Enter 'Björn' with umlaut | Input is accepted and search is triggered |
| 3 | 3. Observe results list | Contact 'Björn Weiß' appears in results |

**Final Expected Result:** Search correctly matches names containing localized characters.

---

### TC-660: Search handles leading and trailing spaces

**Type:** functional
**Priority:** low
**Status:** manual
**User Story:** US-078
**Requirement:** WA-SRC-003

**Description:** Verify that whitespace is ignored and results are still found.

**Preconditions:**
- User is logged in
- User is on Chat-Übersicht
- Contact exists with name 'Peter Lang'

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Focus the search field | Search field is focused |
| 2 | 2. Enter '  Peter Lang  ' with spaces | Input is accepted and search is triggered |
| 3 | 3. Observe results list | Contact 'Peter Lang' appears in results |

**Final Expected Result:** Search ignores extra spaces and returns correct matches.

---

### TC-661: Clearing search restores default chat list

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-078
**Requirement:** WA-SRC-003

**Description:** Verify clearing the search input resets the list to default chat overview.

**Preconditions:**
- User is logged in
- User is on Chat-Übersicht
- Search has been performed with results

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Click in the search field with an existing query | Search field is focused with current query |
| 2 | 2. Clear the input (e.g., backspace or clear icon) | Search field becomes empty |
| 3 | 3. Observe the list view | Default chat overview list is displayed |

**Final Expected Result:** Clearing the search resets to full chat overview.

---

### TC-662: Search performance for large contact list

**Type:** performance
**Priority:** low
**Status:** manual
**User Story:** US-078
**Requirement:** WA-SRC-003

**Description:** Verify search responds within acceptable time for a large dataset.

**Preconditions:**
- User is logged in
- User is on Chat-Übersicht
- User has at least 1000 chats/contacts

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Focus the search field | Search field is focused |
| 2 | 2. Enter a common partial name 'An' | Input is accepted and search is triggered |
| 3 | 3. Measure time until results are displayed | Results appear within defined performance threshold (e.g., < 1s) |

**Final Expected Result:** Search results display within acceptable time under load.

---

### TC-663: Jump to valid date with messages

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-079
**Requirement:** WA-SRC-004

**Description:** Verify system jumps to first message of selected valid date and displays from that point

**Preconditions:**
- User is logged in
- Chat contains messages on multiple dates including 2024-05-10

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the chat conversation with multi-day history | Chat history is displayed with date separators |
| 2 | 2. Open the date selection control | Date picker or input field is visible and active |
| 3 | 3. Select the valid date 2024-05-10 | System processes the selection and loads messages for 2024-05-10 |

**Final Expected Result:** Chat scrolls to the first message on 2024-05-10 and shows the conversation from that point onward

---

### TC-664: No messages on selected date shows helpful message and next available day

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-079
**Requirement:** WA-SRC-004

**Description:** Verify system handles dates with no messages by showing guidance and offering next available date

**Preconditions:**
- User is logged in
- Chat contains messages on 2024-05-10 and 2024-05-12
- No messages on 2024-05-11

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the chat conversation with multi-day history | Chat history is displayed with date separators |
| 2 | 2. Open the date selection control | Date picker or input field is visible and active |
| 3 | 3. Select the date 2024-05-11 | System detects no messages for the selected date |

**Final Expected Result:** A helpful message is displayed and the next available day (2024-05-12) is offered for navigation

---

### TC-665: Invalid date input prevents search

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-079
**Requirement:** WA-SRC-004

**Description:** Verify invalid date input is rejected and user is prompted to correct it

**Preconditions:**
- User is logged in
- Chat conversation is open
- Date input field is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Focus the date input field | Cursor appears in the date input field |
| 2 | 2. Enter an invalid date (e.g., 2024-02-30) and attempt to search | System flags the input as invalid and blocks the search action |

**Final Expected Result:** The date input is marked invalid and a prompt requests correction

---

### TC-666: Boundary: earliest date in chat

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-079
**Requirement:** WA-SRC-004

**Description:** Verify selection of the earliest available date jumps to its first message

**Preconditions:**
- User is logged in
- Chat contains messages starting from 2024-01-01

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the chat conversation | Chat history is displayed |
| 2 | 2. Open the date selection control | Date picker or input field is visible |
| 3 | 3. Select the earliest date 2024-01-01 | System loads messages for 2024-01-01 |

**Final Expected Result:** Chat scrolls to the first message on 2024-01-01 and displays from that point

---

### TC-667: Boundary: latest date in chat

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-079
**Requirement:** WA-SRC-004

**Description:** Verify selection of the latest available date jumps to its first message

**Preconditions:**
- User is logged in
- Chat contains messages up to 2024-06-30

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the chat conversation | Chat history is displayed |
| 2 | 2. Open the date selection control | Date picker or input field is visible |
| 3 | 3. Select the latest date 2024-06-30 | System loads messages for 2024-06-30 |

**Final Expected Result:** Chat scrolls to the first message on 2024-06-30 and displays from that point

---

### TC-668: Invalid format input is rejected

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-079
**Requirement:** WA-SRC-004

**Description:** Verify incorrect date format is rejected and user is prompted to correct

**Preconditions:**
- User is logged in
- Chat conversation is open
- Date input field expects YYYY-MM-DD

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Focus the date input field | Cursor appears in the date input field |
| 2 | 2. Enter date in invalid format (e.g., 10/05/2024) and attempt to search | System flags the input as invalid and blocks the search action |

**Final Expected Result:** The input is marked invalid and a correction message is shown

---

### TC-669: Helpful message offers next available day navigation

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-079
**Requirement:** WA-SRC-004

**Description:** Verify user can navigate to the suggested next available day from the helpful message

**Preconditions:**
- User is logged in
- Chat contains messages on 2024-05-10 and 2024-05-12
- No messages on 2024-05-11

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Select the date 2024-05-11 | Helpful message appears offering next available day 2024-05-12 |
| 2 | 2. Click the offered next available day link/button | System navigates to messages for 2024-05-12 |

**Final Expected Result:** Chat scrolls to the first message on 2024-05-12 and displays from that point

---

### TC-670: Leap day valid input (leap year)

**Type:** functional
**Priority:** low
**Status:** manual
**User Story:** US-079
**Requirement:** WA-SRC-004

**Description:** Verify leap day is accepted in leap years and navigation works

**Preconditions:**
- User is logged in
- Chat contains messages on 2024-02-29

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the date selection control | Date picker or input field is visible |
| 2 | 2. Select or enter 2024-02-29 and initiate search | System accepts the date and loads messages |

**Final Expected Result:** Chat scrolls to the first message on 2024-02-29 and displays from that point

---

### TC-671: Set visibility to 'Niemand' hides online status from other users

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-080
**Requirement:** WA-SET-001

**Description:** Verify that setting online status visibility to 'Niemand' prevents other users from seeing the online status

**Preconditions:**
- User A is logged in
- User B exists and is logged in on a separate session
- User A is on privacy settings page

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. User A selects visibility option 'Niemand' | Option 'Niemand' is selected |
| 2 | 2. User A clicks 'Save' | Save action is accepted and confirmation is shown |
| 3 | 3. User B opens User A's profile or presence list | User A's online status is not displayed |

**Final Expected Result:** Other users cannot see User A's online status after setting visibility to 'Niemand'

---

### TC-672: Set visibility to 'Alle' shows online status to other users

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-080
**Requirement:** WA-SET-001

**Description:** Verify that setting online status visibility to 'Alle' allows other users to see the online status

**Preconditions:**
- User A is logged in
- User B exists and is logged in on a separate session
- User A is on privacy settings page

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. User A selects visibility option 'Alle' | Option 'Alle' is selected |
| 2 | 2. User A clicks 'Save' | Save action is accepted and confirmation is shown |
| 3 | 3. User B opens User A's profile or presence list | User A's online status is displayed |

**Final Expected Result:** Other users can see User A's online status after setting visibility to 'Alle'

---

### TC-673: Change visibility takes effect immediately during active session

**Type:** integration
**Priority:** high
**Status:** manual
**User Story:** US-080
**Requirement:** WA-SET-001

**Description:** Verify that visibility changes apply immediately without restart

**Preconditions:**
- User A is logged in and currently online
- User B exists and is viewing User A's profile or presence list
- User A is on privacy settings page

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. User A switches visibility from 'Alle' to 'Niemand' | Option changes to 'Niemand' |
| 2 | 2. User A clicks 'Save' | Save action is accepted and confirmation is shown |
| 3 | 3. User B refreshes the presence list or keeps it open | User A's online status disappears immediately without User A restarting the app/session |

**Final Expected Result:** Visibility change is applied immediately during the active session

---

### TC-674: Server error on save shows error and retains previous setting

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-080
**Requirement:** WA-SET-001

**Description:** Verify behavior when a temporary server error occurs while saving visibility settings

**Preconditions:**
- User A is logged in
- User A is on privacy settings page
- Previous visibility setting is 'Alle'
- Server is configured to return a temporary error on save

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. User A selects visibility option 'Niemand' | Option 'Niemand' is selected |
| 2 | 2. User A clicks 'Save' | Error message is displayed indicating save failed |
| 3 | 3. User A reloads the privacy settings page | Visibility setting remains 'Alle' |

**Final Expected Result:** Error is shown and previous visibility setting is preserved after save failure

---

### TC-675: Cancel or navigate away does not apply changes without saving

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-080
**Requirement:** WA-SET-001

**Description:** Verify unsaved changes are not applied

**Preconditions:**
- User A is logged in
- User A is on privacy settings page
- Current visibility setting is 'Alle'

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. User A selects visibility option 'Niemand' | Option 'Niemand' is selected |
| 2 | 2. User A navigates away without saving | No confirmation of save is shown |
| 3 | 3. User A returns to privacy settings page | Visibility setting remains 'Alle' |

**Final Expected Result:** Changes are not applied unless saved

---

### TC-676: Persisted visibility setting after logout/login

**Type:** e2e
**Priority:** medium
**Status:** manual
**User Story:** US-080
**Requirement:** WA-SET-001

**Description:** Verify visibility setting persists across sessions

**Preconditions:**
- User A is logged in
- User A is on privacy settings page

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. User A sets visibility to 'Niemand' and clicks 'Save' | Save confirmation is shown |
| 2 | 2. User A logs out | User A is logged out |
| 3 | 3. User A logs back in and opens privacy settings page | Visibility setting is still 'Niemand' |

**Final Expected Result:** Visibility setting persists across logout/login

---

### TC-677: Boundary condition: rapid toggle and save applies last selected option

**Type:** functional
**Priority:** low
**Status:** manual
**User Story:** US-080
**Requirement:** WA-SET-001

**Description:** Verify that rapid toggling and saving applies the final selection only

**Preconditions:**
- User A is logged in
- User A is on privacy settings page
- User B exists and is logged in on a separate session

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. User A quickly toggles between 'Alle' and 'Niemand' multiple times | The UI reflects the latest selected option |
| 2 | 2. User A clicks 'Save' when 'Niemand' is selected | Save confirmation is shown |
| 3 | 3. User B checks User A's online status | User A's online status is not displayed |

**Final Expected Result:** The final selected visibility option at save time is applied

---

### TC-678: Unauthorized access blocked: privacy settings not accessible when logged out

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-080
**Requirement:** WA-SET-001

**Description:** Verify that logged-out users cannot access privacy settings

**Preconditions:**
- User is logged out

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. User attempts to navigate directly to privacy settings URL | User is redirected to login or shown access denied |

**Final Expected Result:** Privacy settings are protected for authenticated users only

---

### TC-679: Display read receipt when enabled and recipient reads message

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-081
**Requirement:** WA-SET-002

**Description:** Verify that a read receipt is shown to the sender when receipts are enabled and the recipient reads the message

**Preconditions:**
- Sender and recipient accounts exist
- Sender is logged in
- Recipient is logged in
- Read receipts are enabled in sender settings
- Sender and recipient can message each other

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Sender composes and sends a message to the recipient | Message is sent and appears in the sender's conversation view |
| 2 | 2. Recipient opens the conversation containing the new message | Message is displayed as read in recipient view |
| 3 | 3. Sender views the conversation after recipient opens it | A read receipt indicator is shown for the message |

**Final Expected Result:** Sender sees a read receipt for the message after the recipient reads it

---

### TC-680: No read receipt when disabled and recipient reads message

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-081
**Requirement:** WA-SET-002

**Description:** Verify that no read receipt is displayed when the sender disables receipts

**Preconditions:**
- Sender and recipient accounts exist
- Sender is logged in
- Recipient is logged in
- Read receipts are disabled in sender settings
- Sender and recipient can message each other

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Sender composes and sends a message to the recipient | Message is sent and appears in the sender's conversation view |
| 2 | 2. Recipient opens the conversation containing the new message | Message is displayed as read in recipient view |
| 3 | 3. Sender views the conversation after recipient opens it | No read receipt indicator is shown for the message |

**Final Expected Result:** Sender does not see a read receipt for the message

---

### TC-681: Updated read receipt setting applies to future messages only

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-081
**Requirement:** WA-SET-002

**Description:** Verify that changing the read receipt setting affects only new messages sent after saving

**Preconditions:**
- Sender and recipient accounts exist
- Sender is logged in
- Recipient is logged in
- Read receipts are enabled in sender settings
- Sender and recipient can message each other

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Sender sends Message A to recipient | Message A is sent and appears in the sender's conversation view |
| 2 | 2. Sender disables read receipts and saves settings | Settings are saved and read receipts are shown as disabled |
| 3 | 3. Sender sends Message B to recipient | Message B is sent and appears in the sender's conversation view |
| 4 | 4. Recipient opens the conversation containing Message A and Message B | Messages A and B are displayed as read in recipient view |
| 5 | 5. Sender checks read receipts for Message A and Message B | Read receipt is shown for Message A and not shown for Message B |

**Final Expected Result:** Only messages sent after the setting change follow the new read receipt behavior

---

### TC-682: Enable read receipts and verify applies to new messages

**Type:** e2e
**Priority:** medium
**Status:** manual
**User Story:** US-081
**Requirement:** WA-SET-002

**Description:** Verify enabling read receipts affects only messages sent after saving

**Preconditions:**
- Sender and recipient accounts exist
- Sender is logged in
- Recipient is logged in
- Read receipts are disabled in sender settings
- Sender and recipient can message each other

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Sender sends Message A to recipient | Message A is sent and appears in the sender's conversation view |
| 2 | 2. Sender enables read receipts and saves settings | Settings are saved and read receipts are shown as enabled |
| 3 | 3. Sender sends Message B to recipient | Message B is sent and appears in the sender's conversation view |
| 4 | 4. Recipient opens the conversation containing Message A and Message B | Messages A and B are displayed as read in recipient view |
| 5 | 5. Sender checks read receipts for Message A and Message B | No read receipt is shown for Message A and a read receipt is shown for Message B |

**Final Expected Result:** Only messages sent after enabling receipts display read receipts

---

### TC-683: Read receipt not shown before recipient reads message

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-081
**Requirement:** WA-SET-002

**Description:** Verify that read receipt is not displayed until the recipient actually reads the message

**Preconditions:**
- Sender and recipient accounts exist
- Sender is logged in
- Recipient is logged in
- Read receipts are enabled in sender settings
- Sender and recipient can message each other

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Sender sends a message to recipient | Message is sent and appears in sender's conversation view |
| 2 | 2. Recipient does not open the conversation | Message remains unread in recipient view |
| 3 | 3. Sender checks the message status | No read receipt indicator is shown for the message |

**Final Expected Result:** Read receipt appears only after the recipient reads the message

---

### TC-684: Persist read receipt setting across sessions

**Type:** integration
**Priority:** medium
**Status:** manual
**User Story:** US-081
**Requirement:** WA-SET-002

**Description:** Verify that the saved read receipt configuration persists after logout and login

**Preconditions:**
- Sender account exists and is logged in
- Read receipts are enabled in sender settings

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Sender disables read receipts and saves settings | Settings are saved and read receipts are shown as disabled |
| 2 | 2. Sender logs out | Sender is logged out |
| 3 | 3. Sender logs back in and opens settings | Read receipts setting remains disabled |

**Final Expected Result:** Read receipt configuration persists across sessions

---

### TC-685: Concurrent messages with mixed settings change

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-081
**Requirement:** WA-SET-002

**Description:** Boundary case to verify read receipts are correctly applied around a settings change with rapid sends

**Preconditions:**
- Sender and recipient accounts exist
- Sender is logged in
- Recipient is logged in
- Read receipts are enabled in sender settings
- Sender and recipient can message each other

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Sender sends Message A | Message A is sent |
| 2 | 2. Sender disables read receipts and saves settings immediately after sending Message A | Settings are saved and read receipts are disabled |
| 3 | 3. Sender sends Message B immediately after the settings change | Message B is sent |
| 4 | 4. Recipient reads both messages | Both messages are marked as read in recipient view |
| 5 | 5. Sender checks read receipts for Message A and Message B | Read receipt shown for Message A and not shown for Message B |

**Final Expected Result:** Read receipt behavior aligns with setting at the time each message was sent

---

### TC-686: Save valid visibility option applies immediately

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-082
**Requirement:** WA-SET-003

**Description:** Verify that selecting a valid visibility option and saving applies and confirms immediately

**Preconditions:**
- User is logged in
- User is on profile visibility settings page

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Select visibility option 'Public' from the available options | The 'Public' option is selected |
| 2 | 2. Click the 'Save' button | A success confirmation is displayed |
| 3 | 3. Navigate to the profile page | Profile image visibility reflects 'Public' immediately |

**Final Expected Result:** Selected valid visibility is saved, applied immediately, and confirmed to the user

---

### TC-687: Reopen settings shows stored visibility option

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-082
**Requirement:** WA-SET-003

**Description:** Verify that reopening visibility settings without changes shows the currently saved option

**Preconditions:**
- User is logged in
- A visibility option has been previously saved

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open profile visibility settings | Visibility settings page loads |
| 2 | 2. Do not change any option | Current stored visibility remains selected |
| 3 | 3. Close and reopen the visibility settings | The same stored visibility option is still selected |

**Final Expected Result:** The stored visibility option is correctly displayed when reopening settings without changes

---

### TC-688: Reject invalid visibility option on save

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-082
**Requirement:** WA-SET-003

**Description:** Verify that saving an invalid visibility option is rejected with an error message

**Preconditions:**
- User is logged in
- User is on profile visibility settings page

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Manipulate the request to include an invalid visibility value (e.g., 'Invisible123') | The invalid value is set in the save request |
| 2 | 2. Submit the save request | Save is rejected |
| 3 | 3. Observe the UI response | A clear, user-friendly error message is displayed |

**Final Expected Result:** Invalid visibility option is not saved and an understandable error message is shown

---

### TC-689: No change made does not alter stored visibility

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-082
**Requirement:** WA-SET-003

**Description:** Verify that saving without changing the selection retains the current visibility setting

**Preconditions:**
- User is logged in
- Visibility option 'Friends' is currently saved

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open visibility settings | Settings page shows 'Friends' selected |
| 2 | 2. Click 'Save' without changing selection | Success confirmation is displayed |
| 3 | 3. Reopen settings | 'Friends' remains selected |

**Final Expected Result:** Saving without changes keeps the existing visibility setting unchanged

---

### TC-690: Boundary: visibility option list contains only allowed values

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-082
**Requirement:** WA-SET-003

**Description:** Verify that only valid visibility options are selectable in the UI

**Preconditions:**
- User is logged in
- User is on profile visibility settings page

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the visibility dropdown or selection list | List of options is displayed |
| 2 | 2. Review all listed options | Only allowed options (e.g., Public, Friends, Private) are present |

**Final Expected Result:** UI restricts selection to valid visibility options only

---

### TC-691: Persistence across session

**Type:** integration
**Priority:** medium
**Status:** manual
**User Story:** US-082
**Requirement:** WA-SET-003

**Description:** Verify that saved visibility persists after logout and login

**Preconditions:**
- User is logged in
- User is on profile visibility settings page

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Select visibility option 'Private' and save | Success confirmation is displayed |
| 2 | 2. Log out | User is logged out successfully |
| 3 | 3. Log in again and open visibility settings | 'Private' is still selected |

**Final Expected Result:** Saved visibility setting persists across sessions

---

### TC-692: Set Info/Status text visibility to visible and save

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-083
**Requirement:** WA-SET-004

**Description:** Verify that setting visibility to 'sichtbar' displays the text for the target audience after saving.

**Preconditions:**
- Shop-Admin is logged in
- Shop-Admin has access to Info/Status text settings
- An Info/Status text exists and has a defined target audience

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | Navigate to Einstellungen fuer Info/Status-Texte | Info/Status text settings page is displayed |
| 2 | Select an existing Info/Status text | Text details and visibility options are shown |
| 3 | Set visibility to 'sichtbar' | Visibility option is updated to 'sichtbar' |
| 4 | Click 'Speichern' | Success message is displayed and changes are saved |
| 5 | Open the relevant UI as an end user in the target audience | The Info/Status text is displayed |

**Final Expected Result:** Text is shown to the target audience after visibility is set to 'sichtbar' and saved.

---

### TC-693: Set Info/Status text visibility to invisible and verify not shown

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-083
**Requirement:** WA-SET-004

**Description:** Verify that setting visibility to 'unsichtbar' hides the text from end users.

**Preconditions:**
- Shop-Admin is logged in
- Shop-Admin has access to Info/Status text settings
- An Info/Status text exists and is currently visible

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | Navigate to Einstellungen fuer Info/Status-Texte | Info/Status text settings page is displayed |
| 2 | Select the visible Info/Status text | Text details and visibility options are shown |
| 3 | Set visibility to 'unsichtbar' | Visibility option is updated to 'unsichtbar' |
| 4 | Click 'Speichern' | Success message is displayed and changes are saved |
| 5 | Open the relevant UI as an end user in the target audience | The Info/Status text is not displayed |

**Final Expected Result:** Text is hidden from end users when visibility is set to 'unsichtbar'.

---

### TC-694: Attempt to save invalid visibility option

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-083
**Requirement:** WA-SET-004

**Description:** Validate error handling when an invalid visibility option is provided.

**Preconditions:**
- Shop-Admin is logged in
- Shop-Admin has access to Info/Status text settings

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | Navigate to Einstellungen fuer Info/Status-Texte | Info/Status text settings page is displayed |
| 2 | Select an Info/Status text | Text details and visibility options are shown |
| 3 | Input an invalid visibility value (e.g., via API or UI manipulation) | Invalid value is present in the visibility field |
| 4 | Click 'Speichern' | An error message is displayed and changes are not saved |

**Final Expected Result:** System rejects invalid visibility option and preserves the previous configuration.

---

### TC-695: Boundary: visibility unchanged and save

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-083
**Requirement:** WA-SET-004

**Description:** Ensure saving without changing visibility does not alter behavior or cause errors.

**Preconditions:**
- Shop-Admin is logged in
- An Info/Status text exists with visibility set to 'sichtbar'

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | Navigate to Einstellungen fuer Info/Status-Texte | Info/Status text settings page is displayed |
| 2 | Select the Info/Status text with visibility 'sichtbar' | Visibility option shows 'sichtbar' |
| 3 | Click 'Speichern' without changing visibility | Success message is displayed and no changes occur |
| 4 | Open the relevant UI as an end user in the target audience | The Info/Status text is still displayed |

**Final Expected Result:** Saving with no changes keeps visibility intact and does not produce errors.

---

### TC-696: Verify visibility applies only to target audience

**Type:** e2e
**Priority:** medium
**Status:** manual
**User Story:** US-083
**Requirement:** WA-SET-004

**Description:** Ensure that visible text is shown only to the configured target audience.

**Preconditions:**
- Shop-Admin is logged in
- An Info/Status text exists with a defined target audience
- Visibility is set to 'sichtbar'

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | Open the relevant UI as an end user in the target audience | The Info/Status text is displayed |
| 2 | Open the relevant UI as an end user not in the target audience | The Info/Status text is not displayed |

**Final Expected Result:** Visibility respects the configured target audience.

---

### TC-697: Integration: Persist visibility setting across sessions

**Type:** integration
**Priority:** medium
**Status:** manual
**User Story:** US-083
**Requirement:** WA-SET-004

**Description:** Verify visibility setting is persisted and reflected after admin logout/login.

**Preconditions:**
- Shop-Admin is logged in
- An Info/Status text exists

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | Set visibility to 'sichtbar' and save | Success message is displayed and changes are saved |
| 2 | Log out and log back in as Shop-Admin | Admin is successfully logged in |
| 3 | Navigate to Einstellungen fuer Info/Status-Texte and open the same text | Visibility is still set to 'sichtbar' |

**Final Expected Result:** Visibility settings persist across sessions.

---

### TC-698: Admins-only setting restricts invitations to admins

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-084
**Requirement:** WA-SET-005

**Description:** Verify that setting invitation permissions to 'Nur Administratoren' limits group invitations to admins only.

**Preconditions:**
- Nutzeradministrator is logged in
- Nutzeradministrator has Gruppenverwaltung permission
- A group exists with at least one admin and one normal member

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to the group's invitation settings | Invitation settings page is displayed |
| 2 | 2. Select 'Nur Administratoren' and click 'Speichern' | Settings are saved and confirmation message is shown |
| 3 | 3. Log in as a normal group member and attempt to add a new user to the group | The add-user action is blocked |

**Final Expected Result:** Only administrators can add users to groups when 'Nur Administratoren' is set.

---

### TC-699: Non-admin invitation attempt is rejected with error message

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-084
**Requirement:** WA-SET-005

**Description:** Ensure non-admin members receive an error message when inviting users under admin-only setting.

**Preconditions:**
- Invitation settings are set to 'Nur Administratoren'
- A normal group member is logged in
- Target user exists and is not in the group

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to the group members page | Group members page loads successfully |
| 2 | 2. Click 'Nutzer hinzufügen' and enter the target user's identifier | Invite form accepts the input |
| 3 | 3. Submit the invitation | An error message is displayed indicating insufficient permissions |

**Final Expected Result:** The invitation is rejected and a permission error message is shown.

---

### TC-700: Admin can add users when admins-only is enabled

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-084
**Requirement:** WA-SET-005

**Description:** Verify that administrators can still add users when invitations are limited to admins.

**Preconditions:**
- Invitation settings are set to 'Nur Administratoren'
- An administrator is logged in
- Target user exists and is not in the group

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to the group members page | Group members page loads successfully |
| 2 | 2. Click 'Nutzer hinzufügen' and enter the target user's identifier | Invite form accepts the input |
| 3 | 3. Submit the invitation | User is added to the group and appears in the members list |

**Final Expected Result:** Administrator successfully adds the user to the group.

---

### TC-701: All members can add users when setting is 'Alle Mitglieder'

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-084
**Requirement:** WA-SET-005

**Description:** Verify that normal members can add users when invitations are open to all members.

**Preconditions:**
- Invitation settings are set to 'Alle Mitglieder'
- A normal group member is logged in
- Target user exists and is not in the group

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to the group members page | Group members page loads successfully |
| 2 | 2. Click 'Nutzer hinzufügen' and enter the target user's identifier | Invite form accepts the input |
| 3 | 3. Submit the invitation | User is added to the group and appears in the members list |

**Final Expected Result:** Normal member successfully adds the user to the group.

---

### TC-702: Permission change takes effect immediately for members

**Type:** integration
**Priority:** medium
**Status:** manual
**User Story:** US-084
**Requirement:** WA-SET-005

**Description:** Ensure that switching from 'Nur Administratoren' to 'Alle Mitglieder' allows members to add users without re-login.

**Preconditions:**
- Nutzeradministrator is logged in
- A normal group member is logged in in a separate session
- Target user exists and is not in the group

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. As admin, set invitation settings to 'Nur Administratoren' and save | Settings are saved and confirmation is shown |
| 2 | 2. As normal member, attempt to add the target user | Action is blocked with permission error |
| 3 | 3. As admin, change invitation settings to 'Alle Mitglieder' and save | Settings are saved and confirmation is shown |
| 4 | 4. As normal member, attempt to add the same target user again | User is added successfully |

**Final Expected Result:** Permission changes are applied immediately across sessions.

---

### TC-703: Boundary: Inviting an existing member under allowed settings

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-084
**Requirement:** WA-SET-005

**Description:** Validate error handling when attempting to add a user who is already a group member.

**Preconditions:**
- Invitation settings are set to 'Alle Mitglieder'
- A normal group member is logged in
- Target user already belongs to the group

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to the group members page | Group members page loads successfully |
| 2 | 2. Click 'Nutzer hinzufügen' and enter the existing member's identifier | Invite form accepts the input |
| 3 | 3. Submit the invitation | An error message indicates the user is already a member |

**Final Expected Result:** The system prevents duplicate membership and shows a clear error.

---

### TC-704: Display storage usage overview with current values

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-085
**Requirement:** WA-SET-006

**Description:** Verify that the storage overview shows used and available storage per area and total usage with current values

**Preconditions:**
- Administrator is logged in
- Storage usage data is available and up to date

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to the storage usage overview page | Storage usage overview page loads successfully |
| 2 | 2. Observe the storage usage section for each area | Used and available storage values are displayed for each area |
| 3 | 3. Observe the total storage usage section | Total used and available storage values are displayed |
| 4 | 4. Compare displayed values with the latest data source | Displayed values match the latest data source values |

**Final Expected Result:** The storage overview shows current used/available storage per area and total usage

---

### TC-705: Persist new storage limit for a specific area

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-085
**Requirement:** WA-SET-006

**Description:** Verify that a valid storage limit can be saved and persists in the system

**Preconditions:**
- Administrator is logged in
- Storage limit management is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to storage limit management | Storage limit management screen is displayed |
| 2 | 2. Select an area to set a new storage limit | Area is selected and limit input is enabled |
| 3 | 3. Enter a valid storage limit within allowed range | Input is accepted without validation error |
| 4 | 4. Click the save button | Success confirmation message is displayed |
| 5 | 5. Reopen the same area settings | The newly saved storage limit is displayed |

**Final Expected Result:** The valid storage limit is validated and persisted for the selected area

---

### TC-706: Reject non-numeric storage limit input

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-085
**Requirement:** WA-SET-006

**Description:** Verify validation prevents non-numeric values for storage limit

**Preconditions:**
- Administrator is logged in
- Storage limit management is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to storage limit management | Storage limit management screen is displayed |
| 2 | 2. Select an area to set a new storage limit | Area is selected and limit input is enabled |
| 3 | 3. Enter a non-numeric value (e.g., 'abc') | Validation error is displayed for invalid input |
| 4 | 4. Click the save button | Save is blocked and no changes are persisted |

**Final Expected Result:** Non-numeric storage limit values are rejected and not saved

---

### TC-707: Reject negative storage limit input

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-085
**Requirement:** WA-SET-006

**Description:** Verify validation prevents negative storage limit values

**Preconditions:**
- Administrator is logged in
- Storage limit management is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to storage limit management | Storage limit management screen is displayed |
| 2 | 2. Select an area to set a new storage limit | Area is selected and limit input is enabled |
| 3 | 3. Enter a negative storage limit (e.g., -1) | Validation error is displayed for invalid range |
| 4 | 4. Click the save button | Save is blocked and no changes are persisted |

**Final Expected Result:** Negative storage limit values are rejected and not saved

---

### TC-708: Boundary test for minimum allowed storage limit

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-085
**Requirement:** WA-SET-006

**Description:** Verify the system accepts the minimum allowed storage limit value

**Preconditions:**
- Administrator is logged in
- Storage limit management is available
- Minimum allowed storage limit is defined

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to storage limit management | Storage limit management screen is displayed |
| 2 | 2. Select an area to set a new storage limit | Area is selected and limit input is enabled |
| 3 | 3. Enter the minimum allowed storage limit value | Input is accepted without validation error |
| 4 | 4. Click the save button | Success confirmation message is displayed |

**Final Expected Result:** Minimum allowed storage limit is accepted and persisted

---

### TC-709: Boundary test for maximum allowed storage limit

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-085
**Requirement:** WA-SET-006

**Description:** Verify the system accepts the maximum allowed storage limit value

**Preconditions:**
- Administrator is logged in
- Storage limit management is available
- Maximum allowed storage limit is defined

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to storage limit management | Storage limit management screen is displayed |
| 2 | 2. Select an area to set a new storage limit | Area is selected and limit input is enabled |
| 3 | 3. Enter the maximum allowed storage limit value | Input is accepted without validation error |
| 4 | 4. Click the save button | Success confirmation message is displayed |

**Final Expected Result:** Maximum allowed storage limit is accepted and persisted

---

### TC-710: Reject storage limit above maximum allowed value

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-085
**Requirement:** WA-SET-006

**Description:** Verify validation prevents saving a storage limit greater than the maximum allowed value

**Preconditions:**
- Administrator is logged in
- Storage limit management is available
- Maximum allowed storage limit is defined

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to storage limit management | Storage limit management screen is displayed |
| 2 | 2. Select an area to set a new storage limit | Area is selected and limit input is enabled |
| 3 | 3. Enter a storage limit above the maximum allowed value | Validation error is displayed for invalid range |
| 4 | 4. Click the save button | Save is blocked and no changes are persisted |

**Final Expected Result:** Storage limit above maximum allowed value is rejected and not saved

---

### TC-711: Show error when storage usage data is temporarily unavailable

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-085
**Requirement:** WA-SET-006

**Description:** Verify a meaningful error message appears and no stale values are shown when data is unavailable

**Preconditions:**
- Administrator is logged in
- Storage usage data source is temporarily unavailable

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to the storage usage overview page | Storage usage overview page loads with an error state |
| 2 | 2. Observe the error message | A clear, meaningful error message is displayed |
| 3 | 3. Check storage usage values on the page | No used/available values are displayed; no stale data is shown |

**Final Expected Result:** An informative error is shown and no outdated storage usage values are displayed

---

### TC-712: Verify storage usage overview refresh shows updated values

**Type:** integration
**Priority:** medium
**Status:** manual
**User Story:** US-085
**Requirement:** WA-SET-006

**Description:** Verify that refreshing the overview shows updated values after data changes

**Preconditions:**
- Administrator is logged in
- Storage usage data is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the storage usage overview page | Overview displays current values |
| 2 | 2. Trigger an update in storage usage data source | Data source reflects new usage values |
| 3 | 3. Refresh the storage usage overview page | Overview displays the updated values |

**Final Expected Result:** Overview reflects the latest storage usage values after refresh

---

### TC-713: Access control for storage usage overview

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-085
**Requirement:** WA-SET-006

**Description:** Verify only administrators can access the storage usage overview

**Preconditions:**
- Non-admin user is logged in

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Attempt to navigate to the storage usage overview page | Access is denied or user is redirected to an unauthorized page |

**Final Expected Result:** Non-admin users cannot access the storage usage overview

---

### TC-714: Access control for storage limit management

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-085
**Requirement:** WA-SET-006

**Description:** Verify only administrators can manage storage limits

**Preconditions:**
- Non-admin user is logged in

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Attempt to navigate to storage limit management | Access is denied or user is redirected to an unauthorized page |

**Final Expected Result:** Non-admin users cannot manage storage limits

---

### TC-715: Handle persistence failure when saving storage limit

**Type:** integration
**Priority:** high
**Status:** manual
**User Story:** US-085
**Requirement:** WA-SET-006

**Description:** Verify an error is shown and no changes are persisted when save fails

**Preconditions:**
- Administrator is logged in
- Storage limit management is available
- Persistence service is unavailable

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to storage limit management | Storage limit management screen is displayed |
| 2 | 2. Select an area and enter a valid storage limit | Input is accepted without validation error |
| 3 | 3. Click the save button | An error message indicating save failure is displayed |
| 4 | 4. Reopen the same area settings | Previous storage limit remains unchanged |

**Final Expected Result:** A save failure is handled gracefully and no invalid persistence occurs

---

### TC-716: View data usage and control options when logged in

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-086
**Requirement:** WA-SET-007

**Description:** Verify that a logged-in user can access the data usage view and see current usage and control options.

**Preconditions:**
- User is registered and logged in
- User has access to settings
- Data usage service is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to Settings | Settings page is displayed |
| 2 | 2. Open the Data Usage view | Data Usage view loads successfully |
| 3 | 3. Observe current data usage and available control options | Current data usage value and control options are displayed |

**Final Expected Result:** User can view current data usage and available control options.

---

### TC-717: Apply control action when usage reaches defined threshold

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-086
**Requirement:** WA-SET-007

**Description:** Verify that a notification is sent and the selected control measure is applied when usage reaches the set limit.

**Preconditions:**
- User is logged in
- A data usage limit is set (e.g., 5 GB)
- A control measure is selected (e.g., reduce data quality or pause data)
- Notification channel is enabled

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Simulate data usage reaching the configured threshold (e.g., 5 GB) | System detects threshold reached |
| 2 | 2. Observe notifications | User receives a notification indicating the limit is reached |
| 3 | 3. Verify control measure execution | Selected control measure is applied by the system |

**Final Expected Result:** User is notified and the selected control measure is applied when the threshold is reached.

---

### TC-718: Threshold boundary: usage just below limit

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-086
**Requirement:** WA-SET-007

**Description:** Ensure no notification or control action is triggered when usage is just below the limit.

**Preconditions:**
- User is logged in
- A data usage limit is set (e.g., 5 GB)
- A control measure is selected

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Simulate data usage at 4.99 GB (just below 5 GB limit) | System registers usage below threshold |
| 2 | 2. Check notifications | No notification is sent |
| 3 | 3. Verify control measures | No control measure is applied |

**Final Expected Result:** No notification or control action occurs when usage is below the threshold.

---

### TC-719: Threshold boundary: usage equals limit

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-086
**Requirement:** WA-SET-007

**Description:** Ensure notification and control action are triggered when usage equals the limit.

**Preconditions:**
- User is logged in
- A data usage limit is set (e.g., 5 GB)
- A control measure is selected

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Simulate data usage exactly at 5 GB limit | System registers usage at threshold |
| 2 | 2. Check notifications | Notification is sent to the user |
| 3 | 3. Verify control measures | Selected control measure is applied |

**Final Expected Result:** Notification and control action are triggered when usage equals the limit.

---

### TC-720: Data usage view unavailable shows error and refresh option

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-086
**Requirement:** WA-SET-007

**Description:** Verify error handling when data usage data is temporarily unavailable.

**Preconditions:**
- User is logged in
- Data usage service is temporarily unavailable

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to Data Usage view | Data Usage view attempts to load |
| 2 | 2. Observe error handling | A clear, understandable error message is displayed |
| 3 | 3. Click the refresh/retry option | System retries fetching the data usage data |

**Final Expected Result:** User sees an understandable error and can retry loading data usage.

---

### TC-721: Successful refresh after temporary unavailability

**Type:** integration
**Priority:** medium
**Status:** manual
**User Story:** US-086
**Requirement:** WA-SET-007

**Description:** Verify that retry succeeds when the service becomes available.

**Preconditions:**
- User is logged in
- Data usage service initially unavailable, then restored

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open Data Usage view while service is unavailable | Error message and retry option are displayed |
| 2 | 2. Restore data usage service availability | Service is reachable |
| 3 | 3. Click the refresh/retry option | Data Usage view loads and displays usage and control options |

**Final Expected Result:** Data usage information loads successfully after retry.

---

### TC-722: Access control: user not logged in

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-086
**Requirement:** WA-SET-007

**Description:** Ensure unauthenticated users cannot access data usage view.

**Preconditions:**
- User is not logged in

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Attempt to navigate directly to Data Usage view URL | Access is denied or redirected to login |
| 2 | 2. Observe page content | Data usage details are not displayed |

**Final Expected Result:** Unauthenticated users cannot view data usage.

---

### TC-723: Control option selection persists

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-086
**Requirement:** WA-SET-007

**Description:** Verify that selected data usage control options are saved and displayed on next visit.

**Preconditions:**
- User is logged in
- Data usage view is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open Data Usage view | Data usage view loads |
| 2 | 2. Select a control option (e.g., reduce data quality) | Selection is saved and confirmation is shown |
| 3 | 3. Navigate away and return to Data Usage view | Previously selected control option is displayed as selected |

**Final Expected Result:** Control option selection persists across sessions.

---

### TC-724: No limit set: usage threshold should not trigger actions

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-086
**Requirement:** WA-SET-007

**Description:** Verify system does not notify or apply control measures when no limit is configured.

**Preconditions:**
- User is logged in
- No data usage limit is set

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Simulate data usage increasing beyond typical threshold values | System tracks usage without threshold |
| 2 | 2. Check notifications | No limit-related notification is sent |
| 3 | 3. Verify control measures | No automatic control measures are applied |

**Final Expected Result:** Without a configured limit, no threshold actions occur.

---

### TC-725: Performance: Data usage view loads within acceptable time

**Type:** performance
**Priority:** low
**Status:** manual
**User Story:** US-086
**Requirement:** WA-SET-007

**Description:** Ensure data usage view loads quickly under normal conditions.

**Preconditions:**
- User is logged in
- Data usage service is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open Data Usage view | View loads within defined performance threshold (e.g., <= 2 seconds) |

**Final Expected Result:** Data usage view meets performance requirements.

---

### TC-726: Select and save a new chat background from predefined options

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-087
**Requirement:** WA-SET-008

**Description:** Verify that selecting a predefined background and saving applies it to current and future chats

**Preconditions:**
- User is logged in
- User is in chat settings
- Background list is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the background selection list | List of predefined backgrounds is displayed |
| 2 | 2. Select a background option different from the current one | Selected background is highlighted or previewed |
| 3 | 3. Click the Save/Apply button | Success confirmation is shown and selection is saved |
| 4 | 4. Navigate to an existing chat | Chat displays the newly selected background |
| 5 | 5. Start a new chat session | New chat displays the newly selected background |

**Final Expected Result:** The selected background is applied to current and future chats and persists after save

---

### TC-727: Persist selected background across app restart

**Type:** integration
**Priority:** high
**Status:** manual
**User Story:** US-087
**Requirement:** WA-SET-008

**Description:** Ensure saved background persists across logout/login or app restart

**Preconditions:**
- User is logged in
- User has saved a non-default background

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Close the application or log out | Application is closed or user is logged out |
| 2 | 2. Reopen the application or log in again | User is authenticated and app loads |
| 3 | 3. Open an existing chat | Previously saved background is displayed |

**Final Expected Result:** Saved background persists across sessions

---

### TC-728: Reset to default background

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-087
**Requirement:** WA-SET-008

**Description:** Verify that resetting to default applies immediately and is saved

**Preconditions:**
- User is logged in
- User has a non-default background saved
- User is in chat settings

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Click the Reset to Default option | Default background is previewed or applied |
| 2 | 2. Save the change if required | Confirmation is shown and default is saved |
| 3 | 3. Navigate to an existing chat | Default background is displayed |

**Final Expected Result:** Default background is immediately applied and stored as the active background

---

### TC-729: Background list fails to load

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-087
**Requirement:** WA-SET-008

**Description:** Validate error handling when background list cannot be retrieved

**Preconditions:**
- User is logged in
- Background list service is unavailable or returns error

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open chat settings | Settings screen opens |
| 2 | 2. Attempt to open background selection list | A clear error message is displayed indicating the list cannot be loaded |
| 3 | 3. Navigate to a chat | Previously active background remains in use |

**Final Expected Result:** Error message is shown and current background remains unchanged

---

### TC-730: Attempt to save without selecting a background

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-087
**Requirement:** WA-SET-008

**Description:** Ensure no change occurs when user tries to save without a valid selection

**Preconditions:**
- User is logged in
- User is in chat settings

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open background selection list | List of backgrounds is displayed |
| 2 | 2. Do not select any background and click Save/Apply | User is prompted to select a background or no changes are made |
| 3 | 3. Open a chat | Previously active background remains unchanged |

**Final Expected Result:** No background change occurs without selection

---

### TC-731: Select same background as current and save

**Type:** functional
**Priority:** low
**Status:** manual
**User Story:** US-087
**Requirement:** WA-SET-008

**Description:** Verify saving the same background does not cause errors and keeps state

**Preconditions:**
- User is logged in
- User is in chat settings
- Current background is known

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open background selection list | List of backgrounds is displayed |
| 2 | 2. Select the currently active background | Selected background is highlighted |
| 3 | 3. Click Save/Apply | Save completes without error |

**Final Expected Result:** Background remains the same with no errors

---

### TC-732: Boundary: verify all predefined options are selectable

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-087
**Requirement:** WA-SET-008

**Description:** Ensure each predefined background can be selected and applied

**Preconditions:**
- User is logged in
- User is in chat settings
- Background list is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open background selection list | All predefined backgrounds are displayed |
| 2 | 2. Select the first background option and save | First background is applied |
| 3 | 3. Select the last background option and save | Last background is applied |

**Final Expected Result:** Any predefined background can be selected and applied successfully

---

### TC-733: Performance: background list loads within acceptable time

**Type:** performance
**Priority:** low
**Status:** manual
**User Story:** US-087
**Requirement:** WA-SET-008

**Description:** Validate background list loading time does not exceed performance threshold

**Preconditions:**
- User is logged in
- User is in chat settings
- Network is stable

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open background selection list and start timer | Timer starts and request is made |
| 2 | 2. Observe list load completion | List loads within the defined threshold (e.g., 2 seconds) |

**Final Expected Result:** Background list loads within acceptable performance limits

---

### TC-734: Activate Dark Mode from Settings

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-088
**Requirement:** WA-SET-009

**Description:** Verify that enabling Dark Mode immediately switches UI to dark theme

**Preconditions:**
- User is logged in
- User is on Settings screen
- Dark Mode is currently disabled

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Locate the Dark Mode toggle in Settings | Dark Mode toggle is visible and in OFF state |
| 2 | 2. Tap/click the Dark Mode toggle to enable | Toggle switches to ON state |
| 3 | 3. Observe the UI theme | UI switches immediately to dark color scheme across visible screens |

**Final Expected Result:** Dark Mode is enabled and UI immediately changes to dark theme

---

### TC-735: Deactivate Dark Mode from Settings

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-088
**Requirement:** WA-SET-009

**Description:** Verify that disabling Dark Mode immediately switches UI back to light theme

**Preconditions:**
- User is logged in
- User is on Settings screen
- Dark Mode is currently enabled

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Locate the Dark Mode toggle in Settings | Dark Mode toggle is visible and in ON state |
| 2 | 2. Tap/click the Dark Mode toggle to disable | Toggle switches to OFF state |
| 3 | 3. Observe the UI theme | UI switches immediately to light color scheme across visible screens |

**Final Expected Result:** Dark Mode is disabled and UI immediately changes to light theme

---

### TC-736: Dark Mode state persists after app restart

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-088
**Requirement:** WA-SET-009

**Description:** Verify Dark Mode remains active after app restart

**Preconditions:**
- User is logged in
- Dark Mode is enabled

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Close the application completely | Application is terminated |
| 2 | 2. Relaunch the application | Start view loads successfully |
| 3 | 3. Observe the UI theme on start view | Dark theme is applied on start view |
| 4 | 4. Navigate to Settings | Settings screen opens |
| 5 | 5. Check Dark Mode toggle state | Toggle remains in ON state |

**Final Expected Result:** Dark Mode persists after restart and is correctly displayed

---

### TC-737: Dark Mode default state after first login (boundary condition)

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-088
**Requirement:** WA-SET-009

**Description:** Verify default theme when no previous preference exists

**Preconditions:**
- User is logged in for the first time
- No saved theme preference exists

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to the Settings screen | Settings screen opens |
| 2 | 2. Observe Dark Mode toggle state | Toggle is in OFF state (default) |
| 3 | 3. Observe the UI theme | UI is in light theme by default |

**Final Expected Result:** Default theme is light when no preference is saved

---

### TC-738: Rapid toggle switching (boundary condition)

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-088
**Requirement:** WA-SET-009

**Description:** Verify UI stability when toggling Dark Mode quickly

**Preconditions:**
- User is logged in
- User is on Settings screen

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Toggle Dark Mode ON | UI switches to dark theme |
| 2 | 2. Immediately toggle Dark Mode OFF | UI switches back to light theme |
| 3 | 3. Toggle Dark Mode ON again | UI switches to dark theme |

**Final Expected Result:** UI consistently reflects the last toggle state without glitches

---

### TC-739: Unauthorized access to Settings (negative test)

**Type:** integration
**Priority:** medium
**Status:** manual
**User Story:** US-088
**Requirement:** WA-SET-009

**Description:** Verify Dark Mode cannot be changed without authentication

**Preconditions:**
- User is logged out

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Attempt to open the Settings screen | User is redirected to login or shown access denied |
| 2 | 2. Attempt to locate Dark Mode toggle | Dark Mode toggle is not accessible |

**Final Expected Result:** Unauthenticated users cannot change Dark Mode setting

---

### TC-740: Theme persists across app navigation

**Type:** e2e
**Priority:** medium
**Status:** manual
**User Story:** US-088
**Requirement:** WA-SET-009

**Description:** Verify Dark Mode applies across multiple screens immediately after enabling

**Preconditions:**
- User is logged in
- Dark Mode is currently disabled

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Enable Dark Mode in Settings | UI switches to dark theme |
| 2 | 2. Navigate to Home screen | Home screen is displayed in dark theme |
| 3 | 3. Navigate to another feature screen | All UI elements display in dark theme |

**Final Expected Result:** Dark Mode applies consistently across screens after enabling

---

### TC-741: Switch to a supported language updates all UI text

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-089
**Requirement:** WA-SET-010

**Description:** Verify that selecting a supported language updates all UI texts, system messages, and navigation elements

**Preconditions:**
- Application is started
- At least two supported languages are configured
- User is on language selection screen

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the language selection menu | Language options list is displayed |
| 2 | 2. Select a supported language (e.g., German) | Selected language is highlighted |
| 3 | 3. Confirm the selection | UI refreshes in the selected language |
| 4 | 4. Navigate to main screen, settings, and notifications area | All UI texts, system messages, and navigation labels are shown in the selected language |

**Final Expected Result:** Application displays all UI and system text fully in the chosen supported language

---

### TC-742: Unsupported language selection shows error and keeps current language

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-089
**Requirement:** WA-SET-010

**Description:** Verify that selecting an unsupported language keeps current language and shows a clear error message

**Preconditions:**
- Application is started
- Current language is set to a supported language
- Unsupported language option is accessible for test (e.g., via mock configuration)

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the language selection menu | Language options list is displayed |
| 2 | 2. Attempt to select an unsupported language | Selection is accepted by UI for confirmation |
| 3 | 3. Confirm the selection | Error message is displayed indicating the language is not supported |
| 4 | 4. Inspect the UI language after the error | UI remains in the previous language |

**Final Expected Result:** Unsupported language selection is rejected with a clear error and the previous language remains active

---

### TC-743: Auto-detect device language when no manual selection exists

**Type:** integration
**Priority:** high
**Status:** manual
**User Story:** US-089
**Requirement:** WA-SET-010

**Description:** Verify that UI automatically uses the device language when no manual language is set

**Preconditions:**
- Application is started
- No manual language preference has been saved
- Device language is set to a supported language

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Launch the application for the first time | No manual language selection is prompted |
| 2 | 2. Observe the UI texts on the home screen | UI is displayed in the device language |

**Final Expected Result:** Application auto-selects and displays the device language when no manual selection exists

---

### TC-744: Manual language selection overrides auto-detected device language

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-089
**Requirement:** WA-SET-010

**Description:** Verify that user selection overrides auto-detected language and persists during the session

**Preconditions:**
- Application is started
- Device language is supported and currently in use by the app
- Language selection menu is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the language selection menu | Language options list is displayed |
| 2 | 2. Select a different supported language from device language | Selected language is highlighted |
| 3 | 3. Confirm the selection | UI updates to the newly selected language |
| 4 | 4. Navigate across multiple screens | UI remains in the manually selected language |

**Final Expected Result:** Manual language choice overrides the auto-detected device language

---

### TC-745: Language change applies to system messages and alerts

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-089
**Requirement:** WA-SET-010

**Description:** Verify that system messages, dialogs, and error alerts are translated after language switch

**Preconditions:**
- Application is started
- At least two supported languages are configured
- User can trigger a system alert

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Change the language to a supported language (e.g., French) | UI updates to French |
| 2 | 2. Trigger a system alert (e.g., network error) | Alert message appears in French |

**Final Expected Result:** All system messages and alerts are displayed in the selected language

---

### TC-746: Boundary test with minimum supported languages configured

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-089
**Requirement:** WA-SET-010

**Description:** Verify language selection behavior when only one supported language is configured

**Preconditions:**
- Application is started
- Only one supported language is configured
- Language selection menu is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the language selection menu | Only one language option is displayed |
| 2 | 2. Select the only available language and confirm | UI remains in the same language without errors |

**Final Expected Result:** Application handles single-language configuration gracefully

---

### TC-747: Unsupported device language falls back to previous language

**Type:** integration
**Priority:** medium
**Status:** manual
**User Story:** US-089
**Requirement:** WA-SET-010

**Description:** Verify fallback behavior when device language is unsupported and no manual selection exists

**Preconditions:**
- Application is started
- No manual language preference has been saved
- Device language is set to an unsupported language

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Launch the application | Application starts normally |
| 2 | 2. Observe UI language on the home screen | UI displays in default or previously configured supported language |
| 3 | 3. Check for any warning or informational message | A clear informational or error message is shown if required by product behavior |

**Final Expected Result:** Application falls back to a supported language when device language is unsupported

---

### TC-748: Enable Cloud-Backup and perform successful backup

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-090
**Requirement:** WA-BAK-001

**Description:** Verify that a logged-in user with stable internet can enable Cloud-Backup and complete a backup with confirmation

**Preconditions:**
- User is registered and logged in
- Stable internet connection is available
- User has not exceeded cloud storage limit
- Cloud-Backup feature is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to Settings > Backup | Backup settings page is displayed |
| 2 | 2. Toggle Cloud-Backup to ON | Cloud-Backup is enabled and UI shows enabled state |
| 3 | 3. Tap 'Start Backup' | Backup process starts and progress indicator is shown |
| 4 | 4. Wait for the backup to complete | Backup completes successfully without errors |

**Final Expected Result:** Backup is stored in the cloud and the user receives a confirmation message

---

### TC-749: Start backup without internet connection

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-090
**Requirement:** WA-BAK-001

**Description:** Verify backup does not start and user receives clear error when no internet is available

**Preconditions:**
- User is registered and logged in
- No internet connection is available
- Cloud-Backup is enabled

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to Settings > Backup | Backup settings page is displayed |
| 2 | 2. Tap 'Start Backup' | Backup does not start and a network error is shown |

**Final Expected Result:** Backup is not executed and user sees a clear error message with a retry suggestion

---

### TC-750: Internet connection drops during backup

**Type:** integration
**Priority:** high
**Status:** manual
**User Story:** US-090
**Requirement:** WA-BAK-001

**Description:** Verify backup fails gracefully when connection is lost mid-process

**Preconditions:**
- User is registered and logged in
- Cloud-Backup is enabled
- Stable internet connection initially available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to Settings > Backup | Backup settings page is displayed |
| 2 | 2. Tap 'Start Backup' | Backup process starts and progress indicator is shown |
| 3 | 3. Disconnect internet during backup | Backup process stops and an error is displayed |

**Final Expected Result:** Backup is not completed and user receives a clear error message with a retry option

---

### TC-751: Backup rejected due to cloud storage limit reached

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-090
**Requirement:** WA-BAK-001

**Description:** Verify backup is blocked and user sees storage management options when limit is reached

**Preconditions:**
- User is registered and logged in
- Cloud-Backup is enabled
- User has reached cloud storage limit

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to Settings > Backup | Backup settings page is displayed |
| 2 | 2. Tap 'Start Backup' | Backup is rejected and a storage limit message appears |

**Final Expected Result:** Backup is not executed and user is presented with options to manage storage

---

### TC-752: Attempt backup when Cloud-Backup is disabled

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-090
**Requirement:** WA-BAK-001

**Description:** Verify user cannot start backup unless Cloud-Backup is enabled

**Preconditions:**
- User is registered and logged in
- Stable internet connection is available
- Cloud-Backup is disabled

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to Settings > Backup | Backup settings page is displayed with Cloud-Backup disabled |
| 2 | 2. Tap 'Start Backup' | Backup does not start and user is prompted to enable Cloud-Backup |

**Final Expected Result:** Backup is not executed and user is informed to enable Cloud-Backup first

---

### TC-753: Boundary: Backup at exact storage limit

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-090
**Requirement:** WA-BAK-001

**Description:** Verify backup behavior when storage is exactly full (limit reached)

**Preconditions:**
- User is registered and logged in
- Cloud-Backup is enabled
- Cloud storage is exactly at limit

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to Settings > Backup | Backup settings page is displayed |
| 2 | 2. Tap 'Start Backup' | Backup is rejected with storage limit message |

**Final Expected Result:** Backup is not executed and user is shown storage management options

---

### TC-754: Retry backup after network error

**Type:** e2e
**Priority:** medium
**Status:** manual
**User Story:** US-090
**Requirement:** WA-BAK-001

**Description:** Verify user can retry backup successfully after restoring connectivity

**Preconditions:**
- User is registered and logged in
- Cloud-Backup is enabled
- Initial internet connection is unavailable
- Cloud storage has available space

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to Settings > Backup | Backup settings page is displayed |
| 2 | 2. Tap 'Start Backup' with no internet | Backup does not start and a retry suggestion appears |
| 3 | 3. Restore internet connection | Device shows active internet connection |
| 4 | 4. Tap 'Start Backup' again | Backup process starts and completes successfully |

**Final Expected Result:** Backup completes successfully and user receives confirmation

---

### TC-755: Performance: Backup completion within acceptable time

**Type:** performance
**Priority:** low
**Status:** manual
**User Story:** US-090
**Requirement:** WA-BAK-001

**Description:** Verify backup completes within defined performance threshold under stable connection

**Preconditions:**
- User is registered and logged in
- Cloud-Backup is enabled
- Stable high-speed internet connection is available
- Cloud storage has sufficient space

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to Settings > Backup | Backup settings page is displayed |
| 2 | 2. Tap 'Start Backup' | Backup process starts and progress indicator is shown |
| 3 | 3. Measure time until completion | Backup completes within the defined performance threshold |

**Final Expected Result:** Backup completes within acceptable time and user receives confirmation

---

### TC-756: Start encrypted backup successfully

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-091
**Requirement:** WA-BAK-002

**Description:** Verify that initiating a backup creates an end-to-end encrypted backup and shows success message

**Preconditions:**
- User is registered and logged in
- Backup feature is accessible
- User has data to back up

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to the backup feature screen | Backup screen is displayed with start backup option |
| 2 | 2. Click the 'Start Backup' button | Backup process starts and progress is shown |
| 3 | 3. Wait for backup to complete | Success message is displayed indicating encrypted backup completed |
| 4 | 4. Verify backup metadata or log | Backup is marked as end-to-end encrypted and stored |

**Final Expected Result:** An end-to-end encrypted backup is created and user receives a success confirmation

---

### TC-757: Restore from encrypted backup successfully

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-091
**Requirement:** WA-BAK-002

**Description:** Verify that a valid encrypted backup can be fully and correctly restored

**Preconditions:**
- User is registered and logged in
- An end-to-end encrypted backup exists for the user
- User has valid decryption secret

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to the restore screen | Restore screen is displayed with available backups |
| 2 | 2. Select the latest encrypted backup | Backup details are shown and restore option is enabled |
| 3 | 3. Enter the valid decryption secret | Secret is accepted and restore button becomes active |
| 4 | 4. Click 'Restore' and wait for completion | Restore completes without errors and success message is shown |
| 5 | 5. Verify restored data | All data matches the original backup contents |

**Final Expected Result:** Data is fully and correctly restored from the encrypted backup

---

### TC-758: Restore fails without valid decryption secret

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-091
**Requirement:** WA-BAK-002

**Description:** Verify that restore is rejected when decryption secret is invalid or missing

**Preconditions:**
- User is registered and logged in
- An end-to-end encrypted backup exists for the user

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to the restore screen | Restore screen is displayed |
| 2 | 2. Select an encrypted backup | Backup details are displayed |
| 3 | 3. Leave decryption secret empty or enter an invalid secret | Input is accepted but validation indicates invalid secret on submission |
| 4 | 4. Click 'Restore' | Restore is rejected and a clear error message is displayed |

**Final Expected Result:** Restore is not performed and user sees a clear error message about invalid secret

---

### TC-759: Backup creation fails gracefully when user is not logged in

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-091
**Requirement:** WA-BAK-002

**Description:** Verify access control for backup feature

**Preconditions:**
- User is not logged in

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Attempt to access the backup feature URL directly | User is redirected to login or access is denied |
| 2 | 2. Attempt to start backup without authentication | Backup is not started and user is prompted to log in |

**Final Expected Result:** Unauthenticated users cannot start backups and are prompted to authenticate

---

### TC-760: Restore from corrupted encrypted backup

**Type:** integration
**Priority:** medium
**Status:** manual
**User Story:** US-091
**Requirement:** WA-BAK-002

**Description:** Verify error handling when backup file is corrupted or tampered

**Preconditions:**
- User is registered and logged in
- A corrupted or tampered encrypted backup exists
- User has valid decryption secret

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to restore screen | Restore screen is displayed |
| 2 | 2. Select the corrupted encrypted backup | Backup details are displayed |
| 3 | 3. Enter valid decryption secret and start restore | System detects corruption and stops restore |

**Final Expected Result:** Restore is aborted and a clear error message about corrupted backup is shown

---

### TC-761: Backup encryption verification via stored metadata

**Type:** integration
**Priority:** medium
**Status:** manual
**User Story:** US-091
**Requirement:** WA-BAK-002

**Description:** Verify that backup is marked and stored as end-to-end encrypted

**Preconditions:**
- User is registered and logged in
- Backup feature is accessible

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Start a new backup | Backup process starts |
| 2 | 2. After completion, view backup metadata/logs | Metadata indicates end-to-end encryption |

**Final Expected Result:** Backup is confirmed as end-to-end encrypted in system metadata

---

### TC-762: Restore with boundary condition: minimal data set

**Type:** functional
**Priority:** low
**Status:** manual
**User Story:** US-091
**Requirement:** WA-BAK-002

**Description:** Verify restore works with smallest possible backup data set

**Preconditions:**
- User is registered and logged in
- An encrypted backup exists containing minimal data

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to restore screen | Restore screen is displayed |
| 2 | 2. Select minimal data backup and enter valid secret | Restore starts successfully |
| 3 | 3. Wait for restore to finish | Restore completes successfully |

**Final Expected Result:** Minimal data backup is restored correctly

---

### TC-763: Restore with boundary condition: large data set

**Type:** performance
**Priority:** medium
**Status:** manual
**User Story:** US-091
**Requirement:** WA-BAK-002

**Description:** Verify restore works with large backup data set without data loss

**Preconditions:**
- User is registered and logged in
- An encrypted backup exists containing large data set
- User has valid decryption secret

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to restore screen | Restore screen is displayed |
| 2 | 2. Select large backup and enter valid secret | Restore starts and progress is shown |
| 3 | 3. Monitor restore completion time and result | Restore completes within acceptable time and no errors are shown |
| 4 | 4. Verify data integrity | All restored data matches backup contents |

**Final Expected Result:** Large encrypted backup is restored correctly within acceptable performance limits

---

### TC-764: Backup success message content and localization

**Type:** functional
**Priority:** low
**Status:** manual
**User Story:** US-091
**Requirement:** WA-BAK-002

**Description:** Verify success message is understandable and localized for the user

**Preconditions:**
- User is registered and logged in
- Backup feature is accessible
- User language set to German

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Start a backup | Backup process starts |
| 2 | 2. Wait for completion | Success message is displayed in German and is understandable |

**Final Expected Result:** User receives a clear, localized success message upon backup completion

---

### TC-765: Export single chat with messages successfully

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-092
**Requirement:** WA-BAK-003

**Description:** Verify that a logged-in user can export an existing single chat with messages and download the file

**Preconditions:**
- User is logged in
- User is in an existing single chat with at least one message
- User has permission to export the chat

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the chat options menu | Chat options menu is displayed |
| 2 | 2. Click the Export Chat option | Export process starts and a download is prepared |
| 3 | 3. Download the export file | File is downloaded successfully |
| 4 | 4. Open the downloaded file | File contains all chat messages and required metadata |

**Final Expected Result:** A downloadable export file containing the full chat content and metadata is created

---

### TC-766: Export empty chat generates file with metadata only

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-092
**Requirement:** WA-BAK-003

**Description:** Verify that exporting a chat with no messages creates an empty export file containing only metadata

**Preconditions:**
- User is logged in
- User is in an existing single chat with zero messages
- User has permission to export the chat

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the chat options menu | Chat options menu is displayed |
| 2 | 2. Click the Export Chat option | Export process starts and a download is prepared |
| 3 | 3. Download the export file | File is downloaded successfully |
| 4 | 4. Open the downloaded file | File contains only metadata and no messages |

**Final Expected Result:** A downloadable export file is created containing only chat metadata

---

### TC-767: Export denied for user without permission

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-092
**Requirement:** WA-BAK-003

**Description:** Verify that the system blocks export for a user who lacks permission and shows an error message

**Preconditions:**
- User is logged in
- User is in an existing single chat
- User does not have permission to export the chat

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the chat options menu | Chat options menu is displayed |
| 2 | 2. Click the Export Chat option | System blocks the action and displays an understandable error message |
| 3 | 3. Check for a download prompt | No download is initiated |

**Final Expected Result:** Export is refused and a clear error message is shown

---

### TC-768: Export button not visible when user lacks permission

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-092
**Requirement:** WA-BAK-003

**Description:** Verify UI hides or disables export option for users without export permission

**Preconditions:**
- User is logged in
- User is in an existing single chat
- User does not have permission to export the chat

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the chat options menu | Chat options menu is displayed |
| 2 | 2. Inspect available options | Export option is hidden or disabled |

**Final Expected Result:** Export option is not available to unauthorized users

---

### TC-769: Export file includes required metadata

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-092
**Requirement:** WA-BAK-003

**Description:** Verify that export includes metadata such as chat ID, participants, and timestamps

**Preconditions:**
- User is logged in
- User is in an existing single chat with messages
- User has permission to export the chat

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Trigger export for the chat | Export file is prepared for download |
| 2 | 2. Download and open the export file | File is readable and accessible |
| 3 | 3. Verify metadata fields | Chat ID, participants, and message timestamps are present |

**Final Expected Result:** Export file contains required chat metadata

---

### TC-770: Export handles chat with large number of messages

**Type:** performance
**Priority:** medium
**Status:** manual
**User Story:** US-092
**Requirement:** WA-BAK-003

**Description:** Verify export succeeds for chats with a large message count without truncation

**Preconditions:**
- User is logged in
- User is in an existing single chat with a large number of messages
- User has permission to export the chat

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Trigger export for the chat | Export process starts without errors |
| 2 | 2. Download the export file | File download completes successfully |
| 3 | 3. Validate message count in export | All messages are included with no truncation |

**Final Expected Result:** Large chat exports successfully with full content

---

### TC-771: Export fails gracefully on server error

**Type:** integration
**Priority:** medium
**Status:** manual
**User Story:** US-092
**Requirement:** WA-BAK-003

**Description:** Verify that a server-side failure during export shows a clear error and does not provide a partial file

**Preconditions:**
- User is logged in
- User is in an existing single chat with messages
- User has permission to export the chat
- Export service is configured to return an error

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Trigger export for the chat | System attempts to create export and encounters an error |
| 2 | 2. Observe the UI response | A clear error message is displayed |
| 3 | 3. Check for any downloaded file | No file is downloaded |

**Final Expected Result:** Export failure is handled with an understandable error message and no file download

---

### TC-772: User not logged in cannot export chat

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-092
**Requirement:** WA-BAK-003

**Description:** Verify that unauthenticated users cannot access export functionality

**Preconditions:**
- User is not logged in
- A chat URL is known

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to the chat URL | User is redirected to login or access is denied |
| 2 | 2. Attempt to access export via direct URL or UI | Export is blocked and user is prompted to log in |

**Final Expected Result:** Export is not accessible without authentication

---

### TC-773: Successful chat history transfer between devices with same account

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-093
**Requirement:** WA-BAK-004

**Description:** Verify full chat history is transferred when user is logged in on both devices with same account and online

**Preconditions:**
- User has existing chat history on old device
- User is logged in on old device with Account A
- User is logged in on new device with Account A
- Both devices are online with stable connectivity

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. On the old device, navigate to Chat History Transfer feature | Transfer option is visible and enabled |
| 2 | 2. Initiate transfer to the new device | Transfer starts and progress indication is shown |
| 3 | 3. On the new device, wait for transfer to complete | Transfer completes successfully |
| 4 | 4. Open chat list on the new device | All conversations from the old device are displayed |
| 5 | 5. Open a recent conversation and send a new message | Message is sent and appears in the conversation without errors |

**Final Expected Result:** Full chat history is displayed on the new device and user can continue chatting seamlessly

---

### TC-774: Transfer fails with no stable internet connection on new device

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-093
**Requirement:** WA-BAK-004

**Description:** Verify error handling when new device lacks stable internet during transfer

**Preconditions:**
- User has existing chat history on old device
- User is logged in on old device with Account A
- User is logged in on new device with Account A
- New device has unstable or no internet connection

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. On the old device, initiate chat history transfer to the new device | Transfer attempt starts |
| 2 | 2. On the new device, observe transfer status | Transfer fails due to connectivity issues |
| 3 | 3. Verify error message on the new device | System displays a clear error indicating missing/unstable connection |
| 4 | 4. Verify presence of retry option | Retry option is displayed and enabled |

**Final Expected Result:** System shows an error about missing connection and offers a retry

---

### TC-775: Retry transfer after restoring internet connection

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-093
**Requirement:** WA-BAK-004

**Description:** Verify retry succeeds after connection is restored

**Preconditions:**
- User has existing chat history on old device
- User is logged in on old device with Account A
- User is logged in on new device with Account A
- Initial transfer attempt failed due to no/unstable internet

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Restore stable internet connection on the new device | Device shows stable connectivity |
| 2 | 2. Tap the retry option on the new device | Transfer restarts |
| 3 | 3. Wait for transfer to complete | Transfer completes successfully |
| 4 | 4. Open chat list on the new device | All conversations are visible |

**Final Expected Result:** Transfer succeeds on retry after connectivity is restored

---

### TC-776: Transfer blocked when accounts do not match

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-093
**Requirement:** WA-BAK-004

**Description:** Verify transfer is denied when old and new devices use different accounts

**Preconditions:**
- User has existing chat history on old device with Account A
- Old device is logged in with Account A
- New device is logged in with Account B
- Both devices are online

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. On the old device, initiate chat history transfer to the new device | Transfer request is sent |
| 2 | 2. On the new device, observe transfer response | System rejects the transfer |
| 3 | 3. Verify user notification on either device | User is informed that accounts do not match |

**Final Expected Result:** Transfer is refused and user is informed of account mismatch

---

### TC-777: No partial transfer on failure

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-093
**Requirement:** WA-BAK-004

**Description:** Verify no partial chat history appears on new device after failed transfer

**Preconditions:**
- User has existing chat history on old device
- User is logged in on both devices with the same account
- New device has unstable internet connection

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Initiate transfer from old device | Transfer starts |
| 2 | 2. Interrupt connection during transfer | Transfer fails |
| 3 | 3. Open chat list on new device | Chat history is not partially displayed or is clearly marked as incomplete |

**Final Expected Result:** No partial or corrupted chat history is shown after failed transfer

---

### TC-778: Transfer with large chat history (boundary condition)

**Type:** performance
**Priority:** medium
**Status:** manual
**User Story:** US-093
**Requirement:** WA-BAK-004

**Description:** Verify transfer handles large chat history volume successfully

**Preconditions:**
- User has a large chat history (e.g., thousands of messages across many chats) on old device
- User is logged in on both devices with the same account
- Both devices are online with stable connectivity

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Initiate transfer from old device to new device | Transfer starts with progress indication |
| 2 | 2. Monitor transfer completion time | Transfer completes within acceptable time threshold |
| 3 | 3. Verify random sample of chats and messages on new device | Sampled chats and messages match old device content |

**Final Expected Result:** Large chat history transfers fully and correctly within acceptable performance limits

---

### TC-779: Transfer initiated when old device is offline

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-093
**Requirement:** WA-BAK-004

**Description:** Verify transfer cannot start if old device is offline

**Preconditions:**
- User has existing chat history on old device
- User is logged in on old device with Account A
- User is logged in on new device with Account A
- Old device is offline

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Attempt to initiate transfer from old device | Transfer initiation is blocked or fails |
| 2 | 2. Observe error message on old device | System indicates old device is offline or connectivity is required |

**Final Expected Result:** Transfer does not start and user is informed about offline old device

---

### TC-780: Archive active chat successfully

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-094
**Requirement:** WA-BAK-005

**Description:** Verify that an active chat can be archived and moved to archive list

**Preconditions:**
- User is logged in
- User has access to the chat
- Chat is visible in the active chat list
- Archive section is accessible

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Locate the target chat in the active chat list | Chat is visible with an available 'Archivieren' action |
| 2 | 2. Select the 'Archivieren' action for the chat | System processes the archive request without error |
| 3 | 3. Check the active chat list | Chat is removed from the active list |
| 4 | 4. Open the archive list | Archived chat is displayed in the archive list |

**Final Expected Result:** Chat is removed from active list and appears in archive list

---

### TC-781: Archive already archived chat

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-094
**Requirement:** WA-BAK-005

**Description:** Verify neutral message and unchanged state when archiving an already archived chat

**Preconditions:**
- User is logged in
- User has access to the chat
- Chat is already in the archive list

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the archive list and locate the archived chat | Chat is visible with an 'Archivieren' action available |
| 2 | 2. Select the 'Archivieren' action for the archived chat | System shows a neutral informational message |
| 3 | 3. Verify the chat status | Chat remains archived and does not move to active list |
| 4 | 4. Verify message type and content | Message is neutral/informational and not an error |

**Final Expected Result:** Chat status is unchanged and neutral message is displayed without error

---

### TC-782: Archive chat without permission

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-094
**Requirement:** WA-BAK-005

**Description:** Verify that archiving is blocked for chats the user is not authorized to access

**Preconditions:**
- User is logged in
- User does not have permission to access the target chat
- Target chat is known to exist

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Attempt to archive the chat via UI action or deep link | System denies the request |
| 2 | 2. Observe the system response | A clear, understandable error message is shown |
| 3 | 3. Check active and archive lists | Chat does not appear or change status for the user |

**Final Expected Result:** Archiving is rejected and a user-friendly error message is displayed

---

### TC-783: Archive action button availability for active chat

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-094
**Requirement:** WA-BAK-005

**Description:** Verify that the archive option is available only when chat is active and user has access

**Preconditions:**
- User is logged in
- User has access to an active chat and an archived chat

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to active chat list | Active chats are displayed |
| 2 | 2. Verify archive action on an active chat | 'Archivieren' action is present and enabled |
| 3 | 3. Navigate to archive list | Archived chats are displayed |
| 4 | 4. Verify archive action on an archived chat | 'Archivieren' action is present or behaves neutrally when selected |

**Final Expected Result:** Archive action is available for active chats and neutral behavior applies for archived chats

---

### TC-784: Archive chat updates list counts

**Type:** functional
**Priority:** low
**Status:** manual
**User Story:** US-094
**Requirement:** WA-BAK-005

**Description:** Verify that list counts update when archiving a chat

**Preconditions:**
- User is logged in
- User has access to at least one active chat
- Active and archive list counts are visible

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Note current counts for active and archived chats | Counts are visible and recorded |
| 2 | 2. Archive an active chat | Archive request succeeds |
| 3 | 3. Re-check counts for active and archived chats | Active count decreases by 1 and archive count increases by 1 |

**Final Expected Result:** List counts reflect the archived chat correctly

---

### TC-785: Archive chat via keyboard shortcut (if supported)

**Type:** e2e
**Priority:** low
**Status:** manual
**User Story:** US-094
**Requirement:** WA-BAK-005

**Description:** Verify archiving works via keyboard interaction for accessibility

**Preconditions:**
- User is logged in
- User has access to an active chat
- Archive action is keyboard accessible

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Focus the active chat item using keyboard navigation | Chat item receives focus indicator |
| 2 | 2. Trigger 'Archivieren' using keyboard (e.g., Enter/Space) | Archive request is initiated |
| 3 | 3. Verify chat removed from active list and present in archive list | Chat is moved to archive list |

**Final Expected Result:** Archiving works via keyboard and updates lists correctly

---

### TC-786: Archive chat with network interruption

**Type:** integration
**Priority:** medium
**Status:** manual
**User Story:** US-094
**Requirement:** WA-BAK-005

**Description:** Verify system behavior when archiving fails due to network error

**Preconditions:**
- User is logged in
- User has access to an active chat
- Network can be interrupted or mocked to fail

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Initiate archive action for an active chat | Archive request is sent |
| 2 | 2. Simulate network failure during request | System detects failure |
| 3 | 3. Observe user feedback | An error message indicates the archive did not complete |
| 4 | 4. Verify chat status | Chat remains in active list and not in archive |

**Final Expected Result:** Failed archive due to network error does not change chat status and shows error

---

### TC-787: Archive last active chat (boundary)

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-094
**Requirement:** WA-BAK-005

**Description:** Verify archiving the last chat in the active list handles empty state correctly

**Preconditions:**
- User is logged in
- User has access to exactly one active chat

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Confirm only one chat exists in active list | Active list shows a single chat |
| 2 | 2. Archive the single active chat | Archive request succeeds |
| 3 | 3. Verify active list empty state | Active list shows empty state message |
| 4 | 4. Verify chat appears in archive list | Chat is present in archive list |

**Final Expected Result:** Active list handles empty state correctly after archiving last chat

---

### TC-788: Pin a non-pinned chat from chat list

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-095
**Requirement:** WA-BAK-006

**Description:** Verify a non-pinned chat can be pinned and moves to top of chat list

**Preconditions:**
- User is logged in
- Chat list is visible
- At least one existing chat is not pinned

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Identify a chat that is not pinned | Chat is displayed without a pinned indicator and is below pinned section (if any) |
| 2 | 2. Open the chat options menu | Options menu is displayed for the selected chat |
| 3 | 3. Select the 'Pin' option | The chat is marked as pinned |
| 4 | 4. Observe the chat list order | The pinned chat appears at the top of the chat list (above unpinned chats) |

**Final Expected Result:** Chat is pinned and displayed at the top of the chat list

---

### TC-789: Re-pin an already pinned chat

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-095
**Requirement:** WA-BAK-006

**Description:** Verify re-pinning an already pinned chat does not create duplicates

**Preconditions:**
- User is logged in
- Chat list is visible
- At least one chat is already pinned

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Identify a chat that is already pinned | Chat shows pinned indicator and is in the pinned section |
| 2 | 2. Open the chat options menu for the pinned chat | Options menu is displayed for the selected chat |
| 3 | 3. Select the 'Pin' option again | No duplicate entry appears and the chat remains pinned |
| 4 | 4. Review the chat list for duplicates | Only one instance of the chat exists in the list |

**Final Expected Result:** Chat remains pinned and no duplicate chat entry is created

---

### TC-790: Attempt to pin a non-existent chat

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-095
**Requirement:** WA-BAK-006

**Description:** Verify system shows error and does not alter list when pinning a non-existent chat

**Preconditions:**
- User is logged in
- Chat list is visible
- A chat reference exists in UI that has been deleted on the server (stale entry)

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Select the stale chat entry | Chat entry is selected in the UI |
| 2 | 2. Open the chat options menu | Options menu is displayed for the selected chat |
| 3 | 3. Select the 'Pin' option | An error message is displayed indicating the chat no longer exists |
| 4 | 4. Observe the chat list | Chat list remains unchanged with no new pinned entry |

**Final Expected Result:** Error is shown and chat list remains unchanged

---

### TC-791: Pin a chat when no chats are currently pinned

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-095
**Requirement:** WA-BAK-006

**Description:** Verify pinning a chat correctly creates the pinned section and moves chat to top

**Preconditions:**
- User is logged in
- Chat list is visible
- No chats are currently pinned
- At least one chat exists

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Select an unpinned chat | Chat is identified as unpinned |
| 2 | 2. Open the chat options menu | Options menu is displayed |
| 3 | 3. Choose the 'Pin' option | Chat is marked as pinned |
| 4 | 4. Check the top of the list | Pinned section is created and the chat appears at the top |

**Final Expected Result:** Pinned section appears and the selected chat is at the top

---

### TC-792: Pin multiple chats and verify ordering of pinned items

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-095
**Requirement:** WA-BAK-006

**Description:** Verify multiple pinned chats are grouped at the top and remain unique

**Preconditions:**
- User is logged in
- Chat list is visible
- At least three chats exist and are unpinned

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Pin the first chat | First chat becomes pinned and moves to the top |
| 2 | 2. Pin a second different chat | Second chat becomes pinned and appears in the pinned section |
| 3 | 3. Pin a third different chat | Third chat becomes pinned and appears in the pinned section |
| 4 | 4. Verify the pinned section contains exactly three unique chats | Pinned section shows three unique chats with no duplicates |

**Final Expected Result:** Multiple chats are pinned, grouped at the top, and each appears only once

---

### TC-793: Pin action persists after refresh

**Type:** integration
**Priority:** medium
**Status:** manual
**User Story:** US-095
**Requirement:** WA-BAK-006

**Description:** Verify pinned state remains after reloading the chat list

**Preconditions:**
- User is logged in
- Chat list is visible
- At least one chat is pinned

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Refresh or reload the chat list | Chat list reloads successfully |
| 2 | 2. Observe pinned chats | Previously pinned chats remain pinned and appear at the top |

**Final Expected Result:** Pinned state is preserved after refresh

---

### TC-794: Pin a chat from an empty chat list

**Type:** functional
**Priority:** low
**Status:** manual
**User Story:** US-095
**Requirement:** WA-BAK-006

**Description:** Verify pin action is not available when there are no chats

**Preconditions:**
- User is logged in
- Chat list is visible
- No chats exist

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Observe the chat list | Chat list is empty and no chat options are available |

**Final Expected Result:** No pin action is available because there are no chats

---

### TC-795: Create business profile with all mandatory fields

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-096
**Requirement:** WA-BUS-001

**Description:** Verify successful creation of a business profile when all required fields are valid

**Preconditions:**
- User is logged in
- User has permission to create a business profile

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to Business Profile creation page | Business Profile creation form is displayed |
| 2 | 2. Enter valid values in all mandatory fields | All mandatory fields accept the entered values without validation errors |
| 3 | 3. Click the Save/Create button | Success message is displayed and profile is created |
| 4 | 4. Open the profile in web and mobile views (or platform switch) | The created business profile is visible on all platforms |

**Final Expected Result:** The business profile is successfully created and visible platform-wide

---

### TC-796: Prevent creation when mandatory fields are empty

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-096
**Requirement:** WA-BUS-001

**Description:** Ensure saving is blocked with clear field-level errors when required data is missing

**Preconditions:**
- User is logged in
- User has permission to create a business profile

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to Business Profile creation page | Business Profile creation form is displayed |
| 2 | 2. Leave one or more mandatory fields empty | No immediate save; empty fields remain unfilled |
| 3 | 3. Click the Save/Create button | Saving is prevented and field-specific error messages appear |

**Final Expected Result:** Profile is not created and clear validation errors are shown for each missing field

---

### TC-797: Prevent creation when invalid data is entered

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-096
**Requirement:** WA-BUS-001

**Description:** Validate that incorrect formats or invalid values are rejected with specific errors

**Preconditions:**
- User is logged in
- User has permission to create a business profile

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to Business Profile creation page | Business Profile creation form is displayed |
| 2 | 2. Enter invalid values (e.g., invalid email/URL or non-numeric values for numeric fields) | Fields accept input but are marked invalid after validation |
| 3 | 3. Click the Save/Create button | Saving is prevented and specific validation messages appear |

**Final Expected Result:** Profile is not created; invalid fields display concrete error messages

---

### TC-798: Verification request changes status to in review

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-096
**Requirement:** WA-BUS-001

**Description:** Verify status update and confirmation when user submits verification documents

**Preconditions:**
- User is logged in
- User has an existing business profile
- Verification feature is enabled

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the existing Business Profile | Business Profile details are displayed |
| 2 | 2. Click on 'Start Verification' | Verification submission form is displayed |
| 3 | 3. Upload required verification documents and submit | Submission is accepted and a confirmation message is displayed |
| 4 | 4. Refresh the profile page | Profile status shows 'in Prüfung' |

**Final Expected Result:** Verification submission is confirmed and status changes to 'in Prüfung'

---

### TC-799: Cannot access creation without permission

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-096
**Requirement:** WA-BUS-001

**Description:** Ensure users without permission cannot create a business profile

**Preconditions:**
- User is logged in
- User does NOT have permission to create a business profile

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Attempt to access the Business Profile creation page | Access is denied or user is redirected with an error message |

**Final Expected Result:** User cannot access or create a business profile without permission

---

### TC-800: Boundary test for maximum length fields

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-096
**Requirement:** WA-BUS-001

**Description:** Verify behavior when mandatory fields are at maximum allowed length

**Preconditions:**
- User is logged in
- User has permission to create a business profile
- Maximum lengths for fields are known

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to Business Profile creation page | Business Profile creation form is displayed |
| 2 | 2. Enter values exactly at the maximum allowed length for each mandatory field | Inputs are accepted without truncation or error |
| 3 | 3. Click the Save/Create button | Profile is created successfully |

**Final Expected Result:** Profile is created with boundary-length values and no validation errors

---

### TC-801: Boundary test for minimum required fields

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-096
**Requirement:** WA-BUS-001

**Description:** Verify that the profile can be created with only mandatory fields filled

**Preconditions:**
- User is logged in
- User has permission to create a business profile

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to Business Profile creation page | Business Profile creation form is displayed |
| 2 | 2. Fill only mandatory fields with valid values and leave all optional fields empty | Form shows no validation errors |
| 3 | 3. Click the Save/Create button | Profile is created successfully |

**Final Expected Result:** Profile creation succeeds with only required fields populated

---

### TC-802: Platform visibility after creation

**Type:** integration
**Priority:** high
**Status:** manual
**User Story:** US-096
**Requirement:** WA-BUS-001

**Description:** Validate cross-platform visibility of the created business profile

**Preconditions:**
- User is logged in
- User has permission to create a business profile

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Create a business profile with valid data | Profile is created successfully |
| 2 | 2. View the profile on Platform A (e.g., web) | Profile is visible with correct data |
| 3 | 3. View the profile on Platform B (e.g., mobile app or alternate interface) | Profile is visible with consistent data |

**Final Expected Result:** Business profile is visible and consistent across platforms

---

### TC-803: Verification submission without documents

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-096
**Requirement:** WA-BUS-001

**Description:** Ensure verification cannot be submitted without required proof documents

**Preconditions:**
- User is logged in
- User has an existing business profile
- Verification feature is enabled

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the existing Business Profile | Business Profile details are displayed |
| 2 | 2. Click on 'Start Verification' | Verification submission form is displayed |
| 3 | 3. Attempt to submit without uploading required documents | Submission is blocked and document-related error messages are shown |

**Final Expected Result:** Verification is not submitted and the user receives specific error messages

---

### TC-804: Submit verification request with all mandatory fields

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-097
**Requirement:** WA-BUS-002

**Description:** Verify that a non-verified business profile can be submitted and status changes to In Pruefung

**Preconditions:**
- Business-Administrator is logged in
- Business profile exists and is not verified
- Verification form is accessible

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to the business profile verification form | Verification form is displayed with all required fields |
| 2 | 2. Fill all mandatory fields with valid data | All fields are populated and no validation errors are shown |
| 3 | 3. Upload a valid verification document | Document upload succeeds and file is listed |
| 4 | 4. Submit the verification form | Submission succeeds and a confirmation message is displayed |

**Final Expected Result:** Verification request is saved and status changes to "In Pruefung"

---

### TC-805: Successful verification review sets status and badge

**Type:** integration
**Priority:** high
**Status:** manual
**User Story:** US-097
**Requirement:** WA-BUS-002

**Description:** Verify that a successfully reviewed request updates profile status and shows badge

**Preconditions:**
- Business-Administrator is logged in
- Verification request exists with status In Pruefung
- Reviewer marks request as approved in backend

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Refresh the business profile page after approval | Profile data is reloaded |
| 2 | 2. Check the profile status | Status is displayed as "Verifiziert" |
| 3 | 3. Verify presence of verification badge on the profile | Visible verification badge is shown |

**Final Expected Result:** Profile status is "Verifiziert" and badge is visible to users

---

### TC-806: Reject submission with missing mandatory fields

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-097
**Requirement:** WA-BUS-002

**Description:** Ensure validation errors are shown when required fields are empty

**Preconditions:**
- Business-Administrator is logged in
- Business profile exists and is not verified

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open verification form | Form is displayed |
| 2 | 2. Leave one or more mandatory fields empty | Fields remain empty |
| 3 | 3. Click submit | Submission is blocked and validation errors are shown next to empty fields |

**Final Expected Result:** Request is not submitted and concrete validation errors are displayed

---

### TC-807: Reject submission with invalid document format

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-097
**Requirement:** WA-BUS-002

**Description:** Verify that uploading an invalid document type results in validation error

**Preconditions:**
- Business-Administrator is logged in
- Business profile exists and is not verified
- Verification form is accessible

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open verification form | Form is displayed |
| 2 | 2. Upload an unsupported file type (e.g., .exe) | Upload is rejected or flagged with an error message |
| 3 | 3. Attempt to submit the form | Submission is blocked and error message indicates invalid document |

**Final Expected Result:** Submission is rejected and invalid document error is shown

---

### TC-808: Boundary: Submit with maximum allowed file size

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-097
**Requirement:** WA-BUS-002

**Description:** Ensure that documents at maximum permitted size are accepted

**Preconditions:**
- Business-Administrator is logged in
- Business profile exists and is not verified
- Maximum file size limit is known

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open verification form | Form is displayed |
| 2 | 2. Upload a valid document at the maximum allowed file size | Upload succeeds without errors |
| 3 | 3. Complete all required fields with valid data | No validation errors are shown |
| 4 | 4. Submit the form | Submission succeeds with confirmation |

**Final Expected Result:** Request is saved and status changes to "In Pruefung"

---

### TC-809: Boundary: Reject file size just above maximum limit

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-097
**Requirement:** WA-BUS-002

**Description:** Ensure that documents exceeding the maximum size are rejected

**Preconditions:**
- Business-Administrator is logged in
- Business profile exists and is not verified
- Maximum file size limit is known

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open verification form | Form is displayed |
| 2 | 2. Upload a valid document slightly above maximum size limit | Upload is rejected with size validation error |
| 3 | 3. Attempt to submit the form | Submission is blocked with file size error |

**Final Expected Result:** Submission is rejected with a file size validation error

---

### TC-810: View rejection reasons and resubmit corrected request

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-097
**Requirement:** WA-BUS-002

**Description:** Verify that rejected requests show reasons and allow resubmission

**Preconditions:**
- Business-Administrator is logged in
- Verification request exists with status Rejected
- Rejection notification is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the rejection notification | Notification details are displayed |
| 2 | 2. Review rejection reasons | Clear rejection reasons are visible |
| 3 | 3. Click on "Resubmit" or equivalent action | Verification form is opened with ability to edit |
| 4 | 4. Correct the fields/documents and submit again | Submission succeeds with confirmation message |

**Final Expected Result:** Corrected request is submitted and status changes to "In Pruefung"

---

### TC-811: Prevent submission when already verified

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-097
**Requirement:** WA-BUS-002

**Description:** Ensure verified profiles cannot submit a new verification request

**Preconditions:**
- Business-Administrator is logged in
- Business profile status is Verifiziert

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to verification section of the business profile | Verification section indicates profile is already verified |
| 2 | 2. Attempt to access or submit verification form | Form is disabled or submission is blocked with message |

**Final Expected Result:** No new verification request can be submitted for verified profile

---

### TC-812: Validation error messages are specific and localized

**Type:** functional
**Priority:** low
**Status:** manual
**User Story:** US-097
**Requirement:** WA-BUS-002

**Description:** Check that validation errors are concrete and user-friendly

**Preconditions:**
- Business-Administrator is logged in
- Business profile exists and is not verified

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open verification form | Form is displayed |
| 2 | 2. Leave multiple required fields empty and upload an invalid document | Form shows validation issues upon submit |
| 3 | 3. Submit the form | Each invalid field/document shows a specific error message |

**Final Expected Result:** Concrete, field-level validation errors are displayed

---

### TC-813: Create quick response with valid title and text

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-098
**Requirement:** WA-BUS-003

**Description:** Verify Business-Admin can create and save a quick response and it appears in list

**Preconditions:**
- Business-Admin is logged in
- Business-Admin has access to message management

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to the Schnellantworten management page | Schnellantworten list and create option are visible |
| 2 | 2. Click on 'Neue Schnellantwort erstellen' | Create Schnellantwort form is displayed |
| 3 | 3. Enter a valid Titel and Text | Entered Titel and Text are displayed in form fields |
| 4 | 4. Click on 'Speichern' | Save action completes without validation errors |

**Final Expected Result:** New Schnellantwort is displayed in the list and is available for insertion in chats

---

### TC-814: Insert quick response into chat and edit before sending

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-098
**Requirement:** WA-BUS-003

**Description:** Verify quick response selection inserts text into message field and allows editing

**Preconditions:**
- Business-Admin is logged in
- At least one Schnellantwort exists
- A customer chat is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open a chat with a customer | Chat window and message input field are visible |
| 2 | 2. Open the Schnellantworten list in chat | List of Schnellantworten is displayed |
| 3 | 3. Select an existing Schnellantwort | Corresponding text is inserted into the message input field |
| 4 | 4. Edit the inserted text in the message input field | Message input reflects the edited text |

**Final Expected Result:** Quick response text is inserted and can be edited before sending

---

### TC-815: Validation error when saving without title

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-098
**Requirement:** WA-BUS-003

**Description:** Ensure validation prevents saving when title is missing

**Preconditions:**
- Business-Admin is logged in
- Business-Admin has access to message management

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to the Schnellantworten management page | Schnellantworten list and create option are visible |
| 2 | 2. Click on 'Neue Schnellantwort erstellen' | Create Schnellantwort form is displayed |
| 3 | 3. Leave Titel empty and enter valid Text | Text field contains input; Titel field remains empty |
| 4 | 4. Click on 'Speichern' | Validation error message is shown for missing Titel |

**Final Expected Result:** Schnellantwort is not saved and validation message is displayed

---

### TC-816: Validation error when saving without text

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-098
**Requirement:** WA-BUS-003

**Description:** Ensure validation prevents saving when text is missing

**Preconditions:**
- Business-Admin is logged in
- Business-Admin has access to message management

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to the Schnellantworten management page | Schnellantworten list and create option are visible |
| 2 | 2. Click on 'Neue Schnellantwort erstellen' | Create Schnellantwort form is displayed |
| 3 | 3. Enter valid Titel and leave Text empty | Titel field contains input; Text field remains empty |
| 4 | 4. Click on 'Speichern' | Validation error message is shown for missing Text |

**Final Expected Result:** Schnellantwort is not saved and validation message is displayed

---

### TC-817: Boundary: Save quick response with maximum allowed title length

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-098
**Requirement:** WA-BUS-003

**Description:** Verify system accepts title at maximum allowed length

**Preconditions:**
- Business-Admin is logged in
- Business-Admin has access to message management
- Maximum title length is defined

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the Schnellantwort create form | Create Schnellantwort form is displayed |
| 2 | 2. Enter a Titel with exactly the maximum allowed characters and valid Text | Fields accept the input without truncation |
| 3 | 3. Click on 'Speichern' | Save action completes without validation errors |

**Final Expected Result:** Schnellantwort is saved and appears in the list

---

### TC-818: Boundary: Save quick response with maximum allowed text length

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-098
**Requirement:** WA-BUS-003

**Description:** Verify system accepts text at maximum allowed length

**Preconditions:**
- Business-Admin is logged in
- Business-Admin has access to message management
- Maximum text length is defined

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the Schnellantwort create form | Create Schnellantwort form is displayed |
| 2 | 2. Enter a valid Titel and Text with exactly the maximum allowed characters | Fields accept the input without truncation |
| 3 | 3. Click on 'Speichern' | Save action completes without validation errors |

**Final Expected Result:** Schnellantwort is saved and appears in the list

---

### TC-819: Boundary: Prevent saving when title exceeds maximum length

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-098
**Requirement:** WA-BUS-003

**Description:** Ensure validation prevents saving when title exceeds allowed length

**Preconditions:**
- Business-Admin is logged in
- Business-Admin has access to message management
- Maximum title length is defined

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the Schnellantwort create form | Create Schnellantwort form is displayed |
| 2 | 2. Enter a Titel exceeding maximum length and valid Text | Form shows length limit feedback or accepts input |
| 3 | 3. Click on 'Speichern' | Validation error is displayed for title length |

**Final Expected Result:** Schnellantwort is not saved due to title length validation

---

### TC-820: Boundary: Prevent saving when text exceeds maximum length

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-098
**Requirement:** WA-BUS-003

**Description:** Ensure validation prevents saving when text exceeds allowed length

**Preconditions:**
- Business-Admin is logged in
- Business-Admin has access to message management
- Maximum text length is defined

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the Schnellantwort create form | Create Schnellantwort form is displayed |
| 2 | 2. Enter a valid Titel and Text exceeding maximum length | Form shows length limit feedback or accepts input |
| 3 | 3. Click on 'Speichern' | Validation error is displayed for text length |

**Final Expected Result:** Schnellantwort is not saved due to text length validation

---

### TC-821: Insert quick response from list after creation

**Type:** integration
**Priority:** high
**Status:** manual
**User Story:** US-098
**Requirement:** WA-BUS-003

**Description:** Verify newly created quick response is immediately available in chat list

**Preconditions:**
- Business-Admin is logged in
- Business-Admin has access to message management
- A new Schnellantwort has just been created

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open a chat with a customer | Chat window and message input field are visible |
| 2 | 2. Open the Schnellantworten list in chat | List of Schnellantworten includes the newly created item |
| 3 | 3. Select the newly created Schnellantwort | Corresponding text is inserted into the message input field |

**Final Expected Result:** New Schnellantwort is selectable and inserts its text into the message field

---

### TC-822: Access control: User without permissions cannot access Schnellantworten management

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-098
**Requirement:** WA-BUS-003

**Description:** Verify user lacking rights cannot access quick response management

**Preconditions:**
- User is logged in
- User does not have access to message management

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Attempt to navigate to Schnellantworten management page | Access is denied or user is redirected |

**Final Expected Result:** User without permissions cannot access Schnellantworten management

---

### TC-823: Activate absence message with valid period and text

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-099
**Requirement:** WA-BUS-004

**Description:** Verify that an active absence message is sent for incoming requests within the configured period.

**Preconditions:**
- Shop-Admin account exists
- Shop-Admin is logged in
- Admin is on Absence Message Settings page
- System time is known and controllable

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Enter a valid absence period (start = now, end = now + 2 days) | Period fields accept input and are displayed correctly |
| 2 | 2. Enter absence message text 'We are away until Monday.' | Text field accepts input |
| 3 | 3. Toggle 'Activate' to ON | Activation state is ON |
| 4 | 4. Click 'Save' | Success confirmation is displayed and settings are persisted |
| 5 | 5. Trigger a new incoming customer request during the configured period | An automatic absence message is sent to the customer |

**Final Expected Result:** Absence message is saved, activated, and automatically sent for requests within the defined period.

---

### TC-824: No absence message after period has ended

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-099
**Requirement:** WA-BUS-004

**Description:** Ensure absence messages stop after the configured end date/time.

**Preconditions:**
- Shop-Admin is logged in
- Admin is on Absence Message Settings page
- Absence message is already configured with end time in the past and set to active

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Verify the configured period end is in the past | Displayed end time is earlier than current system time |
| 2 | 2. Trigger a new incoming customer request | No automatic absence message is sent |

**Final Expected Result:** No absence message is sent for requests after the configured period has ended.

---

### TC-825: Attempt to save without message text

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-099
**Requirement:** WA-BUS-004

**Description:** Validate that message text is required.

**Preconditions:**
- Shop-Admin is logged in
- Admin is on Absence Message Settings page

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Enter a valid period (start = now, end = now + 1 day) | Period fields accept input |
| 2 | 2. Leave message text empty | Text field is empty |
| 3 | 3. Click 'Save' | Validation error is shown for missing text |

**Final Expected Result:** System shows a valid error message and does not save the absence message.

---

### TC-826: Attempt to save with invalid period (end before start)

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-099
**Requirement:** WA-BUS-004

**Description:** Validate that end date must be after start date.

**Preconditions:**
- Shop-Admin is logged in
- Admin is on Absence Message Settings page

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Enter start time = now + 2 days and end time = now + 1 day | Period fields accept input |
| 2 | 2. Enter valid message text | Text field accepts input |
| 3 | 3. Click 'Save' | Validation error is shown for invalid period |

**Final Expected Result:** System shows a valid error message and does not save the absence message.

---

### TC-827: Attempt to save with invalid period (missing start or end)

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-099
**Requirement:** WA-BUS-004

**Description:** Validate required period fields are enforced.

**Preconditions:**
- Shop-Admin is logged in
- Admin is on Absence Message Settings page

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Enter only a start date/time, leave end date/time empty | End field remains empty |
| 2 | 2. Enter valid message text | Text field accepts input |
| 3 | 3. Click 'Save' | Validation error is shown for missing end date/time |

**Final Expected Result:** System shows a valid error message and does not save the absence message.

---

### TC-828: Boundary condition: request at exact start time

**Type:** integration
**Priority:** medium
**Status:** manual
**User Story:** US-099
**Requirement:** WA-BUS-004

**Description:** Ensure message is sent at the exact start boundary.

**Preconditions:**
- Shop-Admin is logged in
- Admin is on Absence Message Settings page
- System time can be synchronized for test

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Configure period start = T and end = T + 1 hour, set active, save | Settings are saved successfully |
| 2 | 2. Trigger a customer request at exact time T | Absence message is sent |

**Final Expected Result:** Absence message is sent for requests at the exact start time.

---

### TC-829: Boundary condition: request at exact end time

**Type:** integration
**Priority:** medium
**Status:** manual
**User Story:** US-099
**Requirement:** WA-BUS-004

**Description:** Ensure message is not sent after the period ends; clarify behavior at exact end time.

**Preconditions:**
- Shop-Admin is logged in
- Admin is on Absence Message Settings page
- System time can be synchronized for test

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Configure period start = T and end = T + 1 hour, set active, save | Settings are saved successfully |
| 2 | 2. Trigger a customer request at exact time T + 1 hour | System applies defined boundary rule (either sends if inclusive or does not send if exclusive) |

**Final Expected Result:** Boundary behavior at exact end time is consistent with system rule and documented.

---

### TC-830: Deactivate absence message and verify no auto-response

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-099
**Requirement:** WA-BUS-004

**Description:** Ensure deactivated messages are not sent even within the period.

**Preconditions:**
- Shop-Admin is logged in
- Admin is on Absence Message Settings page
- Absence message is configured with valid period

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Toggle 'Activate' to OFF | Activation state is OFF |
| 2 | 2. Click 'Save' | Settings are saved successfully |
| 3 | 3. Trigger a new incoming customer request within the configured period | No absence message is sent |

**Final Expected Result:** No automatic absence message is sent when the feature is deactivated.

---

### TC-831: Edit existing message text and verify new text is sent

**Type:** e2e
**Priority:** medium
**Status:** manual
**User Story:** US-099
**Requirement:** WA-BUS-004

**Description:** Ensure updates to the message text are applied to outgoing auto-responses.

**Preconditions:**
- Shop-Admin is logged in
- Admin is on Absence Message Settings page
- Active absence message exists within current period

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Update message text to 'We are out of office until Friday.' | Text field shows updated content |
| 2 | 2. Click 'Save' | Settings are saved successfully |
| 3 | 3. Trigger a new incoming customer request within the period | Absence message with updated text is sent |

**Final Expected Result:** Updated absence message text is sent for new requests.

---

### TC-832: Auto-greeting sent on first contact when configured and profile active

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-100
**Requirement:** WA-BUS-005

**Description:** Verifies that exactly one greeting is automatically sent on first contact for an active business profile with a configured greeting.

**Preconditions:**
- Business profile is active
- Greeting message is configured and enabled
- Customer has no prior contact history with the business profile

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Customer sends a first message to the business profile | Customer message is received by the system |
| 2 | 2. System processes the first-contact event | System triggers auto-greeting workflow |
| 3 | 3. Check messages sent to the customer | Exactly one greeting message is delivered to the customer |

**Final Expected Result:** System delivers exactly one configured greeting message on first contact and marks delivery as successful.

---

### TC-833: No auto-greeting on repeat contact

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-100
**Requirement:** WA-BUS-005

**Description:** Ensures no greeting is sent when the customer has previous contact history.

**Preconditions:**
- Business profile is active
- Greeting message is configured and enabled
- Customer has prior contact history with the business profile

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Customer sends a new message to the business profile | Customer message is received by the system |
| 2 | 2. System checks customer contact history | System identifies customer as returning |
| 3 | 3. Check messages sent to the customer | No greeting message is sent |

**Final Expected Result:** No auto-greeting is delivered to returning customers.

---

### TC-834: No auto-greeting when greeting is not configured

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-100
**Requirement:** WA-BUS-005

**Description:** Validates that no greeting is sent and state is logged when greeting is not configured.

**Preconditions:**
- Business profile is active
- Greeting message is not configured
- Customer has no prior contact history

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Customer sends a first message to the business profile | Customer message is received by the system |
| 2 | 2. System evaluates greeting configuration | System detects greeting is not configured |
| 3 | 3. Check messages sent to the customer | No greeting message is sent |
| 4 | 4. Check system logs or audit trail | State is logged indicating greeting not configured |

**Final Expected Result:** No auto-greeting is sent and the not-configured state is logged.

---

### TC-835: No auto-greeting when greeting is disabled

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-100
**Requirement:** WA-BUS-005

**Description:** Ensures no greeting is sent and state is logged when greeting is disabled.

**Preconditions:**
- Business profile is active
- Greeting message is configured but disabled
- Customer has no prior contact history

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Customer sends a first message to the business profile | Customer message is received by the system |
| 2 | 2. System evaluates greeting configuration | System detects greeting is disabled |
| 3 | 3. Check messages sent to the customer | No greeting message is sent |
| 4 | 4. Check system logs or audit trail | State is logged indicating greeting disabled |

**Final Expected Result:** No auto-greeting is sent and the disabled state is logged.

---

### TC-836: No auto-greeting when business profile is inactive

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-100
**Requirement:** WA-BUS-005

**Description:** Validates that auto-greeting is not sent if the business profile is inactive.

**Preconditions:**
- Business profile is inactive
- Greeting message is configured and enabled
- Customer has no prior contact history

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Customer sends a first message to the business profile | Customer message is received by the system |
| 2 | 2. System checks business profile status | System identifies profile as inactive |
| 3 | 3. Check messages sent to the customer | No greeting message is sent |

**Final Expected Result:** No auto-greeting is sent when the business profile is inactive.

---

### TC-837: Exactly one auto-greeting when multiple first-contact messages are sent rapidly

**Type:** integration
**Priority:** high
**Status:** manual
**User Story:** US-100
**Requirement:** WA-BUS-005

**Description:** Ensures only one greeting is sent under rapid multiple first-contact messages (race condition boundary).

**Preconditions:**
- Business profile is active
- Greeting message is configured and enabled
- Customer has no prior contact history

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Customer sends two messages in rapid succession as first contact | Both customer messages are received by the system |
| 2 | 2. System processes first-contact detection | System identifies first-contact event once |
| 3 | 3. Check messages sent to the customer | Exactly one greeting message is delivered |

**Final Expected Result:** System sends only one greeting despite rapid multiple first-contact messages.

---

### TC-838: Delivery reliability for auto-greeting

**Type:** integration
**Priority:** medium
**Status:** manual
**User Story:** US-100
**Requirement:** WA-BUS-005

**Description:** Verifies that the auto-greeting is delivered reliably and delivery status is recorded.

**Preconditions:**
- Business profile is active
- Greeting message is configured and enabled
- Customer has no prior contact history

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Customer sends a first message to the business profile | Customer message is received by the system |
| 2 | 2. System sends auto-greeting | Greeting is queued for delivery |
| 3 | 3. Verify delivery status in message tracking | Delivery status is marked as successful |

**Final Expected Result:** Auto-greeting is delivered successfully and delivery status is tracked.

---

### TC-839: Configuration change takes effect for new first-contact customers

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-100
**Requirement:** WA-BUS-005

**Description:** Ensures enabling greeting applies to future first-contact customers only.

**Preconditions:**
- Business profile is active
- Greeting message is initially disabled
- Customer A has no prior contact history
- Customer B has no prior contact history

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Customer A sends a first message while greeting is disabled | No greeting is sent to Customer A |
| 2 | 2. Administrator enables the greeting message | Greeting configuration is saved and enabled |
| 3 | 3. Customer B sends a first message after enabling | Exactly one greeting is sent to Customer B |

**Final Expected Result:** Greeting is not sent before enabling and is sent to new first-contact customers after enabling.

---

### TC-840: Returning customer after greeting enabled does not receive greeting

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-100
**Requirement:** WA-BUS-005

**Description:** Confirms that returning customers do not get greetings even if it is enabled later.

**Preconditions:**
- Business profile is active
- Greeting message is disabled initially
- Customer has prior contact history while greeting was disabled

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Administrator enables the greeting message | Greeting configuration is saved and enabled |
| 2 | 2. Returning customer sends a new message | System identifies customer as returning |
| 3 | 3. Check messages sent to the customer | No greeting message is sent |

**Final Expected Result:** Returning customers do not receive auto-greetings even if greeting is enabled later.

---

### TC-841: Logging when greeting disabled for first contact

**Type:** functional
**Priority:** low
**Status:** manual
**User Story:** US-100
**Requirement:** WA-BUS-005

**Description:** Validates that system logs the disabled state when no greeting is sent.

**Preconditions:**
- Business profile is active
- Greeting message is configured but disabled
- Customer has no prior contact history

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Customer sends a first message | Customer message is received by the system |
| 2 | 2. System evaluates greeting configuration | System detects greeting disabled |
| 3 | 3. Inspect audit logs | Log entry indicates greeting disabled for first contact |

**Final Expected Result:** System logs the disabled greeting state for first-contact events.

---

### TC-842: Create and publish catalog with minimum one product

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-101
**Requirement:** WA-BUS-006

**Description:** Verify that a business administrator can create and publish a catalog with at least one product and it is visible to customers with correct details.

**Preconditions:**
- Business-Administrator is authenticated
- User has catalog management permission

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to Catalog Management page | Catalog Management page loads with create option |
| 2 | 2. Click on 'Create New Catalog' | New catalog form is displayed |
| 3 | 3. Enter catalog name and add one product with name, price, and availability | Product is listed in the catalog form with entered details |
| 4 | 4. Click 'Publish' to publish the catalog | Catalog status changes to Published and confirmation is shown |
| 5 | 5. Open customer-facing catalog view | Published catalog is visible with product name, price, and availability correctly displayed |

**Final Expected Result:** A published catalog with at least one product is visible to customers with correct details.

---

### TC-843: Create catalog with multiple products

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-101
**Requirement:** WA-BUS-006

**Description:** Verify that a catalog can be created with multiple products and all products are visible.

**Preconditions:**
- Business-Administrator is authenticated
- User has catalog management permission

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to Catalog Management page | Catalog Management page loads |
| 2 | 2. Click 'Create New Catalog' | New catalog form is displayed |
| 3 | 3. Add three products with valid name, price, and availability | All three products appear in the catalog form |
| 4 | 4. Publish the catalog | Catalog is published successfully |
| 5 | 5. View catalog as a customer | All three products are listed with correct name, price, and availability |

**Final Expected Result:** Published catalog shows all added products with accurate details.

---

### TC-844: Update product details in existing catalog

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-101
**Requirement:** WA-BUS-006

**Description:** Verify updates to a product are immediately visible in the catalog.

**Preconditions:**
- Business-Administrator is authenticated
- User has catalog management permission
- An existing published catalog with at least one product is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open existing catalog in Catalog Management | Catalog details and product list are displayed |
| 2 | 2. Select a product and update its price and availability | Changes are accepted in edit form |
| 3 | 3. Save the changes | Success message is shown and updated values are displayed in the admin list |
| 4 | 4. View catalog as a customer | Updated product price and availability are immediately visible |

**Final Expected Result:** Product updates are saved and visible to customers without delay.

---

### TC-845: Remove a product from existing catalog

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-101
**Requirement:** WA-BUS-006

**Description:** Verify that removing a product updates the catalog and keeps the list consistent.

**Preconditions:**
- Business-Administrator is authenticated
- User has catalog management permission
- An existing published catalog with at least two products is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open existing catalog in Catalog Management | Catalog details and product list are displayed |
| 2 | 2. Remove one product from the catalog | Product is removed from the list in the admin view |
| 3 | 3. Save changes | Catalog update is confirmed |
| 4 | 4. View catalog as a customer | Removed product no longer appears; remaining products are listed consistently |

**Final Expected Result:** Removed product is no longer visible and catalog remains consistent.

---

### TC-846: Attempt to save product without name

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-101
**Requirement:** WA-BUS-006

**Description:** Verify validation prevents saving a product without a name.

**Preconditions:**
- Business-Administrator is authenticated
- User has catalog management permission

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to create or edit product form | Product form is displayed |
| 2 | 2. Leave product name empty and enter valid price and availability | Form accepts input but name is blank |
| 3 | 3. Click 'Save' | Validation error message for missing name is displayed |

**Final Expected Result:** Product is not saved and a clear error message is shown for missing name.

---

### TC-847: Attempt to save product without price

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-101
**Requirement:** WA-BUS-006

**Description:** Verify validation prevents saving a product without a price.

**Preconditions:**
- Business-Administrator is authenticated
- User has catalog management permission

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to create or edit product form | Product form is displayed |
| 2 | 2. Enter product name but leave price empty | Form accepts input but price is blank |
| 3 | 3. Click 'Save' | Validation error message for missing price is displayed |

**Final Expected Result:** Product is not saved and a clear error message is shown for missing price.

---

### TC-848: Boundary test for price format and zero value

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-101
**Requirement:** WA-BUS-006

**Description:** Verify price validation handles invalid formats and zero value.

**Preconditions:**
- Business-Administrator is authenticated
- User has catalog management permission

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open product form | Product form is displayed |
| 2 | 2. Enter valid name and set price to 0 | Form accepts input |
| 3 | 3. Click 'Save' | System shows validation error if price must be > 0 or saves if 0 is allowed by business rules |
| 4 | 4. Enter invalid price format (e.g., letters) and click 'Save' | Validation error for invalid price format is displayed |

**Final Expected Result:** Price validation enforces business rules and blocks invalid format.

---

### TC-849: Prevent publishing catalog with zero products

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-101
**Requirement:** WA-BUS-006

**Description:** Verify catalog cannot be published without at least one product.

**Preconditions:**
- Business-Administrator is authenticated
- User has catalog management permission

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to create new catalog | New catalog form is displayed |
| 2 | 2. Enter catalog name but do not add any products | Catalog has zero products |
| 3 | 3. Click 'Publish' | Error message indicates at least one product is required |

**Final Expected Result:** Catalog is not published and validation message is shown.

---

### TC-850: Visibility check: unpublished catalog not visible to customers

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-101
**Requirement:** WA-BUS-006

**Description:** Verify unpublished catalogs are not visible to customers.

**Preconditions:**
- Business-Administrator is authenticated
- User has catalog management permission
- A catalog exists in Draft state with at least one product

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Ensure catalog is in Draft state | Catalog status shows Draft |
| 2 | 2. Open customer-facing catalog view | Draft catalog is not listed or accessible |

**Final Expected Result:** Unpublished catalogs are not visible to customers.

---

### TC-851: Permission check for catalog management

**Type:** integration
**Priority:** high
**Status:** manual
**User Story:** US-101
**Requirement:** WA-BUS-006

**Description:** Verify users without catalog management permission cannot create or edit catalogs.

**Preconditions:**
- User is authenticated without catalog management permission

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to Catalog Management page | Access is denied or page is not accessible |
| 2 | 2. Attempt to access create catalog URL directly | System prevents access and shows permission error |

**Final Expected Result:** Unauthorized users cannot access catalog management features.

---

### TC-852: Add single item to cart shows correct quantity and price

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-102
**Requirement:** WA-BUS-007

**Description:** Verify that adding one product displays correct quantity and unit price in cart

**Preconditions:**
- User is logged in
- Shop is available
- Product exists with known price

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open product detail page for the product | Product detail page loads with price displayed |
| 2 | 2. Click 'Add to cart' | Cart icon updates to show 1 item |
| 3 | 3. Open cart page | Cart displays the added product with quantity 1 and correct unit price |

**Final Expected Result:** Item appears in cart with correct quantity and price

---

### TC-853: Add multiple quantities of same item updates quantity and totals

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-102
**Requirement:** WA-BUS-007

**Description:** Verify cart shows correct quantity and subtotal when adding same item multiple times

**Preconditions:**
- User is logged in
- Shop is available
- Product exists with known price

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open product detail page for the product | Product detail page loads with price displayed |
| 2 | 2. Click 'Add to cart' three times | Cart icon updates to show 3 items for the product |
| 3 | 3. Open cart page | Cart shows quantity 3 with unit price and subtotal = unit price x 3 |

**Final Expected Result:** Cart quantity and subtotal reflect 3 units of the product

---

### TC-854: Change item quantity updates subtotal and total immediately

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-102
**Requirement:** WA-BUS-007

**Description:** Verify that changing quantity recalculates subtotal and total in real time

**Preconditions:**
- User is logged in
- Shop is available
- Cart contains at least one item

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open cart page | Cart displays items with current quantities and totals |
| 2 | 2. Increase quantity of an item from 1 to 2 | Item subtotal updates to unit price x 2 immediately |
| 3 | 3. Observe cart total | Total reflects updated subtotal without page refresh |

**Final Expected Result:** Subtotal and total are updated immediately after quantity change

---

### TC-855: Decrease item quantity to minimum boundary

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-102
**Requirement:** WA-BUS-007

**Description:** Verify boundary behavior when quantity is set to minimum allowed value

**Preconditions:**
- User is logged in
- Shop is available
- Cart contains an item with quantity 2

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open cart page | Cart displays item with quantity 2 |
| 2 | 2. Decrease quantity to 1 | Quantity updates to 1 and subtotal recalculates |

**Final Expected Result:** Quantity cannot go below 1 and totals update correctly

---

### TC-856: Remove item from cart updates totals

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-102
**Requirement:** WA-BUS-007

**Description:** Verify removing an item updates subtotal and total immediately

**Preconditions:**
- User is logged in
- Shop is available
- Cart contains at least two items

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open cart page | Cart displays multiple items with totals |
| 2 | 2. Click 'Remove' on one item | Item is removed from cart list |
| 3 | 3. Observe subtotal and total | Totals update immediately to exclude removed item |

**Final Expected Result:** Removed item is no longer in cart and totals are recalculated

---

### TC-857: Attempt to add item when shop/backend is unavailable

**Type:** integration
**Priority:** high
**Status:** manual
**User Story:** US-102
**Requirement:** WA-BUS-007

**Description:** Verify error handling and cart integrity when backend is down

**Preconditions:**
- User is logged in
- Shop or backend is unavailable
- Product exists

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open product detail page for the product | Product page may load from cache or show limited data |
| 2 | 2. Click 'Add to cart' | User receives a clear error message indicating temporary unavailability |
| 3 | 3. Open cart page | Cart contents remain unchanged |

**Final Expected Result:** Error message is shown and cart remains unchanged

---

### TC-858: Add item with invalid quantity input

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-102
**Requirement:** WA-BUS-007

**Description:** Verify invalid quantity input is rejected and no incorrect update occurs

**Preconditions:**
- User is logged in
- Shop is available
- Cart contains an item

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open cart page | Cart displays item with quantity field |
| 2 | 2. Enter quantity 0 or a negative number in quantity field | Validation error is displayed or value resets to minimum allowed |
| 3 | 3. Observe totals | Totals do not reflect invalid quantity |

**Final Expected Result:** Invalid quantity is not accepted and totals remain correct

---

### TC-859: Cart remains correct after page refresh

**Type:** e2e
**Priority:** medium
**Status:** manual
**User Story:** US-102
**Requirement:** WA-BUS-007

**Description:** Verify cart state persists after refresh and totals remain accurate

**Preconditions:**
- User is logged in
- Shop is available
- Cart contains items

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open cart page and note quantities and totals | Cart shows current items and totals |
| 2 | 2. Refresh the page | Cart reloads successfully |
| 3 | 3. Compare quantities and totals to previous state | Items, quantities, and totals remain unchanged |

**Final Expected Result:** Cart state and totals persist after refresh

---

### TC-860: Concurrent update: modify quantity while backend responds slowly

**Type:** performance
**Priority:** low
**Status:** manual
**User Story:** US-102
**Requirement:** WA-BUS-007

**Description:** Verify totals update correctly when backend response is delayed

**Preconditions:**
- User is logged in
- Shop is available
- Network latency simulated
- Cart contains an item

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open cart page | Cart displays item with quantity field |
| 2 | 2. Increase quantity by 1 under simulated latency | UI indicates processing and eventually updates quantity |
| 3 | 3. Observe subtotal and total after update | Totals are correct and no duplicate updates occur |

**Final Expected Result:** Cart updates correctly despite delayed backend response

---

### TC-861: Successful WhatsApp Pay payment in supported market

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-103
**Requirement:** WA-BUS-008

**Description:** Verify payment is processed successfully when user is in a supported market with a saved payment method

**Preconditions:**
- User is logged in
- User is in a supported market
- User has at least one valid payment method saved
- Payment service is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to a payment-eligible screen in the app | WhatsApp Pay option is visible and enabled |
| 2 | 2. Select WhatsApp Pay and enter a valid amount within allowed limits | Amount is accepted and confirm button is enabled |
| 3 | 3. Tap the confirm payment button | Payment is submitted to the backend without errors |
| 4 | 4. Wait for the transaction response | Success confirmation is displayed to the user |

**Final Expected Result:** Payment is processed successfully and the user receives a confirmation

---

### TC-862: WhatsApp Pay disabled in unsupported market

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-103
**Requirement:** WA-BUS-008

**Description:** Verify payment feature is disabled and availability message is shown in unsupported markets

**Preconditions:**
- User is logged in
- User is in an unsupported market

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to a payment-eligible screen in the app | WhatsApp Pay option is visible but disabled |
| 2 | 2. Attempt to select WhatsApp Pay | Selection is blocked and a non-availability message is shown |

**Final Expected Result:** Payment function is disabled and user receives a notice of unavailability

---

### TC-863: Payment attempt when payment service is temporarily unavailable

**Type:** integration
**Priority:** high
**Status:** manual
**User Story:** US-103
**Requirement:** WA-BUS-008

**Description:** Verify error handling when payment processing is down

**Preconditions:**
- User is logged in
- User is in a supported market
- User has a valid payment method saved
- Payment service is temporarily unavailable

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to a payment-eligible screen and select WhatsApp Pay | WhatsApp Pay option is visible and enabled |
| 2 | 2. Enter a valid amount and tap confirm payment | Request is sent and a temporary unavailability error is returned |
| 3 | 3. Observe the UI response | Error message is displayed and no success confirmation is shown |

**Final Expected Result:** A clear error message is displayed and the payment is not executed

---

### TC-864: Attempt payment in supported market without saved payment method

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-103
**Requirement:** WA-BUS-008

**Description:** Verify user is prompted to add a payment method when none exists

**Preconditions:**
- User is logged in
- User is in a supported market
- User has no saved payment methods
- Payment service is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to a payment-eligible screen and select WhatsApp Pay | Prompt to add a payment method is shown |
| 2 | 2. Attempt to proceed without adding a payment method | Payment confirmation is disabled and user cannot proceed |

**Final Expected Result:** User cannot submit payment and is instructed to add a payment method

---

### TC-865: Boundary test: minimum allowed payment amount

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-103
**Requirement:** WA-BUS-008

**Description:** Verify payment succeeds with the minimum allowed amount

**Preconditions:**
- User is logged in
- User is in a supported market
- User has a valid payment method saved
- Payment service is available
- Minimum amount is configured

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to WhatsApp Pay and enter the minimum allowed amount | Amount is accepted and confirm button is enabled |
| 2 | 2. Confirm the payment | Payment is processed successfully |

**Final Expected Result:** Payment succeeds with the minimum allowed amount

---

### TC-866: Boundary test: below minimum payment amount

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-103
**Requirement:** WA-BUS-008

**Description:** Verify payment is blocked when amount is below the minimum allowed

**Preconditions:**
- User is logged in
- User is in a supported market
- User has a valid payment method saved
- Payment service is available
- Minimum amount is configured

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigate to WhatsApp Pay and enter an amount below the minimum allowed | Validation error is displayed |
| 2 | 2. Attempt to confirm payment | Confirm button remains disabled or submission is blocked |

**Final Expected Result:** Payment cannot be submitted with an amount below the minimum

---

### TC-867: Verify confirmation details after successful payment

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-103
**Requirement:** WA-BUS-008

**Description:** Ensure confirmation contains required information after a successful transaction

**Preconditions:**
- User is logged in
- User is in a supported market
- User has a valid payment method saved
- Payment service is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Complete a successful WhatsApp Pay payment | Success confirmation screen is shown |
| 2 | 2. Review confirmation details | Confirmation includes amount, timestamp, and transaction reference |

**Final Expected Result:** Confirmation shows correct transaction details

---

### TC-868: Display basic message statistics for a valid period

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-104
**Requirement:** WA-BUS-009

**Description:** Verify that sent, delivered, and read message counts are shown for a selected period with data

**Preconditions:**
- Business-Admin account exists and is logged in
- There are messages with sent/delivered/read statuses within the selected period

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the Business Dashboard | Dashboard loads successfully |
| 2 | 2. Navigate to the statistics section | Statistics section is displayed |
| 3 | 3. Select a period that contains message activity | The selected period is applied |
| 4 | 4. Load statistics | Statistics are displayed for the selected period |

**Final Expected Result:** Sent, delivered, and read message counts are shown correctly for the selected period

---

### TC-869: Zero activity period shows neutral 0 values

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-104
**Requirement:** WA-BUS-009

**Description:** Verify that selecting a period without message activity shows 0 values and a neutral no-data message

**Preconditions:**
- Business-Admin account exists and is logged in
- No messages exist in the selected period

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the Business Dashboard | Dashboard loads successfully |
| 2 | 2. Navigate to the statistics section | Statistics section is displayed |
| 3 | 3. Select a period with no message activity | The selected period is applied |
| 4 | 4. Load statistics | Statistics panel updates |

**Final Expected Result:** All displayed metrics show 0 and a neutral message indicates no data is available

---

### TC-870: Statistics data source unreachable shows error and retry

**Type:** integration
**Priority:** high
**Status:** manual
**User Story:** US-104
**Requirement:** WA-BUS-009

**Description:** Verify that an error message and retry option appear when the data source is unavailable

**Preconditions:**
- Business-Admin account exists and is logged in
- Statistics data source is unreachable or returns an error

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the Business Dashboard | Dashboard loads successfully |
| 2 | 2. Navigate to the statistics section | Statistics section is displayed |
| 3 | 3. Attempt to load statistics | A user-friendly error message is shown and a retry option is visible |

**Final Expected Result:** System displays a clear error message and provides a retry action

---

### TC-871: Retry after data source recovery loads statistics

**Type:** integration
**Priority:** high
**Status:** manual
**User Story:** US-104
**Requirement:** WA-BUS-009

**Description:** Verify that retry succeeds after the data source becomes available

**Preconditions:**
- Business-Admin account exists and is logged in
- Statistics data source initially unreachable then restored

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the statistics section while data source is unreachable | Error message and retry option are shown |
| 2 | 2. Restore data source availability | Data source is reachable |
| 3 | 3. Click the retry action | Statistics are reloaded |

**Final Expected Result:** Statistics load successfully after retry without requiring page reload

---

### TC-872: Boundary: Single-day period with activity

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-104
**Requirement:** WA-BUS-009

**Description:** Verify that selecting a single-day period displays correct counts

**Preconditions:**
- Business-Admin account exists and is logged in
- Messages exist only on a specific day

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the statistics section | Statistics section is displayed |
| 2 | 2. Select a period spanning a single day with activity | Single-day period is applied |
| 3 | 3. Load statistics | Statistics update for the selected day |

**Final Expected Result:** Counts reflect only the messages from the selected day

---

### TC-873: Boundary: Large period range with high volume

**Type:** performance
**Priority:** medium
**Status:** manual
**User Story:** US-104
**Requirement:** WA-BUS-009

**Description:** Verify that statistics load and display correctly for a large date range with many messages

**Preconditions:**
- Business-Admin account exists and is logged in
- High volume of messages exists over a large date range

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the statistics section | Statistics section is displayed |
| 2 | 2. Select the maximum supported period range | Maximum range is applied |
| 3 | 3. Load statistics | Statistics load without errors within acceptable time |

**Final Expected Result:** Statistics display accurate counts and load within acceptable performance thresholds

---

### TC-874: Data consistency: Delivered cannot exceed Sent

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-104
**Requirement:** WA-BUS-009

**Description:** Verify basic data consistency rules in displayed statistics

**Preconditions:**
- Business-Admin account exists and is logged in
- Messages with various statuses exist in the selected period

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the statistics section | Statistics section is displayed |
| 2 | 2. Select a period with message activity | Selected period is applied |
| 3 | 3. Load statistics | Statistics are displayed |

**Final Expected Result:** Displayed delivered and read counts do not exceed sent count

---

### TC-875: Authorization: Non-admin user cannot access statistics

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-104
**Requirement:** WA-BUS-009

**Description:** Verify access control prevents non-admin users from viewing business statistics

**Preconditions:**
- Non-admin user account exists and is logged in

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Attempt to open the Business Dashboard statistics section | Access is denied or statistics section is not visible |

**Final Expected Result:** Non-admin users are prevented from accessing business statistics

---

### TC-876: Authorized request returns expected response within performance limits

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-105
**Requirement:** WA-BUS-010

**Description:** Verify that a valid API request with valid credentials returns correct data, status code, and response time within defined limits

**Preconditions:**
- Valid API credentials are issued to the integration partner
- Documented API endpoint is available
- Performance threshold is defined

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Send an API request to a documented endpoint with valid credentials and valid request payload | API responds with expected data structure and correct status code (e.g., 200 OK) |
| 2 | 2. Measure response time | Response time is within the defined performance limits |

**Final Expected Result:** Authorized request succeeds with correct response and within performance limits

---

### TC-877: Missing credentials return unauthorized error

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-105
**Requirement:** WA-BUS-010

**Description:** Verify that API requests without credentials are rejected with appropriate error status and message

**Preconditions:**
- Documented API endpoint is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Send an API request to a documented endpoint without any authentication headers or credentials | API responds with an appropriate error status (e.g., 401 Unauthorized) |
| 2 | 2. Inspect the error payload | Error message clearly indicates missing credentials |

**Final Expected Result:** Request is rejected with proper status and clear error message

---

### TC-878: Invalid credentials return unauthorized/forbidden error

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-105
**Requirement:** WA-BUS-010

**Description:** Verify that API requests with invalid credentials are rejected with appropriate error status and message

**Preconditions:**
- Documented API endpoint is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Send an API request to a documented endpoint with invalid credentials | API responds with an appropriate error status (e.g., 401 Unauthorized or 403 Forbidden) |
| 2 | 2. Inspect the error payload | Error message clearly indicates invalid credentials |

**Final Expected Result:** Request is rejected with proper status and clear error message

---

### TC-879: Rate limit exceeded returns rate-limit error with retry information

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-105
**Requirement:** WA-BUS-010

**Description:** Verify that exceeding the defined rate limit results in a rate-limit error and retry guidance

**Preconditions:**
- Valid API credentials are issued to the integration partner
- Rate limit policy is defined and enforced

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Send API requests with valid credentials up to the rate limit | Requests within the limit succeed with correct status codes |
| 2 | 2. Send one additional request exceeding the limit | API responds with rate-limit error status (e.g., 429 Too Many Requests) |
| 3 | 3. Inspect rate-limit response headers or body | Response includes retry information (e.g., Retry-After header or equivalent) |

**Final Expected Result:** Requests beyond the limit are rejected with rate-limit status and retry guidance

---

### TC-880: Boundary test at exact rate limit

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-105
**Requirement:** WA-BUS-010

**Description:** Verify that the last request within the allowed rate limit is accepted

**Preconditions:**
- Valid API credentials are issued to the integration partner
- Rate limit policy is defined and enforced

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Send API requests with valid credentials to reach exactly the rate limit threshold | The last request at the threshold succeeds with correct status code |

**Final Expected Result:** Exact-limit request is accepted and processed successfully

---

### TC-881: Unauthorized request to documented endpoint returns consistent error format

**Type:** integration
**Priority:** medium
**Status:** manual
**User Story:** US-105
**Requirement:** WA-BUS-010

**Description:** Verify that error responses are consistent and understandable for unauthorized access

**Preconditions:**
- Documented API endpoint is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Send an API request with missing credentials | API responds with an error payload in the documented format |
| 2 | 2. Validate required error fields (e.g., error code, message) | Error response includes all required fields and a human-readable message |

**Final Expected Result:** Unauthorized error response is consistent and understandable

---

### TC-882: Performance under normal authorized load

**Type:** performance
**Priority:** high
**Status:** manual
**User Story:** US-105
**Requirement:** WA-BUS-010

**Description:** Verify API response time under expected authorized load

**Preconditions:**
- Valid API credentials are issued to the integration partner
- Performance threshold is defined
- Load testing environment is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Execute a load test with authorized requests at expected normal load levels | System remains stable and responses are successful |
| 2 | 2. Measure response times across the test duration | Response times stay within defined performance limits |

**Final Expected Result:** API meets performance requirements under normal authorized load

---

### TC-883: Rate-limit recovery after retry time

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-105
**Requirement:** WA-BUS-010

**Description:** Verify that requests succeed after waiting for the retry period specified by the rate-limit response

**Preconditions:**
- Valid API credentials are issued to the integration partner
- Rate limit policy is defined and enforced

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Exceed the rate limit to trigger a 429 response with retry information | API returns 429 with retry guidance |
| 2 | 2. Wait for the specified retry period | Retry period elapses without additional requests |
| 3 | 3. Send a new API request with valid credentials | Request succeeds with correct status code (e.g., 200 OK) |

**Final Expected Result:** API accepts requests after the retry period as indicated by rate-limit information

---

### TC-884: SR-Navigation: Hauptnavigation liest Rollen/Labels korrekt vor

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-106
**Requirement:** WA-ACC-001

**Description:** Verifiziert, dass Screenreader alle interaktiven Elemente in der Hauptnavigation mit korrekten Rollen, Zuständen und Beschriftungen vorliest.

**Preconditions:**
- Anwendung ist geladen
- Screenreader ist aktiv
- Nutzer befindet sich auf der Startseite

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Setze Fokus auf den ersten Navigationspunkt per Tastatur (Tab). | Screenreader liest die Rolle (z. B. Link/Schaltfläche), Beschriftung und aktuellen Zustand (z. B. ausgewählt) korrekt vor. |
| 2 | 2. Navigiere mit Tab durch alle Hauptnavigationspunkte. | Jedes interaktive Element wird mit korrekter Rolle, Beschriftung und Zustand vorgelesen. |
| 3 | 3. Aktiviere einen Navigationspunkt mit Enter. | Navigation erfolgt, Screenreader bestätigt den neuen Kontext (z. B. Seitenüberschrift). |

**Final Expected Result:** Alle Elemente der Hauptnavigation werden mit korrekten Rollen, Zuständen und Labels vorgelesen.

---

### TC-885: SR-Zentrale Funktionen: Buttons und Toggles korrekt angekündigt

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-106
**Requirement:** WA-ACC-001

**Description:** Prüft, dass zentrale Funktionen (z. B. Haupt-CTA, Toggle) korrekt durch den Screenreader angekündigt werden.

**Preconditions:**
- Anwendung ist geladen
- Screenreader ist aktiv
- Nutzer befindet sich auf einer Seite mit zentralen Funktionen

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigiere per Tab zu einem primären Button (CTA). | Screenreader liest die korrekte Beschriftung und Rolle (Button). |
| 2 | 2. Aktiviere einen Toggle/Switch per Leertaste. | Screenreader kündigt die Zustandsänderung (ein/aus) korrekt an. |
| 3 | 3. Navigiere zum nächsten interaktiven Element. | Fokusreihenfolge ist logisch und der Screenreader liest das Element korrekt vor. |

**Final Expected Result:** Zentrale Funktionen werden vom Screenreader korrekt mit Rollen, Labels und Zustandsänderungen angekündigt.

---

### TC-886: Negative: Fehlende ARIA-Labels in Navigation

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-106
**Requirement:** WA-ACC-001

**Description:** Stellt sicher, dass Elemente ohne Label als Fehler erkannt werden und nicht unverständlich vorgelesen werden.

**Preconditions:**
- Anwendung ist geladen
- Screenreader ist aktiv
- Ein Navigations-Icon ohne Label ist vorhanden (Testumgebung)

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigiere per Tab auf das Icon ohne Label. | Screenreader liest kein verständliches Label oder nur generische Information vor. |
| 2 | 2. Erfasse die Ausgabe des Screenreaders. | Unzureichende Beschriftung wird als Defekt identifiziert. |

**Final Expected Result:** Test weist fehlende Labels nach und markiert dies als Barrierefreiheitsdefekt.

---

### TC-887: ARIA-Live: Neue Nachrichten in dynamischer Liste werden angekündigt

**Type:** integration
**Priority:** high
**Status:** manual
**User Story:** US-106
**Requirement:** WA-ACC-001

**Description:** Verifiziert, dass neue Inhalte in einer Nachrichtenliste per ARIA-Live angekündigt werden, ohne Fokusverschiebung.

**Preconditions:**
- Anwendung ist geladen
- Screenreader ist aktiv
- Nachrichtenliste mit ARIA-Live Region ist sichtbar

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Setze Fokus auf ein anderes Element außerhalb der Liste. | Fokus bleibt stabil auf dem Element. |
| 2 | 2. Trigger neue Nachricht (z. B. per Test-Event). | Screenreader kündigt die neue Nachricht an. |
| 3 | 3. Prüfe die Fokusposition nach der Ankündigung. | Fokus bleibt unverändert auf dem ursprünglichen Element. |

**Final Expected Result:** Neue Inhalte werden über ARIA-Live angekündigt, ohne den Fokus zu verschieben.

---

### TC-888: ARIA-Live: Statusmeldung aktualisiert sich ohne Fokusverlust

**Type:** integration
**Priority:** medium
**Status:** manual
**User Story:** US-106
**Requirement:** WA-ACC-001

**Description:** Prüft, dass Statusmeldungen (z. B. Upload-Fortschritt) per ARIA-Live angekündigt werden, ohne Fokuswechsel.

**Preconditions:**
- Anwendung ist geladen
- Screenreader ist aktiv
- Statusmeldungsbereich mit ARIA-Live ist vorhanden

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Starte eine Aktion, die Statusmeldungen erzeugt (z. B. Upload). | Screenreader kündigt den initialen Status an. |
| 2 | 2. Warte auf Statusänderung (z. B. 50% abgeschlossen). | Screenreader kündigt die Statusänderung an. |
| 3 | 3. Überprüfe, dass der Fokus auf dem aktiven Steuerelement bleibt. | Kein Fokusverlust oder unerwartete Fokusverschiebung. |

**Final Expected Result:** Statusänderungen werden korrekt angekündigt, ohne Fokusverschiebung.

---

### TC-889: Negative: Dynamische Inhalte ohne ARIA-Live werden nicht angekündigt

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-106
**Requirement:** WA-ACC-001

**Description:** Stellt sicher, dass fehlende ARIA-Live-Konfiguration erkannt wird, wenn Inhalte nicht angekündigt werden.

**Preconditions:**
- Anwendung ist geladen
- Screenreader ist aktiv
- Dynamische Ansicht ohne ARIA-Live (Testumgebung)

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Trigger eine Inhaltserweiterung in der dynamischen Ansicht. | Inhalt ändert sich sichtbar. |
| 2 | 2. Lausche auf Screenreader-Ausgabe nach Änderung. | Keine oder unzureichende Ankündigung erfolgt. |

**Final Expected Result:** Fehlende ARIA-Live-Konfiguration wird als Defekt identifiziert.

---

### TC-890: Formular: Pflichtfeld leer lassen – Fehlermeldung wird vorgelesen und Fokus gesetzt

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-106
**Requirement:** WA-ACC-001

**Description:** Verifiziert, dass bei leerem Pflichtfeld die Fehlermeldung vorgelesen und der Fokus auf das Feld gesetzt wird.

**Preconditions:**
- Anwendung ist geladen
- Screenreader ist aktiv
- Formular mit Pflichtfeldern ist sichtbar

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Lasse ein Pflichtfeld leer und fülle andere Felder aus. | Formular ist bereit zum Absenden. |
| 2 | 2. Klicke auf Absenden. | Fehlermeldung erscheint für das Pflichtfeld. |
| 3 | 3. Prüfe Screenreader-Ausgabe und Fokusposition. | Screenreader liest die Fehlermeldung vor und Fokus springt auf das fehlerhafte Feld. |

**Final Expected Result:** Fehlermeldung wird vorgelesen und Fokus korrekt gesetzt.

---

### TC-891: Formular: Mehrere Pflichtfelder leer – erstes fehlerhaftes Feld fokussiert

**Type:** e2e
**Priority:** medium
**Status:** manual
**User Story:** US-106
**Requirement:** WA-ACC-001

**Description:** Überprüft Fokuslogik bei mehreren leeren Pflichtfeldern.

**Preconditions:**
- Anwendung ist geladen
- Screenreader ist aktiv
- Formular mit mehreren Pflichtfeldern ist sichtbar

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Lasse mehrere Pflichtfelder leer. | Formular kann abgesendet werden. |
| 2 | 2. Klicke auf Absenden. | Mehrere Fehlermeldungen erscheinen. |
| 3 | 3. Prüfe den Fokus nach der Validierung. | Fokus springt auf das erste fehlerhafte Feld in der Tab-Reihenfolge. |
| 4 | 4. Prüfe Screenreader-Ausgabe. | Screenreader liest die Fehlermeldung des fokussierten Feldes vor. |

**Final Expected Result:** Fokus und Screenreader-Ausgabe verweisen korrekt auf das erste fehlerhafte Feld.

---

### TC-892: Positive: Pflichtfeld korrekt ausgefüllt – keine Fehlermeldung

**Type:** functional
**Priority:** low
**Status:** manual
**User Story:** US-106
**Requirement:** WA-ACC-001

**Description:** Stellt sicher, dass bei korrekter Eingabe keine Fehlermeldung vorgelesen wird.

**Preconditions:**
- Anwendung ist geladen
- Screenreader ist aktiv
- Formular mit Pflichtfeldern ist sichtbar

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Fülle alle Pflichtfelder korrekt aus. | Formular ist valid. |
| 2 | 2. Klicke auf Absenden. | Formular wird erfolgreich verarbeitet. |
| 3 | 3. Prüfe Screenreader-Ausgabe. | Keine Fehlermeldungen werden vorgelesen. |

**Final Expected Result:** Formular wird ohne Fehlermeldungen erfolgreich gesendet.

---

### TC-893: Boundary: Sehr lange Label-Texte werden vollständig vorgelesen

**Type:** functional
**Priority:** low
**Status:** manual
**User Story:** US-106
**Requirement:** WA-ACC-001

**Description:** Testet, dass lange Beschriftungen von Elementen vollständig vorgelesen werden.

**Preconditions:**
- Anwendung ist geladen
- Screenreader ist aktiv
- Ein Element mit sehr langer Beschriftung ist vorhanden

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigiere per Tab zum Element mit sehr langem Label. | Fokus liegt auf dem Element. |
| 2 | 2. Lausche auf die Screenreader-Ausgabe. | Das vollständige Label wird vorgelesen ohne unerwartete Abbrüche. |

**Final Expected Result:** Lange Labels werden korrekt und vollständig vorgelesen.

---

### TC-894: Apply larger font size and update all text areas immediately

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-107
**Requirement:** WA-ACC-002

**Description:** Verify that selecting a larger font size updates all text areas instantly

**Preconditions:**
- User is logged in
- User is on the application settings page
- Default font size is applied

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the font size selection control | Font size options are displayed |
| 2 | 2. Select a larger font size option | Selection is accepted without errors |
| 3 | 3. Observe text areas across the application UI (e.g., headers, body text, buttons, labels) | All text areas immediately render with the selected larger font size |

**Final Expected Result:** All application text areas update instantly to the selected larger font size

---

### TC-895: Apply smaller font size and update all text areas immediately

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-107
**Requirement:** WA-ACC-002

**Description:** Verify that selecting a smaller font size updates all text areas instantly

**Preconditions:**
- User is logged in
- User is on the application settings page
- Default font size is applied

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the font size selection control | Font size options are displayed |
| 2 | 2. Select a smaller font size option | Selection is accepted without errors |
| 3 | 3. Observe text areas across the application UI (e.g., headers, body text, buttons, labels) | All text areas immediately render with the selected smaller font size |

**Final Expected Result:** All application text areas update instantly to the selected smaller font size

---

### TC-896: Persist selected font size after application restart

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-107
**Requirement:** WA-ACC-002

**Description:** Verify that chosen font size is retained after restarting the application

**Preconditions:**
- User is logged in
- User has selected a non-default font size
- Application is running

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Close the application completely | Application is closed |
| 2 | 2. Restart the application | Application loads successfully |
| 3 | 3. Navigate to a screen with multiple text areas | Screen loads without errors |
| 4 | 4. Check font size in text areas | Text areas display the previously selected font size |

**Final Expected Result:** Previously selected font size persists after application restart

---

### TC-897: Persist selected font size after page reload

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-107
**Requirement:** WA-ACC-002

**Description:** Verify that chosen font size is retained after reloading the page

**Preconditions:**
- User is logged in
- User has selected a non-default font size
- Application is open in a browser

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Reload the page | Page reloads successfully |
| 2 | 2. Observe font sizes in multiple text areas | Text areas display the previously selected font size |

**Final Expected Result:** Previously selected font size persists after page reload

---

### TC-898: Select minimum allowed font size without layout issues

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-107
**Requirement:** WA-ACC-002

**Description:** Verify boundary condition for minimum font size and check for layout integrity

**Preconditions:**
- User is logged in
- User is on the application settings page

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the font size selection control | Font size options are displayed |
| 2 | 2. Select the smallest available font size | Selection is accepted without errors |
| 3 | 3. Confirm or apply the selection | Font size is set to the minimum allowed value |
| 4 | 4. Navigate through key screens (e.g., dashboard, forms, dialogs) | No layout breakages or overlapping text are observed |

**Final Expected Result:** Minimum font size is applied and layout remains intact

---

### TC-899: Select maximum allowed font size without layout issues

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-107
**Requirement:** WA-ACC-002

**Description:** Verify boundary condition for maximum font size and check for layout integrity

**Preconditions:**
- User is logged in
- User is on the application settings page

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the font size selection control | Font size options are displayed |
| 2 | 2. Select the largest available font size | Selection is accepted without errors |
| 3 | 3. Confirm or apply the selection | Font size is set to the maximum allowed value |
| 4 | 4. Navigate through key screens (e.g., dashboard, forms, dialogs) | No layout breakages, clipped text, or overflow are observed |

**Final Expected Result:** Maximum font size is applied and layout remains intact

---

### TC-900: Reject invalid font size input via UI entry

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-107
**Requirement:** WA-ACC-002

**Description:** Verify that invalid font size values are rejected and last valid value remains

**Preconditions:**
- User is logged in
- User is on the application settings page
- A valid font size is currently selected

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Attempt to enter an invalid font size value (e.g., non-numeric or out-of-range) in the input field | Input is flagged as invalid or rejected |
| 2 | 2. Submit or confirm the invalid value | System rejects the invalid value |
| 3 | 3. Check current font size in UI text areas | Font size remains at the last valid selection |

**Final Expected Result:** Invalid font size input is rejected and the last valid font size is retained

---

### TC-901: Reject invalid font size value via API or settings storage

**Type:** integration
**Priority:** medium
**Status:** manual
**User Story:** US-107
**Requirement:** WA-ACC-002

**Description:** Verify that invalid font size values sent through a backend interface are rejected

**Preconditions:**
- User is logged in
- API endpoint for settings update is accessible
- A valid font size is currently stored

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Send an API request to update font size with an invalid value (e.g., -1, 0, or extremely large) | API response indicates rejection or validation error |
| 2 | 2. Refresh the application UI | Application reloads successfully |
| 3 | 3. Verify current font size in UI | Font size remains at the last valid selection |

**Final Expected Result:** Invalid API-provided font size is rejected and previous valid setting persists

---

### TC-902: Immediate update with repeated font size changes

**Type:** performance
**Priority:** medium
**Status:** manual
**User Story:** US-107
**Requirement:** WA-ACC-002

**Description:** Verify responsiveness and consistency when user changes font size multiple times quickly

**Preconditions:**
- User is logged in
- User is on the application settings page

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Rapidly switch between several font size options | Each selection is accepted without errors |
| 2 | 2. Observe text areas during changes | Text areas update in near real-time without noticeable lag or glitches |

**Final Expected Result:** Multiple rapid font size changes are handled smoothly and correctly

---

### TC-903: Verify font size applies to dynamically loaded content

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-107
**Requirement:** WA-ACC-002

**Description:** Ensure font size changes affect text loaded after the selection

**Preconditions:**
- User is logged in
- User is on the application settings page

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Select a non-default font size | Font size is updated immediately in current UI |
| 2 | 2. Navigate to a page where content loads dynamically (e.g., list or feed) | Dynamic content loads successfully |
| 3 | 3. Observe font size of dynamically loaded text | Dynamically loaded text uses the selected font size |

**Final Expected Result:** Selected font size applies to dynamically loaded content as well

---

### TC-904: Standard-Theme: Ausreichender Kontrast für Text und interaktive Elemente

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-108
**Requirement:** WA-ACC-003

**Description:** Überprüft, dass alle Text-Hintergrund-Kombinationen im Standard-Theme ausreichenden Kontrast aufweisen.

**Preconditions:**
- Anwendung ist installiert und gestartet
- Standard-Theme ist aktiv
- Benutzer ist eingeloggt

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Öffne die Startseite der Anwendung | Startseite wird angezeigt |
| 2 | 2. Identifiziere alle sichtbaren Textbereiche und Buttons auf der Startseite | Alle Text- und interaktiven Elemente sind sichtbar |
| 3 | 3. Prüfe den Kontrast jeder Text-Hintergrund-Kombination mit einem Kontrast-Checker | Jede Kombination erfüllt den Mindestkontrast gemäß WCAG (z. B. 4.5:1 für normalen Text) |

**Final Expected Result:** Alle Text- und interaktiven Elemente sind im Standard-Theme gut lesbar.

---

### TC-905: Standard-Theme: Grenzfall minimaler zulässiger Kontrast

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-108
**Requirement:** WA-ACC-003

**Description:** Validiert, dass Kombinationen am Grenzwert des Mindestkontrasts akzeptiert werden.

**Preconditions:**
- Standard-Theme ist aktiv
- Testdaten mit Textfarbe und Hintergrund am Kontrast-Grenzwert sind vorhanden

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigiere zu einer Seite mit einem Text-Hintergrund-Paar am Grenzwert | Seite mit Grenzwert-Kombination wird angezeigt |
| 2 | 2. Prüfe den Kontrastwert mit einem Kontrast-Checker | Kontrastwert entspricht genau dem Mindestwert (z. B. 4.5:1) |

**Final Expected Result:** Grenzwert-Kombination wird als ausreichend akzeptiert.

---

### TC-906: Hochkontrastmodus: Automatische Anpassung und ausreichender Kontrast

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-108
**Requirement:** WA-ACC-003

**Description:** Stellt sicher, dass nach Aktivierung des Hochkontrastmodus die Oberfläche neu gerendert wird und ausreichend kontrastiert bleibt.

**Preconditions:**
- Benutzer ist eingeloggt
- Standard-Theme ist aktiv

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Öffne die Einstellungen | Einstellungsseite wird angezeigt |
| 2 | 2. Aktiviere den Hochkontrastmodus | Die Oberfläche wird neu gerendert |
| 3 | 3. Prüfe Text- und interaktive Elemente auf ausreichenden Kontrast | Alle Elemente erfüllen den Mindestkontrast gemäß WCAG |

**Final Expected Result:** Hochkontrastmodus sorgt für ausreichenden Kontrast aller Elemente.

---

### TC-907: Barrierefreie Ansicht: Kontrast bleibt ausreichend nach Umschalten

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-108
**Requirement:** WA-ACC-003

**Description:** Validiert, dass in der barrierefreien Ansicht die Farben automatisch angepasst werden und der Kontrast ausreichend bleibt.

**Preconditions:**
- Benutzer ist eingeloggt
- Barrierefreie Ansicht ist verfügbar

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Öffne die Einstellungen | Einstellungsseite wird angezeigt |
| 2 | 2. Aktiviere die barrierefreie Ansicht | Die Oberfläche wird neu gerendert |
| 3 | 3. Prüfe stichprobenartig verschiedene Seiten auf ausreichenden Kontrast | Alle geprüften Text- und Hintergrundkombinationen sind ausreichend kontrastiert |

**Final Expected Result:** In der barrierefreien Ansicht bleiben Inhalte gut lesbar.

---

### TC-908: Administrator: Speichern eines eigenen Farbschemas mit ausreichendem Kontrast

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-108
**Requirement:** WA-ACC-003

**Description:** Stellt sicher, dass ein Administrator ein Schema mit ausreichendem Kontrast speichern kann.

**Preconditions:**
- Administrator ist eingeloggt
- Admin-Bereich für Farbschemata ist zugänglich

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Öffne den Admin-Bereich für Farbschemata | Konfigurationsoberfläche wird angezeigt |
| 2 | 2. Wähle Text- und Hintergrundfarben mit ausreichendem Kontrast | Farben werden in der Vorschau angezeigt |
| 3 | 3. Klicke auf 'Speichern' | Speicherung wird bestätigt |

**Final Expected Result:** Das Farbschema wird erfolgreich gespeichert.

---

### TC-909: Administrator: Warnung und Speichern verhindern bei zu geringem Kontrast

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-108
**Requirement:** WA-ACC-003

**Description:** Validiert, dass bei unzureichendem Kontrast eine Warnung angezeigt wird und Speichern nicht möglich ist.

**Preconditions:**
- Administrator ist eingeloggt
- Admin-Bereich für Farbschemata ist zugänglich

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Öffne den Admin-Bereich für Farbschemata | Konfigurationsoberfläche wird angezeigt |
| 2 | 2. Wähle Text- und Hintergrundfarben mit zu geringem Kontrast | Vorschau zeigt die ausgewählten Farben |
| 3 | 3. Klicke auf 'Speichern' | Warnung über unzureichenden Kontrast wird angezeigt |

**Final Expected Result:** Speichern wird verhindert, bis der Kontrast ausreichend ist.

---

### TC-910: Administrator: Speichern nach Korrektur des Kontrasts

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-108
**Requirement:** WA-ACC-003

**Description:** Überprüft, dass nach Korrektur eines zu geringen Kontrasts das Speichern möglich ist.

**Preconditions:**
- Administrator ist eingeloggt
- Admin-Bereich für Farbschemata ist zugänglich

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Wähle Text- und Hintergrundfarben mit zu geringem Kontrast | Warnung über unzureichenden Kontrast wird angezeigt |
| 2 | 2. Passe die Farben an, bis der Mindestkontrast erreicht wird | Warnung verschwindet oder wird als behoben angezeigt |
| 3 | 3. Klicke auf 'Speichern' | Speicherung wird bestätigt |

**Final Expected Result:** Nach Korrektur wird das Farbschema gespeichert.

---

### TC-911: Kontrastprüfung für dynamische Inhalte (Modals und Tooltips)

**Type:** integration
**Priority:** medium
**Status:** manual
**User Story:** US-108
**Requirement:** WA-ACC-003

**Description:** Stellt sicher, dass auch dynamische UI-Elemente ausreichenden Kontrast haben.

**Preconditions:**
- Benutzer ist eingeloggt
- Standard-Theme ist aktiv

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Öffne ein Modal über eine Aktion | Modal wird angezeigt |
| 2 | 2. Prüfe den Kontrast von Text und Buttons im Modal | Kontrast erfüllt den Mindestwert |
| 3 | 3. Öffne einen Tooltip über ein Info-Icon | Tooltip wird angezeigt |
| 4 | 4. Prüfe den Kontrast von Tooltip-Text und Hintergrund | Kontrast erfüllt den Mindestwert |

**Final Expected Result:** Dynamische Inhalte sind gut lesbar.

---

### TC-912: Persistenz: Hochkontrastmodus bleibt nach Seitenwechsel aktiv

**Type:** e2e
**Priority:** medium
**Status:** manual
**User Story:** US-108
**Requirement:** WA-ACC-003

**Description:** Prüft, dass der Hochkontrastmodus nach Navigation erhalten bleibt und Kontrast weiterhin ausreichend ist.

**Preconditions:**
- Benutzer ist eingeloggt
- Hochkontrastmodus ist aktiviert

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Navigiere zu einer anderen Seite der Anwendung | Neue Seite wird angezeigt |
| 2 | 2. Prüfe, dass der Hochkontrastmodus weiterhin aktiv ist | Hochkontrast-Design ist sichtbar |
| 3 | 3. Prüfe den Kontrast auf der neuen Seite | Kontrast erfüllt den Mindestwert |

**Final Expected Result:** Hochkontrastmodus bleibt aktiv und Kontrast ist ausreichend.

---

### TC-913: Negative: Administrator ohne Rechte kann Farbschema nicht konfigurieren

**Type:** functional
**Priority:** low
**Status:** manual
**User Story:** US-108
**Requirement:** WA-ACC-003

**Description:** Stellt sicher, dass nur Administratoren Farbschemata konfigurieren können.

**Preconditions:**
- Standardbenutzer ist eingeloggt
- Admin-Bereich ist vorhanden

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Versuche, den Admin-Bereich für Farbschemata zu öffnen | Zugriff wird verweigert oder Bereich ist nicht sichtbar |

**Final Expected Result:** Nicht-Administratoren können keine Farbschemata konfigurieren.

---

### TC-914: Transcription requested manually for received voice message

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-109
**Requirement:** WA-ACC-004

**Description:** Verify that a received voice message is transcribed on user request and shown in a timely manner.

**Preconditions:**
- User is logged in
- A received voice message is available in a conversation
- Transcription service is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the conversation containing the voice message | Voice message is visible with a transcript action available |
| 2 | 2. Tap the 'Transcribe' action for the voice message | Transcription starts and a loading indicator is shown |
| 3 | 3. Wait for transcription to complete | Transcribed text is displayed correctly and promptly under the voice message |

**Final Expected Result:** The voice message is transcribed correctly and displayed in a timely manner.

---

### TC-915: Automatic transcription enabled

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-109
**Requirement:** WA-ACC-004

**Description:** Verify that transcription happens automatically when the feature is enabled.

**Preconditions:**
- User is logged in
- Automatic transcription is enabled in settings
- A new received voice message is available
- Transcription service is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the conversation with the new voice message | Voice message is visible and transcription begins automatically |
| 2 | 2. Wait for transcription to complete | Transcribed text is displayed correctly without manual action |

**Final Expected Result:** Automatic transcription displays correct text without user initiation.

---

### TC-916: Very short voice message transcription

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-109
**Requirement:** WA-ACC-004

**Description:** Verify that short audio is handled and transcribed with best-effort output.

**Preconditions:**
- User is logged in
- A received voice message of very short duration (e.g., 1-2 seconds) is available
- Transcription service is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the conversation with the short voice message | Voice message is visible with a transcribe action |
| 2 | 2. Tap the 'Transcribe' action | Transcription starts and completes |

**Final Expected Result:** A best-effort transcription is displayed, even if minimal or partial.

---

### TC-917: Background noise with uncertain words flagged

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-109
**Requirement:** WA-ACC-004

**Description:** Verify that uncertain words are marked in noisy audio.

**Preconditions:**
- User is logged in
- A received voice message containing background noise is available
- Transcription service is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the conversation with the noisy voice message | Voice message is visible with a transcribe action |
| 2 | 2. Tap the 'Transcribe' action | Transcription completes and text is displayed |
| 3 | 3. Review the transcribed text for uncertainty indicators | Uncertain words are clearly marked (e.g., highlighted or with a confidence indicator) |

**Final Expected Result:** Best-effort transcription is shown and uncertain words are flagged.

---

### TC-918: Transcription service unavailable

**Type:** integration
**Priority:** high
**Status:** manual
**User Story:** US-109
**Requirement:** WA-ACC-004

**Description:** Verify graceful handling when the transcription service is down.

**Preconditions:**
- User is logged in
- A received voice message is available
- Transcription service is unavailable or returns error

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the conversation with the voice message | Voice message is visible with a transcribe action |
| 2 | 2. Tap the 'Transcribe' action | A clear error message is displayed to the user |
| 3 | 3. Play the voice message after the error | Voice message remains unchanged and playable |

**Final Expected Result:** User receives a clear error message and the voice message remains available.

---

### TC-919: Retry transcription after temporary failure

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-109
**Requirement:** WA-ACC-004

**Description:** Verify that a user can retry transcription after an initial failure.

**Preconditions:**
- User is logged in
- A received voice message is available
- Transcription service is initially unavailable, then becomes available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Tap the 'Transcribe' action while service is unavailable | A clear error message is displayed |
| 2 | 2. Restore transcription service availability | Service is reachable |
| 3 | 3. Tap the 'Transcribe' action again | Transcription completes and text is displayed |

**Final Expected Result:** Transcription succeeds on retry after service recovery.

---

### TC-920: Boundary condition: maximum supported voice message length

**Type:** performance
**Priority:** medium
**Status:** manual
**User Story:** US-109
**Requirement:** WA-ACC-004

**Description:** Verify transcription performance and correctness for long voice messages.

**Preconditions:**
- User is logged in
- A received voice message at maximum supported length is available
- Transcription service is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the conversation with the long voice message | Voice message is visible with a transcribe action |
| 2 | 2. Tap the 'Transcribe' action | Transcription starts and remains responsive |
| 3 | 3. Wait for transcription to complete | Transcribed text is displayed without truncation or errors |

**Final Expected Result:** Long voice messages are transcribed correctly within acceptable time.

---

### TC-921: User cancels transcription in progress

**Type:** functional
**Priority:** low
**Status:** manual
**User Story:** US-109
**Requirement:** WA-ACC-004

**Description:** Verify cancellation handling during transcription.

**Preconditions:**
- User is logged in
- A received voice message is available
- Transcription service is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Tap the 'Transcribe' action | Transcription starts and a progress indicator is shown |
| 2 | 2. Tap 'Cancel' while transcription is in progress | Transcription stops and no partial text is displayed |

**Final Expected Result:** Transcription can be canceled and the voice message remains unchanged.

---

### TC-922: Invalid or corrupted audio file

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-109
**Requirement:** WA-ACC-004

**Description:** Verify handling of corrupted or unsupported voice message content.

**Preconditions:**
- User is logged in
- A received voice message file is corrupted or unsupported
- Transcription service is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the conversation with the corrupted voice message | Voice message is visible with a transcribe action |
| 2 | 2. Tap the 'Transcribe' action | An error message indicates transcription cannot be completed |
| 3 | 3. Attempt to play the voice message | Voice message remains available according to current playback handling |

**Final Expected Result:** User receives a clear error and the message remains unchanged.

---

### TC-923: Automatic transcription toggle off

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-109
**Requirement:** WA-ACC-004

**Description:** Verify that transcription does not start automatically when disabled.

**Preconditions:**
- User is logged in
- Automatic transcription is disabled in settings
- A new received voice message is available
- Transcription service is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the conversation with the new voice message | Voice message is visible and transcription does not start automatically |
| 2 | 2. Tap the 'Transcribe' action | Transcription starts only after manual action |

**Final Expected Result:** Automatic transcription is not triggered when disabled.

---

### TC-924: Open app offline after prior login and view cached messages

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-110
**Requirement:** WA-PERF-001

**Description:** Verify user can access basic functions and read last synced messages when offline

**Preconditions:**
- App is installed
- User has successfully logged in at least once
- At least one message is synced while online
- Device airplane mode enabled (offline)

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Launch the app while the device is offline | App opens successfully and displays offline state indicator |
| 2 | 2. Navigate to the messages/inbox screen | Last synced messages are displayed from local cache |
| 3 | 3. Open a cached message | Message content is readable without errors |

**Final Expected Result:** User can open the app and read last synchronized messages offline

---

### TC-925: Compose a new message offline and save as pending

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-110
**Requirement:** WA-PERF-001

**Description:** Verify composing messages offline is allowed and stored locally

**Preconditions:**
- App is installed
- User is logged in
- Device is offline

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the app while offline | App loads and indicates offline mode |
| 2 | 2. Tap 'New Message' | Compose screen opens |
| 3 | 3. Enter recipient and message content and tap 'Send' | Message is saved locally with a pending/queued status |

**Final Expected Result:** Message is created offline and marked as pending for later send

---

### TC-926: Auto-queue and send offline message when connection restores

**Type:** integration
**Priority:** high
**Status:** manual
**User Story:** US-110
**Requirement:** WA-PERF-001

**Description:** Verify offline-composed messages are auto-queued and sent upon reconnection

**Preconditions:**
- User is logged in
- At least one message is created offline and marked pending
- Device is offline

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Restore internet connection | App detects connectivity change |
| 2 | 2. Observe the pending message state | Message is automatically queued for sending |
| 3 | 3. Wait for sync to complete | Message status changes to 'sent' without user action |

**Final Expected Result:** Offline messages are automatically sent after reconnection

---

### TC-927: Attempt online-only feature in offline mode shows clear message

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-110
**Requirement:** WA-PERF-001

**Description:** Verify offline warning and alternative/schedule option for online-required features

**Preconditions:**
- User is logged in
- Device is offline

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the app while offline | App indicates offline mode |
| 2 | 2. Select an online-only feature (e.g., 'Search server messages' or 'Refresh') | App shows a clear offline warning message |
| 3 | 3. Choose the offered alternative/schedule option (if available) | App either provides a cached alternative or offers to perform the action later |

**Final Expected Result:** Offline warning is clear and user is offered a valid alternative or deferred action

---

### TC-928: Launch app offline without prior login

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-110
**Requirement:** WA-PERF-001

**Description:** Verify offline mode requires prior authentication

**Preconditions:**
- App is installed
- User has never logged in on this device
- Device is offline

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Launch the app while offline | Login screen appears with offline message |
| 2 | 2. Attempt to log in with offline connection | Login fails with a clear message indicating internet is required |

**Final Expected Result:** User cannot log in for the first time while offline and receives a clear error

---

### TC-929: Offline access to messages when no cache exists

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-110
**Requirement:** WA-PERF-001

**Description:** Verify app handles empty cache gracefully

**Preconditions:**
- User is logged in
- Message list has never been synced or cache was cleared
- Device is offline

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the app while offline | App opens and indicates offline mode |
| 2 | 2. Navigate to messages/inbox | Empty state is shown with a clear message about no cached messages |

**Final Expected Result:** App displays an appropriate empty state without errors

---

### TC-930: Offline draft persists after app restart

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-110
**Requirement:** WA-PERF-001

**Description:** Verify offline-created message is persisted locally across app restarts

**Preconditions:**
- User is logged in
- Device is offline
- A message is created offline and marked pending

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Force close the app while offline | App closes successfully |
| 2 | 2. Reopen the app while still offline | App loads and indicates offline mode |
| 3 | 3. Navigate to pending/outbox messages | Previously created offline message is still present and pending |

**Final Expected Result:** Offline pending messages persist across app restarts

---

### TC-931: Multiple offline messages auto-send in correct order

**Type:** integration
**Priority:** medium
**Status:** manual
**User Story:** US-110
**Requirement:** WA-PERF-001

**Description:** Verify queue handles multiple offline messages and sends upon reconnection

**Preconditions:**
- User is logged in
- Device is offline

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Create and send three messages offline in sequence | All three messages are saved with pending status and ordered by creation time |
| 2 | 2. Restore internet connection | App detects connectivity |
| 3 | 3. Wait for sync to complete | All messages are sent automatically in order and marked as sent |

**Final Expected Result:** All offline messages are auto-sent on reconnection in the correct order

---

### TC-932: Network flapping during send retries

**Type:** integration
**Priority:** medium
**Status:** manual
**User Story:** US-110
**Requirement:** WA-PERF-001

**Description:** Verify app handles intermittent connectivity without data loss

**Preconditions:**
- User is logged in
- Device is offline
- At least one message is pending

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Restore internet connection briefly then disconnect | App attempts to send and handles interruption gracefully |
| 2 | 2. Reconnect to the internet | App retries sending pending message automatically |
| 3 | 3. Verify message status | Message is sent successfully without duplicates |

**Final Expected Result:** Intermittent connectivity does not cause message loss or duplicate sends

---

### TC-933: Offline indicator and message clarity

**Type:** functional
**Priority:** low
**Status:** manual
**User Story:** US-110
**Requirement:** WA-PERF-001

**Description:** Verify UI clearly indicates offline mode and provides guidance

**Preconditions:**
- User is logged in
- Device is offline

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the app while offline | Offline banner or icon is visible |
| 2 | 2. Attempt to refresh messages | A clear offline message appears with guidance or deferred option |

**Final Expected Result:** Offline state is clearly communicated to the user

---

### TC-934: App startet schnell und zeigt Hauptansicht bei normalen Bedingungen

**Type:** performance
**Priority:** high
**Status:** manual
**User Story:** US-111
**Requirement:** WA-PERF-002

**Description:** Verifiziert, dass die App bei normalen Bedingungen schnell startet und die Hauptansicht angezeigt wird.

**Preconditions:**
- App ist installiert
- Alle Berechtigungen sind erteilt
- Geraet hat normale Auslastung und ausreichend freien Speicher
- Netzwerkverbindung ist verfuegbar

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. App vom Startbildschirm starten | Startvorgang beginnt ohne Fehlermeldung |
| 2 | 2. Zeit bis zur Anzeige der Hauptansicht messen | Hauptansicht wird innerhalb des definierten Zeitlimits angezeigt |

**Final Expected Result:** Die App ist in kurzer Zeit startbereit und die Hauptansicht wird angezeigt.

---

### TC-935: App bleibt bedienbar bei hoher Geraeteauslastung

**Type:** performance
**Priority:** high
**Status:** manual
**User Story:** US-111
**Requirement:** WA-PERF-002

**Description:** Stellt sicher, dass die App bei hoher CPU/RAM-Auslastung weiterhin schnell startet und bedienbar bleibt.

**Preconditions:**
- App ist installiert
- Alle Berechtigungen sind erteilt
- Geraet ist stark ausgelastet (CPU/RAM)
- Netzwerkverbindung ist verfuegbar

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Systemlast erzeugen (z. B. Hintergrund-Apps/Benchmark laufen lassen) | Geraet zeigt hohe Auslastung |
| 2 | 2. App starten | Startvorgang beginnt ohne Absturz |
| 3 | 3. Zeit bis zur Anzeige der Hauptansicht messen | Hauptansicht wird innerhalb des definierten Zeitlimits angezeigt |
| 4 | 4. Grundlegende Interaktionen durchfuehren (z. B. Navigations-Tab wechseln) | App bleibt bedienbar ohne Hanger |

**Final Expected Result:** Die App startet schnell und bleibt trotz hoher Auslastung bedienbar.

---

### TC-936: App startet schnell bei wenig freiem Speicher

**Type:** performance
**Priority:** high
**Status:** manual
**User Story:** US-111
**Requirement:** WA-PERF-002

**Description:** Ueberprueft, dass die App bei niedrigem freien Speicher weiterhin schnell startet.

**Preconditions:**
- App ist installiert
- Alle Berechtigungen sind erteilt
- Freier Speicher ist niedrig (nahe dem minimal empfohlenen Wert)
- Netzwerkverbindung ist verfuegbar

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Freien Speicher auf niedrigen Wert reduzieren | System zeigt wenig freien Speicher |
| 2 | 2. App starten | Startvorgang beginnt ohne Fehlermeldung |
| 3 | 3. Zeit bis zur Anzeige der Hauptansicht messen | Hauptansicht wird innerhalb des definierten Zeitlimits angezeigt |

**Final Expected Result:** Die App startet schnell trotz wenig freiem Speicher.

---

### TC-937: App zeigt Offline-Ansicht ohne Netzwerk

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-111
**Requirement:** WA-PERF-002

**Description:** Validiert, dass bei fehlender Netzwerkverbindung eine Offline-Ansicht angezeigt wird und die App startfaehig bleibt.

**Preconditions:**
- App ist installiert
- Alle Berechtigungen sind erteilt
- Keine Netzwerkverbindung (WLAN und Mobile Daten deaktiviert)

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Netzwerkverbindungen deaktivieren | Geraet hat keine aktive Netzwerkverbindung |
| 2 | 2. App starten | App startet ohne Absturz |
| 3 | 3. Erste Ansicht pruefen | Offline-Ansicht wird angezeigt |

**Final Expected Result:** Die App bleibt startfaehig und zeigt eine Offline-Ansicht.

---

### TC-938: App-Start mit verweigerten Berechtigungen (negativer Test)

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-111
**Requirement:** WA-PERF-002

**Description:** Prueft Verhalten, wenn erforderliche Berechtigungen fehlen.

**Preconditions:**
- App ist installiert
- Mindestens eine erforderliche Berechtigung ist verweigert

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Berechtigungen der App entziehen | System zeigt Berechtigungen als verweigert |
| 2 | 2. App starten | App startet und zeigt einen Berechtigungsdialog oder Hinweis |

**Final Expected Result:** Die App behandelt fehlende Berechtigungen sauber, ohne zu haengen oder abzustuerzen.

---

### TC-939: Kaltstart vs. Warmstart Performance

**Type:** performance
**Priority:** medium
**Status:** manual
**User Story:** US-111
**Requirement:** WA-PERF-002

**Description:** Vergleicht Kaltstart (App nicht im Speicher) und Warmstart (App im Hintergrund) auf Startzeit.

**Preconditions:**
- App ist installiert
- Alle Berechtigungen sind erteilt
- Netzwerkverbindung ist verfuegbar

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. App beenden/aus dem Speicher entfernen | App ist nicht im Speicher |
| 2 | 2. App starten und Startzeit messen (Kaltstart) | Hauptansicht wird innerhalb des definierten Zeitlimits angezeigt |
| 3 | 3. App in den Hintergrund senden | App bleibt im Speicher |
| 4 | 4. App erneut oeffnen und Startzeit messen (Warmstart) | Hauptansicht wird schneller als beim Kaltstart angezeigt |

**Final Expected Result:** Sowohl Kalt- als auch Warmstart liegen innerhalb akzeptabler Startzeiten.

---

### TC-940: App-Start unter extrem niedrigem Speicher (Grenzfall)

**Type:** performance
**Priority:** medium
**Status:** manual
**User Story:** US-111
**Requirement:** WA-PERF-002

**Description:** Testet Grenzfall bei extrem niedrigem freien Speicher und ueberprueft Stabilitaet.

**Preconditions:**
- App ist installiert
- Alle Berechtigungen sind erteilt
- Freier Speicher ist extrem niedrig (knapp ueber Systemminimum)
- Netzwerkverbindung ist verfuegbar

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Freien Speicher bis knapp ueber Systemminimum reduzieren | System zeigt Warnung fuer niedrigen Speicher |
| 2 | 2. App starten | App startet ohne Absturz |
| 3 | 3. Hauptansicht und grundlegende Navigation pruefen | Hauptansicht wird angezeigt und Interaktionen sind moeglich |

**Final Expected Result:** Die App bleibt startfaehig und stabil im Grenzfall niedrigen Speichers.

---

### TC-941: App-Start ohne Netzwerk, dann Netzwerkverbindung hergestellt

**Type:** integration
**Priority:** medium
**Status:** manual
**User Story:** US-111
**Requirement:** WA-PERF-002

**Description:** Verifiziert, dass die App offline startet und nach Wiederherstellung des Netzwerks funktionsfaehig bleibt.

**Preconditions:**
- App ist installiert
- Alle Berechtigungen sind erteilt
- Keine Netzwerkverbindung zu Beginn

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. App ohne Netzwerk starten | Offline-Ansicht wird angezeigt |
| 2 | 2. Netzwerkverbindung aktivieren | Geraet stellt Netzwerkverbindung her |
| 3 | 3. App aktualisieren oder zurück zur Hauptansicht navigieren | App wechselt zu Online-Ansicht oder laedt Inhalte ohne Neustart |

**Final Expected Result:** Die App startet offline korrekt und bleibt nach Netzwerkwiederherstellung nutzbar.

---

### TC-942: Sync on app open downloads all pending messages within performance limits

**Type:** performance
**Priority:** high
**Status:** manual
**User Story:** US-112
**Requirement:** WA-PERF-003

**Description:** Verify that opening the app with stable network syncs all new messages within defined performance thresholds.

**Preconditions:**
- User is logged in
- Stable network connection
- Server has pending new messages for the user
- Performance limits are defined (e.g., max sync time, max response time)

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the app | App launches and initiates synchronization automatically |
| 2 | 2. Wait for synchronization to complete | All pending messages are downloaded and displayed |
| 3 | 3. Measure sync duration and response times | Synchronization completes within defined performance limits |

**Final Expected Result:** All new messages are displayed and sync meets performance thresholds.

---

### TC-943: Manual sync downloads all pending messages within performance limits

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-112
**Requirement:** WA-PERF-003

**Description:** Verify that manually starting sync downloads all pending messages under stable network within performance limits.

**Preconditions:**
- User is logged in
- Stable network connection
- Server has pending new messages for the user

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the app | App launches successfully |
| 2 | 2. Trigger synchronization manually | Sync process starts |
| 3 | 3. Wait for synchronization to complete | All pending messages are downloaded and displayed |

**Final Expected Result:** Manual sync completes successfully with all new messages displayed.

---

### TC-944: Sync with slow network uses batching and shows progress

**Type:** integration
**Priority:** high
**Status:** manual
**User Story:** US-112
**Requirement:** WA-PERF-003

**Description:** Verify that slow or unstable network triggers batch synchronization without blocking the app and shows progress.

**Preconditions:**
- User is logged in
- Network is slow or unstable (simulated)
- Server has multiple pending messages for the user

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the app or start sync manually | Sync process starts |
| 2 | 2. Observe synchronization behavior under slow network | Messages are fetched in smaller batches |
| 3 | 3. Interact with the app during sync (e.g., navigate to another screen) | App remains responsive and not blocked |
| 4 | 4. Observe sync progress UI | Progress indicator updates as batches complete |

**Final Expected Result:** Batch synchronization occurs with visible progress and no app blocking.

---

### TC-945: Sync handles server unreachable with error message and retry

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-112
**Requirement:** WA-PERF-003

**Description:** Verify that when the server is unreachable, the app shows a clear error and schedules retry without data loss.

**Preconditions:**
- User is logged in
- Server is unreachable or returns network error
- App contains existing messages

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Start synchronization | Sync attempt is initiated |
| 2 | 2. Simulate server unreachable during sync | Sync fails with a clear, user-facing error message |
| 3 | 3. Observe retry scheduling | Automatic retry is scheduled or queued |
| 4 | 4. Verify existing messages | Previously downloaded messages remain intact |

**Final Expected Result:** User receives a clear error, retry is scheduled, and no existing messages are lost.

---

### TC-946: Sync handles server error response with error message and retry

**Type:** integration
**Priority:** high
**Status:** manual
**User Story:** US-112
**Requirement:** WA-PERF-003

**Description:** Verify that server error responses (e.g., 5xx) show a clear error and schedule retry without data loss.

**Preconditions:**
- User is logged in
- Server returns 5xx error on sync endpoint
- App contains existing messages

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Start synchronization | Sync attempt is initiated |
| 2 | 2. Receive server error response | App shows a clear error message to the user |
| 3 | 3. Verify retry logic | Automatic retry is scheduled |
| 4 | 4. Verify existing messages | Existing messages are preserved |

**Final Expected Result:** Error handling and retry occur without losing existing data.

---

### TC-947: Boundary: No pending messages on server

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-112
**Requirement:** WA-PERF-003

**Description:** Verify sync behavior when there are no new messages to download.

**Preconditions:**
- User is logged in
- Stable network connection
- No pending messages on the server

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Start synchronization | Sync process starts |
| 2 | 2. Wait for sync to complete | Sync completes quickly with no new messages |

**Final Expected Result:** App indicates sync completion with no changes to message list.

---

### TC-948: Boundary: Large volume of pending messages

**Type:** performance
**Priority:** high
**Status:** manual
**User Story:** US-112
**Requirement:** WA-PERF-003

**Description:** Verify that a large number of pending messages syncs within performance limits under stable network.

**Preconditions:**
- User is logged in
- Stable network connection
- Server has a large number of pending messages (e.g., 10,000)

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Start synchronization | Sync process starts |
| 2 | 2. Monitor sync progress and completion time | All messages are downloaded and displayed |
| 3 | 3. Measure performance metrics | Synchronization completes within defined performance limits |

**Final Expected Result:** Large dataset sync completes successfully within performance limits.

---

### TC-949: Resume sync after temporary network drop

**Type:** integration
**Priority:** medium
**Status:** manual
**User Story:** US-112
**Requirement:** WA-PERF-003

**Description:** Verify that sync continues or retries after a temporary network interruption without duplicating or losing messages.

**Preconditions:**
- User is logged in
- Network connection can be toggled
- Server has pending messages

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Start synchronization | Sync process starts |
| 2 | 2. Interrupt the network connection mid-sync | Sync pauses or fails gracefully with a clear status |
| 3 | 3. Restore network connection | Sync resumes or retries automatically |
| 4 | 4. Verify message list integrity | No duplicates or missing messages |

**Final Expected Result:** Sync recovers from temporary network loss without data inconsistencies.

---

### TC-950: Progress indicator accuracy during batch sync

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-112
**Requirement:** WA-PERF-003

**Description:** Verify that progress indicator reflects batch sync progress under slow network.

**Preconditions:**
- User is logged in
- Slow network simulated
- Server has multiple pending messages

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Start synchronization | Sync begins with progress indicator displayed |
| 2 | 2. Observe progress updates after each batch | Progress indicator increments in line with batches completed |
| 3 | 3. Complete synchronization | Progress indicator reaches 100% or completed state |

**Final Expected Result:** Progress indicator accurately reflects batch synchronization progress.

---

### TC-951: Manual sync does not block UI under slow network

**Type:** e2e
**Priority:** medium
**Status:** manual
**User Story:** US-112
**Requirement:** WA-PERF-003

**Description:** Verify that UI remains responsive when manually syncing on a slow network.

**Preconditions:**
- User is logged in
- Slow network simulated
- Server has pending messages

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Trigger manual sync | Sync starts |
| 2 | 2. Attempt UI interaction (e.g., open settings, scroll message list) | UI remains responsive without freezing |

**Final Expected Result:** Manual sync under slow network does not block the app UI.

---

### TC-952: Error message clarity for sync failure

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-112
**Requirement:** WA-PERF-003

**Description:** Verify that error messaging is clear and actionable when sync fails.

**Preconditions:**
- User is logged in
- Server returns error during sync

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Start synchronization | Sync attempt starts |
| 2 | 2. Receive server error response | User sees a clear error message indicating sync failure |

**Final Expected Result:** Error message is clear and understandable to the end user.

---

### TC-953: No data loss after repeated sync failures

**Type:** integration
**Priority:** high
**Status:** manual
**User Story:** US-112
**Requirement:** WA-PERF-003

**Description:** Verify that repeated sync failures do not remove existing messages.

**Preconditions:**
- User is logged in
- App has existing messages
- Server consistently returns error

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Start synchronization | Sync fails with error message |
| 2 | 2. Allow automatic retry to trigger multiple times | Retries are attempted without app crash |
| 3 | 3. Verify existing messages after retries | Existing messages remain intact |

**Final Expected Result:** Repeated failures do not cause data loss.

---

### TC-954: Vordergrundnutzung 30 Minuten mit aktivem Nachrichtenverkehr

**Type:** performance
**Priority:** high
**Status:** manual
**User Story:** US-113
**Requirement:** WA-PERF-004

**Description:** Verifiziert, dass der Akkuverbrauch im Vordergrundbetrieb mit aktivem Senden/Empfangen innerhalb der Effizienzgrenzen bleibt

**Preconditions:**
- App ist installiert
- Benutzer ist eingeloggt
- Gerät ist vollständig geladen und Messung der Batterienutzung ist aktiviert
- Referenzgrenzen für Akkuverbrauch sind definiert

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. App im Vordergrund starten und 30 Minuten kontinuierlich verwenden (Nachrichten senden/empfangen alle 1–2 Minuten). | App bleibt stabil und verarbeitet alle Nachrichten ohne Abstürze. |
| 2 | 2. Batterieverbrauch der App nach 30 Minuten erfassen. | Akkunutzung liegt innerhalb der definierten Effizienzgrenzen. |

**Final Expected Result:** Der Akkuverbrauch bleibt innerhalb der Effizienzgrenzen ohne ungewöhnlich hohe Entladung.

---

### TC-955: Vordergrundnutzung 30 Minuten bei hoher Nachrichtenfrequenz (Grenzfall)

**Type:** performance
**Priority:** high
**Status:** manual
**User Story:** US-113
**Requirement:** WA-PERF-004

**Description:** Prüft die Akku-Effizienz bei hoher Last (hohe Nachrichtenrate)

**Preconditions:**
- App ist installiert
- Benutzer ist eingeloggt
- Gerät ist vollständig geladen
- Testumgebung ermöglicht automatisiertes Senden/Empfangen von Nachrichten
- Referenzgrenzen für Akkuverbrauch sind definiert

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. App im Vordergrund starten und 30 Minuten verwenden. | App bleibt stabil. |
| 2 | 2. Alle 5 Sekunden eine Nachricht senden und empfangen. | Alle Nachrichten werden korrekt verarbeitet. |
| 3 | 3. Batterieverbrauch nach 30 Minuten erfassen. | Akkunutzung bleibt innerhalb der definierten Effizienzgrenzen oder dokumentiert einen akzeptierten Grenzwert. |

**Final Expected Result:** Der Akkuverbrauch bleibt innerhalb akzeptabler Grenzen auch bei hoher Nachrichtenfrequenz.

---

### TC-956: Hintergrundbetrieb ohne neue Nachrichten

**Type:** performance
**Priority:** high
**Status:** manual
**User Story:** US-113
**Requirement:** WA-PERF-004

**Description:** Validiert, dass im Hintergrund keine unnötigen Aktivitäten stattfinden und der Akkuverbrauch minimal bleibt

**Preconditions:**
- App ist installiert
- Benutzer ist eingeloggt
- Gerät ist vollständig geladen
- Keine neuen Nachrichten im System geplant

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. App in den Hintergrund senden. | App wechselt in den Hintergrundstatus. |
| 2 | 2. Gerät 30 Minuten im Leerlauf lassen. | Keine sichtbaren Hintergrundaktivitäten der App. |
| 3 | 3. Batterieverbrauch der App nach 30 Minuten prüfen. | Akkunutzung ist minimal und innerhalb definierter Grenzwerte für Hintergrundbetrieb. |

**Final Expected Result:** Im Hintergrundbetrieb ohne Nachrichten bleibt der Akkuverbrauch minimal.

---

### TC-957: Hintergrundbetrieb mit eingehender Push-Benachrichtigung

**Type:** integration
**Priority:** high
**Status:** manual
**User Story:** US-113
**Requirement:** WA-PERF-004

**Description:** Stellt sicher, dass Push-Benachrichtigungen zugestellt werden, ohne dauerhafte stromintensive Prozesse zu starten

**Preconditions:**
- App ist installiert
- Benutzer ist eingeloggt
- Push-Benachrichtigungen sind aktiviert
- App ist im Hintergrund

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Eine neue Nachricht an den Benutzer senden. | Push-Benachrichtigung wird zugestellt. |
| 2 | 2. Systemaktivitätsmonitor prüfen (CPU/Wake Locks) für 5 Minuten nach Push. | Keine dauerhaften stromintensiven Prozesse laufen. |

**Final Expected Result:** Push-Benachrichtigung erfolgt korrekt ohne anhaltende energieintensive Prozesse.

---

### TC-958: Hintergrundbetrieb ohne Interaktion, aber gelegentliche Systemereignisse (negativ)

**Type:** performance
**Priority:** medium
**Status:** manual
**User Story:** US-113
**Requirement:** WA-PERF-004

**Description:** Überprüft, dass Systemereignisse (z. B. Netzwerkwechsel) keine unnötigen App-Aktivitäten auslösen

**Preconditions:**
- App ist installiert
- Benutzer ist eingeloggt
- App ist im Hintergrund

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. App in den Hintergrund senden. | App ist im Hintergrund. |
| 2 | 2. Netzwerkverbindung 3-mal innerhalb von 15 Minuten wechseln (WLAN ↔ Mobil). | App startet keine kontinuierlichen Hintergrundprozesse. |
| 3 | 3. Batterieverbrauch prüfen. | Akkunutzung bleibt minimal. |

**Final Expected Result:** Keine unnötigen Hintergrundaktivitäten trotz Systemereignissen.

---

### TC-959: Vordergrundbetrieb 30 Minuten ohne Nachrichtenverkehr (Basislinie)

**Type:** performance
**Priority:** medium
**Status:** manual
**User Story:** US-113
**Requirement:** WA-PERF-004

**Description:** Ermittelt den Basis-Akkuverbrauch der App im Vordergrund ohne aktive Nachrichten

**Preconditions:**
- App ist installiert
- Benutzer ist eingeloggt
- Gerät ist vollständig geladen

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. App im Vordergrund starten und 30 Minuten geöffnet lassen, ohne Nachrichten zu senden/empfangen. | App bleibt stabil im Vordergrund. |
| 2 | 2. Batterieverbrauch nach 30 Minuten erfassen. | Akkunutzung liegt innerhalb der definierten Effizienzgrenzen. |

**Final Expected Result:** Basis-Akkuverbrauch im Vordergrund ist effizient.

---

### TC-960: Push-Benachrichtigung bei gesperrtem Bildschirm

**Type:** integration
**Priority:** medium
**Status:** manual
**User Story:** US-113
**Requirement:** WA-PERF-004

**Description:** Validiert, dass eine Push-Benachrichtigung bei gesperrtem Bildschirm zugestellt wird ohne erhöhte Akkuaktivität

**Preconditions:**
- App ist installiert
- Benutzer ist eingeloggt
- Push-Benachrichtigungen sind aktiviert
- Bildschirm ist gesperrt
- App ist im Hintergrund

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Neue Nachricht an den Benutzer senden. | Push-Benachrichtigung erscheint auf dem Sperrbildschirm. |
| 2 | 2. Systemaktivität 5 Minuten überwachen. | Keine anhaltenden energieintensiven Prozesse. |

**Final Expected Result:** Push-Benachrichtigung erfolgt korrekt ohne erhöhten Stromverbrauch.

---

### TC-961: Fehlende Push-Berechtigung (negativ)

**Type:** functional
**Priority:** low
**Status:** manual
**User Story:** US-113
**Requirement:** WA-PERF-004

**Description:** Stellt sicher, dass keine unerwarteten Hintergrundprozesse starten, wenn Push-Berechtigungen fehlen

**Preconditions:**
- App ist installiert
- Benutzer ist eingeloggt
- Push-Benachrichtigungen sind auf OS-Ebene deaktiviert
- App ist im Hintergrund

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Neue Nachricht an den Benutzer senden. | Keine Push-Benachrichtigung wird zugestellt. |
| 2 | 2. Systemaktivität 5 Minuten überwachen. | Keine anhaltenden stromintensiven Prozesse werden gestartet. |

**Final Expected Result:** Keine Push-Benachrichtigung und keine unnötigen Hintergrundaktivitäten.

---

### TC-962: Redundante Datenvermeidung im Normalbetrieb

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-114
**Requirement:** WA-PERF-005

**Description:** Überprüft, dass beim Speichern von Nachrichten und Metadaten redundante Daten vermieden werden und Speicherverbrauch innerhalb definierter Grenzwerte bleibt.

**Preconditions:**
- System im Normalbetrieb
- Grenzwerte für Speicherverbrauch sind konfiguriert

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Erzeuge eine Nachricht mit identischen Metadaten mehrfach | Nachrichten werden angenommen und verarbeitet |
| 2 | 2. Speichere die Nachrichten im System | Speicherprozess läuft ohne Fehler |
| 3 | 3. Prüfe deduplizierte Speicherung im Speicher- oder Datenbankprotokoll | Redundante Daten werden nicht mehrfach gespeichert |
| 4 | 4. Prüfe den aktuellen Speicherverbrauch | Speicherverbrauch bleibt innerhalb der definierten Grenzwerte |

**Final Expected Result:** Redundante Daten werden vermieden und Speicherverbrauch bleibt innerhalb der Grenzwerte.

---

### TC-963: Grenzwert-Speicherverbrauch im Normalbetrieb

**Type:** performance
**Priority:** high
**Status:** manual
**User Story:** US-114
**Requirement:** WA-PERF-005

**Description:** Validiert den Speicherverbrauch bei hoher, aber zulässiger Last im Normalbetrieb.

**Preconditions:**
- System im Normalbetrieb
- Grenzwerte für Speicherverbrauch sind konfiguriert
- Monitoring für Speicherverbrauch aktiviert

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Sende eine hohe Anzahl zulässiger Nachrichtenlast innerhalb der Spezifikation | Nachrichten werden verarbeitet |
| 2 | 2. Speichere die Nachrichten und Metadaten | Speicherprozess läuft ohne Fehler |
| 3 | 3. Überwache Speicherverbrauch während des Speicherns | Speicherverbrauch bleibt unter dem definierten Grenzwert |

**Final Expected Result:** Speicherverbrauch bleibt unterhalb der definierten Grenzwerte bei hoher, zulässiger Last.

---

### TC-964: Speicherbereinigung/Komprimierung mit historischen Daten

**Type:** integration
**Priority:** high
**Status:** manual
**User Story:** US-114
**Requirement:** WA-PERF-005

**Description:** Prüft, dass eine Speicherbereinigung oder Komprimierung Speicher freigibt, ohne Datenintegrität oder Verfügbarkeit zu beeinträchtigen.

**Preconditions:**
- Große Menge historischer Daten vorhanden
- Bereinigung/Komprimierung kann manuell ausgelöst werden

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Ermittele aktuellen Speicherverbrauch | Aktueller Speicherverbrauch ist messbar und dokumentiert |
| 2 | 2. Löse eine Speicherbereinigung oder Komprimierung aus | Bereinigungs-/Komprimierungsprozess startet |
| 3 | 3. Überwache Prozessabschluss | Prozess endet erfolgreich ohne Fehler |
| 4 | 4. Prüfe Speicherverbrauch nach Abschluss | Speicherverbrauch ist reduziert |
| 5 | 5. Verifiziere Zugriff auf Stichprobe historischer Daten | Daten sind vollständig, korrekt und verfügbar |

**Final Expected Result:** Speicher wird freigegeben und Datenintegrität sowie Verfügbarkeit bleiben erhalten.

---

### TC-965: Datenintegrität nach Komprimierung unter Last

**Type:** e2e
**Priority:** medium
**Status:** manual
**User Story:** US-114
**Requirement:** WA-PERF-005

**Description:** Stellt sicher, dass während/ nach Komprimierung keine Datenverluste auftreten.

**Preconditions:**
- Große Menge historischer Daten vorhanden
- System verarbeitet weiterhin neue Nachrichten

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Starte Speicherkomprimierung | Komprimierungsprozess startet |
| 2 | 2. Sende parallel neue Nachrichten | Neue Nachrichten werden weiterhin gespeichert |
| 3 | 3. Prüfe eine Stichprobe neuer und historischer Daten | Alle geprüften Daten sind korrekt und verfügbar |

**Final Expected Result:** Komprimierung beeinträchtigt nicht die Datenintegrität oder Verfügbarkeit.

---

### TC-966: Warnung bei kritischem Speicher-Schwellenwert

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-114
**Requirement:** WA-PERF-005

**Description:** Überprüft, dass eine Warnung ausgelöst wird, wenn der Speicher sich dem kritischen Schwellenwert nähert.

**Preconditions:**
- Kritischer Speicher-Schwellenwert ist konfiguriert
- Monitoring und Alarmierung sind aktiv

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Fülle den Speicher bis knapp unter den kritischen Schwellenwert | Speicherverbrauch liegt nahe am Schwellenwert |
| 2 | 2. Versuche neue Daten zu speichern | Warnung wird ausgelöst |

**Final Expected Result:** System löst eine Warnung aus, wenn der Speicher den kritischen Schwellenwert erreicht/nahe ist.

---

### TC-967: Kontrollierte Speicherung bei kritischem Speicher

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-114
**Requirement:** WA-PERF-005

**Description:** Validiert, dass die Speicherung bei kritischem Speicherstand kontrolliert erfolgt, ohne Systemabsturz.

**Preconditions:**
- Kritischer Speicher-Schwellenwert ist konfiguriert
- System kann kontrolliertes Speichern (z. B. Throttling/Queue) durchführen

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Fülle den Speicher bis zum kritischen Schwellenwert | Speicherverbrauch erreicht den Schwellenwert |
| 2 | 2. Speichere neue Nachrichten | Speicherung erfolgt kontrolliert (z. B. Warteschlange/Throttle) |
| 3 | 3. Überwache Systemstabilität | Kein Systemabsturz, Dienste bleiben erreichbar |

**Final Expected Result:** Speicherung erfolgt kontrolliert und das System bleibt stabil.

---

### TC-968: Negative: Komprimierung fehlgeschlagen

**Type:** integration
**Priority:** medium
**Status:** manual
**User Story:** US-114
**Requirement:** WA-PERF-005

**Description:** Stellt sicher, dass bei fehlgeschlagener Komprimierung keine Daten verloren gehen und ein Fehler protokolliert wird.

**Preconditions:**
- Große Menge historischer Daten vorhanden
- Fehlersimulation für Komprimierung möglich

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Lösen einer Komprimierung aus und simulieren eines Fehlers (z. B. Prozessabbruch) | Komprimierung wird abgebrochen und Fehler wird registriert |
| 2 | 2. Prüfe Datenintegrität anhand einer Stichprobe | Daten sind unverändert und verfügbar |

**Final Expected Result:** Fehler wird korrekt behandelt, keine Datenverluste.

---

### TC-969: Boundary: Speicher genau am Grenzwert

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-114
**Requirement:** WA-PERF-005

**Description:** Überprüft Verhalten, wenn Speicherverbrauch exakt den definierten Grenzwert erreicht.

**Preconditions:**
- Grenzwerte für Speicherverbrauch sind definiert
- Monitoring aktiv

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Fülle den Speicher exakt bis zum Grenzwert | Speicherverbrauch entspricht dem Grenzwert |
| 2 | 2. Speichere eine weitere kleine Nachricht | System reagiert gemäß Speicherrichtlinie (z. B. Warnung/Throttle) |

**Final Expected Result:** System verhält sich gemäß Richtlinie am Grenzwert.

---

### TC-970: Negative: Warnung wird nicht ausgelöst

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-114
**Requirement:** WA-PERF-005

**Description:** Prüft, dass ein fehlender Alarm bei kritischem Speicher als Fehler erkannt wird.

**Preconditions:**
- Kritischer Speicher-Schwellenwert ist konfiguriert
- Monitoring und Alarmierung sind aktiv

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Fülle den Speicher bis über den kritischen Schwellenwert | Speicherverbrauch überschreitet Schwellenwert |
| 2 | 2. Prüfe Alarmierungs-Logs und Benachrichtigungen | Warnung ist vorhanden |

**Final Expected Result:** Eine Warnung wird ausgelöst; falls nicht, ist dies ein Fehler.

---

### TC-971: Share content to a selected app successfully

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-115
**Requirement:** WA-INT-001

**Description:** Verify that a shareable content can be shared to a chosen target app and confirmation is shown

**Preconditions:**
- User is logged in
- User is viewing a shareable content item
- Device has at least one compatible target app installed
- System Share Extension is available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Tap the Share button on the content screen | System share sheet is displayed with available target apps |
| 2 | 2. Select a compatible target app (e.g., Messages) | Share sheet closes and the target app opens with content pre-filled |
| 3 | 3. Confirm/send within the target app | Content is sent and the app displays a confirmation message in the source app (upon return) or in-app confirmation toast/banner |

**Final Expected Result:** Content is passed correctly to the selected app and a confirmation is displayed

---

### TC-972: Share sheet shows available options on limited-share device

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-115
**Requirement:** WA-INT-001

**Description:** Ensure the share sheet lists only available options on a device with restricted share capabilities

**Preconditions:**
- User is logged in
- User is viewing a shareable content item
- Device has limited share options configured

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Tap the Share button on the content screen | System share sheet opens |
| 2 | 2. Review the available share targets | Only permitted/installed share targets are listed |

**Final Expected Result:** The system displays only available share options without errors

---

### TC-973: No compatible target apps installed

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-115
**Requirement:** WA-INT-001

**Description:** Verify user is informed when no compatible target apps are available

**Preconditions:**
- User is logged in
- User is viewing a shareable content item
- Device has no compatible target apps installed

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Tap the Share button on the content screen | System share sheet opens or an in-app message is shown |
| 2 | 2. Observe the share options or message | User is informed that no compatible target apps are available |

**Final Expected Result:** A clear message informs the user that no compatible target apps are available

---

### TC-974: Temporary error when invoking share extension

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-115
**Requirement:** WA-INT-001

**Description:** Validate error handling and retry option when the share extension fails temporarily

**Preconditions:**
- User is logged in
- User is viewing a shareable content item
- System Share Extension is available
- Simulate a temporary share extension error

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Tap the Share button on the content screen | Share invocation fails and an error message is displayed |
| 2 | 2. Tap the Retry action on the error message | System attempts to open the share sheet again |

**Final Expected Result:** A clear error message is shown and retry successfully re-invokes the share sheet

---

### TC-975: Share action canceled by user

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-115
**Requirement:** WA-INT-001

**Description:** Ensure no content is shared if the user cancels the share sheet

**Preconditions:**
- User is logged in
- User is viewing a shareable content item
- Device has at least one compatible target app installed

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Tap the Share button on the content screen | System share sheet is displayed |
| 2 | 2. Dismiss the share sheet (cancel) | User returns to the content screen |

**Final Expected Result:** No content is shared and the app returns to its previous state without errors

---

### TC-976: Share non-shareable or restricted content

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-115
**Requirement:** WA-INT-001

**Description:** Confirm that non-shareable content does not allow sharing or provides a proper message

**Preconditions:**
- User is logged in
- User is viewing a non-shareable content item

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Observe the Share button state on the content screen | Share button is disabled or hidden |
| 2 | 2. Attempt to trigger Share via alternative UI (if possible) | App blocks the action and shows an informative message |

**Final Expected Result:** Sharing is prevented for non-shareable content with a clear user indication

---

### TC-977: Boundary: Share very large content payload

**Type:** integration
**Priority:** low
**Status:** manual
**User Story:** US-115
**Requirement:** WA-INT-001

**Description:** Verify share functionality with large content payload to ensure correct handoff or graceful failure

**Preconditions:**
- User is logged in
- User is viewing a shareable content item with a large payload
- Device has at least one compatible target app installed

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Tap the Share button on the content screen | System share sheet opens successfully |
| 2 | 2. Select a compatible target app | Target app opens with content handed off or a size-related warning is shown |

**Final Expected Result:** Large content is shared successfully or a clear, actionable error is displayed

---

### TC-978: Send message via Siri with confirmation (happy path)

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-116
**Requirement:** WA-INT-002

**Description:** Verify a dictated message via Siri creates a preview and sends after confirmation

**Preconditions:**
- User is logged in
- Siri integration enabled
- Microphone and Siri permissions granted
- Network available
- At least one contact exists

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Invoke Siri and dictate: 'Send a message to Anna: I will arrive at 5 pm.' | System receives the command and transcribes the message content and recipient |
| 2 | 2. Review the message preview shown by the app/assistant | Preview displays recipient 'Anna' and message text exactly as transcribed |
| 3 | 3. Confirm sending using the voice command 'Send' or tap 'Send' | Message is sent to Anna and a success confirmation is displayed |

**Final Expected Result:** Message is sent reliably only after user confirmation

---

### TC-979: Send message via Google Assistant with confirmation (happy path)

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-116
**Requirement:** WA-INT-002

**Description:** Verify a dictated message via Google Assistant creates a preview and sends after confirmation

**Preconditions:**
- User is logged in
- Google Assistant integration enabled
- Microphone and Assistant permissions granted
- Network available
- At least one contact exists

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Invoke Google Assistant and dictate: 'Send a message to Ben: Meeting is moved to 3 pm.' | System receives the command and transcribes the message content and recipient |
| 2 | 2. Review the message preview shown by the app/assistant | Preview displays recipient 'Ben' and message text exactly as transcribed |
| 3 | 3. Confirm sending using the voice command 'Send' or tap 'Send' | Message is sent to Ben and a success confirmation is displayed |

**Final Expected Result:** Message is sent reliably only after user confirmation

---

### TC-980: Do not send without confirmation

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-116
**Requirement:** WA-INT-002

**Description:** Ensure message is not sent if user does not confirm the preview

**Preconditions:**
- User is logged in
- Voice assistant integration enabled
- Permissions granted
- Network available
- At least one contact exists

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Dictate a message to a valid contact via assistant | Message preview is displayed with recipient and text |
| 2 | 2. Say 'Cancel' or dismiss the preview | Preview is closed and no send action is executed |

**Final Expected Result:** No message is sent when confirmation is not provided

---

### TC-981: Handle unclear voice command (ambiguous recipient)

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-116
**Requirement:** WA-INT-002

**Description:** System should ask for clarification and not send when command is unclear

**Preconditions:**
- User is logged in
- Voice assistant integration enabled
- Permissions granted
- Network available
- Two contacts with similar names exist (e.g., 'Anna Schmidt' and 'Anna Schulz')

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Dictate: 'Send a message to Anna: Hi' | System detects ambiguous recipient |
| 2 | 2. Observe assistant prompt | System asks the user to уточнить/precise the recipient and does not show send confirmation yet |

**Final Expected Result:** System requests clarification and does not send any message

---

### TC-982: Handle incomplete voice command (missing message body)

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-116
**Requirement:** WA-INT-002

**Description:** System should request missing information and not send without confirmation

**Preconditions:**
- User is logged in
- Voice assistant integration enabled
- Permissions granted
- Network available
- At least one contact exists

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Dictate: 'Send a message to Chris' | System recognizes missing message content |
| 2 | 2. Observe assistant prompt | System asks user to provide the message text and does not send |

**Final Expected Result:** System requests additional details and does not send any message

---

### TC-983: Permission denied for voice assistant

**Type:** integration
**Priority:** high
**Status:** manual
**User Story:** US-116
**Requirement:** WA-INT-002

**Description:** System should inform user when permission is missing and provide alternative input

**Preconditions:**
- User is logged in
- Voice assistant integration enabled
- Microphone/assistant permissions denied
- Network available

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Attempt to dictate a message via assistant | Assistant invocation fails due to missing permission |
| 2 | 2. Observe app response | System shows an error message about missing permissions and provides an alternative in-app input option |

**Final Expected Result:** User is informed of permission error and offered alternative input in the app

---

### TC-984: Network error when assistant is unreachable

**Type:** integration
**Priority:** high
**Status:** manual
**User Story:** US-116
**Requirement:** WA-INT-002

**Description:** System should handle network error and provide alternative input

**Preconditions:**
- User is logged in
- Voice assistant integration enabled
- Permissions granted
- Network unavailable or unstable

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Attempt to dictate a message via assistant while offline | Assistant is unreachable due to network error |
| 2 | 2. Observe app response | System shows a network error message and provides an alternative in-app input option |

**Final Expected Result:** User is informed of network error and offered alternative input in the app

---

### TC-985: Boundary test: very short message

**Type:** functional
**Priority:** low
**Status:** manual
**User Story:** US-116
**Requirement:** WA-INT-002

**Description:** Verify system can handle minimal message content

**Preconditions:**
- User is logged in
- Voice assistant integration enabled
- Permissions granted
- Network available
- At least one contact exists

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Dictate: 'Send a message to Dana: OK' | Preview displays recipient 'Dana' and message 'OK' |
| 2 | 2. Confirm sending | Message is sent successfully |

**Final Expected Result:** Short messages are previewed and sent after confirmation

---

### TC-986: Boundary test: very long dictated message

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-116
**Requirement:** WA-INT-002

**Description:** Verify system handles long message content without truncation in preview

**Preconditions:**
- User is logged in
- Voice assistant integration enabled
- Permissions granted
- Network available
- At least one contact exists

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Dictate a long message (e.g., 500+ characters) to a valid contact | Preview displays the full message or indicates truncation with option to expand |
| 2 | 2. Confirm sending | Message is sent and content matches the dictated text |

**Final Expected Result:** Long messages are handled correctly and sent after confirmation

---

### TC-987: Add widget with standard configuration displays expected info

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-117
**Requirement:** WA-INT-003

**Description:** Verify widget can be added with standard configuration and shows expected information on Home-Screen

**Preconditions:**
- App is installed
- User is logged in
- Device Home-Screen is accessible

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the device widget picker and select the app's widget | Widget preview is shown and can be added |
| 2 | 2. Add the widget to the Home-Screen | Widget appears on the Home-Screen |
| 3 | 3. Choose the standard configuration when prompted | Standard configuration is applied |
| 4 | 4. Observe the widget content | Widget displays the expected information for the standard configuration |

**Final Expected Result:** Widget is visible on Home-Screen and shows the correct information based on the standard configuration

---

### TC-988: Widget settings change content and size

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-117
**Requirement:** WA-INT-003

**Description:** Verify that changing widget content and size in settings is saved and reflected within 5 seconds

**Preconditions:**
- App is installed
- User is logged in
- Widget is already added to the Home-Screen

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open widget settings from the widget or app | Widget settings screen is displayed |
| 2 | 2. Change the widget content to an alternative available data set | Content selection is updated in settings |
| 3 | 3. Change the widget size to the next larger supported size | Size selection is updated in settings |
| 4 | 4. Save the settings | Settings are saved successfully |
| 5 | 5. Observe the widget for 5 seconds | Widget reflects new content and size within 5 seconds |

**Final Expected Result:** Widget updates to the new content and size within 5 seconds after saving

---

### TC-989: Widget shows cached content and offline notice when no network

**Type:** functional
**Priority:** high
**Status:** manual
**User Story:** US-117
**Requirement:** WA-INT-003

**Description:** Verify that widget displays last available content and an offline indicator when network is unavailable

**Preconditions:**
- App is installed
- User is logged in
- Widget is already added to the Home-Screen
- Widget has previously loaded content

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Disable network connectivity on the device | Device shows no active network connection |
| 2 | 2. Trigger a widget refresh (e.g., wait for auto-refresh or manually refresh if available) | Widget attempts to refresh |
| 3 | 3. Observe the widget content | Last available content remains displayed |
| 4 | 4. Check for offline indicator/notice on the widget | Offline notice is shown on the widget |

**Final Expected Result:** Widget displays cached content and an offline notice when refresh occurs without network

---

### TC-990: Widget settings change persists across app restart

**Type:** integration
**Priority:** medium
**Status:** manual
**User Story:** US-117
**Requirement:** WA-INT-003

**Description:** Verify widget configuration changes are persisted after restarting the app/device

**Preconditions:**
- App is installed
- User is logged in
- Widget is already added to the Home-Screen

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open widget settings and change content and size | Settings show updated selections |
| 2 | 2. Save settings and verify widget updates within 5 seconds | Widget reflects the new configuration |
| 3 | 3. Force close the app and reopen it | App launches successfully |
| 4 | 4. Observe the widget on the Home-Screen | Widget retains the updated content and size |

**Final Expected Result:** Widget configuration persists across app restart

---

### TC-991: Attempt to add widget without login

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-117
**Requirement:** WA-INT-003

**Description:** Verify system behavior when user is not logged in and tries to add widget

**Preconditions:**
- App is installed
- User is logged out

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Add the app widget to the Home-Screen | Widget appears on the Home-Screen or prompts for configuration |
| 2 | 2. Attempt to select a standard configuration | User is prompted to log in or widget displays a login required state |

**Final Expected Result:** Widget does not show protected information and prompts user to log in

---

### TC-992: Invalid or empty widget configuration selection

**Type:** functional
**Priority:** medium
**Status:** manual
**User Story:** US-117
**Requirement:** WA-INT-003

**Description:** Verify that widget handles an invalid/empty configuration selection gracefully

**Preconditions:**
- App is installed
- User is logged in
- Widget is already added to the Home-Screen

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open widget settings | Settings screen is displayed |
| 2 | 2. Clear the selected content or choose a non-existent data source if possible | System prevents invalid selection or shows a validation message |
| 3 | 3. Attempt to save settings | Save is blocked or default configuration is restored |
| 4 | 4. Observe the widget | Widget shows a safe default state or previous valid content |

**Final Expected Result:** Widget does not break and either blocks invalid configuration or falls back to a valid state

---

### TC-993: Boundary: minimum supported widget size

**Type:** functional
**Priority:** low
**Status:** manual
**User Story:** US-117
**Requirement:** WA-INT-003

**Description:** Verify widget renders correctly at minimum supported size

**Preconditions:**
- App is installed
- User is logged in
- Widget is already added to the Home-Screen
- Device supports resizing widgets

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Resize the widget to the minimum supported size | Widget resizes to the minimum size without errors |
| 2 | 2. Observe content layout | Content is readable or appropriately truncated according to design |

**Final Expected Result:** Widget renders correctly at the minimum supported size

---

### TC-994: Boundary: maximum supported widget size

**Type:** functional
**Priority:** low
**Status:** manual
**User Story:** US-117
**Requirement:** WA-INT-003

**Description:** Verify widget renders correctly at maximum supported size

**Preconditions:**
- App is installed
- User is logged in
- Widget is already added to the Home-Screen
- Device supports resizing widgets

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Resize the widget to the maximum supported size | Widget resizes to the maximum size without errors |
| 2 | 2. Observe content layout | Content is displayed correctly using the larger space |

**Final Expected Result:** Widget renders correctly at the maximum supported size

---

### TC-995: Performance: widget updates within 5 seconds after settings change

**Type:** performance
**Priority:** medium
**Status:** manual
**User Story:** US-117
**Requirement:** WA-INT-003

**Description:** Measure widget update time after configuration change to ensure it meets the 5-second requirement

**Preconditions:**
- App is installed
- User is logged in
- Widget is already added to the Home-Screen

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open widget settings and change content | Content selection is updated |
| 2 | 2. Save settings and start a timer | Settings are saved successfully |
| 3 | 3. Stop the timer when the widget shows updated content | Update time is recorded |

**Final Expected Result:** Widget updates within 5 seconds after saving settings

---

### TC-996: Receive notification on smartwatch within seconds

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-118
**Requirement:** WA-INT-004

**Description:** Verify that a new message triggers a smartwatch notification within a few seconds when paired and notifications enabled

**Preconditions:**
- User is a registered user and logged in on phone app
- Smartwatch is paired with the phone app
- Smartwatch notifications are enabled
- Smartwatch has active internet connection

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Send a new message to the user from the system | Message is received by the backend and queued for delivery |
| 2 | 2. Observe the smartwatch for incoming notification | Notification appears on the smartwatch within a few seconds |

**Final Expected Result:** Notification is displayed on the smartwatch within the expected time window

---

### TC-997: No notification when smartwatch not paired

**Type:** negative
**Priority:** medium
**Status:** manual
**User Story:** US-118
**Requirement:** WA-INT-004

**Description:** Verify that no smartwatch notification is shown when the smartwatch is not paired

**Preconditions:**
- User is a registered user and logged in on phone app
- Smartwatch is not paired with the phone app
- Smartwatch notifications are enabled in app settings

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Send a new message to the user from the system | Message is received by the backend and queued for delivery |
| 2 | 2. Observe the smartwatch for incoming notification | No notification appears on the smartwatch |

**Final Expected Result:** No smartwatch notification is displayed when the device is not paired

---

### TC-998: No notification when notifications disabled

**Type:** negative
**Priority:** medium
**Status:** manual
**User Story:** US-118
**Requirement:** WA-INT-004

**Description:** Verify that no smartwatch notification is shown when notifications are disabled

**Preconditions:**
- User is a registered user and logged in on phone app
- Smartwatch is paired with the phone app
- Smartwatch notifications are disabled

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Send a new message to the user from the system | Message is received by the backend and queued for delivery |
| 2 | 2. Observe the smartwatch for incoming notification | No notification appears on the smartwatch |

**Final Expected Result:** No smartwatch notification is displayed when notifications are disabled

---

### TC-999: Reply to notification with preset response

**Type:** e2e
**Priority:** high
**Status:** manual
**User Story:** US-118
**Requirement:** WA-INT-004

**Description:** Verify that selecting a preset response sends the message and shows confirmation

**Preconditions:**
- User is a registered user and logged in on phone app
- Smartwatch is paired with the phone app
- Smartwatch notifications are enabled
- Smartwatch has active internet connection
- A notification is visible on the smartwatch

**Steps:**

| # | Action | Expected Result |
|---|--------|------------------|
| 1 | 1. Open the visible notification on the smartwatch | Notification details and response options are displayed |
| 2 | 2. Select a preset response option | Response is queued for sending |
| 3 | 3. Confirm sending the response (if prompted) | Response is sent successfully |

**Final Expected Result:** Response is delivered to the recipient and marked as sent on the smartwatch

---

