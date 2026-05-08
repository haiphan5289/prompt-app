# Quality Checklist — pa-figma-implement

Run all checks after generating the widget or screen. All items must pass.

## Design Fidelity

- [ ] 1. Colors match Figma — all mapped from `colorScheme.*` or `AppColors.*`
- [ ] 2. Typography matches Figma — all from `textTheme.*`
- [ ] 3. Spacing matches Figma — all from `AppSpacing.*`
- [ ] 4. Layout structure (Column/Row/Stack) matches the Figma hierarchy
- [ ] 5. Component hierarchy depth matches Figma nesting

## Interactive States

- [ ] 6. Normal state implemented
- [ ] 7. Pressed/hover state handled (Material handles via `InkWell`/button ripple automatically)
- [ ] 8. Disabled state implemented where applicable (pass `null` for `onPressed`)
- [ ] 9. Loading state handled (shows `LinearProgressIndicator` or spinner)
- [ ] 10. Empty state handled if the component shows a list or content area
- [ ] 11. Error state handled (shows error text with `colorScheme.error`)

## Code Quality

- [ ] 12. All `const` constructors applied
- [ ] 13. `build()` under 50 lines or extracted to `_SubWidget` helpers
- [ ] 14. Private sub-widgets use leading underscore naming
- [ ] 15. No business logic in `build()` — only layout + theme token references

## Theme Compliance

- [ ] 16. No hardcoded `Colors.*` values
- [ ] 17. No hardcoded hex `Color(0xFF...)`
- [ ] 18. No hardcoded `fontSize`, `fontWeight`, or `fontFamily`
- [ ] 19. No hardcoded pixel padding/margin values
- [ ] 20. No hardcoded `BorderRadius.circular(N)` — use theme shape or constant

## Prompt App Specifics

- [ ] 21. Prompt/result text uses `SelectableText` — not plain `Text`
- [ ] 22. Copy button uses `Icons.copy_outlined`
- [ ] 23. Transform action button uses `Icons.auto_fix_high`
- [ ] 24. Pattern chips use `FilterChip` — not custom chip widget
- [ ] 25. Card result area background uses `colorScheme.surfaceVariant`

## Widget Architecture

- [ ] 26. `ConsumerWidget` only when widget reads a provider
- [ ] 27. `StatelessWidget` when all data comes via props
- [ ] 28. Provider names verified to exist before referencing

## Analysis

- [ ] 29. `flutter analyze` passes with zero errors
- [ ] 30. No unused imports
