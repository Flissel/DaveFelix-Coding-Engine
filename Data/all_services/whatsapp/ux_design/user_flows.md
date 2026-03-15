# User Flows

## FLOW-001: Telefonnummer-Registrierung

**Actor:** Lena Hoffmann
**Trigger:** User klickt auf 'Registrieren' und waehlt Registrierung per Telefonnummer

Flow zur Registrierung mit Mobilnummer inkl. Verifizierung

### Steps

| # | Action | Screen | Expected Result |
|---|--------|--------|-----------------|
| 1 | User oeffnet Registrierungsbildschirm | Registrierung | Registrierungsformular wird angezeigt |
| 2 | User gibt Mobilnummer ein und klickt 'Code senden' (Decision) | Registrierung | System prueft Format und sendet Verifizierungscode |
| 3 | User sieht Hinweis 'Code gesendet' und Eingabefeld fuer Code | Code-Verifizierung | Eingabefeld fuer Verifizierungscode ist aktiv |
| 4 | User gibt Verifizierungscode ein und klickt 'Verifizieren' (Decision) | Code-Verifizierung | System validiert Code und Zeitfenster |
| 5 | User wird bestaetigt und Konto wird erstellt | Erfolg/Willkommen | Account ist erstellt und Telefonnummer als verifiziert markiert |

### Success Criteria

Konto wurde erstellt und die Telefonnummer ist verifiziert

### Error Scenarios

- Ungueltige oder falsch formatierte Telefonnummer
- Falscher oder abgelaufener Verifizierungscode
- Codeversand fehlgeschlagen (z.B. SMS-Gateway-Fehler)

**Diagram:** See `user_flows/flow-001.mmd`

---

## FLOW-002: Zwei-Faktor-Authentifizierung aktivieren, nutzen und deaktivieren

**Actor:** Lena Hoffmann
**Trigger:** User moechte die Kontosicherheit erhoehen oder verwaltet 2FA in den Sicherheitseinstellungen

Flow zum Aktivieren, Verwenden und Deaktivieren der optionalen 2FA mit 6-stelligem PIN

### Steps

| # | Action | Screen | Expected Result |
|---|--------|--------|-----------------|
| 1 | User oeffnet Sicherheits-Einstellungen | Account Settings > Security | Sicherheits-Einstellungen werden angezeigt |
| 2 | User aktiviert den 2FA-Schalter | Account Settings > Security | Dialog zur Einrichtung der 2FA wird angezeigt |
| 3 | System sendet 6-stelligen PIN und User gibt PIN ein (Decision) | 2FA Setup Dialog | PIN-Eingabe wird akzeptiert |
| 4 | User bestaetigt PIN | 2FA Setup Dialog | 2FA wird aktiviert und als 'Aktiv' angezeigt |
| 5 | User loggt sich aus und wieder ein | Login | Login mit Benutzername/Passwort wird akzeptiert, 2FA-PIN wird angefordert |
| 6 | User gibt 6-stelligen PIN ein (Decision) | 2FA PIN Eingabe | Bei korrektem PIN wird Zugriff gewaehrt |
| 7 | User deaktiviert 2FA in den Sicherheits-Einstellungen | Account Settings > Security | 2FA wird deaktiviert und als 'Inaktiv' angezeigt |

### Success Criteria

2FA wurde erfolgreich aktiviert, fuer Login verwendet und kann bei Bedarf deaktiviert werden

### Error Scenarios

- Falscher 6-stelliger PIN bei Aktivierung oder Login
- PIN nicht erhalten
- Systemfehler beim Aktivieren/Deaktivieren
- Zugriff verweigert, wenn User nicht eingeloggt ist

**Diagram:** See `user_flows/flow-002.mmd`

---

## FLOW-003: Biometrische Entsperrung

**Actor:** Lena Hoffmann
**Trigger:** User öffnet die App

Flow zum Entsperren der App per Fingerabdruck oder Face ID

### Steps

| # | Action | Screen | Expected Result |
|---|--------|--------|-----------------|
| 1 | User öffnet die App (Decision) | App-Startbildschirm | Prüfung, ob biometrische Entsperrung aktiviert und verfügbar ist |
| 2 | App fordert biometrische Authentifizierung an | Biometrischer Dialog (System) | Systemdialog für Fingerabdruck oder Face ID wird angezeigt |
| 3 | User authentifiziert sich biometrisch (Decision) | Biometrischer Dialog (System) | Biometrische Prüfung erfolgreich |
| 4 | App gewährt Zugriff | Start-/Dashboard | User ist eingeloggt und sieht das Dashboard |
| 5 | User wählt alternative Anmeldung | Login (Passwort/PIN) | User kann sich mit Passwort oder PIN anmelden |
| 6 | User meldet sich mit Passwort oder PIN an | Login (Passwort/PIN) | User ist eingeloggt und sieht das Dashboard |

