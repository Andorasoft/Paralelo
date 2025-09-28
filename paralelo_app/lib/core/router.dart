import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:paralelo/features/auth/controllers/auth_notifier.dart';
import 'package:paralelo/features/auth/views/auth_page.dart';
import 'package:paralelo/features/projects/views/add_project_page.dart';
import 'package:paralelo/features/projects/views/project_details_page.dart';
import 'package:paralelo/widgets/bottom_nav_bar.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);

  return GoRouter(
    debugLogDiagnostics: true,
    initialLocation: AuthPage.routePath,
    refreshListenable: GoRouterRefreshStream(
      ref.read(authProvider.notifier).stream,
    ),
    redirect: (_, state) {
      final loggedIn = authState != null;
      final loggingIn = [AuthPage.routePath].contains(state.matchedLocation);

      if (!loggedIn && !loggingIn) return AuthPage.routePath;
      if (loggedIn && loggingIn) return '/';

      return null;
    },
    routes: [
      GoRoute(path: '/', builder: (_, __) => const BottomNavBar()),
      GoRoute(path: AuthPage.routePath, builder: (_, __) => const AuthPage()),

      GoRoute(
        path: AddProjectPage.routePath,
        builder: (_, _) => const AddProjectPage(),
      ),
      GoRoute(
        path: ProjectDetailsPage.routePath,
        builder: (_, state) =>
            ProjectDetailsPage(projectId: state.extra as int),
      ),
    ],
  );
});
