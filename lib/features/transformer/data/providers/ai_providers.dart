import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/openai_client.dart';
import '../../domain/repositories/ai_repository.dart';
import '../../domain/usecases/run_prompt_use_case.dart';
import '../datasources/ai_remote_datasource.dart';
import '../repositories/ai_repository_impl.dart';

const _openAiApiKey = String.fromEnvironment(
  'OPENAI_API_KEY',
  defaultValue: '',
);

final openAiClientProvider = Provider<OpenAIClient>(
  (ref) => OpenAIClient(apiKey: _openAiApiKey),
);

final aiRemoteDatasourceProvider = Provider<AIRemoteDatasource>(
  (ref) => AIRemoteDatasource(ref.watch(openAiClientProvider)),
);

final aiRepositoryProvider = Provider<AIRepository>(
  (ref) => AIRepositoryImpl(ref.watch(aiRemoteDatasourceProvider)),
);

final runPromptUseCaseProvider = Provider<RunPromptUseCase>(
  (ref) => RunPromptUseCase(ref.watch(aiRepositoryProvider)),
);
