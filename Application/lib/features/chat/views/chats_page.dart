import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:paralelo/core/imports.dart';
import 'package:paralelo/core/providers.dart';
import 'package:paralelo/core/router.dart';
import 'package:paralelo/features/auth/exports.dart';
import 'package:paralelo/features/chat/exports.dart';
import 'package:paralelo/features/project/exports.dart';
import 'package:paralelo/features/proposal/exports.dart';
import 'package:paralelo/features/user/exports.dart';
import 'package:paralelo/utils/extensions.dart';
import 'package:paralelo/utils/formatters.dart';
import 'package:paralelo/widgets/skeleton.dart';
import 'package:paralelo/widgets/skeleton_block.dart';

class ChatsPage extends ConsumerStatefulWidget {
  static const routePath = '/chats';

  const ChatsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _ChatsPageState();
  }
}

class _ChatsPageState extends ConsumerState<ChatsPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late final Future<List<(ChatRoom, Project, User)>> loadDataFuture;

  final tabs = ['all', 'unread', 'ongoing_projects'];
  String selectedTab = 'all';

  @override
  void initState() {
    super.initState();

    loadDataFuture = loadData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadDataFuture,
      builder: (_, snapshot) {
        if (!snapshot.hasData) {
          return skeleton();
        }

        return page(snapshot.data!);
      },
    ).hideKeyboardOnTap(context);
  }

  Widget skeleton() {
    return Skeleton(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        key: scaffoldKey,

        appBar: AppBar(
          titleSpacing: 16.0,
          title: const SkeletonBlock(
            radius: 100.0,
            width: double.infinity,
            height: 44.0,
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(32.0),
            child: Row(
              spacing: 12.0,
              children: [
                for (int i = 0; i < 3; i++)
                  const SkeletonBlock(radius: 100.0, width: 80.0, height: 24.0),
              ],
            ).margin(Insets.h16v8),
          ),
        ),

        body: ListView(
          shrinkWrap: true,
          children: [
            for (int i = 0; i < 4; i++) ...[
              const SkeletonBlock(
                radius: 100.0,
                width: 64.0,
                height: 16.0,
              ).align(Alignment.centerLeft),
              const SkeletonBlock(
                radius: 100.0,
                width: double.infinity,
                height: 16.0,
              ),
              if (i < 3) const SizedBox(height: 13.0),
            ],
          ].divide(const SizedBox(height: 8.0)),
        ).margin(Insets.h16v8),
      ),
    );
  }

  Widget page(List<(ChatRoom, Project, User)> data) {
    return Scaffold(
      key: scaffoldKey,

      appBar: AppBar(
        titleSpacing: 16.0,
        title: SearchBar(
          onSubmitted: (query) {},

          leading: const Icon(LucideIcons.search),
          hintText: 'input.search_chats'.tr(),
        ).size(height: 44.0),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(32.0),
          child: Row(
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

                    padding: EdgeInsets.zero,
                    labelPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity.compact,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.0),
                    ),

                    label: Text(
                      'chip.$key'.tr(),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                )
                .toList(),
          ).margin(Insets.h16),
        ),
      ),

      body: data.isNotEmpty
          ? ListView(
              children: data
                  .map((i) {
                    final (room, project, user) = i;

                    final unreadAsync = ref.watch(unreadProvider(room.id));
                    final currentUserId = ref.read(authProvider)!.id;

                    final hasUnread = unreadAsync.maybeWhen(
                      data: (data) => data?[currentUserId] == true,
                      orElse: () => false,
                    );

                    return ChatTile(
                      onTap: () async {
                        await ref
                            .read(goRouterProvider)
                            .push(ChatRoomPage.routePath, extra: room.id);
                      },
                      title: user.displayName.obscure(),
                      subtitle: project.title,
                      unread: hasUnread,
                    );
                  })
                  .divide(const Divider(height: 13.0).margin(Insets.h16)),
            ).margin(Insets.v8)
          : Text('empty'.tr()).center(),
    );
  }

  Future<List<(ChatRoom, Project, User)>> loadData() async {
    final userId = ref.read(authProvider)!.id;
    final userRepo = ref.read(userProvider);
    final chatRepo = ref.read(chatRoomProvider);
    final proposalRepo = ref.read(proposalProvider);
    final projectRepo = ref.read(projectProvider);

    final chats = await chatRepo.getForUser(userId);

    if (chats.isEmpty) return [];

    // Get all unique proposal IDs
    final proposalIds = chats.map((c) => c.proposalId).toSet().toList();
    final proposals = await proposalRepo.getByIds(proposalIds);

    // Get all unique project IDs for those proposals
    final projectIds = proposals.map((p) => p.projectId).toSet().toList();
    final projects = await projectRepo.getByIds(projectIds);

    // Map by ID for quick access
    final proposalMap = {for (var p in proposals) p.id: p};
    final projectMap = {for (var p in projects) p.id: p};

    // Assemble final result
    final results = await Future.wait(
      chats.map((chat) async {
        final proposal = proposalMap[chat.proposalId];
        if (proposal == null) return null;

        final project = projectMap[proposal.projectId];
        if (project == null) return null;

        final user = await userRepo.getById(
          chat.user1Id == userId ? chat.user2Id : chat.user1Id,
        );
        if (user == null) return null;

        return (chat, project, user);
      }),
    );

    return results.whereType<(ChatRoom, Project, User)>().toList();
  }
}
