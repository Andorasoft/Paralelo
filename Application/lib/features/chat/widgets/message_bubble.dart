import 'package:paralelo/core/imports.dart';
import 'package:paralelo/utils/formatters.dart';

class MessageBubble extends ConsumerStatefulWidget {
  final String content;
  final DateTime date;
  final bool isFromCurrentUser;

  const MessageBubble({
    super.key,
    required this.content,
    required this.date,
    this.isFromCurrentUser = false,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return MessageBubbleState();
  }
}

class MessageBubbleState extends ConsumerState<MessageBubble> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: widget.isFromCurrentUser
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      spacing: 8.0,

      children: [
        if (widget.isFromCurrentUser) _buildTextTime(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
          margin: EdgeInsets.zero,

          decoration: BoxDecoration(
            color: widget.isFromCurrentUser
                ? Theme.of(context).colorScheme.secondaryContainer
                : Theme.of(context).colorScheme.surfaceContainer,
            borderRadius: BorderRadiusGeometry.only(
              topLeft: const Radius.circular(12.0),
              topRight: const Radius.circular(12.0),

              bottomLeft: widget.isFromCurrentUser
                  ? const Radius.circular(12.0)
                  : const Radius.circular(0.0),
              bottomRight: widget.isFromCurrentUser
                  ? const Radius.circular(0.0)
                  : const Radius.circular(12.0),
            ),
          ),

          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.65,
            minWidth: 0.0,
          ),

          child: Text(widget.content, softWrap: true),
        ),
        if (!widget.isFromCurrentUser) _buildTextTime(),
      ],
    );
  }

  Widget _buildTextTime() {
    return Text(
      formatToShortDateString(widget.date),
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
        color: Theme.of(context).colorScheme.outline,
      ),
    );
  }
}
