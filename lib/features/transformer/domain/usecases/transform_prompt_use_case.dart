import '../entities/prompt_pattern.dart';

class TransformPromptUseCase {
  const TransformPromptUseCase();

  String execute(String rawPrompt, PromptPattern pattern, {String? title}) =>
      pattern.transform(rawPrompt, title: title);
}
