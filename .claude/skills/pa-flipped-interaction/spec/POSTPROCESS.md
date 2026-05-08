# Post-Execution Steps — Flipped Interaction

## After Delivering Questions

1. **Wait.** Do not produce any output until the user answers.
2. Do not guess or assume answers — even partial answers require confirmation.

## After Receiving Answers

### Evaluate completeness

- Are all blocking ambiguities resolved?
- Is the layer (UI / domain / data) now clear?
- Is the acceptance criteria now clear?

If any ambiguity remains → ask a single follow-up question targeting only the remaining gap.

### Choose the next skill

| Situation after answers | Next skill |
|---|---|
| Requirements are fully clear, standard feature | `pa-feature-pipeline` |
| Requirements are clear but architecture is complex | `pa-chain-of-thought` first, then `pa-feature-pipeline` |
| A new prompt pattern must be designed | `pa-prompt-pattern-design` first, then `pa-feature-pipeline` |
| This is a bug, not a feature | `pa-bugfix-skill` |

### Summarise before handing off

Before switching to the implementation skill, output a one-paragraph summary:

```
Understood. [One sentence restatement of the feature].
Scope: [layer(s) affected].
Acceptance criteria: [how we know it is done].
Proceeding with [next skill name].
```

This summary becomes the `CONTEXT` input for the next skill.
