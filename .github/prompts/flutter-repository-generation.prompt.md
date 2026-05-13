---
agent: Flutter Repository Generator
always: Generate Repository interface + implementation following Clean Architecture with proper error handling
description: "Auto-generate Repository interface (domain/) and implementation (data/) with data source integration and error handling."
---

## Prompt Activation

**You are an expert Flutter developer following Clean Architecture Repository pattern.**

# Flutter Repository Generation - Data Layer Pattern

You are an expert Flutter developer specializing in **Repository pattern implementation** within the **Prompt App**.

We are going to **auto-generate Repository interfaces and implementations** following **Clean Architecture** with proper **data source integration** and **error handling**.

## Context Understanding

The **Repository Generation Pattern** handles:
- Abstract repository interfaces in domain layer
- Concrete implementations in data layer
- Data source orchestration (local + remote)
- Error handling and transformation
- Data model to entity mapping
- Caching strategies

## Architecture Requirements

All repositories must follow:
- **Abstract interface** in `domain/repositories/`
- **Concrete implementation** in `data/repositories/`
- **Data sources** injected via constructor
- **Entity types** in method signatures (not data models)
- **Exception handling** with proper error types
- **Const constructors** where applicable

## Repository Structure

```
lib/features/{feature}/
├── domain/
│   └── repositories/
│       └── {name}_repository.dart        ← Interface
├── data/
│   ├── repositories/
│   │   └── {name}_repository_impl.dart   ← Implementation
│   ├── datasources/
│   │   ├── {name}_remote_datasource.dart ← API calls
│   │   └── {name}_local_datasource.dart  ← Local storage
│   └── models/
│       └── {name}_model.dart             ← Data models with JSON
```

## Generation Templates

### Repository Interface (Domain Layer)

```dart
// lib/features/{feature}/domain/repositories/{name}_repository.dart

/// Repository interface for {feature} data operations.
/// 
/// Defines the contract for accessing {description} data.
/// Implementations should handle data source orchestration and error handling.
abstract interface class {Name}Repository {
  /// Fetches {description}.
  /// 
  /// Returns [{Entity}] on success.
  /// Throws [Exception] if operation fails.
  Future<{Entity}> fetch{Name}({Parameters});
  
  /// Saves {description}.
  /// 
  /// Returns [void] on success.
  /// Throws [Exception] if operation fails.
  Future<void> save{Name}({Entity} entity);
  
  /// Deletes {description}.
  /// 
  /// Returns [void] on success.
  /// Throws [Exception] if operation fails.
  Future<void> delete{Name}(String id);
  
  /// Gets all {description}.
  /// 
  /// Returns list of [{Entity}] on success.
  /// Returns empty list if no data found.
  Future<List<{Entity}>> getAll();
}
```

### Repository Implementation (Data Layer)

```dart
// lib/features/{feature}/data/repositories/{name}_repository_impl.dart
import '../../domain/entities/{entity}.dart';
import '../../domain/repositories/{name}_repository.dart';
import '../datasources/{name}_remote_datasource.dart';
import '../datasources/{name}_local_datasource.dart';
import '../models/{name}_model.dart';

/// Concrete implementation of [{Name}Repository].
/// 
/// Orchestrates data from remote and local sources with caching strategy.
class {Name}RepositoryImpl implements {Name}Repository {
  const {Name}RepositoryImpl({
    required {Name}RemoteDatasource remoteDatasource,
    {Name}LocalDatasource? localDatasource,
  })  : _remoteDatasource = remoteDatasource,
        _localDatasource = localDatasource;

  final {Name}RemoteDatasource _remoteDatasource;
  final {Name}LocalDatasource? _localDatasource;

  @override
  Future<{Entity}> fetch{Name}({Parameters}) async {
    try {
      // Try remote first
      final model = await _remoteDatasource.fetch({parameters});
      
      // Cache locally
      if (_localDatasource != null) {
        await _localDatasource.save(model);
      }
      
      // Map to domain entity
      return model.toEntity();
    } catch (e) {
      // Fallback to local cache
      if (_localDatasource != null) {
        try {
          final cachedModel = await _localDatasource.fetch({parameters});
          return cachedModel.toEntity();
        } catch (_) {
          // Re-throw original error if cache also fails
          rethrow;
        }
      }
      rethrow;
    }
  }

  @override
  Future<void> save{Name}({Entity} entity) async {
    final model = {Name}Model.fromEntity(entity);
    
    // Save to both sources
    await Future.wait([
      _remoteDatasource.save(model),
      if (_localDatasource != null) _localDatasource.save(model),
    ]);
  }

  @override
  Future<void> delete{Name}(String id) async {
    await Future.wait([
      _remoteDatasource.delete(id),
      if (_localDatasource != null) _localDatasource.delete(id),
    ]);
  }

  @override
  Future<List<{Entity}>> getAll() async {
    try {
      final models = await _remoteDatasource.getAll();
      
      // Cache locally
      if (_localDatasource != null) {
        await _localDatasource.saveAll(models);
      }
      
      return models.map((model) => model.toEntity()).toList();
    } catch (e) {
      // Fallback to local
      if (_localDatasource != null) {
        final cachedModels = await _localDatasource.getAll();
        return cachedModels.map((model) => model.toEntity()).toList();
      }
      rethrow;
    }
  }
}
```

