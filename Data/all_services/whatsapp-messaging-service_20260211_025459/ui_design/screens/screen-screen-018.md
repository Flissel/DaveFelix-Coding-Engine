# Dokumente senden

**ID:** `SCREEN-018`
**Route:** `/chat/send-document`
**Layout:** single-column

Screen to send documents to a recipient via WhatsApp. User selects a recipient, attaches a document file, adds an optional message, and confirms sending.

---

## Components Used

- `COMP-001`
- `COMP-002`
- `COMP-004`
- `COMP-005`
- `COMP-008`
- `COMP-010`

---

## Data Requirements

- `GET /api/contacts`
- `POST /api/messages/document`
- `POST /api/upload/document`

---

## Related User Story

`US-049`

---

## Wireframe

```
     0    5   10   15   20   25   30   35   40   45   50   55   60
   0 +------------------------------------------------------------+
     |  [<]   Dokument senden                          [...]     |
   2 |  COMP-004 (TopBar)                                        |
     +------------------------------------------------------------+
   4 |                                                            |
   5 | [Ava] |  [Empfänger eingeben / auswählen...]              |
     | COMP  |   COMP-002 (RecipientInput)                        |
   7 | -008  |                                                    |
   8 |-------+---------------------------------------------------|
   9 |                                                            |
  10 |    +------------------------------------------------+      |
     |    |  [📎]  Dokument auswählen...                   |      |
  12 |    |        COMP-001 (AttachDocButton)               |      |
     |    +------------------------------------------------+      |
  14 |                                                            |
     |    +------------------------------------------------+      |
  15 |    |  📄 vertrag_2024.pdf                           |      |
     |    |  PDF · 2.4 MB                          [✕]     |      |
  17 |    +------------------------------------------------+      |
  18 |    +------------------------------------------------+      |
     |    |  Nachricht hinzufügen (optional)...            |      |
  20 |    |  COMP-002 (MessageInput)                       |      |
     |    +------------------------------------------------+      |
  22 |                                                            |
  24 |         +------------------------------+                   |
     |         |     📤  Senden               |                   |
  26 |         |   COMP-001 (SendButton)       |                   |
     |         +------------------------------+                   |
  28 +------------------------------------------------------------+
     |  [💬]       [📞]       [📷]       [⚙️]                    |
  30 |  COMP-005 (BottomNav)                                      |
     +------------------------------------------------------------+
  32
     COMP-010 (ConfirmDialog) - shown as overlay on send:
     +------------------------------------------+
     |  Dokument senden?                        |
     |                                          |
     |  vertrag_2024.pdf an Max Mustermann      |
     |  senden?                                 |
     |                                          |
     |       [Abbrechen]    [Senden]            |
     +------------------------------------------+
```

---

## Component Layout

| ID | Name | X | Y | W | H |
|-----|------|---|---|---|---|
| COMP-004 | TopBar | 0 | 0 | 60 | 4 |
| COMP-008 | Avatar | 2 | 5 | 6 | 3 |
| COMP-002 | RecipientInput | 10 | 5 | 48 | 3 |
| COMP-001 | AttachDocButton | 5 | 10 | 50 | 4 |
| COMP-002-2 | MessageInput | 5 | 18 | 50 | 4 |
| COMP-001-2 | SendButton | 15 | 24 | 30 | 4 |
| COMP-005 | BottomNav | 0 | 28 | 60 | 4 |
| COMP-010 | ConfirmDialog | 10 | 8 | 40 | 16 |
