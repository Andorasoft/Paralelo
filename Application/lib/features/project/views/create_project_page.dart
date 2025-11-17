import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:paralelo/core/constants.dart';
import 'package:paralelo/core/imports.dart';
import 'package:paralelo/core/router.dart';
import 'package:paralelo/features/auth/exports.dart';
import 'package:paralelo/features/category/exports.dart';
import 'package:paralelo/features/plan/exports.dart';
import 'package:paralelo/features/project/exports.dart';
import 'package:paralelo/features/project_payment/exports.dart';
import 'package:paralelo/features/project_skill/exports.dart';
import 'package:paralelo/features/skill/exports.dart';
import 'package:paralelo/utils/validators.dart';
import 'package:paralelo/widgets/info_bar.dart';
import 'package:paralelo/widgets/navigation_button.dart';
import 'package:paralelo/widgets/skeleton.dart';
import 'package:paralelo/widgets/skeleton_block.dart';
import 'package:paralelo/widgets/skeleton_card.dart';

class CreateProjectPage extends ConsumerStatefulWidget {
  static const routePath = '/create-project';

  const CreateProjectPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _CreateProjectPageState();
  }
}

class _CreateProjectPageState extends ConsumerState<CreateProjectPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  late final Future<(List<Skill>, List<Category>, bool, bool)> loadDataFuture;

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final requirementController = TextEditingController();
  final minBadgeController = TextEditingController();
  final maxBadgeController = TextEditingController();

  final titleFocusNode = FocusNode();
  final descriptionFocusNode = FocusNode();
  final requirementFocusNode = FocusNode();
  final minBadgeFocusNode = FocusNode();
  final maxBadgeFocusNode = FocusNode();

  // Validators...
  final titleValidator = Validator<String>()
    ..required('El título es obligatorio')
    ..minLength(5);
  final descriptionValidator = Validator<String>()
    ..required('La descripción es obligatoria')
    ..minLength(10);
  final categoryValidator = Validator<String>()..required();
  final minBadgeValidator = Validator<String>()
    ..required('Indica el mínimo')
    ..isDouble('Debe ser numérico');
  final maxBadgeValidator = Validator<String>()
    ..required('Indica el máximo')
    ..isDouble('Debe ser numérico');
  final badgeTypeValidator = Validator<String>()..required();

  bool bussy = false;
  bool featured = false;
  String? selectedCategory;
  String? selectedBudgetType;
  Set<String> selectedSkills = {};

  @override
  void initState() {
    super.initState();

    loadDataFuture = loadData();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => !bussy,
      child: FutureBuilder(
        future: loadDataFuture,
        builder: (_, snapshot) {
          if (!snapshot.hasData) {
            return skeleton();
          }

          return page(snapshot.data!);
        },
      ),
    ).hideKeyboardOnTap(context);
  }

  ///
  Widget skeleton() {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: Skeleton(
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: Colors.transparent,

          appBar: AppBar(
            leading: const SkeletonBlock(
              width: 40.0,
              height: 40.0,
            ).align(Alignment.centerRight),
            title: const SkeletonBlock(width: 128.0, height: 24.0),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8.0,
            children: [
              const SkeletonBlock(
                width: 64.0,
                height: 16.0,
              ).margin(const EdgeInsets.only(top: 16.0)),
              const SkeletonBlock(width: double.infinity, height: 32.0),
              const SkeletonBlock(
                width: 64.0,
                height: 16.0,
              ).margin(const EdgeInsets.only(top: 16.0)),
              SkeletonCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8.0,
                  children: const [
                    SkeletonBlock(width: double.infinity, height: 16.0),
                    SkeletonBlock(width: 128.0, height: 16.0),
                  ],
                ).margin(Insets.a16),
              ),
              const SkeletonBlock(
                width: 64.0,
                height: 16.0,
              ).margin(const EdgeInsets.only(top: 16.0)),
              const SkeletonBlock(width: double.infinity, height: 32.0),
              const SkeletonBlock(
                width: 64.0,
                height: 16.0,
              ).margin(const EdgeInsets.only(top: 16.0)),
              const SkeletonBlock(width: double.infinity, height: 32.0),
              const SkeletonBlock(
                width: 64.0,
                height: 16.0,
              ).margin(const EdgeInsets.only(top: 16.0)),
              const SkeletonBlock(width: double.infinity, height: 32.0),
            ],
          ).margin(Insets.h16v8),
        ),
      ),
    );
  }

  ///
  Widget page((List<Skill>, List<Category>, bool, bool) data) {
    final (skills, categories, canCreateActive, canCreateFeatured) = data;

    return Scaffold(
      key: scaffoldKey,

      appBar: AppBar(
        automaticallyImplyLeading: false,

        leading: const NavigationButton(type: NavigationButtonType.close),
        title: const Text('Publicar un proyecto'),
      ),

      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,

        child: Form(
          key: formKey,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 4.0,

            children: [
              if (!canCreateActive)
                const InfoBar(
                  title: 'Límite de proyectos alcanzado',
                  message:
                      'No puedes publicar más proyectos activos con tu plan actual.',
                  closable: false,
                  severity: InfoBarSeverity.error,
                ).margin(const EdgeInsets.only(bottom: 16.0)),
              const Text('Títutlo'),
              TextFormField(
                minLines: 1,
                maxLines: null,
                focusNode: titleFocusNode,
                controller: titleController,
                validator: titleValidator.validate,

                decoration: InputDecoration(
                  hintText: 'Ejemplo: Asesoría en estadística para tesis',
                  hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.outlineVariant,
                  ),
                ),
                style: Theme.of(context).textTheme.bodyMedium,
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp(r'\n')),
                ],
                textInputAction: TextInputAction.next,
              ),

              const Text(
                'Descripción',
              ).margin(const EdgeInsets.only(top: 16.0)),
              TextFormField(
                minLines: 4,
                maxLines: null,
                focusNode: descriptionFocusNode,
                controller: descriptionController,
                validator: descriptionValidator.validate,

                decoration: InputDecoration(
                  hintText:
                      'Explica brevemente lo que necesitas, el objetivo y el tipo de ayuda esperada.',
                  hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.outlineVariant,
                  ),
                ),
                style: Theme.of(context).textTheme.bodyMedium,
                textInputAction: TextInputAction.newline,
              ),

              const Text(
                'Requisito (opcional)',
              ).margin(const EdgeInsets.only(top: 16.0)),
              TextFormField(
                minLines: 1,
                maxLines: null,
                focusNode: requirementFocusNode,
                controller: requirementController,

                decoration: InputDecoration(
                  hintText:
                      'Ejemplo: experiencia previa o entrega en cierto formato.',
                  hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.outlineVariant,
                  ),
                ),
                style: Theme.of(context).textTheme.bodyMedium,
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp(r'\n')),
                ],
                textInputAction: TextInputAction.next,
              ),

              const Text('Categoría').margin(const EdgeInsets.only(top: 16.0)),
              DropdownButtonFormField<String>(
                isExpanded: true,
                menuMaxHeight: 300.0,
                initialValue: selectedCategory,
                validator: categoryValidator.validate,

                onChanged: (value) {
                  if (value.isNotNull) {
                    safeSetState(() => selectedCategory = value);
                  }
                },

                decoration: InputDecoration(
                  hintText: 'Selecciona el área del proyecto.',
                  hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.outlineVariant,
                  ),
                ),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  overflow: TextOverflow.ellipsis,
                ),
                items: categories
                    .map(
                      (it) => DropdownMenuItem<String>(
                        value: it.id,
                        child: Text(it.name),
                      ),
                    )
                    .toList(),
              ),

              const Text(
                'Habilidades requeridas (opcional)',
              ).margin(const EdgeInsets.only(top: 16.0)),
              SkillInputSelector(
                max: 5,
                source: skills,
                onAdd: (skill) {
                  selectedSkills.add(skill.id);
                },
                onRemove: (skill) {
                  selectedSkills.remove(skill.id);
                },
              ),

              const Text(
                'Presupuesto',
              ).margin(const EdgeInsets.only(top: 16.0)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                spacing: 16.0,

                children: [
                  TextFormField(
                    focusNode: minBadgeFocusNode,
                    controller: minBadgeController,
                    validator: minBadgeValidator.validate,

                    decoration: InputDecoration(
                      hintText: 'Monto mínimo',
                      hintStyle: Theme.of(context).textTheme.bodyMedium
                          ?.copyWith(
                            color: Theme.of(context).colorScheme.outlineVariant,
                          ),
                    ),
                    style: Theme.of(context).textTheme.bodyMedium,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                  ).expanded(),
                  TextFormField(
                    focusNode: maxBadgeFocusNode,
                    controller: maxBadgeController,
                    validator: maxBadgeValidator.validate,

                    decoration: InputDecoration(
                      hintText: 'Monto máximo',
                      hintStyle: Theme.of(context).textTheme.bodyMedium
                          ?.copyWith(
                            color: Theme.of(context).colorScheme.outlineVariant,
                          ),
                    ),
                    style: Theme.of(context).textTheme.bodyMedium,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                  ).expanded(),
                ],
              ),

              const Text(
                'Tipo de presupuesto',
              ).margin(const EdgeInsets.only(top: 16.0)),
              DropdownButtonFormField<String>(
                menuMaxHeight: 200.0,
                initialValue: selectedBudgetType,
                validator: badgeTypeValidator.validate,

                onChanged: (value) {
                  if (value.isNotNull) {
                    safeSetState(() => selectedBudgetType = value);
                  }
                },

                decoration: InputDecoration(
                  hintText: 'Elige si es un pago fijo o por horas.',
                  hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.outlineVariant,
                  ),
                ),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  overflow: TextOverflow.ellipsis,
                ),
                items: ProjectPaymentType.values
                    .map(
                      (i) => DropdownMenuItem<String>(
                        value: i,
                        child: Text(ProjectPaymentType.labels[i]!),
                      ),
                    )
                    .toList(),
              ),

              const Text(
                'Proyecto destacado (opcional)',
              ).margin(const EdgeInsets.only(top: 16.0)),
              Row(
                children: [
                  Text(
                    'Los proyectos destacados tienen mayor visibilidad en los listados.',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                  ).expanded(),
                  Switch.adaptive(
                    value: featured,
                    onChanged: canCreateFeatured
                        ? (value) {
                            safeSetState(() => featured = value);
                          }
                        : null,
                  ),
                ],
              ),

              if (!canCreateFeatured)
                const InfoBar(
                  title: 'Límite de proyectos destacados',
                  message:
                      'Has alcanzado el número máximo de proyectos destacados que permite tu plan.',
                  closable: false,
                  severity: InfoBarSeverity.error,
                ).margin(const EdgeInsets.only(top: 16.0)),
            ],
          ),
        ).margin(Insets.h16v8),
      ),

      bottomNavigationBar: FilledButton(
        onPressed: canCreateActive && !bussy
            ? () async {
                if (!formKey.currentState!.validate()) {
                  return;
                }

                await createProject();
              }
            : null,
        child: Text(!bussy ? 'Publicar proyecto' : 'Publicando...'),
      ).useSafeArea().margin(Insets.h16v8),
    );
  }

  Future<(List<Skill>, List<Category>, bool, bool)> loadData() async {
    final userId = ref.read(authProvider)!.id;

    final (skills, categories, plan, actives, features) = await (
      ref.read(skillProvider).getAll(),
      ref.read(categoryProvider).getAll(),
      ref.read(planProvider).getForUser(userId),
      ref.read(projectProvider).countActive(userId),
      ref.read(projectProvider).countFeatured(userId),
    ).wait;

    final canCreateActive = plan!.activeProjectsLimit == null
        ? true
        : actives < plan.activeProjectsLimit!;
    final canCreateFeatured =
        plan.featuredProjectsLimit > 0 && features < plan.featuredProjectsLimit;

    return (skills, categories, canCreateActive, canCreateFeatured);
  }

  Future<void> createProject() async {
    final userId = ref.read(authProvider)!.id;

    try {
      safeSetState(() => bussy = true);

      final project = await ref
          .read(projectProvider)
          .create(
            title: titleController.text,
            description: descriptionController.text,
            requirement: requirementController.text,
            featured: featured,
            ownerId: userId,
            categoryId: selectedCategory!,
          );

      await (
        ref
            .read(projectPaymentProvider)
            .create(
              min: double.parse(minBadgeController.text),
              max: double.parse(maxBadgeController.text),
              currency: 'USD',
              type: selectedBudgetType!,
              projectId: project.id,
            ),
        Future.wait(
          selectedSkills.map(
            (id) => ref
                .read(projectSkillProvider)
                .create(projectId: project.id, skillId: id),
          ),
        ),
      ).wait;

      ref.read(goRouterProvider).pop();
    } on PostgrestException catch (e) {
      showSnackbar(context, e.message);
    } catch (err) {
      showSnackbar(
        context,
        'Ups, algo salió mal al publicar tu proyecto. Inténtalo otra vez.',
      );
    } finally {
      safeSetState(() => bussy = false);
    }
  }
}
