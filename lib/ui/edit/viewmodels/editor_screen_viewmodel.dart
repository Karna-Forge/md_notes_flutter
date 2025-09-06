import 'package:markdown_notes/data/models/note.dart';
import 'package:markdown_notes/data/repositories/i_notes_repository.dart';
import 'package:markdown_notes/data/services/navigation/i_navigation_service.dart';
import 'package:markdown_notes/routing/models/editor_screen_args.dart';
import 'package:markdown_notes/ui/core/viewmodel.dart/base_viewmodel.dart';

class EditorScreenViewmodel extends BaseViewModel {
  final INavigationService _service;
  final INotesRepository _repo;
  final EditorScreenArgs _args;
  EditorScreenViewmodel(this._service, this._repo, this._args);

  late Note _note;

  String get title => _note.title;

  bool _isArchived = false;
  bool get iaArchived => _isArchived;

  bool _isPinned = false;
  bool get iaPinned => _isPinned;

  String _content = '';
  String get content => _content;

  @override
  Future<void> init() async {
    await getNote();
    updateNotesInfo();
  }

  Future<void> getNote() async {
    await _repo.getNote(_args.id);
  }

  Future<void> updateNotesInfo() async {
    _content = _note.content;
    _isArchived = _note.archived;
    _isPinned = _note.pinned;
  }

  Future<void> togglePin() async {
    _isPinned = !_isPinned;
    _update(_note, pinned: _isPinned);
    notifyChanges();
  }

  Future<void> toogleArchived() async {
    _isArchived = !_isArchived;
    _update(_note, archived: _isArchived);
    notifyChanges();
  }

  Future<void> delete(Note note) async {
    await _repo.delete(note.id);
    goBack();
  }

  Future<void> _update(Note note,
      {String? title, String? content, bool? pinned, bool? archived}) async {
    await _repo.update(note,
        title: title, content: content, pinned: pinned, archived: archived);
    await getNote();
  }

  Future<void> goBack() async {
    await _service.goBack();
  }
}
