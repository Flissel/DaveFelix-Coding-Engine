# Component Compositions - whatsapp-messaging-service

## Overview

| Property | Value |
|----------|-------|
| Screens | 23 |
| Missing Components | 59 |
| Unique Components Used | 10 |

## Component Usage Frequency

| Component ID | Usage Count |
|-------------|-------------|
| `COMP-001` | 58 |
| `COMP-004` | 22 |
| `COMP-009` | 22 |
| `COMP-002` | 13 |
| `COMP-010` | 10 |
| `COMP-003` | 9 |
| `COMP-008` | 8 |
| `COMP-005` | 3 |
| `COMP-007` | 3 |
| `COMP-006` | 1 |

## Missing Components

Die folgenden Komponenten werden benoetigt, sind aber nicht im Design System definiert:

- Logo
- AppIcon
- WelcomeText
- FeatureHighlight
- StepIndicator
- OnboardingHeader
- ProgressBar
- InformationCard
- ChatList
- SearchBar
- QRCodeDisplay
- DeviceList
- ProfileImage
- SettingsSection
- SettingsItem
- DeviceListItem
- Text/Label component for instructions
- Timer component for resend countdown
- Icon
- Text
- Card
- ProgressIndicator
- InfoCard
- Timer
- PhoneNumberFormatter
- MessageInput
- ChatHeader
- MessageList
- TypingIndicator
- FileUploadButton
- EmojiPicker
- ImagePicker
- CameraCapture
- ProfileImageUploader
- Label
- FormField
- ValidationMessage
- StatusList
- StatusItem
- StatusPrivacySelector
- StatusTextCounter
- PhoneNumberDisplay
- SettingsCard
- StatusIndicator
- ProfileForm
- ShareSheet
- SettingsListItem
- SecuritySection
- SectionHeader
- LoadingSpinner
- BiometricSetupGuide
- SecurityInfoCard
- BiometricStatusIndicator
- PasskeyListItem
- EmptyState
- ErrorMessage
- FormContainer
- DeviceInfoCard
- InfoText

---

## Start

**Route:** `/`

**User Stories:** `US-111`

**Layout:** flex column, centered, max-width 400px, padding 20px, gap 16px

### Components

| Component | Position | Props | Responsive |
|-----------|----------|-------|------------|
| `COMP-004` TopBar | header | variant=transparent, title=Welcome | mobile: visible, desktop: visible |
| `COMP-001` Button | main | variant=primary, text=Get Started, size=large | mobile: visible, desktop: visible |
| `COMP-001` Button | main | variant=outline, text=Sign In, size=medium | mobile: visible, desktop: visible |

### Data Sources

- `GET /api/v1/users/{userId}/2fa`
- `GET /api/v1/biometric/credentials`

### State Shape

```json
{
  "isLoading": "boolean",
  "hasExistingAuth": "boolean",
  "biometricAvailable": "boolean"
}
```

---

## Onboarding

**Route:** `/onboarding`

**Layout:** flex column, centered, max-width 400px, padding 24px, gap 16px

### Components

| Component | Position | Props | Responsive |
|-----------|----------|-------|------------|
| `COMP-002` TextInput | main | placeholder=Telefonnummer eingeben, variant=outline, type=tel | mobile: visible, desktop: visible |
| `COMP-003` OTPInput | main | variant=numeric, length=6 | mobile: visible, desktop: visible |
| `COMP-001` Button | main | variant=primary, text=Telefonnummer verifizieren | mobile: visible, desktop: visible |
| `COMP-001` Button | main | variant=ghost, text=Code erneut senden | mobile: visible, desktop: visible |
| `COMP-002` TextInput | main | placeholder=6-stellige PIN eingeben, variant=outline, type=password | mobile: visible, desktop: visible |
| `COMP-001` Button | main | variant=primary, text=2FA aktivieren | mobile: visible, desktop: visible |
| `COMP-001` Button | main | variant=primary, text=Biometrische Anmeldung einrichten | mobile: visible, desktop: visible |
| `COMP-001` Button | main | variant=secondary, text=Später einrichten | mobile: visible, desktop: visible |

### Data Sources

- `POST /api/v1/phone-registrations`
- `POST /api/v1/phone-registrations/{registrationId}/verify`
- `POST /api/v1/phone-registrations/{registrationId}/resend-otp`
- `POST /api/v1/users/{userId}/2fa`
- `POST /api/v1/biometric/registration-options`
- `POST /api/v1/biometric/credentials`
- `POST /api/v1/devices`

### State Shape

