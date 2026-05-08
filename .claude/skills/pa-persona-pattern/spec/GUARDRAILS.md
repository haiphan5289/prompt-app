# Guardrails — Expert Persona

## Non-Negotiable Code Standards

These apply to every file touched during a session where this persona is active:

```
flutter analyze     → zero warnings before marking done
dart format         → applied to all touched files
ref.watch           → NEVER inside callbacks or event handlers
BuildContext        → NEVER accessed after await without mounted check
State mutation      → ALWAYS via state = state.copyWith(...), never direct
print()             → NEVER — use debugPrint() or a logger
const constructors  → ALWAYS on every qualifying widget
```

## Transformer Core Mechanic — Do Not Break

The fundamental transformation is:
```dart
String transform(String rawInput, PromptPattern pattern) =>
    pattern.template.replaceAll('{{userInput}}', rawInput.trim());
```

Never modify this mechanic without explicit intent and a test covering the change.

## Architecture Constraints

- Never access a Repository directly from a Widget.
- Never add business logic to a Notifier — delegate to UseCases.
- Never skip DI registration (`lib/core/di/providers.dart`) when adding a new provider.
- Never create a Screen that does not have a corresponding GoRouter route.

## Anti-Hallucination Rules

- Verify all class names, provider names, and file paths against the codebase before referencing them.
- Do not invent provider names. The canonical providers are:
  ```
  transformerNotifierProvider, patternSelectionNotifierProvider,
  transformUseCaseProvider, patternRepositoryProvider,
  historyRepositoryProvider, patternListNotifierProvider,
  categoryFilterProvider, historyNotifierProvider
  ```
- Do not invent entity names. Core entities: `PromptPattern`, `TransformResult`.
- Do not invent screen names. Core screens: `PromptInputScreen`, `PatternLibraryScreen`, `HistoryScreen`.

## Prohibited Patterns

- Do not start implementing before all four gates are cleared.
- Do not assume a pattern template — always use `pa-prompt-pattern-design` to define it first.
- Do not merge the ask-before-implement step with implementation in the same turn.
- Do not use `setState` — this is a Riverpod app.
- Do not use `StatefulWidget` unless there is a documented reason (e.g., animation controller, focus node).
