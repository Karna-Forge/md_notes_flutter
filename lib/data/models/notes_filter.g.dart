// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notes_filter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NotesFilter _$NotesFilterFromJson(Map<String, dynamic> json) => _NotesFilter(
      query: json['query'] as String?,
      archived: json['archived'] as bool? ?? false,
      pinnedFirst: json['pinnedFirst'] as bool? ?? false,
    );

Map<String, dynamic> _$NotesFilterToJson(_NotesFilter instance) =>
    <String, dynamic>{
      'query': instance.query,
      'archived': instance.archived,
      'pinnedFirst': instance.pinnedFirst,
    };
