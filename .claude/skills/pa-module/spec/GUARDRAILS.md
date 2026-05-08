# Guardrails — Full Module Generator

## Hard Rules

- NEVER generate a module if the feature folder already exists — use `pa-scaffold` for individual files
- NEVER skip DI provider registration — all 4 providers must be added to `lib/core/di/providers.dart`
- NEVER skip route registration — screen must appear in `lib/core/router/app_router.dart`
- NEVER import `data/` from `presentation/` or vice versa
- NEVER put business logic in the Domain entity — entities are pure data structures
- NEVER use `Navigator.push` — use GoRouter `context.go()` in screens
- NEVER hardcode colors in generated screens — use `Theme.of(context)` tokens

## Prohibited Patterns in Generated Code

| Pattern | Why Prohibited | Correct Alternative |
|---|---|---|
| `StateNotifierProvider(...)` | Legacy Riverpod | `@riverpod` annotation |
| `ChangeNotifier` | Not Riverpod | `AsyncNotifier` |
| `Navigator.push(...)` | Bypasses GoRouter | `context.go(routePath)` |
| `print(...)` | Log spam | `debugPrint(...)` |
| Direct state mutation in Notifier | Riverpod won't detect | `ref.invalidateSelf()` after mutation |
| `Hive.box()` without prior `openBox` | Runtime error | Open box in `main.dart` first |
| Cross-layer imports | Breaks Clean Architecture | Follow domain → data → presentation dependency rule |
| Missing `const` constructors | Performance regression | Always add `const` to widget constructors |

## Anti-Hallucination

Before generating:
- Confirm `DISPLAY_NAME` matches the capitalization expected in class names (e.g., `PromptHistory` not `Prompthistory`)
- Do not invent additional entity fields beyond those listed in `ENTITY_FIELDS`
- The Hive `_boxName` must match exactly what will be passed to `Hive.openBox()` in `main.dart`
- All `part` directive filenames must match the generated file name exactly

## Layer Dependency Map

```
presentation/ → imports from domain/ only
data/         → imports from domain/ only
domain/       → imports nothing (pure Dart)
core/di/      → imports from all layers (wires them together)
```
