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

  void _setInitialInfo(EditorScreenViewmodel viewModel) {
    if (_titleCtrl.text != viewModel.title) {
      _titleCtrl.text = viewModel.title;
    }
    if (_contentCtrl.text != viewModel.content) {
      _contentCtrl.text = viewModel.content;
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<EditorScreenViewmodel>();
    _setInitialInfo(viewModel);

    Future<void> _openRenameDialog() async {
      _titleCtrl.text = viewModel.title;
      await showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(widget._localization.editNoteTitle),
          content: TextField(
            controller: _titleCtrl,
            autofocus: true,
            textInputAction: TextInputAction.done,
            onSubmitted: (v) {
              viewModel.saveTitle(v);
              Navigator.of(ctx).pop();
            },
            decoration: InputDecoration(
              hintText: widget._localization.titleHint,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                viewModel.saveTitle(_titleCtrl.text);
                Navigator.of(ctx).pop();
              },
              child: const Text('Save'),
            ),
          ],
        ),
      );
    }

    return WillPopScope(
      onWillPop: () async {
        await viewModel.goBack(refetch: viewModel.shouldRefetch);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: InkWell(
            onTap: _openRenameDialog,
            child: Text(
              viewModel.title.isEmpty
                  ? widget._localization.untitled
                  : viewModel.title,
              overflow: TextOverflow.ellipsis,
            ),
          ),
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
              icon: Icon(viewModel.isPinned
                  ? Icons.push_pin
                  : Icons.push_pin_outlined),
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
            // Title moved to AppBar; tap title to rename
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
      ),
    );
  }
}
