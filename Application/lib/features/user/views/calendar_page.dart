import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:andorasoft_flutter/andorasoft_flutter.dart';

class ProfilePage extends ConsumerStatefulWidget {
  static const routeName = 'CalendarPage';
  static const routePath = '/calendar';

  const ProfilePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return ProfilePageState();
  }
}

class ProfilePageState extends ConsumerState<ProfilePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,

      body: Text('Profile Page').center(),
    ).hideKeyboardOnTap(context);
  }
}
