# Guardrails — Anti-Hallucination

## Hard Rules

- NEVER emit code that imports a package not confirmed in `pubspec.yaml`
- NEVER reference a Riverpod provider by name without grepping for it first
- NEVER assume a field exists on a model — read the actual file
- NEVER construct an import path without running `find lib/` to confirm the file exists
- NEVER emit `// TODO: implement` and silently proceed — flag the gap explicitly
- NEVER use `context.read<X>()` without confirming the provider type matches

## Prohibited Patterns

| Pattern | Why Prohibited | Safe Alternative |
|---|---|---|
| Inventing provider names | Provider won't exist at runtime | Grep `lib/` for `Provider` first |
| `ref.watch` inside callbacks | Causes runtime exceptions | Use `ref.read` in callbacks |
| `ref.read` inside `build()` | No reactivity — widget won't rebuild | Use `ref.watch` in `build()` |
| Inventing package APIs | Will compile but fail at runtime | Read the package's data source file |
| `AsyncValue.value!` without guard | Crashes on loading/error states | Use `.when(data:, loading:, error:)` |
| `BuildContext` after `await` without `mounted` | Stale context crash | Always check `if (!context.mounted) return;` |
| Assuming Hive box names | Box not opened = runtime error | Read the data source file for `_boxName` |
| Assuming model field names | `NoSuchMethodError` at runtime | Read the entity file before referencing fields |

## Verified Symbols Reference

These symbols are known to exist in Prompt App. Still verify before use — they may have changed.

### Packages (pubspec.yaml)
- `flutter_riverpod`
- `riverpod_annotation`
- `hive_flutter`
- `freezed_annotation`
- `go_router`

### Core Providers (lib/core/di/providers.dart)
- `patternLocalDataSourceProvider`
- `patternRepositoryProvider`
- `transformUseCaseProvider`
- `historyRepositoryProvider`
- `appRouterProvider`

### Domain Entities
- `PromptPattern` — fields: `id`, `name`, `description`, `category`, `template`, `useCases`, `examples`
- `ExamplePair` — fields: `input`, `output`
- `TransformResult` — fields: `originalPrompt`, `enhancedPrompt`, `appliedPattern`, `createdAt`

### Verification Commands
```bash
# All providers in the project
grep -r "Provider\b" lib/ --include="*.dart" -l

# All domain models
find lib/domain -name "*.dart" | head -20

# Specific class
grep -r "class TransformResult" lib/

# Method on a class
grep -A 10 "class PromptRepository" lib/domain/repositories/

# Package availability
grep "riverpod\|flutter_riverpod\|hooks_riverpod" pubspec.yaml
```
