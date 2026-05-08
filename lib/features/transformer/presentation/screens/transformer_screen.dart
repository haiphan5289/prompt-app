import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/copy_button.dart';
import '../../domain/entities/prompt_pattern.dart';
import '../notifiers/transformer_notifier.dart';

class TransformerScreen extends ConsumerStatefulWidget {
  const TransformerScreen({super.key});

  @override
  ConsumerState<TransformerScreen> createState() => _TransformerScreenState();
}

class _TransformerScreenState extends ConsumerState<TransformerScreen> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() =>
      ref.read(transformerProvider.notifier).transform(_controller.text);

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(transformerProvider);
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Prompt Transformer'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _controller,
                minLines: 4,
                maxLines: 8,
                textInputAction: TextInputAction.newline,
                decoration: InputDecoration(
                  fillColor: cs.surfaceContainerLow,
                  hintText: 'Type your prompt here…',
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              FilledButton(
                onPressed: state.isLoading ? null : _submit,
                child: const Text('Transform & Ask AI'),
              ),
              const SizedBox(height: AppSpacing.lg),
              state.when(
                data: (result) {
                  if (result == null) return const SizedBox.shrink();
                  return _ResultCard(result: result);
                },
                loading: () => const Center(
                  child: Padding(
                    padding: EdgeInsets.all(AppSpacing.xl),
                    child: CircularProgressIndicator(),
                  ),
                ),
                error: (error, _) => _ErrorView(
                  message: error.toString(),
                  onRetry: _submit,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ResultCard extends StatelessWidget {
  const _ResultCard({required this.result});

  final TransformerResult result;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Chip(
              avatar: CircleAvatar(
                backgroundColor: _categoryColor(result.pattern.category),
                radius: 6,
              ),
              label: Text(result.pattern.name),
              backgroundColor: cs.surfaceContainerLow,
              labelStyle: tt.labelMedium,
            ),
            const Spacer(),
            CopyButton(text: result.aiResponse),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        Card(
          color: cs.surfaceContainerLow,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: SelectableText(
              result.aiResponse,
              style: tt.bodyMedium,
            ),
          ),
        ),
      ],
    );
  }

  Color _categoryColor(PatternCategory category) => switch (category) {
        PatternCategory.roleBased => AppColors.roleBased,
        PatternCategory.chainOfThought => AppColors.chainOfThought,
        PatternCategory.fewShot => AppColors.fewShot,
        PatternCategory.risen => AppColors.risen,
        PatternCategory.cato => AppColors.cato,
      };
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Card(
          color: cs.errorContainer,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Text(
              message,
              style: tt.bodyMedium?.copyWith(color: cs.onErrorContainer),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        OutlinedButton.icon(
          onPressed: onRetry,
          icon: const Icon(Icons.refresh),
          label: const Text('Retry'),
        ),
      ],
    );
  }
}
