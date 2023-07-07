import 'package:flutter/material.dart';
import 'package:midusa_pos/activate_serial_page.dart';
import 'package:midusa_pos/login_page.dart';
import 'package:midusa_pos/set_admin_account.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:window_manager/window_manager.dart';
import 'package:page_transition/page_transition.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:window_manager/window_manager.dart';
import 'intro_screens/intro_screens_1.dart';
import 'intro_screens/intro_screens_2.dart';
import 'intro_screens/intro_screens_3.dart';
import 'local_database/overal_utils.dart';
import 'local_database/user_utils.dart';

class splashPage extends StatefulWidget {
  const splashPage({super.key});

  @override
  State<splashPage> createState() => _splashPageState();
}

class _splashPageState extends State<splashPage> {
  //controller to keep track of what page we are on
  PageController _controller = PageController();

  //keep track if we are on the last page or not
  bool onLastPage = false;
  bool onFirstPage = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                onLastPage = (index == 2);
                onFirstPage = (index == 0);
              });
            },
            children: [
              introScreenOne(),
              introScreenTwo(),
              introScreenThree(),
            ],
          ),
          Container(
              alignment: Alignment(0, 0.8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //skip or back
                  onLastPage
                      ? TextButton(
                          onPressed: () {
                            onFirstPage = false;
                            _controller.jumpToPage(1);
                          },
                          child: const Text(
                            'back',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                        )
                      : onFirstPage
                          ? TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return activateSerialPage();
                                    },
                                  ),
                                );
                              },
                              child: const Text(
                                'skip',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),
                            )
                          : TextButton(
                              onPressed: () {
                                onFirstPage = false;
                                _controller.jumpToPage(0);
                              },
                              child: const Text(
                                'back',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),
                            ),
                  //dot indicators
                  SmoothPageIndicator(controller: _controller, count: 3),

                  //next or done
                  onLastPage
                      ? TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return activateSerialPage();
                                },
                              ),
                            );
                          },
                          child: const Text(
                            'start',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                        )
                      : TextButton(
                          onPressed: () {
                            _controller.nextPage(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeIn,
                            );
                          },
                          child: const Text(
                            'next',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                        ),
                ],
              )),
        ],
      ),
    );
  }
}

class myAnimatedPage extends StatefulWidget {
  const myAnimatedPage({super.key});

  @override
  State<myAnimatedPage> createState() => _myAnimatedPageState();
}

class _myAnimatedPageState extends State<myAnimatedPage> with WindowListener {
  @override
  void initState() {
    windowManager.addListener(this);
    //_init();
    super.initState();
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  void onWindowClose() async {
    bool _isPreventClose = await windowManager.isPreventClose();
    if (_isPreventClose) {
      showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text('Are you sure you want to exit Ariaquickpay?'),
            actions: [
              TextButton(
                child: Text('No'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('Yes'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  await windowManager.destroy();
                },
              ),
            ],
          );
        },
      );
    }
  }

  final bool isSerialNumberSet =
      overalDataPreference.getSerialNumberSet() ?? false;
  final bool isAdminCreated =
      overalDataPreference.getAdminCreatedStatus() ?? false;
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      backgroundColor: Colors.white,
      splash: Image.asset(
        "assets/images/Midusa.png",
      ),
      splashIconSize: 400,
      centered: true,
      nextScreen: isSerialNumberSet != true && isAdminCreated != true
          ? const splashPage()
          : isSerialNumberSet == true && isAdminCreated != true
              ? const adminCreationPage()
              : loginPage(),
      duration: 3000,
      splashTransition: SplashTransition.scaleTransition,
      pageTransitionType: PageTransitionType.leftToRightWithFade,
      animationDuration: const Duration(milliseconds: 2000),
    );
  }
}
