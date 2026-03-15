# Anzeigename

**ID:** `SCREEN-011`
**Route:** `/profile/name`
**Layout:** single-column

Screen zur Anzeige und Bearbeitung des Profilnamens, geschützt durch biometrische Entsperrung (Fingerabdruck oder Face ID). Zeigt nach erfolgreicher Authentifizierung ein Formular zur Namensänderung an.

---

## Components Used

- `COMP-004`
- `COMP-008`
- `COMP-002`
- `COMP-009`
- `COMP-001`
- `COMP-010`

---

## Data Requirements

- `GET /api/profile/name`
- `PUT /api/profile/name`
- `POST /api/auth/biometric/verify`
- `GET /api/settings/biometric`

---

## Related User Story

`US-003`

---

## Wireframe

```
     0    5   10   15   20   25   30   35   40   45   50   55   60
   0 +------------------------------------------------------------+
     |  [<Back]     Anzeigename              [...]               |
   2 |                   COMP-004 (TopBar)                       |
     +------------------------------------------------------------+
   4 |                                                            |
   5 |                      +----------+                          |
     |                      |          |                          |
   7 |                      | (Avatar) |                          |
     |                      | COMP-008 |                          |
   9 |                      +----------+                          |
     |                                                            |
  11 |                                                            |
  12 |     +------------------------------------------------+    |
     |     | Anzeigename                                    |    |
  14 |     | [Max Mustermann                           ]    |    |
     |     | COMP-002 (TextInput)                            |    |
  16 |     +------------------------------------------------+    |
  17 |     +------------------------------------------------+    |
     |     | Biometrische Entsperrung          [==O]        |    |
  19 |     | COMP-009 (ToggleSwitch)                         |    |
     |     +------------------------------------------------+    |
  21 |                                                            |
  22 |          +--------------------------------------+          |
     |          |         [Speichern]                  |          |
  24 |          |         COMP-001 (Button)            |          |
     |          +--------------------------------------+          |
  26 |                                                            |
     +------------------------------------------------------------+
     |                                                            |
     |  COMP-010 (ModalDialog) - Biometrie-Prompt (Overlay):     |
     |        +------------------------------------------+        |
     |        |                                          |        |
     |        |        [Fingerprint/FaceID Icon]         |        |
     |        |                                          |        |
     |        |   Bitte bestätigen Sie Ihre Identität    |        |
     |        |   mit Fingerabdruck oder Face ID          |        |
     |        |                                          |        |
     |        |    [Abbrechen]       [Bestätigen]        |        |
     |        |                                          |        |
     |        +------------------------------------------+        |
     |                                                            |
     +------------------------------------------------------------+
```

---

## Component Layout

| ID | Name | X | Y | W | H |
|-----|------|---|---|---|---|
| COMP-004 | TopBar | 0 | 0 | 60 | 4 |
| COMP-008 | Avatar | 22 | 5 | 16 | 6 |
| COMP-002 | TextInput (Anzeigename) | 5 | 12 | 50 | 4 |
| COMP-009 | ToggleSwitch (Biometrie) | 5 | 17 | 50 | 3 |
| COMP-001 | Button (Speichern) | 10 | 22 | 40 | 4 |
| COMP-010 | ModalDialog (Biometrie-Prompt) | 8 | 8 | 44 | 14 |
