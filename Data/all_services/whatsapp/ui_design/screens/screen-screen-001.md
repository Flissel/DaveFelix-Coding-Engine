# Phone Registration

**ID:** `SCREEN-001`
**Route:** `/register`
**Layout:** centered

Registration screen where new users enter their mobile phone number, receive an OTP verification code, and complete account creation with terms acceptance

---

## Components Used

- `COMP-001`
- `COMP-003`
- `COMP-004`
- `COMP-005`
- `COMP-007`
- `COMP-010`

---

## Data Requirements

- `POST /api/auth/send-otp`
- `POST /api/auth/verify-otp`
- `POST /api/auth/register`

---

## Related User Story

`US-001`

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
   5 |          |  | "Verification code sent!"          ||        |
     |          |  +------------------------------------+|        |
   6 |          |                                        |        |
     |          |      📱  Phone Registration            |        |
   8 |          |      Create your account by            |        |
     |          |      verifying your phone number       |        |
  10 |          |  +------------------------------------+|        |
     |          |  | COMP-003 (PhoneInput)              ||        |
  12 |          |  | [+1 ▼] [  Enter phone number    ]  ||        |
     |          |  +------------------------------------+|        |
  13 |          |                                        |        |
     |          |        [Send Code]                     |        |
  15 |          |  +------------------------------------+|        |
     |          |  | COMP-004 (OTPInput)                ||        |
  17 |          |  | [ _ ] [ _ ] [ _ ] [ _ ] [ _ ] [ _ ]||        |
     |          |  +------------------------------------+|        |
  18 |          |                                        |        |
     |          |     Didn't receive code? Resend        |        |
  20 |          |  +------------------------------------+|        |
     |          |  | COMP-007 (Checkbox)                ||        |
  22 |          |  | [x] I agree to Terms & Privacy     ||        |
     |          |  +------------------------------------+|        |
  24 |          |  +------------------------------------+|        |
     |          |  |     COMP-001 (Button)              ||        |
  26 |          |  |   [ Verify & Create Account ]      ||        |
     |          |  +------------------------------------+|        |
  28 |          +----------------------------------------+        |
     |                                                            |
  30 +------------------------------------------------------------+
```

---

## Component Layout

| ID | Name | X | Y | W | H |
|-----|------|---|---|---|---|
| COMP-005 | AuthCard | 10 | 2 | 40 | 26 |
| COMP-010 | Alert | 12 | 3 | 36 | 3 |
| COMP-003 | PhoneInput | 12 | 10 | 36 | 3 |
| COMP-004 | OTPInput | 12 | 15 | 36 | 3 |
| COMP-007 | Checkbox | 12 | 20 | 36 | 2 |
| COMP-001 | Button | 12 | 24 | 36 | 3 |
