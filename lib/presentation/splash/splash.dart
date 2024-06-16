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

    Future.delayed (const Duration(seconds: 4)).then((value) => Get.toNamed('/Home') ,);
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
                fontWeight: FontWeight.bold
              ),
              // atRestEffect: WidgetRestingEffects.pulse(effectStrength: 0.6),
              atRestEffect: WidgetRestingEffects.none(),
             
              incomingEffect: WidgetTransitionEffects.incomingSlideInFromLeft(
                // blur: const Offset(0, 10), scale: 3,
                 delay: const Duration(seconds: 1)
                 
              ),
              
              
              
               //  characterDelay: Duration(milliseconds: 250),
                 
              textAlign: TextAlign.center,),
      ),
    );
  }
}