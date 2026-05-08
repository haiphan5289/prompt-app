# Examples — pa-git-diff

## Example 1: Simple feature branch, default target

**Input:**
```
TARGET: main
```

**Output (abbreviated):**

```
Branch: feature/add-chain-of-thought → main
Files changed: 6
Insertions: +142 | Deletions: -8
Features touched: transformer, pattern_library
```

**Changes by Layer:**

Domain Layer (`lib/features/transformer/domain/`)
- New UseCases: `ApplyChainOfThoughtUseCase`
- New repository interfaces: none

Data Layer (`lib/features/transformer/data/`)
- New pattern seeds added: `cot_basic`, `cot_expert`

Presentation Layer (`lib/features/transformer/presentation/`)
- Modified widgets: `TransformerInputCard`

Tests (`test/`)
- New tests: 2
- Modified tests: 1

**Review Checklist (excerpt):**
- [x] No cross-layer imports
- [x] New UseCase injected via `@riverpod`
- [x] `{{userInput}}` present in both new patterns
- [ ] New screens have widget tests — N/A (no new screens)

**PR Description:**
```markdown
## What
Adds Chain-of-Thought prompt pattern to the transformer engine.

## Why
PA-88: Users need step-by-step reasoning patterns for complex queries.

## Changes
- Added `ApplyChainOfThoughtUseCase` in domain
- Seeded two new patterns: `cot_basic`, `cot_expert`
- Updated `TransformerInputCard` to surface the new pattern category

## Test Plan
- [ ] Tap "Chain of Thought" pattern, enter a prompt, verify output shows numbered reasoning steps
- [ ] flutter test passes
```

---

## Example 2: Focused on presentation layer only

**Input:**
```
TARGET: main
FLAGS:
  --focus presentation
```

**Output (abbreviated):**

Only the Presentation Layer section is shown:

```
Presentation Layer (lib/features/*/presentation/)
- New screens: HistoryDetailScreen
- New notifiers: HistoryDetailNotifier
- Modified widgets: HistoryListTile
```

All other layer sections are omitted. Review checklist items for Domain, Data, and Patterns are marked N/A.

---

## Example 3: Full diff from a specific commit

**Input:**
```
TARGET: main
FLAGS:
  --full
  --since d9f3a12
```

**Output:**

All five sections produced as normal, but the diff is bounded from commit `d9f3a12` to HEAD. Full file diffs are shown inline after the Changes by Layer section before the checklist, wrapped in `diff` code blocks.
