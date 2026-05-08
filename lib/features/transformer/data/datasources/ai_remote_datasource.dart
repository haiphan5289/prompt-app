import '../../../../core/network/gemini_client.dart';

class AIRemoteDatasource {
  const AIRemoteDatasource(this._client);

  final GeminiClient _client;

  Future<String> runPrompt(String enhancedPrompt) =>
      _client.chat(enhancedPrompt);
}
