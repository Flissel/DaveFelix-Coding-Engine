# Two-Factor Authentication Setup

**ID:** `SCREEN-002`
**Route:** `/auth/2fa-setup`
**Layout:** centered

Screen for enabling and configuring optional two-factor authentication with a 6-digit PIN, including toggle activation, phone number input, OTP verification, and status feedback.

---

## Components Used

- `COMP-001`
- `COMP-003`
- `COMP-004`
- `COMP-005`
- `COMP-006`
- `COMP-010`

---

## Data Requirements

- `GET /api/auth/2fa/status`
- `POST /api/auth/2fa/enable`
- `POST /api/auth/2fa/disable`
- `POST /api/auth/2fa/send-code`
- `POST /api/auth/2fa/verify`

---

## Related User Story

`US-002`

---

## Wireframe

```
     0    5   10   15   20   25   30   35   40   45   50   55   60
   0 +------------------------------------------------------------+
     |                                                            |
   2 |          +----------------------------------------+        |
     |          |         COMP-005 (AuthCard)             |        |
   4 |          |                                        |        |
     |          |   🔒  Two-Factor Authentication        |        |
   6 |          |                                        |        |
     |          |   Enable 2FA   [====○] OFF             |        |
   8 |          |                COMP-006 (ToggleSwitch) |        |
     |          |                                        |        |
   9 |          |   +----------------------------------+ |        |
     |          |   | ℹ️  2FA adds an extra layer of   | |        |
  11 |          |   |    security to your account.     | |        |
     |          |   +----------------------------------+ |        |
  12 |          |          COMP-010 (Alert)              |        |
     |          |                                        |        |
  13 |          |   +----------------------------------+ |        |
     |          |   | 📱  +49 |  Enter phone number   | |        |
  15 |          |   +----------------------------------+ |        |
     |          |          COMP-003 (PhoneInput)         |        |
  17 |          |                                        |        |
     |          |   [========= Send Code ============]   |        |
  19 |          |          COMP-001 (SendCodeButton)     |        |
     |          |                                        |        |
  21 |          |   Enter your 6-digit PIN:              |        |
     |          |   [ _ ] [ _ ] [ _ ] [ _ ] [ _ ] [ _ ]  |        |
  23 |          |          COMP-004 (OTPInput)            |        |
     |          |                                        |        |
  25 |          |   [======== Verify & Enable ========]  |        |
     |          |          COMP-001-B (VerifyButton)      |        |
  27 |          |                                        |        |
     |          +----------------------------------------+        |
  29 |                                                            |
     +------------------------------------------------------------+
```

---

## Component Layout

| ID | Name | X | Y | W | H |
|-----|------|---|---|---|---|
| COMP-005 | AuthCard | 10 | 2 | 40 | 26 |
| COMP-006 | ToggleSwitch | 14 | 6 | 32 | 3 |
| COMP-010 | Alert | 14 | 9 | 32 | 3 |
| COMP-003 | PhoneInput | 14 | 13 | 32 | 3 |
| COMP-001 | SendCodeButton | 14 | 17 | 32 | 3 |
| COMP-004 | OTPInput | 14 | 21 | 32 | 3 |
| COMP-001-B | VerifyButton | 14 | 25 | 32 | 3 |
