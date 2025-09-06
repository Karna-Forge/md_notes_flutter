import 'package:markdown_notes/routing/models/editor_screen_args.dart';

abstract class INavigationService {
  Future<bool> gotoEditorPage(EditorScreenArgs args);
  Future<bool> goBack();
}
