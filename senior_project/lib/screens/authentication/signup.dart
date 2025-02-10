import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import "../../widgets/password.dart";
import "login.dart";
import 'package:senior_project/templates/cus_scaf_log.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Widget content =  Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Full Name",
              style: TextStyle(
                color: Colors.black,
              ),
              textAlign: TextAlign.left,
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: "your name",
                filled: true,
                fillColor: Color.fromARGB(255, 223, 247, 226),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(18.0),
                  ),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter your name";
                }
                return null;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            const Text("Email"),
            TextFormField(
              decoration: const InputDecoration(
                hintText: "example@example.com",
                filled: true,
                fillColor: Color.fromARGB(255, 223, 247, 226),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(18.0),
                  ),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter your email";
                } else if (!value.contains("@")) {
                  return "Please enter a valid email";
                }
                return null;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            const Text("Mobile Number"),
            TextFormField(
              decoration: const InputDecoration(
                hintText: "+ 966 50 456 7890",
                filled: true,
                fillColor: Color.fromARGB(255, 223, 247, 226),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(18.0),
                  ),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter your mobile number";
                }
                final regExp = RegExp(
                    r'^(009665|9665|\+9665|05)(5|0|3|6|4|9|1|8|7)[0-9]{7}$'); // check all possabilities later
      
                if (!regExp.hasMatch(value)) {
                  return "Please enter a valid mobile number";
                }
                return null;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            const Text("Date of Birth"),
            TextFormField(
              decoration: const InputDecoration(
                hintText: "DD / MM / YYY",
                filled: true,
                fillColor: Color.fromARGB(255, 223, 247, 226),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(18.0),
                  ),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter your date of birth";
                }
                final dateRegex = RegExp(
                    r'/(0[1-9]|1[012])[- \/.](0[1-9]|[12][0-9]|3[01])[- \/.](19|20)\d\d/');
      
                if (!dateRegex.hasMatch(value)) {
                  return "Please enter a date with the format DD/MM/YYYY";
                }
                return null;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            const Text("Password"),
            const Password(),
            const SizedBox(
              height: 20,
            ),
            const Text("Confirm Password"),
            const Password(),
            const SizedBox(height: 20),
            const Text(
              textAlign: TextAlign.center,
              "By continuing, you agree to Terms of Use and Privacy Policy.",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            Center(
              // Center the button
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        print("Form is valid");
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 0, 208, 158),
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 80),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Color.fromARGB(255, 9, 48, 48),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(
                          text: 'Already have an account?',
                          style: TextStyle(color: Colors.black),
                        ),
                        TextSpan(
                          text: ' Login',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ),
                              );
                            },
                          style: const TextStyle(color: Colors.blue),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );

    return CustomScaffold(
      title: "Create Account",
      content: content,
    );
  }
}
