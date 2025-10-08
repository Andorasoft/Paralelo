import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:andorasoft_flutter/andorasoft_flutter.dart';

class CalendarPage extends ConsumerStatefulWidget {
  static const routeName = 'CalendarPage';
  static const routePath = '/calendar';

  const CalendarPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _CalendarPageState();
  }
}

class _CalendarPageState extends ConsumerState<CalendarPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,

      body: Text('Calendar Page').center(),
    ).hideKeyboardOnTap(context);
  }
}
