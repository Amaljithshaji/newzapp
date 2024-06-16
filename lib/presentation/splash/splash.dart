import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newzapp/manager/color_manager.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 4)).then(
      (value) => Get.toNamed('/Home'),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: TextAnimator(
          'Newz App',
          style: TextStyle(
              fontSize: 56,
              color: appColors.brandDark,
              fontWeight: FontWeight.bold),
          atRestEffect: WidgetRestingEffects.none(),
          incomingEffect: WidgetTransitionEffects.incomingSlideInFromLeft(
              delay: const Duration(seconds: 1)),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
