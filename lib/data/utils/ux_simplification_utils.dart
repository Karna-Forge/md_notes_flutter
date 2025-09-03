import 'package:intl/intl.dart';
import 'package:markdown_notes/data/models/note.dart';

extension DateFormatting on String {
  /// Parses ISO 8601 string to a readable format like "June 29, 2025"
  String isoToReadableDate() {
    try {
      final date = DateTime.parse(this);
      return DateFormat.yMMMMd().format(date);
    } catch (_) {
      return this; // fallback if invalid format
    }
  }
}

extension DateFormattingExtension on DateTime {
  /// Parses ISO 8601 string to a readable format like "June 29, 2025"
  String readableDate() {
    try {
      return DateFormat.yMMMMd().format(this);
    } catch (_) {
      return ""; // fallback if invalid format
    }
  }
}

extension NoteX on Note {
  Note copyUpdating(
      {String? title,
      String? content,
      bool? pinned,
      bool? archived,
      DateTime? updatedAt}) {
    return copyWith(
      title: title ?? this.title,
      content: content ?? this.content,
      pinned: pinned ?? this.pinned,
      archived: archived ?? this.archived,
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }
}
