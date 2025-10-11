import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:andorasoft_flutter/andorasoft_flutter.dart';

class ChatTile extends ConsumerStatefulWidget {
  final void Function() onTap;
  final String title;
  final String? subtitle;

  const ChatTile({
    super.key,
    required this.onTap,
    required this.title,
    this.subtitle,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return ChatTileState();
  }
}

class ChatTileState extends ConsumerState<ChatTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,

      borderRadius: BorderRadius.circular(4.0),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,

        children: [
          Text(widget.title),
          if (widget.subtitle != null) Text(widget.subtitle!),
        ],
      ).margin(const EdgeInsets.all(8.0)),
    );
  }
}
