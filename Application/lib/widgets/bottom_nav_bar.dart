import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:paralelo/core/imports.dart';
import 'package:paralelo/core/router.dart';
import 'package:paralelo/core/services.dart';
import 'package:paralelo/features/auth/exports.dart';
import 'package:paralelo/features/management/exports.dart';
import 'package:paralelo/features/setting/exports.dart';
import 'package:paralelo/features/chat/exports.dart';
import 'package:paralelo/features/home/exports.dart';
import 'package:paralelo/features/project/exports.dart';
import 'package:paralelo/features/subscription/exports.dart';

class BottomNavBar extends ConsumerStatefulWidget {
  const BottomNavBar({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _BottomNavBarState();
  }
}

class _BottomNavBarState extends ConsumerState<BottomNavBar> {
  bool hasMessages = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await initializeFCMService();
      await initializeSubscriptionService();
      await SubscriptionService.instance.restore();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(
        context,
      ).copyWith(scaffoldBackgroundColor: Colors.transparent),
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: Colors.transparent,
        ),

        child: BottomNavBarWidget(
          onTap: (index) {
            if (index == 2 && hasMessages) {
              safeSetState(() => hasMessages = false);
            }
          },

          height: 56.0,
          showLabels: false,
          extendContent: true,

          backgroundGradient: const LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [Color(0xFFF7F6FA), Colors.white],
          ),

          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              await ref
                  .read(goRouterProvider)
                  .push(CreateProjectPage.routePath);
            },
            highlightElevation: 0.0,
            elevation: 2.0,

            child: const Icon(TablerIcons.plus),
          ),

          items: [
            BottomNavBarItem(
              label: 'nav.home'.tr(),
              icon: const Icon(TablerIcons.smart_home, size: 28.0),
              page: const HomePage(),
            ),
            BottomNavBarItem(
              label: 'nav.search'.tr(),
              icon: const Icon(TablerIcons.search, size: 28.0),
              page: const MarketplacePage(),
            ),
            BottomNavBarItem(
              label: 'nav.chats'.tr(),
              icon: Badge(
                smallSize: 8.0,
                isLabelVisible: hasMessages,
                backgroundColor: Theme.of(context).colorScheme.primary,

                child: const Icon(TablerIcons.message_2, size: 28.0),
              ),
              page: const ChatsPage(),
            ),
            BottomNavBarItem(
              label: 'nav.account'.tr(),
              icon: const Icon(TablerIcons.user_circle, size: 28.0),
              page: const SettingsPage(),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> initializeFCMService() {
    return FCMService.initialize(
      onMessage: (msg) {
        if (!hasMessages) {
          safeSetState(() => hasMessages = true);
        }
      },
      onMessageOpenedApp: (msg) async {
        await ref
            .read(goRouterProvider)
            .push(ChatRoomPage.routePath, extra: msg.data['room_id']);
      },
    );
  }

  Future<void> initializeSubscriptionService() {
    return SubscriptionService.initialize(
      onData: (purchase) async {
        if (purchase.status == PurchaseStatus.purchased ||
            purchase.status == PurchaseStatus.restored) {
          final userId = ref.read(authProvider)!.id;
          final token = purchase.verificationData.serverVerificationData;

          final success = await ref
              .read(userSubscriptionProvider)
              .verify(
                purchaseToken: token,
                productId: purchase.productID,
                userId: userId,
              );

          if (success) {
            if (purchase.pendingCompletePurchase) {
              await SubscriptionService.instance.complete(purchase);
              await ref
                  .read(goRouterProvider)
                  .pushReplacement(SplashPage.routePath);
            }
          } else {
            showSnackbar(context, 'Error');
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
