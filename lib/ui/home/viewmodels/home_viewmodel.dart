import 'package:markdown_notes/data/models/note.dart';
import 'package:markdown_notes/data/models/notes_filter.dart';
import 'package:markdown_notes/data/repositories/i_notes_repository.dart';
import 'package:markdown_notes/data/services/navigation/i_navigation_service.dart';
import 'package:markdown_notes/routing/models/editor_screen_args.dart';
import 'package:markdown_notes/ui/core/viewmodel.dart/base_viewmodel.dart';

class HomeViewModel extends BaseViewModel {
  final INavigationService _service;
  final INotesRepository _repo;

  List<Note> _notes = [];
  List<Note> get notes => _notes;

  String? _query;
  String? get query => _query;

  bool _archived = false;
  bool get archived => _archived;

  bool _pinnedFirst = true;
  bool get pinnedFirst => _pinnedFirst;

  NotesFilter get _filter => NotesFilter(
        query: _query,
        archived: _archived,
        pinnedFirst: _pinnedFirst,
      );

  HomeViewModel(this._service, this._repo) {
    init();
  }

  @override
  Future<void> init() async {
    await _getNotes();
  }

  Future<void> _getNotes() async {
    _notes = await _repo.listNotes(_filter);
    notifyListeners();
  }

  void setQuery(String? q) {
    _query = (q?.isEmpty ?? true) ? null : q;
    _getNotes();
  }

  void toogleArchived() {
    _archived = !_archived;
    _getNotes();
  }

  void togglePinned() {
    _pinnedFirst = !_pinnedFirst;
    _getNotes();
  }

  Future<void> gotoEditorPage(EditorScreenArgs args) async {
    _service.gotoEditorPage(args);
  }

  Future<Note> create({required String title, required String content}) async {
    final n = await _repo.create(title: title, content: content);
    await _getNotes();
    return n;
  }

  Future<void> createAndEditNewNotes() async {
    final newNote = await _createEmpty();
    gotoEditorPage(EditorScreenArgs(id: newNote.id, isNew: true));
  }

  Future<Note> _createEmpty() async {
    final n = await _repo.create(title: "", content: "");
    await _getNotes();
    return n;
  }

  Future<void> update(Note note,
      {String? title, String? content, bool? pinned, bool? archived}) async {
    await _repo.update(note,
        title: title, content: content, pinned: pinned, archived: archived);
    await _getNotes();
  }
}
