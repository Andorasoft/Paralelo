import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:paralelo/features/auth/controllers/auth_provider.dart';
import 'package:paralelo/features/auth/views/auth_page.dart';
import 'package:paralelo/features/chats/models/chat_room.dart';
import 'package:paralelo/features/chats/views/chat_room_page.dart';
import 'package:paralelo/features/management/views/splash_page.dart';
import 'package:paralelo/features/projects/models/project.dart';
import 'package:paralelo/features/projects/views/create_project_page.dart';
import 'package:paralelo/features/projects/views/my_projects_page.dart';
import 'package:paralelo/features/projects/views/project_details_page.dart';
import 'package:paralelo/features/proposal/views/create_proposal_page.dart';
import 'package:paralelo/features/proposal/views/my_proposals_page.dart';
import 'package:paralelo/features/proposal/views/proposal_details_page.dart';
import 'package:paralelo/features/user/models/user.dart';
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
          final project = state.extra as Project;
          return CreateProposalPage(project: project);
        },
      ),
      GoRoute(
        path: ProposalDetailsPage.routePath,
        builder: (_, state) {
          return ProposalDetailsPage(proposalId: state.extra as int);
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
          final (room, user) = state.extra as (ChatRoom, User);
          return ChatRoomPage(roomId: room.id, recipientId: user.id);
        },
      ),
    ],
  );
});
