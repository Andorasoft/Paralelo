import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:paralelo/core/imports.dart';
import 'package:paralelo/features/auth/exports.dart';

class AuthPage extends ConsumerStatefulWidget {
  static const routePath = '/auth';

  const AuthPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _AuthPageState();
  }
}

class _AuthPageState extends ConsumerState<AuthPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final emailController = TextEditingController();
  final emailFocusNode = FocusNode();

  final passwordController = TextEditingController();
  final passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
      ),

      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Theme.of(context).colorScheme.tertiary,

        body: Stack(
          children: [
            SvgPicture.asset('assets/images/blob-scene.svg', fit: BoxFit.cover),

            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,

                  children: [
                    SvgPicture.asset(
                      'assets/images/icon.svg',
                      width: 128.0,
                      height: 128.0,
                    ),
                    // Image.asset(
                    //   'assets/images/andorasoft.png',
                    //   width: 128.0,
                    //   height: 128.0,
                    // ),
                  ],
                ).expanded(),
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
                          focusNode: emailFocusNode,

                          labelText: 'Email',
                          hintText: 'your@uni.edu.ec',
                        ),

                        PasswordFormField(
                          controller: passwordController,
                          focusNode: passwordFocusNode,

                          labelText: 'Password',
                          hintText: '********',
                        ),

                        FilledButton(
                          onPressed: () async {
                            await ref
                                .read(authProvider.notifier)
                                .signIn(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                          },
                          child: Text('Login'),
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
                      'Don\'t have an account?',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Sign up',
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
