import 'package:markdown_notes/data/models/note.dart';
import 'package:markdown_notes/data/models/notes_filter.dart';
import 'package:markdown_notes/data/repositories/i_notes_repository.dart';
import 'package:markdown_notes/data/services/notes/i_notes_service.dart';
import 'package:markdown_notes/data/utils/result.dart';

class NotesRepository implements INotesRepository {
  final INotesService _svc;
  NotesRepository(this._svc);

  @override
  Future<Result<List<Note>>> listNotes(NotesFilter filter) async {
    final allRes = await _svc.getAll();
    if (allRes.isFailure) return Result.failure(allRes.error!);
    final filtered = _svc.applyFilter(allRes.data!, filter);
    return Result.success(filtered);
  }

  @override
  Future<Result<Note>> create({
    required String title,
    required String content,
    bool pinned = false,
    bool archived = false,
  }) async {
    final draft = _svc.createDraft(
      title: title,
      content: content,
      pinned: pinned,
      archived: archived,
    );
    final allRes = await _svc.getAll();
    if (allRes.isFailure) return Result.failure(allRes.error!);
    final updated = [...allRes.data!, draft];
    final saveRes = await _svc.saveAll(updated);
    if (saveRes.isFailure) return Result.failure(saveRes.error!);
    return Result.success(draft);
  }

  @override
  Future<Result<Note>> update(
    Note note, {
    String? title,
    String? content,
    bool? pinned,
    bool? archived,
  }) async {
    final allRes = await _svc.getAll();
    if (allRes.isFailure) return Result.failure(allRes.error!);
    final all = allRes.data!;
    final idx = all.indexWhere((n) => n.id == note.id);
    if (idx == -1) return Result.failure('Note not found');
    final patched = _svc.applyUpdate(note,
        title: title, content: content, pinned: pinned, archived: archived);
    final copy = [...all]..[idx] = patched;
    final saveRes = await _svc.saveAll(copy);
    if (saveRes.isFailure) return Result.failure(saveRes.error!);
    return Result.success(patched);
  }

  @override
  Future<Result<void>> delete(String id) async {
    final allRes = await _svc.getAll();
    if (allRes.isFailure) return Result.failure(allRes.error!);
    final copy = allRes.data!.where((n) => n.id != id).toList(growable: false);
    final saveRes = await _svc.saveAll(copy);
    if (saveRes.isFailure) return Result.failure(saveRes.error!);
    return Result<void>.success(null);
  }

  @override
  Future<Result<void>> persist() async {
    // With write-through service this can be a no-op, but keep for API symmetry
    final allRes = await _svc.getAll();
    if (allRes.isFailure) return Result.failure(allRes.error!);
    final saveRes = await _svc.saveAll(allRes.data!);
    if (saveRes.isFailure) return Result.failure(saveRes.error!);
    return Result<void>.success(null);
  }

  @override
  Future<Result<Note>> getNote(String id) async {
    return _svc.getNote(id);
  }
}
