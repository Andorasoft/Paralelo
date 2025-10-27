import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:paralelo/core/imports.dart';
import 'package:paralelo/core/router.dart';

class NavigationButton extends ConsumerWidget {
  final NavigationButtonType type;

  const NavigationButton({super.key, this.type = NavigationButtonType.back});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Tooltip(
      message: type == NavigationButtonType.back
          ? 'button.back'.tr()
          : 'button.close'.tr(),

      child: IconButton(
        onPressed: () => ref.read(goRouterProvider).pop(),

        icon: Icon(
          type == NavigationButtonType.back
              ? LucideIcons.chevronLeft
              : LucideIcons.x,
          size: 24.0,
          color: Theme.of(context).colorScheme.outline,
        ),
      ),
    ).align(Alignment.centerRight);
  }
}

enum NavigationButtonType { back, close }
