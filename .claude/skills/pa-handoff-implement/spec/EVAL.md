# Quality Checklist — Handoff Implement

Run after Phase 4 before marking the feature done.

## Phase 1: Spec Understanding
- [ ] 1. All five extraction questions were answered (screens, interactions, data, side effects, patterns)
- [ ] 2. Ambiguous requirements were surfaced and resolved via `pa-flipped-interaction` before implementation
- [ ] 3. Every stated requirement from the handoff is captured (nothing silently dropped)

## Phase 2: Architecture Mapping
- [ ] 4. A spec-to-layer mapping table was produced before writing code
- [ ] 5. No layer was added that is not required by the spec (no premature abstraction)
- [ ] 6. New prompt patterns were routed through `pa-prompt-pattern-design` before implementation

## Phase 3: Implementation Order
- [ ] 7. Domain entities and interfaces were implemented before data layer
- [ ] 8. Data layer was implemented before providers
- [ ] 9. Providers were registered before the notifier used them
- [ ] 10. UI was implemented last
- [ ] 11. `dart format` was run after each file
- [ ] 12. `flutter analyze` showed zero warnings after each file

## Phase 4: Spec Validation
- [ ] 13. Every requirement from the handoff has a row in the Spec Validation Report
- [ ] 14. All requirements show `yes` — no requirement is unimplemented without explanation
- [ ] 15. All edge cases mentioned in the handoff are handled
- [ ] 16. All stated interactions are implemented and testable

## Tests
- [ ] 17. At least one test was written for the main new behavior
- [ ] 18. The test covers the happy path
- [ ] 19. If a new UseCase was added, it has a dedicated unit test
- [ ] 20. Existing tests still pass

## Code Standards
- [ ] 21. No `ref.watch` inside callbacks
- [ ] 22. No `BuildContext` accessed after `await` without `mounted` check
- [ ] 23. State is only updated via `state = state.copyWith(...)`
- [ ] 24. `const` constructors on all qualifying widgets
- [ ] 25. No `print()` calls in any changed file
