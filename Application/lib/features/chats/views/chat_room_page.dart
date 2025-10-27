import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:paralelo/core/imports.dart';
import 'package:paralelo/features/auth/exports.dart';
import 'package:paralelo/features/chats/exports.dart';
import 'package:paralelo/features/proposal/exports.dart';
import 'package:paralelo/features/user/exports.dart';
import 'package:paralelo/core/providers.dart';
import 'package:paralelo/core/services.dart';
import 'package:paralelo/utils/extensions.dart';
import 'package:paralelo/utils/formatters.dart';
import 'package:paralelo/widgets/navigation_button.dart';
import 'package:paralelo/widgets/skeleton.dart';
import 'package:paralelo/widgets/skeleton_block.dart';

class ChatRoomPage extends ConsumerStatefulWidget {
  static const routeName = 'ChatRoomPage';
  static const routePath = '/chat-room';

  final String roomId;
  final String recipientId;

  const ChatRoomPage({
    super.key,
    required this.roomId,
    required this.recipientId,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _ChatRoomPageState();
  }
}

class _ChatRoomPageState extends ConsumerState<ChatRoomPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late final Future<(User, Proposal)> loadDataFuture;

  @override
  void initState() {
    super.initState();

    loadDataFuture = loadData();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final userId = ref.read(authProvider)!.id;

      await ChatService.instance.markAsRead(
        roomId: widget.roomId,
        userId: userId,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final messagesAsync = ref.watch(messagesProvider(widget.roomId));

    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: true,

      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),

        child: FutureBuilder(
          future: loadDataFuture,
          builder: (_, snapshot) {
            if (!snapshot.hasData) {
              return skeleton();
            }

            return header(snapshot.data!);
          },
        ),
      ),

      body: Column(
        spacing: 8.0,

        children: [
          messagesAsync
              .when(
                data: (messages) => ListView.separated(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (_, i) {
                    final msg = messages[i];

                    return MessageBubble(
                      content: msg['text'] as String,
                      date:
                          (msg['timestamp'] as Timestamp?)?.toDate() ??
                          DateTime.now(),
                      isFromCurrentUser: msg['recipient'] == widget.recipientId,
                    );
                  },

                  separatorBuilder: (_, i) {
                    return const SizedBox(height: 8.0);
                  },
                ),
                loading: () => const CircularProgressIndicator().center(),
                error: (e, _) => Text('Error: $e').center(),
              )
              .expanded(),

          MessageInputBar(
            onSubmitted: (message) async {
              final userId = ref.read(authProvider)!.id;

              await ChatService.instance.sendMessage(
                roomId: widget.roomId,
                senderId: userId,
                recipientId: widget.recipientId,
                text: message,
              );
            },
          ).useSafeArea(),
        ],
      ).margin(Insets.h16v8),
    ).hideKeyboardOnTap(context);
  }

  Widget skeleton() {
    return Skeleton(
      child: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 64.0,
        leading: const SkeletonBlock(
          width: 40.0,
          height: 40.0,
        ).align(Alignment.centerRight),
        title: const SkeletonBlock(width: 94.0, height: 20.0),
        actions: const [SkeletonBlock(width: 32.0, height: 20.0)],

        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(36.0),
          child: SkeletonBlock(
            width: double.infinity,
            height: 36.0,
            radius: 0.0,
          ),
        ),
      ),
    );
  }

  Widget header((User, Proposal) data) {
    final (user, proposal) = data;
    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: 64.0,

      leading: const NavigationButton(),
      title: Text(user.displayName.obscure()),
      actions: const [UserRatingStar(rating: 0.0)],

      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(36.0),
        child: ShowProposalButton(proposalId: proposal.id).size(height: 36.0),
      ),
    );
  }

  Future<(User, Proposal)> loadData() async {
    final (user, room) = await (
      ref.read(userProvider).getById(widget.recipientId),
      ref.read(chatRoomProvider).getById(widget.roomId),
    ).wait;
    final proposal = await ref.read(proposalProvider).getById(room!.proposalId);

    return (user!, proposal!);
  }
}
