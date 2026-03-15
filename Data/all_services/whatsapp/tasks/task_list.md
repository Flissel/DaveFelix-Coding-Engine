# Task List - Project Tasks

## Summary

| Metric | Value |
|--------|-------|
| Total Tasks | 38 |
| Total Hours | 322h |
| Total Story Points | 208 |

---

## Critical Path

The following tasks are on the critical path:

1. `TASK-001`
2. `TASK-002`
3. `TASK-003`
4. `TASK-005`
5. `TASK-026`

---

## Tasks by Feature

### FEAT-001

| Tasks | Hours | Points |
|-------|-------|--------|
| 6 | 60h | 39 |

#### TASK-001: Auth-Flow UX für Registrierung & 2FA entwerfen

- **Type:** design
- **Complexity:** medium
- **Estimated:** 8h / 5 points
- **Skills:** ux, ui, mobile-design
- **Assignee:** Product Designer

Erstelle UX/UI-Designs für Telefonnummer-Registrierung, OTP-Verifizierung und 2FA-Flow inkl. Fehlerzustände, Resend-Mechanik und Onboarding-Screens.

**Acceptance Criteria:**
- [ ] Wireframes und High-Fidelity Screens für Registrierung & 2FA vorhanden
- [ ] Fehler- und Erfolgszustände dokumentiert
- [ ] Designs sind im Design-System abgelegt

---

#### TASK-002: Telefonnummer-Registrierung implementieren

- **Type:** development
- **Complexity:** complex
- **Estimated:** 12h / 8 points
- **Skills:** frontend, mobile, api-integration
- **Assignee:** Mobile Developer

Implementierung der Registrierung per Telefonnummer inkl. Eingabevalidierung, Versand von OTP und Verifikation gegen Backend-API.

**Acceptance Criteria:**
- [ ] User kann Telefonnummer eingeben und OTP anfordern
- [ ] OTP-Verifikation erfolgreich mit Backend
- [ ] Validierungs- und Fehlermeldungen funktionieren

**Depends on:** TASK-001

---

#### TASK-003: Zwei-Faktor-Authentifizierung (2FA) hinzufügen

- **Type:** development
- **Complexity:** complex
- **Estimated:** 10h / 8 points
- **Skills:** frontend, mobile, security
- **Assignee:** Mobile Developer

Implementiere 2FA-Flow für Login nach Registrierung inkl. OTP-Eingabe, Resend-Option und Sperrlogik bei Fehlversuchen.

**Acceptance Criteria:**
- [ ] 2FA wird nach Login ausgelöst
- [ ] Resend-Mechanik mit Timer vorhanden
- [ ] Fehlversuche werden limitiert und angezeigt

**Depends on:** TASK-002

---

#### TASK-004: Biometrische Entsperrung integrieren

- **Type:** development
- **Complexity:** medium
- **Estimated:** 8h / 5 points
- **Skills:** mobile, security
- **Assignee:** Mobile Developer

Integriere biometrisches Entsperren (FaceID/TouchID) mit Fallback auf PIN/Passwort. Einstellungen zur Aktivierung/Deaktivierung bereitstellen.

**Acceptance Criteria:**
- [ ] Biometrische Entsperrung funktioniert auf unterstützten Geräten
- [ ] Fallback-Mechanismus vorhanden
- [ ] Einstellung zur Aktivierung/Deaktivierung verfügbar

**Depends on:** TASK-003

---

#### TASK-005: Multi-Device & Passkey Unterstützung hinzufügen

- **Type:** development
- **Complexity:** complex
- **Estimated:** 14h / 8 points
- **Skills:** backend, security, auth
- **Assignee:** Backend Developer

Implementiere Multi-Device Sessions und Passkey-Login (wo unterstützt). Backend-Token Handling und Device-Management integrieren.

**Acceptance Criteria:**
- [ ] Mehrere Geräte können parallel authentifiziert werden
- [ ] Passkey-Login funktioniert auf unterstützten Plattformen
- [ ] Device-Session-Übersicht verfügbar

