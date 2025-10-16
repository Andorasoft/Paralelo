import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:paralelo/core/imports.dart';
import 'package:paralelo/features/auth/exports.dart';
import 'package:paralelo/features/projects/controllers/project_provider.dart';
import 'package:paralelo/features/projects/models/project.dart';
import 'package:paralelo/features/projects/widgets/project_card.dart';
import 'package:paralelo/widgets/empty_indicator.dart';
import 'package:paralelo/widgets/loading_indicator.dart';
import 'package:paralelo/widgets/navigation_button.dart';

class MyProjectsPage extends ConsumerStatefulWidget {
  static const routeName = 'MyProjectsPage';
  static const routePath = '/my-projects';

  const MyProjectsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _MyProjectsPageState();
  }
}

class _MyProjectsPageState extends ConsumerState<MyProjectsPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late final Future<List<Project>> loadDataFuture;

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

        leading: const NavigationButton(),

        title: Text('setting.options.my_projects'.tr()),
      ),

      body: FutureBuilder(
        future: loadDataFuture,
        builder: (_, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const LoadingIndicator().center();
          }

          if (!snapshot.hasData || (snapshot.data?.isEmpty ?? true)) {
            return const EmptyIndicator().center();
          }

          final projects = snapshot.data!;

          return ListView(
            children: projects.map((p) => ProjectCard(project: p)).toList(),
          ).margin(const EdgeInsets.all(8.0));
        },
      ),
    );
  }

  Future<List<Project>> loadData() async {
    final userId = ref.read(authProvider)!.id;
    return await ref.read(projectProvider).getForUser(userId);
  }
}
