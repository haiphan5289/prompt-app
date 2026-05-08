# Examples — pa-service

## Example 1: Pattern Suggestion (Claude API)

### Input

```
NAME: PatternSuggestion
ENDPOINT: https://api.anthropic.com/v1/messages
FEATURE: transformer
OPERATIONS:
  - name: suggestPattern
    method: POST
    request:
      prompt: String
    response:
      patternId: String
      confidence: double
```

### Output: domain/services/pattern_suggestion_service.dart

```dart
abstract interface class PatternSuggestionService {
  Future<SuggestPatternResponse> suggestPattern(SuggestPatternRequest request);
}
```

### Output: data/services/pattern_suggestion_service_impl.dart

```dart
import 'package:dio/dio.dart';

class PatternSuggestionServiceImpl implements PatternSuggestionService {
  const PatternSuggestionServiceImpl({required this.dio});

  final Dio dio;

  @override
  Future<SuggestPatternResponse> suggestPattern(SuggestPatternRequest request) async {
    final response = await dio.post(
      'https://api.anthropic.com/v1/messages',
      data: request.toJson(),
      options: Options(
        headers: {
          'Authorization': 'Bearer ${const String.fromEnvironment('API_KEY')}',
          'Content-Type': 'application/json',
        },
      ),
    );
    return SuggestPatternResponse.fromJson(response.data as Map<String, dynamic>);
  }
}
```

### Output: data/models/suggest_pattern_request.dart

```dart
class SuggestPatternRequest {
  const SuggestPatternRequest({required this.prompt});
  final String prompt;

  Map<String, dynamic> toJson() => {'prompt': prompt};
}
```

### Output: data/models/suggest_pattern_response.dart

```dart
class SuggestPatternResponse {
  const SuggestPatternResponse({
    required this.patternId,
    required this.confidence,
  });

  final String patternId;
  final double confidence;

  factory SuggestPatternResponse.fromJson(Map<String, dynamic> json) =>
      SuggestPatternResponse(
        patternId: json['patternId'] as String,
        confidence: (json['confidence'] as num).toDouble(),
      );
}
```

### Output: data/providers/pattern_suggestion_providers.dart

```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dio/dio.dart';

part 'pattern_suggestion_providers.g.dart';

@riverpod
Dio dio(DioRef ref) => Dio(BaseOptions(connectTimeout: const Duration(seconds: 10)));

@riverpod
PatternSuggestionService patternSuggestionService(PatternSuggestionServiceRef ref) =>
    PatternSuggestionServiceImpl(dio: ref.watch(dioProvider));
```

---

## Example 2: Remote Pattern Library Update (GET)

### Input

```
NAME: RemotePattern
ENDPOINT: https://api.promptapp.io/v1/patterns
FEATURE: pattern_library
OPERATIONS:
  - name: fetchPatterns
    method: GET
    request:
      locale: String
    response:
      patterns: List<Map<String, dynamic>>
      updatedAt: String
```

### Output: domain/services/remote_pattern_service.dart

```dart
abstract interface class RemotePatternService {
  Future<FetchPatternsResponse> fetchPatterns(FetchPatternsRequest request);
}
```

### Output: data/services/remote_pattern_service_impl.dart

```dart
import 'package:dio/dio.dart';

class RemotePatternServiceImpl implements RemotePatternService {
  const RemotePatternServiceImpl({required this.dio});

  final Dio dio;

  @override
  Future<FetchPatternsResponse> fetchPatterns(FetchPatternsRequest request) async {
    final response = await dio.get(
      'https://api.promptapp.io/v1/patterns',
      queryParameters: request.toJson(),
    );
    return FetchPatternsResponse.fromJson(response.data as Map<String, dynamic>);
  }
}
```

---

## Example 3: Analytics Feedback (POST, no response body)

### Input

```
NAME: Feedback
ENDPOINT: https://api.promptapp.io/v1/feedback
FEATURE: shared
OPERATIONS:
  - name: sendFeedback
    method: POST
    request:
      promptId: String
      rating: int
      comment: String?
    response:
      success: bool
```

### Output: domain/services/feedback_service.dart

```dart
abstract interface class FeedbackService {
  Future<SendFeedbackResponse> sendFeedback(SendFeedbackRequest request);
}
```

### Output: data/models/send_feedback_request.dart

```dart
class SendFeedbackRequest {
  const SendFeedbackRequest({
    required this.promptId,
    required this.rating,
    this.comment,
  });

  final String promptId;
  final int rating;
  final String? comment;

  Map<String, dynamic> toJson() => {
    'promptId': promptId,
    'rating': rating,
    if (comment != null) 'comment': comment,
  };
}
```
