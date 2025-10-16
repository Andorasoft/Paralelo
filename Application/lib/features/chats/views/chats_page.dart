import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:paralelo/core/imports.dart';
import 'package:paralelo/features/auth/controllers/auth_provider.dart';
import 'package:paralelo/features/chats/controllers/chat_room_provider.dart';
import 'package:paralelo/features/chats/models/chat_room.dart';
import 'package:paralelo/features/chats/views/chat_room_page.dart';
import 'package:paralelo/features/chats/widgets/chat_tile.dart';
import 'package:paralelo/features/projects/controllers/project_provider.dart';
import 'package:paralelo/features/projects/models/project.dart';
import 'package:paralelo/features/proposal/controllers/proposal_provider.dart';
import 'package:paralelo/utils/formatters.dart';
import 'package:paralelo/widgets/empty_indicator.dart';
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
  late final Future<List<(ChatRoom, Project)>> loadDataFuture;

  final tabs = ['all', 'unread', 'ongoing_projects'];
  String selectedTab = 'all';

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
        titleSpacing: 8.0,

        title: Text('nav.chats'.tr()),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(44.0),
          child: SearchBar(
            onSubmitted: (query) {},

            leading: const Icon(LucideIcons.search),
            hintText: 'input.search_chats'.tr(),
          ).size(height: 44.0).margin(const EdgeInsets.all(4.0)),
        ),
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

          final list = snapshot.data!;

          return ListView(
            scrollDirection: Axis.vertical,

            children: [
              Row(
                spacing: 8.0,

                children: tabs
                    .map(
                      (key) => ChoiceChip(
                        selected: selectedTab == key,
                        onSelected: (selected) {
                          if (selected) {
                            safeSetState(() => selectedTab = key);
                          }
                        },

                        showCheckmark: false,
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100.0),
                        ),

                        label: Text('chip.$key'.tr()),
                      ),
                    )
                    .toList(),
              ),
              ...list
                  .map((i) {
                    final (room, project) = i;
                    final user = room.user1Id == ref.read(authProvider)!.id
                        ? room.user2Id
                        : room.user1Id;

                    return ChatTile(
                      onTap: () async {
                        await ref
                            .read(goRouterProvider)
                            .push(ChatRoomPage.routePath, extra: (room, user));
                      },
                      title: user.obscure(),
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

  Future<List<(ChatRoom, Project)>> loadData() async {
    final userId = ref.read(authProvider)!.id;
    final chatRepo = ref.read(chatRoomProvider);
    final proposalRepo = ref.read(proposalProvider);
    final projectRepo = ref.read(projectProvider);

    final chats = await chatRepo.getForUser(userId);

    if (chats.isEmpty) return [];

    // Obtener todas las proposal IDs únicas
    final proposalIds = chats.map((c) => c.proposalId).toSet().toList();
    final proposals = await proposalRepo.getByIds(proposalIds);

    // Obtener todos los project IDs únicos de esas proposals
    final projectIds = proposals.map((p) => p.projectId).toSet().toList();
    final projects = await projectRepo.getByIds(projectIds);

    // Mapear por ID para acceso rápido
    final proposalMap = {for (var p in proposals) p.id: p};
    final projectMap = {for (var p in projects) p.id: p};

    // Armar resultado final
    return chats
        .map((chat) {
          final proposal = proposalMap[chat.proposalId];
          if (proposal == null) return null;

          final project = projectMap[proposal.projectId];
          if (project == null) return null;

          return (chat, project);
        })
        .whereType<(ChatRoom, Project)>()
        .toList();
  }
}
