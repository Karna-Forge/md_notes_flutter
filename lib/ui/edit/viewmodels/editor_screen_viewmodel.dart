import 'package:markdown_notes/data/models/note.dart';
import 'package:markdown_notes/data/repositories/i_notes_repository.dart';
import 'package:markdown_notes/data/services/navigation/i_navigation_service.dart';
import 'package:markdown_notes/routing/models/editor_screen_args.dart';
import 'package:markdown_notes/ui/core/viewmodel.dart/base_viewmodel.dart';

class EditorScreenViewmodel extends BaseViewModel {
  final INavigationService _service;
  final INotesRepository _repo;
  final EditorScreenArgs _args;
  EditorScreenViewmodel(this._service, this._repo, this._args) {
    init();
  }

  late Note _note;
  bool _shouldRefetch = false;
  bool get shouldRefetch => _shouldRefetch;

  void _markShouldRefetch() {
    _shouldRefetch = true;
  }

  String _title = '';
  String get title => _title;

  bool _isArchived = false;
  bool get isArchived => _isArchived;

  bool _isPinned = false;
  bool get isPinned => _isPinned;

  String _content = '';
  String get content => _content;

  @override
  Future<void> init() async {
    showLoading();
    await getNote();
    await _updateNotesInfo();
    stopLoading();
  }

  Future<void> getNote() async {
    final res = await _repo.getNote(_args.id);
    if (res.isSuccess) {
      _note = res.data!;
    }
  }

  Future<void> _updateNotesInfo() async {
    _title = _note.title;
    _content = _note.content;
    _isArchived = _note.archived;
    _isPinned = _note.pinned;
  }

  Future<void> togglePin() async {
    _isPinned = !_isPinned;
    _markShouldRefetch();
    _update(_note, pinned: _isPinned);
    notifyChanges();
  }

  Future<void> toogleArchived() async {
    _isArchived = !_isArchived;
    _markShouldRefetch();
    _update(_note, archived: _isArchived);
    notifyChanges();
  }

  Future<void> saveContent(String content) async {
    _content = content;
    _markShouldRefetch();
    _update(_note, content: _content);
    notifyChanges();
  }

  Future<void> saveTitle(String title) async {
    _title = title;
    _markShouldRefetch();
    _update(_note, title: title);
    notifyChanges();
  }

  Future<void> delete() async {
    await _repo.delete(_args.id);
    _markShouldRefetch();
    goBack(refetch: true);
  }

  Future<void> _update(Note note,
      {String? title, String? content, bool? pinned, bool? archived}) async {
    final res = await _repo.update(note,
        title: title, content: content, pinned: pinned, archived: archived);
    if (res.isSuccess) {
      await getNote();
    }
  }

  Future<void> goBack({bool refetch = false}) async {
    await _service.goBack(refetch);
  }
}
