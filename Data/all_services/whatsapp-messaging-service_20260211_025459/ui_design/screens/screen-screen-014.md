# QR-Code Profil

**ID:** `SCREEN-014`
**Route:** `/profile/qr`
**Layout:** single-column

QR-Code screen for multi-device support, allowing users to scan a QR code to link additional devices and share their profile QR code with others.

---

## Components Used

- `COMP-004`
- `COMP-008`
- `COMP-001`
- `COMP-010`
- `COMP-005`

---

## Data Requirements

- `GET /api/profile/qr-code`
- `POST /api/profile/qr-code/refresh`
- `GET /api/devices/linked`
- `POST /api/devices/link`
- `DELETE /api/devices/{deviceId}`

---

## Related User Story

`US-004`

---

## Wireframe

```
     0    5   10   15   20   25   30   35   40   45   50   55   60
   0 +------------------------------------------------------------+
     |  [<Back]     QR-Code Profil          [...]                |
   2 |                    COMP-004 (TopBar)                      |
     +------------------------------------------------------------+
   4 |                                                            |
   5 |                      +----------+                          |
     |                      |          |                          |
   7 |                      | [Avatar] |                          |
     |                      | COMP-008 |                          |
   9 |                      +----------+                          |
  10 |                       Benutzername                         |
     |                                                            |
  12 |            +----------------------------------+            |
     |            |                                  |            |
  14 |            |     +------------------------+   |            |
     |            |     |                        |   |            |
  16 |            |     |    ██ ██ █ ██ ██       |   |            |
     |            |     |    █ ██ ███ █ ██       |   |            |
  18 |            |     |    ██ █ ██ ██ █        |   |            |
     |            |     |    █ ███ █ ██ ██       |   |            |
  20 |            |     |      QR-CODE           |   |            |
     |            |     +------------------------+   |            |
  22 |            |  +----------------------------+  |            |
     |            |  | [Refresh QR] COMP-001      |  |            |
  24 |            |  +----------------------------+  |            |
     |            +----------------------------------+            |
  26 |            +----------------------------+                  |
     |            | [Share QR-Code] COMP-001   |                  |
  28 |            +----------------------------+                  |
     |                                                            |
  30 |            +----------------------------+                  |
     |            |[+ Gerät verknüpfen]COMP-001|                  |
  32 |            +----------------------------+                  |
     |                                                            |
  34 |  Verknüpfte Geräte: 2/4                                   |
     |  • iPhone 14 Pro (dieses Gerät)                            |
  36 +------------------------------------------------------------+
     |  [Chats]   [Status]   [QR-Code]   [Einstellungen]         |
  38 |                  COMP-005 (BottomNav)                      |
  40 +------------------------------------------------------------+

  COMP-010 (ModalDialog) - appears on tap 'Gerät verknüpfen':
  +--------------------------------------------------+
  |  Neues Gerät verknüpfen                     [X]  |
  |                                                  |
  |  Scannen Sie den QR-Code auf Ihrem anderen       |
  |  Gerät, um es zu verknüpfen.                     |
  |                                                  |
  |  [Abbrechen]              [Bestätigen]           |
  +--------------------------------------------------+
```

---

## Component Layout

| ID | Name | X | Y | W | H |
|-----|------|---|---|---|---|
| COMP-004 | TopBar | 0 | 0 | 60 | 4 |
| COMP-008 | Avatar | 22 | 5 | 16 | 6 |
| COMP-001-qr-refresh | RefreshQRButton | 15 | 22 | 30 | 3 |
| COMP-001-share | ShareButton | 15 | 26 | 30 | 3 |
| COMP-001-link-device | LinkDeviceButton | 15 | 30 | 30 | 3 |
| COMP-010 | ModalDialog | 5 | 8 | 50 | 20 |
| COMP-005 | BottomNav | 0 | 36 | 60 | 4 |
