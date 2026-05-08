# Quality Checklist — pa-alternative-approaches

## Coverage
- [ ] 1. Number of options matches COMPLEXITY level (Simple=3, Medium=3-4, Complex=4-5)
- [ ] 2. Every option has a code sketch (not just description)
- [ ] 3. Comparison matrix includes all 6 criteria
- [ ] 4. Decision framework covers all key constraint branches
- [ ] 5. Recommendation clearly states which option and why

## Package Validation
- [ ] 6. No option proposes a package not in `pubspec.yaml` without explicitly flagging it as a new dep
- [ ] 7. All Dart/Flutter APIs in code sketches are verified to exist
- [ ] 8. No invented class or method names in code examples

## Prompt App Fit
- [ ] 9. Each option evaluated against Clean Architecture constraints (domain purity, testability)
- [ ] 10. Offline-first requirement checked for each option if relevant
- [ ] 11. Riverpod compatibility confirmed for each option
- [ ] 12. Current codebase scale considered (MVP vs. enterprise)

## Architecture Questions (for architecture-level decisions)
- [ ] 13. Domain layer purity assessed — does the option add external deps to domain?
- [ ] 14. Testability assessed — can domain logic be unit tested without Flutter?
- [ ] 15. Offline support confirmed — transformer must work without internet
- [ ] 16. Complexity budget assessed — is this too complex for current Prompt App scale?

## Output Quality
- [ ] 17. Each option name is distinct and descriptive
- [ ] 18. Pros and cons are specific (not generic "easy to test" without explanation)
- [ ] 19. "Best when" condition for each option is concrete and actionable
- [ ] 20. Recommendation is a single clear choice, not "it depends"
