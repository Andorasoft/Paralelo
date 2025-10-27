import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:paralelo/features/auth/exports.dart';
import 'package:paralelo/features/chats/exports.dart';
import 'package:paralelo/features/management/exports.dart';
import 'package:paralelo/features/projects/exports.dart';
import 'package:paralelo/features/proposal/exports.dart';
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
      if (loggedIn && loggingIn) return SplashPage.routePath;

      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        builder: (_, __) {
          return const BottomNavBar();
        },
      ),

      GoRoute(
        path: AuthPage.routePath,
        builder: (_, __) {
          return const AuthPage();
        },
      ),

      GoRoute(
        path: SplashPage.routePath,
        builder: (_, _) {
          return const SplashPage();
        },
      ),

      GoRoute(
        path: CreateProjectPage.routePath,
        builder: (_, _) {
          return const CreateProjectPage();
        },
      ),
      GoRoute(
        path: ProjectDetailsPage.routePath,
        builder: (_, state) {
          return ProjectDetailsPage(project: state.extra as Project);
        },
      ),
      GoRoute(
        path: MyProjectsPage.routePath,
        builder: (_, _) {
          return const MyProjectsPage();
        },
      ),

      GoRoute(
        path: CreateProposalPage.routePath,
        builder: (_, state) {
          return CreateProposalPage(projectId: state.extra as int);
        },
      ),
      GoRoute(
        path: ProposalDetailsPage.routePath,
        builder: (_, state) {
          final proposalId = state.extra as int;
          return ProposalDetailsPage(proposalId: proposalId);
        },
      ),
      GoRoute(
        path: MyProposalsPage.routePath,
        builder: (_, _) {
          return const MyProposalsPage();
        },
      ),

      GoRoute(
        path: ChatRoomPage.routePath,
        builder: (_, state) {
          final (roomId, userId) = state.extra as (String, String);
          return ChatRoomPage(roomId: roomId, recipientId: userId);
        },
      ),
    ],
  );
});
