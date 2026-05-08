# Feature Pipeline — Execution Workflow

Single-entry orchestrator. Input once → output: domain model + Riverpod providers + screens + tests.

---

## Phase 0: Scope Clarification

Before any implementation:

1. Read `README.md` to confirm the feature aligns with app goals
2. Read `CLAUDE.md` for architecture constraints
3. Identify which existing providers/repositories this feature touches
4. Flag any naming conflicts with existing files

Output a brief plan:

```
Files to create: [list]
Files to modify: [list]
Providers needed: [list]
Pattern work needed: yes/no
```

**Stop and get user confirmation before proceeding to Phase 1.**

---

## Phase 1: Domain Design

**If PATTERN_INVOLVED = yes** → invoke `pa-prompt-pattern-design` first:
- Define the new `PromptPattern` entity data
- Validate template and examples
- Add to seed data in `PatternLocalDataSource`

**For all features:**
1. Define or update domain entities in `lib/features/[feature]/domain/entities/`
2. Define or update repository interfaces in `lib/features/[feature]/domain/repositories/`
3. Write the `UseCase` class skeleton in `lib/features/[feature]/domain/usecases/`

> Phase 1 produces interfaces only — no implementation yet.

Output: domain files ready for Phase 2.

---

## Phase 2: Implementation

Sub-skills loaded per layer:

### Data Layer — follow `pa-flutter-expert-skill`

- Implement repository at `lib/features/[feature]/data/repositories/`
- Implement local/remote datasource
- Register Riverpod providers in `lib/core/di/providers.dart`

### Domain Layer

- Implement UseCase body
- Wire repository via constructor injection (provider)

### Presentation Layer — follow `pa-flutter-expert-skill`

- Create Notifier in `lib/features/[feature]/presentation/notifiers/`
- Create Screen in `lib/features/[feature]/presentation/screens/`
- Extract sub-Widgets under `lib/features/[feature]/presentation/widgets/`
- Add route to `lib/core/router/app_router.dart` if a new screen is introduced

**After each file:** run `dart format` and `flutter analyze` — fix all issues before moving to the next file.

---

## Phase 3: Verification

Load `pa-unittest` and generate:
- Unit tests for each UseCase
- Widget tests for the main Screen

Then run the final checklist (see `EVAL.md`).
