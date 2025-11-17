import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:paralelo/core/constants.dart';
import 'package:paralelo/core/imports.dart';
import 'package:paralelo/core/providers.dart';
import 'package:paralelo/core/services.dart';
import 'package:paralelo/features/auth/exports.dart';
import 'package:paralelo/features/chat/exports.dart';
import 'package:paralelo/features/proposal/exports.dart';
import 'package:paralelo/features/user/exports.dart';
import 'package:paralelo/features/user_rating/exports.dart';
import 'package:paralelo/utils/helpers.dart';
import 'package:paralelo/widgets/navigation_button.dart';
import 'package:paralelo/widgets/skeleton.dart';
import 'package:paralelo/widgets/skeleton_block.dart';

class ChatRoomPage extends ConsumerStatefulWidget {
  static const routePath = '/chat-room';

  final String roomId;

  const ChatRoomPage({super.key, required this.roomId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _ChatRoomPageState();
  }
}

class _ChatRoomPageState extends ConsumerState<ChatRoomPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late final Future<(ChatRoom, User, Proposal)> loadDataFuture;
  late final String userId;

  @override
  void initState() {
    super.initState();

    userId = ref.read(authProvider)!.id;
    loadDataFuture = loadData();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ChatService.instance.markAsRead(
        roomId: widget.roomId,
        userId: userId,
      );
    });
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
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: Skeleton(
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: Colors.transparent,

          appBar: AppBar(
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
        ),
      ),
    );
  }

  Widget page((ChatRoom, User, Proposal) data) {
    final (room, recipient, proposal) = data;

    final messagesAsync = ref.watch(messagesProvider(widget.roomId));

    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: true,

      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 64.0,

        leading: const NavigationButton(),
        title: Text(obscureText(recipient.displayName)),
        actions: const [RatingPresenter(rating: 0.0)],

        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(36.0),
          child: ShowProposalButton(proposalId: proposal.id).size(height: 36.0),
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
                      isFromCurrentUser: msg['recipient'] == recipient.id,
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
              await ChatService.instance.sendMessage(
                roomId: widget.roomId,
                senderId: userId,
                recipientId: recipient.id,
                text: message,
              );
            },
          ).useSafeArea(),
        ],
      ).margin(Insets.h16v8),
    ).hideKeyboardOnTap(context);
  }

  Future<(ChatRoom, User, Proposal)> loadData() async {
    final room = await ref.read(chatRoomProvider).getById(widget.roomId);

    final recipientId = room!.user1Id == userId ? room.user2Id : room.user1Id;

    final (recipient, proposal) = await (
      ref.read(userProvider).getById(recipientId),
      ref.read(proposalProvider).getById(room.proposalId),
    ).wait;

    return (room, recipient!, proposal!);
  }
}
