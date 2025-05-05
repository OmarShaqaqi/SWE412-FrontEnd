import 'package:flutter/material.dart';
import 'package:senior_project/screens/authentication/signup.dart';
import '../profile/forgot_password.dart';
import 'login.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  final _buttonStyle = ElevatedButton.styleFrom(
    minimumSize: const Size(220, 50),
    maximumSize: const Size(260, 60),
    padding: const EdgeInsets.symmetric(vertical: 12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
    ),
    elevation: 4,
    shadowColor: Colors.black26,
  );

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: const Offset(0, -0.2),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutBack,
    ));

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutCubic,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    Image.asset(
                      'assets/sh_green_final.png',
                      width: MediaQuery.of(context).size.width * 0.8,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 40),
                    _buildAuthButtons(),
                  ],
                ),
              ),
            ),
          ),
          const Positioned(
            bottom: 45,
            left: 0,
            right: 0,
            child: _BrandText(),
          ),
        ],
      ),
    );
  }

  Widget _buildAuthButtons() {
    return Column(
      children: [
        const SizedBox(height: 50),
        ElevatedButton(
          onPressed: () => Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 400),
              pageBuilder: (context, animation, secondaryAnimation) =>
                  LoginScreen(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                final offsetAnimation = Tween<Offset>(
                  begin: const Offset(1.0, 0.0), // Start from right
                  end: Offset.zero,
                ).chain(CurveTween(curve: Curves.easeInOut));

                return SlideTransition(
                  position: animation.drive(offsetAnimation),
                  child: child,
                );
              },
            ),
          ),
          style: _buttonStyle.copyWith(
            backgroundColor: MaterialStateProperty.all(const Color(0xFF00D09E)),
          ),
          child: const Text(
            'Log In',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              fontSize: 20,
              color: Color(0xFF093030),
              letterSpacing: 0.5,
            ),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () => Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 400),
              pageBuilder: (context, animation, secondaryAnimation) =>
                  SignupScreen(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                final offsetAnimation = Tween<Offset>(
                  begin: const Offset(1.0, 0.0), // Start from right
                  end: Offset.zero,
                ).chain(CurveTween(curve: Curves.easeInOut));

                return SlideTransition(
                  position: animation.drive(offsetAnimation),
                  child: child,
                );
              },
            ),
          ),
          child: const Text(
            'Sign Up',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              fontSize: 20,
              color: Color(0xFF0E3E3E),
              letterSpacing: 0.5,
            ),
          ),
        ),
        const SizedBox(height: 15),
        TextButton(
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (_) => const ForgotPasswordScreen())),
          child: const Text(
            'Forgot Password?',
            style: TextStyle(
              fontFamily: 'League Spartan',
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Color(0xFF093030),
              letterSpacing: 0.3,
            ),
          ),
        ),
      ],
    );
  }
}

class _BrandText extends StatelessWidget {
  const _BrandText();

  @override
  Widget build(BuildContext context) {
    return const Text(
      "رٌشـــد",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontFamily: 'SaudiFont',
        fontWeight: FontWeight.w600,
        fontSize: 35,
        height: 1.1,
        letterSpacing: 0.5,
        color: Color(0xFF00D09E),
        shadows: [
          Shadow(
            blurRadius: 4,
            offset: Offset(0, 2),
            color: Colors.black26,
          )
        ],
      ),
    );
  }
}
