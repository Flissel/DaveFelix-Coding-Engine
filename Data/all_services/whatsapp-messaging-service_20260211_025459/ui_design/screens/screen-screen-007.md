# Passkey-Einrichtung

**ID:** `SCREEN-007`
**Route:** `/onboarding/passkey`
**Layout:** single-column-centered

Screen for setting up a passkey after phone number registration and verification. Guides the user through creating a passkey for secure, passwordless authentication on their WhatsApp messaging service account.

---

## Components Used

- `COMP-001`
- `COMP-004`
- `COMP-010`

---

## Data Requirements

- `POST /api/auth/passkey/register-options`
- `POST /api/auth/passkey/register`
- `GET /api/onboarding/status`

---

## Related User Story

`US-001`

---

## Wireframe

```
     0    5   10   15   20   25   30   35   40   45   50   55   60
   0 +------------------------------------------------------------+
     | [< Back]       Passkey-Einrichtung              Step 3/3  |
   2 |  COMP-001      COMP-004 (TopBar)                          |
     |  (Back)                                                   |
   4 +------------------------------------------------------------+
     |                                                            |
   6 |              +------[ Passkey Icon / Illustration ]------+ |
     |              |          🔐                               | |
   8 |              |    Sichern Sie Ihr Konto                  | |
     |              |    mit einem Passkey                      | |
  10 |              |                                           | |
     |              |  Passkeys ersetzen Passwörter und          | |
  12 |              |  ermöglichen eine sichere Anmeldung        | |
     |              |  per Fingerabdruck, Gesichtserkennung      | |
  14 |              |  oder Bildschirmsperre.                    | |
     |              |                                           | |
  16 |              +-------------------------------------------+ |
     |                                                            |
  18 |          +--------------------------------------+          |
     |          | [🔑 Passkey einrichten]               |          |
  20 |          |  COMP-001 (Setup Passkey Button)      |          |
     |          +--------------------------------------+          |
  22 |                  [Später einrichten]                       |
     |                   COMP-001 (Skip)                          |
  24 |                                                            |
     +------------------------------------------------------------+
     |                                                            |
     |  - - - - COMP-010 (ModalDialog) when triggered - - - - -  |
     |  +----------------------------------------------------+   |
  28 |  |  ✅  Passkey erfolgreich eingerichtet!              |   |
     |  |                                                    |   |
  30 |  |  Ihr Konto ist jetzt mit einem Passkey             |   |
     |  |  gesichert. Sie können sich ab sofort              |   |
  32 |  |  sicher und schnell anmelden.                      |   |
     |  |                                                    |   |
  34 |  |         [Weiter zum Chat]                          |   |
     |  |          COMP-001                                  |   |
  36 |  +----------------------------------------------------+   |
     +------------------------------------------------------------+
```

---

## Component Layout

| ID | Name | X | Y | W | H |
|-----|------|---|---|---|---|
| COMP-004 | TopBar | 0 | 0 | 60 | 4 |
| COMP-001-back | Button (Back) | 1 | 1 | 6 | 2 |
| COMP-001-setup | Button (Setup Passkey) | 10 | 18 | 40 | 3 |
| COMP-001-skip | Button (Skip) | 18 | 22 | 24 | 2 |
| COMP-010 | ModalDialog (Passkey Confirm) | 8 | 8 | 44 | 16 |
