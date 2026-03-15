# Component Library

## Button

**ID:** `COMP-001`
**Type:** button

Primary and secondary action button

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
| `fullWidth` | `boolean` |

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
<Button variant='primary' size='md'>Weiter</Button>
```

---

## TextInput

**ID:** `COMP-002`
**Type:** input

Single-line input for text, phone numbers, and search

### Variants

- `default`
- `filled`
- `outline`

### Props

| Prop | Type |
|------|------|
| `type` | `text | tel | password | search` |
| `value` | `string` |
| `placeholder` | `string` |
| `error` | `string (optional)` |
| `leadingIcon` | `ReactNode (optional)` |
| `trailingIcon` | `ReactNode (optional)` |
| `onChange` | `(value: string) => void` |

### States

- default
- focus
- filled
- error
- disabled

### Accessibility

- **role:** textbox
- **aria-label:** Input description required
- **aria-invalid:** When error

### Example

```tsx
<TextInput type='tel' placeholder='+49 123 456789' />
```

---

## OTPInput

**ID:** `COMP-003`
**Type:** input

Input group for 6-digit PIN/verification codes

### Variants

- `numeric`
- `masked`

### Props

| Prop | Type |
|------|------|
| `length` | `number` |
| `value` | `string` |
| `autoFocus` | `boolean` |
| `onChange` | `(value: string) => void` |
| `onComplete` | `(value: string) => void` |

### States

- default
- focus
- error
- disabled

### Accessibility

- **role:** group
- **aria-label:** One-time code input

### Example

```tsx
<OTPInput length={6} onComplete={verifyCode} />
```

---

## TopBar

**ID:** `COMP-004`
**Type:** navigation

App header with title, back button, and actions

### Variants

- `default`
- `transparent`
- `elevated`

### Props

| Prop | Type |
|------|------|
| `title` | `string` |
| `showBack` | `boolean` |
| `actions` | `ReactNode (optional)` |
| `onBack` | `() => void` |

### States

- default
- scrolled

### Accessibility

- **role:** navigation
- **aria-label:** Top navigation

### Example

```tsx
<TopBar title='Chats' actions={<IconButton icon={<Search/>} />} />
```

---

## BottomNav

**ID:** `COMP-005`
**Type:** navigation

Bottom navigation for main sections

### Variants

- `default`
- `labeled`

### Props

| Prop | Type |
|------|------|
| `items` | `NavItem[]` |
| `activeId` | `string` |
| `onChange` | `(id: string) => void` |

### States

- default
- active

### Accessibility

- **role:** navigation
- **aria-label:** Bottom navigation

### Example

```tsx
<BottomNav items={navItems} activeId='chats' />
```

---

## ChatListItem

**ID:** `COMP-006`
**Type:** list-item

Row showing chat preview with avatar, name, last message and unread badge

### Variants

- `default`
- `compact`

### Props

| Prop | Type |
|------|------|
| `avatarUrl` | `string` |
| `name` | `string` |
| `lastMessage` | `string` |
| `timestamp` | `string` |
| `unreadCount` | `number` |
| `onClick` | `() => void` |

### States

- default
- hover
- active
- selected

### Accessibility

- **role:** button
- **aria-label:** Open chat

### Example

```tsx
<ChatListItem name='Lisa' lastMessage='Hey!' unreadCount={2} />
```

---

## MessageBubble

**ID:** `COMP-007`
**Type:** message

Chat bubble for sent/received messages with status

### Variants

- `sent`
- `received`
- `system`

### Props

| Prop | Type |
|------|------|
| `text` | `string` |
| `time` | `string` |
| `status` | `sent | delivered | read` |
| `media` | `ReactNode (optional)` |

### States

- default
- selected

### Accessibility

- **role:** article
- **aria-label:** Message

### Example

```tsx
<MessageBubble variant='sent' text='Hallo!' status='read' />
```

---

## Avatar

**ID:** `COMP-008`
**Type:** image

User avatar with fallback initials

### Variants

- `circle`
- `rounded`

### Props

| Prop | Type |
|------|------|
| `src` | `string (optional)` |
| `name` | `string` |
| `size` | `xs | sm | md | lg | xl` |
| `onClick` | `() => void (optional)` |

### States

- default
- loading
- error

### Accessibility

- **role:** img
- **aria-label:** User avatar

### Example

```tsx
<Avatar name='Max' src='/max.jpg' size='lg' />
```

---

## ToggleSwitch

**ID:** `COMP-009`
**Type:** switch

Toggle for settings like 2FA, biometrics, and notifications

### Variants

- `default`

### Props

| Prop | Type |
|------|------|
| `checked` | `boolean` |
| `disabled` | `boolean` |
| `label` | `string` |
| `onChange` | `(checked: boolean) => void` |

### States

- default
- checked
- disabled
- focus

### Accessibility

- **role:** switch
- **aria-checked:** boolean

### Example

```tsx
<ToggleSwitch label='Biometrie aktivieren' checked />
```

---

## ModalDialog

**ID:** `COMP-010`
**Type:** dialog

Modal for confirmations, device limit alerts, and biometric fallback

### Variants

- `default`
- `alert`
- `fullscreen`

### Props

| Prop | Type |
|------|------|
| `title` | `string` |
| `open` | `boolean` |
| `onClose` | `() => void` |
| `actions` | `ReactNode (optional)` |

### States

- open
- closed

### Accessibility

- **role:** dialog
- **aria-modal:** true
- **aria-labelledby:** Dialog title id

### Example

```tsx
<ModalDialog title='Geräte-Limit erreicht' open />
```

---

