import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:markdown_notes/data/repositories/i_notes_repository.dart';
import 'package:markdown_notes/data/models/note.dart';

class NotesProvider extends ChangeNotifier {
  final INotesRepository _repo;
  NotesProvider(this._repo);

  UnmodifiableListView<Note> get notes => _repo.notes;
  bool get showArchived => _repo.showArchived;
  String get query => _repo.query;

  Future<void> load() async {
    await _repo.load();
    notifyListeners();
  }

  Future<void> persist() => _repo.persist();

  void setQuery(String q) {
    _repo.setQuery(q);
    notifyListeners();
  }

  void toggleArchivedView() {
    _repo.toggleArchivedView();
    notifyListeners();
  }

  void toggleSortPinnedFirst() {
    _repo.toggleSortPinnedFirst();
    notifyListeners();
  }

  Note createEmpty() {
    final note = _repo.createEmpty();
    notifyListeners();
    return note;
  }

  void update(Note note,
      {String? title, String? content, bool? pinned, bool? archived}) {
    _repo.update(note,
        title: title, content: content, pinned: pinned, archived: archived);
    notifyListeners();
    _repo.persist();
  }

  void delete(Note note) {
    _repo.delete(note);
    notifyListeners();
    _repo.persist();
  }
}
