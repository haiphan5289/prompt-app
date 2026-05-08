# Guardrails — pa-semantic-filter

## Core Rules

1. **Preserve technical requirements exactly.** Do not paraphrase, summarise, or reword functional requirements, user stories, or acceptance criteria. Copy them as written.
2. **Strip silently.** Do not reproduce stripped content anywhere — not in the output, not in the "Removed" summary, not in quotes. Only name the category that was removed.
3. **When in doubt, keep.** If a sentence is ambiguous (could be technical or sensitive), default to keeping it. It is safer to pass a slightly over-inclusive spec downstream than to accidentally drop a requirement.
4. **Do not infer intent.** Do not add requirements, assumptions, or interpretations that were not present in the input. The filter only removes; it does not add.

## Prohibited Patterns

- Do not output any figure prefixed with `$`, `%`, or a metric label (`DAU`, `MAU`, `MRR`, `ARR`, `LTV`, `ARPU`).
- Do not output any date formatted as quarter (`Q1`, `Q2`, `Q3`, `Q4`) or `[month] [year]` when used as a release target.
- Do not output any sentence containing "better than", "compared to", "unlike", or "[competitor name]".
- Do not output any name that follows "approved by", "owned by", or "per [name]".

## Scope

This skill produces terminal output only. It does not write files, call external APIs, or read the codebase.
