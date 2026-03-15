# Information Architecture - whatsapp-messaging-service

## Site Map

- **Start** (`/`)
  - Content: landing, navigation
  - **Onboarding** (`/onboarding`)
    - Content: wizard, forms
  - **Chats** (`/chats`)
    - Content: list, search, filters
  - **Profil** (`/profile`)
    - Content: details, media, actions
  - **Einstellungen** (`/settings`)
    - Content: list, toggles
  - **Telefonnummer-Registrierung** (`/onboarding/phone`)
    - Content: form, verification
  - **Passkey-Einrichtung** (`/onboarding/passkey`)
    - Content: setup, system-prompt
  - **2FA-Setup** (`/onboarding/2fa`)
    - Content: form, pin-setup
  - **Chat-Detail** (`/chats/:id`)
    - Content: conversation, composer
  - **Profilbild** (`/profile/photo`)
    - Content: upload, editor
  - **Anzeigename** (`/profile/name`)
    - Content: form
  - **Info/Status Text** (`/profile/status`)
    - Content: form
  - **Telefonnummer anzeigen** (`/profile/phone`)
    - Content: read-only, actions
  - **QR-Code Profil** (`/profile/qr`)
    - Content: qr-code, share
  - **Sicherheit & Anmeldung** (`/settings/security`)
    - Content: toggles, actions
  - **Multi-Device** (`/settings/devices`)
    - Content: list, status, actions
  - **Benachrichtigungen** (`/settings/notifications`)
    - Content: toggles, preferences
  - **Verifizierungscode** (`/onboarding/phone/verify`)
    - Content: otp-input
  - **2FA verwalten** (`/settings/security/2fa`)
    - Content: pin-management, recovery
  - **Biometrische Entsperrung** (`/settings/security/biometrics`)
    - Content: toggle, fallback
  - **Passkeys verwalten** (`/settings/security/passkeys`)
    - Content: list, actions
  - **Geraet hinzufügen** (`/settings/devices/add`)
    - Content: qr-scan, pairing
  - **Geraete-Details** (`/settings/devices/:id`)
    - Content: details, actions

---

## Interaction Patterns

- Modal Dialoge fuer Formulare und Sicherheitsabfragen
- Toast Notifications fuer Feedback
- Bottom Sheets fuer schnelle Aktionen
- QR-Scanner als Fullscreen-Overlay
- Inline Validation fuer PIN/OTP Eingaben

---

## Design Principles

1. Mobile First
1. Progressive Disclosure
1. Consistency ueber alle Screens
1. Fehlertoleranz
1. Security by Design
