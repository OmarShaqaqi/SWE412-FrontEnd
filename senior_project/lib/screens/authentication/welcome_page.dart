import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:senior_project/screens/authentication/signup.dart';
import '../profile/forgot_password.dart';
import 'login.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1FFF3),
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
                    'assets/vector_green.json',
                    fit: BoxFit.contain,
                    repeat: false,
                  ),
                ),
                const SizedBox(height: 60),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) =>  LoginScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(207, 45),
                    backgroundColor: const Color(0xFF00D09E),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Log In',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: Color(0xFF093030),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignupScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(207, 45),
                    backgroundColor: const Color(0xFFDFF7E2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: Color(0xFF0E3E3E),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()),
                    );
                  },
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(
                      fontFamily: 'League Spartan',
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Color(0xFF093030),
                    ),
                  ),
                ),
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
                color: Color.fromARGB(255, 0, 208, 158),
              ),
            ),
          ),
        ],
      ),
    );
  }
}