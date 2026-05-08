import '../../../../core/network/openai_client.dart';

class AIRemoteDatasource {
  const AIRemoteDatasource(this._client);

  final OpenAIClient _client;

  Future<String> runPrompt(String enhancedPrompt) =>
      _client.chat(enhancedPrompt);
}
