# Post-Execution Steps — pa-design-system

After implementing a screen or component using the design system, complete these steps.

## 1. Run Static Analysis

```bash
flutter analyze lib/features/{{feature}}/
```

Fix all errors and warnings before proceeding.

## 2. Visual Review Checklist

Open the screen in a simulator or device and verify:
- [ ] All buttons have the correct type (Filled = primary, Outlined = secondary)
- [ ] Card backgrounds use `surfaceVariant` for result areas, default `surface` otherwise
- [ ] Prompt output is `SelectableText` — user can long-press and copy
- [ ] Copy button present with `Icons.copy_outlined`
- [ ] Loading state shows `LinearProgressIndicator` inline
- [ ] Error state shows inline `Text` with `colorScheme.error`

## 3. Dark Mode Test

Toggle the device to dark mode:
- [ ] All surfaces adapt correctly — no hardcoded white/black
- [ ] Text remains readable
- [ ] Category chip colors are visible (they are `AppColors.*` — static, check contrast)

## 4. Overflow Test

Resize the simulator to a smaller screen (e.g. iPhone SE) and verify:
- [ ] No overflow errors (yellow/black stripes)
- [ ] `SingleChildScrollView` scroll works correctly
- [ ] Pattern selector row scrolls horizontally

## 5. Accessibility Check

- [ ] All interactive elements have `tooltip` or semantic label
- [ ] Copy button: `tooltip: 'Copy to clipboard'` present
- [ ] `IconButton` for info: `tooltip: 'Pattern details'` or similar
- [ ] Text contrast sufficient (Material 3 + `colorScheme` ensures this automatically)

## 6. Verify Imports

Confirm all component imports are correct:
- `AppSpacing` from `lib/core/theme/app_spacing.dart`
- `AppColors` from `lib/core/theme/app_colors.dart`
- `categoryColor` from `lib/core/theme/app_colors.dart`
- Feature widgets from their respective `widgets/` folder

## 7. Write Widget Tests

Use `pa-unittest` to generate tests for the implemented screen or component:
- Test empty state renders without error
- Test loading state shows `LinearProgressIndicator`
- Test error state shows error text
- Test data state shows expected content
