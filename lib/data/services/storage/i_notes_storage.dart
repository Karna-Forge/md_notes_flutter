import 'package:markdown_notes/data/models/note.dart';

abstract class INotesStorage {
  Future<List<Note>> readAll();
  Future<void> writeAll(List<Note> notes);
}
