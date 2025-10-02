import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:paralelo/firebase_options.dart';
import 'package:paralelo/core/services.dart';
import 'package:paralelo/core/router.dart';
import 'package:paralelo/core/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
      statusBarColor: Colors.transparent,
    ),
  );

  await dotenv.load();
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_KEY']!,
    authOptions: const FlutterAuthClientOptions(autoRefreshToken: true),
  );
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FCMService().initialize(
    onMessage: (msg) {
      debugPrint("🔥 Foreground: ${msg.notification?.title}");
    },
    onMessageOpenedApp: (msg) {
      debugPrint("👉 Abrieron notificación: ${msg.notification?.title}");
    },
    onTokenRefresh: (newToken) {
      debugPrint("💾 Guardar token en Supabase: $newToken");
    },
  );

  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Paralelo',

      theme: Theme.of(context).app,
      themeMode: ThemeMode.light,

      supportedLocales: const [Locale('es'), Locale('en')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      routerConfig: router,
    );
  }
}
