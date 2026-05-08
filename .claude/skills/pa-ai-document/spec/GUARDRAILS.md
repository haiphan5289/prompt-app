# Guardrails — pa-ai-document

## Anti-Hallucination Rules

1. **Verify before writing.** Apply `pa-anti-hallucination` in Step 0. Every file path, class name, provider name, and pattern ID must be confirmed in the live codebase before it appears in the document.
2. **No invented symbols.** Do not write a class or provider name that you have not confirmed exists via a file read or search. If a symbol cannot be confirmed, write `[unknown — verify]` instead.
3. **No invented file paths.** Every path in the Key Files table must resolve to a real file. Use `find lib/ -name "*.dart"` to verify.
4. **No fabricated API endpoints.** If no API contract exists or can be verified, mark the section `N/A`.
5. **No invented pattern IDs.** Pattern IDs must match entries in the seed data files under `lib/features/pattern_library/data/`.

## Prohibited Content

- Do not include revenue targets, OKR numbers, DAU goals, or any internal business metrics.
- Do not include competitor names or comparisons.
- Do not include raw user research data, PII, interview quotes, or survey results.
- Do not include release dates, roadmap commitments, or legal review notes.
- If such content appears in the Jira ticket or input, strip it (use `pa-semantic-filter` first when in doubt).

## Scope

- This skill writes one `.md` file. It does not modify any `.dart` files.
- Output path must be inside the repository (`lib/` or `docs/`). Do not write outside the repo root.

## Reference

See [pa-anti-hallucination](../pa-anti-hallucination/SKILL.md) for the full symbol-verification protocol.
