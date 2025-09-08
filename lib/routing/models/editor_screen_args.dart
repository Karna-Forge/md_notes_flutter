import 'package:freezed_annotation/freezed_annotation.dart';

part 'editor_screen_args.freezed.dart';
part 'editor_screen_args.g.dart';

@freezed
abstract class EditorScreenArgs with _$EditorScreenArgs {
  const factory EditorScreenArgs({
    required String id,
    @Default(false) bool isNew,
  }) = _EditorScreenArgs;

  factory EditorScreenArgs.fromJson(Map<String, dynamic> json) =>
      _$EditorScreenArgsFromJson(json);
}
