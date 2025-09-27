import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:paralelo/features/auth/controller/auth_notifier.dart';
import 'package:paralelo/features/auth/view/auth_page.dart';
import 'package:paralelo/features/home/view/home_page.dart';

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
      if (loggedIn && loggingIn) return HomePage.routePath;

      return null;
    },
    routes: [
      GoRoute(path: HomePage.routePath, builder: (_, __) => const HomePage()),
      GoRoute(path: AuthPage.routePath, builder: (_, __) => const AuthPage()),
    ],
  );
});
