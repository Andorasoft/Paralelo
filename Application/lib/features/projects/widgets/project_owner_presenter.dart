import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:paralelo/core/imports.dart';
import 'package:paralelo/features/user/exports.dart';
import 'package:paralelo/utils/formatters.dart';
import 'package:paralelo/widgets/person_picture.dart';

class ProjectOwnerPresenter extends ConsumerWidget {
  final User owner;

  const ProjectOwnerPresenter({super.key, required this.owner});

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
          PersonPicture(source: owner.pictureUrl ?? '', size: 44.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 4.0,

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
                  if (owner.verified)
                    Icon(
                      TablerIcons.rosette_discount_check_filled,
                      size: 22.0,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                spacing: 4.0,
                children: [
                  Icon(
                    Icons.calendar_month_rounded,
                    size: 18.0,
                    color: Colors.grey.shade500,
                  ),
                  Text(
                    owner.createdAt.toShortDateString(),
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ],
          ).expanded(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            spacing: 4.0,
            children: [
              UserRatingStar(rating: 0.0),
              if (owner.planId != 1)
                Chip(
                  visualDensity: VisualDensity(
                    horizontal: VisualDensity.minimumDensity,
                    vertical: VisualDensity.minimumDensity,
                  ),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  padding: EdgeInsets.zero,
                  backgroundColor: owner.planId == 2
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.secondary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0),
                  ),

                  label: Text(
                    owner.planId == 2 ? 'PRO' : 'PREMIUM',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 10.0,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ).margin(const EdgeInsets.all(16.0)),
    );
  }
}
