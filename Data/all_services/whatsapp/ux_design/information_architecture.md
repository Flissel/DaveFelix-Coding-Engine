# Information Architecture - unnamed_project

## Site Map

- **Home** (`/`)
  - Content: dashboard, quick-actions
  - **Onboarding & Auth** (`/auth`)
    - Content: flow, forms
  - **Telefonnummer-Registrierung** (`/auth/phone-signup`)
    - Content: form, verification
  - **Mobilnummer eingeben** (`/auth/phone-signup/enter`)
    - Content: form
  - **Code verifizieren** (`/auth/phone-signup/verify`)
    - Content: verification, otp
  - **Login** (`/auth/login`)
    - Content: form
  - **Passkey-Login** (`/auth/login/passkey`)
    - Content: biometric, system-prompt
  - **Telefonnummer-Login** (`/auth/login/phone`)
    - Content: form, verification
  - **2FA Verifizierung** (`/auth/2fa`)
    - Content: pin-entry, verification
  - **Biometrische Entsperrung** (`/auth/biometric`)
    - Content: system-prompt, security
  - **Profil** (`/profile`)
    - Content: profile, preview
  - **Profilbild** (`/profile/avatar`)
    - Content: upload, crop
  - **Anzeigename** (`/profile/display-name`)
    - Content: form
  - **Info/Status** (`/profile/status`)
    - Content: form
  - **Telefonnummer anzeigen** (`/profile/phone`)
    - Content: read-only, details
  - **QR-Code Profil** (`/profile/qr`)
    - Content: qr-code, share
  - **Einstellungen & Sicherheit** (`/settings`)
    - Content: settings, security
  - **Zwei-Faktor-Authentifizierung** (`/settings/2fa`)
    - Content: toggle, pin-setup
  - **2FA aktivieren** (`/settings/2fa/enable`)
    - Content: pin-setup, confirmation
  - **2FA deaktivieren** (`/settings/2fa/disable`)
    - Content: confirmation
  - **Biometrische Entsperrung** (`/settings/biometric`)
    - Content: toggle, system-permission
  - **Passkeys** (`/settings/passkeys`)
    - Content: list, manage
  - **Passkey hinzufügen** (`/settings/passkeys/add`)
    - Content: system-prompt, confirmation
  - **Geräte** (`/devices`)
    - Content: list, status
  - **Aktive Geräte** (`/devices/active`)
    - Content: list, details
  - **Gerät hinzufügen** (`/devices/add`)
    - Content: flow, verification

---

## Interaction Patterns

- Modal Dialoge fuer sicherheitskritische Aktionen
- Toast Notifications fuer Feedback
- Inline Validation fuer Formulare
- System Prompts fuer Biometrie und Passkeys
- QR-Code Scan/Share

---

## Design Principles

1. Mobile First
1. Progressive Disclosure
1. Consistency ueber alle Screens
1. Fehlertoleranz
1. Security by Design
