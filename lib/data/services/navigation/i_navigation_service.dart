import 'package:markdown_notes/routing/models/editor_screen_args.dart';
import 'package:markdown_notes/data/utils/result.dart';

abstract class INavigationService {
  Future<Result<bool>> gotoEditorPage(EditorScreenArgs args);
  Future<Result<bool>> goBack([bool? result]);
}