```json
{
  "currentStep": "string",
  "phoneNumber": "string",
  "registrationId": "string",
  "otpCode": "string",
  "twoFactorPin": "string",
  "isLoading": "boolean",
  "error": "string",
  "userId": "string"
}
```

---

## Chats

**Route:** `/chats`

**Layout:** flex column, full height, header-main-footer structure

### Components

| Component | Position | Props | Responsive |
|-----------|----------|-------|------------|
| `COMP-004` TopBar | header | title=Chats, variant=default | mobile: visible, desktop: visible |
| `COMP-002` TextInput | main | placeholder=Search chats..., variant=outline | mobile: visible, desktop: visible |
| `COMP-006` ChatListItem | main | variant=default | mobile: visible, desktop: visible |
| `COMP-008` Avatar | main | variant=circle | mobile: visible, desktop: visible |
| `COMP-005` BottomNav | footer | variant=labeled | mobile: visible, desktop: hidden |

### State Shape

```json
{
  "chats": "array",
  "searchQuery": "string",
  "selectedChat": "object|null",
  "isLoading": "boolean"
}
```

---

## Profil

**Route:** `/profile`

**User Stories:** `US-010`, `US-096`

**Layout:** flex column, centered, max-width 400px, padding 16px, gap 24px

### Components

| Component | Position | Props | Responsive |
|-----------|----------|-------|------------|
| `COMP-004` TopBar | header | title=Profil, variant=default, showBack=False | mobile: visible, desktop: visible |
| `COMP-008` Avatar | main | variant=circle, size=large, editable=True | mobile: visible, desktop: visible |
| `COMP-002` TextInput | main | variant=outline, label=Name, placeholder=Dein Name | mobile: visible, desktop: visible |
| `COMP-002` TextInput | main | variant=outline, label=Telefonnummer, disabled=True | mobile: visible, desktop: visible |
| `COMP-009` ToggleSwitch | main | variant=default, label=2FA aktiviert | mobile: visible, desktop: visible |
| `COMP-009` ToggleSwitch | main | variant=default, label=Biometrische Anmeldung | mobile: visible, desktop: visible |
| `COMP-001` Button | main | variant=outline, text=QR-Code anzeigen | mobile: visible, desktop: visible |
| `COMP-001` Button | main | variant=outline, text=Geräte verwalten | mobile: visible, desktop: visible |
| `COMP-001` Button | main | variant=primary, text=Speichern | mobile: visible, desktop: visible |
| `COMP-005` BottomNav | footer | variant=labeled, activeTab=profile | mobile: visible, desktop: hidden |
| `COMP-010` ModalDialog | modal | variant=default, title=2FA PIN eingeben | mobile: visible, desktop: visible |

### Data Sources

- `GET /api/v1/users/{userId}/2fa`
- `POST /api/v1/users/{userId}/2fa`
- `DELETE /api/v1/users/{userId}/2fa`
- `GET /api/v1/biometric/credentials`
- `POST /api/v1/biometric/registration-options`
- `POST /api/v1/biometric/credentials`
- `GET /api/v1/devices`

### State Shape

```json
{
  "user": "object",
  "name": "string",
  "phoneNumber": "string",
  "twoFactorEnabled": "boolean",
  "biometricEnabled": "boolean",
  "devices": "array",
  "showQRModal": "boolean",
  "show2FAModal": "boolean",
  "isLoading": "boolean",
  "error": "string"
}
```

---

## Einstellungen

**Route:** `/settings`

**Layout:** flex column, padding 16px, gap 24px, max-width 400px

### Components

| Component | Position | Props | Responsive |
|-----------|----------|-------|------------|
| `COMP-004` TopBar | header | title=Einstellungen, showBackButton=True, variant=default | mobile: visible, desktop: visible |
| `COMP-009` ToggleSwitch | main | label=2FA aktivieren, variant=default | mobile: visible, desktop: visible |
| `COMP-009` ToggleSwitch | main | label=Biometrische Anmeldung, variant=default | mobile: visible, desktop: visible |
| `COMP-001` Button | main | text=Telefonnummer registrieren, variant=outline | mobile: visible, desktop: visible |
| `COMP-001` Button | main | text=Geräte verwalten, variant=outline | mobile: visible, desktop: visible |
| `COMP-001` Button | main | text=Biometrische Daten löschen, variant=danger | mobile: visible, desktop: visible |
| `COMP-010` ModalDialog | modal | variant=alert, title=2FA PIN eingeben | mobile: visible, desktop: visible |
| `COMP-003` OTPInput | modal | variant=numeric, length=6 | mobile: visible, desktop: visible |

### Data Sources

