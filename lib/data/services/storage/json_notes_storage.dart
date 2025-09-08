import 'package:markdown_notes/data/models/note.dart';
import 'package:markdown_notes/data/services/storage/i_notes_storage.dart';
import 'package:markdown_notes/data/services/storage/storage_service.dart';

class JsonNotesStorage implements INotesStorage {
  final StorageService _storage;
  JsonNotesStorage(this._storage);

  @override
  Future<List<Note>> readAll() => _storage.loadNotes();

  @override
  Future<void> writeAll(List<Note> notes) => _storage.saveNotes(notes);
}
