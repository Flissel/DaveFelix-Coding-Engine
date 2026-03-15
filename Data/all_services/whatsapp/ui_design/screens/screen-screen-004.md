# Mobilnummer eingeben

**ID:** `SCREEN-004`
**Route:** `/auth/phone-signup/enter`
**Layout:** centered

Phone number entry screen for registration, enabling multi-device support by associating the user's phone number with their account for seamless cross-device usage.

---

## Components Used

- `COMP-001`
- `COMP-003`
- `COMP-005`
- `COMP-010`

---

## Data Requirements

- `POST /api/auth/phone-signup/send-otp`
- `GET /api/auth/session/devices`

---

## Related User Story

`US-004`

---

## Wireframe

```
     0    5   10   15   20   25   30   35   40   45   50   55   60
   0 +------------------------------------------------------------+
     |                                                            |
   2 |                                                            |
     |          +----------------------------------------+        |
   4 |          |          COMP-005 (AuthCard)            |        |
     |          |    +--------------------------------+   |        |
   6 |          |    | COMP-010 (Alert)                |   |        |
     |          |    | ℹ️ Geben Sie Ihre Mobilnummer   |   |        |
   8 |          |    | ein, um auf allen Geräten       |   |        |
     |          |    | nahtlos weiterzuarbeiten.       |   |        |
  10 |          |    +--------------------------------+   |        |
     |          |                                        |        |
  12 |          |    +--------------------------------+   |        |
     |          |    | COMP-003 (PhoneInput)           |   |        |
  14 |          |    | [+49 ▼] [  Mobilnummer       ]  |   |        |
     |          |    +--------------------------------+   |        |
  16 |          |                                        |        |
     |          |                                        |        |
  18 |          |    +--------------------------------+   |        |
     |          |    |    COMP-001 (Button)            |   |        |
  20 |          |    |       [ Weiter ]                |   |        |
     |          |    +--------------------------------+   |        |
  22 |          |                                        |        |
     |          +----------------------------------------+        |
  24 |                                                            |
     +------------------------------------------------------------+
```

---

## Component Layout

| ID | Name | X | Y | W | H |
|-----|------|---|---|---|---|
| COMP-005 | AuthCard | 10 | 3 | 40 | 20 |
| COMP-010 | Alert | 14 | 5 | 32 | 3 |
| COMP-003 | PhoneInput | 14 | 12 | 32 | 3 |
| COMP-001 | Button | 14 | 18 | 32 | 3 |