- `GET /api/v1/users/{userId}/2fa`
- `POST /api/v1/users/{userId}/2fa`
- `DELETE /api/v1/users/{userId}/2fa`
- `GET /api/v1/biometric/credentials`
- `DELETE /api/v1/biometric/credentials/{credentialId}`
- `POST /api/v1/biometric/registration-options`
- `POST /api/v1/biometric/credentials`
- `GET /api/v1/devices`

### State Shape

```json
{
  "twoFactorEnabled": "boolean",
  "biometricEnabled": "boolean",
  "biometricCredentials": "array",
  "devices": "array",
  "showTwoFactorModal": "boolean",
  "twoFactorPin": "string",
  "isLoading": "boolean"
}
```

---

## Telefonnummer-Registrierung

**Route:** `/onboarding/phone`

**User Stories:** `US-001`, `US-009`

**Layout:** flex column, centered, max-width 400px, padding 24px, gap 16px

### Components

| Component | Position | Props | Responsive |
|-----------|----------|-------|------------|
| `COMP-004` TopBar | header | variant=default, title=Telefonnummer verifizieren, showBackButton=True | mobile: visible, desktop: visible |
| `COMP-002` TextInput | main | variant=outline, type=tel, placeholder=+49 123 456 789, label=Telefonnummer | mobile: visible, desktop: visible |
| `COMP-003` OTPInput | main | variant=numeric, length=6, label=Bestätigungscode | mobile: visible, desktop: visible |
| `COMP-001` Button | main | variant=primary, text=Code senden, fullWidth=True | mobile: visible, desktop: visible |
| `COMP-001` Button | main | variant=outline, text=Bestätigen, fullWidth=True, disabled=True | mobile: visible, desktop: visible |
| `COMP-001` Button | main | variant=ghost, text=Code erneut senden | mobile: visible, desktop: visible |

### Data Sources

- `POST /api/v1/phone-registrations`
- `POST /api/v1/phone-registrations/{registrationId}/verify`
- `POST /api/v1/phone-registrations/{registrationId}/resend-otp`

### State Shape

```json
{
  "phoneNumber": "string",
  "registrationId": "string",
  "otpCode": "string",
  "isLoading": "boolean",
  "step": "string",
  "error": "string",
  "canResendOtp": "boolean",
  "resendTimer": "number"
}
```

---

## Passkey-Einrichtung

**Route:** `/onboarding/passkey`

**User Stories:** `US-005`

**Layout:** flex column, centered, max-width 400px, padding 24px, gap 24px

### Components

| Component | Position | Props | Responsive |
|-----------|----------|-------|------------|
| `COMP-004` TopBar | header | title=Passkey einrichten, showBackButton=True, variant=default | mobile: visible, desktop: visible |
| `COMP-001` Button | main | text=Passkey erstellen, variant=primary, fullWidth=True | mobile: visible, desktop: visible |
| `COMP-001` Button | main | text=Später einrichten, variant=ghost, fullWidth=True | mobile: visible, desktop: visible |

### Data Sources

- `POST /api/v1/biometric/registration-options`
- `POST /api/v1/biometric/credentials`
- `GET /api/v1/biometric/credentials`

### State Shape

```json
{
  "isLoading": "boolean",
  "registrationChallenge": "object",
  "error": "string|null",
  "passkeySupported": "boolean"
}
```

---

## 2FA-Setup

**Route:** `/onboarding/2fa`

**Layout:** flex column, centered, max-width 400px, padding 24px, gap 16px

### Components

| Component | Position | Props | Responsive |
|-----------|----------|-------|------------|
| `COMP-004` TopBar | header | variant=default, title=2FA Setup, showBackButton=True | mobile: visible, desktop: visible |
| `COMP-002` TextInput | main | variant=outline, placeholder=Enter phone number, type=tel | mobile: visible, desktop: visible |
| `COMP-003` OTPInput | main | variant=numeric, length=6, placeholder=Enter verification code | mobile: visible, desktop: visible |
| `COMP-001` Button | main | variant=primary, text=Send Code, fullWidth=True | mobile: visible, desktop: visible |
| `COMP-001` Button | main | variant=secondary, text=Resend Code, disabled=True | mobile: visible, desktop: visible |
| `COMP-001` Button | main | variant=primary, text=Verify & Continue, fullWidth=True | mobile: visible, desktop: visible |
| `COMP-001` Button | main | variant=ghost, text=Skip for now | mobile: visible, desktop: visible |

### Data Sources

- `POST /api/v1/phone-registrations`
- `POST /api/v1/phone-registrations/{registrationId}/verify`
- `POST /api/v1/phone-registrations/{registrationId}/resend-otp`
- `POST /api/v1/users/{userId}/2fa`

