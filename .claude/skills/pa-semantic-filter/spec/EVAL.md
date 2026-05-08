# Eval — pa-semantic-filter

Quality checklist for filtered output. Verify every item before passing the spec downstream.

## Stripping Correctness

- [ ] 1. No revenue targets, conversion rates, or MRR/ARR figures appear in the output
- [ ] 2. No competitor names or comparative claims appear in the output
- [ ] 3. No internal OKR numbers, DAU targets, or retention goals appear in the output
- [ ] 4. No raw user research quotes or PII appear in the output
- [ ] 5. No release dates, launch quarters, or roadmap milestones appear in the output
- [ ] 6. No legal review references or compliance notes appear in the output
- [ ] 7. No personnel names, team names, or approval attributions appear in the output

## Preservation Correctness

- [ ] 8. All user stories from the original are present (none accidentally stripped)
- [ ] 9. All functional requirements are preserved verbatim (not paraphrased)
- [ ] 10. All UI/UX specifications are present
- [ ] 11. All acceptance criteria are present and in checkbox format
- [ ] 12. All API contracts and data model definitions are present
- [ ] 13. All error handling rules are present
- [ ] 14. All performance and platform constraints are present
- [ ] 15. All prompt pattern requirements are present (if applicable)

## Output Format

- [ ] 16. Output uses the standard Filtered Feature Spec template
- [ ] 17. Each populated section has at least one bullet or item
- [ ] 18. Empty sections are omitted (not printed with no content)
- [ ] 19. "Removed" line at the bottom names the stripped categories without quoting the stripped content
- [ ] 20. "Safe to pass to" line lists at least one downstream skill

## Completeness

- [ ] 21. Feature name in the header reflects the actual feature (not a placeholder)
- [ ] 22. No placeholder text (e.g. `[criterion 1]`) remains unfilled when source content existed
- [ ] 23. Prompt Pattern Requirements section is present when the input mentions a pattern change
