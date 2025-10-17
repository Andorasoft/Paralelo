import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:flutter/material.dart';
import 'package:paralelo/core/imports.dart' hide Badge;

class ChatTile extends ConsumerWidget {
  final void Function() onTap;
  final String title;
  final String? subtitle;
  final bool? unread;

  const ChatTile({
    super.key,
    required this.onTap,
    required this.title,
    this.subtitle,
    this.unread,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: onTap,

      borderRadius: BorderRadius.circular(4.0),

      child: Badge(
        smallSize: 8.0,
        isLabelVisible: unread ?? false,
        alignment: Alignment.centerRight,
        backgroundColor: Theme.of(context).colorScheme.primary,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,

          children: [
            Text(title, style: Theme.of(context).textTheme.bodyLarge),
            if (subtitle != null)
              Text(
                subtitle!,
                softWrap: false,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.outline,
                ),
              ),
          ],
        ).margin(EdgeInsets.only(right: (unread ?? false) ? 16.0 : 0.0)),
      ).margin(const EdgeInsets.all(8.0)),
    );
  }
}
