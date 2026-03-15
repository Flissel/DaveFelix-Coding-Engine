# User Flows

## FLOW-001: Telefonnummer-Registrierung

**Actor:** Laura Schmitt
**Trigger:** User oeffnet Registrierungsseite

Flow zur Registrierung und Verifizierung einer Telefonnummer

### Steps

| # | Action | Screen | Expected Result |
|---|--------|--------|-----------------|
| 1 | User oeffnet die Registrierungsseite | Registrierung | Registrierungsformular mit Telefonnummernfeld wird angezeigt |
| 2 | User gibt Telefonnummer ein und sendet Registrierung ab (Decision) | Registrierung | System validiert die Telefonnummer und sendet einen Verifizierungscode |
| 3 | System zeigt Hinweis zur Code-Zustellung und Eingabefeld fuer Verifizierungscode (Decision) | Code-Verifizierung | User sieht Eingabefeld und Zeitlimit fuer Code |
| 4 | User gibt Verifizierungscode ein und bestaetigt (Decision) | Code-Verifizierung | System prueft den Code |
| 5 | System bestaetigt Verifizierung und erstellt Konto | Erfolgsbestaetigung | Telefonnummer ist verifiziert; Zugriff auf die Plattform wird innerhalb von 5 Sekunden gewaehrt |

### Success Criteria

Konto ist erstellt, Telefonnummer verifiziert und Zugang zur Plattform gewaehrt

### Error Scenarios

- Ungueltige oder unvollstaendige Telefonnummer
- Zustellung des Verifizierungscodes nicht moeglich
- Falscher oder abgelaufener Verifizierungscode
- Systemverzoegerung verhindert Zugriff innerhalb von 5 Sekunden

**Diagram:** See `user_flows/flow-001.mmd`

---

## FLOW-002: Zwei-Faktor-Authentifizierung aktivieren und verwenden

**Actor:** Laura Schmitt
**Trigger:** User oeffnet Sicherheits-Einstellungen und moechte 2FA aktivieren

Flow zum Aktivieren der 2FA mit 6-stelliger PIN und anschließender Anmeldung mit PIN

### Steps

| # | Action | Screen | Expected Result |
|---|--------|--------|-----------------|
| 1 | User oeffnet Einstellungen | Einstellungen | Einstellungsmenue wird angezeigt |
| 2 | User navigiert zu 'Sicherheit' | Sicherheit | Sicherheitsoptionen werden angezeigt |
| 3 | User klickt 'Zwei-Faktor-Authentifizierung aktivieren' | Sicherheit | PIN-Eingabedialog erscheint |
| 4 | User gibt eine 6-stellige PIN ein (Decision) | PIN-Eingabe | PIN wird validiert |
| 5 | User bestaetigt die PIN | PIN-Bestaetigung | 2FA wird aktiviert und PIN als zweiter Faktor gespeichert |
| 6 | User loggt sich aus | Menue | Logout erfolgreich, Login-Screen wird angezeigt |
| 7 | User gibt Benutzername und Passwort ein und klickt 'Anmelden' (Decision) | Login | PIN-Abfrage wird angezeigt |
| 8 | User gibt die 6-stellige PIN ein (Decision) | PIN-Abfrage | PIN wird geprueft |
| 9 | System validiert PIN (Decision) | PIN-Abfrage | Bei korrekter PIN erfolgt erfolgreicher Login |
| 10 | User wird in die App weitergeleitet | Dashboard | User ist erfolgreich angemeldet |

### Success Criteria

2FA ist aktiviert und ein Login mit korrektem Passwort sowie korrekter 6-stelliger PIN ist erfolgreich

### Error Scenarios

- PIN hat weniger oder mehr als 6 Stellen
- Falsche PIN bei der Anmeldung
- PIN fehlt bei der Anmeldung
- Serververbindung fehlgeschlagen beim Aktivieren von 2FA

**Diagram:** See `user_flows/flow-002.mmd`

---

## FLOW-003: App per Biometrie entsperren

**Actor:** Laura Schmitt
**Trigger:** User oeffnet die App

Flow zum Entsperren der App mittels Fingerabdruck oder Face ID inkl. Fallback

### Steps

| # | Action | Screen | Expected Result |
|---|--------|--------|-----------------|
| 1 | User tippt auf App-Icon | Splash Screen | App startet und prueft Authentifizierungsoptionen |
| 2 | System prueft, ob Biometrie aktiviert und am Geraet eingerichtet ist (Decision) | Authentifizierungs-Check | Biometrische Abfrage wird vorbereitet oder Passwort-Login angezeigt |
| 3 | Biometrische Abfrage wird angezeigt | Biometrie-Prompt | User kann Fingerabdruck/Face ID scannen |
| 4 | User bestaetigt Biometrie erfolgreich (Decision) | Biometrie-Prompt | App wird innerhalb von 2 Sekunden entsperrt |
| 5 | App zeigt Hauptansicht | Chats/Home | User ist eingeloggt und kann die App nutzen |
| 6 | Biometrische Pruefung schlaegt fehl (Decision) | Biometrie-Prompt | Fallback zur Passworteingabe wird angezeigt |
| 7 | User gibt Passwort ein (Decision) | Passwort-Login | Bei korrektem Passwort Zugriff auf App |
| 8 | Geraet unterstuetzt keine Biometrie oder ist deaktiviert | Passwort-Login | User wird ausschliesslich zur Passworteingabe aufgefordert |

