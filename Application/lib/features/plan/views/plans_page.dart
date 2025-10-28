import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:paralelo/core/imports.dart';
import 'package:paralelo/features/auth/exports.dart';
import 'package:paralelo/features/plan/exports.dart';
import 'package:paralelo/features/user/exports.dart';
import 'package:paralelo/utils/extensions.dart';
import 'package:paralelo/widgets/loading_indicator.dart';
import 'package:paralelo/widgets/navigation_button.dart';

class PlansPage extends ConsumerStatefulWidget {
  static const routePath = '/plans';

  const PlansPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _PlansPageState();
  }
}

class _PlansPageState extends ConsumerState<PlansPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late final Future<(List<Plan>, int)> loadDataFuture;

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

  Widget page((List<Plan>, int) data) {
    final (plans, planId) = data;

    return Scaffold(
      key: scaffoldKey,

      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: const NavigationButton(),
      ),

      body: ListView(
        padding: Insets.h16v8,
        children: plans
            .map(
              (i) => PlanCard(
                plan: i,
                onTap: () {},
                icon: switch (i.name) {
                  'Premium' => LucideIcons.crown,
                  'Pro' => LucideIcons.star,
                  _ => LucideIcons.send,
                },
                backgroundColor: switch (i.name) {
                  'Premium' => Theme.of(
                    context,
                  ).colorScheme.secondaryContainer.withAlpha(64),
                  'Pro' => Theme.of(
                    context,
                  ).colorScheme.primaryContainer.withAlpha(128),
                  _ => null,
                },
                borderColor: switch (i.name) {
                  'Premium' => Theme.of(context).colorScheme.secondary,
                  'Pro' => Theme.of(context).colorScheme.primary,
                  _ => null,
                },
                borderWidth: 2.0,
                isCurrent: i.id == planId,
              ),
            )
            .divide(const SizedBox(height: 16.0)),
      ).useSafeArea(),
    );
  }

  Future<(List<Plan>, int)> loadData() async {
    final userId = ref.read(authProvider)!.id;

    final (plans, user) = await (
      ref.read(planProvider).getAll(),
      ref.read(userProvider).getById(userId),
    ).wait;

    return (plans, user!.planId!);
  }
}