### Remote Data Source

```dart
// lib/features/{feature}/data/datasources/{name}_remote_datasource.dart
import 'package:dio/dio.dart';
import '../models/{name}_model.dart';

/// Remote data source for {feature} using API.
class {Name}RemoteDatasource {
  const {Name}RemoteDatasource(this._dio);

  final Dio _dio;

  Future<{Name}Model> fetch({Parameters}) async {
    try {
      final response = await _dio.get('/api/{endpoint}');
      return {Name}Model.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> save({Name}Model model) async {
    try {
      await _dio.post(
        '/api/{endpoint}',
        data: model.toJson(),
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> delete(String id) async {
    try {
      await _dio.delete('/api/{endpoint}/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<List<{Name}Model>> getAll() async {
    try {
      final response = await _dio.get('/api/{endpoint}');
      final list = response.data as List;
      return list.map((json) => {Name}Model.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException error) {
    if (error.response != null) {
      return Exception('API Error: ${error.response?.statusCode}');
    } else if (error.type == DioExceptionType.connectionTimeout) {
      return Exception('Connection timeout');
    } else if (error.type == DioExceptionType.receiveTimeout) {
      return Exception('Receive timeout');
    } else {
      return Exception('Network error: ${error.message}');
    }
  }
}
```

### Local Data Source (Hive example)

```dart
// lib/features/{feature}/data/datasources/{name}_local_datasource.dart
import 'package:hive_flutter/hive_flutter.dart';
import '../models/{name}_model.dart';

/// Local data source for {feature} using Hive.
class {Name}LocalDatasource {
  const {Name}LocalDatasource(this._box);

  final Box<{Name}Model> _box;

  Future<{Name}Model> fetch({Parameters}) async {
    final model = _box.get({key});
    if (model == null) {
      throw Exception('Not found in cache');
    }
    return model;
  }

  Future<void> save({Name}Model model) async {
    await _box.put(model.id, model);
  }

  Future<void> delete(String id) async {
    await _box.delete(id);
  }

  Future<List<{Name}Model>> getAll() async {
    return _box.values.toList();
  }

  Future<void> saveAll(List<{Name}Model> models) async {
    final map = {for (var model in models) model.id: model};
    await _box.putAll(map);
  }

  Future<void> clear() async {
    await _box.clear();
  }
}
```

### Data Model with JSON Serialization

```dart
// lib/features/{feature}/data/models/{name}_model.dart
import 'package:hive/hive.dart';
import '../../domain/entities/{entity}.dart';

part '{name}_model.g.dart';

@HiveType(typeId: {uniqueId})
class {Name}Model extends HiveObject {
  {Name}Model({
    required this.id,
    required this.field1,
    required this.field2,
  });

  @HiveField(0)
  final String id;

  @HiveField(1)
  final String field1;

  @HiveField(2)
  final int field2;

  /// Convert from JSON (API response)
  factory {Name}Model.fromJson(Map<String, dynamic> json) => {Name}Model(
        id: json['id'] as String,
        field1: json['field_1'] as String,
        field2: json['field_2'] as int,
      );

  /// Convert to JSON (API request)
  Map<String, dynamic> toJson() => {
        'id': id,
        'field_1': field1,
        'field_2': field2,
      };

  /// Convert to domain entity
  {Entity} toEntity() => {Entity}(
        id: id,
        field1: field1,
        field2: field2,
      );

  /// Convert from domain entity
  factory {Name}Model.fromEntity({Entity} entity) => {Name}Model(
        id: entity.id,
        field1: entity.field1,
        field2: entity.field2,
      );
}
```

