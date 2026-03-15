# Chat sperren

**ID:** `SCREEN-009`
**Route:** `/chats/:id`
**Layout:** single-column

Chat detail screen with lock functionality requiring additional authentication via PIN/OTP input. Users can lock individual chats to protect sensitive conversations.

---

## Components Used

- `COMP-001`
- `COMP-004`
- `COMP-007`
- `COMP-008`
- `COMP-009`
- `COMP-010`
- `COMP-003`

---

## Data Requirements

- `GET /api/chats/{id}`
- `GET /api/chats/{id}/messages`
- `GET /api/chats/{id}/lock-status`
- `POST /api/chats/{id}/lock`
- `POST /api/chats/{id}/unlock`
- `POST /api/chats/{id}/verify-pin`

---

## Related User Story

`US-020`

---

## Wireframe

```
     0    5   10   15   20   25   30   35   40   45   50   55   60
   0 +------------------------------------------------------------+
     | [<]  [Avatar]  Chat Name           [...]  [Lock Icon]    |
   2 |       COMP-008   Online                                   |
     |  COMP-004 (TopBar)                                        |
   4 +------------------------------------------------------------+
     |                                                            |
   5 |    +------------------------------------------+            |
     |    | Hallo, wie geht's?           10:30       |            |
   7 |    | COMP-007 (MessageBubble)                 |            |
     |    +------------------------------------------+            |
   9 |                  +----------------------------------+      |
     |                  | Mir geht's gut!        10:31    |      |
  11 |                  | COMP-007 (MessageBubble)        |      |
     |                  +----------------------------------+      |
  13 |    +------------------------------------------+            |
     |    | Treffen wir uns morgen?       10:32       |            |
  15 |    | COMP-007 (MessageBubble)                 |            |
     |    +------------------------------------------+            |
  17 |                                                            |
     |------------------------------------------------------------|
  19 |                                                            |
     |   Chat sperren:    [COMP-001: Sperren]  [Toggle COMP-009] |
  21 |                                                            |
     +------------------------------------------------------------+
     |                                                            |
     |     +------------------------------------------+           |
   6 |     | COMP-010 (ModalDialog)                   |           |
     |     |                                          |           |
   8 |     |   Chat sperren                           |           |
     |     |   --------------------------------       |           |
  10 |     |   Bitte geben Sie Ihren PIN ein,         |           |
     |     |   um diesen Chat zu sperren.             |           |
  12 |     |                                          |           |
     |     |   +----------------------------------+   |           |
  14 |     |   |  [_] [_] [_] [_] [_] [_]         |   |           |
     |     |   |  COMP-003 (OTPInput)              |   |           |
  16 |     |   +----------------------------------+   |           |
     |     |                                          |           |
  18 |     |   [Abbrechen]     [Bestaetigen]          |           |
     |     |    COMP-001        COMP-001               |           |
  20 |     +------------------------------------------+           |
     |                                                            |
  22 +------------------------------------------------------------+
```

---

## Component Layout

| ID | Name | X | Y | W | H |
|-----|------|---|---|---|---|
| COMP-004 | TopBar | 0 | 0 | 60 | 4 |
| COMP-008 | Avatar | 4 | 1 | 4 | 2 |
| COMP-007 | MessageBubble | 2 | 5 | 56 | 14 |
| COMP-009 | ToggleSwitch | 44 | 20 | 12 | 2 |
| COMP-001 | Button | 18 | 20 | 24 | 2 |
| COMP-010 | ModalDialog | 10 | 6 | 40 | 16 |
| COMP-003 | OTPInput | 17 | 13 | 26 | 4 |
