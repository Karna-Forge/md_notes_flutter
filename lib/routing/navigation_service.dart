import 'package:go_router/go_router.dart';
import 'package:markdown_notes/data/services/navigation/i_navigation_service.dart';
import 'package:markdown_notes/routing/models/editor_screen_args.dart';
import 'package:markdown_notes/routing/routes.dart';
import 'package:markdown_notes/data/utils/result.dart';

class NavigationService extends INavigationService {
  late final GoRouter _router;

  NavigationService(this._router);

  @override
  Future<Result<bool>> gotoEditorPage(EditorScreenArgs args) async {
    final res = await _router.push<bool>(Routes.editScreen, extra: args);
    return Result.success(res ?? false);
  }

  @override
  Future<Result<bool>> goBack([bool? result]) async {
    _router.pop(result);
    return Result.success(true);
  }
}
