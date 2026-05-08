# Input Schema — Bug Fix

## Required Fields

| Field | Type | Description |
|---|---|---|
| `BUG` | string | Short label for the bug category (e.g. "Widget not rebuilding") |
| `SYMPTOM` | string | What the user observes — exact behavior that is wrong |

## Optional Fields

| Field | Type | Description |
|---|---|---|
| `FILES` | list of paths | Specific files suspected to be involved |
| `ERROR` | string | Exact error message or stack trace if available |
| `STEPS_TO_REPRODUCE` | string | Steps that reliably trigger the bug |

## Bug Categories

Use one of these for the `BUG` field to trigger the correct diagnostic path:

| Category | When to Use |
|---|---|
| `Widget not rebuilding` | UI doesn't update after state changes |
| `ProviderScope / ref exception` | Runtime exception related to Riverpod |
| `Async error` | Unhandled Future, missing `await`, async gap |
| `Null safety crash` | `Null check operator used on a null value` |
| `Transformer wrong output` | Enhanced prompt is empty, malformed, or unsubstituted |
| `History not persisting` | History items not saved or not loading |
| `Layout overflow` | RenderFlex overflow, widget clipped |
| `Navigation error` | Wrong route, missing context, GoRouter exception |

## Example Input

```
BUG: Widget not rebuilding
SYMPTOM: Transform button tapped but result card stays empty; no loading indicator shown
FILES: lib/features/transformer/presentation/screens/home_screen.dart
ERROR: (none)
STEPS_TO_REPRODUCE: Enter text → select pattern → tap Transform → card remains empty
```
