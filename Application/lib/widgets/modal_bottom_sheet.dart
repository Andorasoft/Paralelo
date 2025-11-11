import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:paralelo/core/imports.dart';

class ModalBottomSheet extends ConsumerWidget {
  final Widget child;
  final Key? formKey;
  final PreferredSizeWidget? title;
  final PreferredSizeWidget? bottom;

  const ModalBottomSheet({
    super.key,
    required this.child,
    this.title,
    this.bottom,
  }) : formKey = null;

  const ModalBottomSheet.form({
    super.key,
    required this.child,
    required this.formKey,
    required this.title,
    this.bottom,
  });

  @override
  Widget build(BuildContext context, WidgetRef _) {
    final padding = EdgeInsets.fromLTRB(
      16.0,
      16.0,
      16.0,
      MediaQuery.of(context).padding.bottom > 0.0 ? 0.0 : 16.0,
    );

    return Padding(
      padding: padding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 8.0,

        children: [
          if (title != null)
            DefaultTextStyle(
              style: Theme.of(
                context,
              ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w500),
              child: title!,
            ),

          if (formKey != null) Form(key: formKey, child: child) else child,

          if (bottom != null) bottom!,
        ],
      ),
    ).useSafeArea().hideKeyboardOnTap(context);
  }
}
