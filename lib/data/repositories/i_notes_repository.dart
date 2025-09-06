import 'package:markdown_notes/data/models/note.dart';
import 'package:markdown_notes/data/models/notes_filter.dart';

abstract class INotesRepository {
  Future<Note> getNote(String id);
  Future<List<Note>> listNotes(NotesFilter filter);

  Future<Note> create({
    required String title,
    required String content,
    bool pinned = false,
    bool archived = false,
  });

  Future<Note> update(
    Note note, {
    String? title,
    String? content,
    bool? pinned,
    bool? archived,
  });

  Future<void> delete(String id);

  Future<void> persist(); // optional no-op for some backends
}
