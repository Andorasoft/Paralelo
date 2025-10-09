import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';

import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:paralelo/features/auth/controllers/auth_notifier.dart';
import 'package:paralelo/features/chats/controllers/chat_room_provider.dart';
import 'package:paralelo/features/chats/models/chat_room.dart';
import 'package:paralelo/features/chats/views/chat_room_page.dart';
import 'package:paralelo/widgets/loading_indicator.dart';
import 'package:paralelo/core/router.dart';

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

  final tabs = ['Todos', 'No leídos', 'Proyectos en curso'];

  String selectedTab = 'Todos';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,

      appBar: AppBar(title: Text('Chats').align(AlignmentGeometry.centerLeft)),

      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 8.0,

        children: [
          SearchBar(
            padding: WidgetStateProperty.all(
              const EdgeInsets.symmetric(horizontal: 12.0),
            ),

            onSubmitted: (query) {},

            leading: const Icon(LucideIcons.search),
            hintText: 'Buscar conversaciones...',
          ).size(height: 44.0),
          ListView(
            scrollDirection: Axis.horizontal,

            children: tabs
                .map(
                  (t) => ChoiceChip(
                    selected: selectedTab == t,
                    showCheckmark: false,
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(100.0),
                    ),

                    onSelected: (selected) {
                      if (selected) safeSetState(() => selectedTab = t);
                    },
                    label: Text(t),
                  ),
                )
                .divide(const SizedBox(width: 8.0)),
          ).size(height: 36.0),
          FutureBuilder(
            future: loadData(),
            builder: (_, snapshot) {
              if (!snapshot.hasData) {
                return LoadingIndicator();
              }

              final rooms = snapshot.data!;

              return Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 4.0,

                children: rooms
                    .map(
                      (r) => InkWell(
                        onTap: () async {
                          final user = ref.read(authProvider)!;

                          await ref
                              .read(goRouterProvider)
                              .push(
                                ChatRoomPage.routePath,
                                extra: {
                                  'room_id': r.id,
                                  'recipient_id': user.id == r.user1Id
                                      ? r.user2Id
                                      : r.user1Id,
                                },
                              );
                        },

                        child: Text(r.createdAt.toIso8601String()),
                      ),
                    )
                    .toList(),
              );
            },
          ),
        ],
      ).margin(const EdgeInsets.symmetric(horizontal: 16.0)),
    ).hideKeyboardOnTap(context);
  }

  Future<List<ChatRoom>> loadData() {
    return ref.read(chatRoomProvider).getForUser(ref.read(authProvider)!.id);
  }
}
