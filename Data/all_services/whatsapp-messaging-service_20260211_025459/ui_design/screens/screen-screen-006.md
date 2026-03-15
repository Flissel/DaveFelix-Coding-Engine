# Audio File Send

**ID:** `SCREEN-006`
**Route:** `/chat/:chatId/audio`
**Layout:** single-column

Chat screen with audio file sending capability. User can record or attach an audio file, preview it, and send it as a message in the chat conversation.

---

## Components Used

- `COMP-001`
- `COMP-004`
- `COMP-005`
- `COMP-007`
- `COMP-008`
- `COMP-010`

---

## Data Requirements

- `GET /api/chats/{chatId}/messages`
- `POST /api/chats/{chatId}/messages/audio`
- `POST /api/media/upload`
- `GET /api/chats/{chatId}/info`

---

## Related User Story

`US-054`

---

## Wireframe

```
     0    5   10   15   20   25   30   35   40   45   50   55   60
   0 +------------------------------------------------------------+
     | [<]  [Avatar]  Contact Name           [📞] [📎] [⋮]     |
   2 |       COMP-008   Online                                   |
     |  COMP-004 (TopBar)                                        |
   4 +------------------------------------------------------------+
     |                                                            |
   5 |   +----------------------------------+                     |
     |   | Hey, check out this song!        |                     |
   7 |   | COMP-007 (MessageBubble)         |                     |
     |   +----------------------------------+                     |
   9 |                  +----------------------------------+      |
     |                  |  🎵 Sure, sending it now!        |      |
  11 |                  |  COMP-007 (MessageBubble)        |      |
     |                  |  +----------------------------+  |      |
  13 |                  |  | ▶  ━━━━●━━━━━━━  1:24     |  |      |
     |                  |  | [Audio Waveform Player]    |  |      |
  15 |                  |  +----------------------------+  |      |
     |                  +----------------------------------+      |
  17 |                                                            |
     |  +----------------------------------------------+          |
  19 |  |  COMP-010 (AudioPreviewModal)                |          |
     |  |  +--------------------------------------+    |          |
  20 |  |  | ▶  ━━━━━━━━━━━━━━━━━  0:00 / 2:35   |    |          |
     |  |  +--------------------------------------+    |          |
  22 |  |  [Cancel]              [Send COMP-001]       |          |
     |  +----------------------------------------------+          |
  23 +------------------------------------------------------------+
     | [🎤 Record] [📎 Attach Audio]  [Type...]  [Send]          |
  25 |                                            COMP-001        |
     |  COMP-005 (BottomNav)                                      |
  27 +------------------------------------------------------------+
```

---

## Component Layout

| ID | Name | X | Y | W | H |
|-----|------|---|---|---|---|
| COMP-004 | TopBar | 0 | 0 | 60 | 4 |
| COMP-008 | Avatar | 4 | 1 | 4 | 2 |
| COMP-007 | MessageBubble | 2 | 5 | 56 | 14 |
| COMP-001 | SendButton | 50 | 20 | 8 | 3 |
| COMP-010 | AudioPreviewModal | 8 | 7 | 44 | 10 |
| COMP-005 | BottomNav | 0 | 23 | 60 | 4 |
