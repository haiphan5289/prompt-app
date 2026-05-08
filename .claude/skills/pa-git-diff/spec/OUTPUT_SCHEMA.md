# Output Schema — pa-git-diff

The skill produces five numbered sections in a single response.

## Section 1: Summary

```
Branch: [current] → [target]
Files changed: N
Insertions: +N | Deletions: -N
Features touched: [transformer | pattern_library | history | core]
```

## Section 2: Changes by Layer

**Domain Layer** (`lib/features/*/domain/`)
- New entities: [list]
- Modified entities: [list]
- New UseCases: [list]
- New repository interfaces: [list]

**Data Layer** (`lib/features/*/data/`)
- New datasources: [list]
- Modified repositories: [list]
- New pattern seeds added: [list ids]

**Presentation Layer** (`lib/features/*/presentation/`)
- New screens: [list]
- New notifiers: [list]
- Modified widgets: [list]

**Core** (`lib/core/`)
- Router changes: [yes/no]
- New providers in DI: [list]
- Theme changes: [yes/no]

**Tests** (`test/`)
- New tests: [count]
- Modified tests: [count]

## Section 3: Review Checklist

Checkbox list (see EVAL.md for full items). Each item marked `[x]` (pass) or `[ ]` (fail/not verified).

## Section 4: PR Description

```markdown
## What
[1–3 sentence summary of what changed]

## Why
[The feature or bug this addresses]

## Changes
- [bullet per significant change]

## Test Plan
- [ ] [manual test step 1]
- [ ] [manual test step 2]
- [ ] `flutter test` passes
```

## Section 5: Suggested Next Steps

Bulleted list of any flagged items: missing tests, open TODOs, violations discovered, or files requiring follow-up.
