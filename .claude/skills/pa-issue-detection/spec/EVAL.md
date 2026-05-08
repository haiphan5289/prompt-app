# Quality Checklist — pa-issue-detection

Use this checklist to verify the scan was complete and the report is accurate.

## Scan Completeness (5 items)

- [ ] 1. `git diff main...HEAD --name-only | grep '\.dart$'` was run to collect changed files
- [ ] 2. Every changed Dart file was read (not just sampled)
- [ ] 3. Generated files (`*.g.dart`) were excluded from the scan
- [ ] 4. P08 (print check) was applied only to non-`test/` files
- [ ] 5. Files with no issues are listed in the CLEAN section

## Pattern Coverage (12 items — one per pattern)

- [ ] 6. P01 (unguarded bang) — every `!` checked for `// safe:` comment
- [ ] 7. P02 (context after await) — every `await` + `context.` pair checked for mounted guard
- [ ] 8. P03 (ref.watch in callback) — all `ref.watch` occurrences checked for build() context
- [ ] 9. P04 (direct state mutation) — `state.` + mutating operation checked
- [ ] 10. P05 (missing error case) — every `.when(` checked for `error:` parameter
- [ ] 11. P06 (unsubstituted template) — strings containing `{{` checked for `.replaceAll` chain
- [ ] 12. P07 (missing trim) — `replaceAll('{{userInput}}',` checked for `.trim()` on value
- [ ] 13. P08 (print in production) — `print(` checked in non-test files
- [ ] 14. P09 (Hive box before open) — `Hive.box(` checked in non-main files
- [ ] 15. P10 (missing part directive) — every `@riverpod` checked for `part '*.g.dart';`
- [ ] 16. P11 (setState for business state) — `setState` calls checked for non-UI state updates
- [ ] 17. P12 (Navigator.push) — `Navigator.of(context).push` checked

## Issue Report Quality (6 items)

- [ ] 18. Every flagged issue includes exact file path and line number
- [ ] 19. Every flagged issue includes pattern ID (P01–P12)
- [ ] 20. Every flagged issue includes a specific fix, not vague advice
- [ ] 21. Risk levels assigned correctly: HIGH / MEDIUM / LOW per the pattern definitions
- [ ] 22. Total issue counts in summary are accurate
- [ ] 23. Recommendation is one of: BLOCK merge / merge with caution / safe to merge

## Accuracy Checks (2 items)

- [ ] 24. No false positives: `// safe:` comments on bang operators are NOT flagged as P01
- [ ] 25. No issues reported in files that were not in the changed file list
