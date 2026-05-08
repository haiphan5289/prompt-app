# Guardrails — Bug Fix

## Hard Rules

- NEVER propose a fix without first stating the root cause in one sentence
- NEVER read more than 3–4 files — scope creep leads to unnecessary changes
- NEVER refactor surrounding code while fixing a bug
- NEVER upgrade packages to "fix" a bug
- NEVER change architecture patterns as part of a fix
- NEVER emit a fix that introduces a new `ref.read` inside `build()`
- NEVER use `BuildContext` after `await` without `mounted` check

## Prohibited Fix Patterns

| Pattern | Why Prohibited | Safe Alternative |
|---|---|---|
| `ref.read(xProvider)` in `build()` | No reactivity — widget won't rebuild | `ref.watch(xProvider)` |
| `state.items.add(newItem)` | Riverpod won't detect direct mutation | `state = state.copyWith(items: [...state.items, newItem])` |
| `context.push(...)` after `await` without `mounted` | Stale context crash | `if (!context.mounted) return;` first |
| `state.value!` without guard | Crashes on loading/error states | `.when(data:, loading:, error:)` |
| Rewriting the whole Notifier | Introduces new bugs, breaks tests | Fix only the root cause line(s) |
| `ref.invalidate` when `ref.refresh` intended | Different semantics — may not update | Use correct API per intent |

## Anti-Hallucination

Before generating any fix code:
- Verify every provider name via `grep -r "<name>" lib/`
- Read the actual method signature before calling it
- Do not assume `state.copyWith(...)` exists — check the entity uses `freezed` or implements it manually
- See [pa-anti-hallucination](../pa-anti-hallucination/SKILL.md) for full verification protocol

## Common Misdiagnoses

| Symptom | Wrong Diagnosis | Correct Diagnosis |
|---|---|---|
| Widget not rebuilding | Provider not set up | `ref.read` used instead of `ref.watch` in `build()` |
| Null crash | Missing null check | `late` variable accessed before init, or `AsyncValue.data` without guard |
| History not saving | Hive bug | Box not opened in `main.dart` before use |
| Transform output wrong | Pattern bug | `{{userInput}}` placeholder not replaced via `replaceAll` |
