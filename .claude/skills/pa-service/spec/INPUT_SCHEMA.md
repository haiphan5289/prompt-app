# Input Schema — pa-service

## Parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| `NAME` | PascalCase string | Yes | Base name for the service (e.g. `PatternSuggestion`) |
| `ENDPOINT` | URL string | Yes | Base URL or description of the API endpoint |
| `OPERATIONS` | List of Operation | Yes | One or more HTTP operations to implement |
| `FEATURE` | string | Yes | Feature folder name (e.g. `transformer`, `pattern_library`) |

## Operation Object

| Field | Type | Required | Description |
|---|---|---|---|
| `name` | camelCase string | Yes | Method name on the service (e.g. `suggestPattern`) |
| `method` | `GET` \| `POST` \| `PUT` \| `DELETE` | Yes | HTTP verb |
| `request` | Object schema | Yes | Fields in the request body (POST/PUT) or query params (GET) |
| `response` | Object schema | Yes | Fields returned in the response |

## Derived Values (auto-computed)

| Derived | Rule | Example |
|---|---|---|
| `name_snake` | PascalCase → snake_case | `PatternSuggestion` → `pattern_suggestion` |
| `nameCamel` | PascalCase → camelCase | `PatternSuggestion` → `patternSuggestion` |
| `operation_snake` | operation name → snake_case | `suggestPattern` → `suggest_pattern` |

## Example Input

```
NAME: PatternSuggestion
ENDPOINT: https://api.anthropic.com/v1/messages
FEATURE: transformer
OPERATIONS:
  - name: suggestPattern
    method: POST
    request:
      prompt: String
    response:
      patternId: String
      confidence: double
```

## Validation Rules

- `NAME` must be PascalCase, no spaces
- `FEATURE` must match an existing feature folder in `lib/features/`
- Each operation must have at least one request field and one response field
- Do not generate a Service if no HTTP calls are needed — use DataSource instead
