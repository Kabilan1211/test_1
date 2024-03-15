import 'package:test_1/Pages/login.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

//This is the splash screen page, shows for 2 seconds

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      duration: 2000,
      splashTransition: SplashTransition.fadeTransition,
      backgroundColor: Colors.grey.shade200,
      splash: const Text("Welcome",
          style: TextStyle(
              color: Color.fromARGB(255, 186, 149, 255), fontSize: 50)),
      splashIconSize: 200,
      nextScreen: const Login(),
    );
  }
}
