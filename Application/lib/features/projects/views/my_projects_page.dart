import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:paralelo/features/auth/controllers/auth_notifier.dart';
import 'package:paralelo/features/projects/controllers/project_provider.dart';
import 'package:paralelo/features/projects/models/project.dart';
import 'package:paralelo/features/projects/widgets/project_card.dart';
import 'package:paralelo/widgets/loading_indicator.dart';
import 'package:paralelo/widgets/navigation_button.dart';

class MyProjectsPage extends ConsumerStatefulWidget {
  static const routeName = 'MyProjectsPage';
  static const routePath = '/my-projects';

  const MyProjectsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return MyProjectsPageState();
  }
}

class MyProjectsPageState extends ConsumerState<MyProjectsPage> {
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

        leading: const NavigationButton(),

        title: Text('setting.options.my_projects'.tr()),
      ),

      body: FutureBuilder(
        future: _loadDataFuture,
        builder: (_, snapshot) {
          if (!snapshot.hasData) {
            return const LoadingIndicator().center();
          }

          final projects = snapshot.data as List<Project>;

          return ListView(
            children: projects.map((p) => ProjectCard(project: p)).toList(),
          ).margin(const EdgeInsets.all(8.0));
        },
      ),
    );
  }

  Future<List<Project>> _loadData() async {
    final userId = ref.read(authProvider)!.id;
    return await ref.read(projectProvider).getForUser(userId);
  }
}
