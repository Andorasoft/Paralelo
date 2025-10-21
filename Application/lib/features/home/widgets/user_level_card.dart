import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:paralelo/core/imports.dart';

class UserLevelCard extends ConsumerWidget {
  final UserLevel level;

  const UserLevelCard({super.key, required this.level});

  final _levels = const [
    {
      'icon': Icons.local_florist,
      'color': Color(0xFF3B82F6),
      'title': 'Novato',
      'active': true,
    },
    {
      'icon': Icons.lock,
      'color': Color(0xFFB4B4B4),
      'title': 'Colega',
      'active': false,
    },
    {
      'icon': Icons.lock,
      'color': Color(0xFFB4B4B4),
      'title': 'Mentor',
      'active': false,
    },
    {
      'icon': Icons.emoji_events,
      'color': Color(0xFFFCBE2B),
      'title': 'Leyenda',
      'active': false,
    },
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      color: Colors.white,
      elevation: 0.5,

      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 16.0,

        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(text: 'Tu nivel: '),
                TextSpan(
                  text: 'NOVATO',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
              ],

              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 4.0,

            children: _levels
                .map(
                  (i) => _buildItem(
                    context,
                    icon: i['icon'] as IconData,
                    color: i['color'] as Color,
                    title: i['title'] as String,
                    active: i['active'] as bool,
                  ),
                )
                .divide(Divider().expanded()),
          ),
        ],
      ).margin(const EdgeInsets.all(16.0)),
    );
  }

  Widget _buildItem(
    BuildContext context, {
    required IconData icon,
    required Color color,
    required String title,
    required bool active,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 8.0,

      children: [
        Container(
          width: 52.0,
          height: 52.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100.0),
            color: color.withAlpha(30),
          ),
          child: Icon(icon, color: color),
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: active ? FontWeight.bold : FontWeight.normal,
            color: Theme.of(context).colorScheme.outline,
          ),
        ),
      ],
    );
  }
}

enum UserLevel { rookie, colleague, mentor, legend }
