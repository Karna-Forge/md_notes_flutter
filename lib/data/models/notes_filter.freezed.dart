// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notes_filter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NotesFilter {
  String? get query;
  bool get archived;
  bool get pinnedFirst;

  /// Create a copy of NotesFilter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $NotesFilterCopyWith<NotesFilter> get copyWith =>
      _$NotesFilterCopyWithImpl<NotesFilter>(this as NotesFilter, _$identity);

  /// Serializes this NotesFilter to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is NotesFilter &&
            (identical(other.query, query) || other.query == query) &&
            (identical(other.archived, archived) ||
                other.archived == archived) &&
            (identical(other.pinnedFirst, pinnedFirst) ||
                other.pinnedFirst == pinnedFirst));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, query, archived, pinnedFirst);

  @override
  String toString() {
    return 'NotesFilter(query: $query, archived: $archived, pinnedFirst: $pinnedFirst)';
  }
}

/// @nodoc
abstract mixin class $NotesFilterCopyWith<$Res> {
  factory $NotesFilterCopyWith(
          NotesFilter value, $Res Function(NotesFilter) _then) =
      _$NotesFilterCopyWithImpl;
  @useResult
  $Res call({String? query, bool archived, bool pinnedFirst});
}

/// @nodoc
class _$NotesFilterCopyWithImpl<$Res> implements $NotesFilterCopyWith<$Res> {
  _$NotesFilterCopyWithImpl(this._self, this._then);

  final NotesFilter _self;
  final $Res Function(NotesFilter) _then;

  /// Create a copy of NotesFilter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? query = freezed,
    Object? archived = null,
    Object? pinnedFirst = null,
  }) {
    return _then(_self.copyWith(
      query: freezed == query
          ? _self.query
          : query // ignore: cast_nullable_to_non_nullable
              as String?,
      archived: null == archived
          ? _self.archived
          : archived // ignore: cast_nullable_to_non_nullable
              as bool,
      pinnedFirst: null == pinnedFirst
          ? _self.pinnedFirst
          : pinnedFirst // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [NotesFilter].
extension NotesFilterPatterns on NotesFilter {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_NotesFilter value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _NotesFilter() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_NotesFilter value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NotesFilter():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_NotesFilter value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NotesFilter() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String? query, bool archived, bool pinnedFirst)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _NotesFilter() when $default != null:
        return $default(_that.query, _that.archived, _that.pinnedFirst);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String? query, bool archived, bool pinnedFirst) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NotesFilter():
        return $default(_that.query, _that.archived, _that.pinnedFirst);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(String? query, bool archived, bool pinnedFirst)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NotesFilter() when $default != null:
        return $default(_that.query, _that.archived, _that.pinnedFirst);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _NotesFilter implements NotesFilter {
  const _NotesFilter(
      {this.query, this.archived = false, this.pinnedFirst = false});
  factory _NotesFilter.fromJson(Map<String, dynamic> json) =>
      _$NotesFilterFromJson(json);

  @override
  final String? query;
  @override
  @JsonKey()
  final bool archived;
  @override
  @JsonKey()
  final bool pinnedFirst;

  /// Create a copy of NotesFilter
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$NotesFilterCopyWith<_NotesFilter> get copyWith =>
      __$NotesFilterCopyWithImpl<_NotesFilter>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$NotesFilterToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _NotesFilter &&
            (identical(other.query, query) || other.query == query) &&
            (identical(other.archived, archived) ||
                other.archived == archived) &&
            (identical(other.pinnedFirst, pinnedFirst) ||
                other.pinnedFirst == pinnedFirst));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, query, archived, pinnedFirst);

  @override
  String toString() {
    return 'NotesFilter(query: $query, archived: $archived, pinnedFirst: $pinnedFirst)';
  }
}

/// @nodoc
abstract mixin class _$NotesFilterCopyWith<$Res>
    implements $NotesFilterCopyWith<$Res> {
  factory _$NotesFilterCopyWith(
          _NotesFilter value, $Res Function(_NotesFilter) _then) =
      __$NotesFilterCopyWithImpl;
  @override
  @useResult
  $Res call({String? query, bool archived, bool pinnedFirst});
}

/// @nodoc
class __$NotesFilterCopyWithImpl<$Res> implements _$NotesFilterCopyWith<$Res> {
  __$NotesFilterCopyWithImpl(this._self, this._then);

  final _NotesFilter _self;
  final $Res Function(_NotesFilter) _then;

  /// Create a copy of NotesFilter
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? query = freezed,
    Object? archived = null,
    Object? pinnedFirst = null,
  }) {
    return _then(_NotesFilter(
      query: freezed == query
          ? _self.query
          : query // ignore: cast_nullable_to_non_nullable
              as String?,
      archived: null == archived
          ? _self.archived
          : archived // ignore: cast_nullable_to_non_nullable
              as bool,
      pinnedFirst: null == pinnedFirst
          ? _self.pinnedFirst
          : pinnedFirst // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
