import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';

import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:paralelo/features/auth/controllers/auth_notifier.dart';
import 'package:paralelo/features/chats/controllers/chat_room_provider.dart';
import 'package:paralelo/features/chats/models/chat_room.dart';
import 'package:paralelo/features/chats/views/chat_room_page.dart';
import 'package:paralelo/features/chats/widgets/chat_tile.dart';
import 'package:paralelo/features/projects/controllers/project_provider.dart';
import 'package:paralelo/features/projects/models/project.dart';
import 'package:paralelo/utils/formatters.dart';
import 'package:paralelo/widgets/loading_indicator.dart';
import 'package:paralelo/core/router.dart';

class ChatsPage extends ConsumerStatefulWidget {
  static const routeName = 'ChatsPage';
  static const routePath = '/chats';

  const ChatsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return ChatsPageState();
  }
}

class ChatsPageState extends ConsumerState<ChatsPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  late final Future<dynamic> _loadDataFuture;

  final _tabs = ['Todos', 'No leídos', 'Proyectos en curso'];

  String _selectedTab = 'Todos';

  @override
  void initState() {
    super.initState();

    _loadDataFuture = _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,

      appBar: AppBar(title: const Text('Chats')),

      body: FutureBuilder(
        future: _loadDataFuture,
        builder: (_, snapshot) {
          if (!snapshot.hasData) {
            return const LoadingIndicator().center();
          }

          final map = snapshot.data as List<Map<String, dynamic>>;

          return ListView(
            scrollDirection: Axis.vertical,

            children: [
              SearchBar(
                onSubmitted: (query) {},

                leading: const Icon(LucideIcons.search),
                hintText: 'Buscar conversaciones...',
              ).size(height: 44.0),
              Row(
                spacing: 8.0,

                children: _tabs
                    .map(
                      (t) => ChoiceChip(
                        selected: _selectedTab == t,

                        showCheckmark: false,
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(100.0),
                        ),

                        onSelected: (selected) {
                          if (selected) {
                            safeSetState(() => _selectedTab = t);
                          }
                        },
                        label: Text(t),
                      ),
                    )
                    .toList(),
              ).margin(const EdgeInsets.symmetric(vertical: 4.0)),
              ...map
                  .map((m) {
                    final chat = m['chat'] as ChatRoom;
                    final project = m['project'] as Project;
                    final user = chat.user1Id == ref.read(authProvider)!.id
                        ? chat.user2
                        : chat.user1;

                    return ChatTile(
                      onTap: () async {
                        await ref
                            .read(goRouterProvider)
                            .push(
                              ChatRoomPage.routePath,
                              extra: {
                                'room_id': chat.id,
                                'recipient_id': user.id,
                              },
                            );
                      },
                      title: '${user!.firstName} ${user.lastName}'.obscure(),
                      subtitle: project.title,
                    );
                  })
                  .divide(const Divider(height: 9.0)),
            ],
          ).margin(const EdgeInsets.symmetric(horizontal: 8.0));
        },
      ),
    ).hideKeyboardOnTap(context);
  }

  Future<dynamic> _loadData() async {
    final userId = ref.read(authProvider)!.id;

    final chats = await ref
        .read(chatRoomProvider)
        .getForUser(userId, includeRelations: true);

    final results = await Future.wait(
      chats.map((chat) async {
        final projectId = chat.proposal?.projectId;
        if (projectId == null) return null;

        final project = await ref
            .read(projectProvider)
            .getById(projectId, includeRelations: true);

        return {'chat': chat, 'project': project};
      }),
    );

    return results.whereType<Map<String, dynamic>>().toList();
  }
}
