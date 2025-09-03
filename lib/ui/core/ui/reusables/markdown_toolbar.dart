import 'package:flutter/material.dart';

class MarkdownToolbar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback? onChanged;
  const MarkdownToolbar({super.key, required this.controller, this.onChanged});

  void _wrapSelection(String left, String right) {
    final text = controller.text;
    final sel = controller.selection;
    final start = sel.start;
    final end = sel.end;
    if (start < 0 || end < 0) return;

    final selected = text.substring(start, end);
    final newText = text.replaceRange(start, end, '$left$selected$right');
    controller.value = controller.value.copyWith(
      text: newText,
      selection: TextSelection.collapsed(
          offset: start + left.length + selected.length + right.length),
      composing: TextRange.empty,
    );
    onChanged?.call();
  }

  void _insertAtLineStart(String prefix) {
    final text = controller.text;
    final sel = controller.selection;
    if (sel.start < 0) return;

    final lines = text.split('\n');
    int charCount = 0;
    for (int i = 0; i < lines.length; i++) {
      final line = lines[i];
      final nextCount = charCount + line.length + 1; // +1 for newline
      if (sel.start <= nextCount) {
        final insertPos = charCount;
        final newText = text.replaceRange(insertPos, insertPos, '$prefix ');
        controller.value = controller.value.copyWith(
          text: newText,
          selection:
              TextSelection.collapsed(offset: sel.start + prefix.length + 1),
        );
        onChanged?.call();
        return;
      }
      charCount = nextCount;
    }
    // If no line found, append
    controller.text = '$text\n$prefix ';
    controller.selection =
        TextSelection.collapsed(offset: controller.text.length);
    onChanged?.call();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.surfaceContainer,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Wrap(
          spacing: 8,
          children: [
            _ToolButton(
                icon: Icons.format_bold,
                label: 'Bold',
                onPressed: () => _wrapSelection('**', '**')),
            _ToolButton(
                icon: Icons.format_italic,
                label: 'Italic',
                onPressed: () => _wrapSelection('*', '*')),
            _ToolButton(
                icon: Icons.code,
                label: 'Code',
                onPressed: () => _wrapSelection('`', '`')),
            _ToolButton(
                icon: Icons.link,
                label: 'Link',
                onPressed: () {
                  final text = controller.text;
                  final sel = controller.selection;
                  final start = sel.start;
                  final end = sel.end;
                  if (start < 0 || end < 0) return;
                  final selected = text.substring(start, end);
                  final linkText = selected.isEmpty ? 'title' : selected;
                  final insert = '[$linkText](https://)';
                  final newText = text.replaceRange(start, end, insert);
                  controller.value = controller.value.copyWith(
                    text: newText,
                    selection:
                        TextSelection.collapsed(offset: start + insert.length),
                  );
                  onChanged?.call();
                }),
            _ToolButton(
                icon: Icons.title,
                label: 'H1',
                onPressed: () => _insertAtLineStart('#')),
            _ToolButton(
                icon: Icons.title,
                label: 'H2',
                onPressed: () => _insertAtLineStart('##')),
            _ToolButton(
                icon: Icons.format_list_bulleted,
                label: '• List',
                onPressed: () => _insertAtLineStart('-')),
            _ToolButton(
                icon: Icons.format_list_numbered,
                label: '1. List',
                onPressed: () => _insertAtLineStart('1.')),
            _ToolButton(
                icon: Icons.horizontal_rule,
                label: 'Rule',
                onPressed: () {
                  final t = controller.text;
                  final sel = controller.selection;
                  final insert = '\n\n---\n\n';
                  final newText = t.replaceRange(
                    sel.start.clamp(0, t.length),
                    sel.end.clamp(0, t.length),
                    insert,
                  );
                  controller.value = controller.value.copyWith(
                    text: newText,
                    selection: TextSelection.collapsed(
                        offset: (sel.start + insert.length)
                            .clamp(0, newText.length)),
                  );
                  onChanged?.call();
                }),
          ],
        ),
      ),
    );
  }
}

class _ToolButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  const _ToolButton(
      {required this.icon, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      icon: Icon(icon, size: 18),
      label: Text(label),
      onPressed: onPressed,
    );
  }
}