### Success Criteria

App wird nach erfolgreicher Biometrie innerhalb von 2 Sekunden entsperrt oder nach Passwort-Login geoeffnet

### Error Scenarios

- Biometrische Pruefung fehlgeschlagen -> Passwort-Fallback
- Biometrie nicht verfuegbar oder deaktiviert -> Passwort-Login
- Zeitueberschreitung beim Entsperren
- Falsches Passwort -> erneute Eingabe

**Diagram:** See `user_flows/flow-003.mmd`

---

## FLOW-004: Multi-Device Support nutzen

**Actor:** Laura Schmitt
**Trigger:** User meldet sich mit demselben Konto auf einem zweiten Gerät an

Flow zur Nutzung des Dienstes auf zwei Geräten mit Synchronisation von Nachrichten, Benachrichtigungen und Lesestatus sowie Handling des Geräte-Limits

### Steps

| # | Action | Screen | Expected Result |
|---|--------|--------|-----------------|
| 1 | User öffnet die App auf Gerät A und ist bereits angemeldet | Chat-Übersicht | Chat-Übersicht wird angezeigt |
| 2 | User öffnet die App auf Gerät B und meldet sich mit demselben Konto an | Login | Anmeldung erfolgreich, Chat-Übersicht erscheint |
| 3 | User sendet eine Nachricht auf Gerät A | Chat | Nachricht wird als gesendet markiert |
| 4 | System synchronisiert die gesendete Nachricht auf Gerät B | Chat (Gerät B) | Nachricht erscheint innerhalb von 2 Sekunden und ist als gesendet markiert |
| 5 | User erhält eine neue Nachricht auf Gerät A | Chat-Übersicht (Gerät A) | Push-Benachrichtigung wird auf Gerät A angezeigt |
| 6 | System zeigt die Benachrichtigung auch auf Gerät B an | Chat-Übersicht (Gerät B) | Benachrichtigung erscheint auf beiden Geräten |
| 7 | User öffnet die neue Nachricht auf Gerät B | Chat (Gerät B) | Nachricht wird als gelesen markiert |
| 8 | System synchronisiert den Lesestatus auf Gerät A | Chat (Gerät A) | Lesestatus wird auf beiden Geräten aktualisiert |
| 9 | Drittes Gerät versucht, sich mit demselben Konto anzumelden (Decision) | Login | System prüft Geräte-Limit |
| 10 | Geräte-Limit erreicht -> System zeigt Fehlermeldung | Login | Verständliche Fehlermeldung, keine neue Sitzung erstellt |

### Success Criteria

Nachrichten, Benachrichtigungen und Lesestatus werden zwischen zwei Geräten innerhalb von 2 Sekunden synchronisiert; Anmeldung eines dritten Geräts wird verständlich abgelehnt

### Error Scenarios

- Synchronisation der Nachricht überschreitet 2 Sekunden
- Benachrichtigungen erscheinen nicht auf beiden Geräten
- Lesestatus wird nicht auf beiden Geräten aktualisiert
- Anmeldung eines dritten Geräts wird nicht korrekt blockiert

**Diagram:** See `user_flows/flow-004.mmd`

---

## FLOW-005: Passkey-Anmeldung

**Actor:** Laura Schmitt
**Trigger:** User waehlt im Login-Bildschirm die Option 'Mit Passkey anmelden'

Flow zur passwortlosen Anmeldung per Passkey

### Steps

| # | Action | Screen | Expected Result |
|---|--------|--------|-----------------|
| 1 | User oeffnet die App und sieht den Login-Bildschirm | Login | Login-Optionen werden angezeigt |
| 2 | User klickt auf 'Mit Passkey anmelden' (Decision) | Login | System prueft, ob ein Passkey fuer den Nutzer auf dem Geraet vorhanden ist |
| 3 | System erkennt, dass kein Passkey vorhanden ist | Login | Hinweismeldung wird angezeigt und alternative Anmeldeoptionen werden angeboten |
| 4 | System erkennt, dass ein Passkey vorhanden ist und startet die Geraete-Authentifizierung (Biometrie/PIN) (Decision) | Geraete-Authentifizierung | Authentifizierungsdialog wird angezeigt |
| 5 | User bestaetigt die biometrische oder Geraete-Authentifizierung (Decision) | Geraete-Authentifizierung | Authentifizierung wird innerhalb von 3 Sekunden abgeschlossen |
| 6 | System erstellt eine Session und leitet den User in die App weiter | Chat-Übersicht | User ist erfolgreich angemeldet |
| 7 | Geraete-Authentifizierung schlaegt fehl | Geraete-Authentifizierung | Fehlermeldung wird angezeigt, Login wird abgebrochen und keine Session erstellt |

### Success Criteria

User wird innerhalb von 3 Sekunden per Passkey angemeldet und eine Session wird erstellt

### Error Scenarios

- Kein Passkey auf dem Geraet hinterlegt
- Biometrische oder Geraete-Authentifizierung fehlgeschlagen
- Authentifizierung dauert laenger als 3 Sekunden

**Diagram:** See `user_flows/flow-005.mmd`

---