**Depends on:** TASK-003

---

#### TASK-006: Auth-Tests & Dokumentation

- **Type:** testing
- **Complexity:** medium
- **Estimated:** 8h / 5 points
- **Skills:** qa, documentation, auth
- **Assignee:** QA Engineer

Erstelle Testfälle für Registrierung, 2FA, Biometrie und Passkeys. Aktualisiere Entwicklerdokumentation für Auth-APIs und Flows.

**Acceptance Criteria:**
- [ ] Testfälle für alle Auth-Flows vorhanden und ausgeführt
- [ ] Dokumentation für Auth-APIs aktualisiert
- [ ] Testreport erstellt und abgelegt

**Depends on:** TASK-002, TASK-003, TASK-004, TASK-005

---

### FEAT-002

| Tasks | Hours | Points |
|-------|-------|--------|
| 7 | 68h | 41 |

#### TASK-007: Auth-Flow UX/UI konzipieren

- **Type:** design
- **Complexity:** medium
- **Estimated:** 8h / 5 points
- **Skills:** ux, ui, wireframing
- **Assignee:** UX/UI Designer

Erstelle die UX/UI für Telefonnummer-Registrierung, 2FA, biometrische Entsperrung sowie Multi-Device/Passkey-Flows inkl. Zustandsdiagramm.

**Acceptance Criteria:**
- [ ] Wireframes für alle Auth-Screens vorhanden
- [ ] Flow-Diagramm für Registrierung, 2FA, Biometrie und Passkey dokumentiert

---

#### TASK-008: Backend: Telefonnummer-Registrierung & SMS-OTP

- **Type:** development
- **Complexity:** complex
- **Estimated:** 12h / 8 points
- **Skills:** backend, security, nodejs
- **Assignee:** Backend Developer

Implementiere die Registrierung via Telefonnummer inkl. SMS-OTP Versand, Rate-Limiting und Verifizierung.

**Acceptance Criteria:**
- [ ] OTP wird per SMS versendet und verifiziert
- [ ] Rate-Limit und Fehlversuche werden serverseitig geprüft

---

#### TASK-009: Backend: 2FA, Multi-Device & Passkey Support

- **Type:** development
- **Complexity:** complex
- **Estimated:** 14h / 8 points
- **Skills:** backend, security, webauthn
- **Assignee:** Backend Developer

Implementiere 2FA-Mechanik (z.B. TOTP), Geräte-Registrierung/Entzug sowie Passkey-Registrierung und Validierung.

**Acceptance Criteria:**
- [ ] 2FA kann pro Nutzer aktiviert/deaktiviert werden
- [ ] Mehrere Geräte werden verwaltet und entzogen
- [ ] Passkey-Registrierung und Login sind validiert

**Depends on:** TASK-002

---

#### TASK-010: Frontend: Auth-Screens für Registrierung & 2FA

- **Type:** development
- **Complexity:** complex
- **Estimated:** 12h / 8 points
- **Skills:** frontend, typescript, react
- **Assignee:** Frontend Developer

Erstelle UI und Logik für Telefonnummer-Registrierung, OTP-Eingabe, 2FA-Setup/Login sowie Fehlerzustände.

**Acceptance Criteria:**
- [ ] Registrierung und 2FA-Flows sind vollständig bedienbar
- [ ] Fehler- und Ladezustände werden korrekt angezeigt

**Depends on:** TASK-001, TASK-002, TASK-003

---

#### TASK-011: Frontend: Biometrie & Passkey Integration

- **Type:** development
- **Complexity:** complex
- **Estimated:** 10h / 5 points
- **Skills:** mobile, biometrics, webauthn
- **Assignee:** Mobile Developer

Integriere biometrische Entsperrung (Face/Touch ID) sowie Passkey-Login in der Client-App.

**Acceptance Criteria:**
- [ ] Biometrische Entsperrung kann aktiviert und genutzt werden
- [ ] Passkey-Login funktioniert auf unterstützten Geräten

**Depends on:** TASK-001, TASK-003

---

