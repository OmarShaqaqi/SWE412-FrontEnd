import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:senior_project/screens/authentication/login.dart';
import 'package:senior_project/templates/custom_scaffold.dart';
import "../authentication/signup.dart";
import "../../templates/custom_body.dart";

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordStateScreen();
}

class _ForgotPasswordStateScreen extends State<ForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    final content = Column(
      children: [
        const Text(
          "Enter your email address",
          style: TextStyle(
            color: Color.fromARGB(255, 9, 48, 48),
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        const SizedBox(
          height: 32,
        ),
        Container(
          margin: const EdgeInsets.only(
            left: 32,
            right: 32,
          ),
          child: const TextField(
            decoration: InputDecoration(
              hintText: "example@example.com",
              filled: true,
              fillColor: Color.fromARGB(255, 223, 247, 226),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(18.0),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 32,
        ),
        Container(
          margin: const EdgeInsets.only(
            left: 32,
            right: 32,
          ),
          child: Column(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 0, 208, 158),
                ),
                onPressed: () {},
                child: const Text(
                  "Reset",
                  style: TextStyle(
                    color: Color.fromARGB(255, 9, 48, 48),
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Already have an account?',
                      style: TextStyle(color: Colors.black),
                    ),
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>  LoginScreen(),
                            ),
                          );
                        },
                      text: ' Login',
                      style: const TextStyle(color: Colors.blue),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 32,
              ),
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
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignupScreen(),
                            ),
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
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Forgot Password",
          style: TextStyle(
            color: Color.fromARGB(255, 9, 48, 48),
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 208, 158),
      ),
      body: CustomBody(
        content: content,
      ),
    );
  }
}
