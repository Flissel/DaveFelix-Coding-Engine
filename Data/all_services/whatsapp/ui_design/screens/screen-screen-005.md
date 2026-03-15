# Code verifizieren

**ID:** `SCREEN-005`
**Route:** `/auth/phone-signup/verify`
**Layout:** centered

Phone verification screen where users enter an OTP code sent to their phone, with the option to register a passkey for future passwordless sign-in

---

## Components Used

- `COMP-004`
- `COMP-005`
- `COMP-001`
- `COMP-008`
- `COMP-010`

---

## Data Requirements

- `POST /api/auth/phone-signup/verify`
- `POST /api/auth/passkey/register`
- `POST /api/auth/phone-signup/resend-otp`

---

## Related User Story

`US-005`

---

## Wireframe

```
     0    5   10   15   20   25   30   35   40   45   50   55   60
   0 +------------------------------------------------------------+
     |                                                            |
   2 |                                                            |
     |          +----------------------------------------+        |
   4 |          |            COMP-005 (AuthCard)         |        |
     |          |    +--------------------------------+  |        |
   6 |          |    | COMP-010 (Alert)               |  |        |
     |          |    | i  Code wurde an +49...42 ge-  |  |        |
   8 |          |    |    sendet.                      |  |        |
     |          |    +--------------------------------+  |        |
  10 |          |                                        |        |
     |          |    +--+  +--+  +--+  +--+  +--+  +--+  |        |
  12 |          |    |  |  |  |  |  |  |  |  |  |  |  |  |        |
     |          |    +--+  +--+  +--+  +--+  +--+  +--+  |        |
  14 |          |       COMP-004 (OTPInput)              |        |
     |          |    +--------------------------------+  |        |
  16 |          |    |      Code verifizieren         |  |        |
     |          |    |      COMP-001 (VerifyButton)   |  |        |
  18 |          |    +--------------------------------+  |        |
     |          |         ─ ─ ─ ─ oder ─ ─ ─ ─          |        |
  20 |          |    +--------------------------------+  |        |
     |          |    |  [K] Mit Passkey anmelden      |  |        |
  22 |          |    |  COMP-008 (PasskeyButton)      |  |        |
     |          |    +--------------------------------+  |        |
  24 |          |                                        |        |
     |          |     Code nicht erhalten? Erneut senden |        |
  26 |          +----------------------------------------+        |
     |                                                            |
  28 +------------------------------------------------------------+
```

---

## Component Layout

| ID | Name | X | Y | W | H |
|-----|------|---|---|---|---|
| COMP-005 | AuthCard | 10 | 3 | 40 | 22 |
| COMP-010 | Alert | 14 | 5 | 32 | 3 |
| COMP-004 | OTPInput | 14 | 9 | 32 | 4 |
| COMP-001 | VerifyButton | 14 | 14 | 32 | 3 |
| COMP-008 | PasskeyButton | 14 | 19 | 32 | 3 |