#### TASK-012: E2E-Tests für Auth-Flows

- **Type:** testing
- **Complexity:** medium
- **Estimated:** 8h / 5 points
- **Skills:** qa, automation, e2e-testing
- **Assignee:** QA Engineer

Erstelle automatisierte Tests für Registrierung, 2FA, Biometrie, Multi-Device und Passkey-Login.

**Acceptance Criteria:**
- [ ] Alle kritischen Auth-Flows sind automatisiert abgedeckt
- [ ] Tests laufen stabil in der CI-Pipeline

**Depends on:** TASK-002, TASK-003, TASK-004, TASK-005

---

#### TASK-013: Dokumentation: Authentifizierungs-Setup

- **Type:** documentation
- **Complexity:** simple
- **Estimated:** 4h / 2 points
- **Skills:** technical-writing, security
- **Assignee:** Technical Writer

Dokumentiere Setup, Konfiguration und Sicherheitsaspekte (2FA, Passkeys, Multi-Device, Biometrie) für Entwickler und Support.

**Acceptance Criteria:**
- [ ] Setup-Anleitung ist vollständig und nachvollziehbar
- [ ] Sicherheits- und Betriebsanforderungen sind dokumentiert

**Depends on:** TASK-003, TASK-004, TASK-005

---

### FEAT-003

| Tasks | Hours | Points |
|-------|-------|--------|
| 7 | 72h | 48 |

#### TASK-014: Auth-Flow Architektur & UI-Flows definieren

- **Type:** design
- **Complexity:** medium
- **Estimated:** 8h / 5 points
- **Skills:** ux, system-design
- **Assignee:** UX Designer

Erarbeiten der integrierten Authentifizierungs- und Registrierungsflüsse (Telefonnummer, 2FA, Biometrie, Passkey, Multi-Device). Erstellung von User Flow Diagrammen und UI-Zustandsmodellen für Integration.

**Acceptance Criteria:**
- [ ] Vollständige User Flow Diagramme liegen vor
- [ ] UI-Zustandsmodell deckt alle Anforderungen ab
- [ ] Freigabe durch Product Owner dokumentiert

---

#### TASK-015: Telefonnummer-Registrierung integrieren

- **Type:** development
- **Complexity:** complex
- **Estimated:** 12h / 8 points
- **Skills:** frontend, backend, api-integration
- **Assignee:** Fullstack Developer

Implementierung der Telefonnummer-Registrierung inkl. Validierung, OTP-Anforderung und Backend-Integration gemäß WA-AUTH-001.

**Acceptance Criteria:**
- [ ] Telefonnummern-Input validiert Formate
- [ ] OTP-Anforderung erfolgreich an Backend
- [ ] Registrierung abgeschlossen und Nutzerprofil erstellt

**Depends on:** TASK-001

---

#### TASK-016: Zwei-Faktor-Authentifizierung integrieren

- **Type:** development
- **Complexity:** complex
- **Estimated:** 10h / 8 points
- **Skills:** frontend, backend, security
- **Assignee:** Fullstack Developer

Implementierung des 2FA-Mechanismus inklusive OTP-Eingabe, Fehlerbehandlung und Session-Hardening gemäß WA-AUTH-002.

**Acceptance Criteria:**
- [ ] OTP wird abgefragt und validiert
- [ ] Fehlerfälle (falscher Code, Timeout) sind abgedeckt
- [ ] Session erst nach erfolgreicher 2FA aktiviert

**Depends on:** TASK-002

---

#### TASK-017: Biometrische Entsperrung & Passkey Support implementieren

- **Type:** development
- **Complexity:** complex
- **Estimated:** 14h / 8 points
- **Skills:** mobile, security, platform-auth
- **Assignee:** Mobile Developer

Implementierung der Biometrie-Integration (z.B. FaceID/TouchID) sowie Passkey-Unterstützung für Login gemäß WA-AUTH-003 und WA-AUTH-005.

**Acceptance Criteria:**
- [ ] Biometrische Anmeldung aktiviert und getestet
- [ ] Passkey-Login funktioniert auf unterstützten Plattformen
- [ ] Fallback auf PIN/OTP implementiert

