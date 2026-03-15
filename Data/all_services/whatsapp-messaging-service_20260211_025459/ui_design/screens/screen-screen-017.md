# Profilbild verwalten

**ID:** `SCREEN-017`
**Route:** `/settings/profile-picture`
**Layout:** single-column

Screen for uploading and managing the user's profile picture, with options to upload, preview, and remove the avatar image

---

## Components Used

- `COMP-001`
- `COMP-004`
- `COMP-005`
- `COMP-008`
- `COMP-009`
- `COMP-010`

---

## Data Requirements

- `GET /api/user/profile-picture`
- `POST /api/user/profile-picture`
- `DELETE /api/user/profile-picture`
- `PUT /api/user/profile-picture/visibility`

---

## Related User Story

`US-006`

---

## Wireframe

```
     0    5   10   15   20   25   30   35   40   45   50   55   60
   0 +------------------------------------------------------------+
     |  [<Back]     Profilbild verwalten          [...]          |
   2 |                    COMP-004 (TopBar)                      |
     +------------------------------------------------------------+
   4 |                                                            |
   5 |                  +--------------------+                    |
     |                  |                    |                    |
   7 |                  |    [Profilbild]     |                    |
     |                  |                    |                    |
   9 |                  |   COMP-008         |                    |
     |                  |   (Avatar)         |                    |
  11 |                  |   150x150px        |                    |
     |                  |                    |                    |
  13 |                  +--------------------+                    |
     |                                                            |
  15 |                                                            |
  16 |          [Foto hochladen]      [Foto entfernen]           |
     |          COMP-001 (Upload)     COMP-001 (Remove)          |
  18 |                                                            |
     |  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -    |
  20 |                                                            |
  21 |    Profilbild für alle sichtbar          [==O]            |
     |                                     COMP-009 (Toggle)     |
  23 |                                                            |
     |  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -    |
  25 |                                                            |
  26 |               [    Speichern    ]                          |
     |               COMP-001 (Save)                              |
  28 |                                                            |
     |  COMP-010 (ModalDialog) - appears on upload/remove confirm |
  30 +------------------------------------------------------------+
     |  [Chats]    [Status]    [Settings]    [Profile]           |
  32 |                  COMP-005 (BottomNav)                      |
  34 +------------------------------------------------------------+
```

---

## Component Layout

| ID | Name | X | Y | W | H |
|-----|------|---|---|---|---|
| COMP-004 | TopBar | 0 | 0 | 60 | 4 |
| COMP-008 | Avatar | 18 | 5 | 24 | 10 |
| COMP-001-upload | UploadButton | 10 | 16 | 18 | 3 |
| COMP-001-remove | RemoveButton | 32 | 16 | 18 | 3 |
| COMP-009 | ToggleSwitch | 4 | 21 | 52 | 3 |
| COMP-001-save | SaveButton | 15 | 26 | 30 | 3 |
| COMP-010 | ModalDialog | 8 | 8 | 44 | 14 |
| COMP-005 | BottomNav | 0 | 30 | 60 | 4 |
