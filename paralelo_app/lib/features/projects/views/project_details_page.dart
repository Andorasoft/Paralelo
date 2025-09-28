import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';

import 'package:paralelo/features/projects/controllers/project_payment_provider.dart';
import 'package:paralelo/features/projects/controllers/project_provider.dart';
import 'package:paralelo/features/projects/controllers/project_skill_provider.dart';
import 'package:paralelo/features/projects/models/project.dart';
import 'package:paralelo/features/projects/models/project_payment.dart';
import 'package:paralelo/features/projects/models/project_requirement.dart';
import 'package:paralelo/features/projects/models/project_skill.dart';
import 'package:paralelo/features/projects/models/skill.dart';
import 'package:paralelo/features/projects/widgets/project_report_form.dart';
import 'package:paralelo/features/user/controllers/app_user_provider.dart';
import 'package:paralelo/features/user/models/app_user.dart';
import 'package:paralelo/widgets/loading_indicator.dart';
import 'package:paralelo/core/router.dart';

class ProjectDetailsPage extends ConsumerStatefulWidget {
  static const routeName = 'ProjectDetailsPage';
  static const routePath = '/project-details';

  final int projectId;

  const ProjectDetailsPage({super.key, required this.projectId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _ProjectDetailsPageState();
  }
}

class _ProjectDetailsPageState extends ConsumerState<ProjectDetailsPage> {
  late Project project;
  late ProjectPayment projectPayment;
  late ProjectRequirement projectRequirement;
  late List<ProjectSkill> projectSkills;
  late AppUser user;

  late Future<List<Object?>> loadProjectFuture;
  late Future<AppUser?> loadOwnerFuture;

  bool isReady = false;

  @override
  void initState() {
    super.initState();

    loadProjectFuture = loadProject();
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
        future: loadProjectFuture,
        builder: (_, snapshot) {
          if (!snapshot.hasData) {
            return LoadingIndicator();
          }

          project = snapshot.data![0] as Project;
          projectPayment = snapshot.data![1] as ProjectPayment;
          projectSkills = snapshot.data![2] as List<ProjectSkill>;

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

              FutureBuilder(
                future: loadOwnerFuture,
                builder: (_, snapshot) {
                  if (!snapshot.hasData) {
                    return LoadingIndicator();
                  }

                  if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }

                  user = snapshot.data!;

                  return Column(
                    children: [Text('${user.firstName} ${user.lastName}')],
                  );
                },
              ),

              TextButton.icon(
                onPressed: () async {
                  final _ = await showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (_) {
                      return ProjectReportForm().useSafeArea();
                    },
                  );
                },

                icon: Icon(
                  LucideIcons.flag,
                  color: Theme.of(context).colorScheme.outline,
                ),
                label: Text(
                  'Reportar esta publicación',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ),
              ).center(),
            ],
          ).margin(const EdgeInsets.symmetric(horizontal: 16.0));
        },
      ),

      bottomNavigationBar: FilledButton(
        onPressed: () {},
        style: Theme.of(context).filledButtonTheme.style?.copyWith(
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(100.0),
            ),
          ),
        ),
        child: Text('Ofrecer ayuda'),
      ).margin(const EdgeInsets.symmetric(horizontal: 16.0)).useSafeArea(),
    );
  }

  Future<void> loadData() async {
    project = (await ref.read(projectProvider).getById(widget.projectId))!;
    projectPayment = (await ref
        .read(projectPaymentProvider)
        .getByProject(widget.projectId))!;
    projectSkills = (await ref
        .read(projectSkillProvider)
        .getByProject(widget.projectId));
    user = (await ref.read(appUserProvider).getById(project.ownerId))!;

    safeSetState(() => isReady = true);
  }

  Future<List<Object?>> loadProject() {
    return Future.wait([
      ref.read(projectProvider).getById(widget.projectId),
      ref.read(projectPaymentProvider).getByProject(widget.projectId),
      ref.read(projectSkillProvider).getByProject(widget.projectId),
    ]);
  }

  Future<Skill> loadSkill() {
    throw UnimplementedError();
  }

  Future<AppUser?> loadOwner() {
    return ref.read(appUserProvider).getById(project.ownerId);
  }
}
