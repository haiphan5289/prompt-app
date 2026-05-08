# Guardrails — pa-design-system

## Core Rule

Only use Material 3 components from the approved list. Do not invent custom base components when a Material equivalent exists.

## Prohibited Patterns

### Wrong Button Types

```dart
// NEVER — deprecated / wrong semantic
ElevatedButton(...)       // prohibited — use FilledButton for primary
RaisedButton(...)         // deprecated
FlatButton(...)           // deprecated

// ALWAYS
FilledButton(...)         // primary CTA
OutlinedButton(...)       // secondary action
TextButton(...)           // tertiary / destructive
IconButton(...)           // icon-only
```

### Hardcoded Colors

```dart
// NEVER
Colors.blue, Colors.purple, Colors.red
Color(0xFF...)

// ALWAYS — theme tokens
Theme.of(context).colorScheme.primary
Theme.of(context).colorScheme.error
AppColors.roleBased
```

### Hardcoded Typography

```dart
// NEVER
fontWeight: FontWeight.bold
fontSize: 14

// ALWAYS
style: Theme.of(context).textTheme.bodyMedium
style: Theme.of(context).textTheme.labelSmall
```

### Hardcoded Border Radius

```dart
// NEVER
BorderRadius.circular(8),
BorderRadius.circular(12),

// PREFER — use card theme shape or define a constant
```

### Non-Copyable Prompt Output

```dart
// NEVER — plain Text cannot be selected/copied by user
Text(result.enhancedPrompt)

// ALWAYS — SelectableText allows user to copy
SelectableText(result.enhancedPrompt)
```

### Wrong Loading Indicator Placement

```dart
// NEVER — full-screen loading blocks entire screen for inline operations
Scaffold(body: Center(child: CircularProgressIndicator()))

// CORRECT
// Inline/stream loading: LinearProgressIndicator at top of content area
// Center-of-section loading: CircularProgressIndicator centered in its section only
```

### Scrolling on Fixed List

```dart
// NEVER — pure Column without scroll on a screen that might overflow
Scaffold(
  body: Column(children: [...many children...]) // will overflow on small screens
)

// ALWAYS
Scaffold(
  body: SingleChildScrollView(
    child: Column(children: [...])
  )
)
```

## Verified Material 3 Widget Names

| Widget | Notes |
|---|---|
| `FilledButton` | M3 primary button — replaces ElevatedButton for CTAs |
| `OutlinedButton` | M3 secondary button |
| `TextButton` | M3 tertiary button |
| `IconButton` | Icon-only action |
| `FilterChip` | Selectable chip |
| `Chip` | Display-only chip |
| `Card` | Surface container |
| `ListTile` | Row layout |
| `TextField` | Text input |
| `SelectableText` | User-selectable text |
| `LinearProgressIndicator` | Inline loading bar |
| `CircularProgressIndicator` | Spinner |
| `SnackBar` | Transient feedback |
| `NavigationBar` | Bottom navigation |
| `NavigationRail` | Side navigation (tablet) |
| `DraggableScrollableSheet` | Bottom sheet with drag |
| `Divider` | Horizontal separator |
| `Spacer` | Flex spacer in Row/Column |

## Do Not Invent

Do not assume or invent widget or class names that are not listed above or confirmed in the codebase:
- Do not use `PromptCard` unless confirmed in `lib/features/`
- Do not use `PatternListView` unless confirmed
- Do not reference provider names unless confirmed with `@riverpod` or `final` declaration
