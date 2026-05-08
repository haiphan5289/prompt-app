# Eval — Prompt Pattern Design Quality Checklist

Run this checklist before adding any pattern to the production library.

## Pattern Structure (8 items)

- [ ] 1. Pattern has a unique `id` in `snake_case` format
- [ ] 2. `id` does not conflict with any existing pattern in `PatternLocalDataSource`
- [ ] 3. Template contains at least `{{userInput}}` placeholder
- [ ] 4. All `{{variables}}` in the template have defined resolution logic
- [ ] 5. `category` is one of the 7 valid enum values (not a custom category)
- [ ] 6. `description` is exactly one sentence describing what the pattern *adds*
- [ ] 7. `whenToUse` has 2–3 conditions that are specific (not "use for any task")
- [ ] 8. `name` is human-readable and title-cased

## Example Quality (5 items)

- [ ] 9. At least 3 `input → output` example pairs are provided
- [ ] 10. All example inputs are realistic raw user prompts (lowercase, unpolished)
- [ ] 11. Example outputs are fully expanded — not abbreviated or truncated
- [ ] 12. Example inputs span at least 2 different topic domains
- [ ] 13. Each example output is clearly better than the raw input prompt

## Template Quality (5 items)

- [ ] 14. Template tested manually with 5 different inputs — all produce better output than the raw prompt
- [ ] 15. Template does not duplicate the core addition of any existing pattern
- [ ] 16. Template is concise — no unnecessary filler or meta-commentary
- [ ] 17. Template is self-contained — no references to files or external context
- [ ] 18. Template preserves the full semantic meaning of `{{userInput}}`

## Evaluation Scores (5 items — must score ≥ 3/5 on all)

- [ ] 19. **Improvement delta** ≥ 3/5 — output is meaningfully better than raw prompt
- [ ] 20. **Generality** ≥ 3/5 — works across many topic domains without domain-specific tuning
- [ ] 21. **Predictability** ≥ 3/5 — consistently produces the same quality of improvement
- [ ] 22. **Simplicity** ≥ 3/5 — template is easy to understand and modify
- [ ] 23. **Composability** ≥ 3/5 — could be combined with another pattern without conflict

## Library Fit (2 items)

- [ ] 24. Pattern solves a problem not already covered by an existing pattern
- [ ] 25. Pattern added to `PatternLocalDataSource` seed data after passing all checks above
