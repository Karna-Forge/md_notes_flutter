import 'package:markdown_notes/data/models/note.dart';
import 'package:markdown_notes/data/models/notes_filter.dart';
import 'package:markdown_notes/data/utils/result.dart';

abstract class INotesRepository {
  Future<Result<Note>> getNote(String id);
  Future<Result<List<Note>>> listNotes(NotesFilter filter);

  Future<Result<Note>> create({
    required String title,
    required String content,
    bool pinned = false,
    bool archived = false,
  });

  Future<Result<Note>> update(
    Note note, {
    String? title,
    String? content,
    bool? pinned,
    bool? archived,
  });

  Future<Result<void>> delete(String id);

  Future<Result<void>> persist(); // optional no-op for some backends
}
