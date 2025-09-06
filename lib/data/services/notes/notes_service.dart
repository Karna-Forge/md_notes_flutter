import 'package:markdown_notes/data/models/note.dart';
import 'package:markdown_notes/data/models/notes_filter.dart';
import 'package:markdown_notes/data/services/notes/i_notes_service.dart';
import 'package:markdown_notes/data/services/storage/i_notes_storage.dart';
import 'package:uuid/uuid.dart';

class NotesService implements INotesService {
  final INotesStorage _storage;
  final _uuid = const Uuid();

  // In-memory cache (optional; can be removed if you prefer stateless service)
  final List<Note> _cache = [];

  NotesService(this._storage);

  // --- Persistence ---
  @override
  Future<List<Note>> getAll() async {
    if (_cache.isEmpty) {
      _cache
        ..clear()
        ..addAll(await _storage.readAll());
    }
    return List.unmodifiable(_cache);
  }

  @override
  Future<void> saveAll(List<Note> notes) async {
    _cache
      ..clear()
      ..addAll(notes);
    await _storage.writeAll(_cache);
  }

  // --- Rules ---
  @override
  List<Note> applyFilter(List<Note> notes, NotesFilter filter) {
    final q = (filter.query ?? '').trim().toLowerCase();
    final filtered = notes.where((n) {
      final matchesArchived = filter.archived ? n.archived : !n.archived;
      final matchesQuery = q.isEmpty ||
          n.title.toLowerCase().contains(q) ||
          n.content.toLowerCase().contains(q);
      return matchesArchived && matchesQuery;
    }).toList();

    filtered.sort((a, b) {
      if (filter.pinnedFirst && a.pinned != b.pinned) {
        return a.pinned ? -1 : 1;
      }
      return b.updatedAt.compareTo(a.updatedAt);
    });

    return filtered;
  }

  @override
  Note createDraft({
    required String title,
    required String content,
    bool pinned = false,
    bool archived = false,
  }) {
    return Note.withDefaults(
      id: _uuid.v4(),
      title: title,
      content: content,
      pinned: pinned,
      archived: archived,
    );
  }

  @override
  Note applyUpdate(
    Note note, {
    String? title,
    String? content,
    bool? pinned,
    bool? archived,
  }) {
    return note.copyUpdating(
      title: title,
      content: content,
      pinned: pinned,
      archived: archived,
    );
  }

  @override
  Future<Note> getNote(String id) async {
    return _cache.firstWhere((item) => item.id == id);
  }
}
