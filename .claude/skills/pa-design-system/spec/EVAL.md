# Quality Checklist — pa-design-system

Run these checks after implementing any screen or component. All items must pass.

## Component Selection

- [ ] 1. Primary CTA uses `FilledButton` — not `ElevatedButton` or `RaisedButton`
- [ ] 2. Secondary actions use `OutlinedButton`
- [ ] 3. Destructive actions use `TextButton` with `colorScheme.error` foreground color
- [ ] 4. Icon-only actions use `IconButton`
- [ ] 5. Selectable text (prompt output) uses `SelectableText`
- [ ] 6. Multi-line inputs use `TextField` with `maxLines: null`
- [ ] 7. Category filters use `FilterChip` — not custom widget
- [ ] 8. Pattern cards use `Card` with `ListTile` or structured `Padding > Column`

## Iconography

- [ ] 9. Copy action uses `Icons.copy_outlined`
- [ ] 10. Transform / Magic action uses `Icons.auto_fix_high`
- [ ] 11. Pattern Library navigation uses `Icons.grid_view_outlined`
- [ ] 12. History navigation uses `Icons.history`
- [ ] 13. Settings uses `Icons.settings_outlined`
- [ ] 14. Info / Preview uses `Icons.info_outline`
- [ ] 15. No non-standard icon names used (verify all `Icons.*` exist in material icons)

## Typography Scale

- [ ] 16. App title / hero text uses `displayMedium`
- [ ] 17. Screen titles use `headlineMedium`
- [ ] 18. Card and section headers use `titleLarge` or `titleMedium`
- [ ] 19. Prompt content uses `bodyLarge` (ensures readability)
- [ ] 20. Descriptions use `bodyMedium`
- [ ] 21. Button labels inherit from `FilledButton`/`OutlinedButton` defaults (no override needed)
- [ ] 22. Chip labels, tags use `labelMedium` or `labelSmall`
- [ ] 23. Timestamps and metadata use `labelSmall`

## Layout Structure

- [ ] 24. Screen body wrapped in `SingleChildScrollView` to handle overflow
- [ ] 25. Sections separated with `SizedBox(height: AppSpacing.md)` or `AppSpacing.lg`
- [ ] 26. Column uses `crossAxisAlignment: CrossAxisAlignment.stretch` for full-width children

## Color

- [ ] 27. Result/output cards use `colorScheme.surfaceVariant` background
- [ ] 28. Error text uses `colorScheme.error` color
- [ ] 29. Secondary metadata (pattern name in history) uses `colorScheme.secondary`
- [ ] 30. No raw `Colors.*` or hex values

## Analysis

- [ ] 31. `flutter analyze` passes with zero errors
- [ ] 32. No unused imports
