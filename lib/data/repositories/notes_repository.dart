import 'dart:collection';

import 'package:markdown_notes/data/models/note.dart';
import 'package:markdown_notes/data/repositories/i_notes_repository.dart';
import 'package:markdown_notes/data/services/notes/notes_service.dart';

class NotesRepository implements INotesRepository {
  final NotesService _svc;
  NotesRepository(this._svc);

  @override
  UnmodifiableListView<Note> get notes => _svc.notes;
  @override
  bool get showArchived => _svc.showArchived;
  @override
  String get query => _svc.query;

  @override
  Future<void> load() => _svc.load();

  @override
  Future<void> persist() => _svc.persist();

  @override
  void setQuery(String q) => _svc.setQuery(q);

  @override
  void toggleArchivedView() => _svc.toggleArchivedView();

  @override
  void toggleSortPinnedFirst() => _svc.toggleSortPinnedFirst();

  @override
  Note createEmpty() => _svc.createEmpty();

  @override
  void update(Note note,
          {String? title, String? content, bool? pinned, bool? archived}) =>
      _svc.update(note,
          title: title, content: content, pinned: pinned, archived: archived);

  @override
  void delete(Note note) => _svc.delete(note);
}
