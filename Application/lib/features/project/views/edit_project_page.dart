import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:paralelo/core/constants.dart';
import 'package:paralelo/core/imports.dart';
import 'package:paralelo/core/router.dart';
import 'package:paralelo/features/auth/exports.dart';
import 'package:paralelo/features/category/exports.dart';
import 'package:paralelo/features/plan/exports.dart';
import 'package:paralelo/features/project/exports.dart';
import 'package:paralelo/features/project_payment/exports.dart';
import 'package:paralelo/features/skill/exports.dart';
import 'package:paralelo/features/user/exports.dart';
import 'package:paralelo/utils/validators.dart';
import 'package:paralelo/widgets/info_bar.dart';
import 'package:paralelo/widgets/navigation_button.dart';
import 'package:paralelo/widgets/skeleton.dart';
import 'package:paralelo/widgets/skeleton_block.dart';
import 'package:paralelo/widgets/skeleton_card.dart';

class EditProjectPage extends ConsumerStatefulWidget {
  static const routePath = '/edit-project';

  final String projectId;

  const EditProjectPage({super.key, required this.projectId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _EditProjectPageState();
  }
}

class _EditProjectPageState extends ConsumerState<EditProjectPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  late Future<_EditProjectDto> loadDataFuture;
  late final String userId;

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
  bool? featured;
  String? selectedCategory;
  String? selectedBudgetType;
  Set<Skill>? selectedSkills;

  @override
  void initState() {
    super.initState();

    userId = ref.read(authProvider)!.id;
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

          final data = snapshot.data!;

          return page(
            owner: data.owner,
            plan: data.plan,
            project: data.project,
            payment: data.payment,
            skills: data.skills,
            categories: data.categories,
            canFeatured: data.canFeatured,
          );
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
  Widget page({
    required User owner,
    required Plan plan,
    required Project project,
    required ProjectPayment payment,
    required List<Skill> skills,
    required List<Category> categories,
    required bool canFeatured,
  }) {
    if (titleController.text.isEmpty) {
      titleController.text = project.title;
    }
    if (descriptionController.text.isEmpty) {
      descriptionController.text = project.description;
    }
    if (requirementController.text.isEmpty) {
      requirementController.text = project.requirement ?? '';
    }
    if (minBadgeController.text.isEmpty) {
      minBadgeController.text = payment.min.toStringAsFixed(2);
    }
    if (maxBadgeController.text.isEmpty) {
      maxBadgeController.text = payment.max.toStringAsFixed(2);
    }

    selectedCategory ??= project.categoryId;
    selectedBudgetType ??= payment.type;
    selectedSkills ??= skills.toSet();
    featured ??= project.featured;

    return Scaffold(
      key: scaffoldKey,

      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: const NavigationButton(type: NavigationButtonType.close),
        title: const Text('Editar proyecto'),
        actions: [
          TextButton(
            onPressed: () async {
              final delete = await showDeleteProjectModalBottomSheet(context);

              if (!(delete ?? false)) return;

              await deleteProject();
            },
            style: Theme.of(context).textButtonTheme.style?.copyWith(
              foregroundColor: WidgetStateProperty.all(Colors.red),
            ),
            child: const Text('Eliminar'),
          ),
        ],
      ),

      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 4.0,
            children: [
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
                enabled: false,
                source: skills,
                initialValues: selectedSkills!.toList(),
                onAdd: (skill) {
                  selectedSkills!.add(skill);
                },
                onRemove: (skill) {
                  selectedSkills!.remove(skill);
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

                onChanged: null, // disabled

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
                    value: featured!,
                    onChanged: canFeatured
                        ? (value) {
                            safeSetState(() => featured = value);
                          }
                        : null,
                  ),
                ],
              ),

              if (!canFeatured)
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
        onPressed: !bussy
            ? () async {
                if (!formKey.currentState!.validate()) {
                  return;
                }

                await updateProject(
                  projectId: project.id,
                  paymentId: payment.id,
                  title: titleController.text != project.title
                      ? titleController.text
                      : null,
                  description: descriptionController.text != project.title
                      ? descriptionController.text
                      : null,
                  requirement: requirementController.text != project.title
                      ? requirementController.text
                      : null,
                  categoryId: selectedCategory != project.categoryId
                      ? selectedCategory
                      : null,
                  minBadge: double.parse(minBadgeController.text) != payment.min
                      ? double.parse(minBadgeController.text)
                      : null,
                  maxBadge: double.parse(maxBadgeController.text) != payment.max
                      ? double.parse(maxBadgeController.text)
                      : null,
                  featured: featured != project.featured ? featured : null,
                );
              }
            : null,
        child: Text(!bussy ? 'Actualizar proyecto' : 'Actualizando...'),
      ).useSafeArea().margin(Insets.h16v8),
    );
  }

  Future<_EditProjectDto> loadData() async {
    final project = await ref.read(projectProvider).getById(widget.projectId);

    final (owner, plan, payment, skills, categories, features) = await (
      ref.read(userProvider).getById(project!.ownerId),
      ref.read(planProvider).getForUser(project.ownerId),
      ref.read(projectPaymentProvider).getForProject(widget.projectId),
      ref.read(skillProvider).getForProject(widget.projectId),
      ref.read(categoryProvider).getAll(),
      ref.read(projectProvider).countFeatured(userId),
    ).wait;

    final canCreateFeatured =
        plan!.featuredProjectsLimit > 0 &&
        features < plan.featuredProjectsLimit;

    return _EditProjectDto(
      owner: owner!,
      plan: plan,
      project: project,
      payment: payment!,
      skills: skills,
      categories: categories,
      canFeatured: canCreateFeatured,
    );
  }

  Future<void> updateProject({
    required String projectId,
    required String paymentId,
    String? title,
    String? description,
    String? requirement,
    String? categoryId,
    double? minBadge,
    double? maxBadge,
    bool? featured,
  }) async {
    try {
      safeSetState(() => bussy = true);

      await (
        ref
            .read(projectProvider)
            .update(
              widget.projectId,
              title: title,
              description: description,
              requirement: requirement,
              featured: featured,
              categoryId: categoryId,
            ),
        ref
            .read(projectPaymentProvider)
            .update(paymentId, min: minBadge, max: maxBadge),
      ).wait;

      ref.read(goRouterProvider).pop(true);
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

  Future<void> deleteProject() async {
    try {
      safeSetState(() => bussy = true);

      ref.read(goRouterProvider).pop(true);
    } on PostgrestException catch (e) {
      showSnackbar(context, '$e');
    } catch (e) {
      debugPrint('Error on [EditProjectPage.deleteProject]: $e');
      showSnackbar(context, '');
    } finally {
      safeSetState(() => bussy = false);
    }
  }
}

class _EditProjectDto {
  final User owner;
  final Plan plan;
  final Project project;
  final ProjectPayment payment;
  final List<Skill> skills;
  final List<Category> categories;
  final bool canFeatured;

  const _EditProjectDto({
    required this.owner,
    required this.plan,
    required this.project,
    required this.payment,
    required this.skills,
    required this.categories,
    required this.canFeatured,
  });
}
