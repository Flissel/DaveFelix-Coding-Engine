# Kontakt blockieren

**ID:** `SCREEN-005`
**Route:** `/settings/blocked-contacts`
**Layout:** single-column

Einstellungsseite zum Verwalten und Blockieren von Kontakten. Zeigt eine Liste aller Kontakte mit der Möglichkeit, einzelne Kontakte zu blockieren oder zu entblockieren. Ein Bestätigungsdialog erscheint vor dem Blockieren.

---

## Components Used

- `COMP-001`
- `COMP-002`
- `COMP-004`
- `COMP-005`
- `COMP-006`
- `COMP-008`
- `COMP-009`
- `COMP-010`

---

## Data Requirements

- `GET /api/contacts`
- `PUT /api/contacts/{id}/block`
- `PUT /api/contacts/{id}/unblock`
- `GET /api/settings/blocked-contacts`

---

## Related User Story

`US-060`

---

## Wireframe

```
     0    5   10   15   20   25   30   35   40   45   50   55   60
   0 +------------------------------------------------------------+
     |  [<Back]   Blockierte Kontakte          [TopBar]          |
   2 |  COMP-004                                                 |
     +------------------------------------------------------------+
   4 |  +------------------------------------------------------+ |
     |  | [🔍 Kontakt suchen...]  COMP-002 (SearchInput)        | |
   6 |  +------------------------------------------------------+ |
     +------------------------------------------------------------+
   8 |  [Ava]  Max Mustermann          +49 170 ...   [🔘 Block] |
     |  COMP-008 COMP-006 (ContactListItem)          COMP-009   |
  10 |  -------------------------------------------------------- |
     |  [Ava]  Anna Schmidt            +49 171 ...   [🔘 Block] |
  12 |  COMP-008 COMP-006                             COMP-009   |
     |  -------------------------------------------------------- |
  14 |  [Ava]  Peter Weber             +49 172 ...   [⬤ Blocked]|
     |  COMP-008 COMP-006                             COMP-009   |
     |  -------------------------------------------------------- |
  16 |  [Ava]  Lisa Braun              +49 173 ...   [🔘 Block] |
     |  COMP-008 COMP-006                             COMP-009   |
  18 |  -------------------------------------------------------- |
     |                                                           |
  20 |  +------------------------------------------------+      |
     |  | COMP-010 (BlockConfirmDialog)                   |      |
  22 |  |  Möchten Sie diesen Kontakt wirklich            |      |
     |  |  blockieren? Blockierte Kontakte können          |      |
  24 |  |  Ihnen keine Nachrichten mehr senden.            |      |
     |  |                                                  |      |
  26 |  |   [Abbrechen]        [Blockieren] COMP-001      |      |
     |  +------------------------------------------------+      |
  28 +------------------------------------------------------------+
     |  [Chats]   [Status]   [Anrufe]   [Einstellungen]         |
  30 |  COMP-005 (BottomNav)                                     |
     +------------------------------------------------------------+
```

---

## Component Layout

| ID | Name | X | Y | W | H |
|-----|------|---|---|---|---|
| COMP-004 | TopBar | 0 | 0 | 60 | 4 |
| COMP-002 | SearchInput | 2 | 4 | 56 | 3 |
| COMP-008 | Avatar | 2 | 8 | 5 | 3 |
| COMP-006 | ContactListItem | 7 | 8 | 41 | 3 |
| COMP-009 | BlockToggle | 50 | 8 | 8 | 3 |
| COMP-010 | BlockConfirmDialog | 10 | 8 | 40 | 12 |
| COMP-001 | ConfirmButton | 30 | 17 | 18 | 3 |
| COMP-005 | BottomNav | 0 | 24 | 60 | 4 |
