import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'dart:async';

import '../authentication/welcome_page.dart';

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(Duration(milliseconds: 1800), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 200),
          pageBuilder: (_, __, ___) => WelcomeScreen(),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF00D09E),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.50,
                  height: MediaQuery.of(context).size.height * 0.50,
                  child: Lottie.asset(
                    'assets/vector_animation.json',
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 240),
              ],
            ),
          ),
          const Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Text(
              "Roshd",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                fontSize: 35.14,
                height: 57.36 / 52.14,
                letterSpacing: 0,
                textBaseline: TextBaseline.alphabetic,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
