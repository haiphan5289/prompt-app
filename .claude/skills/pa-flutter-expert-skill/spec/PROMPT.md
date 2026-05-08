# Execution Workflow — Flutter Expert

## Step 1: Identify the Layer

Determine which Clean Architecture layer the task touches:

| Layer | Responsibility | Location |
|---|---|---|
| Presentation | Screens, Widgets, Notifiers | `lib/features/<feature>/presentation/` |
| Domain | Entities, UseCases, Repository interfaces | `lib/features/<feature>/domain/` |
| Data | Repository impls, DataSources, Models | `lib/features/<feature>/data/` |
| Core | DI providers, Router, Theme | `lib/core/` |
| Shared | Reusable widgets, utilities | `lib/shared/` |

**Layer dependency rule:**
- Presentation → Domain only
- Domain → nothing (zero external dependencies)
- Data → Domain only
- Never: Presentation → Data, Data → Presentation

## Step 2: Run Anti-Hallucination Checks

Before writing any code, verify every symbol. See [pa-anti-hallucination](../pa-anti-hallucination/SKILL.md).

```bash
grep -r "class <EntityName>" lib/
grep -r "<providerName>Provider" lib/
find lib/ -name "<filename>.dart"
```

## Step 3: Choose the Correct Riverpod Pattern

| Need | Pattern | Example |
|---|---|---|
| Async operation (network, storage) | `AsyncNotifier` | `TransformerNotifier` |
| Sync state | `Notifier` | `PatternSelectionNotifier` |
| Read-only derived state | `@riverpod` function | `patternListProvider` |

Always use code generation (`@riverpod` annotation + `build_runner`). Never write providers manually.

## Step 4: Choose the Correct Widget Type

| Need | Widget Type |
|---|---|
| Read state, no local state | `ConsumerWidget` |
| Read state + local UI state (TextEditingController, animation) | `ConsumerStatefulWidget` |
| Pure layout, no providers | `StatelessWidget` |

Never use `StatefulWidget` for business logic. Never use `setState` beyond local UI ephemeral state.

## Step 5: Write the Code

Follow these rules strictly:

**Notifier (async):**
```dart
@riverpod
class MyNotifier extends _$MyNotifier {
  @override
  FutureOr<ResultType?> build() => null;

  Future<void> doWork() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => ref.read(useCaseProvider).execute());
  }
}
```

**ConsumerWidget:**
```dart
@override
Widget build(BuildContext context, WidgetRef ref) {
  final state = ref.watch(myNotifierProvider);
  return state.when(
    data: (value) => MyContent(value: value),
    loading: () => const CircularProgressIndicator(),
    error: (e, _) => ErrorBanner(message: e.toString()),
  );
}
```

**Navigation:**
```dart
context.go('/route');   // replace current route
context.push('/route'); // push on stack
// Never: Navigator.push(...)
```

**Hive storage:**
```dart
// Always open box before use (in main.dart)
await Hive.openBox<TransformResult>('history');

// Access in data source
Box<TransformResult> get _box => Hive.box('history');
```

## Step 6: Register Provider in DI

After creating any UseCase, Repository, or DataSource, register it in `lib/core/di/providers.dart`:

```dart
@riverpod
MyUseCase myUseCase(MyUseCaseRef ref) =>
    MyUseCase(repository: ref.watch(myRepositoryProvider));
```

## Step 7: Verify

```bash
flutter pub run build_runner build --delete-conflicting-outputs
flutter analyze lib/
dart format lib/ test/
flutter test
```

Zero `flutter analyze` warnings — treat warnings as errors.
