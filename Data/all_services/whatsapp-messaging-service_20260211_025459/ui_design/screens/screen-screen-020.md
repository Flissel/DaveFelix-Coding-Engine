# Anzeigename

**ID:** `SCREEN-020`
**Route:** `/settings/profile/display-name`
**Layout:** single-column

Screen to set and change the configurable display name for the user profile. Includes a text input for the name, avatar preview, and save/cancel actions.

---

## Components Used

- `COMP-001`
- `COMP-002`
- `COMP-004`
- `COMP-008`
- `COMP-010`

---

## Data Requirements

- `GET /api/profile`
- `PUT /api/profile/display-name`
- `GET /api/profile/avatar`

---

## Related User Story

`US-007`

---

## Wireframe

```
     0    5   10   15   20   25   30   35   40   45   50   55   60
   0 +------------------------------------------------------------+
     |  [<Back]     Anzeigename              [TopBar]            |
   2 |  COMP-004                                                 |
     +------------------------------------------------------------+
   4 |                                                            |
   5 |                      +------------+                        |
     |                      |            |                        |
   7 |                      |  [Avatar]  |                        |
     |                      |  COMP-008  |                        |
   9 |                      |            |                        |
     |                      +------------+                        |
  11 |                                                            |
     |                    Dein Anzeigename                        |
  13 |                                                            |
  14 |     +------------------------------------------------+    |
     |     | [DisplayNameInput]                              |    |
  16 |     |  COMP-002                                       |    |
     |     |  Anzeigename eingeben...                        |    |
  18 |     +------------------------------------------------+    |
     |       Dieser Name wird anderen Nutzern angezeigt.         |
  20 |                                                            |
  21 |     +------------------------------------------------+    |
     |     |          [Speichern]  COMP-001                  |    |
  23 |     +------------------------------------------------+    |
     |                                                            |
  25 +------------------------------------------------------------+
     |                                                            |
     |  - - - - - COMP-010 (ConfirmDialog) - - - - - - -          |
  28 |  :  +--------------------------------------+  :            |
     |  :  | Name ändern?                         |  :            |
  30 |  :  |                                      |  :            |
     |  :  | Möchtest du deinen Anzeigenamen       |  :            |
  32 |  :  | wirklich ändern?                      |  :            |
     |  :  |                                      |  :            |
  34 |  :  |    [Abbrechen]      [Bestätigen]     |  :            |
     |  :  +--------------------------------------+  :            |
  36 |  - - - - - - - - - - - - - - - - - - - - - -              |
     +------------------------------------------------------------+
```

---

## Component Layout

| ID | Name | X | Y | W | H |
|-----|------|---|---|---|---|
| COMP-004 | TopBar | 0 | 0 | 60 | 4 |
| COMP-008 | Avatar | 22 | 5 | 16 | 8 |
| COMP-002 | DisplayNameInput | 5 | 14 | 50 | 5 |
| COMP-001 | SaveButton | 5 | 21 | 50 | 3 |
| COMP-010 | ConfirmDialog | 10 | 8 | 40 | 12 |
