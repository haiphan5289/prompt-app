# Execution Workflow — Bug Fix

## Step 1: Limit Scope (3–4 files max)

Read only the files directly involved in the bug. Never explore broadly.

**Good scope:**
- The widget showing the symptom
- The Notifier/Provider driving it
- The UseCase or Repository the Notifier calls

**Skip:**
- Entire feature folders
- Unrelated providers
- Third-party package source

## Step 2: Identify Root Cause

State the root cause in **one sentence** before proposing any fix.

**Widget not rebuilding?**
- Is the widget watching the provider? (`ref.watch`, not `ref.read`)
- Is state mutated directly (bypassing `state = ...`)?
- Is the widget inside the correct `ProviderScope`?
- Is a `ConsumerWidget` being used instead of `StatelessWidget`?

**Async/await bug?**
- Is `await` missing on an async call?
- Is `BuildContext` used after an `await` without a `mounted` check?
- Is the `AsyncValue.when()` handler missing the `error:` case?

**Null safety crash?**
- Is a nullable field accessed with `!` without a guard?
- Is a `late` variable accessed before initialization?
- Is `AsyncValue.data` accessed without checking `hasValue`?

**Riverpod bug?**
- Is `ref.read` used in `build()` instead of `ref.watch`?
- Is a provider overridden in a test but not in the widget tree?
- Is `keepAlive` missing on a provider that should survive navigation?
- Is `ref.invalidate` called when `ref.refresh` was intended?

**Transformer bug?**
- Is the correct pattern template being loaded?
- Are all `{{variable}}` placeholders substituted?
- Is the user's raw input being sanitized/trimmed before injection?

**Local storage bug?**
- Is `Hive.openBox` called before reading?
- Is the key consistent between write and read?
- Is the storage type adapter registered?

## Step 3: Apply Minimal Fix

Fix only the root cause. Do not refactor surrounding code.

**Good fixes:**
- Change `ref.read(xProvider)` → `ref.watch(xProvider)` in `build()`
- Add `if (!context.mounted) return;` after `await`
- Replace `value!` with `value ?? defaultValue` or a proper null guard
- Fix missing `state = state.copyWith(...)` in Notifier

**Avoid:**
- Rewriting the entire Notifier
- Changing architecture patterns
- Adding unrelated cleanup
- Upgrading packages as a "fix"

## Step 4: Trace the Data Path

Verify the fix end-to-end through the transformer flow:

```
User taps button
  → Widget calls ref.read(notifierProvider.notifier).transform(input)
  → Notifier sets state = AsyncLoading
  → Notifier calls transformUseCase.execute(input, pattern)
  → UseCase calls patternRepository.getPattern(id)
  → UseCase calls transformer.apply(input, pattern.template)
  → Notifier sets state = AsyncData(result)
  → Widget rebuilds with enhanced prompt
```

At each arrow: is data flowing? Is async handled? Are errors caught?

## Step 5: Verify

```bash
flutter analyze lib/
flutter test test/
dart format --output=none --set-exit-if-changed lib/
```

## Step 6: Summarize

Provide all four fields:
- **What was broken:** root cause (one sentence)
- **Why:** the mechanism that caused it
- **Fix:** the minimal change applied
- **How to verify:** steps to confirm the fix works
