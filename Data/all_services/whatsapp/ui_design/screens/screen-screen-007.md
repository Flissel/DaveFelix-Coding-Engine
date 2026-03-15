# Passkey-Login

**ID:** `SCREEN-007`
**Route:** `/auth/login/passkey`
**Layout:** centered

Passkey login screen where registered users authenticate via biometric/passkey prompt and can set or update their configurable display name before completing login

---

## Components Used

- `COMP-001`
- `COMP-002`
- `COMP-005`
- `COMP-008`
- `COMP-009`
- `COMP-010`

---

## Data Requirements

- `GET /api/auth/user/display-name`
- `PUT /api/auth/user/display-name`
- `POST /api/auth/login/passkey/start`
- `POST /api/auth/login/passkey/finish`

---

## Related User Story

`US-007`

---

## Wireframe

```
     0    5   10   15   20   25   30   35   40   45   50   55   60
   0 |                                                            |
     |                                                            |
   2 |          +----------------------------------------+        |
     |          |  COMP-005 (AuthCard)                   |        |
   3 |          |  +------------------------------------+|        |
     |          |  | COMP-010 (Alert)                   ||        |
   5 |          |  | "Welcome back! Update your name."  ||        |
     |          |  +------------------------------------+|        |
   6 |          |                                        |        |
     |          |     🔐  Passkey Login                  |        |
   8 |          |  +------------------------------------+|        |
     |          |  | COMP-002 (DisplayNameInput)        ||        |
  10 |          |  | Label: "Display Name"              ||        |
     |          |  | [  Enter your display name...    ] ||        |
  11 |          |  +------------------------------------+|        |
     |          |                                        |        |
  12 |          |  Tip: This name will be shown to       |        |
     |          |  others instead of your account ID.    |        |
  14 |          |  +------------------------------------+|        |
     |          |  | COMP-008 (PasskeyButton)           ||        |
  16 |          |  | [🔑  Sign in with Passkey        ] ||        |
     |          |  +------------------------------------+|        |
  18 |          |  +------------------------------------+|        |
     |          |  | COMP-001 (UpdateNameButton)        ||        |
  20 |          |  | [   Save Display Name             ] ||        |
     |          |  +------------------------------------+|        |
  22 |          |                                        |        |
     |          +----------------------------------------+        |
  24 |                                                            |
     |         +----------------------------------+               |
  26 |         | COMP-009 (BiometricPrompt)        |  (modal,     |
     |         |  ┌────────────────────────────┐   |   shown on   |
  28 |         |  │   👆 Biometric Verify       │   |   passkey    |
     |         |  │                            │   |   trigger)   |
  30 |         |  │  Confirm your identity      │   |              |
     |         |  │  using fingerprint / Face ID │   |              |
  32 |         |  │                            │   |              |
     |         |  │  [Cancel]       [Confirm]  │   |              |
  34 |         |  └────────────────────────────┘   |              |
     |         +----------------------------------+               |
  36 |                                                            |
```

---

## Component Layout

| ID | Name | X | Y | W | H |
|-----|------|---|---|---|---|
| COMP-005 | AuthCard | 10 | 2 | 40 | 22 |
| COMP-010 | Alert | 12 | 3 | 36 | 2 |
| COMP-002 | DisplayNameInput | 12 | 8 | 36 | 3 |
| COMP-008 | PasskeyButton | 12 | 14 | 36 | 3 |
| COMP-001 | UpdateNameButton | 12 | 18 | 36 | 3 |
| COMP-009 | BiometricPrompt | 14 | 6 | 32 | 14 |
