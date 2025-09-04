import 'package:flutter/foundation.dart';
import 'package:markdown_notes/data/models/notes_filter.dart';
import 'package:markdown_notes/data/repositories/i_notes_repository.dart';
import 'package:markdown_notes/data/models/note.dart';

class NotesProvider extends ChangeNotifier {
  final INotesRepository _repo;

  // UI state
  String? _query;
  bool _archived = false;
  bool _pinnedFirst = true;

  List<Note> _visible = [];
  List<Note> get notes => _visible;

  NotesProvider(this._repo) {
    init();
  }

  String? get query => _query;
  bool get archived => _archived;
  bool get pinnedFirst => _pinnedFirst;

  NotesFilter get _filter => NotesFilter(
        query: _query,
        archived: _archived,
        pinnedFirst: _pinnedFirst,
      );

  Future<void> init() async {
    await refresh();
  }

  Future<void> refresh() async {
    _visible = await _repo.listNotes(_filter);
    notifyListeners();
  }

  // UI events
  void setQuery(String? q) {
    _query = (q?.isEmpty ?? true) ? null : q;
    refresh();
  }

  void toogleArchived() {
    _archived = !_archived;
    refresh();
  }

  void togglePinned() {
    _pinnedFirst = !_pinnedFirst;
    refresh();
  }

  Future<Note> create({required String title, required String content}) async {
    final n = await _repo.create(title: title, content: content);
    await refresh();
    return n;
  }

  Future<Note> createEmpty() async {
    final n = await _repo.create(title: "", content: "");
    await refresh();
    return n;
  }

  Future<void> update(Note note,
      {String? title, String? content, bool? pinned, bool? archived}) async {
    await _repo.update(note,
        title: title, content: content, pinned: pinned, archived: archived);
    await refresh();
  }

  Future<void> delete(Note note) async {
    await _repo.delete(note.id);
    await refresh();
  }
}
