import 'dart:ui';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart';
import 'package:midusa_pos/login_page.dart';
import 'package:page_transition/page_transition.dart';
import 'package:midusa_pos/Colors/mycolors.dart' as myColor;

class logOutSplash extends StatelessWidget {
  const logOutSplash({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: AnimatedSplashScreen(
          backgroundColor: myColor.AppColor.serialActivationPageBg,
          splash: Column(
            children: [
              Expanded(child: Container()),
              CircularProgressIndicator(
                color: Colors.orange,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Logging you out...',
                style: TextStyle(color: Colors.black),
              ),
              Expanded(child: Container()),
            ],
          ),
          nextScreen: loginPage(),
          duration: 2500,
          splashTransition: SplashTransition.slideTransition,
          pageTransitionType: PageTransitionType.leftToRightWithFade,
          animationDuration: Duration(milliseconds: 1500),
        ),
      ),
    );
  }
}
