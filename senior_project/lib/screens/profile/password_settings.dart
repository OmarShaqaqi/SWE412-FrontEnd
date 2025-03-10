import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:senior_project/Providers/token_provider.dart';
import 'package:senior_project/templates/custom_scaffold.dart';
import "../../templates/custom_body.dart";

class PasswordSettingsScreen extends ConsumerStatefulWidget {
  const PasswordSettingsScreen({super.key});

  @override
  ConsumerState<PasswordSettingsScreen> createState() => _PasswordSettingsScreenState();
}

class _PasswordSettingsScreenState extends ConsumerState<PasswordSettingsScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  // ✅ Function to update password
  Future<void> changePassword() async {
    final token = ref.read(tokenProvider); // ✅ Read token from Riverpod

    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Authentication error: No token found")),
      );
      return;
    }

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
          "Authorization": "Bearer $token", // ✅ Use token from provider
        },
        body: jsonEncode({
          "newPassword": newPasswordController.text.trim(),
        }),
      );

      print("Response Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

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
            decoration: const InputDecoration(
              hintText: "●●●●●●●●",
              filled: true,
              fillColor: Color.fromARGB(255, 223, 247, 226),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(18.0)),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text("Confirm New Password"),
          TextFormField(
            controller: confirmPasswordController,
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

    return CustomScaffold(
      title: "Password Settings",
      content: CustomBody(content: content),
    );
  }
}
