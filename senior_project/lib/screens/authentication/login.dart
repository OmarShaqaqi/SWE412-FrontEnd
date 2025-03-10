import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:senior_project/Providers/token_provider.dart';
import 'package:senior_project/screens/home/HomeScreen.dart';
import 'package:senior_project/screens/profile/profile.dart';
import 'package:senior_project/templates/custom_body.dart';
import 'package:senior_project/Providers/token_provider.dart';
import '../../templates/custom_appbar.dart';
import "signup.dart";
import "forgot_password.dart";
import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginScreen extends ConsumerWidget {
  final TextEditingController usernameLoginController = TextEditingController();
  final TextEditingController passwordLoginController = TextEditingController();

  Future<void> handleSignin(BuildContext context, WidgetRef ref) async {
    if (usernameLoginController.text.isNotEmpty && passwordLoginController.text.isNotEmpty) {
      final response = await http.post(
        Uri.parse("http://10.0.2.2:8080/login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "phone": usernameLoginController.text.trim(),
          "password": passwordLoginController.text.trim(),
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        String token = data["token"];

        // ✅ Save token using Riverpod
        ref.read(tokenProvider.notifier).saveToken(token);

        print("Login successful, token stored: $token");

        // Navigate to ProfileScreen with token
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Login failed: ${response.body}")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: CustomAppbar(title: "Welcome"),
      body: CustomBody(
        content: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 241, 255, 243),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [   
              const SizedBox(height: 5),               
              const Text(
                "Username or Email",
                style: TextStyle(color: Colors.black),
                textAlign: TextAlign.left,
              ),
              TextFormField(
                controller: usernameLoginController,
                decoration: const InputDecoration(
                  hintText: "example@example.com",
                  filled: true,
                  fillColor: Color.fromARGB(255, 223, 247, 226),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(18.0)),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text("Password"),
              TextFormField(
                controller: passwordLoginController,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: "●●●●●●●●",
                  filled: true,
                  fillColor: Color.fromARGB(255, 223, 247, 226),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(18.0)),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () => handleSignin(context, ref), // ✅ Call function
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 0, 208, 158),
                        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 80),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                      child: const Text(
                        "Login",
                        style: TextStyle(color: Color.fromARGB(255, 9, 48, 48)),
                      ),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()),
                        );
                      },
                      child: const Text(
                        "Forgot Password?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    Text.rich(
                      TextSpan(
                        children: [
                          const TextSpan(
                            text: 'Don’t have an account?',
                            style: TextStyle(color: Colors.black),
                          ),
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => SignupScreen()),
                                );
                              },
                            text: ' Sign Up',
                            style: const TextStyle(color: Colors.blue),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
