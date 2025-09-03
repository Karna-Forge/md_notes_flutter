import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '/ui/home/widgets/home_screen.dart';

import 'routes.dart';

List<RouteBase> _commonRoutes = [
  GoRoute(
    path: Routes.home,
    builder: (context, state) {
      return const HomeScreen();
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
      initialLocation: Routes.home,
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
