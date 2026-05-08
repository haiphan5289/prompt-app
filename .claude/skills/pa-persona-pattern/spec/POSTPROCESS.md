# Post-Execution Steps — Expert Persona

## End of Session Checklist

After every session where this persona was active:

1. Run `flutter analyze` — confirm zero warnings.
2. Run `dart format` on all touched files.
3. Run the quality checklist in [EVAL.md](EVAL.md) — all 20 items must pass.
4. Confirm at least one test was written for the new behaviour.

## Skill Handoff Summary

If handing off to another agent or session, produce a handoff summary:

```
## Session Summary
Feature: [name]
Pillar: [pillar]
Status: [in progress | complete | blocked]

## What was implemented
- [file path] — [what changed]
- ...

## What remains
- [outstanding task]
- ...

## Open questions
- [any unresolved ambiguity]
```

## Persona Deactivation

The persona stays active for the duration of the session. It does not need to be explicitly deactivated. The next invocation of any skill (e.g., `pa-feature-pipeline`) continues within the same standards.
