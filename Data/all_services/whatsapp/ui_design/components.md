# Component Library

## Button

**ID:** `COMP-001`
**Type:** button

Primary action button for form submissions and key actions

### Variants

- `primary`
- `secondary`
- `outline`
- `ghost`
- `danger`

### Props

| Prop | Type |
|------|------|
| `size` | `sm | md | lg` |
| `disabled` | `boolean` |
| `loading` | `boolean` |
| `icon` | `ReactNode (optional)` |
| `onClick` | `() => void` |
| `type` | `button | submit` |

### States

- default
- hover
- active
- focus
- disabled
- loading

### Accessibility

- **role:** button
- **aria-label:** Required for icon-only buttons
- **aria-disabled:** When disabled

### Example

```tsx
<Button variant='primary' size='md' type='submit'>Weiter</Button>
```

---

## TextInput

**ID:** `COMP-002`
**Type:** input

Single-line text input with label and helper/error text

### Variants

- `default`
- `filled`
- `outline`

### Props

| Prop | Type |
|------|------|
| `label` | `string` |
| `placeholder` | `string` |
| `value` | `string` |
| `onChange` | `(value: string) => void` |
| `type` | `text | password | email | tel` |
| `disabled` | `boolean` |
| `error` | `string (optional)` |
| `helperText` | `string (optional)` |

### States

- default
- focus
- filled
- error
- disabled

### Accessibility

- **role:** textbox
- **aria-label:** If label is visually hidden
- **aria-invalid:** When error

### Example

```tsx
<TextInput label='E-Mail' placeholder='name@mail.com' />
```

---

## PhoneInput

**ID:** `COMP-003`
**Type:** input

Phone number input with country selector and formatting

### Variants

- `default`
- `compact`

### Props

| Prop | Type |
|------|------|
| `label` | `string` |
| `value` | `string` |
| `onChange` | `(value: string, country: string) => void` |
| `defaultCountry` | `string (ISO code)` |
| `disabled` | `boolean` |
| `error` | `string (optional)` |

### States

- default
- focus
- error
- disabled

### Accessibility

- **role:** textbox
- **aria-label:** If label is visually hidden

### Example

```tsx
<PhoneInput label='Mobilnummer' defaultCountry='DE' />
```

---

## OTPInput

**ID:** `COMP-004`
**Type:** input

Multi-field input for one-time passcodes (e.g., 6-digit)

### Variants

- `6-digit`
- `4-digit`

### Props

| Prop | Type |
|------|------|
| `length` | `number` |
| `value` | `string` |
| `onChange` | `(value: string) => void` |
| `autoFocus` | `boolean` |
| `disabled` | `boolean` |
| `error` | `string (optional)` |

### States

- default
- focus
- filled
- error
- disabled

### Accessibility

- **role:** group
- **aria-label:** One-time code input

### Example

```tsx
<OTPInput length={6} onChange={setCode} />
```

---

## AuthCard

**ID:** `COMP-005`
**Type:** container

Centered card layout for auth screens with logo/title slot

### Variants

- `default`
- `compact`

### Props

| Prop | Type |
|------|------|
| `title` | `string` |
| `subtitle` | `string (optional)` |
| `children` | `ReactNode` |
| `logo` | `ReactNode (optional)` |

### States

- default

### Accessibility

- **role:** region
- **aria-labelledby:** Title id

### Example

```tsx
<AuthCard title='Willkommen' subtitle='Bitte anmelden'>...</AuthCard>
```

---

## ToggleSwitch

**ID:** `COMP-006`
**Type:** switch

Binary toggle for settings like 2FA activation

### Variants

- `default`
- `compact`

### Props

| Prop | Type |
|------|------|
| `checked` | `boolean` |
| `onChange` | `(checked: boolean) => void` |
| `disabled` | `boolean` |
| `label` | `string (optional)` |

### States

- default
- checked
- focus
- disabled

### Accessibility

- **role:** switch
- **aria-checked:** When checked

### Example

```tsx
<ToggleSwitch checked={twoFA} onChange={setTwoFA} label='2FA aktivieren' />
```

---

## Checkbox

**ID:** `COMP-007`
**Type:** checkbox

Checkbox for confirmations like Terms & Privacy

### Variants

- `default`

### Props

| Prop | Type |
|------|------|
| `checked` | `boolean` |
| `onChange` | `(checked: boolean) => void` |
| `disabled` | `boolean` |
| `label` | `string` |

### States

- default
- checked
- focus
- disabled

### Accessibility

- **role:** checkbox
- **aria-checked:** When checked

### Example

```tsx
<Checkbox label='Ich akzeptiere die AGB' />
```

---

## PasskeyButton

**ID:** `COMP-008`
**Type:** button

Specialized button for Passkey login with platform icon

### Variants

- `primary`
- `outline`

### Props

| Prop | Type |
|------|------|
| `label` | `string` |
| `providerIcon` | `ReactNode (optional)` |
| `loading` | `boolean` |
| `onClick` | `() => void` |

### States

- default
- hover
- active
- focus
- disabled
- loading

### Accessibility

- **role:** button
- **aria-label:** Passkey login button

### Example

```tsx
<PasskeyButton label='Mit Passkey anmelden' />
```

---

## BiometricPrompt

**ID:** `COMP-009`
**Type:** modal

Modal prompt for biometric authentication (Face ID / Fingerprint)

### Variants

- `faceid`
- `fingerprint`

### Props

| Prop | Type |
|------|------|
| `open` | `boolean` |
| `type` | `faceid | fingerprint` |
| `onCancel` | `() => void` |
| `onRetry` | `() => void` |

### States

- open
- loading
- error

### Accessibility

- **role:** dialog
- **aria-modal:** true
- **aria-label:** Biometric authentication

### Example

```tsx
<BiometricPrompt open type='faceid' onCancel={close} />
```

---

## Alert

**ID:** `COMP-010`
**Type:** feedback

Inline alert for errors, success, or info messages

### Variants

- `info`
- `success`
- `warning`
- `error`

### Props

| Prop | Type |
|------|------|
| `title` | `string (optional)` |
| `message` | `string` |
| `icon` | `ReactNode (optional)` |
| `dismissible` | `boolean` |
| `onDismiss` | `() => void` |

### States

- default

### Accessibility

- **role:** alert
- **aria-live:** polite

### Example

```tsx
<Alert variant='error' message='Code ungültig' />
```

---

