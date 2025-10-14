import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:paralelo/features/auth/controllers/auth_notifier.dart';
import 'package:paralelo/features/projects/controllers/project_payment_provider.dart';
import 'package:paralelo/features/skills/controllers/project_skill_provider.dart';
import 'package:paralelo/features/projects/models/project.dart';
import 'package:paralelo/features/projects/models/project_payment.dart';
import 'package:paralelo/features/skills/models/project_skill.dart';
import 'package:paralelo/features/reports/widgets/project_report_button.dart';
import 'package:paralelo/features/proposal/views/create_proposal_page.dart';
import 'package:paralelo/features/user/widgets/user_rating.dart';
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
    return ProjectDetailsPageState();
  }
}

class ProjectDetailsPageState extends ConsumerState<ProjectDetailsPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  late final Future<(ProjectPayment, List<ProjectSkill>)> _loadDataFuture;

  @override
  void initState() {
    super.initState();

    _loadDataFuture = _loadData();
  }

  @override
  Widget build(BuildContext context) {
    final userId = ref.read(authProvider)!.id;

    return Scaffold(
      key: _scaffoldKey,

      appBar: AppBar(
        automaticallyImplyLeading: false,

        leading: const NavigationButton(),

        actions: [
          if (userId == widget.project.ownerId)
            TextButton(onPressed: () {}, child: Text('button.edit'.tr())),
        ],
      ),

      body: FutureBuilder(
        future: _loadDataFuture,
        builder: (_, snapshot) {
          if (!snapshot.hasData) {
            return const LoadingIndicator().center();
          }

          final (payment, skills) = snapshot.data!;

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
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          spacing: 12.0,

                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(100.0),

                              child: Image.network(
                                widget.project.owner!.pictureUrl!,
                                width: 40.0,
                                height: 40.0,
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                Text(
                                  '${widget.project.owner!.firstName} ${widget.project.owner!.lastName}'
                                      .obscure(),
                                  style: Theme.of(context).textTheme.labelLarge
                                      ?.copyWith(fontWeight: FontWeight.w600),
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
                            UserRating(rating: 4.5),
                          ],
                        ).margin(const EdgeInsets.all(16.0)),
                      ),
                  ],
                ),
              ).margin(const EdgeInsets.only(top: 16.0)),
            ],
          ).margin(const EdgeInsets.symmetric(horizontal: 8.0));
        },
      ),

      bottomNavigationBar: FutureBuilder(
        future: _loadDataFuture,

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
          ).margin(const EdgeInsets.all(8.0)).useSafeArea();
        },
      ),
    );
  }

  Future<(ProjectPayment, List<ProjectSkill>)> _loadData() async {
    final payment = await ref
        .read(projectPaymentProvider)
        .getByProject(widget.project.id);
    final skills = await ref
        .read(projectSkillProvider)
        .getByProject(widget.project.id, includeRelations: true);

    return (payment!, skills);
  }
}
