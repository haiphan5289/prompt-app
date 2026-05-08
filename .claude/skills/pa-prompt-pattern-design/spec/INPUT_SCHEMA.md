# Input Schema — Prompt Pattern Design

## Primary Input: Pattern Definition

When adding a new pattern, provide:

| Field | Type | Required | Description |
|---|---|---|---|
| `id` | `String` (snake_case) | Yes | Unique identifier for the pattern |
| `name` | `String` | Yes | Human-readable display name |
| `category` | `Enum` (7 values) | Yes | One of the 7 pattern categories |
| `description` | `String` (1 sentence) | Yes | What this pattern adds to a prompt |
| `template` | `String` | Yes | Transformation template with `{{userInput}}` |
| `whenToUse` | `List<String>` (2–3 items) | Yes | Trigger conditions for pattern selection |
| `examples` | `List<{input, output}>` (min 3) | Yes | Worked input → output pairs |

## Category Enum Values

```
role_based
chain_of_thought
few_shot
output_format
constraint_based
risen
cato
```

## Action Input

| Action | Additional Required Fields |
|---|---|
| `ADD_PATTERN` | All fields above |
| `REFINE_PATTERN` | `id` of existing pattern + fields to update |
| `EVALUATE_PATTERN` | Pattern definition or existing `id` |
| `AUDIT_LIBRARY` | None (operates on full library) |

## Template Variable Registry

Variables that may appear in templates and must be resolvable:

| Variable | Default Value | Source |
|---|---|---|
| `{{userInput}}` | (required) | Raw user prompt |
| `{{detectedDomain}}` | Inferred from keywords | NLP inference |
| `{{inferredContext}}` | Inferred from intent | NLP inference |
| `{{audience}}` | `"general"` | User setting or default |
| `{{maxLength}}` | `"300 words"` | User setting or default |
| `{{role}}` | Derived from domain | NLP inference |
| `{{knowledgeLevel}}` | `"intermediate"` | User setting or default |
