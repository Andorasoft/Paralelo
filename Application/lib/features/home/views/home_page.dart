import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:paralelo/core/imports.dart';
import 'package:paralelo/features/auth/exports.dart';
import 'package:paralelo/features/home/exports.dart';
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
  late final Future<(User, int, int)> loadDataFuture;

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

  Widget page((User, int, int) data) {
    final (user, collaborations, conections) = data;

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
          CreditsSummaryCard(credits: 0.00, collaborations: collaborations),
          CommunityGrowthCard(),
          UserLevelCard(level: UserLevel.rookie),
          UpgradeLevelCard(),
          CampusActivityCard(conections: conections),
          Text(
            'Proyectos para ti',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
          ).margin(const EdgeInsets.only(top: 8.0, bottom: 4.0)),
        ].divide(const SizedBox(height: 16.0)),
      ),
    );
  }

  Future<(User, int, int)> loadData() async {
    final userId = ref.read(authProvider)!.id;

    final (user, collaborations, conections) = await (
      ref.read(userProvider).getById(userId),
      ref.read(collaborationProvider).getForUser(userId),
      ref.read(conectionProvider).getForUser(userId),
    ).wait;

    return (user!, collaborations, conections);
  }

  String firstName(String fullName) {
    return fullName.split(' ')[0];
  }

  String lastName(String fullName) {
    return fullName.split(' ')[2];
  }
}
