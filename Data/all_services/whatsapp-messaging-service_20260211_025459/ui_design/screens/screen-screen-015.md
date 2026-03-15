# Video senden

**ID:** `SCREEN-015`
**Route:** `/chat/video-send`
**Layout:** single-column

Screen for selecting and sending a video in a chat message, with video preview, caption input, and send button within the chat conversation view.

---

## Components Used

- `COMP-001`
- `COMP-002`
- `COMP-004`
- `COMP-005`
- `COMP-007`
- `COMP-008`
- `COMP-010`

---

## Data Requirements

- `GET /api/chats/{chatId}/messages`
- `POST /api/chats/{chatId}/messages/video`
- `POST /api/media/upload`
- `GET /api/contacts/{contactId}`

---

## Related User Story

`US-048`

---

## Wireframe

```
     0    5   10   15   20   25   30   35   40   45   50   55   60
   0 +------------------------------------------------------------+
     | [<]  [Avatar]  Kontaktname           [📞] [📎] [⋮]      |
   2 |       COMP-008   Online                                   |
     |  COMP-004 (TopBar)                                        |
   4 +------------------------------------------------------------+
   5 |    +----------------------------------+                    |
     |    | Hallo! Hier ist das Video 🎬    |                    |
   7 |    | COMP-007 (MessageBubble)         |                    |
     |    |                          14:32 ✓✓|                    |
   9 |    +----------------------------------+                    |
     |                                                            |
  11 |                                                            |
  12 |        +------------------------------------------+        |
     |        |                                          |        |
  14 |        |      ┌─────────────────────┐             |        |
     |        |      │  ▶  Video Preview   │             |        |
  16 |        |      │    (00:45 / 2:30)   │             |        |
     |        |      │   video_clip.mp4    │             |        |
  18 |        |      └─────────────────────┘             |        |
     |        |   COMP-010 (ModalDialog - Video Preview) |        |
  20 |        |  Size: 12.4 MB   Format: MP4             |        |
     |        |  [Trim Video]         [Cancel]           |        |
  22 |        +------------------------------------------+        |
     |                                                            |
  24 |                                                            |
  25 +------------------------------------------------+-----------+
     | [📎] Bildunterschrift eingeben...               | [▶ Send] |
  26 |      COMP-002 (TextInput - Caption)             | COMP-001 |
  27 |                                                 | (Button) |
  28 +------------------------------------------------+-----------+
     |  [💬 Chats] [📊 Status] [📞 Anrufe] [⚙ Settings]        |
  30 |              COMP-005 (BottomNav)                          |
  31 +------------------------------------------------------------+
```

---

## Component Layout

| ID | Name | X | Y | W | H |
|-----|------|---|---|---|---|
| COMP-004 | TopBar | 0 | 0 | 60 | 4 |
| COMP-008 | Avatar | 2 | 1 | 4 | 2 |
| COMP-007 | MessageBubble | 4 | 5 | 36 | 6 |
| COMP-010 | ModalDialog (Video Preview) | 8 | 12 | 44 | 12 |
| COMP-002 | TextInput (Caption) | 0 | 25 | 48 | 3 |
| COMP-001 | Button (Send) | 49 | 25 | 11 | 3 |
| COMP-005 | BottomNav | 0 | 28 | 60 | 4 |
