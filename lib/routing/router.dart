import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:markdown_notes/ui/edit/widgets/editor_page.dart';
import 'package:markdown_notes/ui/home/viewmodels/notes_provider.dart';
import 'package:provider/provider.dart';
import '/ui/home/widgets/home_screen.dart';

import 'routes.dart';

List<RouteBase> _commonRoutes = [
  GoRoute(
    path: Routes.homeScreen,
    builder: (context, state) {
      return ChangeNotifierProvider(
        create: (context) => NotesProvider(context.read()),
        child: HomeScreen(context.read()),
      );
    },
  ),
  GoRoute(
    path: Routes.editScreen,
    builder: (context, state) {
      final id = state.extra as String;
      return ChangeNotifierProvider(
        create: (context) => NotesProvider(context.read()),
        child: EditorPage(
          noteId: id,
        ),
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
