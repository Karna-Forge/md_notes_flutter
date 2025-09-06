import 'package:markdown_notes/data/services/navigation/i_navigation_service.dart';
import 'package:markdown_notes/routing/models/editor_screen_args.dart';
import 'package:markdown_notes/ui/core/viewmodel.dart/base_viewmodel.dart';

class HomeViewModel extends BaseViewModel {
  final INavigationService _service;

  HomeViewModel(this._service);

  @override
  Future<void> init() async {}

  Future<void> gotoEditorPage(EditorScreenArgs args) async {
    _service.gotoEditorPage(args);
  }
}
