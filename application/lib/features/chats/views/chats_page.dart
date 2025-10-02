import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:andorasoft_flutter/andorasoft_flutter.dart';

class ChatsPage extends ConsumerStatefulWidget {
  static const routeName = 'ChatsPage';
  static const routePath = '/chats';

  const ChatsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _ChatsPageState();
  }
}

class _ChatsPageState extends ConsumerState<ChatsPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,

      body: Text('Chats Page').center(),
    ).hideKeyboardOnTap(context);
  }
}
