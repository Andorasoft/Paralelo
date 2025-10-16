import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:andorasoft_flutter/andorasoft_flutter.dart';

class ModalBottomSheet extends ConsumerStatefulWidget {
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
  ConsumerState<ConsumerStatefulWidget> createState() {
    return ModalBottomSheetState();
  }
}

class ModalBottomSheetState extends ConsumerState<ModalBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).padding.bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, bottom > 0.0 ? 0.0 : 16.0),

      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 8.0,

        children: [
          if (widget.title.isNotNull)
            DefaultTextStyle(
              style: Theme.of(
                context,
              ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w500),
              child: widget.title!,
            ),

          if (widget.formKey != null)
            Form(key: widget.formKey, child: widget.child)
          else
            widget.child,

          if (widget.bottom.isNotNull) widget.bottom!,
        ],
      ),
    ).useSafeArea();
  }
}
