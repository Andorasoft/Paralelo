import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:paralelo/core/imports.dart';
import 'package:paralelo/features/auth/controllers/auth_provider.dart';
import 'package:paralelo/features/projects/controllers/project_payment_provider.dart';
import 'package:paralelo/features/skills/controllers/project_skill_provider.dart';
import 'package:paralelo/features/projects/models/project.dart';
import 'package:paralelo/features/projects/models/project_payment.dart';
import 'package:paralelo/features/skills/models/project_skill.dart';
import 'package:paralelo/features/reports/widgets/project_report_button.dart';
import 'package:paralelo/features/proposal/views/create_proposal_page.dart';
import 'package:paralelo/features/user/exports.dart';
import 'package:paralelo/widgets/loading_indicator.dart';
import 'package:paralelo/widgets/navigation_button.dart';
import 'package:paralelo/utils/formatters.dart';
import 'package:paralelo/core/router.dart';

class ProjectDetailsPage extends ConsumerStatefulWidget {
  static const routeName = 'ProjectDetailsPage';
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
              ),

              Theme(
                data: Theme.of(context).copyWith(
                  cardTheme: CardThemeData(
                    elevation: 0.0,
                    color: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1.0,
                        color: Theme.of(context).colorScheme.primaryContainer,
                      ),
                      borderRadius: BorderRadiusGeometry.circular(8.0),
                    ),
                  ),
                ),
                child: Column(
                  spacing: 16.0,

                  children: [
                    Card(
                      margin: EdgeInsets.zero,

                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        spacing: 4.0,

                        children: [
                          Text(
                            '${payment.currency} ${payment.min} - ${payment.max}',
                            style: Theme.of(context).textTheme.labelLarge
                                ?.copyWith(fontWeight: FontWeight.w600),
                            textAlign: TextAlign.end,
                          ).margin(const EdgeInsets.only(bottom: 12.0)),
                          Text(widget.project.description),

                          Text(
                            'Habilidades necesarias',
                            style: Theme.of(context).textTheme.labelLarge
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ).margin(const EdgeInsets.only(top: 12.0)),
                          Wrap(
                            spacing: 8.0,

                            children: skills
                                .map((s) => Chip(label: Text(s.skill!.name)))
                                .toList(),
                          ),
                          if (userId != widget.project.ownerId)
                            const ReportProjectButton().center().margin(
                              const EdgeInsets.only(top: 16.0),
                            ),
                        ],
                      ).margin(const EdgeInsets.all(16.0)),
                    ),

                    if (userId != widget.project.ownerId)
                      Card(
                        margin: EdgeInsets.zero,

                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          spacing: 12.0,

                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(100.0),

                              child: owner.pictureUrl == null
                                  ? SvgPicture.asset(
                                      'assets/images/user.svg',
                                      width: 40.0,
                                      height: 40.0,
                                    )
                                  : Image.network(
                                      owner.pictureUrl!,
                                      width: 40.0,
                                      height: 40.0,
                                    ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  spacing: 4.0,

                                  children: [
                                    Text(
                                      owner.displayName.obscure(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge
                                          ?.copyWith(
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                    if (owner.verified)
                                      Icon(
                                        TablerIcons
                                            .rosette_discount_check_filled,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.secondary,
                                      ),
                                  ],
                                ),
                                Text(
                                  '11 proyectos completados',
                                  style: Theme.of(context).textTheme.bodyMedium
                                      ?.copyWith(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.outline,
                                      ),
                                ),
                              ],
                            ).expanded(),
                            UserRatingPresenter(rating: 4.5),
                          ],
                        ).margin(const EdgeInsets.all(16.0)),
                      ),
                  ],
                ),
              ).margin(const EdgeInsets.only(top: 16.0)),
            ],
          ).margin(const EdgeInsets.symmetric(horizontal: 12.0));
        },
      ),

      bottomNavigationBar: FutureBuilder(
        future: loadDataFuture,

        builder: (_, snapshot) {
          return FilledButton(
                onPressed: snapshot.hasData && userId != widget.project.ownerId
                    ? () async {
                        await ref
                            .read(goRouterProvider)
                            .push(
                              CreateProposalPage.routePath,
                              extra: widget.project,
                            );
                      }
                    : null,
                child: Text('button.offer_help'.tr()),
              )
              .margin(
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              )
              .useSafeArea();
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
