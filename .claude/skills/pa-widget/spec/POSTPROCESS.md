# Post-Execution Steps — pa-widget

After generating the widget file, complete these steps.

## 1. Run Static Analysis

```bash
flutter analyze lib/features/{{feature}}/presentation/widgets/{{name_snake}}.dart
```

Fix any warnings or errors before proceeding.

## 2. Check Import Validity

Verify all imported types exist:
- Domain entity types (e.g. `PromptPattern`) — confirm the class exists in `domain/entities/`
- Provider names — confirm the provider is declared with `@riverpod` or `final`
- `AppSpacing` — confirm it is defined in `lib/core/theme/app_spacing.dart`
- `AppColors` — confirm it is defined in `lib/core/theme/app_colors.dart`

## 3. Register Widget Export (if applicable)

If the project uses barrel files (e.g. `widgets.dart`), add the new widget:

```dart
// lib/features/{{feature}}/presentation/widgets/widgets.dart
export '{{name_snake}}.dart';
```

## 4. Write a Widget Test

Use the `pa-unittest` skill to generate a widget test:

```
SKILL: pa-unittest
TARGET: {{Name}}
TYPE: widget
```

At minimum, verify:
- Widget renders without error
- Required props are accepted
- Callback fires on tap (if applicable)

## 5. Integrate into Parent Screen/Widget

Replace the placeholder in the parent widget with the new widget:
- Import the widget file
- Pass required props from the parent's data source
- Confirm layout looks correct in the simulator

## 6. Visual Check (Device/Simulator)

Run the app and verify:
- Colors match the design system (not hardcoded)
- Text styles use correct token scale
- Spacing is consistent with surrounding widgets
- Dark mode renders correctly (no hardcoded colors break)
- Widget scales correctly on different screen sizes (phone + tablet)
