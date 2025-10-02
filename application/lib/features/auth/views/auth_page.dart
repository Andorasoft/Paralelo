import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:paralelo/features/auth/controllers/auth_notifier.dart';
import 'package:paralelo/features/auth/widgets/email_form_field.dart';
import 'package:paralelo/features/auth/widgets/password_form_field.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthPage extends ConsumerStatefulWidget {
  static const routeName = 'AuthPage';
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
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,

      extendBodyBehindAppBar: true,
      extendBody: true,

      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(
          statusBarColor: Colors.transparent,
        ),
      ),

      body: Stack(
        children: [
          SvgPicture.asset('assets/svg/Layered-Peaks.svg', fit: BoxFit.cover),
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,

            children: [
              SizedBox().expanded(),
              Card(
                elevation: 4.0,
                color: const Color(0xCCFFFFFF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(28.0),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: 4.0,

                  children: [
                    Text(
                      'Correo electrónico',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ).margin(const EdgeInsets.only(top: 12.0)),
                    EmailFormField(
                      controller: emailController,
                      hintText: 'tu@email.com',
                    ),

                    Text(
                      'Contraseña',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ).margin(const EdgeInsets.only(top: 12.0)),
                    PasswordFormField(
                      controller: passwordController,
                      hintText: '********',
                    ),

                    FilledButton(
                      onPressed: () async {
                        try {
                          await ref
                              .read(authProvider.notifier)
                              .login(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                        } on AuthException catch (e) {
                          showSnackbar(context, 'Error: ${e.message}');
                        }
                      },
                      child: Text(
                        'Iniciar sesión',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    ).margin(const EdgeInsets.only(top: 16.0)),

                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: 16.0,

                      children: [
                        Divider().expanded(),
                        Text(
                          'o continúa con',
                          style: Theme.of(context).textTheme.labelMedium
                              ?.copyWith(color: Colors.black38),
                        ),
                        Divider().expanded(),
                      ],
                    ).margin(const EdgeInsets.symmetric(vertical: 12.0)),

                    ElevatedButton.icon(
                      onPressed: () {},
                      style: Theme.of(context).elevatedButtonTheme.style
                          ?.copyWith(elevation: WidgetStateProperty.all(0.0)),
                      label: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 16.0,

                        children: [
                          SvgPicture.asset('assets/svg/Microsoft.svg'),
                          Text(
                            'Microsoft',
                            style: Theme.of(context).textTheme.labelLarge
                                ?.copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurface,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ).margin(const EdgeInsets.all(24.0)),
              ).useSafeArea().margin(
                const EdgeInsets.symmetric(horizontal: 16.0),
              ),
            ],
          ),
        ],
      ),
    ).hideKeyboardOnTap(context);
  }
}
