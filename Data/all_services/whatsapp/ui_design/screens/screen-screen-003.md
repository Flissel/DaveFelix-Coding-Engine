# Biometrische Entsperrung

**ID:** `SCREEN-003`
**Route:** `/auth/phone-signup`
**Layout:** single-column-centered

Phone registration screen with biometric unlock setup. Users can register with their phone number, verify via OTP, and enable fingerprint or Face ID for faster, password-free authentication.

---

## Components Used

- `COMP-001`
- `COMP-003`
- `COMP-004`
- `COMP-005`
- `COMP-006`
- `COMP-008`
- `COMP-009`
- `COMP-010`

---

## Data Requirements

- `POST /api/auth/phone/register`
- `POST /api/auth/phone/verify-otp`
- `POST /api/auth/biometric/enroll`
- `GET /api/auth/biometric/capabilities`
- `POST /api/auth/biometric/authenticate`

---

## Related User Story

`US-003`

---

## Wireframe

```
     0    5   10   15   20   25   30   35   40   45   50   55   60
   0 +------------------------------------------------------------+
     |                                                            |
   2 |          +----------------------------------------+        |
     |          |  COMP-005 (AuthCard)                   |        |
   3 |          |  +------------------------------------+|        |
     |          |  | COMP-010 (Alert)                   ||        |
   5 |          |  | i  Biometrie verfuegbar! Aktiviere ||        |
     |          |  |    Fingerabdruck / Face ID          ||        |
   6 |          |  +------------------------------------+|        |
     |          |                                        |        |
   7 |          |  Telefonnummer                         |        |
     |          |  +------------------------------------+|        |
   8 |          |  | [+49] | Telefonnummer eingeben     ||        |
     |          |  | COMP-003 (PhoneInput)               ||        |
  10 |          |  +------------------------------------+|        |
     |          |                                        |        |
  11 |          |  Verifizierungscode                    |        |
     |          |  +------------------------------------+|        |
  12 |          |  | [_] [_] [_] [_] [_] [_]            ||        |
     |          |  | COMP-004 (OTPInput)                 ||        |
  14 |          |  +------------------------------------+|        |
     |          |                                        |        |
  16 |          |  +------------------------------------+|        |
     |          |  | Biometrie aktivieren    [ Toggle ] ||        |
  18 |          |  | COMP-006 (ToggleSwitch)             ||        |
     |          |  +------------------------------------+|        |
  20 |          |  +------------------------------------+|        |
     |          |  | [FingerprintIcon] Mit Biometrie    ||        |
  22 |          |  |  COMP-008 (PasskeyButton)           ||        |
     |          |  +------------------------------------+|        |
  24 |          |  +------------------------------------+|        |
     |          |  |        Registrieren                ||        |
  26 |          |  |  COMP-001 (Button)                  ||        |
     |          |  +------------------------------------+|        |
  28 |          |                                        |        |
     |          +----------------------------------------+        |
  30 +------------------------------------------------------------+
     |                                                            |
     |    +------------------------------------------------+      |
     |    |  COMP-009 (BiometricPrompt) - Modal Overlay    |      |
     |    |                                                |      |
     |    |          [Fingerprint / FaceID Icon]           |      |
     |    |                                                |      |
     |    |    Bestaetigen Sie Ihre Identitaet mit         |      |
     |    |    Fingerabdruck oder Face ID                  |      |
     |    |                                                |      |
     |    |    [Bestaetigen]         [Abbrechen]           |      |
     |    +------------------------------------------------+      |
     +------------------------------------------------------------+
```

---

## Component Layout

| ID | Name | X | Y | W | H |
|-----|------|---|---|---|---|
| COMP-005 | AuthCard | 10 | 2 | 40 | 28 |
| COMP-010 | Alert | 12 | 3 | 36 | 3 |
| COMP-003 | PhoneInput | 12 | 7 | 36 | 3 |
| COMP-004 | OTPInput | 12 | 11 | 36 | 3 |
| COMP-006 | ToggleSwitch | 12 | 16 | 36 | 3 |
| COMP-008 | PasskeyButton | 12 | 20 | 36 | 3 |
| COMP-001 | Button | 12 | 24 | 36 | 3 |
| COMP-009 | BiometricPrompt | 10 | 8 | 40 | 16 |
