import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:paralelo/core/imports.dart';
import 'package:paralelo/features/user/exports.dart';
import 'package:paralelo/utils/formatters.dart';

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
          ClipRRect(
            borderRadius: BorderRadius.circular(100.0),

            child: owner.pictureUrl == null
                ? SvgPicture.asset(
                    'assets/images/user.svg',
                    width: 40.0,
                    height: 40.0,
                  )
                : Image.network(owner.pictureUrl!, width: 40.0, height: 40.0),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                spacing: 4.0,

                children: [
                  Text(
                    owner.displayName.obscure(),
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (owner.verified)
                    Icon(
                      TablerIcons.rosette_discount_check_filled,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                ],
              ),
              Text(
                '11 proyectos completados',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.outline,
                ),
              ),
            ],
          ).expanded(),
          UserRatingStar(rating: 0.0),
        ],
      ).margin(const EdgeInsets.all(16.0)),
    );
  }
}
