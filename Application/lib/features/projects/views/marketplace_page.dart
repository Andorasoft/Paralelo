import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:paralelo/core/imports.dart';
import 'package:paralelo/features/auth/exports.dart';
import 'package:paralelo/features/projects/controllers/project_provider.dart';
import 'package:paralelo/features/projects/models/project.dart';
import 'package:paralelo/features/projects/widgets/project_card.dart';
import 'package:paralelo/features/projects/widgets/project_sort_button.dart';
import 'package:paralelo/features/proposal/controllers/proposal_provider.dart';
import 'package:paralelo/widgets/empty_indicator.dart';
import 'package:paralelo/widgets/loading_indicator.dart';

class MarketplacePage extends ConsumerStatefulWidget {
  static const routeName = 'MarketplacePage';
  static const routePath = '/marketplace';

  const MarketplacePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _MarketplacePageState();
  }
}

class _MarketplacePageState extends ConsumerState<MarketplacePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late Future<(int, int, List<(Project, bool)>)> loadDataFuture;

  @override
  void initState() {
    super.initState();

    loadDataFuture = loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,

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
                hintText: 'input.search_projects'.tr(),
              ).size(height: 44.0).expanded(),
              const ProjectSortButton(),
              // const ProjectFilterButton(),
            ],
          ).margin(const EdgeInsets.symmetric(horizontal: 8.0)),
        ),
      ),

      body: FutureBuilder(
        future: loadDataFuture,

        builder: (_, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const LoadingIndicator().center();
          }

          if (!snapshot.hasData) {
            return const EmptyIndicator().center();
          }

          final (current, total, list) = snapshot.data!;

          return SingleChildScrollView(
            child: Column(
              children: [
                ...list.map((i) {
                  final (project, applied) = i;

                  return ProjectCard(project: project);
                }),

                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 128.0,

                  children: [
                    IconButton.filledTonal(
                      onPressed: current != 1
                          ? () {
                              loadDataFuture = loadData(index: current - 1);
                              safeSetState(() {});
                            }
                          : null,

                      icon: const Icon(LucideIcons.chevronLeft),
                    ),
                    IconButton.filledTonal(
                      onPressed: current != total
                          ? () {
                              loadDataFuture = loadData(index: current + 1);
                              safeSetState(() {});
                            }
                          : null,

                      icon: const Icon(LucideIcons.chevronRight),
                    ),
                  ],
                ).margin(const EdgeInsets.only(top: 32.0)),
              ],
            ).margin(const EdgeInsets.all(12.0)),
          );
        },
      ),
    ).hideKeyboardOnTap(context);
  }

  Future<(int, int, List<(Project, bool)>)> loadData({int index = 1}) async {
    final userId = ref.read(authProvider)!.id;

    final (page, pages, projects) = await ref
        .read(projectProvider)
        .getPaginated(excludedUserId: userId, page: index);

    final appliedList = await Future.wait(
      projects.map((p) => ref.read(proposalProvider).applied(p.id)),
    );

    return (
      page,
      pages,
      [for (var i = 0; i < projects.length; i++) (projects[i], appliedList[i])],
    );
  }
}
