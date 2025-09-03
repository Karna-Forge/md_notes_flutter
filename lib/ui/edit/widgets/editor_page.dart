import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown_notes/ui/core/ui/models/note.dart';
import 'package:markdown_notes/ui/home/viewmodels/notes_provider.dart';
import 'package:markdown_notes/widgets/markdown_toolbar.dart';
import 'package:provider/provider.dart';

class EditorPage extends StatefulWidget {
  final String noteId;
  final bool isNew;
  const EditorPage({super.key, required this.noteId, this.isNew = false});

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
            Note(id: widget.noteId, title: '', content: ''));
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
        orElse: () => Note(id: widget.noteId, title: '', content: ''));

    return Scaffold(
      appBar: AppBar(
        title: Text(note.title.isEmpty ? 'New note' : 'Edit note'),
        actions: [
          IconButton(
            tooltip: _preview ? 'Edit' : 'Preview',
            onPressed: () => setState(() => _preview = !_preview),
            icon: Icon(_preview ? Icons.edit : Icons.preview),
          ),
          IconButton(
            tooltip: note.pinned ? 'Unpin' : 'Pin',
            onPressed: () => provider.update(note, pinned: !note.pinned),
            icon: Icon(note.pinned ? Icons.push_pin : Icons.push_pin_outlined),
          ),
          IconButton(
            tooltip: note.archived ? 'Unarchive' : 'Archive',
            onPressed: () => provider.update(note, archived: !note.archived),
            icon:
                Icon(note.archived ? Icons.unarchive : Icons.archive_outlined),
          ),
          IconButton(
            tooltip: 'Delete',
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
              decoration: const InputDecoration(
                hintText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          MarkdownToolbar(
              controller: _contentCtrl, onChanged: () => _save(context)),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: _preview
                  ? Markdown(
                      data: _contentCtrl.text.isEmpty
                          ? '_Nothing to preview yet…_\n\nTry **bold**, *italic*, `code`, lists, and more.'
                          : _contentCtrl.text,
                    )
                  : TextField(
                      controller: _contentCtrl,
                      onChanged: (_) => _save(context),
                      maxLines: null,
                      expands: true,
                      keyboardType: TextInputType.multiline,
                      decoration: const InputDecoration(
                        hintText: 'Write your note in Markdown…',
                        border: OutlineInputBorder(),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
