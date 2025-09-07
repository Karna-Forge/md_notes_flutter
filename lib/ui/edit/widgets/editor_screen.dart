import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown_notes/ui/edit/viewmodels/editor_screen_viewmodel.dart';
import 'package:markdown_notes/ui/core/loacalization/app_localization.dart';
import 'package:markdown_notes/widgets/markdown_toolbar.dart';
import 'package:provider/provider.dart';

class EditorScreen extends StatefulWidget {
  final String noteId;
  final bool isNew;
  final AppLocalization _localization;
  const EditorScreen(this._localization,
      {super.key, required this.noteId, this.isNew = false});

  @override
  State<EditorScreen> createState() => _EditorScreenState();
}

class _EditorScreenState extends State<EditorScreen> {
  final _titleCtrl = TextEditingController();
  final _contentCtrl = TextEditingController();
  bool _preview = false;

  @override
  void dispose() {
    _titleCtrl.dispose();
    _contentCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<EditorScreenViewmodel>();
    _titleCtrl.text = viewModel.title;
    _contentCtrl.text = viewModel.content;

    return Scaffold(
      appBar: AppBar(
        title: Text(viewModel.title.isEmpty
            ? widget._localization.newNoteTitle
            : widget._localization.editNoteTitle),
        actions: [
          IconButton(
            tooltip: _preview
                ? widget._localization.edit
                : widget._localization.preview,
            onPressed: () => setState(() => _preview = !_preview),
            icon: Icon(_preview ? Icons.edit : Icons.preview),
          ),
          IconButton(
            tooltip: viewModel.isPinned
                ? widget._localization.unpin
                : widget._localization.pin,
            onPressed: viewModel.togglePin,
            icon: Icon(
                viewModel.isPinned ? Icons.push_pin : Icons.push_pin_outlined),
          ),
          IconButton(
            tooltip: viewModel.isArchived
                ? widget._localization.unarchive
                : widget._localization.archive,
            onPressed: viewModel.toogleArchived,
            icon: Icon(viewModel.isArchived
                ? Icons.unarchive
                : Icons.archive_outlined),
          ),
          IconButton(
            tooltip: widget._localization.delete,
            onPressed: viewModel.delete,
            icon: const Icon(Icons.delete_outline),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: TextField(
              controller: _titleCtrl,
              onChanged: viewModel.saveTitle,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                hintText: widget._localization.titleHint,
                border: const OutlineInputBorder(),
              ),
            ),
          ),
          MarkdownToolbar(widget._localization,
              controller: _contentCtrl,
              onChanged: () => viewModel.saveContent(_contentCtrl.text)),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: _preview
                  ? Markdown(
                      data: _contentCtrl.text.isEmpty
                          ? widget._localization.previewPlaceholder
                          : _contentCtrl.text,
                    )
                  : TextField(
                      controller: _contentCtrl,
                      onChanged: viewModel.saveContent,
                      maxLines: null,
                      expands: true,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        hintText: widget._localization.contentHint,
                        border: const OutlineInputBorder(),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
