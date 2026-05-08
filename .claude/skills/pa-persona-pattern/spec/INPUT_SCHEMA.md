# Input Schema — Expert Persona

## Parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| `REQUEST` | string | yes | The feature request or task description to classify and act on |
| `CONTEXT` | string | no | Additional background — which sprint, related tickets, prior decisions |

## When to Use This Skill

Use at the start of any session where:
- A non-trivial feature is being designed or implemented
- You want to enforce the ask-before-implement discipline for the entire session
- A new collaborator or agent needs to be onboarded to the Prompt App collaboration mode

## The Four Pre-Implementation Gates

Before any code is written, all four must be confirmed:

| Gate | Question |
|---|---|
| Feature intent | What user problem does this solve? |
| Scope | Which layers are affected? |
| Acceptance criteria | How do we know it is done? |
| Pattern involvement | Does this add or modify a prompt pattern? |

## Example Invocations

```
REQUEST: "Add a constraint-based pattern to the library"
```

```
REQUEST: "Improve the transformer screen layout"
CONTEXT: Design review flagged that PatternSelectorRow is hard to discover on small screens.
```

```
REQUEST: "Add history filtering by pattern category"
```
