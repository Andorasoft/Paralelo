import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:paralelo/core/imports.dart';
import 'package:paralelo/features/plan/models/plan.dart';
import 'package:paralelo/utils/extensions.dart';

class PlanCard extends ConsumerWidget {
  final Plan plan;
  final IconData? icon;
  final bool? isCurrent;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderWidth;
  final void Function() onTap;

  const PlanCard({
    super.key,
    required this.plan,
    required this.onTap,
    this.icon,
    this.isCurrent,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ap = plan.activeProjectsLimit ?? double.infinity;
    final fp = plan.featuredProjectsLimit ?? double.infinity;
    final op = plan.ongoingProjectsLimit ?? double.infinity;

    return Card(
      elevation: 0.0,
      margin: EdgeInsets.zero,
      color: backgroundColor ?? Colors.transparent,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          width: borderWidth ?? 1.0,
          color: borderColor ?? Theme.of(context).colorScheme.primaryContainer,
        ),
        borderRadius: BorderRadius.circular(24.0),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 8.0,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Card(
                color: Colors.grey.withAlpha(32),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.0),
                ),
                child: Icon(
                  icon ?? LucideIcons.dot,
                  size: 20.0,
                ).margin(Insets.a12),
              ),
              Chip(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.0),
                ),
                backgroundColor:
                    borderColor ??
                    Theme.of(context).colorScheme.primaryContainer,

                label: Text(
                  'Plan ${plan.name}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: borderColor.isNull ? Colors.black : Colors.white,
                  ),
                ),
              ),
            ],
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text:
                      '${plan.price == 0.0 ? 'Gratis' : '\$${plan.price}'} / ',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                TextSpan(text: plan.periodUnit.toLowerCase()),
              ],

              style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
            ),
          ),
          Text(
            plan.description ?? '',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
          Divider(
            color:
                borderColor ?? Theme.of(context).colorScheme.primaryContainer,
          ).margin(Insets.v8),

          _item('${plan.proposalsPerWeek} proposals per week'),
          if (ap > 0)
            _item('${ap.isInfinite ? 'Unlimited' : ap} active projects'),
          if (fp > 0)
            _item('${fp.isInfinite ? 'Unlimited' : fp} featured projects'),
          if (op > 0)
            _item('${op.isInfinite ? 'Unlimited' : op} ongoing projects'),
          if (plan.tag != '-') _item('${plan.tag} user tag'),
          _item('${plan.supportLevel} support level'),
          if (plan.performanceMetrics) _item('Performance metrics'),
          if (plan.highlightServices) _item('Highlight services'),

          FilledButton(
            onPressed: !(isCurrent ?? false) ? onTap : null,
            child: Text(!(isCurrent ?? false) ? 'Upgrade' : 'Current plan'),
          ).margin(const EdgeInsets.only(top: 8.0)),
        ],
      ).margin(Insets.a16),
    );
  }

  Widget _item(String title) {
    return Row(
      spacing: 8.0,
      children: [
        const Icon(
          LucideIcons.checkCircle,
          size: 16.0,
          color: Colors.lightGreen,
        ),
        Text(title),
      ],
    );
  }
}
