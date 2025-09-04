// lib/services/notes_service.dart
import 'dart:collection';
import 'package:markdown_notes/data/models/note.dart';
import 'package:markdown_notes/data/services/storage/storage_service.dart';
import 'package:markdown_notes/data/utils/ux_simplification_utils.dart';
import 'package:uuid/uuid.dart';

class NotesService {
  final StorageService _storage;
  final _uuid = const Uuid();

  final List<Note> _notes = [];
  String _query = '';
  bool _showArchived = false;
  bool _sortPinnedFirst = true;

  NotesService(this._storage);

  // ---- Derived view ----
  UnmodifiableListView<Note> get notes {
    final q = _query.trim().toLowerCase();
    final filtered = _notes.where((n) {
      final matchesArchived = _showArchived ? n.archived : !n.archived;
      final matchesQuery = q.isEmpty ||
          n.title.toLowerCase().contains(q) ||
          n.content.toLowerCase().contains(q);
      return matchesArchived && matchesQuery;
    }).toList();

    filtered.sort((a, b) {
      if (_sortPinnedFirst && a.pinned != b.pinned) return a.pinned ? -1 : 1;
      return b.updatedAt.compareTo(a.updatedAt);
    });

    return UnmodifiableListView(filtered);
  }

  bool get showArchived => _showArchived;
  String get query => _query;

  // ---- UI state setters ----
  void setQuery(String q) => _query = q;
  void toggleArchivedView() => _showArchived = !_showArchived;
  void toggleSortPinnedFirst() => _sortPinnedFirst = !_sortPinnedFirst;

  // ---- CRUD (mutate in-memory list) ----
  Future<void> load() async {
    final loaded = await _storage.loadNotes();
    _notes
      ..clear()
      ..addAll(loaded);
  }

  Future<void> persist() => _storage.saveNotes(_notes);

  Note createEmpty() {
    final note = Note.withDefaults(id: _uuid.v4(), title: '', content: '');
    _notes.add(note);
    return note;
  }

  void update(
    Note note, {
    String? title,
    String? content,
    bool? pinned,
    bool? archived,
  }) {
    final i = _notes.indexWhere((n) => n.id == note.id);
    if (i == -1) return;
    _notes[i] = note.copyUpdating(
      title: title,
      content: content,
      pinned: pinned,
      archived: archived,
    );
  }

  void delete(Note note) {
    _notes.removeWhere((n) => n.id == note.id);
  }
}
