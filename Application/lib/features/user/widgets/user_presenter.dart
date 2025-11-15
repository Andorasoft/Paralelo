import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:paralelo/core/imports.dart';
import 'package:paralelo/features/plan/exports.dart';
import 'package:paralelo/features/user/exports.dart';
import 'package:paralelo/widgets/person_picture.dart';
import 'package:paralelo/widgets/verified_mark.dart';

class UserPresenter extends ConsumerWidget {
  final User user;
  final Plan plan;

  const UserPresenter({super.key, required this.user, required this.plan});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisSize: MainAxisSize.min,

      children: [
        PersonPicture(
          source: user.pictureUrl ?? '',
          size: 64.0,

          badgePlacement: BadgePlacement.topLef,
          badge: switch (plan.name) {
            'Premium' => Icon(TablerIcons.crown),
            'Pro' => Icon(LucideIcons.star),
            _ => null,
          },
          side: switch (plan.name) {
            'Premium' => BorderSide(
              width: 3.0,
              color: Theme.of(context).colorScheme.secondary,
            ),
            'Pro' => BorderSide(
              width: 3.0,
              color: Theme.of(context).colorScheme.primary,
            ),
            _ => BorderSide.none,
          },
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 4.0,

          children: [
            Text(
              user.displayName,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
            if (user.verified) const VerifiedMark(),
          ],
        ).margin(const EdgeInsets.only(top: 8.0)),
        Text(
          user.email,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.outline,
          ),
        ),
      ],
    );
  }
}
