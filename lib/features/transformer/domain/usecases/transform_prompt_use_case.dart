import '../entities/prompt_pattern.dart';

class TransformPromptUseCase {
  const TransformPromptUseCase();

  String execute(String rawPrompt, PromptPattern pattern) =>
      pattern.transform(rawPrompt);
}
