# Post-Execution Steps — pa-figma-implement

After generating the widget or screen, complete these steps.

## 1. Run Static Analysis

```bash
flutter analyze lib/features/{{feature}}/presentation/
```

Fix all errors and warnings. Common post-generation issues:
- Missing imports for `AppSpacing`, `AppColors`
- Unresolved provider names (verify they exist)
- `ConsumerWidget` used without `flutter_riverpod` import

## 2. Visual Side-by-Side Comparison

Open the Figma design and the app simulator side by side:
- [ ] Layout matches — Column/Row/Stack structure same as Figma
- [ ] Spacing matches — gaps between elements match Figma (within one token step)
- [ ] Colors match — primary color, surface colors, accent colors
- [ ] Typography matches — text size hierarchy matches Figma
- [ ] Alignment matches — left/center/right/stretch

## 3. Verify All States

For each state visible in Figma, confirm it renders in the app:
- [ ] Empty state (no data)
- [ ] Loading state (`LinearProgressIndicator` or spinner)
- [ ] Error state (error text with `colorScheme.error`)
- [ ] Data state (full content)
- [ ] Selected/active state (if applicable — chips, list items)
- [ ] Disabled state (if applicable — buttons, inputs)

## 4. Dark Mode Test

- [ ] Toggle device to dark mode
- [ ] Colors adapt correctly — no hardcoded colors remain visible as wrong color
- [ ] Text remains readable
- [ ] Card surfaces and backgrounds adjust

## 5. Overflow / Responsiveness Test

- [ ] Test on small screen (iPhone SE — 375px wide)
- [ ] Test on standard screen (iPhone 15 — 390px wide)
- [ ] Test on large screen (iPad — 768px+) if the design requires it
- [ ] No overflow errors (yellow/black stripes)

## 6. Accessibility

- [ ] All interactive elements have `tooltip` (IconButton, FAB)
- [ ] Text contrast is sufficient (Material 3 tokens ensure this)
- [ ] `SelectableText` present for prompt output (screen reader can read it)

## 7. Wire to State

If the widget is a `ConsumerWidget`, confirm:
- The provider it watches is implemented and registered
- The `state.when(data:, loading:, error:)` pattern is complete
- Notifier method is called correctly on user interaction

## 8. Request Designer Sign-Off

Share a screenshot of the implemented screen with the designer for approval before merging.

## 9. Write Widget Tests

Use `pa-unittest` to generate tests:
- Golden test for visual regression (if golden tests are set up)
- Widget test for each state (empty, loading, error, data)
- Interaction test for tappable elements
