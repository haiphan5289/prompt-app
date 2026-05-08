# Quality Checklist — pa-theme

Run these checks after applying theme changes. All items must pass.

## Color Tokens

- [ ] 1. No `Colors.*` values used (e.g. `Colors.purple`, `Colors.blue`, `Colors.white`)
- [ ] 2. No hardcoded hex `Color(0xFF...)`
- [ ] 3. Semantic colors use `Theme.of(context).colorScheme.*`
- [ ] 4. Domain-specific colors (category) use `AppColors.*`
- [ ] 5. No `Color.fromARGB(...)` or `Color.fromRGBO(...)` inline values
- [ ] 6. Category colors accessed via `categoryColor(category)` helper function

## Typography Tokens

- [ ] 7. No hardcoded `fontSize` values
- [ ] 8. No hardcoded `fontWeight` values (e.g. `FontWeight.bold`, `FontWeight.w600`)
- [ ] 9. No hardcoded `fontFamily` values
- [ ] 10. All text styles use `Theme.of(context).textTheme.*`
- [ ] 11. Modified styles use `.copyWith()` (e.g. changing only color on a base token)

## Spacing Tokens

- [ ] 12. No hardcoded numeric padding values (e.g. `EdgeInsets.all(16)`)
- [ ] 13. No hardcoded `SizedBox(height: 24)` etc.
- [ ] 14. All spacing from `AppSpacing.xs/sm/md/lg/xl/xxl`

## ThemeData (if app_theme.dart modified)

- [ ] 15. `useMaterial3: true` is set on both light and dark
- [ ] 16. Both `light` and `dark` getters are present
- [ ] 17. Both use the same `seedColor`
- [ ] 18. `Brightness.light` / `Brightness.dark` passed correctly
- [ ] 19. No manual `Brightness` branching in widgets — `colorScheme.*` adapts automatically

## Dark Mode

- [ ] 20. `MaterialApp` has both `theme` and `darkTheme`
- [ ] 21. `themeMode: ThemeMode.system` (unless explicit override is requested)
- [ ] 22. No widget branches on `Brightness` with `if/switch` — all resolved via tokens
- [ ] 23. Dark mode visually tested (or reasoned to be correct via `colorScheme.*` tokens)

## AppColors (if modified)

- [ ] 24. New color entries are `const Color`
- [ ] 25. New entry added to `categoryColor()` switch function
- [ ] 26. New entry name is camelCase, descriptive of the category

## Analysis

- [ ] 27. `flutter analyze` passes with zero errors on all modified files
- [ ] 28. No unused imports
