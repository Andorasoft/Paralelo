import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:paralelo/core/imports.dart';
import 'package:paralelo/core/router.dart';
import 'package:paralelo/features/auth/exports.dart';

class SignInPage extends ConsumerStatefulWidget {
  static const routePath = '/sign-in';

  const SignInPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _SignInPageState();
  }
}

class _SignInPageState extends ConsumerState<SignInPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
      ),

      child: Scaffold(
        key: scaffoldKey,

        body: Stack(
          children: [
            SvgPicture.asset(
              'assets/images/blob-scene-blue.svg',
              fit: BoxFit.cover,
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'assets/images/icon-white.png',
                  width: 112.0,
                  height: 112.0,
                ).center().expanded(),

                Card(
                  elevation: 4.0,
                  color: const Color(0xCCFFFFFF),
                  margin: const EdgeInsets.all(16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28.0),
                  ),

                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    spacing: 4.0,
                    children: [
                      Text(
                        'Bienvenido a Paralelo',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      ...[
                        Text(
                          'Conecta con otros estudiantes, comparte tus conocimientos y encuentra la ayuda académica que necesitas.',
                        ),

                        EmailFormField(
                          controller: emailController,

                          backgroundColor: Colors.white.withOpacity(0.2),
                          labelText: 'Correo institucional',
                          hintText: 'tu@uni.edu.ec',
                        ),
                        PasswordFormField(
                          controller: passwordController,

                          backgroundColor: Colors.white.withOpacity(0.2),
                          labelText: 'Contraseña',
                          hintText: '••••••••',
                        ),

                        FilledButton(
                          onPressed: () async {
                            if (emailController.text.isEmpty ||
                                passwordController.text.isEmpty) {
                              return;
                            }

                            await ref
                                .read(authProvider.notifier)
                                .signIn(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                          },
                          child: const Text('Iniciar sesión'),
                        ),
                      ].divide(const SizedBox(height: 16.0)),
                    ],
                  ).margin(const EdgeInsets.all(24.0)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 4.0,

                  children: [
                    Text(
                      '¿Aún no tienes cuenta?',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        await ref
                            .read(goRouterProvider)
                            .push(SignUpPage.routePath);
                      },
                      child: Text(
                        'Regístrate',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  ],
                ).margin(const EdgeInsets.symmetric(vertical: 8.0)),
              ],
            ).useSafeArea(),
          ],
        ),
      ),
    ).hideKeyboardOnTap(context);
  }
}