### State Shape

```json
{
  "phoneNumber": "string",
  "registrationId": "string",
  "otpCode": "string",
  "isCodeSent": "boolean",
  "isVerifying": "boolean",
  "canResend": "boolean",
  "resendTimer": "number",
  "error": "string|null"
}
```

---

## Chat-Detail

**Route:** `/chats/:id`

**User Stories:** `US-020`, `US-078`, `US-087`, `US-092`, `US-094`, `US-095`, `US-121`

**Layout:** flex column, full height, header fixed top, main scrollable, footer fixed bottom

### Components

| Component | Position | Props | Responsive |
|-----------|----------|-------|------------|
| `COMP-004` TopBar | header | variant=default, title=Chat Name, showBackButton=True, showMenuButton=True | mobile: visible, desktop: visible |
| `COMP-008` Avatar | header | variant=circle, size=small | mobile: visible, desktop: visible |
| `COMP-007` MessageBubble | main | variant=sent | mobile: visible, desktop: visible |
| `COMP-007` MessageBubble | main | variant=received | mobile: visible, desktop: visible |
| `COMP-007` MessageBubble | main | variant=system | mobile: visible, desktop: visible |
| `COMP-002` TextInput | footer | variant=outline, placeholder=Nachricht eingeben..., multiline=True | mobile: visible, desktop: visible |
| `COMP-001` Button | footer | variant=primary, icon=send | mobile: visible, desktop: visible |
| `COMP-010` ModalDialog | modal | variant=default, title=Chat-Optionen | mobile: visible, desktop: visible |
| `COMP-009` ToggleSwitch | modal | variant=default, label=Chat sperren | mobile: visible, desktop: visible |
| `COMP-001` Button | modal | variant=outline, text=Chat archivieren | mobile: visible, desktop: visible |
| `COMP-001` Button | modal | variant=outline, text=Chat anpinnen | mobile: visible, desktop: visible |
| `COMP-001` Button | modal | variant=outline, text=Chat exportieren | mobile: visible, desktop: visible |

### State Shape

```json
{
  "chatId": "string",
  "messages": "array",
  "currentMessage": "string",
  "isTyping": "boolean",
  "chatSettings": "object",
  "showOptionsModal": "boolean",
  "isLocked": "boolean",
  "isPinned": "boolean",
  "isArchived": "boolean"
}
```

---

## Profilbild

**Route:** `/profile/photo`

**User Stories:** `US-006`, `US-082`

**Layout:** flex column, centered, max-width 400px, padding 16px

### Components

| Component | Position | Props | Responsive |
|-----------|----------|-------|------------|
| `COMP-004` TopBar | header | title=Profilbild, showBackButton=True, variant=default | mobile: visible, desktop: visible |
| `COMP-008` Avatar | main | size=large, variant=circle, editable=True | mobile: visible, desktop: visible |
| `COMP-001` Button | main | variant=primary, text=Foto auswählen | mobile: visible, desktop: visible |
| `COMP-001` Button | main | variant=outline, text=Foto aufnehmen | mobile: visible, desktop: visible |
| `COMP-009` ToggleSwitch | main | label=Profilbild für alle sichtbar, variant=default | mobile: visible, desktop: visible |
| `COMP-001` Button | footer | variant=primary, text=Speichern, fullWidth=True | mobile: visible, desktop: visible |

### State Shape

```json
{
  "profileImage": "File | null",
  "imageUrl": "string | null",
  "isVisible": "boolean",
  "isLoading": "boolean",
  "hasChanges": "boolean"
}
```

---

## Anzeigename

**Route:** `/profile/name`

**User Stories:** `US-007`

**Layout:** flex column, centered, max-width 400px, padding 16px

### Components

| Component | Position | Props | Responsive |
|-----------|----------|-------|------------|
| `COMP-004` TopBar | header | title=Anzeigename, showBackButton=True, variant=default | mobile: visible, desktop: visible |
| `COMP-002` TextInput | main | placeholder=Anzeigename eingeben, variant=outline, maxLength=50 | mobile: visible, desktop: visible |
| `COMP-001` Button | main | text=Speichern, variant=primary, disabled=False | mobile: visible, desktop: visible |

### State Shape

```json
{
  "displayName": "string",
  "isValid": "boolean",
  "isLoading": "boolean",
  "error": "string | null"
}
```

---

## Info/Status Text

**Route:** `/profile/status`

**User Stories:** `US-008`, `US-042`, `US-043`, `US-044`, `US-045`, `US-046`, `US-083`

**Layout:** flex column, padding 16px, gap 20px, max-width 400px

### Components

