import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown_notes/data/models/note.dart';
import 'package:markdown_notes/ui/home/viewmodels/notes_provider.dart';
import 'package:markdown_notes/ui/core/loacalization/app_localization.dart';
import 'package:markdown_notes/widgets/markdown_toolbar.dart';
import 'package:provider/provider.dart';

class EditorPage extends StatefulWidget {
  final String noteId;
  final bool isNew;
  final AppLocalization _localization;
  const EditorPage(this._localization,
      {super.key, required this.noteId, this.isNew = false});

  @override
  State<EditorPage> createState() => _EditorPageState();
}

class _EditorPageState extends State<EditorPage> {
  final _titleCtrl = TextEditingController();
  final _contentCtrl = TextEditingController();
  bool _preview = false;

  Note? _getNote(BuildContext context) {
    final provider = context.read<NotesProvider>();
    return provider.notes.firstWhere((n) => n.id == widget.noteId,
        orElse: () =>
            // fallback in case we navigated fast
            Note.withDefaults(id: widget.noteId, title: '', content: ''));
  }

  @override
  void initState() {
    super.initState();
    final note = _getNote(context);
    _titleCtrl.text = note?.title ?? '';
    _contentCtrl.text = note?.content ?? '';
  }

  void _save(BuildContext context) {
    final provider = context.read<NotesProvider>();
    final note = _getNote(context);
    if (note == null) return;
    provider.update(
      note,
      title: _titleCtrl.text.trim(),
      content: _contentCtrl.text,
    );
    if (widget.isNew &&
        (_titleCtrl.text.trim().isEmpty && _contentCtrl.text.trim().isEmpty)) {
      // If completely empty on first save, delete it
      provider.delete(note);
    }
  }

  @override
  void dispose() {
    _save(context);
    _titleCtrl.dispose();
    _contentCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<NotesProvider>();
    final note = provider.notes.firstWhere((n) => n.id == widget.noteId,
        orElse: () =>
            Note.withDefaults(id: widget.noteId, title: '', content: ''));

    return Scaffold(
      appBar: AppBar(
        title: Text(note.title.isEmpty
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
            tooltip: note.pinned
                ? widget._localization.unpin
                : widget._localization.pin,
            onPressed: () => provider.update(note, pinned: !note.pinned),
            icon: Icon(note.pinned ? Icons.push_pin : Icons.push_pin_outlined),
          ),
          IconButton(
            tooltip: note.archived
                ? widget._localization.unarchive
                : widget._localization.archive,
            onPressed: () => provider.update(note, archived: !note.archived),
            icon:
                Icon(note.archived ? Icons.unarchive : Icons.archive_outlined),
          ),
          IconButton(
            tooltip: widget._localization.delete,
            onPressed: () {
              provider.delete(note);
              Navigator.of(context).maybePop();
            },
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
              onChanged: (_) => _save(context),
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                hintText: widget._localization.titleHint,
                border: const OutlineInputBorder(),
              ),
            ),
          ),
          MarkdownToolbar(widget._localization,
              controller: _contentCtrl, onChanged: () => _save(context)),
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
                      onChanged: (_) => _save(context),
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
