import 'package:freezed_annotation/freezed_annotation.dart';

part 'notes_filter.freezed.dart';
part 'notes_filter.g.dart';

@freezed
abstract class NotesFilter with _$NotesFilter {
  const factory NotesFilter({
    @Default(null) String? query,
    @Default(false) bool archived,
    @Default(false) bool pinnedFirst,
  }) = _NotesFilter;

  factory NotesFilter.fromJson(Map<String, dynamic> json) =>
      _$NotesFilterFromJson(json);
}
