import 'dart:convert';
import 'package:http/http.dart' as http;

class GeminiClient {
  GeminiClient({required this.apiKey});

  final String apiKey;

  static const _model = 'gemini-2.0-flash';
  static const _baseUrl =
      'https://generativelanguage.googleapis.com/v1beta/models';
  static const _timeout = Duration(seconds: 30);

  Future<String> chat(String prompt) async {
    final response = await http
        .post(
          Uri.parse('$_baseUrl/$_model:generateContent?key=$apiKey'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'contents': [
              {
                'parts': [
                  {'text': prompt},
                ],
              },
            ],
            'generationConfig': {'temperature': 0.7},
          }),
        )
        .timeout(_timeout);

    if (response.statusCode != 200) {
      final error = jsonDecode(response.body);
      throw GeminiException(
        message: error['error']?['message'] ?? 'Unknown error',
        statusCode: response.statusCode,
      );
    }

    final body = jsonDecode(response.body) as Map<String, dynamic>;
    final candidates = body['candidates'] as List<dynamic>;
    final parts = candidates.first['content']['parts'] as List<dynamic>;
    return (parts.first['text'] as String).trim();
  }
}

class GeminiException implements Exception {
  const GeminiException({required this.message, required this.statusCode});
  final String message;
  final int statusCode;

  @override
  String toString() => 'GeminiException($statusCode): $message';
}
