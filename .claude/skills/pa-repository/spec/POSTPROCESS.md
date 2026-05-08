# Post-Execution Steps — pa-repository

## 1. Format
```bash
dart format lib/features/{{feature}}/domain/repositories/ \
            lib/features/{{feature}}/data/repositories/ \
            lib/core/di/providers.dart
```

## 2. Analyze
```bash
flutter analyze lib/features/{{feature}}/
```
Zero warnings required.

## 3. Run Code Generation (if using @riverpod annotation)
```bash
dart run build_runner build --delete-conflicting-outputs
```
Confirm the generated `providers.g.dart` includes the new provider.

## 4. Write Repository Tests

Create:
```
test/features/{{feature}}/data/repositories/{{name_snake}}_repository_impl_test.dart
```

Use `mocktail` to mock the DataSource. Test every generated operation.

```bash
flutter test test/features/{{feature}}/data/repositories/
```

## 5. Wire to UseCase

After the repository is created, the next step is to wire it into a UseCase via `pa-generate-usecase`. The UseCase will depend on the repository interface, not the implementation.

## 6. Verify No Direct Imports of Impl

```bash
grep -rn "{{Name}}RepositoryImpl" lib/features/
```

Only `lib/core/di/providers.dart` should reference the implementation class.