**Depends on:** TASK-003

---

#### TASK-018: Multi-Device Session Handling integrieren

- **Type:** development
- **Complexity:** complex
- **Estimated:** 12h / 8 points
- **Skills:** backend, security, api-design
- **Assignee:** Backend Developer

Implementierung der Multi-Device-Unterstützung inkl. Geräteverwaltung, Session-Rotation und Abmeldung je Gerät gemäß WA-AUTH-004.

**Acceptance Criteria:**
- [ ] Mehrere Geräte können parallel angemeldet sein
- [ ] Geräteübersicht inkl. Abmeldung vorhanden
- [ ] Sessions sind sicher rotiert und invalidierbar

**Depends on:** TASK-003

---

#### TASK-019: Integrationstests für Auth-Flows erstellen

- **Type:** testing
- **Complexity:** complex
- **Estimated:** 10h / 8 points
- **Skills:** qa, automation, testing
- **Assignee:** QA Engineer

Erstellung automatisierter Tests für Telefonnummer-Registrierung, 2FA, Biometrie, Passkey und Multi-Device-Szenarien.

**Acceptance Criteria:**
- [ ] Testabdeckung für alle Auth-Flows vorhanden
- [ ] Tests laufen stabil in CI
- [ ] Fehlerfälle sind inkludiert

**Depends on:** TASK-002, TASK-003, TASK-004, TASK-005

---

#### TASK-020: Technische Dokumentation & Betriebsanleitung

- **Type:** documentation
- **Complexity:** medium
- **Estimated:** 6h / 3 points
- **Skills:** technical-writing, security
- **Assignee:** Technical Writer

Dokumentation der Authentifizierungsflüsse, API-Endpunkte, Konfigurationen und Hinweise für Betrieb/Support.

**Acceptance Criteria:**
- [ ] Dokumentation ist vollständig und versioniert
- [ ] Betriebshinweise (Rollout, Support) enthalten
- [ ] Review durch Engineering abgeschlossen

**Depends on:** TASK-004, TASK-005

---

### FEAT-004

| Tasks | Hours | Points |
|-------|-------|--------|
| 7 | 74h | 45 |

#### TASK-021: Auth-Flow Design & Spezifikation

- **Type:** design
- **Complexity:** medium
- **Estimated:** 8h / 5 points
- **Skills:** ux, security, authentication
- **Assignee:** UX Designer

Erstelle detaillierte Spezifikation und Ablaufdiagramme für Telefonnummer-Registrierung, 2FA, biometrische Entsperrung, Multi-Device Support und Passkeys.

**Acceptance Criteria:**
- [ ] Ablaufdiagramme für alle Auth-Flows vorhanden
- [ ] Spezifikation deckt Requirements WA-AUTH-001 bis WA-AUTH-005 ab
- [ ] Stakeholder-Review abgeschlossen

---

#### TASK-022: Backend: Telefonnummer-Registrierung & OTP

- **Type:** development
- **Complexity:** complex
- **Estimated:** 12h / 8 points
- **Skills:** backend, nodejs, security
- **Assignee:** Backend Developer

Implementiere Server-Endpunkte für Telefonnummer-Registrierung und OTP-Versand/Validierung inkl. Rate-Limiting und Logging.

**Acceptance Criteria:**
- [ ] Telefonnummer-Registrierung speichert validierte Nummer
- [ ] OTP kann versendet und geprüft werden
- [ ] Rate-Limiting verhindert Missbrauch

**Depends on:** TASK-001

---

#### TASK-023: Backend: 2FA, Multi-Device & Passkeys

- **Type:** development
- **Complexity:** complex
- **Estimated:** 14h / 8 points
- **Skills:** backend, webauthn, security
- **Assignee:** Backend Developer

Erweitere Auth-Logik um 2FA-Status, Geräteverwaltung (multi-device) und Passkey-Registrierung/Verifizierung.

