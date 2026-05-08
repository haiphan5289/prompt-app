# Input Schema — pa-ai-document

## Parameters

| Param | Type | Required | Description |
|---|---|---|---|
| `FEATURE_REQUEST` | string | yes (if no JIRA) | Free-text description of the feature to document |
| `JIRA` | string | no | Jira ticket key (e.g. `PA-42`) — fetched via Atlassian MCP if available |
| `FILES` | path(s) | no | Specific local file paths to include as context |
| `CONTEXT` | string | no | Additional business context not covered elsewhere |
| `PRIORITY` | enum | no | `High` / `Medium` / `Low` — controls documentation depth |

## Priority Depth

| Priority | Depth |
|---|---|
| `High` | All sections filled, mermaid data-flow diagram included |
| `Medium` | All sections filled, no diagram |
| `Low` | Summary + Business Rules + Key Files only |

## Input Format

```
FEATURE_REQUEST: <free-text description>
JIRA: <ticket key>
FILES: <path1>, <path2>
CONTEXT: <additional context>
PRIORITY: High | Medium | Low
```

## Minimal Input

```
FEATURE_REQUEST: Add a history screen that lists the last 50 transformed prompts
PRIORITY: Medium
```