| Component | Position | Props | Responsive |
|-----------|----------|-------|------------|
| `COMP-004` TopBar | header | title=Status, variant=default, showBackButton=True | mobile: visible, desktop: visible |
| `COMP-008` Avatar | main | variant=circle, size=large, showStatusIndicator=True | mobile: visible, desktop: visible |
| `COMP-002` TextInput | main | variant=outline, placeholder=Was machst du gerade?, multiline=True, maxLength=139 | mobile: visible, desktop: visible |
| `COMP-009` ToggleSwitch | main | variant=default, label=Status für alle sichtbar | mobile: visible, desktop: visible |
| `COMP-009` ToggleSwitch | main | variant=default, label=Status-Antworten stumm schalten | mobile: visible, desktop: visible |
| `COMP-001` Button | main | variant=primary, text=Status speichern, fullWidth=True | mobile: visible, desktop: visible |
| `COMP-001` Button | main | variant=outline, text=Status löschen, fullWidth=True | mobile: visible, desktop: visible |

### State Shape

```json
{
  "statusText": "string",
  "isPublicVisible": "boolean",
  "isMuted": "boolean",
  "isLoading": "boolean",
  "userAvatar": "string"
}
```

---

## Telefonnummer anzeigen

**Route:** `/profile/phone`

**User Stories:** `US-009`, `US-001`, `US-043`

**Layout:** flex column, centered, max-width 400px, padding 16px, gap 24px

### Components

| Component | Position | Props | Responsive |
|-----------|----------|-------|------------|
| `COMP-004` TopBar | header | title=Telefonnummer, variant=default, showBackButton=True | mobile: visible, desktop: visible |
| `COMP-008` Avatar | main | variant=circle, size=large, icon=phone | mobile: visible, desktop: visible |
| `COMP-009` ToggleSwitch | main | variant=default, label=2FA aktiviert, disabled=False | mobile: visible, desktop: visible |
| `COMP-001` Button | main | variant=outline, text=Telefonnummer ändern | mobile: visible, desktop: visible |
| `COMP-001` Button | main | variant=danger, text=Telefonnummer entfernen | mobile: visible, desktop: visible |

### Data Sources

- `GET /api/v1/users/{userId}/2fa`

### State Shape

```json
{
  "phoneNumber": "string",
  "is2FAEnabled": "boolean",
  "isLoading": "boolean",
  "error": "string|null"
}
```

---

## QR-Code Profil

**Route:** `/profile/qr`

**User Stories:** `US-010`, `US-096`

**Layout:** flex column, centered, max-width 400px, padding 16px, gap 24px

### Components

| Component | Position | Props | Responsive |
|-----------|----------|-------|------------|
| `COMP-004` TopBar | header | title=QR-Code Profil, showBackButton=True, variant=default | mobile: visible, desktop: visible |
| `COMP-008` Avatar | main | size=large, variant=circle, showEditIcon=True | mobile: visible, desktop: visible |
| `COMP-001` Button | main | text=QR-Code generieren, variant=primary, fullWidth=True | mobile: visible, desktop: visible |
| `COMP-001` Button | main | text=QR-Code teilen, variant=secondary, fullWidth=True | mobile: visible, desktop: visible |
| `COMP-001` Button | main | text=Business-Profil bearbeiten, variant=outline, fullWidth=True | mobile: visible, desktop: visible |
| `COMP-005` BottomNav | footer | variant=labeled, activeTab=profile | mobile: visible, desktop: hidden |

### Data Sources

- `GET /api/v1/users/{userId}/profile`
- `GET /api/v1/users/{userId}/qr-code`

### State Shape

```json
{
  "userProfile": "object",
  "qrCodeData": "string",
  "isLoading": "boolean",
  "error": "string|null"
}
```

---

## Sicherheit & Anmeldung

**Route:** `/settings/security`

**Layout:** flex column, padding 16px, gap 20px, max-width 600px

### Components

| Component | Position | Props | Responsive |
|-----------|----------|-------|------------|
| `COMP-004` TopBar | header | title=Sicherheit & Anmeldung, showBackButton=True, variant=default | mobile: visible, desktop: visible |
| `COMP-009` ToggleSwitch | main | label=Zwei-Faktor-Authentifizierung, variant=default | mobile: visible, desktop: visible |
| `COMP-009` ToggleSwitch | main | label=Biometrische Anmeldung, variant=default | mobile: visible, desktop: visible |
| `COMP-001` Button | main | text=Telefonnummer ändern, variant=outline | mobile: visible, desktop: visible |
| `COMP-001` Button | main | text=Registrierte Geräte verwalten, variant=outline | mobile: visible, desktop: visible |
| `COMP-010` ModalDialog | modal | title=2FA einrichten, variant=default | mobile: visible, desktop: visible |
| `COMP-003` OTPInput | modal | length=6, variant=numeric | mobile: visible, desktop: visible |
| `COMP-002` TextInput | modal | placeholder=Neue Telefonnummer, variant=outline | mobile: visible, desktop: visible |

