import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:markdown_notes/data/utils/ux_simplification_utils.dart';
import 'package:markdown_notes/services/storage_service.dart';
import 'package:markdown_notes/data/models/note.dart';
import 'package:uuid/uuid.dart';

class NotesProvider extends ChangeNotifier {
  final StorageService _storage = StorageService();
  final Uuid _uuid = const Uuid();

  final List<Note> _notes = [];
  String _query = '';
  bool _showArchived = false;
  bool _sortPinnedFirst = true;

  UnmodifiableListView<Note> get notes {
    final filtered = _notes.where((n) {
      final matchesArchived = _showArchived ? n.archived : !n.archived;
      final q = _query.trim().toLowerCase();
      final matchesQuery = q.isEmpty ||
          n.title.toLowerCase().contains(q) ||
          n.content.toLowerCase().contains(q);
      return matchesArchived && matchesQuery;
    }).toList();

    filtered.sort((a, b) {
      if (_sortPinnedFirst) {
        if (a.pinned != b.pinned) return a.pinned ? -1 : 1;
      }
      return b.updatedAt.compareTo(a.updatedAt);
    });

    return UnmodifiableListView(filtered);
  }

  bool get showArchived => _showArchived;
  String get query => _query;

  Future<void> load() async {
    final loaded = await _storage.loadNotes();
    _notes
      ..clear()
      ..addAll(loaded);
    notifyListeners();
  }

  Future<void> persist() async {
    await _storage.saveNotes(_notes);
  }

  void setQuery(String q) {
    _query = q;
    notifyListeners();
  }

  void toggleArchivedView() {
    _showArchived = !_showArchived;
    notifyListeners();
  }

  void toggleSortPinnedFirst() {
    _sortPinnedFirst = !_sortPinnedFirst;
    notifyListeners();
  }

  Note createEmpty() {
    final note = Note.withDefaults(id: _uuid.v4(), title: '', content: '');
    _notes.add(note);
    notifyListeners();
    return note;
  }

  void update(Note note,
      {String? title, String? content, bool? pinned, bool? archived}) {
    final idx = _notes.indexWhere((n) => n.id == note.id);
    if (idx == -1) return;
    final updated = note.copyUpdating(
      title: title,
      content: content,
      pinned: pinned,
      archived: archived,
    );
    _notes[idx] = updated;
    notifyListeners();
    persist();
  }

  void delete(Note note) {
    _notes.removeWhere((n) => n.id == note.id);
    notifyListeners();
    persist();
  }
}
