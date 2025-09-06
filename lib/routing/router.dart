import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:markdown_notes/routing/models/editor_screen_args.dart';
import 'package:markdown_notes/ui/core/loacalization/app_localization.dart';
import 'package:markdown_notes/ui/edit/widgets/editor_page.dart';
import 'package:markdown_notes/ui/home/viewmodels/home_viewmodel.dart';
import 'package:provider/provider.dart';
import '/ui/home/widgets/home_screen.dart';

import 'routes.dart';

List<RouteBase> _commonRoutes = [
  GoRoute(
    path: Routes.homeScreen,
    builder: (context, state) {
      return ChangeNotifierProvider(
        create: (_) => HomeViewModel(context.read(), context.read()),
        child: HomeScreen(context.read<AppLocalization>()),
      );
    },
  ),
  GoRoute(
    path: Routes.editScreen,
    builder: (context, state) {
      final extra = state.extra as EditorScreenArgs;
      return EditorPage(
        context.read(),
        noteId: extra.id,
        isNew: extra.isNew,
      );
    },
  ),
];
List<RouteBase> _desktopOnlyRoutes = [];
List<RouteBase> _mobileOnlyRoutes = [];

List<RouteBase> _getRoutes() {
  List<RouteBase> routes = [..._commonRoutes];
  if (Platform.isAndroid || Platform.isIOS) {
    routes.addAll(_mobileOnlyRoutes);
  } else {
    routes.addAll(_desktopOnlyRoutes);
  }
  return routes;
}

GoRouter router() => GoRouter(
      initialLocation: Routes.homeScreen,
      debugLogDiagnostics: true,
      routes: [
        ShellRoute(
          builder: (context, state, child) {
            return Scaffold(body: child);
          },
          routes: _getRoutes(),
        ),
      ],
    );
