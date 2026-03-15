# Profile Info/Status Text

**ID:** `SCREEN-003`
**Route:** `/chats`
**Layout:** single-column

Screen allowing users to view and edit their short info/status text in their profile, accessible from the chats view. Displays current status with option to edit via a modal dialog.

---

## Components Used

- `COMP-001`
- `COMP-002`
- `COMP-004`
- `COMP-005`
- `COMP-006`
- `COMP-008`
- `COMP-010`

---

## Data Requirements

- `GET /api/profile`
- `GET /api/profile/status`
- `PUT /api/profile/status`
- `GET /api/chats`

---

## Related User Story

`US-008`

---

## Wireframe

```
     0    5   10   15   20   25   30   35   40   45   50   55   60
   0 +------------------------------------------------------------+
     | [TopBar: <- Back    WhatsApp          ...]                 |
   2 |  COMP-004                                                  |
     +------------------------------------------------------------+
   4 |                                                            |
   5 |  [Avatar]   UserName                                       |
     |  COMP-008   "Hey there! I am using WhatsApp"  [Edit ✎]    |
   7 |             ^ Current Status Text                          |
   8 |  +------------------------------------------------------+  |
     |  | COMP-010  ModalDialog: Edit Status                   |  |
  10 |  | +--------------------------------------------------+ |  |
     |  | |  Current Status:                                  | |  |
  12 |  | |  "Hey there! I am using WhatsApp"                 | |  |
     |  | +--------------------------------------------------+ |  |
  14 |  | [SearchInput: Enter new status...]  COMP-002        | |  |
     |  | +--------------------------------------------------+ |  |
  16 |  | |  💬 Available        | 🏠 At home               | |  |
     |  | |  🔋 Busy             | 📱 At work               | |  |
  18 |  | |  🎓 In a meeting     | 📍 Only urgent msgs      | |  |
     |  | +--------------------------------------------------+ |  |
  20 |  |                                                      |  |
     |  |  140 characters remaining                            |  |
  22 |  |         [  Save Status  ]  COMP-001                  |  |
     |  |         [    Cancel     ]                             |  |
  24 |  +------------------------------------------------------+  |
     |                                                            |
  26 | +----------------------------------------------------------+|
     | | [ChatListItem] COMP-006                                  ||
  28 | | 👤 Alice - Hey, how are you?          10:30 AM           ||
     | | 👤 Bob - See you tomorrow!             9:15 AM           ||
  30 +------------------------------------------------------------+
     | [BottomNav: Chats | Status | Calls]  COMP-005              |
  32 |                                                            |
  34 +------------------------------------------------------------+
```

---

## Component Layout

| ID | Name | X | Y | W | H |
|-----|------|---|---|---|---|
| COMP-004 | TopBar | 0 | 0 | 60 | 4 |
| COMP-008 | Avatar | 2 | 5 | 8 | 4 |
| COMP-002 | SearchInput | 2 | 14 | 56 | 3 |
| COMP-006 | ChatListItem | 0 | 17 | 60 | 12 |
| COMP-005 | BottomNav | 0 | 30 | 60 | 4 |
| COMP-010 | ModalDialog | 5 | 8 | 50 | 18 |
| COMP-001 | SaveButton | 15 | 22 | 30 | 3 |
