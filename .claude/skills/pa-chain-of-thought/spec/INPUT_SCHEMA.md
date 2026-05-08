# Input Schema — Chain-of-Thought Analysis

## Parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| `PROBLEM` | string | yes | One-sentence description of the design decision or complex task to analyse |
| `CONTEXT` | string | yes | Relevant background — which feature, what already exists, what triggered this analysis |
| `CONSTRAINT` | string | no | Hard constraints: offline-only, performance budget, platform limits, design system rules |
| `SCOPE_HINT` | string | no | Preliminary guess at which layers are affected (presentation / domain / data / all) |

## Accepted Trigger Phrases

The skill should activate when the request matches any of:

- Designing a new prompt transformation algorithm
- Deciding how pattern auto-selection should work
- Architecting a new feature that spans multiple layers
- Debugging a non-obvious issue where root cause is unclear
- Evaluating whether a feature belongs in domain, data, or presentation

## Example Invocation

```
PROBLEM: Pattern auto-selection — given raw user input, pick the best PromptPattern automatically.
CONTEXT: The transformer screen already has PatternSelectorRow where the user picks manually.
         We want to add an "Auto" option that suggests a pattern using keyword matching.
CONSTRAINT: Must work offline. No network calls allowed. Latency < 200 ms.
SCOPE_HINT: Domain (new UseCase) + Presentation (new UI affordance in PatternSelectorRow).
```
