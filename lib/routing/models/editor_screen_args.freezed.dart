// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'editor_screen_args.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EditorScreenArgs {
  String get id;
  bool get isNew;

  /// Create a copy of EditorScreenArgs
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $EditorScreenArgsCopyWith<EditorScreenArgs> get copyWith =>
      _$EditorScreenArgsCopyWithImpl<EditorScreenArgs>(
          this as EditorScreenArgs, _$identity);

  /// Serializes this EditorScreenArgs to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is EditorScreenArgs &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.isNew, isNew) || other.isNew == isNew));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, isNew);

  @override
  String toString() {
    return 'EditorScreenArgs(id: $id, isNew: $isNew)';
  }
}

/// @nodoc
abstract mixin class $EditorScreenArgsCopyWith<$Res> {
  factory $EditorScreenArgsCopyWith(
          EditorScreenArgs value, $Res Function(EditorScreenArgs) _then) =
      _$EditorScreenArgsCopyWithImpl;
  @useResult
  $Res call({String id, bool isNew});
}

/// @nodoc
class _$EditorScreenArgsCopyWithImpl<$Res>
    implements $EditorScreenArgsCopyWith<$Res> {
  _$EditorScreenArgsCopyWithImpl(this._self, this._then);

  final EditorScreenArgs _self;
  final $Res Function(EditorScreenArgs) _then;

  /// Create a copy of EditorScreenArgs
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? isNew = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      isNew: null == isNew
          ? _self.isNew
          : isNew // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [EditorScreenArgs].
extension EditorScreenArgsPatterns on EditorScreenArgs {
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
    TResult Function(_EditorScreenArgs value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _EditorScreenArgs() when $default != null:
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
    TResult Function(_EditorScreenArgs value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EditorScreenArgs():
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
    TResult? Function(_EditorScreenArgs value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EditorScreenArgs() when $default != null:
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
    TResult Function(String id, bool isNew)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _EditorScreenArgs() when $default != null:
        return $default(_that.id, _that.isNew);
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
    TResult Function(String id, bool isNew) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EditorScreenArgs():
        return $default(_that.id, _that.isNew);
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
    TResult? Function(String id, bool isNew)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EditorScreenArgs() when $default != null:
        return $default(_that.id, _that.isNew);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _EditorScreenArgs implements EditorScreenArgs {
  const _EditorScreenArgs({required this.id, this.isNew = false});
  factory _EditorScreenArgs.fromJson(Map<String, dynamic> json) =>
      _$EditorScreenArgsFromJson(json);

  @override
  final String id;
  @override
  @JsonKey()
  final bool isNew;

  /// Create a copy of EditorScreenArgs
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$EditorScreenArgsCopyWith<_EditorScreenArgs> get copyWith =>
      __$EditorScreenArgsCopyWithImpl<_EditorScreenArgs>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$EditorScreenArgsToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _EditorScreenArgs &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.isNew, isNew) || other.isNew == isNew));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, isNew);

  @override
  String toString() {
    return 'EditorScreenArgs(id: $id, isNew: $isNew)';
  }
}

/// @nodoc
abstract mixin class _$EditorScreenArgsCopyWith<$Res>
    implements $EditorScreenArgsCopyWith<$Res> {
  factory _$EditorScreenArgsCopyWith(
          _EditorScreenArgs value, $Res Function(_EditorScreenArgs) _then) =
      __$EditorScreenArgsCopyWithImpl;
  @override
  @useResult
  $Res call({String id, bool isNew});
}

/// @nodoc
class __$EditorScreenArgsCopyWithImpl<$Res>
    implements _$EditorScreenArgsCopyWith<$Res> {
  __$EditorScreenArgsCopyWithImpl(this._self, this._then);

  final _EditorScreenArgs _self;
  final $Res Function(_EditorScreenArgs) _then;

  /// Create a copy of EditorScreenArgs
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? isNew = null,
  }) {
    return _then(_EditorScreenArgs(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      isNew: null == isNew
          ? _self.isNew
          : isNew // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
