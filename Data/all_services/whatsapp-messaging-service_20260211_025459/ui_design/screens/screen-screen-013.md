# Telefonnummer anzeigen

**ID:** `SCREEN-013`
**Route:** `/profile/phone`
**Layout:** single-column

Displays the contact's phone number and online status in a read-only profile view, showing status indicators consistent with the contact list and chat views.

---

## Components Used

- `COMP-001`
- `COMP-004`
- `COMP-005`
- `COMP-008`
- `COMP-010`

---

## Data Requirements

- `GET /api/contacts/{contactId}`
- `GET /api/contacts/{contactId}/status`
- `GET /api/contacts/{contactId}/phone`

---

## Related User Story

`US-043`

---

## Wireframe

```
     0    5   10   15   20   25   30   35   40   45   50   55   60
   0 +------------------------------------------------------------+
     | [<Back]       Kontakt-Info                                |
   2 |  COMP-001     COMP-004 (TopBar)                           |
     |                                                            |
   4 +------------------------------------------------------------+
   5 |                                                            |
     |                      +------------+                        |
   7 |                      |  [Avatar]  |                        |
     |                      |  COMP-008  |                        |
   9 |                      +------------+                        |
     |                       Max Mustermann                       |
  11 |                     ● Online (Status)                      |
  12 +------------------------------------------------------------+
     |     +------------------------------------------------+     |
  13 |     |  COMP-010 (PhoneInfoCard / ModalDialog)        |     |
     |     |                                                |     |
  15 |     |  Telefonnummer:                                |     |
     |     |  +49 170 1234567                    [Copy]     |     |
  17 |     |                                                |     |
     |     |  Status:  ● Online                             |     |
  19 |     |  Zuletzt online: Heute, 14:32                  |     |
     |     |                                                |     |
  21 |     +------------------------------------------------+     |
  22 |                                                            |
     |                                                            |
  24 |                                                            |
     |                                                            |
  26 +------------------------------------------------------------+
     | [Chats]    [Status]    [Kontakte]    [Einstellungen]       |
  28 |              COMP-005 (BottomNav)                          |
     |                                                            |
  30 +------------------------------------------------------------+
```

---

## Component Layout

| ID | Name | X | Y | W | H |
|-----|------|---|---|---|---|
| COMP-004 | TopBar | 0 | 0 | 60 | 4 |
| COMP-008 | Avatar | 22 | 5 | 16 | 6 |
| COMP-001 | BackButton | 2 | 1 | 6 | 2 |
| COMP-010 | PhoneInfoCard | 5 | 12 | 50 | 10 |
| COMP-005 | BottomNav | 0 | 26 | 60 | 4 |
