import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:paralelo/core/imports.dart';
import 'package:paralelo/features/auth/exports.dart';
import 'package:paralelo/features/home/exports.dart';
import 'package:paralelo/features/project/exports.dart';
import 'package:paralelo/features/user/exports.dart';
import 'package:paralelo/utils/extensions.dart';
import 'package:paralelo/widgets/loading_indicator.dart';
import 'package:paralelo/widgets/person_picture.dart';

class HomePage extends ConsumerStatefulWidget {
  static const routePath = '/home';

  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends ConsumerState<HomePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late final Future<(User, List<Project>, int, int)> loadDataFuture;

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

  Widget page((User, List<Project>, int, int) data) {
    final (user, projects, collaborations, conections) = data;

    return Scaffold(
      key: scaffoldKey,

      appBar: AppBar(
        toolbarHeight: 64.0,
        leading: PersonPicture(
          source: user.pictureUrl ?? '',
          size: 40.0,

          badge: switch (user.planId!) {
            3 => Icon(TablerIcons.crown),
            2 => Icon(LucideIcons.star),
            _ => null,
          },
          side: switch (user.planId!) {
            3 => BorderSide(
              width: 2.0,
              color: Theme.of(context).colorScheme.secondary,
            ),
            2 => BorderSide(
              width: 2.0,
              color: Theme.of(context).colorScheme.primary,
            ),
            _ => BorderSide.none,
          },
        ).align(Alignment.centerRight),
        title: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text(
              '${'hello'.tr()},',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              '${firstName(user.displayName)} ${lastName(user.displayName)}',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),

      body: ListView(
        scrollDirection: Axis.vertical,
        padding: Insets.h16v8,
        children: [
          ...[
            CreditsSummaryCard(credits: 0.00, collaborations: collaborations),
            CommunityGrowthCard(),
            UserLevelCard(level: UserLevel.rookie),
            UpgradeLevelCard(),
            CampusActivityCard(conections: conections),
          ].divide(const SizedBox(height: 16.0)),

          Text(
            'Proyectos para ti',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
          ).margin(const EdgeInsets.only(top: 16.0, bottom: 8.0)),

          ...projects
              .map((i) => ProjectCard(project: i))
              .divide(const SizedBox(height: 16.0)),
        ],
      ),
    );
  }

  Future<(User, List<Project>, int, int)> loadData() async {
    final userId = ref.read(authProvider)!.id;

    final (user, collaborations, conections) = await (
      ref.read(userProvider).getById(userId),
      ref.read(collaborationProvider).getForUser(userId),
      ref.read(conectionProvider).getForUser(userId),
    ).wait;

    final (_, projects) = await ref
        .read(projectProvider)
        .getPaginated(
          excludedUserId: userId,
          universityId: user!.universityId,
          limit: 3,
        );

    return (user, projects, collaborations, conections);
  }

  String firstName(String fullName) {
    return fullName.split(' ')[0];
  }

  String lastName(String fullName) {
    return fullName.split(' ')[2];
  }
}
