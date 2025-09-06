import 'package:go_router/go_router.dart';
import 'package:markdown_notes/data/services/navigation/i_navigation_service.dart';
import 'package:markdown_notes/routing/models/editor_screen_args.dart';
import 'package:markdown_notes/routing/routes.dart';

class NavigationService extends INavigationService {
  late final GoRouter _router;

  NavigationService(this._router);

  @override
  Future<bool> gotoEditorPage(EditorScreenArgs args) async {
    _router.push(Routes.editScreen, extra: args);
    return true;
  }

  @override
  Future<bool> goBack() async {
    _router.pop();
    return true;
  }
}
