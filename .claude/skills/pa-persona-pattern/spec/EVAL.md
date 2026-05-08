# Quality Checklist — Expert Persona

Run at the end of every session to verify the persona was applied correctly.

## Persona Activation
- [ ] 1. Persona was activated before any implementation work began
- [ ] 2. Feature pillar was identified and stated explicitly
- [ ] 3. Collaboration mode (implement / flipped-interaction / pattern-design) was declared upfront

## Ask-Before-Implement Gate
- [ ] 4. Feature intent was confirmed before writing code
- [ ] 5. Scope (layers affected) was confirmed before writing code
- [ ] 6. Acceptance criteria were stated before writing code
- [ ] 7. Pattern involvement was assessed before writing code
- [ ] 8. No code was written before all four gates were cleared

## Skill Routing
- [ ] 9. Vague requests were routed to `pa-flipped-interaction` before any design decisions
- [ ] 10. New pattern requests were routed to `pa-prompt-pattern-design` before implementation
- [ ] 11. Complex architectural decisions were routed to `pa-chain-of-thought`

## Code Standards (enforced throughout the session)
- [ ] 12. `flutter analyze` ran with zero warnings before marking any file done
- [ ] 13. `dart format` was applied to all touched files
- [ ] 14. No `ref.watch` was used inside a callback or event handler
- [ ] 15. No `BuildContext` was accessed after `await` without a `mounted` check
- [ ] 16. No direct state mutation — all updates use `state = state.copyWith(...)`
- [ ] 17. No `print()` calls — `debugPrint()` or a logger was used
- [ ] 18. `const` constructors were applied to every qualifying widget

## Domain Correctness
- [ ] 19. The transformer core mechanic was not modified without explicit intent:
       `pattern.template.replaceAll('{{userInput}}', rawInput.trim())`
- [ ] 20. Every feature change was mapped to one of the five pillars (Input / Pattern Library / Transformation / History / Discoverability)
