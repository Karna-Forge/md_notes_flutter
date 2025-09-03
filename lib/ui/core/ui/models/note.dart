import 'dart:convert';

class Note {
  final String id;
  String title;
  String content;
  bool pinned;
  bool archived;
  DateTime createdAt;
  DateTime updatedAt;

  Note({
    required this.id,
    required this.title,
    required this.content,
    this.pinned = false,
    this.archived = false,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  Note copyWith({
    String? id,
    String? title,
    String? content,
    bool? pinned,
    bool? archived,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Note(
        id: id ?? this.id,
        title: title ?? this.title,
        content: content ?? this.content,
        pinned: pinned ?? this.pinned,
        archived: archived ?? this.archived,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'content': content,
        'pinned': pinned,
        'archived': archived,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
      };

  static Note fromJson(Map<String, dynamic> map) => Note(
        id: map['id'] as String,
        title: map['title'] as String? ?? '',
        content: map['content'] as String? ?? '',
        pinned: map['pinned'] as bool? ?? false,
        archived: map['archived'] as bool? ?? false,
        createdAt: DateTime.tryParse(map['createdAt'] ?? '') ?? DateTime.now(),
        updatedAt: DateTime.tryParse(map['updatedAt'] ?? '') ?? DateTime.now(),
      );

  static String encodeList(List<Note> notes) =>
      jsonEncode(notes.map((e) => e.toJson()).toList());

  static List<Note> decodeList(String raw) {
    final data = jsonDecode(raw) as List<dynamic>;
    return data.map((e) => Note.fromJson(e as Map<String, dynamic>)).toList();
  }
}
