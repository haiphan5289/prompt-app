# Guardrails — Prompt Pattern Design

## Anti-Hallucination Rules

1. **Verify entity classes exist** before referencing them. Check `lib/features/pattern/domain/entities/` for `PromptPattern`, `PatternCategory`, `PatternExample` before generating code that references them.

2. **Verify `PatternLocalDataSource` location** before inserting seed data — use `grep -r "PatternLocalDataSource" lib/` to find the actual file path.

3. **Verify category enum values** — do not invent new categories. Valid categories are only those defined in `PatternCategory` enum. Check with `grep -n "enum PatternCategory" lib/`.

4. **Do not reference `TransformUseCase` methods by name** until you have confirmed the method signature via file inspection.

5. **Do not assume template variable resolution is automatic** — every `{{variable}}` other than `{{userInput}}` requires explicit resolution logic in `TransformUseCase._applyPattern`.

## Prohibited Patterns

- Do NOT add a pattern with a vague `whenToUse` such as "use for any task" or "use when the user types something"
- Do NOT create a category that is not one of the 7 defined categories
- Do NOT add a pattern that has fewer than 3 worked examples
- Do NOT define a pattern where the template produces output that is shorter or simpler than the raw input
- Do NOT use template variables that are not in the variable registry defined in `INPUT_SCHEMA.md`
- Do NOT import Flutter packages in domain entity or repository interface files
- Do NOT add business logic inside the `PatternLocalDataSource` seed data — seeds are data only

## Valid Category Names (enum values)

```
PatternCategory.roleBased
PatternCategory.chainOfThought
PatternCategory.fewShot
PatternCategory.outputFormat
PatternCategory.constraintBased
PatternCategory.risen
PatternCategory.cato
```

## Evaluation Minimum Thresholds

A pattern MUST score ≥ 3/5 on ALL five criteria before being added to the production library:
- Improvement delta
- Generality
- Predictability
- Simplicity
- Composability

A pattern scoring 5/5 on 4 criteria but 2/5 on one criterion does NOT pass.

## Quality Gate

Never ship a pattern that:
- Has not been manually tested with at least 5 diverse raw inputs
- Has duplicate functionality to an existing pattern (use EVAL checklist item 24)
- Has an `id` that already exists in the seed data
