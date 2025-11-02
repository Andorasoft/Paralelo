import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:paralelo/core/imports.dart';
import 'package:paralelo/utils/extensions.dart';

class InfoBar extends ConsumerWidget {
  final String title;
  final String message;
  final InfoBarSeverity? severity;
  final bool closable;

  const InfoBar({
    super.key,
    required this.title,
    required this.message,
    this.severity = InfoBarSeverity.info,
    this.closable = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
        side: BorderSide(
          color: switch (severity) {
            InfoBarSeverity.success => Colors.green.shade100,
            InfoBarSeverity.warning => Colors.orange.shade100,
            InfoBarSeverity.error => Colors.red.shade100,
            _ => Colors.blue.shade100,
          },
        ),
      ),
      color: switch (severity) {
        InfoBarSeverity.success => Colors.green.shade50,
        InfoBarSeverity.warning => Colors.orange.shade50,
        InfoBarSeverity.error => Colors.red.shade50,
        _ => Colors.blue.shade50,
      },

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(message),
            ],
          ).expanded(),
          if (closable)
            IconButton(
              onPressed: () {},

              style: Theme.of(context).iconButtonTheme.style?.copyWith(
                padding: WidgetStateProperty.all(EdgeInsets.all(4.0)),
                minimumSize: WidgetStateProperty.all(Size.zero),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              icon: const Icon(LucideIcons.x, size: 20.0),
            ),
        ],
      ).margin(Insets.a12),
    );
  }
}

enum InfoBarSeverity { info, success, warning, error }
