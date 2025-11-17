import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:paralelo/core/constants.dart';
import 'package:paralelo/core/imports.dart';
import 'package:paralelo/core/providers.dart';
import 'package:paralelo/core/router.dart';
import 'package:paralelo/core/services.dart';
import 'package:paralelo/core/theme.dart';
import 'package:paralelo/features/auth/exports.dart';
import 'package:paralelo/features/application/exports.dart';
import 'package:paralelo/features/user_subscription/exports.dart';
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

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('es')],
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
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _initializePurchaseService(context, ref);

      await PurchaseService.instance.restore();
    });

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

  Future<void> _initializePurchaseService(
    BuildContext context,
    WidgetRef ref,
  ) async {
    await PurchaseService.initialize(
      onData: (purchase) async {
        if (purchase.status == PurchaseStatus.purchased ||
            purchase.status == PurchaseStatus.restored) {
          final userId = ref.read(authProvider)?.id ?? '';

          if (userId.isEmpty) return;

          try {
            final token = purchase.verificationData.serverVerificationData;
            final sub = await ref
                .read(userSubscriptionProvider)
                .getByToken(token);

            if (sub != null && sub.status == SubscriptionStatus.active) return;

            final success = await ref
                .read(userSubscriptionProvider)
                .verify(
                  purchaseToken: token,
                  productId: purchase.productID,
                  userId: userId,
                );

            if (!success) return;

            if (purchase.pendingCompletePurchase) {
              await PurchaseService.instance.complete(purchase);
              await ref
                  .read(goRouterProvider)
                  .pushReplacement(SplashPage.routePath);
            }
          } catch (e) {
            showSnackbar(context, 'Error: $e');
          }

          showSnackbar(context, 'Purchase status: ${purchase.status}');
        }
      },
      onError: (error) {
        showSnackbar(context, 'Error: $error');
      },
    );
  }
}
