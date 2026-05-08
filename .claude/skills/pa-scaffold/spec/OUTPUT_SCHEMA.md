# Output Schema — Scaffold

All templates below use `{{variables}}` for substitution. See `spec/PROMPT.md` Step 2 for variable derivation.

## Screen Template

```dart
// lib/features/{{feature}}/presentation/screens/{{name_snake}}_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class {{Name}}Screen extends ConsumerWidget {
  const {{Name}}Screen({super.key});

  static const routePath = '/{{route}}';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: watch provider
    return Scaffold(
      appBar: AppBar(title: const Text('{{Name}}')),
      body: const _{{Name}}Body(),
    );
  }
}

class _{{Name}}Body extends ConsumerWidget {
  const _{{Name}}Body();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement body
    return const SizedBox.shrink();
  }
}
```

## Notifier Template (AsyncNotifier)

```dart
// lib/features/{{feature}}/presentation/notifiers/{{name_snake}}_notifier.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '{{name_snake}}_notifier.g.dart';

@riverpod
class {{Name}}Notifier extends _${{Name}}Notifier {
  @override
  FutureOr<{{StateType}}?> build() => null;

  Future<void> execute(/* params */) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(/* useCase provider */).execute(/* params */),
    );
  }

  void reset() => state = const AsyncData(null);
}
```

## UseCase Template

```dart
// lib/features/{{feature}}/domain/usecases/{{name_snake}}_use_case.dart
class {{Name}}UseCase {
  const {{Name}}UseCase({
    required this.repository,
  });

  final {{RepositoryType}} repository;

  Future<{{ResultType}}> execute(/* params */) async {
    // TODO: implement
    throw UnimplementedError();
  }
}
```

## Repository Templates (2 files)

```dart
// lib/features/{{feature}}/domain/repositories/{{name_snake}}_repository.dart
abstract interface class {{Name}}Repository {
  Future<List<{{Entity}}>> getAll();
  Future<{{Entity}}> getById(String id);
  Future<void> save({{Entity}} entity);
  Future<void> delete(String id);
}
```

```dart
// lib/features/{{feature}}/data/repositories/{{name_snake}}_repository_impl.dart
import '../../domain/repositories/{{name_snake}}_repository.dart';

class {{Name}}RepositoryImpl implements {{Name}}Repository {
  const {{Name}}RepositoryImpl({required this.localDataSource});

  final {{Name}}LocalDataSource localDataSource;

  @override
  Future<List<{{Entity}}>> getAll() => localDataSource.fetchAll();

  @override
  Future<{{Entity}}> getById(String id) => localDataSource.fetchById(id);

  @override
  Future<void> save({{Entity}} entity) => localDataSource.save(entity);

  @override
  Future<void> delete(String id) => localDataSource.delete(id);
}
```

## DataSource Template

```dart
// lib/features/{{feature}}/data/datasources/{{name_snake}}_local_data_source.dart
import 'package:hive_flutter/hive_flutter.dart';

class {{Name}}LocalDataSource {
  static const _boxName = '{{box_name}}';

  Box get _box => Hive.box(_boxName);

  Future<List<{{Model}}>> fetchAll() async =>
      _box.values.cast<{{Model}}>().toList();

  Future<{{Model}}> fetchById(String id) async {
    final item = _box.get(id);
    if (item == null) throw Exception('{{Model}} not found: $id');
    return item as {{Model}};
  }

  Future<void> save({{Model}} item) async =>
      _box.put(item.id, item);

  Future<void> delete(String id) async =>
      _box.delete(id);
}
```

## Entity Template

```dart
// lib/features/{{feature}}/domain/entities/{{name_snake}}.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part '{{name_snake}}.freezed.dart';

@freezed
class {{Name}} with _${{Name}} {
  const factory {{Name}}({
    required String id,
    // TODO: add fields
    required DateTime createdAt,
  }) = _{{Name}};
}
```

## Widget Template

```dart
// lib/features/{{feature}}/presentation/widgets/{{name_snake}}_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class {{Name}}Widget extends ConsumerWidget {
  const {{Name}}Widget({
    super.key,
    // TODO: add props
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement
    return const SizedBox.shrink();
  }
}
```

## DI Provider Registration (always append to lib/core/di/providers.dart)

```dart
@riverpod
{{Name}}UseCase {{nameCamel}}UseCase({{Name}}UseCaseRef ref) =>
    {{Name}}UseCase(
      repository: ref.watch({{nameCamel}}RepositoryProvider),
    );

@riverpod
{{Name}}Repository {{nameCamel}}Repository({{Name}}RepositoryRef ref) =>
    {{Name}}RepositoryImpl(
      localDataSource: ref.watch({{nameCamel}}LocalDataSourceProvider),
    );

@riverpod
{{Name}}LocalDataSource {{nameCamel}}LocalDataSource({{Name}}LocalDataSourceRef ref) =>
    {{Name}}LocalDataSource();
```
