# Telefonnummer-Login

**ID:** `SCREEN-008`
**Route:** `/auth/login/phone`
**Layout:** centered

Phone number login screen where registered users can authenticate via phone number and OTP verification, with an option to add or update a short info/status text for their profile

---

## Components Used

- `COMP-001`
- `COMP-002`
- `COMP-003`
- `COMP-004`
- `COMP-005`
- `COMP-010`

---

## Data Requirements

- `POST /api/auth/phone/send-otp`
- `POST /api/auth/phone/verify-otp`
- `PUT /api/profile/info-status`

---

## Related User Story

`US-008`

---

## Wireframe

```
     0    5   10   15   20   25   30   35   40   45   50   55   60
   0 +------------------------------------------------------------+
     |                                                            |
   2 |          +----------------------------------------+        |
     |          |           COMP-005 (AuthCard)           |        |
   4 |          |                                        |        |
     |          |        📱 Telefonnummer-Login           |        |
   6 |          |     Melden Sie sich mit Ihrer           |        |
     |          |     Telefonnummer an                    |        |
   8 |          |    +--------------------------------+   |        |
     |          |    | COMP-003 (PhoneInput)          |   |        |
  10 |          |    | [+49] [Telefonnummer eingeben] |   |        |
     |          |    +--------------------------------+   |        |
  12 |          |    +--------------------------------+   |        |
     |          |    | COMP-004 (OTPInput)            |   |        |
  14 |          |    | [_] [_] [_] [_] [_] [_]        |   |        |
     |          |    +--------------------------------+   |        |
  16 |          |    +--------------------------------+   |        |
     |          |    | COMP-002 (InfoStatusTextInput)  |   |        |
  18 |          |    | [Info/Status Text eingeben...] |   |        |
     |          |    +--------------------------------+   |        |
  20 |          |                                        |        |
  21 |          |    +--------------------------------+   |        |
     |          |    |    COMP-001 (SubmitButton)      |   |        |
  23 |          |    |    [ Anmelden & Speichern ]     |   |        |
     |          |    +--------------------------------+   |        |
  25 |          |    +--------------------------------+   |        |
     |          |    | COMP-010 (Alert)                |   |        |
  27 |          |    | ⚠ Status/Fehlermeldung hier     |   |        |
     |          |    +--------------------------------+   |        |
  28 |          +----------------------------------------+        |
     |                                                            |
  30 +------------------------------------------------------------+
```

---

## Component Layout

| ID | Name | X | Y | W | H |
|-----|------|---|---|---|---|
| COMP-005 | AuthCard | 10 | 2 | 40 | 26 |
| COMP-003 | PhoneInput | 14 | 8 | 32 | 3 |
| COMP-004 | OTPInput | 14 | 12 | 32 | 3 |
| COMP-002 | InfoStatusTextInput | 14 | 16 | 32 | 3 |
| COMP-001 | SubmitButton | 14 | 21 | 32 | 3 |
| COMP-010 | Alert | 14 | 25 | 32 | 2 |
