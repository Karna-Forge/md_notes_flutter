import 'package:markdown_notes/data/models/note.dart';
import 'package:markdown_notes/data/models/notes_filter.dart';
import 'package:markdown_notes/data/utils/result.dart';

abstract class INotesService {
  Future<Result<List<Note>>> getAll();
  Future<Result<Note>> getNote(String id);
  Future<Result<void>> saveAll(List<Note> notes);

  List<Note> applyFilter(List<Note> notes, NotesFilter filter);

  Note createDraft({
    required String title,
    required String content,
    bool pinned = false,
    bool archived = false,
  });

  Note applyUpdate(
    Note note, {
    String? title,
    String? content,
    bool? pinned,
    bool? archived,
  });
}
