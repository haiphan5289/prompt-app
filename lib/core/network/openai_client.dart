import 'dart:convert';
import 'package:http/http.dart' as http;

class OpenAIClient {
  OpenAIClient({required this.apiKey});

  final String apiKey;

  static const _baseUrl = 'https://api.openai.com/v1';
  static const _model = 'gpt-4o-mini';
  static const _timeout = Duration(seconds: 30);

  Future<String> chat(String prompt) async {
    final response = await http
        .post(
          Uri.parse('$_baseUrl/chat/completions'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $apiKey',
          },
          body: jsonEncode({
            'model': _model,
            'messages': [
              {'role': 'user', 'content': prompt},
            ],
            'temperature': 0.7,
          }),
        )
        .timeout(_timeout);

    if (response.statusCode != 200) {
      final error = jsonDecode(response.body);
      throw OpenAIException(
        message: error['error']?['message'] ?? 'Unknown error',
        statusCode: response.statusCode,
      );
    }

    final body = jsonDecode(response.body) as Map<String, dynamic>;
    final choices = body['choices'] as List<dynamic>;
    return (choices.first['message']['content'] as String).trim();
  }
}

class OpenAIException implements Exception {
  const OpenAIException({required this.message, required this.statusCode});
  final String message;
  final int statusCode;

  @override
  String toString() => 'OpenAIException($statusCode): $message';
}
