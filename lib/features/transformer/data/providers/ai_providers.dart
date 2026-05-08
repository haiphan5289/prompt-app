import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/gemini_client.dart';
import '../../domain/repositories/ai_repository.dart';
import '../../domain/usecases/run_prompt_use_case.dart';
import '../datasources/ai_remote_datasource.dart';
import '../repositories/ai_repository_impl.dart';

const _geminiApiKey = String.fromEnvironment(
  'GEMINI_API_KEY',
  defaultValue: '',
);

final geminiClientProvider = Provider<GeminiClient>(
  (ref) => GeminiClient(apiKey: _geminiApiKey),
);

final aiRemoteDatasourceProvider = Provider<AIRemoteDatasource>(
  (ref) => AIRemoteDatasource(ref.watch(geminiClientProvider)),
);

final aiRepositoryProvider = Provider<AIRepository>(
  (ref) => AIRepositoryImpl(ref.watch(aiRemoteDatasourceProvider)),
);

final runPromptUseCaseProvider = Provider<RunPromptUseCase>(
  (ref) => RunPromptUseCase(ref.watch(aiRepositoryProvider)),
);
