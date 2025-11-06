import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:paralelo/core/exceptions.dart';
import 'package:paralelo/core/imports.dart';
import 'package:paralelo/core/router.dart';
import 'package:paralelo/features/auth/exports.dart';
import 'package:paralelo/features/plan/controllers/plan_provider.dart';
import 'package:paralelo/features/university/controllers/university_provider.dart';
import 'package:paralelo/features/user/exports.dart';
import 'package:paralelo/utils/extensions.dart';
import 'package:paralelo/utils/formatters.dart';
import 'package:paralelo/utils/validators.dart';
import 'package:paralelo/widgets/link_button.dart';
import 'package:paralelo/widgets/navigation_button.dart';

class SignUpPage extends ConsumerStatefulWidget {
  static const routePath = '/sign-up';

  const SignUpPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _SignUpPageState();
  }
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  // Controllers...
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmationController = TextEditingController();

  // Validators...
  final nameValidator = Validator<String>()
    ..required('Ingresa tu nombre completo')
    ..minLength(3, 'El nombre es demasiado corto');

  final emailValidator = Validator<String>()
    ..required('El correo es obligatorio')
    ..email('Ingresa un correo válido');

  final passwordValidator = Validator<String>()
    ..required('La contraseña es obligatoria')
    ..minLength(8, 'Debe tener al menos 8 caracteres');

  Validator<String> confirmationValidator(String Function() getPassword) =>
      Validator<String>()
        ..required('Repite tu contraseña')
        ..matches(getPassword, 'Las contraseñas no coinciden');

  // Others...
  bool agreeConditions = false;
  bool bussy = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => !bussy,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: Colors.transparent,
        ),
        child: page(),
      ),
    ).hideKeyboardOnTap(context);
  }

  Widget page() {
    return Scaffold(
      key: scaffoldKey,
      extendBodyBehindAppBar: true,

      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: const NavigationButton(),
      ),

      body: Stack(
        children: [
          SvgPicture.asset(
            'assets/images/blob-scene-white.svg',
            fit: BoxFit.cover,
          ),

          ListView(
            padding: Insets.h16v8,
            children: [
              Image.asset(
                'assets/images/icon-blue.png',
                width: 96.0,
                height: 96.0,
              ).center(),

              const SizedBox(height: 16.0),

              Form(
                key: formKey,

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: 4.0,
                  children: [
                    Text(
                      'Crea tu cuenta en Paralelo',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    ...[
                      Text(
                        'Conecta con otros estudiantes, ofrece tus conocimientos y recibe apoyo académico en tu área.',
                        textAlign: TextAlign.center,
                      ),

                      NameFormField(
                        controller: nameController,
                        validator: nameValidator.validate,

                        backgroundColor: Colors.grey.withOpacity(0.1),
                        labelText: 'Nombre completo',
                        hintText: 'Ejemplo: Ana Pérez Gómez',
                      ),
                      EmailFormField(
                        controller: emailController,
                        validator: emailValidator.validate,

                        backgroundColor: Colors.grey.withOpacity(0.1),
                        labelText: 'Correo institucional',
                        hintText: 'Ejemplo: ana.perez@uni.edu.ec',
                      ),
                      PasswordFormField(
                        controller: passwordController,
                        validator: passwordValidator.validate,

                        backgroundColor: Colors.grey.withOpacity(0.1),
                        labelText: 'Contraseña',
                        hintText: 'Mínimo 8 caracteres',
                      ),
                      PasswordFormField(
                        controller: confirmationController,
                        validator: confirmationValidator(
                          () => passwordController.text,
                        ).validate,

                        backgroundColor: Colors.grey.withOpacity(0.1),
                        labelText: 'Confirmar contraseña',
                        hintText: 'Repite tu contraseña',
                      ),

                      Row(
                        children: [
                          Checkbox(
                            onChanged: (value) {
                              safeSetState(
                                () => agreeConditions = value ?? false,
                              );
                            },
                            value: agreeConditions,
                          ),
                          ...const [
                            Text('Acepto los'),
                            LinkButton('terminos', url: ''),
                            Text('y'),
                            LinkButton('condiciones', url: ''),
                          ],
                        ],
                      ),

                      FilledButton(
                        onPressed: agreeConditions && !bussy ? signUp : null,
                        child: Text(
                          !bussy ? 'Crear cuenta' : 'Creando cuenta...',
                        ),
                      ),
                    ].divide(const SizedBox(height: 16.0)),
                  ],
                ),
              ),
            ],
          ).useSafeArea(),
        ],
      ),
    );
  }

  Future<void> signUp() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    try {
      safeSetState(() => bussy = true);

      final email = emailController.text.trim();
      final password = passwordController.text.trim();
      final name = nameController.text.trim();

      final domain = email.extractDomain();
      final university = await ref.read(universityProvider).getByDomain(domain);

      if (university == null) {
        throw NotFoundException('Dominio universitario no válido: $domain');
      }

      final plan = await ref.read(planProvider).getByName('Free');

      if (plan == null) {
        throw NotFoundException('Plan no encontrado');
      }

      final user = await ref
          .read(authProvider.notifier)
          .signUp(email: email, password: password);

      if (user == null) {
        throw AuthException('No se pudo crear la cuenta. Intenta nuevamente.');
      }

      await ref
          .read(userProvider)
          .create(
            id: user.id,
            displayName: name,
            email: email,
            planId: plan.id,
            universityId: university.id,
          );

      showSnackbar(context, 'Cuenta creada con éxito 🎉');
      ref.read(goRouterProvider).pop();
    } on ValidationException catch (ex) {
      showSnackbar(context, ex.message);
    } on NotFoundException catch (ex) {
      showSnackbar(context, ex.message);
    } on AuthException catch (ex) {
      showSnackbar(context, ex.message);
    } on NetworkException catch (ex) {
      showSnackbar(context, 'Error de conexión: ${ex.message}');
    } catch (e, st) {
      debugPrint('Error desconocido en signUp: $e\n$st');
      showSnackbar(context, 'Ocurrió un error inesperado.');
    } finally {
      safeSetState(() => bussy = false);
    }
  }
}
