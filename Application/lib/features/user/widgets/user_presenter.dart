import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserPresenter extends ConsumerStatefulWidget {
  final String pictureUrl;
  final String name;
  final String email;

  const UserPresenter({
    super.key,
    required this.pictureUrl,
    required this.name,
    required this.email,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return UserPresenterState();
  }
}

class UserPresenterState extends ConsumerState<UserPresenter> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,

      children: [
        ClipRRect(
          borderRadius: BorderRadiusGeometry.circular(100.0),

          child: Image.network(widget.pictureUrl, width: 64.0, height: 64.0),
        ),
        Text(
          widget.name,
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
        ).margin(const EdgeInsets.only(top: 8.0)),
        Text(
          widget.email,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.outline,
          ),
        ),
      ],
    );
  }
}
