# Guardrails — Chain-of-Thought Analysis

## Anti-Hallucination Rules

1. **Verify class names before using them.** Every class, provider, or file path mentioned in the analysis must exist in the codebase OR be explicitly marked `[NEW]`. Use `pa-anti-hallucination` to verify symbols if unsure.
2. **Never invent providers.** Only reference providers listed in `lib/core/di/providers.dart` or clearly mark them as `[NEW — to be created]`.
3. **Never assume a file exists.** If you reference `pattern_local_data_source.dart`, confirm it exists before including it in the data flow.
4. **Do not mix up entity names.** `PromptPattern` and `TransformResult` are the two core domain entities. Do not rename or conflate them.

## Prohibited Patterns

- Do not write any implementation code during the analysis phase. The output is a plan, not code.
- Do not skip phases because the problem seems simple. Run all six phases even for "easy" tasks.
- Do not omit the Open Questions section. If there are no questions, write "None — all requirements are clear."
- Do not use vague handling strategies in the Edge Cases section (e.g., "handle gracefully"). Every edge case must have a specific technical response.
- Do not recommend adding network calls for features constrained to offline operation.
- Do not recommend skipping `dart format` or `flutter analyze` steps in the Implementation Roadmap.

## Architecture Constraints (Non-Negotiable)

- The data flow must always follow: Widget → Notifier → UseCase → Repository → DataSource.
- Never suggest accessing a Repository directly from a Widget.
- Never suggest using `ref.watch` inside a callback or event handler.
- Never suggest accessing `BuildContext` after an `await` without a `mounted` check.
- State must always be updated via `state = state.copyWith(...)` — never direct mutation.

## Verified Symbols (Prompt App Core)

The following symbols are confirmed to exist. Do not rename them:

```
Entities:         PromptPattern, TransformResult
Providers:        transformerNotifierProvider, patternSelectionNotifierProvider,
                  transformUseCaseProvider, patternRepositoryProvider,
                  historyRepositoryProvider, patternListNotifierProvider,
                  categoryFilterProvider, historyNotifierProvider
Notifiers:        TransformerNotifier, PatternListNotifier, HistoryNotifier
UseCases:         TransformUseCase, GetPatternsUseCase, GetHistoryUseCase,
                  DeleteHistoryItemUseCase
Repositories:     PatternRepository, HistoryRepository
DataSources:      PatternLocalDataSource, HistoryLocalDataSource
Screens:          PromptInputScreen, PatternLibraryScreen, HistoryScreen
Key Widgets:      PromptTextField, PatternSelectorRow, PromptResultCard, CopyButton,
                  PatternCard, PatternPreviewSheet, CategoryFilterRow, HistoryEntryCard
```
