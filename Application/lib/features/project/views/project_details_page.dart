import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:paralelo/core/constants.dart';
import 'package:paralelo/core/imports.dart';
import 'package:paralelo/core/router.dart';
import 'package:paralelo/features/auth/exports.dart';
import 'package:paralelo/features/plan/exports.dart';
import 'package:paralelo/features/project/exports.dart';
import 'package:paralelo/features/rating/exports.dart';
import 'package:paralelo/features/skill/exports.dart';
import 'package:paralelo/features/proposal/exports.dart';
import 'package:paralelo/features/user/exports.dart';
import 'package:paralelo/widgets/loading_indicator.dart';
import 'package:paralelo/widgets/navigation_button.dart';

class ProjectDetailsPage extends ConsumerStatefulWidget {
  static const routePath = '/project-details';

  final String projectId;

  const ProjectDetailsPage({super.key, required this.projectId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _ProjectDetailsPageState();
  }
}

class _ProjectDetailsPageState extends ConsumerState<ProjectDetailsPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  late final Future<_ProjectDetailsDto> loadDataFuture;
  late final String userId;

  @override
  void initState() {
    super.initState();

    userId = ref.read(authProvider)!.id;
    loadDataFuture = loadData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadDataFuture,
      builder: (_, snapshot) {
        if (!snapshot.hasData) {
          return skeleton();
        }

        return page(snapshot.data!);
      },
    ).hideKeyboardOnTap(context);
  }

  Widget skeleton() {
    return Scaffold(key: scaffoldKey, body: const LoadingIndicator().center());
  }

  Widget page(_ProjectDetailsDto data) {
    return Scaffold(
      key: scaffoldKey,

      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: const NavigationButton(),
        actions: [
          if (userId == data.owner.id)
            TextButton(onPressed: () {}, child: Text('button.edit'.tr())),
        ],
      ),

      body: ListView(
        padding: Insets.h16v8,
        children: [
          Text(
            data.project.title,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w500),
          ),
          Text(
            'Publicado en ${data.project.createdAt.toLongDateString()}',
          ).margin(const EdgeInsets.symmetric(vertical: 16.0)),

          Column(
            spacing: 8.0,

            children: [
              ProjectInfoPresenter(
                project: data.project,
                payment: data.payment,
                skills: data.skills,
                showStatus: true,
              ),
              if (userId != data.owner.id)
                ProjectOwnerPresenter(owner: data.owner, plan: data.plan),
            ],
          ),
        ],
      ),

      bottomNavigationBar: FilledButton(
        onPressed: !data.applied
            ? userId != data.owner.id
                  ? () async {
                      await ref
                          .read(goRouterProvider)
                          .push(
                            CreateProposalPage.routePath,
                            extra: widget.projectId,
                          );
                    }
                  : () async {
                      final rating = await showRatingUserModalBottomSheet(
                        context,
                      );

                      debugPrint('$rating');
                    }
            : null,
        child: Text(
          userId != data.owner.id
              ? 'button.offer_help'.tr()
              : 'button.mark_completed'.tr(),
        ),
      ).margin(const EdgeInsets.all(16.0)).useSafeArea(),
    );
  }

  Future<_ProjectDetailsDto> loadData() async {
    final project = await ref.read(projectProvider).getById(widget.projectId);

    final (owner, plan, payment, skills, applied) = await (
      ref.read(userProvider).getById(project!.ownerId),
      ref.read(planProvider).getForUser(project.ownerId),
      ref.read(projectPaymentProvider).getForProject(widget.projectId),
      ref.read(skillProvider).getForProject(widget.projectId),
      ref
          .read(proposalProvider)
          .applied(projectId: widget.projectId, providerId: userId),
    ).wait;

    return _ProjectDetailsDto(
      owner: owner!,
      plan: plan!,
      project: project,
      payment: payment!,
      skills: skills,
      applied: applied,
    );
  }
}

class _ProjectDetailsDto {
  final User owner;
  final Plan plan;
  final Project project;
  final ProjectPayment payment;
  final List<Skill> skills;
  final bool applied;

  const _ProjectDetailsDto({
    required this.owner,
    required this.plan,
    required this.project,
    required this.payment,
    required this.skills,
    required this.applied,
  });
}
