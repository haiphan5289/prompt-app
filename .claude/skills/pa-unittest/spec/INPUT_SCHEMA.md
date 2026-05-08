# Input Schema — pa-unittest

## Parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| `TARGET` | enum | yes | Type of class to test: `UseCase`, `Notifier`, `Repository`, `Screen`, `Widget` |
| `NAME` | string | yes | Exact class name (PascalCase) of the class to test |
| `FEATURE` | string | yes | Feature folder name (e.g. `transformer`, `history`, `pattern_library`) |
| `EXTRA` | string | no | Additional context: specific edge cases to cover, known dependencies, or tricky behaviors |

## Input Format

```
TARGET: <UseCase | Notifier | Repository | Screen | Widget>
NAME: <ClassName>
FEATURE: <feature-folder-name>
```

## Examples

```
# Generate UseCase test
TARGET: UseCase
NAME: TransformUseCase
FEATURE: transformer

# Generate Notifier test
TARGET: Notifier
NAME: TransformerNotifier
FEATURE: transformer

# Generate Screen widget test
TARGET: Screen
NAME: PromptInputScreen
FEATURE: transformer

# Generate Repository test with extra context
TARGET: Repository
NAME: HistoryRepository
FEATURE: history
EXTRA: Uses Hive box — mock the box, do not open real storage
```

## TARGET Value Mapping

| TARGET | Source Location | Test Location |
|---|---|---|
| `UseCase` | `lib/features/<f>/domain/usecases/` | `test/features/<f>/domain/usecases/` |
| `Notifier` | `lib/features/<f>/presentation/notifiers/` | `test/features/<f>/presentation/notifiers/` |
| `Repository` | `lib/features/<f>/data/repositories/` | `test/features/<f>/data/repositories/` |
| `Screen` | `lib/features/<f>/presentation/screens/` | `test/features/<f>/presentation/screens/` |
| `Widget` | `lib/features/<f>/presentation/widgets/` | `test/features/<f>/presentation/widgets/` |
