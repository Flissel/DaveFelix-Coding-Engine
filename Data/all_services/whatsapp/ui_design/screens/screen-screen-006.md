# Profile Picture Upload

**ID:** `SCREEN-006`
**Route:** `/auth/login`
**Layout:** centered

Login screen with profile picture upload and management functionality for registered users to personalize their account

---

## Components Used

- `COMP-001`
- `COMP-002`
- `COMP-005`
- `COMP-010`

---

## Data Requirements

- `POST /api/auth/login`
- `POST /api/users/profile-picture`
- `GET /api/users/profile-picture`
- `DELETE /api/users/profile-picture`

---

## Related User Story

`US-006`

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
   5 |          |  | "Upload successful!" / Error msg   ||        |
     |          |  +------------------------------------+|        |
   6 |          |                                        |        |
     |          |         +------------------+           |        |
   7 |          |         |                  |           |        |
     |          |         |   [Profile Pic]  |           |        |
   8 |          |         |    (circular     |           |        |
     |          |         |     avatar       |           |        |
   9 |          |         |     preview)     |           |        |
     |          |         |                  |           |        |
  10 |          |         +------------------+           |        |
     |          |                                        |        |
  11 |          |        [Upload Photo]                  |        |
     |          |         COMP-001 (UploadButton)        |        |
  13 |          |                                        |        |
     |          |    +--------------------------------+  |        |
  14 |          |    | Email                          |  |        |
     |          |    | COMP-002 (EmailInput)          |  |        |
  16 |          |    +--------------------------------+  |        |
     |          |                                        |        |
  17 |          |    +--------------------------------+  |        |
     |          |    | Password                       |  |        |
  19 |          |    +--------------------------------+  |        |
     |          |                                        |        |
  20 |          |    [===========Login===============]   |        |
     |          |     COMP-001-2 (LoginButton)           |        |
  22 |          |                                        |        |
     |          +----------------------------------------+        |
  24 |                                                            |
     +------------------------------------------------------------+
```

---

## Component Layout

| ID | Name | X | Y | W | H |
|-----|------|---|---|---|---|
| COMP-005 | AuthCard | 10 | 2 | 40 | 22 |
| COMP-010 | Alert | 12 | 3 | 36 | 2 |
| COMP-002 | EmailInput | 14 | 14 | 32 | 2 |
| COMP-001 | UploadButton | 20 | 11 | 20 | 2 |
| COMP-001-2 | LoginButton | 14 | 20 | 32 | 2 |
