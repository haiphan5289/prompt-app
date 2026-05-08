# Input Schema — Anti-Hallucination

This skill is triggered implicitly before any code generation task. No structured user input is required.

## Context Inputs

| Input | Source | Description |
|---|---|---|
| `package_name` | Code generation context | A package you intend to import |
| `provider_name` | Code generation context | A Riverpod provider name you intend to reference |
| `class_name` | Code generation context | A domain entity or model class name |
| `field_name` | Code generation context | A field on a domain model |
| `file_path` | Code generation context | An import path you intend to use |
| `method_name` | Code generation context | A repository or use case method you intend to call |

## Trigger Conditions

Run this skill whenever you are about to:
- Write a `import 'package:...'` statement
- Reference a Riverpod provider by name
- Access a field on a domain entity
- Call a repository or use case method
- Construct a `lib/...` file path for an import
