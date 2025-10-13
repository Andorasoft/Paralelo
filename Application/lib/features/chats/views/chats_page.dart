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

  late final Future<List<_ChatProjectRelation>> _loadDataFuture;

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

      appBar: AppBar(
        titleSpacing: 8.0,

        title: const Text('Chats'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(44.0),
          child: SearchBar(
            onSubmitted: (query) {},

            leading: const Icon(LucideIcons.search),
            hintText: 'Buscar conversaciones...',
          ).size(height: 44.0).margin(const EdgeInsets.all(4.0)),
        ),
      ),

      body: FutureBuilder(
        future: _loadDataFuture,

        builder: (_, snapshot) {
          if (!snapshot.hasData) {
            return const LoadingIndicator().center();
          }

          final list = snapshot.data as List<_ChatProjectRelation>;

          return ListView(
            scrollDirection: Axis.vertical,

            children: [
              Row(
                spacing: 8.0,

                children: _tabs
                    .map(
                      (t) => ChoiceChip(
                        selected: _selectedTab == t,
                        onSelected: (selected) {
                          if (selected) {
                            safeSetState(() => _selectedTab = t);
                          }
                        },

                        showCheckmark: false,
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(100.0),
                        ),

                        label: Text(t),
                      ),
                    )
                    .toList(),
              ),
              ...list
                  .map((i) {
                    final user = i.chat.user1Id == ref.read(authProvider)!.id
                        ? i.chat.user2
                        : i.chat.user1;

                    return ChatTile(
                      onTap: () async {
                        await ref
                            .read(goRouterProvider)
                            .push(
                              ChatRoomPage.routePath,
                              extra: {
                                'room_id': i.chat.id,
                                'recipient_id': user.id,
                              },
                            );
                      },
                      title: '${user!.firstName} ${user.lastName}'.obscure(),
                      subtitle: i.project.title,
                    );
                  })
                  .divide(const Divider(height: 9.0)),
            ],
          ).margin(const EdgeInsets.symmetric(horizontal: 8.0));
        },
      ),
    ).hideKeyboardOnTap(context);
  }

  Future<List<_ChatProjectRelation>> _loadData() async {
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

        if (project == null) return null;

        return _ChatProjectRelation(chat, project);
      }),
    );

    return results.whereType<_ChatProjectRelation>().toList();
  }
}

class _ChatProjectRelation {
  final ChatRoom chat;
  final Project project;

  const _ChatProjectRelation(this.chat, this.project);
}
