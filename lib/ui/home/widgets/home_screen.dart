import 'package:flutter/material.dart';
import 'package:markdown_notes/routing/models/editor_screen_args.dart';
import 'package:markdown_notes/ui/core/loacalization/app_localization.dart';
import 'package:markdown_notes/ui/home/viewmodels/home_viewmodel.dart';
import 'package:markdown_notes/ui/home/viewmodels/notes_provider.dart';
import 'package:markdown_notes/widgets/note_list_item.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen(this._localization, {super.key});

  final AppLocalization _localization;

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewModel>();
    final notes = viewModel.notes;

    return Scaffold(
      appBar: AppBar(
        title: Text(_localization.markDownNotesTitle),
        actions: [
          IconButton(
            tooltip: viewModel.archived
                ? _localization.activeToolTipMsg
                : _localization.archiveToolTipMsg,
            onPressed: () => viewModel.toogleArchived(),
            icon: Icon(viewModel.archived
                ? Icons.unarchive
                : Icons.inventory_2_outlined),
          ),
          IconButton(
            tooltip: _localization.pinSortToolTipMsg,
            onPressed: () => viewModel.togglePinned(),
            icon: const Icon(Icons.push_pin),
          ),
          const SizedBox(width: 8),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(64),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: TextField(
              onChanged: viewModel.setQuery,
              decoration: InputDecoration(
                hintText: _localization.searchHint,
                prefixIcon: const Icon(Icons.search),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
        ),
      ),
      body: notes.isEmpty
          ? _EmptyState(_localization)
          : ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: notes.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, i) => NoteListItem(
                _localization,
                note: notes[i],
                onTap: () =>
                    viewModel.gotoEditorPage(EditorScreenArgs(id: notes[i].id)),
              ),
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final created = await context.read<NotesProvider>().createEmpty();
          viewModel
              .gotoEditorPage(EditorScreenArgs(id: created.id, isNew: true));
        },
        icon: const Icon(Icons.add),
        label: Text(_localization.newNote),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState(this._localization);
  final AppLocalization _localization;

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
            Text(_localization.emptyNotesTitle,
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 6),
            Text(
              _localization.emptyNotesSubtitle,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
