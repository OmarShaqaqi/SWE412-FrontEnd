import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import "package:senior_project/screens/authentication/login.dart";
import "package:senior_project/templates/custom_body.dart";
import "package:senior_project/templates/custom_scaffold_token.dart";
import "package:senior_project/widgets/bullet_list.dart";
import "../../widgets/password.dart";
import "../../widgets/dialog_utils.dart";

class DeleteAccountScreen extends StatefulWidget {
  final String token;
  const DeleteAccountScreen({super.key, required this.token});

  @override
  State<DeleteAccountScreen> createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccountScreen> {
  final TextEditingController passwordController = TextEditingController();

  // ✅ Function to send POST request to delete the account
  Future<void> deleteAccount() async {
    if (passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter your password")),
      );
      return;
    }

    final url = Uri.parse("http://10.0.2.2:8080/deleteuser");

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${widget.token}",
        },
        body: jsonEncode({
          "password": passwordController.text.trim(),
        }),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Account deleted successfully")),
        );
        
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));

        // Navigate to the login screen or another screen after deletion
        Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: ${response.body}")),
        );
      }
    } catch (e) {
      print("Exception: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("An error occurred")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final content = Column(
      children: [
        const Text(
          "Are you sure you want to delete your account?",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 223, 247, 226),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          margin: const EdgeInsets.only(top: 16),
          child: const Column(
            children: [
              Text(
                "This action will permanently delete all of your data, and you will not be able to recover it.",
                style: TextStyle(fontSize: 16),
              ),
              BulletList(
                strings: [
                  "All your expenses, income, and associated transactions will be eliminated.",
                  "You will not be able to access your account or any related information.",
                  "This action cannot be undone."
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          "Please enter your password to confirm the deletion of your account.",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: passwordController,
          obscureText: true,
          decoration: InputDecoration(
            hintText: "●●●●●●●●",
            filled: true,
            fillColor: const Color.fromARGB(255, 223, 247, 226),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(18.0)),
            ),
          ),
        ), // ✅ Password input field
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: deleteAccount, // ✅ Call function on button press
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 0, 208, 158),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 80),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
          ),
          child: const Text(
            "Yes, delete my account",
            style: TextStyle(color: Color.fromARGB(255, 9, 48, 48)),
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 223, 247, 226),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 80),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
          ),
          child: const Text(
            "Cancel",
            style: TextStyle(color: Color.fromARGB(255, 9, 48, 48)),
          ),
        ),
      ],
    );

    return CustomScaffoldToken(
      title: "Delete Account",
      content: CustomBody(content: content),
      token: widget.token,
    );
  }
}
