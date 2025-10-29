import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:paralelo/core/imports.dart';
import 'package:paralelo/core/router.dart';
import 'package:paralelo/features/auth/exports.dart';
import 'package:paralelo/features/project/exports.dart';
import 'package:paralelo/features/skill/exports.dart';
import 'package:paralelo/features/proposal/exports.dart';
import 'package:paralelo/features/user/exports.dart';
import 'package:paralelo/utils/extensions.dart';
import 'package:paralelo/widgets/loading_indicator.dart';
import 'package:paralelo/widgets/navigation_button.dart';

class ProjectDetailsPage extends ConsumerStatefulWidget {
  static const routePath = '/project-details';

  final int projectId;

  const ProjectDetailsPage({super.key, required this.projectId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _ProjectDetailsPageState();
  }
}

class _ProjectDetailsPageState extends ConsumerState<ProjectDetailsPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late final Future<(User, Project, ProjectPayment, List<Skill>, bool)>
  loadDataFuture;

  @override
  void initState() {
    super.initState();

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

  Widget page((User, Project, ProjectPayment, List<Skill>, bool) data) {
    final (owner, project, payment, skills, applied) = data;
    final userId = ref.read(authProvider)!.id;

    return Scaffold(
      key: scaffoldKey,

      appBar: AppBar(
        automaticallyImplyLeading: false,

        leading: const NavigationButton(),

        actions: [
          if (userId == owner.id)
            TextButton(onPressed: () {}, child: Text('button.edit'.tr())),
        ],
      ),

      body: ListView(
        padding: Insets.h16v8,
        children: [
          Text(
            project.title,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w500),
          ),
          Text(
            'Publicado en ${project.createdAt.toLongDateString()}',
          ).margin(const EdgeInsets.symmetric(vertical: 16.0)),

          Column(
            spacing: 8.0,

            children: [
              ProjectInfoPresenter(
                project: project,
                payment: payment,
                skills: skills,
                showStatus: true,
              ),
              if (userId != owner.id) ProjectOwnerPresenter(owner: owner),
            ],
          ),
        ],
      ),

      bottomNavigationBar: FilledButton(
        onPressed: !applied
            ? userId != owner.id
                  ? () async {
                      await ref
                          .read(goRouterProvider)
                          .push(
                            CreateProposalPage.routePath,
                            extra: widget.projectId,
                          );
                    }
                  : () {}
            : null,
        child: Text(
          userId != owner.id
              ? 'button.offer_help'.tr()
              : 'button.mark_completed'.tr(),
        ),
      ).margin(const EdgeInsets.all(16.0)).useSafeArea(),
    );
  }

  Future<(User, Project, ProjectPayment, List<Skill>, bool)> loadData() async {
    final userId = ref.read(authProvider)!.id;

    final (project, payment, skills, applied) = await (
      ref.read(projectProvider).getById(widget.projectId),
      ref.read(projectPaymentProvider).getForProject(widget.projectId),
      ref.read(skillProvider).getForProject(widget.projectId),
      ref
          .read(proposalProvider)
          .applied(projectId: widget.projectId, providerId: userId),
    ).wait;
    final owner = await ref.read(userProvider).getById(project!.ownerId);

    return (owner!, project, payment!, skills, applied);
  }
}