### Data Sources

- `GET /api/v1/users/{userId}/2fa`
- `POST /api/v1/users/{userId}/2fa`
- `DELETE /api/v1/users/{userId}/2fa`
- `GET /api/v1/biometric/credentials`
- `POST /api/v1/biometric/registration-options`
- `POST /api/v1/biometric/credentials`
- `GET /api/v1/devices`
- `POST /api/v1/phone-registrations`
- `POST /api/v1/phone-registrations/{registrationId}/verify`

### State Shape

```json
{
  "twoFactorEnabled": "boolean",
  "biometricEnabled": "boolean",
  "phoneNumber": "string",
  "devices": "array",
  "biometricCredentials": "array",
  "showTwoFactorModal": "boolean",
  "showPhoneChangeModal": "boolean",
  "otpValue": "string",
  "newPhoneNumber": "string",
  "registrationId": "string"
}
```

---

## Multi-Device

**Route:** `/settings/devices`

**User Stories:** `US-004`

**Layout:** flex column, padding 16px, max-width 600px, centered

### Components

| Component | Position | Props | Responsive |
|-----------|----------|-------|------------|
| `COMP-004` TopBar | header | title=Geräte verwalten, showBackButton=True, variant=default | mobile: visible, desktop: visible |
| `COMP-009` ToggleSwitch | main | label=Multi-Device aktivieren, variant=default | mobile: visible, desktop: visible |
| `COMP-001` Button | main | text=Neues Gerät hinzufügen, variant=primary | mobile: visible, desktop: visible |
| `COMP-001` Button | main | text=Entfernen, variant=danger | mobile: visible, desktop: visible |
| `COMP-010` ModalDialog | modal | title=Gerät hinzufügen, variant=default | mobile: visible, desktop: visible |
| `COMP-003` OTPInput | modal | variant=numeric, length=6 | mobile: visible, desktop: visible |

### Data Sources

- `GET /api/v1/devices`
- `POST /api/v1/devices`
- `POST /api/v1/phone-registrations`
- `POST /api/v1/phone-registrations/{registrationId}/verify`

### State Shape

```json
{
  "devices": "array",
  "isMultiDeviceEnabled": "boolean",
  "showAddDeviceModal": "boolean",
  "registrationId": "string",
  "otpCode": "string",
  "isLoading": "boolean"
}
```

---

## Benachrichtigungen

**Route:** `/settings/notifications`

**User Stories:** `US-065`

**Layout:** flex column, padding 16px, gap 24px, max-width 400px

### Components

| Component | Position | Props | Responsive |
|-----------|----------|-------|------------|
| `COMP-004` TopBar | header | title=Benachrichtigungen, showBackButton=True, variant=default | mobile: visible, desktop: visible |
| `COMP-009` ToggleSwitch | main | label=Push-Benachrichtigungen, variant=default, id=push_notifications | mobile: visible, desktop: visible |
| `COMP-009` ToggleSwitch | main | label=Neue Nachrichten, variant=default, id=new_messages | mobile: visible, desktop: visible |
| `COMP-009` ToggleSwitch | main | label=Gruppennachrichten, variant=default, id=group_messages | mobile: visible, desktop: visible |
| `COMP-009` ToggleSwitch | main | label=Anrufe, variant=default, id=calls | mobile: visible, desktop: visible |
| `COMP-001` Button | main | text=Speichern, variant=primary | mobile: visible, desktop: visible |

### Data Sources

- `POST /api/v1/devices`
- `GET /api/v1/devices`

### State Shape

```json
{
  "pushNotifications": "boolean",
  "newMessages": "boolean",
  "groupMessages": "boolean",
  "calls": "boolean",
  "isLoading": "boolean",
  "deviceId": "string"
}
```

---

## Verifizierungscode

**Route:** `/onboarding/phone/verify`

**Layout:** flex column, centered, max-width 400px, gap-4, padding-4

### Components

| Component | Position | Props | Responsive |
|-----------|----------|-------|------------|
| `COMP-004` TopBar | header | title=Verifizierung, showBackButton=True, variant=default | mobile: visible, desktop: visible |
| `COMP-003` OTPInput | main | variant=numeric, length=6, placeholder=000000 | mobile: visible, desktop: visible |
| `COMP-001` Button | main | variant=primary, text=Verifizieren, disabled=False | mobile: visible, desktop: visible |
| `COMP-001` Button | main | variant=ghost, text=Code erneut senden, disabled=False | mobile: visible, desktop: visible |

