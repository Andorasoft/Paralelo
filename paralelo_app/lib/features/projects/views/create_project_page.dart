import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:andorasoft_flutter/andorasoft_flutter.dart';

class CreateProjectPage extends ConsumerStatefulWidget {
  static const routeName = 'CreateProjectPage';
  static const routePath = '/create-project';

  const CreateProjectPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _CreateProjectPageState();
  }
}

class _CreateProjectPageState extends ConsumerState<CreateProjectPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,

      body: Text('Add Project Page').center(),
    ).hideKeyboardOnTap(context);
  }
}
