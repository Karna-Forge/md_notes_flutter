import 'package:markdown_notes/data/models/note.dart';
import 'package:markdown_notes/data/models/notes_filter.dart';
import 'package:markdown_notes/data/repositories/i_notes_repository.dart';
import 'package:markdown_notes/data/services/notes/i_notes_service.dart';

class NotesRepository implements INotesRepository {
  final INotesService _svc;
  NotesRepository(this._svc);

  @override
  Future<List<Note>> listNotes(NotesFilter filter) async {
    final all = await _svc.getAll();
    return _svc.applyFilter(all, filter);
  }

  @override
  Future<Note> create({
    required String title,
    required String content,
    bool pinned = false,
    bool archived = false,
  }) async {
    final draft = _svc.createDraft(
      title: title,
      content: content,
      pinned: pinned,
      archived: archived,
    );
    final all = await _svc.getAll();
    final updated = [...all, draft];
    await _svc.saveAll(updated);
    return draft;
  }

  @override
  Future<Note> update(
    Note note, {
    String? title,
    String? content,
    bool? pinned,
    bool? archived,
  }) async {
    final all = await _svc.getAll();
    final idx = all.indexWhere((n) => n.id == note.id);
    if (idx == -1) return note; // or throw
    final patched = _svc.applyUpdate(note,
        title: title, content: content, pinned: pinned, archived: archived);
    final copy = [...all]..[idx] = patched;
    await _svc.saveAll(copy);
    return patched;
  }

  @override
  Future<void> delete(String id) async {
    final all = await _svc.getAll();
    final copy = all.where((n) => n.id != id).toList(growable: false);
    await _svc.saveAll(copy);
  }

  @override
  Future<void> persist() async {
    // With write-through service this can be a no-op, but keep for API symmetry
    final all = await _svc.getAll();
    await _svc.saveAll(all);
  }

  @override
  Future<Note> getNote(String id) async {
    return _svc.getNote(id);
  }
}
