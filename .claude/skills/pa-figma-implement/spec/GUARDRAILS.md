# Guardrails — pa-figma-implement

## Anti-Hallucination Rules

### Verify Before Referencing

1. **Provider names** — before using `ref.watch(someProvider)`, confirm the provider is declared with `@riverpod` or `final someProvider = ...` in the codebase.
2. **Widget classes** — before using `PromptInputSection`, `PatternSelectorRow`, etc., confirm they exist in `lib/features/`. Do not invent widget names from the design file names.
3. **Theme tokens** — only use token names listed in GUARDRAILS of `pa-theme`. Do not invent token names (e.g. `colorScheme.cardBackground` does not exist).
4. **AppColors entries** — only reference entries confirmed in `app_colors.dart`. Do not reference `AppColors.transformer` unless confirmed.

See [pa-anti-hallucination](../../pa-anti-hallucination/SKILL.md) for full verification protocol.

## Prohibited Patterns

### Hardcoded Colors from Figma

```dart
// NEVER — even if Figma shows this exact hex
color: Color(0xFF6750A4),
color: Color(0xFFE8DEF8),
color: Colors.purple,

// ALWAYS — map to token
color: Theme.of(context).colorScheme.primary,
color: Theme.of(context).colorScheme.surfaceVariant,
```

### Pixel-for-Pixel Spacing

```dart
// NEVER — do not use Figma pixel values literally
padding: const EdgeInsets.all(16),
const SizedBox(height: 24),

// ALWAYS — round to nearest AppSpacing constant
padding: const EdgeInsets.all(AppSpacing.md),    // 16px → md
const SizedBox(height: AppSpacing.lg),            // 24px → lg
```

### Custom Text Styles from Figma

```dart
// NEVER — do not replicate Figma font specs directly
style: const TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w500,
  letterSpacing: 0.15,
),

// ALWAYS — map to textTheme token
style: Theme.of(context).textTheme.bodyLarge,
```

### Invented Token Names

```dart
// NEVER — these do not exist in Material 3
color: Theme.of(context).colorScheme.cardBackground,
color: Theme.of(context).colorScheme.promptSurface,
style: Theme.of(context).textTheme.promptText,

// ONLY USE — verified token names from pa-theme GUARDRAILS
color: Theme.of(context).colorScheme.surfaceVariant,
style: Theme.of(context).textTheme.bodyMedium,
```

### Non-Copyable Prompt Text

```dart
// NEVER — Figma may show a Text component but result text must be selectable
Text(result.enhancedPrompt)

// ALWAYS
SelectableText(result.enhancedPrompt)
```

### Skipping States Shown in Figma

Figma designs often include multiple frames for the same component: empty, loading, error, and data. Do not implement only the "happy path". If Figma shows a loading skeleton or error state, implement all states.

## Verified Figma → Flutter Mappings

| Figma Term | Flutter Equivalent |
|---|---|
| Frame / Group | `Column`, `Row`, `Stack`, or `SizedBox` |
| Auto Layout (vertical) | `Column` with `mainAxisSize: MainAxisSize.min` |
| Auto Layout (horizontal) | `Row` |
| Fill container | `crossAxisAlignment: CrossAxisAlignment.stretch` or `Expanded` |
| Hug contents | `mainAxisSize: MainAxisSize.min` |
| Fixed frame | `SizedBox(width: ..., height: ...)` |
| Corner radius | `BorderRadius` (prefer theme shape over hardcoded) |
| Text (single line) | `Text` |
| Text (long, readable) | `SelectableText` for prompt output |
| Image / illustration | `Image.asset(...)` or `SvgPicture.asset(...)` |
| Component / Instance | Existing widget class — verify it exists |
| Chip | `Chip` or `FilterChip` |
| Input field | `TextField` |
| Button (filled) | `FilledButton` |
| Button (outlined) | `OutlinedButton` |
| Icon | `Icon(Icons.name_here)` — verify name exists |
