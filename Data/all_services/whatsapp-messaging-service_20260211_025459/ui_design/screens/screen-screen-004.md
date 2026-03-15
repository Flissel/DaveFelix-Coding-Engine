# Videoanruf

**ID:** `SCREEN-004`
**Route:** `/profile/video-call`
**Layout:** fullscreen

Encrypted video call screen allowing users to start and conduct a video call with a contact, showing video feed, call controls, and encryption indicator

---

## Components Used

- `COMP-001`
- `COMP-004`
- `COMP-008`
- `COMP-010`

---

## Data Requirements

- `GET /api/contacts/{contactId}/profile`
- `POST /api/calls/video/start`
- `GET /api/calls/{callId}/status`
- `POST /api/calls/{callId}/end`
- `GET /api/calls/{callId}/encryption-keys`

---

## Related User Story

`US-036`

---

## Wireframe

```
     0    5   10   15   20   25   30   35   40   45   50   55   60
   0 +------------------------------------------------------------+
     |  [<Back]   Videoanruf          [Minimize] [Speaker]      |
   2 |  COMP-004 (TopBar)                                       |
     |  🔒 Ende-zu-Ende-verschluesselt                          |
   4 +------------------------------------------------------------+
     |                                                            |
   6 |            +------ Video Feed Area ------+                 |
     |            |                             |                 |
   8 |            |      +----------------+     |                 |
     |            |      |                |     |                 |
  10 |            |      |   [Avatar]     |     |                 |
     |            |      |   COMP-008     |     |                 |
  12 |            |      | Contact Photo  |     |                 |
     |            |      +----------------+     |                 |
  14 |            |                             |                 |
     |            |      "Max Mustermann"        |                 |
  16 |            |       "Klingelt..."          |                 |
     |            +-----------------------------+                 |
  18 |    +------------------------------------------+            |
     |    |  COMP-010 (ModalDialog)                  |            |
  20 |    |  ⏱ Anrufdauer: 00:03:42                  |            |
     |    |  🔒 Verschluesselung aktiv               |            |
  22 |    |  Verbindungsqualitaet: ████░ Gut         |            |
     |    +------------------------------------------+            |
  24 |                                                            |
     |                                                            |
  26 |    +--------------------------------------------------+    |
     |    | [🔇 Mute]  [📷 Kamera]  [🔴 Auflegen]  [💬 Chat] |    |
  28 |    |  COMP-001   COMP-001     COMP-001       COMP-001  |    |
     |    |              (Buttons)                            |    |
  30 |    +--------------------------------------------------+    |
     +------------------------------------------------------------+
```

---

## Component Layout

| ID | Name | X | Y | W | H |
|-----|------|---|---|---|---|
| COMP-004 | TopBar | 0 | 0 | 60 | 4 |
| COMP-008 | Avatar | 22 | 8 | 16 | 8 |
| COMP-010 | ModalDialog | 10 | 18 | 40 | 6 |
| COMP-001 | Button | 5 | 26 | 50 | 4 |
