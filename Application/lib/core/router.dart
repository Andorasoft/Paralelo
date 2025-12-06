import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:paralelo/core/imports.dart';
import 'package:paralelo/features/auth/exports.dart';
import 'package:paralelo/features/chat/exports.dart';
import 'package:paralelo/features/application/exports.dart';
import 'package:paralelo/features/plan/exports.dart';
import 'package:paralelo/features/project/exports.dart';
import 'package:paralelo/features/proposal/exports.dart';
import 'package:paralelo/widgets/bottom_nav_bar.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    debugLogDiagnostics: true,
    initialLocation: SplashPage.routePath,
    refreshListenable: GoRouterRefreshStream(
      ref.read(authProvider.notifier).stream,
    ),

    redirect: (_, state) {
      if (state.matchedLocation == SplashPage.routePath) {
        return null;
      }

      final loggedIn = ref.read(authProvider) != null;
      final loggingIn = const [
        SignInPage.routePath,
        SignUpPage.routePath,
      ].contains(state.matchedLocation);

      if (!loggedIn && !loggingIn) {
        return SignInPage.routePath;
      }
      if (loggedIn && loggingIn) {
        return '/';
      }

      return null;
    },

    routes: [
      GoRoute(
        path: '/',
        builder: (_, __) {
          return const BottomNavBar();
        },
      ),

      // ---------------------------------------------
      // Auth pages...
      // ---------------------------------------------
      GoRoute(
        path: SignInPage.routePath,
        builder: (_, __) {
          return const SignInPage();
        },
      ),
      GoRoute(
        path: SignUpPage.routePath,
        builder: (_, __) {
          return const SignUpPage();
        },
      ),

      GoRoute(
        path: SplashPage.routePath,
        builder: (_, _) {
          return const SplashPage();
        },
      ),

      // ---------------------------------------------
      // Project management pages...
      // ---------------------------------------------
      GoRoute(
        path: CreateProjectPage.routePath,
        builder: (_, _) {
          return const CreateProjectPage();
        },
      ),
      GoRoute(
        path: EditProjectPage.routePath,
        builder: (_, state) {
          return EditProjectPage(projectId: state.extra as String);
        },
      ),
      GoRoute(
        path: ProjectDetailsPage.routePath,
        builder: (_, state) {
          return ProjectDetailsPage(projectId: state.extra as String);
        },
      ),
      GoRoute(
        path: MyProjectsPage.routePath,
        builder: (_, _) {
          return const MyProjectsPage();
        },
      ),

      // ---------------------------------------------
      // Proposal management pages...
      // ---------------------------------------------
      GoRoute(
        path: CreateProposalPage.routePath,
        builder: (_, state) {
          return CreateProposalPage(projectId: state.extra as String);
        },
      ),
      GoRoute(
        path: ProposalDetailsPage.routePath,
        builder: (_, state) {
          return ProposalDetailsPage(proposalId: state.extra as String);
        },
      ),
      GoRoute(
        path: MyProposalsPage.routePath,
        builder: (_, _) {
          return const MyProposalsPage();
        },
      ),

      // ---------------------------------------------
      // Chat pages...
      // ---------------------------------------------
      GoRoute(
        path: ChatRoomPage.routePath,
        builder: (_, state) {
          return ChatRoomPage(roomId: state.extra as String);
        },
      ),

      // ---------------------------------------------
      // Plan pages...
      // ---------------------------------------------
      GoRoute(
        path: PlansPage.routePath,
        builder: (_, _) {
          return const PlansPage();
        },
      ),
    ],
  );
});
