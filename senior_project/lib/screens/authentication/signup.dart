import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:senior_project/config.dart';
import 'package:senior_project/screens/home/HomeScreen.dart';
import 'package:senior_project/templates/custom_appbar.dart';
import 'package:senior_project/templates/custom_body.dart';
import "../../widgets/password.dart";
import "login.dart";
import "../../templates/custom_scaffold.dart";
import 'package:http/http.dart' as http;
import 'dart:async';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Controllers to store user input
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController budgetController = TextEditingController();

// void handleSignup() async {
//   if (_formKey.currentState!.validate()) {
//     final response = await http.post(
//       Uri.parse("http://127.0.0.1:8080/signup/"),
//       headers: {"Content-Type": "application/json"},
//       body: jsonEncode({
//         "phone": mobileController.text.trim(),
//         "email": emailController.text.trim(),
//         "password": passwordController.text.trim(),
//         "username": lastNameController.text.trim(),
//         "fname": firstNameController.text.trim(),
//         "lname": lastNameController.text.trim(),
//       }),
//     );

//     if (response.statusCode == 200) {
//       print("Signup successful: ${response.body}");
//       Navigator.pop(context);
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => const HomeScreen(),
//                               ),
//                             );
//     } else {
//       print("Signup failed: ${response.body}");
//     }
//   }
// }

//

//second try
// void handleSignup() async {
//   if (_formKey.currentState!.validate()) {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) => Center(child: CircularProgressIndicator()),
//     );

//     try {
//       final response = await http.post(
//         Uri.parse("http://0.0.0.0:8080/signup/"),
//         headers: {"Content-Type": "application/json"},
//         body: jsonEncode({
//           "phone": mobileController.text.trim(),
//           "email": emailController.text.trim(),
//           "password": passwordController.text.trim(),
//           "username": userNameController.text.trim(),
//           "fname": firstNameController.text.trim(),
//           "lname": lastNameController.text.trim(),
//         }),
//       );

//       Navigator.pop(context); // Close loading dialog

//       if (response.statusCode == 200) {
//         print("Signup successful: ${response.body}");
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => HomeScreen()),
//         );
//       } else {
//         print("Signup failed: ${response.body}");
//         showDialog(
//           context: context,
//           builder: (context) => AlertDialog(
//             title: Text("Signup Failed"),
//             content: Text(response.body),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: Text("OK"),
//               ),
//             ],
//           ),
//         );
//       }
//     } catch (e) {
//       Navigator.pop(context); // Close loading dialog
//       print("Error: $e");

//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: Text("Network Error"),
//           content: Text("Could not connect to the server."),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: Text("OK"),
//             ),
//           ],
//         ),
//       );
//     }
//   }
// }

  bool isLoading = false;
  String? responseMessage;

  Future<void> registerUser() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      isLoading = true;
      responseMessage = null;
    });

    final url = Uri.parse("$baseUrl/signup"); // Change this to your backend URL

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "phone": mobileController.text,
        "email": emailController.text,
        "password": passwordController.text,
        "username": userNameController.text,
        "fname": firstNameController.text,
        "lname": lastNameController.text,
        "budget": budgetController.text,
      }),
    );

    setState(() {
      isLoading = false;
      if (response.statusCode == 200) {
        responseMessage = "Signup successful!";
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      } else {
        responseMessage =
            "Signup failed: ${jsonDecode(response.body)['message']}";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: const Color.fromARGB(255, 0, 208, 158),
      appBar: CustomAppbar(title: "Sign Up"),
      body: CustomBody(
        content: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Username",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    controller: userNameController, // Attach controller
                    decoration: const InputDecoration(
                      hintText: "Username",
                      filled: true,
                      fillColor: Color.fromARGB(255, 223, 247, 226),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(18.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(
                              255, 223, 247, 226), // match fill color
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(18.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(
                              255, 223, 247, 226), // match fill color
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(18.0)),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your first name";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "First Name",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    controller: firstNameController, // Attach controller
                    decoration: const InputDecoration(
                      hintText: "First name",
                      filled: true,
                      fillColor: Color.fromARGB(255, 223, 247, 226),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(18.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(
                              255, 223, 247, 226), // match fill color
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(18.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(
                              255, 223, 247, 226), // match fill color
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(18.0)),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your first name";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Last Name",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    controller: lastNameController,
                    decoration: const InputDecoration(
                      hintText: "Last name",
                      filled: true,
                      fillColor: Color.fromARGB(255, 223, 247, 226),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(18.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(
                              255, 223, 247, 226), // match fill color
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(18.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(
                              255, 223, 247, 226), // match fill color
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(18.0)),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your last name";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Email",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      hintText: "example@example.com",
                      filled: true,
                      fillColor: Color.fromARGB(255, 223, 247, 226),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(18.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(
                              255, 223, 247, 226), // match fill color
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(18.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(
                              255, 223, 247, 226), // match fill color
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(18.0)),
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
                  const SizedBox(height: 20),
                  const Text(
                    "Mobile Number",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    controller: mobileController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      hintText: "05xxxxxxxx",
                      filled: true,
                      fillColor: Color.fromARGB(255, 223, 247, 226),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(18.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(
                              255, 223, 247, 226), // match fill color
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(18.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(
                              255, 223, 247, 226), // match fill color
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(18.0)),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your mobile number";
                      }
                      final regExp = RegExp(
                          r'^(009665|9665|\+9665|05)(5|0|3|6|4|9|1|8|7)[0-9]{7}$');

                      if (!regExp.hasMatch(value)) {
                        return "Please enter a valid mobile number";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Your Personal Budget",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    controller: budgetController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: "Enter your budget",
                      filled: true,
                      fillColor: Color.fromARGB(255, 223, 247, 226),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(18.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(
                              255, 223, 247, 226), // match fill color
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(18.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(
                              255, 223, 247, 226), // match fill color
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(18.0)),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your Budget";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Password",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: "Enter password",
                      filled: true,
                      fillColor: Color.fromARGB(255, 223, 247, 226),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(18.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(
                              255, 223, 247, 226), // match fill color
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(18.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(
                              255, 223, 247, 226), // match fill color
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(18.0)),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter a password";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Confirm Password",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  TextFormField(
                    controller: confirmPasswordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: "Confirm password",
                      filled: true,
                      fillColor: Color.fromARGB(255, 223, 247, 226),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(18.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(
                              255, 223, 247, 226), // match fill color
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(18.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(
                              255, 223, 247, 226), // match fill color
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(18.0)),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please confirm your password";
                      } else if (value != passwordController.text) {
                        return "Passwords do not match";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Column(
                      children: [
                        ElevatedButton(
                          onPressed: registerUser,
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 0, 208, 158),
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
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
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
                                    Navigator.pushReplacement(
                                      context,
                                      PageRouteBuilder(
                                        transitionDuration:
                                            const Duration(milliseconds: 300),
                                        pageBuilder: (context, animation,
                                                secondaryAnimation) =>
                                            LoginScreen(),
                                        transitionsBuilder: (context, animation,
                                            secondaryAnimation, child) {
                                          final offsetAnimation = Tween<Offset>(
                                            begin: const Offset(
                                                1.0, 0.0), // Slide from right
                                            end: Offset.zero,
                                          ).chain(CurveTween(
                                              curve: Curves.easeInOut));

                                          return SlideTransition(
                                            position: animation
                                                .drive(offsetAnimation),
                                            child: child,
                                          );
                                        },
                                      ),
                                    );
                                  },
                                text: ' Login',
                                style: const TextStyle(color: Colors.blue),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 50),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
