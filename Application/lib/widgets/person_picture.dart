import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:paralelo/core/imports.dart';

class PersonPicture extends ConsumerWidget {
  final String source;
  final double? size;
  final Widget? badge;
  final BadgePlacement badgePlacement;
  final BorderSide side;

  const PersonPicture({
    super.key,
    required this.source,
    this.size,
    this.badge,
    this.badgePlacement = BadgePlacement.bottomRight,
    this.side = BorderSide.none,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = size ?? 64.0;

    return Badge(
      padding: const EdgeInsets.all(3.0),
      offset: badgePlacement == BadgePlacement.topLef
          ? Offset(-4.0, 0.0)
          : Offset(-4.0, -12.0),
      alignment: badgePlacement == BadgePlacement.topLef
          ? Alignment.topLeft
          : Alignment.bottomRight,
      backgroundColor: side.color,
      label: badge.isNotNull
          ? Theme(
              data: Theme.of(context).copyWith(
                iconTheme: const IconThemeData(size: 16.0, color: Colors.white),
              ),
              child: badge!,
            )
          : null,
      isLabelVisible: badge.isNotNull,

      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.0),
          side: side,
        ),

        child: source.isEmpty
            ? SvgPicture.asset('assets/images/user.svg', width: s, height: s)
            : ClipRRect(
                borderRadius: BorderRadius.circular(100.0),
                child: Image.network(source, width: s, height: s),
              ),
      ),
    );
  }
}

enum BadgePlacement { topLef, bottomRight }