### Provider Registration

```dart
// lib/features/{feature}/data/providers/{feature}_providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../domain/repositories/{name}_repository.dart';
import '../repositories/{name}_repository_impl.dart';
import '../datasources/{name}_remote_datasource.dart';
import '../datasources/{name}_local_datasource.dart';
import '../models/{name}_model.dart';

// Dio instance
final dioProvider = Provider<Dio>((ref) {
  return Dio(BaseOptions(
    baseUrl: 'https://api.example.com',
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),
  ));
});

// Hive box
final {name}BoxProvider = Provider<Box<{Name}Model>>((ref) {
  return Hive.box<{Name}Model>('{name}Box');
});

// Remote datasource
final {name}RemoteDatasourceProvider = Provider<{Name}RemoteDatasource>((ref) {
  return {Name}RemoteDatasource(ref.watch(dioProvider));
});

// Local datasource
final {name}LocalDatasourceProvider = Provider<{Name}LocalDatasource>((ref) {
  return {Name}LocalDatasource(ref.watch({name}BoxProvider));
});

// Repository
final {name}RepositoryProvider = Provider<{Name}Repository>((ref) {
  return {Name}RepositoryImpl(
    remoteDatasource: ref.watch({name}RemoteDatasourceProvider),
    localDatasource: ref.watch({name}LocalDatasourceProvider),
  );
});
```

## Caching Strategies

### 1. Cache-Aside (Lazy Loading)
```dart
@override
Future<{Entity}> fetch({Parameters}) async {
  // Check cache first
  if (_localDatasource != null) {
    try {
      final cached = await _localDatasource.fetch({parameters});
      return cached.toEntity();
    } catch (_) {
      // Cache miss, continue to remote
    }
  }
  
  // Fetch from remote
  final model = await _remoteDatasource.fetch({parameters});
  
  // Update cache
  if (_localDatasource != null) {
    await _localDatasource.save(model);
  }
  
  return model.toEntity();
}
```

### 2. Write-Through
```dart
@override
Future<void> save({Entity} entity) async {
  final model = {Name}Model.fromEntity(entity);
  
  // Write to cache immediately
  if (_localDatasource != null) {
    await _localDatasource.save(model);
  }
  
  // Then write to remote
  await _remoteDatasource.save(model);
}
```

### 3. Cache with TTL
```dart
class CachedModel<T> {
  const CachedModel(this.data, this.timestamp);
  final T data;
  final DateTime timestamp;
  
  bool isExpired(Duration ttl) =>
      DateTime.now().difference(timestamp) > ttl;
}

@override
Future<{Entity}> fetch({Parameters}) async {
  // Check cache with TTL
  if (_localDatasource != null) {
    final cached = await _localDatasource.fetchWithTimestamp({parameters});
    if (cached != null && !cached.isExpired(Duration(minutes: 5))) {
      return cached.data.toEntity();
    }
  }
  
  // Cache expired or miss, fetch fresh data
  final model = await _remoteDatasource.fetch({parameters});
  await _localDatasource?.saveWithTimestamp(model);
  return model.toEntity();
}
```

## Error Handling Best Practices

1. ✅ **Custom exception types**
2. ✅ **Meaningful error messages**
3. ✅ **Fallback to cache on network error**
4. ✅ **Log errors for debugging**
5. ✅ **Don't swallow exceptions silently**

## Checklist

Before using a repository:
- [ ] Interface defined in `domain/repositories/`
- [ ] Implementation in `data/repositories/`
- [ ] Remote datasource with error handling
- [ ] Local datasource (if caching needed)
- [ ] Data model with JSON serialization
- [ ] Entity mapping methods (toEntity/fromEntity)
- [ ] Providers registered
- [ ] Hive TypeAdapter generated (if using Hive)
- [ ] Tests written for repository logic
