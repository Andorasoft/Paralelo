import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:andorasoft_flutter/andorasoft_flutter.dart';

class AddProjectPage extends ConsumerStatefulWidget {
  static const routeName = 'AddProjectPage';
  static const routePath = '/add-project';

  const AddProjectPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _AddProjectPageState();
  }
}

class _AddProjectPageState extends ConsumerState<AddProjectPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,

      body: Text('Add Project Page').center(),
    ).hideKeyboardOnTap(context);
  }
}
