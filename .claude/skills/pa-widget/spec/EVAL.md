# Quality Checklist — pa-widget

Run these checks after generating a widget. All items must pass.

## Constructor

- [ ] 1. Widget has `const` constructor — no exceptions
- [ ] 2. `super.key` is passed in the constructor
- [ ] 3. Required props use `required this.propName`
- [ ] 4. Optional props use `this.propName` without `required`
- [ ] 5. Callbacks typed as `VoidCallback?` or `void Function(T)?`

## Base Class Selection

- [ ] 6. `ConsumerWidget` used only when the widget reads/watches a Riverpod provider
- [ ] 7. `StatelessWidget` used when widget takes all data via props
- [ ] 8. No `StatefulWidget` unless ephemeral UI state is genuinely needed and cannot be lifted

## Build Method

- [ ] 9. `build()` is 50 lines or fewer
- [ ] 10. If build() exceeds 50 lines, private `_SubWidget` helpers are extracted
- [ ] 11. Private sub-widgets use leading underscore naming (`_HeaderRow`, `_ErrorBanner`)
- [ ] 12. No business logic in `build()` — logic belongs in Notifier

## Theme Usage

- [ ] 13. All colors from `Theme.of(context).colorScheme.*` or `AppColors.*`
- [ ] 14. No raw `Colors.*` values (e.g. `Colors.purple`, `Colors.blue`)
- [ ] 15. No hardcoded hex `Color(0xFF...)`
- [ ] 16. All text styles from `Theme.of(context).textTheme.*`
- [ ] 17. No hardcoded `fontSize`, `fontWeight`, or `fontFamily`
- [ ] 18. All spacing from `AppSpacing.xs/sm/md/lg/xl/xxl`
- [ ] 19. No hardcoded numeric padding/margin values

## Widget Type Correctness

- [ ] 20. Card widgets use `Card` with appropriate child (`ListTile` or `Padding > Column`)
- [ ] 21. Selectable chips use `FilterChip`, display-only use `Chip`
- [ ] 22. Primary buttons use `FilledButton`, secondary use `OutlinedButton`
- [ ] 23. Copy actions use `IconButton` with `Icons.copy_outlined`
- [ ] 24. Result text areas use `SelectableText` (allows user to copy)

## Provider Usage (ConsumerWidget only)

- [ ] 25. Provider name verified to exist before referencing
- [ ] 26. Uses `ref.watch()` in build (not `ref.read()`)
- [ ] 27. Uses `state.when(data:, loading:, error:)` for `AsyncValue` states

## Imports

- [ ] 28. No unused imports
- [ ] 29. `flutter_riverpod` imported only when `ConsumerWidget` is used

## Analysis

- [ ] 30. `flutter analyze` passes with zero errors or warnings
