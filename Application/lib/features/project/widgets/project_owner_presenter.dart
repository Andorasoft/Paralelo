import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:paralelo/core/imports.dart';
import 'package:paralelo/features/plan/exports.dart';
import 'package:paralelo/features/user/exports.dart';
import 'package:paralelo/utils/formatters.dart';
import 'package:paralelo/widgets/person_picture.dart';
import 'package:paralelo/widgets/verified_mark.dart';

class ProjectOwnerPresenter extends ConsumerWidget {
  final User owner;
  final Plan plan;

  const ProjectOwnerPresenter({
    super.key,
    required this.owner,
    required this.plan,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      elevation: 0.0,
      margin: EdgeInsets.zero,
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          width: 1.0,
          color: Theme.of(context).colorScheme.primaryContainer,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 12.0,

        children: [
          PersonPicture(
            source: owner.pictureUrl ?? '',
            size: 48.0,

            badge: switch (plan.name) {
              'Premium' => Icon(TablerIcons.crown),
              'Pro' => Icon(TablerIcons.star),
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
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 4.0,

            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 4.0,

                    children: [
                      Text(
                        owner.displayName.obscure(),
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (owner.verified) const VerifiedMark(size: 22.0),
                    ],
                  ),
                  UserRatingStar(rating: 0.0),
                ],
              ),
              Text(
                'Miembro desde ${owner.createdAt.toLongDateString().toLowerCase()}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.outline,
                ),
              ),
            ],
          ).expanded(),
        ],
      ).margin(const EdgeInsets.all(16.0)),
    );
  }
}
