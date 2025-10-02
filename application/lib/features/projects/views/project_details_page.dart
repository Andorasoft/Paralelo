import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';

import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:paralelo/features/projects/controllers/project_payment_provider.dart';
import 'package:paralelo/features/projects/controllers/project_skill_provider.dart';
import 'package:paralelo/features/projects/models/project.dart';
import 'package:paralelo/features/projects/models/project_payment.dart';
import 'package:paralelo/features/projects/models/project_skill.dart';
import 'package:paralelo/features/projects/widgets/project_report_button.dart';
import 'package:paralelo/features/proposal/views/create_proposal_page.dart';
import 'package:paralelo/features/user/controllers/app_user_provider.dart';
import 'package:paralelo/features/user/models/app_user.dart';
import 'package:paralelo/widgets/loading_indicator.dart';
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
  late Future<(Project, ProjectPayment, List<ProjectSkill>, AppUser)>
  loadDataFuture;

  @override
  void initState() {
    super.initState();

    loadDataFuture = _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: IconButton(
          onPressed: () {
            ref.read(goRouterProvider).pop();
          },
          icon: Icon(LucideIcons.chevronLeft),
        ).align(AlignmentGeometry.centerLeft),
      ),

      body: FutureBuilder(
        future: loadDataFuture,
        builder: (_, snapshot) {
          if (!snapshot.hasData) {
            return LoadingIndicator();
          }

          final (project, projectPayment, projectSkills, user) = snapshot.data!;

          return ListView(
            children: [
              Text(
                project.title,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text('Publicado en ${project.createdAt.toLongDateString()}'),

              Card(
                elevation: 0.0,
                margin: const EdgeInsets.symmetric(vertical: 24.0),
                color: Colors.transparent,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 1.0,
                    color: Theme.of(context).colorScheme.primaryContainer,
                  ),
                  borderRadius: BorderRadiusGeometry.circular(8.0),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: 12.0,

                  children: [
                    Text(
                      '${projectPayment.currency} ${projectPayment.min} - ${projectPayment.max}',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.end,
                    ),
                    Text(project.description),

                    Text(
                      'Required skills',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Wrap(
                      children: projectSkills
                          .map((s) => Chip(label: Text(s.skillId.toString())))
                          .toList(),
                    ),
                  ],
                ).margin(const EdgeInsets.all(16.0)),
              ),

              Column(children: [Text('${user.firstName} ${user.lastName}')]),

              ProjectReportButton().center(),
            ],
          ).margin(const EdgeInsets.symmetric(horizontal: 16.0));
        },
      ),

      bottomNavigationBar: FutureBuilder(
        future: loadDataFuture,
        builder: (_, snapshot) {
          return FilledButton(
            onPressed: snapshot.hasData
                ? () async {
                    await ref
                        .read(goRouterProvider)
                        .push(
                          CreateProposalPage.routePath,
                          extra: widget.project,
                        );
                  }
                : null,
            style: Theme.of(context).filledButtonTheme.style?.copyWith(
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
            child: const Text('Ofrecer ayuda'),
          ).margin(const EdgeInsets.symmetric(horizontal: 16)).useSafeArea();
        },
      ).margin(const EdgeInsets.symmetric(horizontal: 16.0)).useSafeArea(),
    );
  }

  Future<(Project, ProjectPayment, List<ProjectSkill>, AppUser)>
  _loadData() async {
    final payment = (await ref
        .read(projectPaymentProvider)
        .getByProject(widget.project.id))!;
    final skills = (await ref
        .read(projectSkillProvider)
        .getByProject(widget.project.id));
    final owner = (await ref
        .read(appUserProvider)
        .getById(widget.project.ownerId))!;

    return (widget.project, payment, skills, owner);
  }
}
