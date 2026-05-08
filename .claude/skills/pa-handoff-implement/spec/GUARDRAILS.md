# Guardrails — Handoff Implement

## Anti-Hallucination Rules

1. **Verify every file path before referencing it.** Do not assume a widget, screen, or datasource exists — confirm via `pa-anti-hallucination` or by reading the file tree.
2. **Never invent class names.** Use verified Prompt App symbols:
   - Entities: `PromptPattern`, `TransformResult`
   - Screens: `PromptInputScreen`, `PatternLibraryScreen`, `HistoryScreen`
   - Key widgets: `PromptTextField`, `PatternSelectorRow`, `PromptResultCard`, `CopyButton`, `PatternCard`, `PatternPreviewSheet`, `CategoryFilterRow`, `HistoryEntryCard`
   - Providers: `transformerNotifierProvider`, `patternSelectionNotifierProvider`, `transformUseCaseProvider`, `patternRepositoryProvider`, `historyRepositoryProvider`, `patternListNotifierProvider`, `categoryFilterProvider`, `historyNotifierProvider`
3. **Never assume a handoff is complete.** Always run Phase 1 extraction. Specs are often missing edge cases.
4. **Do not add fields to entities without checking if they break existing code.** Adding a required field to `TransformResult` or `PromptPattern` without updating all construction sites will cause compile errors.

## Architecture Constraints

- Never access a Repository from a Widget — always go through a Notifier.
- Never put business logic in a Notifier — delegate to a UseCase.
- Never skip DI registration when adding a provider.
- Never modify `lib/core/router/` unless a new Screen was added.

## Implementation Constraints

- Scope `UI only` → do not touch domain or data layers.
- Scope `domain only` → do not touch presentation layer.
- Scope `full-stack` → all layers permitted, but only what the spec requires.

## Prohibited Patterns

- Do not implement features that are not in the handoff spec (no scope creep).
- Do not refactor unrelated code while implementing a handoff (separate concern).
- Do not use `setState` — this is a Riverpod app.
- Do not call `dart format` manually on files you have not changed.
- Do not leave `TODO` comments in delivered code — resolve them or raise as Open Questions.
