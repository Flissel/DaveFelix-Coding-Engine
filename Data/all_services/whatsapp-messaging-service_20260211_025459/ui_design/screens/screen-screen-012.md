# Bild senden

**ID:** `SCREEN-012`
**Route:** `/chat/:chatId/send-image`
**Layout:** single-column

Screen for sending an image in a chat conversation. Shows the chat context with a top bar, message history, image preview area, optional caption input, and send button. A modal dialog confirms the image before sending.

---

## Components Used

- `COMP-001`
- `COMP-002`
- `COMP-004`
- `COMP-007`
- `COMP-008`
- `COMP-010`

---

## Data Requirements

- `GET /api/chats/{chatId}/messages`
- `POST /api/chats/{chatId}/messages/image`
- `GET /api/chats/{chatId}/contact`

---

## Related User Story

`US-047`

---

## Wireframe

```
     0    5   10   15   20   25   30   35   40   45   50   55   60
   0 +------------------------------------------------------------+
     | [<]  [Avatar]  Contact Name           [📎] [⋮]           |
   2 |       COMP-008   Online                                   |
     |  COMP-004 (TopBar)                                        |
   4 +------------------------------------------------------------+
     |                                                            |
   5 |  +--------------------------------------+                  |
     |  | Hey, check out this photo!           |                  |
   7 |  | COMP-007 (MessageBubble)              |                  |
     |  +--------------------------------------+                  |
   9 |                  +--------------------------------------+  |
     |                  |  Sure, send it!                      |  |
  11 |                  |  COMP-007 (MessageBubble)            |  |
     |                  +--------------------------------------+  |
  13 |                                                            |
     |          +----------------------------------------+        |
  14 |          | COMP-010 (ModalDialog)                 |        |
     |          |  +----------------------------------+  |        |
  16 |          |  |   [Image Preview]                |  |        |
     |          |  |   📷  selected_photo.jpg         |  |        |
  18 |          |  |       1.2 MB                     |  |        |
     |          |  +----------------------------------+  |        |
  20 |          |  [Cancel]            [Send Image]   |  |        |
     |          +----------------------------------------+        |
  22 |                                                            |
     +------------------------------------------------------------+
  23 |  [📷 Caption eingeben...]                     [Senden]     |
     |   COMP-002 (TextInput)                        COMP-001     |
  25 |                                               (Button)     |
     +------------------------------------------------------------+
```

---

## Component Layout

| ID | Name | X | Y | W | H |
|-----|------|---|---|---|---|
| COMP-004 | TopBar | 0 | 0 | 60 | 4 |
| COMP-008 | Avatar | 4 | 1 | 4 | 2 |
| COMP-007 | MessageBubble | 2 | 5 | 40 | 10 |
| COMP-002 | TextInput | 2 | 20 | 44 | 3 |
| COMP-001 | Button | 48 | 20 | 10 | 3 |
| COMP-010 | ModalDialog | 10 | 6 | 40 | 14 |
