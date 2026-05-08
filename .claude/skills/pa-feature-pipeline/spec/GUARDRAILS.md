# Guardrails — Feature Pipeline

## Architecture Rules

- **Never** put business logic inside a Notifier — UseCases own all logic
- **Never** import Flutter packages in domain entity or repository interface files
- **Never** call a UseCase directly from a Widget — always go through the Notifier
- **Never** create a Repository without a corresponding abstract interface in `domain/`
- **Never** skip the Phase 0 scope confirmation — get explicit user approval before writing code

## Anti-Hallucination Rules

1. **Read existing files before modifying them.** Before adding a provider to `providers.dart`, read the current file to understand existing providers and naming conventions.

2. **Verify GoRouter route format** by reading `app_router.dart` before adding a new route — do not guess the routing style (named routes vs. path-based).

3. **Verify Hive adapter registration** before assuming Hive is used for a new entity. Check `main.dart` and existing adapters.

4. **Do not assume file paths** — verify the feature folder name matches the convention used by existing features before creating new files.

5. **Do not assume Notifier state type** — check the existing Notifier (if extending one) for its `AsyncValue<T>` type parameter before adding methods.

## Prohibited Patterns

- Do NOT use `ref.read` inside a `build` method — use `ref.watch`
- Do NOT nest Notifiers — use UseCase providers for cross-feature dependencies
- Do NOT create duplicate providers — search `providers.dart` for existing provider names before adding
- Do NOT add `print()` debugging statements — use `debugPrint` or a logging package
- Do NOT leave `TODO` comments — complete the implementation or open a ticket
- Do NOT use `setState` inside a Riverpod-managed widget — use Notifier state

## Phase Gate: Mandatory User Confirmation

After Phase 0, you MUST output the scope plan and wait for user confirmation. Do NOT proceed to Phase 1 without a "yes" or equivalent confirmation. This prevents building the wrong thing.