### Data Sources

- `POST /api/v1/phone-registrations/{registrationId}/verify`
- `POST /api/v1/phone-registrations/{registrationId}/resend-otp`

### State Shape

```json
{
  "otpCode": "string",
  "registrationId": "string",
  "isVerifying": "boolean",
  "isResending": "boolean",
  "error": "string|null",
  "phoneNumber": "string"
}
```

---

## 2FA verwalten

**Route:** `/settings/security/2fa`

**Layout:** flex column, gap-4, padding-4, max-width 400px, centered

### Components

| Component | Position | Props | Responsive |
|-----------|----------|-------|------------|
| `COMP-004` TopBar | header | title=2FA verwalten, showBackButton=True, variant=default | mobile: visible, desktop: visible |
| `COMP-009` ToggleSwitch | main | label=2FA aktiviert, variant=default | mobile: visible, desktop: visible |
| `COMP-003` OTPInput | main | variant=numeric, length=6, placeholder=6-stellige PIN eingeben | mobile: visible, desktop: visible |
| `COMP-001` Button | main | text=PIN bestätigen, variant=primary | mobile: visible, desktop: visible |
| `COMP-009` ToggleSwitch | main | label=Biometrische Authentifizierung, variant=default | mobile: visible, desktop: visible |
| `COMP-001` Button | main | text=Biometrie einrichten, variant=secondary | mobile: visible, desktop: visible |
| `COMP-001` Button | main | text=2FA deaktivieren, variant=danger | mobile: visible, desktop: visible |
| `COMP-010` ModalDialog | modal | variant=alert, title=2FA deaktivieren?, message=Möchten Sie die Zwei-Faktor-Authentifizierung wirklich deaktivieren? | mobile: visible, desktop: visible |

### Data Sources

- `GET /api/v1/users/{userId}/2fa`
- `POST /api/v1/users/{userId}/2fa`
- `DELETE /api/v1/users/{userId}/2fa`
- `GET /api/v1/biometric/credentials`
- `POST /api/v1/biometric/registration-options`
- `POST /api/v1/biometric/credentials`

### State Shape

```json
{
  "is2FAEnabled": "boolean",
  "isBiometricEnabled": "boolean",
  "pinInput": "string",
  "showConfirmModal": "boolean",
  "biometricCredentials": "array",
  "isLoading": "boolean"
}
```

---

## Biometrische Entsperrung

**Route:** `/settings/security/biometrics`

**User Stories:** `US-003`

**Layout:** flex column, padding 16px, gap 24px, max-width 400px

### Components

| Component | Position | Props | Responsive |
|-----------|----------|-------|------------|
| `COMP-004` TopBar | header | title=Biometrische Entsperrung, showBackButton=True, variant=default | mobile: visible, desktop: visible |
| `COMP-009` ToggleSwitch | main | label=Fingerabdruck aktivieren, variant=default | mobile: visible, desktop: visible |
| `COMP-009` ToggleSwitch | main | label=Gesichtserkennung aktivieren, variant=default | mobile: visible, desktop: visible |
| `COMP-001` Button | main | text=Fingerabdruck einrichten, variant=primary | mobile: visible, desktop: visible |
| `COMP-001` Button | main | text=Gesichtserkennung einrichten, variant=primary | mobile: visible, desktop: visible |
| `COMP-001` Button | main | text=Biometrische Daten löschen, variant=danger | mobile: visible, desktop: visible |
| `COMP-010` ModalDialog | modal | title=Biometrische Daten löschen?, variant=alert | mobile: visible, desktop: visible |

### Data Sources

- `GET /api/v1/biometric/credentials`
- `POST /api/v1/biometric/registration-options`
- `POST /api/v1/biometric/credentials`
- `DELETE /api/v1/biometric/credentials/{credentialId}`

### State Shape

```json
{
  "biometricCredentials": "array",
  "fingerprintEnabled": "boolean",
  "faceRecognitionEnabled": "boolean",
  "isLoading": "boolean",
  "showDeleteModal": "boolean",
  "registrationChallenge": "object"
}
```

---

## Passkeys verwalten

**Route:** `/settings/security/passkeys`

**Layout:** flex column, full-width, padding 16px

### Components

