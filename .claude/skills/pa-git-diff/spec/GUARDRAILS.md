# Guardrails — pa-git-diff

## Anti-Hallucination Rules

1. **Only report files that appear in the actual git diff output.** Do not infer or guess additional changed files.
2. **Layer classification must be based on file paths, not assumptions.** Use exact path prefix matching (`lib/features/*/domain/`, etc.).
3. **Do not invent class names or symbol names.** Only name symbols that are visible in the diff hunk.
4. **Do not fabricate test counts.** Count only files matching `test/**/*_test.dart` that appear in the diff.
5. **Do not assume `flutter analyze` passes.** Only report it as passing if explicitly run and confirmed.

## Prohibited Patterns

- Do not include business-sensitive content (revenue targets, OKRs, competitor names) in the PR Description output.
- Do not mark checklist items `[x]` without evidence from the diff. When in doubt, mark `[ ]` and note "not verified".
- Do not summarise files outside `lib/` and `test/` directories in the layer sections (ignore `android/`, `ios/`, `pubspec.yaml` unless specifically relevant).
- Do not produce a PR description if the diff is empty — emit a warning instead.

## Verified Layer Path Prefixes

| Layer | Path prefix |
|---|---|
| Domain | `lib/features/*/domain/` |
| Data | `lib/features/*/data/` |
| Presentation | `lib/features/*/presentation/` |
| Core | `lib/core/` |
| Tests | `test/` |

## Scope

This skill reads git history only — it does not modify any files, create branches, or push to remote.
