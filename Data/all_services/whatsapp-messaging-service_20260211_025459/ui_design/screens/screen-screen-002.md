# Chat Messaging

**ID:** `SCREEN-002`
**Route:** `/chat/:contactId`
**Layout:** single-column

Real-time text messaging screen where users can send text messages to a contact, featuring message history with bubbles, contact info in the top bar, and a text input with send button at the bottom.

---

## Components Used

- `COMP-001`
- `COMP-002`
- `COMP-004`
- `COMP-007`
- `COMP-008`

---

## Data Requirements

- `GET /api/contacts/{contactId}`
- `GET /api/chats/{contactId}/messages`
- `POST /api/chats/{contactId}/messages`
- `WS /ws/chats/{contactId}`

---

## Related User Story

`US-011`

---

## Wireframe

```
     0    5   10   15   20   25   30   35   40   45   50   55   60
   0 +------------------------------------------------------------+
     | [<]  [Avatar]  Contact Name                    [:]        |
   2 |      COMP-008  Online                                     |
     |  COMP-004 (TopBar)                                        |
   4 +------------------------------------------------------------+
   5 |                                                            |
     |  +--------------------------------------+                  |
   7 |  | Hallo! Wie geht es dir?              |                  |
     |  | 10:30 ✓✓                             |                  |
   9 |  +--------------------------------------+                  |
     |                                                            |
  11 |                  +--------------------------------------+  |
     |                  |       Mir geht es gut, danke!        |  |
  13 |                  |                          10:31 ✓✓    |  |
     |                  +--------------------------------------+  |
  15 |                                                            |
     |  +--------------------------------------+                  |
  17 |  | Super! Treffen wir uns heute?         |                  |
     |  | 10:32 ✓✓                             |                  |
  19 |  +--------------------------------------+                  |
     |                                                            |
  21 |          COMP-007 (MessageBubble area)                     |
     |                                                            |
  23 +------------------------------------------------------------+
  24 |  +--------------------------------------------+ [Senden]  |
     |  | Nachricht eingeben...                      | COMP-001  |
  26 |  | COMP-002 (TextInput)                       | (Button)  |
     |  +--------------------------------------------+            |
  28 +------------------------------------------------------------+
```

---

## Component Layout

| ID | Name | X | Y | W | H |
|-----|------|---|---|---|---|
| COMP-004 | TopBar | 0 | 0 | 60 | 4 |
| COMP-008 | Avatar | 2 | 1 | 4 | 2 |
| COMP-007 | MessageBubble | 2 | 5 | 56 | 18 |
| COMP-002 | TextInput | 2 | 24 | 46 | 3 |
| COMP-001 | Button | 49 | 24 | 9 | 3 |
