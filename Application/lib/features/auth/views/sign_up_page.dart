import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:paralelo/core/imports.dart';
import 'package:paralelo/core/router.dart';
import 'package:paralelo/features/auth/exports.dart';
import 'package:paralelo/features/user/exports.dart';
import 'package:paralelo/utils/extensions.dart';
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

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmationController = TextEditingController();

  bool agreeConditions = false;
  bool isBussy = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => !isBussy,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: Colors.transparent,
        ),
        child: Scaffold(
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
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),

                        ...[
                          Text(
                            'Conecta con otros estudiantes, ofrece tus conocimientos y recibe apoyo académico en tu área.',
                            textAlign: TextAlign.center,
                          ),

                          NameFormField(
                            controller: nameController,
                            validator: _SignUpPageValidators.name.validate,

                            backgroundColor: Colors.grey.withOpacity(0.1),
                            labelText: 'Nombre completo',
                            hintText: 'Ejemplo: Ana Pérez Gómez',
                          ),
                          EmailFormField(
                            controller: emailController,
                            validator: _SignUpPageValidators.email.validate,

                            backgroundColor: Colors.grey.withOpacity(0.1),
                            labelText: 'Correo institucional',
                            hintText: 'Ejemplo: ana.perez@uni.edu.ec',
                          ),
                          PasswordFormField(
                            controller: passwordController,
                            validator: _SignUpPageValidators.password.validate,

                            backgroundColor: Colors.grey.withOpacity(0.1),
                            labelText: 'Contraseña',
                            hintText: 'Mínimo 8 caracteres',
                          ),
                          PasswordFormField(
                            controller: confirmationController,
                            validator: _SignUpPageValidators.confirmation(
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
                            onPressed: agreeConditions && !isBussy
                                ? () async {
                                    if (!formKey.currentState!.validate()) {
                                      return;
                                    }

                                    try {
                                      safeSetState(() => isBussy = true);

                                      final auth = await ref
                                          .read(authProvider.notifier)
                                          .signUp(
                                            email: emailController.text,
                                            password: passwordController.text,
                                          );
                                      await ref
                                          .read(userProvider)
                                          .create(
                                            id: auth!.id,
                                            displayName: nameController.text,
                                            email: emailController.text,
                                            planId: 1,
                                          );

                                      ref.read(goRouterProvider).pop();
                                    } catch (err) {
                                      showSnackbar(context, 'Error $err');
                                    } finally {
                                      safeSetState(() => isBussy = false);
                                    }
                                  }
                                : null,
                            child: Text(
                              !isBussy ? 'Crear cuenta' : 'Creando cuenta...',
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
        ),
      ),
    ).hideKeyboardOnTap(context);
  }
}

class _SignUpPageValidators {
  static final name = Validator<String>()
    ..required('Ingresa tu nombre completo')
    ..minLength(3, 'El nombre es demasiado corto');

  static final email = Validator<String>()
    ..required('El correo es obligatorio')
    ..email('Ingresa un correo válido');

  static final password = Validator<String>()
    ..required('La contraseña es obligatoria')
    ..minLength(8, 'Debe tener al menos 8 caracteres');

  static Validator<String> confirmation(String Function() getPassword) =>
      Validator<String>()
        ..required('Repite tu contraseña')
        ..matches(getPassword, 'Las contraseñas no coinciden');
}
