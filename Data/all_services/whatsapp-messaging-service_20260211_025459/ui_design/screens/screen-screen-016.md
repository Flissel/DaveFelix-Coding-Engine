# Status Reply

**ID:** `SCREEN-016`
**Route:** `/status/reply`
**Layout:** single-column

Screen for replying to a WhatsApp status update, showing the status content with a reply input area and send action

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

- `GET /api/status/{statusId}`
- `GET /api/contacts/{contactId}`
- `POST /api/status/{statusId}/reply`
- `GET /api/status/{statusId}/replies`

---

## Related User Story

`US-044`

---

## Wireframe

```
     0    5   10   15   20   25   30   35   40   45   50   55   60
   0 +------------------------------------------------------------+
     | [<Back]  [Avatar] Anna Müller - Status    [···]          |
   2 |  COMP-004 (TopBar)                                       |
     +------------------------------------------------------------+
   4 |                                                            |
   5 | [Ava]  Anna Müller              heute, 14:32              |
     | COMP-008  (Avatar)                                        |
   7 |        posted a status                                    |
   8 |  +----------------------------------------------------+  |
     |  |                                                    |  |
  10 |  |          +--------------------------+              |  |
     |  |          |                          |              |  |
  12 |  |          |   STATUS IMAGE / TEXT     |              |  |
     |  |          |   CONTENT DISPLAY         |              |  |
  14 |  |          |                          |              |  |
     |  |          +--------------------------+              |  |
  16 |  |                                                    |  |
     |  |        COMP-007 (StatusContent/MessageBubble)      |  |
  18 |  |                                                    |  |
     |  +----------------------------------------------------+  |
  20 |  +----------------------------------------------------+  |
     |  | Antwort auf: "Schöner Tag am Strand!"              |  |
  22 |  | COMP-010 (ReplyPreviewModal)                        |  |
     |  +----------------------------------------------------+  |
  24 |                                                            |
  25 |  +--------------------------------------------+ +------+  |
     |  | Antwort eingeben...                        | | Send |  |
  27 |  | COMP-002 (ReplyTextInput)                   | |COMP- |  |
     |  +--------------------------------------------+ |001   |  |
  29 |                                                  +------+  |
  30 +------------------------------------------------------------+
     | [Chats]    [Status]    [Calls]    [Settings]              |
  32 |  COMP-005 (BottomNav)                                     |
     +------------------------------------------------------------+
  34 |                                                            |
```

---

## Component Layout

| ID | Name | X | Y | W | H |
|-----|------|---|---|---|---|
| COMP-004 | TopBar | 0 | 0 | 60 | 4 |
| COMP-008 | Avatar | 2 | 5 | 6 | 3 |
| COMP-007 | StatusContent | 5 | 8 | 50 | 12 |
| COMP-010 | ReplyPreviewModal | 5 | 20 | 50 | 4 |
| COMP-002 | ReplyTextInput | 2 | 25 | 48 | 4 |
| COMP-001 | SendButton | 51 | 25 | 8 | 4 |
| COMP-005 | BottomNav | 0 | 30 | 60 | 4 |
