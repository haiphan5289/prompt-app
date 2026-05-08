# Execution Workflow — Anti-Hallucination

Run every step below before generating any Flutter/Dart code.

## Step 1: Verify Packages

Before importing any package, confirm it exists in `pubspec.yaml`:

```bash
grep -A 50 "dependencies:" pubspec.yaml | grep "<package_name>"
```

If the package is missing:
- Do NOT silently include the import.
- Flag it explicitly and suggest adding it to `pubspec.yaml`.

## Step 2: Verify Riverpod Providers

Before referencing any provider (e.g., `patternRepositoryProvider`, `transformerProvider`):

```bash
grep -r "patternRepositoryProvider" lib/
```

If not found:
- Scaffold the provider first, OR
- Ask the user to confirm the correct provider name.

## Step 3: Verify Domain Models / Entities

Before referencing a model class or any of its fields:

```bash
grep -r "class PromptPattern" lib/
grep -r "enhancedText" lib/
```

- Never assume field names.
- Read the actual model file if it exists.

## Step 4: Verify File Paths

Before constructing any import path:

```bash
find lib/ -name "prompt_pattern.dart"
```

- Flutter uses relative or `package:` imports.
- Never construct an import path without verifying the file exists.

## Step 5: Verify Method Signatures

Before calling any repository or use case method:

```bash
grep -n "Future\|Stream" lib/domain/repositories/
```

- Read the actual method signature — parameter names, types, and return types — before invoking it.

## Step 6: State Unverified Symbols Explicitly

If any symbol cannot be verified after running the above steps:
- State explicitly what could not be verified.
- Do NOT generate code that silently assumes the symbol exists.
- Offer to scaffold or stub it first.
