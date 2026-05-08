# Examples — Flutter Expert

## Example 1: AsyncNotifier for Transformer

**Input:**
```
TASK: Implement TransformerNotifier that runs the transform use case
LAYER: Presentation
FEATURE: transformer
```

**Output** (`lib/features/transformer/presentation/notifiers/transformer_notifier.dart`):
```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'transformer_notifier.g.dart';

@riverpod
class TransformerNotifier extends _$TransformerNotifier {
  @override
  FutureOr<TransformResult?> build() => null;

  Future<void> transform(String rawPrompt, String patternId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() =>
      ref.read(transformUseCaseProvider).execute(rawPrompt, patternId)
    );
  }

  void reset() => state = const AsyncData(null);
}
```

---

## Example 2: ConsumerStatefulWidget with TextEditingController

**Input:**
```
TASK: Implement the prompt input screen with text field and transform button
LAYER: Presentation
FEATURE: transformer
```

**Output** (`lib/features/transformer/presentation/screens/prompt_input_screen.dart`):
```dart
class PromptInputScreen extends ConsumerStatefulWidget {
  const PromptInputScreen({super.key});

  @override
  ConsumerState<PromptInputScreen> createState() => _PromptInputScreenState();
}

class _PromptInputScreenState extends ConsumerState<PromptInputScreen> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTransform() {
    final input = _controller.text.trim();
    if (input.isEmpty) return;
    final patternId = ref.read(patternSelectionNotifierProvider);
    ref.read(transformerNotifierProvider.notifier).transform(input, patternId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          PromptTextField(controller: _controller),
          const PatternSelectorRow(),
          TransformButton(onTap: _onTransform),
          const PromptResultCard(),
        ],
      ),
    );
  }
}
```

---

## Example 3: UseCase + Repository

**Input:**
```
TASK: Implement TransformUseCase that applies a pattern and saves to history
LAYER: Domain
FEATURE: transformer
```

**Output** (`lib/features/transformer/domain/usecases/transform_use_case.dart`):
```dart
class TransformUseCase {
  const TransformUseCase({
    required this.patternRepository,
    required this.historyRepository,
  });

  final PatternRepository patternRepository;
  final HistoryRepository historyRepository;

  Future<TransformResult> execute(String rawPrompt, String patternId) async {
    final pattern = await patternRepository.getById(patternId);
    final enhanced = pattern.template.replaceAll('{{userInput}}', rawPrompt.trim());
    final result = TransformResult(
      originalPrompt: rawPrompt,
      enhancedPrompt: enhanced,
      appliedPattern: pattern,
      createdAt: DateTime.now(),
    );
    await historyRepository.save(result);
    return result;
  }
}
```
