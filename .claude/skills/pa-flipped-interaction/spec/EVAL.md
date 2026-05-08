# Quality Checklist — Flipped Interaction

Run before delivering questions to the user.

## Question Count
- [ ] 1. HIGH priority: 1–2 questions (no more)
- [ ] 2. MEDIUM priority: 3–4 questions (no more)
- [ ] 3. LOW / exploratory priority: 4–5 questions (no more)
- [ ] 4. No questions are duplicated or overlapping in scope

## Question Quality
- [ ] 5. Every question is one sentence, specific and answerable
- [ ] 6. No question is rhetorical or already answerable from the context provided
- [ ] 7. The most architecture-critical question is listed first
- [ ] 8. No question asks the user to make a decision that Claude should make (e.g., "Which file should I edit?")
- [ ] 9. Questions do not assume a specific implementation approach

## Coverage
- [ ] 10. The layer question is addressed (UI-only vs full-stack vs domain-only)
- [ ] 11. The persistence question is addressed if data storage could be involved
- [ ] 12. The UX behavior question is addressed if an ambiguous interaction exists
- [ ] 13. The offline/network question is addressed if a data source decision is blocked by it
- [ ] 14. If a new prompt pattern is involved, template + example questions are included

## Format
- [ ] 15. Opening line is exactly: `Before I implement this, I have [N] quick questions:`
- [ ] 16. Questions are numbered (1. 2. 3.)
- [ ] 17. No preamble before the opening line
- [ ] 18. No explanation of why each question is being asked
- [ ] 19. No implementation code in the output
- [ ] 20. No preliminary design decisions or assumptions stated
