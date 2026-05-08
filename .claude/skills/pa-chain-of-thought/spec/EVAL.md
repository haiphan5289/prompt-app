# Quality Checklist — Chain-of-Thought Analysis

Run this checklist before handing the analysis to the implementation phase.

## Problem Statement
- [ ] 1. Problem is restated in one paragraph using the analyst's own words (not copied verbatim from input)
- [ ] 2. Success criteria are stated explicitly (not implied)
- [ ] 3. All constraints (offline, performance, UX) are captured and acknowledged

## Architecture Impact
- [ ] 4. Every layer (Presentation / Domain / Data) is addressed — even if the answer is "none"
- [ ] 5. Class names used in the impact section match actual codebase names (or are marked `[NEW]`)
- [ ] 6. No layer is added unnecessarily (e.g., a UI-only change does not invent a new UseCase)

## Data Flow
- [ ] 7. The data flow covers every hop from user action to UI update
- [ ] 8. All providers mentioned are named with their exact provider variable name
- [ ] 9. The direction of data (input → processing → output → UI rebuild) is explicit
- [ ] 10. Async boundaries are identified (where `AsyncValue.guard` wraps)

## Edge Cases
- [ ] 11. Empty/whitespace input case is addressed
- [ ] 12. Unmatched `{{variable}}` in pattern template is addressed
- [ ] 13. Navigation-away-mid-action case is addressed
- [ ] 14. Race condition / double-tap case is addressed
- [ ] 15. At least one storage failure scenario is addressed
- [ ] 16. Each edge case has a concrete handling strategy (not just "handle it")

## Test Plan
- [ ] 17. The layer with the most business logic has the most tests
- [ ] 18. The most likely failure point has its own dedicated test
- [ ] 19. There is at least one happy-path test
- [ ] 20. Tests are listed in priority order (critical first)

## Implementation Roadmap
- [ ] 21. Domain entities and interfaces are listed first
- [ ] 22. Data layer comes before providers
- [ ] 23. Providers come before notifiers
- [ ] 24. UI is listed last
- [ ] 25. Each step has a complexity estimate (low / medium / high)

## Open Questions
- [ ] 26. Every ambiguity that would block implementation is listed
- [ ] 27. Each question states which phase it blocks
- [ ] 28. Open Questions section is the last section in the output
- [ ] 29. There are no rhetorical or already-answered questions in the list
- [ ] 30. If there are zero open questions, that is explicitly stated ("None — all requirements are clear")
