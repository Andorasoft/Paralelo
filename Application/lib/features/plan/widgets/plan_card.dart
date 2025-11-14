import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:paralelo/core/constants.dart';
import 'package:paralelo/core/imports.dart';
import 'package:paralelo/features/plan/exports.dart';

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
    final activeProjects = plan.activeProjectsLimit ?? double.infinity;
    final featuredProjects = plan.featuredProjectsLimit;
    final ongoingProjects = plan.ongoingProjectsLimit ?? double.infinity;

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
                TextSpan(text: PlanPeriodUnit.labels[plan.periodUnit]!),
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

          // Beneficios del plan
          _item('${plan.proposalsPerWeek} propuestas por semana'),
          if (activeProjects > 0)
            _item(
              activeProjects.isInfinite
                  ? 'Proyectos activos ilimitados'
                  : '$activeProjects proyectos activos',
            ),
          if (featuredProjects > 0)
            _item('$featuredProjects proyectos destacados'),
          if (ongoingProjects > 0)
            _item(
              ongoingProjects.isInfinite
                  ? 'Proyectos en curso ilimitados'
                  : '$ongoingProjects proyectos en curso',
            ),
          if (plan.tag != null) _item('Etiqueta de usuario: ${plan.tag}'),
          _item('Soporte: nivel ${plan.supportLevel.toLowerCase()}'),
          if (plan.performanceMetrics) _item('Métricas de rendimiento'),

          FilledButton(
            onPressed: !(isCurrent ?? false) ? onTap : null,
            child: Text(
              !(isCurrent ?? false) ? 'Actualizar' : 'Tu plan actual',
            ),
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
