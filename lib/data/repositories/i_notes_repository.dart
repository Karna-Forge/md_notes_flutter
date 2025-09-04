import 'dart:collection';

import 'package:markdown_notes/data/models/note.dart';

abstract class INotesRepository {
  UnmodifiableListView<Note> get notes;
  bool get showArchived;
  String get query;

  Future<void> load();
  Future<void> persist();

  void setQuery(String q);
  void toggleArchivedView();
  void toggleSortPinnedFirst();

  Note createEmpty();
  void update(Note note,
      {String? title, String? content, bool? pinned, bool? archived});
  void delete(Note note);
}
