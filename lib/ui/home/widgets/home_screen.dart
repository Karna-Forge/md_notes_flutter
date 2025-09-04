import 'package:flutter/material.dart';
import 'package:markdown_notes/ui/edit/widgets/editor_page.dart';
import 'package:markdown_notes/ui/home/viewmodels/notes_provider.dart';
import 'package:markdown_notes/widgets/note_list_item.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<NotesProvider>();
    final notes = provider.notes;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Markdown Notes'),
        actions: [
          IconButton(
            tooltip: provider.archived ? 'Show active' : 'Show archived',
            onPressed: () => provider.toogleArchived(),
            icon: Icon(provider.archived
                ? Icons.unarchive
                : Icons.inventory_2_outlined),
          ),
          IconButton(
            tooltip: 'Toggle pin sort',
            onPressed: () => provider.togglePinned(),
            icon: const Icon(Icons.push_pin),
          ),
          const SizedBox(width: 8),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(64),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: TextField(
              onChanged: provider.setQuery,
              decoration: InputDecoration(
                hintText: 'Search notes…',
                prefixIcon: const Icon(Icons.search),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
        ),
      ),
      body: notes.isEmpty
          ? const _EmptyState()
          : ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: notes.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, i) => NoteListItem(
                note: notes[i],
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => EditorPage(noteId: notes[i].id),
                  ));
                },
              ),
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final created = await context.read<NotesProvider>().createEmpty();
          Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => EditorPage(noteId: created.id, isNew: true),
          ));
        },
        icon: const Icon(Icons.add),
        label: const Text('New note'),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.note_alt_outlined, size: 64),
            const SizedBox(height: 12),
            Text('No notes yet', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 6),
            Text(
              'Tap "New note" to create your first Markdown note.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
