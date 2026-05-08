# Examples — Full Module Generator

## Example 1: Bookmark Feature

**Input:**
```
FEATURE_NAME: bookmark
DISPLAY_NAME: Bookmark
PURPOSE: Save and revisit favourite enhanced prompts
ENTITY_FIELDS:
  - promptId: String
  - note: String
  - savedAt: DateTime
```

**Generated entity** (`lib/features/bookmark/domain/entities/bookmark.dart`):
```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bookmark.freezed.dart';

@freezed
class Bookmark with _$Bookmark {
  const factory Bookmark({
    required String id,
    required String promptId,
    required String note,
    required DateTime savedAt,
    required DateTime createdAt,
  }) = _Bookmark;
}
```

**Generated notifier** (`lib/features/bookmark/presentation/notifiers/bookmark_notifier.dart`):
```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bookmark_notifier.g.dart';

@riverpod
class BookmarkNotifier extends _$BookmarkNotifier {
  @override
  FutureOr<List<Bookmark>> build() =>
      ref.read(getBookmarkUseCaseProvider).execute();

  Future<void> refresh() =>
      ref.refresh(bookmarkNotifierProvider.future);

  Future<void> save(Bookmark item) async {
    await ref.read(saveBookmarkUseCaseProvider).execute(item);
    ref.invalidateSelf();
  }
}
```

**DI additions** (`lib/core/di/providers.dart`):
```dart
@riverpod
BookmarkLocalDataSource bookmarkLocalDataSource(BookmarkLocalDataSourceRef ref) =>
    BookmarkLocalDataSource();

@riverpod
BookmarkRepository bookmarkRepository(BookmarkRepositoryRef ref) =>
    BookmarkRepositoryImpl(
      dataSource: ref.watch(bookmarkLocalDataSourceProvider),
    );

@riverpod
GetBookmarkUseCase getBookmarkUseCase(GetBookmarkUseCaseRef ref) =>
    GetBookmarkUseCase(repository: ref.watch(bookmarkRepositoryProvider));

@riverpod
SaveBookmarkUseCase saveBookmarkUseCase(SaveBookmarkUseCaseRef ref) =>
    SaveBookmarkUseCase(repository: ref.watch(bookmarkRepositoryProvider));
```

**main.dart addition:**
```dart
await Hive.openBox('bookmark');
```

---

## Example 2: Prompt History Feature

**Input:**
```
FEATURE_NAME: prompt_history
DISPLAY_NAME: PromptHistory
PURPOSE: Store before/after transform results persistently
ENTITY_FIELDS:
  - originalPrompt: String
  - enhancedPrompt: String
  - patternId: String
```

**Generated screen** (`lib/features/prompt_history/presentation/screens/prompt_history_screen.dart`):
```dart
class PromptHistoryScreen extends ConsumerWidget {
  const PromptHistoryScreen({super.key});
  static const routePath = '/prompt-history';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(promptHistoryNotifierProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('PromptHistory')),
      body: state.when(
        data: (items) => items.isEmpty
            ? const Center(child: Text('Nothing here yet.'))
            : ListView.builder(
                itemCount: items.length,
                itemBuilder: (_, i) => PromptHistoryCard(item: items[i]),
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}
```
