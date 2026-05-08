# Guardrails — Flutter Expert

## Hard Rules

- NEVER import `data/` from `presentation/` — Clean Architecture boundary is absolute
- NEVER import `presentation/` from `data/` — same rule in reverse
- NEVER put business logic in Domain entities — entities are pure data
- NEVER write a provider without `@riverpod` annotation — no manual `Provider()` calls
- NEVER use `Navigator.push` — use GoRouter `context.go()` / `context.push()`
- NEVER use `print()` — use `debugPrint()` or a logger package
- NEVER hardcode colors or font sizes — use `Theme.of(context)` tokens
- NEVER use `StatefulWidget` for business logic — use `Notifier` + `ConsumerWidget`
- NEVER mutate state directly — always `state = state.copyWith(...)`
- NEVER use `BuildContext` after `await` without `mounted` check

## Prohibited Patterns

| Pattern | Why Prohibited | Safe Alternative |
|---|---|---|
| `StatefulWidget` for business logic | Bypass Riverpod, untestable | `Notifier` + `ConsumerWidget` |
| `setState` beyond local UI state | Bypasses reactive state management | `state = state.copyWith(...)` |
| `ref.read` in `build()` | No reactivity | `ref.watch` in `build()` |
| Direct state mutation (`state.list.add(x)`) | Riverpod won't detect | `state = state.copyWith(list: [...state.list, x])` |
| `BuildContext` after `await` without `mounted` | Stale context crash | `if (!context.mounted) return;` |
| Hardcoded colors (`Color(0xFF...)`) | Breaks theming | `Theme.of(context).colorScheme.primary` |
| `Navigator.push` | Bypasses GoRouter | `context.go('/route')` |
| `print()` in production code | Log spam, not filterable | `debugPrint()` or logger |

## Verified Architecture Symbols

### Domain Entities
```dart
class PromptPattern {
  final String id;
  final String name;
  final String description;
  final String category;       // 'role_based', 'chain_of_thought', etc.
  final String template;       // contains {{userInput}} placeholder
  final List<String> useCases;
  final List<ExamplePair> examples;
}

class ExamplePair {
  final String input;
  final String output;
}

class TransformResult {
  final String originalPrompt;
  final String enhancedPrompt;
  final PromptPattern appliedPattern;
  final DateTime createdAt;
}
```

### Core Providers (lib/core/di/providers.dart)
- `patternLocalDataSourceProvider`
- `patternRepositoryProvider`
- `transformUseCaseProvider`
- `historyRepositoryProvider`
- `appRouterProvider`

### Routes
- `/home` → `HomeScreen`
- `/patterns` → `PatternLibraryScreen`
- `/history` → `HistoryScreen`

### Hive Boxes
- `'history'` → `Box<TransformResult>`

### Template Placeholder
- Always: `{{userInput}}` (double braces, exact casing)
- Never: `{userInput}`, `%s`, `$userInput`
