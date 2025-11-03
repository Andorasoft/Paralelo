import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:paralelo/core/imports.dart';

class AnimatedLogo extends ConsumerStatefulWidget {
  const AnimatedLogo({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _AnimatedLogoState();
  }
}

class _AnimatedLogoState extends ConsumerState<AnimatedLogo>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    scaleAnimation = Tween<double>(
      begin: 0.9,
      end: 1.1,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scaleAnimation,
      child: Image.asset(
        'assets/images/icon-white.png',
        width: calculateSize(context),
        height: calculateSize(context),
      ),
    ).center();
  }

  /// Returns a responsive icon size based on the screen's shortest side.
  /// Uses about 40% of that dimension for consistent scaling.
  double calculateSize(BuildContext context) {
    final shortestSide = MediaQuery.of(context).size.shortestSide;
    return shortestSide * 0.4;
  }
}
