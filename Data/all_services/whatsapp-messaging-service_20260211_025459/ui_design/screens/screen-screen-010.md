# Status erstellen

**ID:** `SCREEN-010`
**Route:** `/status/create`
**Layout:** single-column

Screen zum Erstellen und Veröffentlichen eines 24-Stunden-Status-Updates mit Text, Bild-Upload und Vorschau

---

## Components Used

- `COMP-004`
- `COMP-008`
- `COMP-002`
- `COMP-001`
- `COMP-010`
- `COMP-005`

---

## Data Requirements

- `POST /api/status`
- `POST /api/status/media/upload`
- `GET /api/user/profile`
- `GET /api/status/privacy-settings`

---

## Related User Story

`US-042`

---

## Wireframe

```
     0    5   10   15   20   25   30   35   40   45   50   55   60
   0 +------------------------------------------------------------+
     |  [<Back]     Status erstellen          [X]                 |
   2 |                  COMP-004 (TopBar)                         |
     +------------------------------------------------------------+
   4 |                                                            |
   5 |                  +----------------------+                  |
     |                  |                      |                  |
   7 |                  |    [Avatar/Preview]   |                  |
     |                  |      COMP-008         |                  |
   9 |                  |   (Status Vorschau)   |                  |
     |                  |                      |                  |
  11 |                  |    📷  Bild/Video     |                  |
     |                  +----------------------+                  |
  13 |                                                            |
  14 |                                                            |
  16 |          +--------------------------------------+          |
     |          |   📎  Foto/Video hochladen           |          |
  18 |          |      COMP-001 (Upload Media)          |          |
     |          +--------------------------------------+          |
  20 |     +------------------------------------------------+    |
     |     |  Schreibe deinen Status...                     |    |
  22 |     |  COMP-002 (TextInput - Status Text)            |    |
     |     +------------------------------------------------+    |
  24 |                                                            |
  26 |               +----------------------------+               |
     |               |   ✓  Veröffentlichen       |               |
  28 |               |  COMP-001 (Publish Button)  |               |
     |               +----------------------------+               |
  30 +------------------------------------------------------------+
     |  [Chats]  [Status]  [Anrufe]  [Einstellungen]             |
  32 |              COMP-005 (BottomNav)                          |
     +------------------------------------------------------------+
  34 |                                                            |
     | COMP-010 (ModalDialog) - erscheint bei Bestätigung:       |
     | +------------------------------------------------------+  |
     | | Status veröffentlichen?                               |  |
     | | Dein Status ist 24 Stunden sichtbar.                  |  |
     | |            [Abbrechen]  [Bestätigen]                  |  |
     | +------------------------------------------------------+  |
     +------------------------------------------------------------+
```

---

## Component Layout

| ID | Name | X | Y | W | H |
|-----|------|---|---|---|---|
| COMP-004 | TopBar | 0 | 0 | 60 | 4 |
| COMP-008 | Avatar (Status Preview) | 18 | 5 | 24 | 10 |
| COMP-001-upload | Button (Upload Media) | 10 | 16 | 40 | 3 |
| COMP-002 | TextInput (Status Text) | 5 | 20 | 50 | 4 |
| COMP-001-publish | Button (Veröffentlichen) | 15 | 26 | 30 | 3 |
| COMP-010 | ModalDialog (Confirm) | 10 | 8 | 40 | 12 |
| COMP-005 | BottomNav | 0 | 30 | 60 | 4 |
