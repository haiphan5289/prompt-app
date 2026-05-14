import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/providers/ai_providers.dart';
import '../../domain/entities/prompt_pattern.dart';
import '../../domain/usecases/transform_prompt_use_case.dart';

class TransformerResult {
  const TransformerResult({
    required this.rawPrompt,
    required this.pattern,
    required this.enhancedPrompt,
    required this.aiResponse,
  });

  final String rawPrompt;
  final PromptPattern pattern;
  final String enhancedPrompt;
  final String aiResponse;
}

class TransformerNotifier extends AsyncNotifier<TransformerResult?> {
  @override
  Future<TransformerResult?> build() async => null;

  Future<void> transform(String rawPrompt, {String? title}) async {
    final trimmed = rawPrompt.trim();
    if (trimmed.isEmpty) return;

    state = const AsyncValue.loading();

    final pattern = PromptPattern.autoSelect(trimmed, title: title);
    final enhancedPrompt = const TransformPromptUseCase().execute(
      trimmed,
      pattern,
      title: title,
    );
    final runUseCase = ref.read(runPromptUseCaseProvider);

    state = await AsyncValue.guard(() async {
      final aiResponse = await runUseCase.execute(enhancedPrompt);
      return TransformerResult(
        rawPrompt: trimmed,
        pattern: pattern,
        enhancedPrompt: enhancedPrompt,
        aiResponse: aiResponse,
      );
    });
  }

  void reset() => state = const AsyncValue.data(null);
}

final transformerProvider =
    AsyncNotifierProvider<TransformerNotifier, TransformerResult?>(
  TransformerNotifier.new,
);