**Acceptance Criteria:**
- [ ] 2FA kann aktiviert/deaktiviert werden
- [ ] Mehrere Geräte pro Benutzer verwaltbar
- [ ] Passkey-Registrierung und Login funktionieren

**Depends on:** TASK-002

---

#### TASK-024: Frontend: Auth UI (Telefonnummer, 2FA, Passkey)

- **Type:** development
- **Complexity:** complex
- **Estimated:** 12h / 8 points
- **Skills:** frontend, typescript, react
- **Assignee:** Frontend Developer

Implementiere UI-Komponenten für Telefonnummer-Registrierung, OTP-Eingabe, 2FA-Aktivierung und Passkey-Login.

**Acceptance Criteria:**
- [ ] UI deckt alle Auth-Flows ab
- [ ] Fehler- und Erfolgsmeldungen werden angezeigt
- [ ] UI ist responsiv und barrierearm

**Depends on:** TASK-001, TASK-002

---

#### TASK-025: Mobile: Biometrische Entsperrung

- **Type:** development
- **Complexity:** complex
- **Estimated:** 10h / 5 points
- **Skills:** mobile, ios, android, security
- **Assignee:** Mobile Developer

Integriere biometrische Entsperrung (FaceID/TouchID) in der mobilen App inkl. Fallback-Logik.

**Acceptance Criteria:**
- [ ] Biometrische Entsperrung aktiviert/deaktiviert über Einstellungen
- [ ] Fallback auf PIN/Passwort bei Fehler
- [ ] Erfolgreiche Entsperrung triggert Login-Session

**Depends on:** TASK-001

---

#### TASK-026: Tests: Auth-Flows & Sicherheit

- **Type:** testing
- **Complexity:** complex
- **Estimated:** 12h / 8 points
- **Skills:** qa, automation, security
- **Assignee:** QA Engineer

Erstelle automatisierte Tests für Telefonnummer-Registrierung, OTP, 2FA, Passkeys und biometrische Entsperrung inkl. Security-Checks.

**Acceptance Criteria:**
- [ ] Mindestens 80% Testabdeckung für Auth-Endpunkte
- [ ] UI-Tests für OTP und 2FA vorhanden
- [ ] Security-Tests (Rate-Limit, Replay-Attacke) dokumentiert

**Depends on:** TASK-002, TASK-003, TASK-004, TASK-005

---

#### TASK-027: Dokumentation & Betriebsanleitung

- **Type:** documentation
- **Complexity:** medium
- **Estimated:** 6h / 3 points
- **Skills:** documentation, security
- **Assignee:** Technical Writer

Erstelle Entwickler- und Betriebsdokumentation für Auth-Feature inkl. Konfiguration, Passkey-Setup und Multi-Device Verwaltung.

**Acceptance Criteria:**
- [ ] Konfigurationsschritte klar beschrieben
- [ ] API-Endpoints dokumentiert
- [ ] Runbook für Support vorhanden

**Depends on:** TASK-003, TASK-004, TASK-005

---

### DATABASE

| Tasks | Hours | Points |
|-------|-------|--------|
| 10 | 40h | 30 |

#### TASK-028: Create User model and migration

- **Type:** development
- **Complexity:** medium
- **Estimated:** 4h / 3 points
- **Skills:** backend, database, orm
- **Assignee:** Backend Developer

Implement database model for User entity with all attributes and relationships. Create migration script.

**Acceptance Criteria:**
- [ ] User model created with all attributes
- [ ] Migration script works forward and backward
- [ ] Unit tests for model validation

---

#### TASK-029: Create PhoneVerification model and migration

- **Type:** development
- **Complexity:** medium
- **Estimated:** 4h / 3 points
- **Skills:** backend, database, orm
- **Assignee:** Backend Developer

Implement database model for PhoneVerification entity with all attributes and relationships. Create migration script.

**Acceptance Criteria:**
- [ ] PhoneVerification model created with all attributes
- [ ] Migration script works forward and backward
- [ ] Unit tests for model validation

---

#### TASK-030: Create AuthMethod model and migration

