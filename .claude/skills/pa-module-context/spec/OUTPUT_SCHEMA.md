# Output Schema — pa-module-context

The skill outputs a structured in-conversation reference document. No files are created.

## Transformer Feature Map

```
lib/features/transformer/
├── presentation/
│   ├── screens/transformer_screen.dart
│   ├── notifiers/transformer_notifier.dart
│   └── widgets/
│       ├── prompt_input_field.dart
│       └── enhanced_prompt_card.dart
├── domain/
│   ├── entities/transformed_prompt.dart
│   ├── repositories/transformer_repository.dart
│   └── usecases/transform_prompt_use_case.dart
└── data/
    ├── repositories/transformer_repository_impl.dart
    └── datasources/ai_remote_data_source.dart
```

**Key providers:**
| Provider | Type | Returns |
|---|---|---|
| `transformerNotifierProvider` | `AsyncNotifier<TransformedPrompt?>` | Current transformation result |
| `transformPromptUseCaseProvider` | `Provider` | `TransformPromptUseCase` instance |

---

## Pattern Library Feature Map

```
lib/features/pattern_library/
├── presentation/
│   ├── screens/pattern_library_screen.dart
│   ├── notifiers/pattern_library_notifier.dart
│   └── widgets/
│       ├── pattern_card.dart
│       └── category_chip.dart
├── domain/
│   ├── entities/prompt_pattern.dart
│   ├── repositories/pattern_repository.dart
│   └── usecases/get_patterns_use_case.dart
└── data/
    ├── repositories/pattern_repository_impl.dart
    └── datasources/pattern_local_data_source.dart
```

**Key providers:**
| Provider | Type | Returns |
|---|---|---|
| `patternLibraryNotifierProvider` | `AsyncNotifier<List<PromptPattern>>` | All patterns |
| `selectedPatternProvider` | `StateProvider<String?>` | Currently selected pattern ID |

---

## History Feature Map

```
lib/features/history/
├── presentation/
│   ├── screens/history_screen.dart
│   ├── notifiers/history_notifier.dart
│   └── widgets/
│       └── history_entry_tile.dart
├── domain/
│   ├── entities/history_entry.dart
│   ├── repositories/history_repository.dart
│   └── usecases/
│       ├── get_history_use_case.dart
│       └── delete_history_entry_use_case.dart
└── data/
    ├── repositories/history_repository_impl.dart
    └── datasources/history_local_data_source.dart
```

**Key providers:**
| Provider | Type | Returns |
|---|---|---|
| `historyNotifierProvider` | `AsyncNotifier<List<HistoryEntry>>` | All saved history entries |

---

## Naming Convention Table

| Concept | Convention | Example |
|---|---|---|
| Screen | `<Name>Screen` | `TransformerScreen` |
| Notifier | `<Name>Notifier` | `TransformerNotifier` |
| Notifier provider | `<name>NotifierProvider` | `transformerNotifierProvider` |
| UseCase | `<Action><Entity>UseCase` | `TransformPromptUseCase` |
| Repository interface | `<Name>Repository` | `TransformerRepository` |
| Repository impl | `<Name>RepositoryImpl` | `TransformerRepositoryImpl` |
| DataSource | `<Name>LocalDataSource` / `<Name>RemoteDataSource` | `AiRemoteDataSource` |
| Entity | `<Name>` (noun) | `TransformedPrompt`, `HistoryEntry` |
| File name | `snake_case.dart` | `transform_prompt_use_case.dart` |
