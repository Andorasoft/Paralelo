import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';

import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:paralelo/features/auth/controllers/auth_notifier.dart';
import 'package:paralelo/features/projects/controllers/project_provider.dart';
import 'package:paralelo/features/projects/models/project.dart';
import 'package:paralelo/features/projects/widgets/project_filter_button.dart';
import 'package:paralelo/features/projects/widgets/project_card.dart';
import 'package:paralelo/features/projects/widgets/project_sort_button.dart';
import 'package:paralelo/features/proposal/controllers/proposal_provider.dart';
import 'package:paralelo/widgets/loading_indicator.dart';

class MarketplacePage extends ConsumerStatefulWidget {
  static const routeName = 'MarketplacePage';
  static const routePath = '/marketplace';

  const MarketplacePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return MarketplacePageState();
  }
}

class MarketplacePageState extends ConsumerState<MarketplacePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  late final Future<dynamic> _loadDataFuture;

  @override
  void initState() {
    super.initState();

    _loadDataFuture = _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,

      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 8.0,

        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48.0),

          child: Row(
            spacing: 8.0,

            children: [
              SearchBar(
                padding: WidgetStateProperty.all(
                  const EdgeInsets.symmetric(horizontal: 12.0),
                ),

                leading: const Icon(LucideIcons.search),
                hintText: 'Buscar proyectos...',
              ).size(height: 44.0).expanded(),
              const ProjectSortButton(),
              const ProjectFilterButton(),
            ],
          ).margin(const EdgeInsets.symmetric(horizontal: 8.0)),
        ),
      ),

      body: FutureBuilder(
        future: _loadDataFuture,
        builder: (_, snapshot) {
          if (!snapshot.hasData) {
            return const LoadingIndicator().center();
          }

          final map = snapshot.data as List<Map<String, dynamic>>;

          return ListView.builder(
            itemCount: map.length,

            itemBuilder: (_, i) {
              return ProjectCard(
                project: map[i]['project'] as Project,
                isPremium: (i % 2) == 0,
                applied: map[i]['applied'] as bool,
              );
            },
          ).margin(const EdgeInsets.all(8.0));
        },
      ),
    ).hideKeyboardOnTap(context);
  }

  Future<List<Map<String, dynamic>>> _loadData() async {
    final result = <Map<String, dynamic>>[];

    final userId = ref.read(authProvider)!.id;
    final projects = await ref
        .read(projectProvider)
        .getAll(userId, includeRelations: true);
    final appliedList = await Future.wait(
      projects.map((p) => ref.read(proposalProvider).applied(p.id)),
    );

    for (var i = 0; i < projects.length; i++) {
      result.add({'project': projects[i], 'applied': appliedList[i]});
    }

    return result;
  }
}
