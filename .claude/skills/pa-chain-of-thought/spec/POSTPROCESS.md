# Post-Execution Steps — Chain-of-Thought Analysis

After completing the six-phase analysis, perform these steps before handing off to implementation.

## Step 1: Open Questions Resolution

- If Open Questions exist → **stop here**. Present the questions to the user and wait for answers before proceeding.
- If Open Questions are empty → proceed to Step 2.

## Step 2: Checklist Verification

Run through [EVAL.md](EVAL.md). Every checkbox must pass. If any item fails, revise the relevant section of the analysis before proceeding.

## Step 3: Skill Handoff

Choose the next skill based on the analysis outcome:

| Situation | Next skill |
|---|---|
| Analysis is complete, requirements are clear | `pa-feature-pipeline` |
| Request is still vague after analysis | `pa-flipped-interaction` |
| Analysis reveals a new prompt pattern is needed | `pa-prompt-pattern-design` first, then `pa-feature-pipeline` |
| Analysis reveals the problem is a bug | `pa-bugfix-skill` |

## Step 4: Implementation Order Verification

Before handing off to `pa-feature-pipeline`, confirm the Implementation Roadmap follows bottom-up order:

1. Domain layer (entities, interfaces, UseCases) — no dependencies
2. Data layer (repository impls, datasources)
3. DI registration (`lib/core/di/providers.dart`)
4. Notifiers
5. UI (screens, widgets)

If the roadmap is out of order, correct it before handoff.

## Step 5: Archive the Analysis

Paste the final analysis into a comment or task description so it is available during implementation review. The analysis document is the contract between design and implementation.
