import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:paralelo/core/imports.dart';
import 'package:paralelo/core/router.dart';
import 'package:paralelo/features/auth/exports.dart';
import 'package:paralelo/features/projects/exports.dart';
import 'package:paralelo/features/skills/exports.dart';
import 'package:paralelo/features/proposal/exports.dart';
import 'package:paralelo/features/user/exports.dart';
import 'package:paralelo/widgets/loading_indicator.dart';
import 'package:paralelo/widgets/navigation_button.dart';

class ProjectDetailsPage extends ConsumerStatefulWidget {
  static const routePath = '/project-details';

  final Project project;

  const ProjectDetailsPage({super.key, required this.project});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _ProjectDetailsPageState();
  }
}

class _ProjectDetailsPageState extends ConsumerState<ProjectDetailsPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late final Future<(User, ProjectPayment, List<ProjectSkill>)> loadDataFuture;

  @override
  void initState() {
    super.initState();

    loadDataFuture = loadData();
  }

  @override
  Widget build(BuildContext context) {
    final userId = ref.read(authProvider)!.id;

    return Scaffold(
      key: scaffoldKey,

      appBar: AppBar(
        automaticallyImplyLeading: false,

        leading: const NavigationButton(),

        actions: [
          if (userId == widget.project.ownerId)
            TextButton(onPressed: () {}, child: Text('button.edit'.tr())),
        ],
      ),

      body: FutureBuilder(
        future: loadDataFuture,
        builder: (_, snapshot) {
          if (!snapshot.hasData) {
            return const LoadingIndicator().center();
          }

          final (owner, payment, skills) = snapshot.data!;

          return ListView(
            children: [
              Text(
                widget.project.title,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Publicado en ${widget.project.createdAt.toLongDateString()}',
              ).margin(const EdgeInsets.symmetric(vertical: 16.0)),

              Column(
                spacing: 8.0,

                children: [
                  ProjectInfoPresenter(
                    project: widget.project,
                    payment: payment,
                    skills: skills,
                  ),
                  if (userId != widget.project.ownerId)
                    ProjectOwnerPresenter(owner: owner),
                ],
              ),
            ],
          ).margin(const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0));
        },
      ),

      bottomNavigationBar: FutureBuilder(
        future: loadDataFuture,

        builder: (_, snapshot) {
          return FilledButton(
            onPressed: snapshot.hasData
                ? userId != widget.project.ownerId
                      ? () async {
                          await ref
                              .read(goRouterProvider)
                              .push(
                                CreateProposalPage.routePath,
                                extra: widget.project,
                              );
                        }
                      : () {}
                : null,
            child: Text(
              userId != widget.project.ownerId
                  ? 'button.offer_help'.tr()
                  : 'button.mark_completed'.tr(),
            ),
          ).margin(const EdgeInsets.all(16.0)).useSafeArea();
        },
      ),
    );
  }

  Future<(User, ProjectPayment, List<ProjectSkill>)> loadData() async {
    final projectId = widget.project.id;
    final ownerId = widget.project.ownerId;

    final (owner, payment, skills) = await (
      ref.read(userProvider).getById(ownerId),
      ref.read(projectPaymentProvider).getByProject(projectId),
      ref
          .read(projectSkillProvider)
          .getByProject(projectId, includeRelations: true),
    ).wait;

    return (owner!, payment!, skills);
  }
}
