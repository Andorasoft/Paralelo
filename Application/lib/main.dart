import 'package:paralelo/core/imports.dart';
import 'package:paralelo/core/providers.dart';
import 'package:paralelo/core/router.dart';
import 'package:paralelo/core/services.dart';
import 'package:paralelo/core/theme.dart';
import 'package:paralelo/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

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

  await FCMService.initialize(
    onMessage: (msg) {
      debugPrint("🔥 Foreground: ${msg.notification?.title}");
    },
    onMessageOpenedApp: (msg) {
      debugPrint("👉 Abrieron notificación: ${msg.notification?.title}");
    },
  );

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('es')],
      fallbackLocale: const Locale('es'),
      path: 'assets/translations',

      child: const ProviderScope(child: MainApp()),
    ),
  );
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);
    final prefs = ref.watch(preferencesProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Paralelo',

      theme: Theme.of(context).app,
      themeMode: ThemeMode.light,

      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: prefs.locale,

      routerConfig: router,
    );
  }
}
