import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserRatingPresenter extends ConsumerStatefulWidget {
  final double rating;

  const UserRatingPresenter({super.key, required this.rating});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _UserRatingPresenterState();
  }
}

class _UserRatingPresenterState extends ConsumerState<UserRatingPresenter> {
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 4.0,
      children: [
        Icon(Icons.star_rounded, size: 20.0),
        Text('${widget.rating}', style: Theme.of(context).textTheme.bodyLarge),
      ],
    );
  }
}
