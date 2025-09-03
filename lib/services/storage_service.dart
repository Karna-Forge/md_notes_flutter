import 'dart:io';
import 'package:markdown_notes/ui/core/ui/models/note.dart';
import 'package:path_provider/path_provider.dart';

class StorageService {
  static const _fileName = 'notes.json';

  Future<File> _getFile() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$_fileName');
    if (!await file.exists()) {
      await file.writeAsString(Note.encodeList(const []));
    }
    return file;
  }

  Future<List<Note>> loadNotes() async {
    try {
      final file = await _getFile();
      final raw = await file.readAsString();
      return Note.decodeList(raw);
    } catch (_) {
      return [];
    }
  }

  Future<void> saveNotes(List<Note> notes) async {
    final file = await _getFile();
    await file.writeAsString(Note.encodeList(notes));
  }
}
