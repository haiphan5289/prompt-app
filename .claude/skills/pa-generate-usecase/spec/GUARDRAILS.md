# Guardrails — Generate UseCase

## Anti-Hallucination Rules

1. **Verify the repository method exists** before Step 2. Run:
   ```bash
   grep -n "{{methodName}}" lib/features/{{feature}}/domain/repositories/{{name}}_repository.dart
   ```
   If not found, add it to both interface and implementation first.

2. **Verify the repository provider name** in `providers.dart` before referencing it:
   ```bash
   grep -n "RepositoryProvider" lib/core/di/providers.dart
   ```

3. **Verify the Notifier file path** before modifying it:
   ```bash
   find lib/features/{{feature}}/presentation/notifiers/ -name "*.dart"
   ```

4. **Check for existing UseCase with the same name** before creating a new file:
   ```bash
   find lib/features/{{feature}}/domain/usecases/ -name "*.dart"
   ```

5. **Check for duplicate provider names** before adding to `providers.dart`:
   ```bash
   grep -n "{{useCaseCamel}}UseCase" lib/core/di/providers.dart
   ```

## Prohibited Patterns

- Do NOT add business logic inside the UseCase — it must be a thin delegate to the repository
- Do NOT use `ref.watch` inside a Notifier method body — use `ref.read` for one-shot actions
- Do NOT `ref.read` a Notifier provider from inside another Notifier — use the UseCase provider directly
- Do NOT use stream `.listen()` inside Notifier methods — use `await` only
- Do NOT add multiple public methods to a UseCase — one UseCase, one `execute` method
- Do NOT import Flutter packages in the UseCase file — domain layer is pure Dart

## Naming Conventions

| Concept | Convention | Example |
|---|---|---|
| UseCase class | `PascalCaseUseCase` | `DeleteHistoryUseCase` |
| UseCase file | `snake_case_use_case.dart` | `delete_history_use_case.dart` |
| Provider | `camelCaseUseCaseProvider` | `deleteHistoryUseCaseProvider` |
| Notifier method | `camelCase` matching USE_CASE intent | `delete` or `deleteEntry` |
