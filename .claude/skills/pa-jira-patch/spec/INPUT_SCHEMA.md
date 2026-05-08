# Input Schema — pa-jira-patch

## Parameters

| Param | Type | Required | Description |
|---|---|---|---|
| `JIRA` | string | yes | Jira ticket key (e.g. `PA-42`) |
| `MODE` | enum | yes | `read` — fetch ticket before implementing; `update` — patch ticket after implementing |
| `PR_URL` | string | update only | GitHub PR URL to attach to the ticket |
| `STATUS` | enum | update only | New ticket status: `In Review` or `Done` |
| `NOTES` | string | update only | Implementation summary to add as a comment |

## Input Formats

### Read mode

```
JIRA: <ticket key>
MODE: read
```

### Update mode

```
JIRA: <ticket key>
MODE: update
PR_URL: <GitHub PR URL>
STATUS: <In Review | Done>
NOTES: <implementation summary>
```

## Ticket Label Convention for Prompt App

| Label | Meaning |
|---|---|
| `transformer` | Affects the core transform engine |
| `pattern-library` | Adds or modifies prompt patterns |
| `history` | History feature changes |
| `flutter` | Pure Flutter/UI work |
| `architecture` | Structural/refactor changes |
| `bug` | Bug fix |
| `dx` | Developer experience improvement |