- **Type:** development
- **Complexity:** medium
- **Estimated:** 4h / 3 points
- **Skills:** backend, database, orm
- **Assignee:** Backend Developer

Implement database model for AuthMethod entity with all attributes and relationships. Create migration script.

**Acceptance Criteria:**
- [ ] AuthMethod model created with all attributes
- [ ] Migration script works forward and backward
- [ ] Unit tests for model validation

---

#### TASK-031: Create Device model and migration

- **Type:** development
- **Complexity:** medium
- **Estimated:** 4h / 3 points
- **Skills:** backend, database, orm
- **Assignee:** Backend Developer

Implement database model for Device entity with all attributes and relationships. Create migration script.

**Acceptance Criteria:**
- [ ] Device model created with all attributes
- [ ] Migration script works forward and backward
- [ ] Unit tests for model validation

---

#### TASK-032: Create Profile model and migration

- **Type:** development
- **Complexity:** medium
- **Estimated:** 4h / 3 points
- **Skills:** backend, database, orm
- **Assignee:** Backend Developer

Implement database model for Profile entity with all attributes and relationships. Create migration script.

**Acceptance Criteria:**
- [ ] Profile model created with all attributes
- [ ] Migration script works forward and backward
- [ ] Unit tests for model validation

---

#### TASK-033: Create Message model and migration

- **Type:** development
- **Complexity:** medium
- **Estimated:** 4h / 3 points
- **Skills:** backend, database, orm
- **Assignee:** Backend Developer

Implement database model for Message entity with all attributes and relationships. Create migration script.

**Acceptance Criteria:**
- [ ] Message model created with all attributes
- [ ] Migration script works forward and backward
- [ ] Unit tests for model validation

---

#### TASK-034: Create Reaction model and migration

- **Type:** development
- **Complexity:** medium
- **Estimated:** 4h / 3 points
- **Skills:** backend, database, orm
- **Assignee:** Backend Developer

Implement database model for Reaction entity with all attributes and relationships. Create migration script.

**Acceptance Criteria:**
- [ ] Reaction model created with all attributes
- [ ] Migration script works forward and backward
- [ ] Unit tests for model validation

---

#### TASK-035: Create Chat model and migration

- **Type:** development
- **Complexity:** medium
- **Estimated:** 4h / 3 points
- **Skills:** backend, database, orm
- **Assignee:** Backend Developer

Implement database model for Chat entity with all attributes and relationships. Create migration script.

**Acceptance Criteria:**
- [ ] Chat model created with all attributes
- [ ] Migration script works forward and backward
- [ ] Unit tests for model validation

---

#### TASK-036: Create Media model and migration

- **Type:** development
- **Complexity:** medium
- **Estimated:** 4h / 3 points
- **Skills:** backend, database, orm
- **Assignee:** Backend Developer

Implement database model for Media entity with all attributes and relationships. Create migration script.

**Acceptance Criteria:**
- [ ] Media model created with all attributes
- [ ] Migration script works forward and backward
- [ ] Unit tests for model validation

---

#### TASK-037: Create Forwarding model and migration

- **Type:** development
- **Complexity:** medium
- **Estimated:** 4h / 3 points
- **Skills:** backend, database, orm
- **Assignee:** Backend Developer

Implement database model for Forwarding entity with all attributes and relationships. Create migration script.

**Acceptance Criteria:**
- [ ] Forwarding model created with all attributes
- [ ] Migration script works forward and backward
- [ ] Unit tests for model validation

---

### API

| Tasks | Hours | Points |
|-------|-------|--------|
| 1 | 8h | 5 |

#### TASK-038: Implement api API endpoints

- **Type:** development
- **Complexity:** complex
- **Estimated:** 8h / 5 points
- **Skills:** backend, api, rest
- **Assignee:** Backend Developer

Implement 359 endpoints for api resource including validation, error handling, and documentation.

**Acceptance Criteria:**
- [ ] All 359 endpoints implemented
- [ ] Request/response validation
- [ ] OpenAPI documentation updated
- [ ] Integration tests written

---