### Success Criteria

User erhält Zugang zur App entweder per Biometrie oder alternativ per Passwort/PIN

### Error Scenarios

- Biometrische Prüfung fehlgeschlagen -> alternative Anmeldung erforderlich
- Gerät unterstützt keine Biometrie oder nicht eingerichtet -> biometrische Option wird nicht angeboten
- Falsches Passwort/PIN oder zu viele Fehlversuche

**Diagram:** See `user_flows/flow-003.mmd`

---

## FLOW-004: Multi-Device Support

**Actor:** Lena Hoffmann
**Trigger:** User meldet sich auf einem weiteren Geraet mit demselben Account an

Flow zur parallelen Nutzung des Systems auf mehreren Geraeten ohne Sitzungsabbruch

### Steps

| # | Action | Screen | Expected Result |
|---|--------|--------|-----------------|
| 1 | User ist auf Geraet A bereits eingeloggt und arbeitet im System | Beliebiger Arbeitsbereich | Sitzung auf Geraet A ist aktiv |
| 2 | User oeffnet auf Geraet B die Login-Seite | Login | Login-Formular wird angezeigt |
| 3 | User gibt Zugangsdaten ein und klickt auf 'Anmelden' (Decision) | Login | Authentifizierung erfolgreich |
| 4 | System erkennt bestehende Sitzung auf Geraet A und erlaubt parallele Nutzung | Startseite/Dashboard | Dashboard auf Geraet B wird geladen, Sitzung auf Geraet A bleibt aktiv |
| 5 | User fuehrt eine Aktion auf Geraet B aus (z. B. Task aktualisieren) | Detailansicht/Editor | Aktion wird erfolgreich gespeichert, Sitzung auf Geraet A bleibt aktiv |
| 6 | User wechselt zu Geraet A und fuehrt dort eine Aktion aus | Detailansicht/Editor | Aktion wird erfolgreich verarbeitet, Sitzung auf Geraet B bleibt aktiv |
| 7 | User startet Login auf Geraet C (drittes Geraet) mit demselben Account | Login | Login-Formular wird angezeigt |
| 8 | User meldet sich an | Login | System erlaubt dritte Sitzung ohne Abmeldung anderer Geraete |

### Success Criteria

User kann gleichzeitig auf mehreren Geraeten arbeiten, ohne dass bestehende Sitzungen beendet werden

### Error Scenarios

- Parallele Sitzung wird blockiert
- Sitzung auf einem anderen Geraet wird unerwartet beendet
- Datenkonflikte bei gleichzeitiger Bearbeitung

**Diagram:** See `user_flows/flow-004.mmd`

---

## FLOW-005: Passkey-Login

**Actor:** Lena Hoffmann
**Trigger:** User klickt auf 'Mit Passkey anmelden' auf der Login-Seite

Flow zur Anmeldung mit Passkey statt Passwort

### Steps

| # | Action | Screen | Expected Result |
|---|--------|--------|-----------------|
| 1 | User oeffnet Login-Seite | Login | Login-Optionen werden angezeigt |
| 2 | User waehlt 'Mit Passkey anmelden' (Decision) | Login | System prueft, ob ein Passkey fuer das Konto vorhanden ist |
| 3 | System zeigt Hinweis 'Kein Passkey vorhanden' und bietet alternative Login-Methoden | Login | User kann alternative Methode waehlen |
| 4 | System startet Passkey-Authentifizierung auf dem Geraet (Decision) | Passkey-Dialog (System) | User wird zur Geraeteauthentifizierung aufgefordert |
| 5 | User bestaetigt Geraeteauthentifizierung (Biometrie/PIN) (Decision) | Passkey-Dialog (System) | Passkey-Authentifizierung erfolgreich abgeschlossen |
| 6 | System meldet User erfolgreich an | Dashboard | User ist eingeloggt und sieht das Dashboard |
| 7 | System zeigt Fehlermeldung und bietet 'Erneut versuchen' oder alternative Login-Methode | Login | User kann Passkey erneut versuchen oder andere Methode waehlen |

### Success Criteria

User ist erfolgreich mit Passkey authentifiziert und eingeloggt

### Error Scenarios

- Kein Passkey registriert
- Passkey-Authentifizierung fehlgeschlagen oder abgebrochen
- Geraeteauthentifizierung nicht verfuegbar

**Diagram:** See `user_flows/flow-005.mmd`

---

