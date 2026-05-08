import '../repositories/ai_repository.dart';

class RunPromptUseCase {
  const RunPromptUseCase(this._repository);

  final AIRepository _repository;

  Future<String> execute(String enhancedPrompt) =>
      _repository.runPrompt(enhancedPrompt);
}
