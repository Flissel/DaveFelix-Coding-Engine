# 2FA-Setup / Passkey-Unterstützung

**ID:** `SCREEN-008`
**Route:** `/onboarding/2fa`
**Layout:** single-column-centered

Screen for setting up two-factor authentication with passkey support, allowing users to authenticate without a password. Users can set up a PIN as fallback and register a passkey via biometric/device authentication.

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

- `POST /api/auth/2fa/pin-setup`
- `POST /api/auth/passkey/register-options`
- `POST /api/auth/passkey/register`
- `GET /api/auth/passkey/list`
- `DELETE /api/auth/passkey/{id}`

---

## Related User Story

`US-005`

---

## Wireframe

```
     0    5   10   15   20   25   30   35   40   45   50   55   60
   0 +------------------------------------------------------------+
     |  [<Back]     2FA-Setup / Passkey          [Skip]          |
   2 |                    COMP-004 (TopBar)                      |
     +------------------------------------------------------------+
   4 |                                                            |
     |        Sichern Sie Ihr Konto mit einer PIN                |
   6 |        und optionalem Passkey (biometrisch).              |
     |                                                            |
   8 |          +--------------------------------------+          |
     |          |  [ _ ]  [ _ ]  [ _ ]  [ _ ]  [ _ ]   |          |
  10 |          |       COMP-003 (OTPInput/PIN)         |          |
     |          +--------------------------------------+          |
  12 |                                                            |
     |          --- Passkey-Registrierung ---                     |
  14 |          +--------------------------------------+          |
     |          | Passkey-Name (z.B. "Mein iPhone")    |          |
  16 |          | COMP-002 (TextInput)                  |          |
     |          +--------------------------------------+          |
  18 |          +--------------------------------------+          |
     |          | Passkey aktivieren     [==O] Toggle   |          |
  20 |          | COMP-009 (ToggleSwitch)               |          |
     |          +--------------------------------------+          |
  22 |          +--------------------------------------+          |
     |          |     [ Passkey registrieren ]          |          |
  24 |          |       COMP-001 (Button)               |          |
     |          +--------------------------------------+          |
  26 |  . . . . . . . . . . . . . . . . . . . . . . . . . . . .  |
     |  :  +--------------------------------------+  :           |
  28 |  :  |   Passkey-Bestätigung                |  :           |
     |  :  |                                      |  :           |
  30 |  :  |   Bitte bestätigen Sie mit Ihrem     |  :           |
     |  :  |   Gerät (Fingerabdruck/Face ID).     |  :           |
  32 |  :  |                                      |  :           |
     |  :  |   [Abbrechen]       [Bestätigen]     |  :           |
  34 |  :  |   COMP-010 (ModalDialog)              |  :           |
     |  :  +--------------------------------------+  :           |
  36 |  . . . . . . . . . . . . . . . . . . . . . . . . . . . .  |
     +------------------------------------------------------------+
```

---

## Component Layout

| ID | Name | X | Y | W | H |
|-----|------|---|---|---|---|
| COMP-004 | TopBar | 0 | 0 | 60 | 4 |
| COMP-003 | OTPInput (PIN Setup) | 10 | 8 | 40 | 4 |
| COMP-002 | TextInput (Passkey Name) | 10 | 14 | 40 | 3 |
| COMP-009 | ToggleSwitch (Enable Passkey) | 10 | 18 | 40 | 3 |
| COMP-001 | Button (Register Passkey) | 10 | 22 | 40 | 3 |
| COMP-010 | ModalDialog (Passkey Confirm) | 10 | 26 | 40 | 8 |
