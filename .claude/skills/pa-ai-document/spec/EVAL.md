# Eval — pa-ai-document

Quality checklist for generated feature documents. Review each item before marking the skill complete.

## Anti-Hallucination

- [ ] 1. Every file path listed in "Key Files & Symbols" was verified to exist in the live codebase
- [ ] 2. Every class/symbol name was confirmed via codebase search (not guessed from conventions)
- [ ] 3. Every provider name matches an actual `@riverpod`-annotated provider in the codebase
- [ ] 4. No placeholder text (e.g. `[ClassName]`, `[what it does]`) remains in the final document

## Content Completeness

- [ ] 5. Summary is 1–2 sentences and accurately describes what the feature does
- [ ] 6. Business Rules section contains at least 2 concrete, testable rules
- [ ] 7. Architecture Overview names actual notifier, use case, and repository classes
- [ ] 8. Data flow line is accurate and matches code structure
- [ ] 9. Key Files table has at least one entry per affected layer
- [ ] 10. Edge Cases section covers at least: empty input, network failure
- [ ] 11. Test Coverage section lists actual test file paths (not generic placeholders)
- [ ] 12. Open Questions is filled or explicitly marked "None"
- [ ] 13. Sources section lists all files that were read during generation

## Priority Adherence

- [ ] 14. `High` priority: mermaid flowchart is present and syntactically valid
- [ ] 15. `Medium` priority: all sections are filled (no "N/A" on required sections)
- [ ] 16. `Low` priority: only Summary, Business Rules, Key Files are populated

## Prompt Pattern Section (if applicable)

- [ ] 17. Pattern ID matches an ID in the seed data
- [ ] 18. Template snippet includes `{{userInput}}` placeholder
- [ ] 19. Transformation description shows a concrete input→output example

## API Contracts (if applicable)

- [ ] 20. Endpoint URL is real (not fabricated)
- [ ] 21. Request/response fields match the actual model class

## Document Quality

- [ ] 22. Output path is correct (co-located with feature or in docs/ for cross-cutting)
- [ ] 23. Document is written to the file system (not just printed to terminal)
- [ ] 24. No sensitive business data included (revenue targets, OKRs, competitor names)
- [ ] 25. Markdown renders correctly (no broken table formatting, unclosed code fences)
