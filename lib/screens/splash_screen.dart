import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import '../utils/globals.dart';
import '../utils/styles.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      backgroundColor: Globals.primary,
      splash : Column(
        children: [
          const Expanded(
            child: Icon(Icons.wechat_outlined,
            color: Colors.white,
              size: 40,
            ),
          ),
          Expanded(
            child: Text('CHAT APP',
            style: Styles.headingStyle2(
              color: Colors.white
            )),
          )
        ],
      ),
      nextScreen: const MyHomePage(),
      duration: 1500,
      splashTransition: SplashTransition.fadeTransition,
    );
  }
}

