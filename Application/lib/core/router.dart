import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:paralelo/features/auth/controllers/auth_notifier.dart';
import 'package:paralelo/features/auth/views/auth_page.dart';
import 'package:paralelo/features/chats/views/chat_room_page.dart';
import 'package:paralelo/features/projects/models/project.dart';
import 'package:paralelo/features/projects/views/create_project_page.dart';
import 'package:paralelo/features/projects/views/project_details_page.dart';
import 'package:paralelo/features/proposal/views/create_proposal_page.dart';
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
        path: CreateProjectPage.routePath,
        builder: (_, _) => const CreateProjectPage(),
      ),
      GoRoute(
        path: ProjectDetailsPage.routePath,
        builder: (_, state) =>
            ProjectDetailsPage(project: state.extra as Project),
      ),

      GoRoute(
        path: CreateProposalPage.routePath,
        builder: (_, state) =>
            CreateProposalPage(project: state.extra as Project),
      ),

      GoRoute(
        path: ChatRoomPage.routePath,
        builder: (_, state) {
          final data = state.extra as Map<String, dynamic>;

          return ChatRoomPage(
            roomId: data['room_id'],
            recipientId: data['recipient_id'],
          );
        },
      ),
    ],
  );
});
