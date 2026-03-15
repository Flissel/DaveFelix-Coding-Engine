# Zwei-Faktor-Authentifizierung

**ID:** `SCREEN-001`
**Route:** `/settings/2fa`
**Layout:** single-column

Screen to enable and configure two-factor authentication with a 6-digit PIN, including toggle activation, PIN entry, confirmation, and optional recovery email

---

## Components Used

- `COMP-001`
- `COMP-002`
- `COMP-003`
- `COMP-004`
- `COMP-009`
- `COMP-010`

---

## Data Requirements

- `GET /api/settings/2fa/status`
- `POST /api/settings/2fa/enable`
- `POST /api/settings/2fa/disable`
- `POST /api/settings/2fa/verify-pin`

---

## Related User Story

`US-002`

---

## Wireframe

```
     0    5   10   15   20   25   30   35   40   45   50   55   60
   0 +------------------------------------------------------------+
     |  [<Back]   Zwei-Faktor-Authentifizierung        [...]     |
   2 |                    COMP-004 (TopBar)                      |
     +------------------------------------------------------------+
   4 |                                                            |
     |  Sicherheit                                                |
   6 |  +------------------------------------------------------+ |
     |  | Zwei-Faktor-Authentifizierung          [ToggleSwitch] | |
   8 |  | COMP-009                                              | |
     |  +------------------------------------------------------+ |
  10 |                                                            |
     |     Geben Sie eine 6-stellige PIN ein:                     |
  12 |          +--------------------------------------+          |
     |          |  [ _ ] [ _ ] [ _ ] [ _ ] [ _ ] [ _ ] |          |
  14 |          |       COMP-003 (OTPInput PIN)        |          |
     |          +--------------------------------------+          |
  16 |                                                            |
     |     PIN bestätigen:                                        |
  18 |          +--------------------------------------+          |
     |          |  [ _ ] [ _ ] [ _ ] [ _ ] [ _ ] [ _ ] |          |
  20 |          |     COMP-003 (OTPInput Confirm)      |          |
     |          +--------------------------------------+          |
  22 |                                                            |
     |  Wiederherstellungs-E-Mail (optional):                     |
  24 |  +------------------------------------------------------+ |
     |  |  email@example.com                                    | |
  26 |  |  COMP-002 (TextInput Recovery Email)                  | |
     |  +------------------------------------------------------+ |
  28 |                                                            |
     |  Hinweis: Sie benötigen diese PIN beim erneuten           |
  30 |  Registrieren Ihrer Telefonnummer bei WhatsApp.           |
     |              +------------------------------+              |
  32 |              |     2FA Aktivieren           |              |
     |              |     COMP-001 (Button)        |              |
  34 |              +------------------------------+              |
     |                                                            |
  36 +------------------------------------------------------------+
     |                                                            |
     |  +----------------------------------------------+          |
  38 |  |        COMP-010 (ModalDialog)                |          |
     |  |  Möchten Sie 2FA wirklich aktivieren?        |          |
  40 |  |                                              |          |
     |  |  [Abbrechen]            [Bestätigen]         |          |
  42 |  +----------------------------------------------+          |
     |  (Modal appears on activation confirmation)                |
  44 +------------------------------------------------------------+
```

---

## Component Layout

| ID | Name | X | Y | W | H |
|-----|------|---|---|---|---|
| COMP-004 | TopBar | 0 | 0 | 60 | 4 |
| COMP-009 | ToggleSwitch | 4 | 6 | 52 | 3 |
| COMP-003 | OTPInput (PIN Entry) | 10 | 11 | 40 | 5 |
| COMP-003-confirm | OTPInput (PIN Confirm) | 10 | 17 | 40 | 5 |
| COMP-002 | TextInput (Recovery Email) | 4 | 24 | 52 | 4 |
| COMP-001 | Button (Activate) | 14 | 30 | 32 | 4 |
| COMP-010 | ModalDialog (Confirm) | 8 | 10 | 44 | 16 |
