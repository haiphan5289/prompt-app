import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CopyButton extends StatefulWidget {
  const CopyButton({super.key, required this.text});

  final String text;

  @override
  State<CopyButton> createState() => _CopyButtonState();
}

class _CopyButtonState extends State<CopyButton> {
  bool _copied = false;

  Future<void> _copy() async {
    await Clipboard.setData(ClipboardData(text: widget.text));
    setState(() => _copied = true);
    await Future<void>.delayed(const Duration(seconds: 2));
    if (mounted) setState(() => _copied = false);
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: _copy,
      icon: Icon(
        _copied ? Icons.check : Icons.copy_outlined,
        color: _copied
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.onSurfaceVariant,
      ),
      tooltip: _copied ? 'Copied!' : 'Copy',
    );
  }
}
