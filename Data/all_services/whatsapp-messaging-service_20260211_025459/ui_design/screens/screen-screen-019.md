# Status-Datenschutz

**ID:** `SCREEN-019`
**Route:** `/settings/privacy/status`
**Layout:** single-column

Konfigurationsbildschirm für die Sichtbarkeit des eigenen Status. Nutzer können wählen, ob alle Kontakte, nur ausgewählte Kontakte oder alle außer bestimmte Kontakte den Status sehen können. Kontaktliste zur Auswahl wird angezeigt.

---

## Components Used

- `COMP-001`
- `COMP-004`
- `COMP-005`
- `COMP-006`
- `COMP-008`
- `COMP-009`
- `COMP-010`

---

## Data Requirements

- `GET /api/settings/privacy/status`
- `PUT /api/settings/privacy/status`
- `GET /api/contacts`
- `GET /api/contacts/groups`

---

## Related User Story

`US-045`

---

## Wireframe

```
     0    5   10   15   20   25   30   35   40   45   50   55   60
   0 +------------------------------------------------------------+
     |  [<Back]   Status-Datenschutz              [...]          |
   2 |                   COMP-004 (TopBar)                       |
     +------------------------------------------------------------+
   4 |                                                            |
   5 |  Wer kann meinen Status sehen?                            |
     |  +--------------------------------------------------------+|
   6 |  | (o) Meine Kontakte            [COMP-009 Toggle]       ||
     |  +--------------------------------------------------------+|
   8 |  | ( ) Meine Kontakte außer...   [COMP-009-2 Toggle]     ||
     |  +--------------------------------------------------------+|
  11 |  | ( ) Nur teilen mit...         [COMP-009-3 Toggle]     ||
     |  +--------------------------------------------------------+|
  13 |                                                            |
  14 |  ---- Ausgewählte Kontakte (Ausnahmen) ---                |
  15 |                                                            |
  16 |  +--------------------------------------------------------+|
     |  | [AVA]  Max Mustermann                        [x]      ||
  18 |  | COMP-008  COMP-006 (ContactListItem)                  ||
     |  +--------------------------------------------------------+|
  20 |  +--------------------------------------------------------+|
     |  | [AVA]  Anna Schmidt                          [x]      ||
  22 |  |        COMP-006-2 (ContactListItem)                   ||
     |  +--------------------------------------------------------+|
  24 |  +--------------------------------------------------------+|
     |  | [AVA]  Gruppe: Familie                       [x]      ||
  26 |  |        COMP-006-3 (ContactListItem)                   ||
     |  +--------------------------------------------------------+|
  28 |                                                            |
  30 |        +--------------------------------------+            |
     |        |       [Speichern] COMP-001           |            |
  32 |        +--------------------------------------+            |
     |                                                            |
  34 +------------------------------------------------------------+
     |  [Chats]  [Status]  [Anrufe]  [Settings]                  |
  36 |              COMP-005 (BottomNav)                          |
  38 +------------------------------------------------------------+
     |                                                            |
     |    +------ COMP-010 (ModalDialog) ------+                  |
     |    | Änderungen speichern?              |                  |
     |    | Möchten Sie die Datenschutz-        |                  |
     |    | einstellungen wirklich ändern?      |                  |
     |    |                                    |                  |
     |    |    [Abbrechen]    [Bestätigen]     |                  |
     |    +------------------------------------+                  |
     |         (shown as overlay when saving)                     |
```

---

## Component Layout

| ID | Name | X | Y | W | H |
|-----|------|---|---|---|---|
| COMP-004 | TopBar | 0 | 0 | 60 | 4 |
| COMP-009 | ToggleSwitch-AllContacts | 2 | 5 | 56 | 3 |
| COMP-009-2 | ToggleSwitch-ExceptContacts | 2 | 8 | 56 | 3 |
| COMP-009-3 | ToggleSwitch-OnlyShareWith | 2 | 11 | 56 | 3 |
| COMP-006 | ContactListItem-1 | 2 | 16 | 56 | 4 |
| COMP-006-2 | ContactListItem-2 | 2 | 20 | 56 | 4 |
| COMP-006-3 | ContactListItem-3 | 2 | 24 | 56 | 4 |
| COMP-008 | Avatar | 3 | 17 | 4 | 3 |
| COMP-001 | SaveButton | 10 | 30 | 40 | 3 |
| COMP-005 | BottomNav | 0 | 34 | 60 | 4 |
| COMP-010 | ConfirmDialog | 10 | 12 | 40 | 14 |
