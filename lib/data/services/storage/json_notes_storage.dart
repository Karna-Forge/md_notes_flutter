import 'dart:io';

import 'package:markdown_notes/data/models/note.dart';
import 'package:markdown_notes/data/services/storage/i_notes_storage.dart';
import 'package:path_provider/path_provider.dart';

class JsonNotesStorage implements INotesStorage {
  JsonNotesStorage();

  @override
  Future<List<Note>> readAll() => _loadNotes();

  @override
  Future<void> writeAll(List<Note> notes) => _saveNotes(notes);

  Future<File> _getFile() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$_fileName');
    if (!await file.exists()) {
      await file.writeAsString(Note.encodeList(const []));
    }
    return file;
  }

  Future<List<Note>> _loadNotes() async {
    try {
      final file = await _getFile();
      final raw = await file.readAsString();
      return Note.decodeList(raw);
    } catch (_) {
      return [];
    }
  }

  Future<void> _saveNotes(List<Note> notes) async {
    final file = await _getFile();
    await file.writeAsString(Note.encodeList(notes));
  }

  static const _fileName = 'notes.json';
}
