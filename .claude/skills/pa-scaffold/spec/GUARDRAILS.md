# Guardrails — Scaffold

## Hard Rules

- NEVER overwrite an existing file — verify with `find lib/` first
- NEVER scaffold a file in the wrong layer (e.g., entity in `presentation/`, screen in `domain/`)
- NEVER create a provider without `@riverpod` annotation
- NEVER hardcode the route path without adding `static const routePath` to the Screen class
- NEVER skip DI registration when scaffolding UseCase, Repository, or DataSource

## Prohibited Patterns in Scaffolded Code

| Pattern | Why Prohibited | Correct Alternative |
|---|---|---|
| `StateNotifierProvider(...)` | Legacy Riverpod API | `@riverpod` annotation |
| `ChangeNotifier` | Not Riverpod | `Notifier` or `AsyncNotifier` |
| `Navigator.push(...)` | Bypasses GoRouter | `context.go(routePath)` |
| `print(...)` | Log spam | `debugPrint(...)` |
| Hardcoded colors | Breaks theming | `Theme.of(context).colorScheme.*` |
| `StatefulWidget` for new business-logic widgets | Untestable, bypasses Riverpod | `ConsumerWidget` + `Notifier` |
| Missing `const` on widget constructor | Performance regression | Always add `const` |
| `part` directive with wrong filename | Build fails | Match `{{name_snake}}.g.dart` exactly |

## Naming Conventions (must follow exactly)

| Artifact | Convention | Good | Bad |
|---|---|---|---|
| Dart file | snake_case | `pattern_selector_screen.dart` | `PatternSelectorScreen.dart` |
| Class | PascalCase | `PatternSelectorScreen` | `pattern_selector_screen` |
| Provider function | camelCase + Provider suffix | `patternSelectorProvider` | `PatternSelectorProvider` |
| Route path | kebab-case | `/pattern-selector` | `/pattern_selector`, `/PatternSelector` |
| Hive box name | snake_case string literal | `'prompt_history'` | `'PromptHistory'`, `'promptHistory'` |

## Anti-Hallucination

Before scaffolding:
- Verify `FEATURE` folder exists: `find lib/features/<feature> -maxdepth 0`
- Verify no file at target path: `find lib/ -name "<name_snake>_<type>.dart"`
- Do not invent entity field names — scaffold with `// TODO: add fields` placeholder
