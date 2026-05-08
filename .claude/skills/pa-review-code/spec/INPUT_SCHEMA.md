# Input Schema — pa-review-code

## Parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| `TARGET` | string | yes | Feature folder, file path, or "current branch changes" |
| `SCOPE` | enum | no | `full` (all 7 dimensions) or a specific dimension name. Defaults to `full` |
| `COMPARE` | string | no | Git ref to diff against. Defaults to `main` |

## Examples

```
# Review a feature folder
TARGET: lib/features/transformer/

# Review a single file
TARGET: lib/features/transformer/presentation/screens/prompt_input_screen.dart

# Review current branch against main (default)
TARGET: current branch

# Review only Riverpod patterns in a folder
TARGET: lib/features/history/
SCOPE: Riverpod
```

## Accepted Target Formats

- Absolute file path: `lib/features/transformer/domain/usecases/transform_use_case.dart`
- Feature folder: `lib/features/transformer/`
- Layer folder: `lib/features/transformer/presentation/`
- Branch diff: `current branch` or `HEAD` (diffs against main)
- Inline code paste (for quick checks)
