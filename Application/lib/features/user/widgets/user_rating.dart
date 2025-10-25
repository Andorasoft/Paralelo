import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserRatingStar extends ConsumerStatefulWidget {
  final double rating;

  const UserRatingStar({super.key, required this.rating});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _UserRatingStarState();
  }
}

class _UserRatingStarState extends ConsumerState<UserRatingStar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 4.0,
      children: [
        const Icon(Icons.star_rounded, size: 20.0),
        Text('${widget.rating}', style: Theme.of(context).textTheme.bodyLarge),
      ],
    );
  }
}
