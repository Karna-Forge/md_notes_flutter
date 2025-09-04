import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'note.freezed.dart';
part 'note.g.dart';

@freezed
abstract class Note with _$Note {
  const factory Note({
    required String id,
    required String title,
    required String content,
    @Default(false) bool pinned,
    @Default(false) bool archived,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Note;

  const Note._();

  factory Note.withDefaults({
    required String id,
    required String title,
    required String content,
    bool pinned = false,
    bool archived = false,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    final now = DateTime.now();
    return Note(
      id: id,
      title: title,
      content: content,
      pinned: pinned,
      archived: archived,
      createdAt: createdAt ?? now,
      updatedAt: updatedAt ?? now,
    );
  }

  factory Note.fromJson(Map<String, dynamic> json) => _$NoteFromJson(json);

  static String encodeList(List<Note> notes) =>
      jsonEncode(notes.map((e) => e.toJson()).toList());

  static List<Note> decodeList(String raw) => (jsonDecode(raw) as List)
      .map((e) => Note.fromJson(e as Map<String, dynamic>))
      .toList();
}

extension NoteX on Note {
  Note copyUpdating({
    String? title,
    String? content,
    bool? pinned,
    bool? archived,
  }) {
    return copyWith(
        title: title ?? this.title,
        content: content ?? this.content,
        pinned: pinned ?? this.pinned,
        archived: archived ?? this.archived,
        updatedAt: DateTime.now(),
        createdAt: DateTime.now());
  }
}
