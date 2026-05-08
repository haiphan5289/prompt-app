# Input Schema — pa-git-diff

## Parameters

| Parameter | Type | Default | Description |
|---|---|---|---|
| `TARGET` | string | `main` | Branch name or commit SHA to diff against |
| `--full` | flag | off | Show full file diffs instead of summary only |
| `--focus` | enum | (all layers) | Limit analysis to one layer: `domain`, `data`, `presentation`, `patterns` |
| `--since` | string | (none) | Diff from a specific commit SHA instead of branch tip |

## Input Format

```
TARGET: <branch or commit SHA to diff against, default: main>
FLAGS:
  --full       Show full file diffs (not just summary)
  --focus      <domain|data|presentation|patterns> limit to one layer
  --since      <commit SHA> diff from specific commit
```

## Examples

```
TARGET: main
```

```
TARGET: main
FLAGS:
  --focus presentation
```

```
TARGET: origin/release/1.2
FLAGS:
  --full
  --since abc1234
```
