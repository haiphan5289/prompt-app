# Execution Workflow — pa-design-system

## Step 1: Determine the UI Task

Classify what is being built:

| Task Type | Action |
|---|---|
| New screen | Use Transformer Screen Layout as the scaffold |
| New card | Use Pattern Card or Result Card pattern |
| New list item | Use History Entry pattern |
| New input | Select from Component Selection Guide |
| New navigation | Use NavigationBar (phone) or NavigationRail (tablet) |

## Step 2: Select the Right Component

Use the Component Selection Guide to pick the correct Material component:

| Need | Use |
|---|---|
| Multi-line text input | `TextField` with `maxLines: null` |
| Single-line input | `TextField` with `textInputAction: TextInputAction.done` |
| Primary action | `FilledButton` |
| Secondary action | `OutlinedButton` |
| Destructive action | `TextButton` with `colorScheme.error` |
| Icon action | `IconButton` |
| Pattern tag / filter | `FilterChip` or `Chip` |
| Pattern card | `Card` with `ListTile` |
| Result text | `SelectableText` (allows user to copy) |
| Copy action | `IconButton(icon: Icon(Icons.copy_outlined))` |
| Loading (inline) | `LinearProgressIndicator` |
| Loading (center) | `CircularProgressIndicator` |
| Error (transient) | `SnackBar` |
| Error (inline) | `Text` with `colorScheme.error` |
| Bottom sheet | `showModalBottomSheet` with `DraggableScrollableSheet` |
| Navigation (phone) | `NavigationBar` |
| Navigation (tablet) | `NavigationRail` |

Do NOT invent custom components when a standard Material component exists.

## Step 3: Apply the Correct Icon

Use the icon table to pick the right `Icons.*` constant:

| Action | Icon |
|---|---|
| Copy | `Icons.copy_outlined` |
| Transform / Magic | `Icons.auto_fix_high` |
| Pattern Library | `Icons.grid_view_outlined` |
| History | `Icons.history` |
| Settings | `Icons.settings_outlined` |
| Pattern preview / Info | `Icons.info_outline` |
| Delete | `Icons.delete_outline` |
| Share | `Icons.share_outlined` |
| Search | `Icons.search` |

## Step 4: Build Screen Layout

For a new screen, use the Transformer Screen Layout pattern as the base:

```dart
Scaffold(
  appBar: AppBar(title: const Text('Screen Title')),
  body: SingleChildScrollView(
    padding: const EdgeInsets.all(AppSpacing.md),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // sections here, separated by SizedBox(height: AppSpacing.md/lg)
      ],
    ),
  ),
)
```

## Step 5: Apply Typography Scale

Map each text element to the correct typography level:

```
displayMedium  → App hero text ("Prompt App")
headlineMedium → Screen titles ("Pattern Library")
titleLarge     → Card titles, section headers
titleMedium    → Pattern names
bodyLarge      → Prompt content (actual prompts — must be readable)
bodyMedium     → Descriptions, secondary text
labelLarge     → Button text, tabs
labelMedium    → Chip labels, tags
labelSmall     → Timestamps, metadata, captions
```

## Step 6: Build Component-Specific Patterns

### Pattern Card
- `Card > Padding > Column`
- Row with `Chip` (category color) + `Spacer` + `IconButton` (info)
- Pattern name with `titleMedium`
- Description with `bodySmall`

### Result Card
- `Card` with `colorScheme.surfaceVariant`
- Row with `labelLarge` + `Spacer` + `CopyButton`
- `Divider`
- `SelectableText` with `bodyMedium`

### History Entry
- `ListTile`
- Title = original prompt, `maxLines: 1`, `overflow: ellipsis`, `bodyMedium`
- Subtitle = applied pattern name, `labelSmall`, `colorScheme.secondary`
- Trailing = formatted date, `labelSmall`

## Step 7: Verify

Run through EVAL.md checklist before marking done.
