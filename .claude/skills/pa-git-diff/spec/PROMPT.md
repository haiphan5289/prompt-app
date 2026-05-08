# Prompt — pa-git-diff

Step-by-step execution workflow for Git Diff Analysis.

## Step 1: Run Git Diff Commands

```bash
# Default: diff current branch against main
git diff main...HEAD --stat
git diff main...HEAD -- lib/ test/

# Changed files only
git diff main...HEAD --name-only

# Specific layer (if --focus flag provided)
git diff main...HEAD -- lib/features/transformer/
```

If `--full` flag is set, add the full diff output:
```bash
git diff main...HEAD -- lib/ test/
```

If `--since <SHA>` is provided, replace `main` with the SHA:
```bash
git diff <SHA>...HEAD --stat
```

## Step 2: Parse Changed Files by Layer

Categorise every changed file into one of:
- **Domain** — path matches `lib/features/*/domain/`
- **Data** — path matches `lib/features/*/data/`
- **Presentation** — path matches `lib/features/*/presentation/`
- **Core** — path matches `lib/core/`
- **Tests** — path matches `test/`

If `--focus <layer>` is provided, output only that layer's section and skip the others.

## Step 3: Produce Summary Block

Emit the Summary section (see OUTPUT_SCHEMA.md).

## Step 4: Produce Changes by Layer

For each layer with changes emit the relevant sub-list:
- Domain: new entities, modified entities, new UseCases, new repository interfaces
- Data: new datasources, modified repositories, new pattern seed IDs
- Presentation: new screens, new notifiers, modified widgets
- Core: router changes (yes/no), new providers in DI, theme changes (yes/no)
- Tests: new test count, modified test count

## Step 5: Run Review Checklist

Evaluate every checklist item in spec/EVAL.md and mark `[x]` or `[ ]` based on actual diff evidence.

## Step 6: Generate PR Description

Produce the PR Description block (see OUTPUT_SCHEMA.md) based on the diff content.

## Step 7: Suggested Next Steps

List any items flagged during the checklist: missing tests, open TODOs (`// TODO`), violations found, or files that need follow-up.
