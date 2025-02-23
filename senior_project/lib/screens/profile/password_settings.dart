import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import "package:senior_project/templates/custom_scaffold_token.dart";
import "../../templates/custom_body.dart";
import "../../widgets/password.dart";

class PasswordSettingsScreen extends StatefulWidget {
  final String token;
  const PasswordSettingsScreen({super.key, required this.token});

  @override
  State<PasswordSettingsScreen> createState() => _PasswordSettingsScreenState();
}

class _PasswordSettingsScreenState extends State<PasswordSettingsScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  // ✅ Function to update password
  Future<void> changePassword() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (newPasswordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Passwords do not match!")),
      );
      return;
    }

    final url = Uri.parse("http://10.0.2.2:8080/changepassword");

    try {
      final response = await http.put(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${widget.token}",
        },
        body: jsonEncode({
          "newPassword": newPasswordController.text.trim(),
        }),
      );
      print(widget.token);
      print(response.statusCode);
      print("Response: ${response.body}");

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Password changed successfully!")),
        );
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
    final content = Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("New Password"),
                TextFormField(
                controller: newPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "●●●●●●●●",
                  filled: true,
                  fillColor: const Color.fromARGB(255, 223, 247, 226),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(18.0)),
                  ),
                ),
              ), // Password field with controller
          const SizedBox(height: 16),
          const Text("Confirm New Password"),
                TextFormField(
                controller: confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "●●●●●●●●",
                  filled: true,
                  fillColor: const Color.fromARGB(255, 223, 247, 226),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(18.0)),
                  ),
                ),
              ),
          const SizedBox(height: 32),
          Center(
            child: ElevatedButton(
              onPressed: changePassword, // ✅ Call function on button press
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 0, 208, 158),
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 80),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
              child: const Text(
                "Change Password",
                style: TextStyle(
                  color: Color.fromARGB(255, 9, 48, 48),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    return CustomScaffoldToken(
      title: "Password Settings",
      content: CustomBody(content: content),
      token: widget.token,
    );
  }
}