| Component | Position | Props | Responsive |
|-----------|----------|-------|------------|
| `COMP-004` TopBar | header | title=Passkeys, showBackButton=True, variant=default | mobile: visible, desktop: visible |
| `COMP-001` Button | main | text=Neuen Passkey hinzufügen, variant=primary, fullWidth=True | mobile: visible, desktop: visible |
| `COMP-001` Button | modal | text=Passkey erstellen, variant=primary | mobile: visible, desktop: visible |
| `COMP-001` Button | modal | text=Abbrechen, variant=outline | mobile: visible, desktop: visible |
| `COMP-001` Button | modal | text=Löschen, variant=danger | mobile: visible, desktop: visible |
| `COMP-010` ModalDialog | modal | variant=default, title=Passkey hinzufügen | mobile: visible, desktop: visible |
| `COMP-010` ModalDialog | modal | variant=alert, title=Passkey löschen | mobile: visible, desktop: visible |

### Data Sources

- `GET /api/v1/biometric/credentials`
- `POST /api/v1/biometric/registration-options`
- `POST /api/v1/biometric/credentials`
- `DELETE /api/v1/biometric/credentials/{credentialId}`

### State Shape

```json
{
  "passkeys": "array",
  "isLoading": "boolean",
  "showAddModal": "boolean",
  "showDeleteModal": "boolean",
  "selectedPasskey": "object|null",
  "error": "string|null"
}
```

---

## Geraet hinzufügen

**Route:** `/settings/devices/add`

**Layout:** flex column, centered, max-width 400px, padding 20px, gap 16px

### Components

| Component | Position | Props | Responsive |
|-----------|----------|-------|------------|
| `COMP-004` TopBar | header | title=Gerät hinzufügen, showBackButton=True, variant=default | mobile: visible, desktop: visible |
| `COMP-002` TextInput | main | label=Gerätename, placeholder=Mein neues Gerät, variant=outline, required=True | mobile: visible, desktop: visible |
| `COMP-002` TextInput | main | label=Telefonnummer, placeholder=+49 123 456789, variant=outline, type=tel, required=True | mobile: visible, desktop: visible |
| `COMP-003` OTPInput | main | label=Bestätigungscode, variant=numeric, length=6, hidden=True | mobile: visible, desktop: visible |
| `COMP-001` Button | main | text=Code anfordern, variant=primary, fullWidth=True | mobile: visible, desktop: visible |
| `COMP-001` Button | main | text=Code erneut senden, variant=ghost, hidden=True | mobile: visible, desktop: visible |
| `COMP-001` Button | main | text=Gerät hinzufügen, variant=primary, fullWidth=True, disabled=True | mobile: visible, desktop: visible |

### Data Sources

- `POST /api/v1/phone-registrations`
- `POST /api/v1/phone-registrations/{registrationId}/verify`
- `POST /api/v1/phone-registrations/{registrationId}/resend-otp`
- `POST /api/v1/devices`

### State Shape

```json
{
  "deviceName": "string",
  "phoneNumber": "string",
  "otpCode": "string",
  "registrationId": "string",
  "isOtpSent": "boolean",
  "isVerifying": "boolean",
  "isRegistering": "boolean",
  "errors": "object"
}
```

---

## Geraete-Details

**Route:** `/settings/devices/:id`

**Layout:** flex column, centered, max-width 400px, padding 16px, gap 24px

### Components

| Component | Position | Props | Responsive |
|-----------|----------|-------|------------|
| `COMP-004` TopBar | header | title=Gerät Details, showBackButton=True, variant=default | mobile: visible, desktop: visible |
| `COMP-008` Avatar | main | variant=rounded, size=large, icon=device | mobile: visible, desktop: visible |
| `COMP-009` ToggleSwitch | main | label=Biometrische Authentifizierung, variant=default | mobile: visible, desktop: visible |
| `COMP-009` ToggleSwitch | main | label=2FA aktiviert, variant=default | mobile: visible, desktop: visible |
| `COMP-001` Button | main | text=Gerät entfernen, variant=danger | mobile: visible, desktop: visible |
| `COMP-010` ModalDialog | modal | title=Gerät entfernen, message=Möchten Sie dieses Gerät wirklich entfernen?, variant=alert | mobile: visible, desktop: visible |

### Data Sources

- `GET /api/v1/devices`
- `GET /api/v1/biometric/credentials`
- `GET /api/v1/users/{userId}/2fa`
- `DELETE /api/v1/biometric/credentials/{credentialId}`
- `DELETE /api/v1/users/{userId}/2fa`

### State Shape

```json
{
  "device": "object",
  "biometricEnabled": "boolean",
  "twoFactorEnabled": "boolean",
  "showDeleteModal": "boolean",
  "loading": "boolean",
  "error": "string|null"
}
```

---

