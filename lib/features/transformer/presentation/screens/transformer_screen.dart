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
  final _titleController = TextEditingController();
  PromptPattern _selectedPattern = PromptPattern.autoSelect('');

  @override
  void dispose() {
    _controller.dispose();
    _titleController.dispose();
    super.dispose();
  }

  void _submit() {
    ref.read(transformerProvider.notifier).transform(
      _controller.text,
      title: _titleController.text.trim().isNotEmpty
          ? _titleController.text.trim()
          : null,
    );
  }

  void _onPromptChanged(String text) {
    setState(() {
      _selectedPattern = PromptPattern.autoSelect(
        text,
        title: _titleController.text.trim().isNotEmpty ? _titleController.text.trim() : null,
      );
    });
  }

  void _onTitleChanged(String text) {
    setState(() {
      _selectedPattern = PromptPattern.autoSelect(
        _controller.text,
        title: text.trim().isNotEmpty ? text.trim() : null,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(transformerProvider);
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Biến Đổi Câu Hỏi'),
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
                keyboardType: TextInputType.multiline,
                textCapitalization: TextCapitalization.sentences,
                enableInteractiveSelection: true,
                enableSuggestions: true,
                autocorrect: true,
                onChanged: _onPromptChanged,
                decoration: InputDecoration(
                  fillColor: cs.surfaceContainerLow,
                  hintText: 'Nhập câu hỏi của bạn ở đây… (hỗ trợ tiếng Việt)',
                  helperText: 'Long press để paste',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              TextField(
                controller: _titleController,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.words,
                enableInteractiveSelection: true,
                enableSuggestions: true,
                autocorrect: true,
                onChanged: _onTitleChanged,
                decoration: InputDecoration(
                  fillColor: cs.surfaceContainerLow,
                  labelText: 'Vai trò/Chức danh (tùy chọn)',
                  hintText: 'VD: Chuyên gia giặt sấy, Nhà phát triển Flutter, Quản lý bán hàng',
                  helperText: _selectedPattern.requiresTitle 
                    ? 'Bắt buộc cho pattern "${_selectedPattern.name}" • Long press để paste'
                    : 'Tùy chọn - sẽ được dùng nếu pattern yêu cầu • Long press để paste',
                  prefixIcon: const Icon(Icons.person_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              FilledButton(
                onPressed: state.isLoading ? null : _submit,
                child: const Text('Biến Đổi & Hỏi AI'),
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
        PatternCategory.persona => AppColors.persona,
        PatternCategory.professionalRole => AppColors.professionalRole,
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
          label: const Text('Thử Lại'),
        ),
      ],
    );
  }
}
