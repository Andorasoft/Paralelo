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
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();

    _loadDataFuture = loadData();
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

                onSubmitted: (query) {
                  safeSetState(() => _searchQuery = query);
                },

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

          final projects = (snapshot.data! as List<Project>)
              .where(
                (p) => p.title.toLowerCase().contains(
                  _searchQuery.trim().toLowerCase(),
                ),
              )
              .toList();

          return ListView(
            children: [
              ...projects.map(
                (p) => ProjectCard(
                  project: p,
                  isPremium: (projects.indexOf(p) % 2) == 0,
                ),
              ),

              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 128.0,

                children: [
                  IconButton.filledTonal(
                    onPressed: null,
                    icon: const Icon(LucideIcons.chevronLeft),
                  ),
                  IconButton.filledTonal(
                    onPressed: () {},
                    icon: const Icon(LucideIcons.chevronRight),
                  ),
                ],
              ).margin(const EdgeInsets.symmetric(vertical: 28.0)),
            ],
          ).margin(const EdgeInsets.all(8.0));
        },
      ),
    ).hideKeyboardOnTap(context);
  }

  Future<dynamic> loadData() async {
    final user = ref.read(authProvider)!;
    return await ref.read(projectProvider).getAll(user.id);
  }
}
