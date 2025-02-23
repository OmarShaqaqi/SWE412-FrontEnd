import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import "package:senior_project/templates/custom_body_with_image.dart";
import "package:senior_project/templates/custom_scaffold_token.dart";
import "../../widgets/dialog_utils.dart";
import "./profile_edit.dart";
import "./profile_settings.dart";
import "./profile_help.dart";

class ProfileScreen extends StatefulWidget {
  final String token; // Receiving the token

  const ProfileScreen({super.key, required this.token});

  @override
  State<ProfileScreen> createState() => _ProfileScreen();
}

class _ProfileScreen extends State<ProfileScreen> {
  String username = "Loading...";
  String phoneNumber = "Loading...";


  @override
  void initState() {
    super.initState();
    fetchUserProfile();
  }

  // ✅ Function to make an authenticated request
  Future<void> fetchUserProfile() async {
    final url = Uri.parse("http://10.0.2.2:8080/getinfo"); // Adjust to your Spring Boot API endpoint

    try {
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${widget.token}" // Send token in Authorization header
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          username = data["username"].toString();
          phoneNumber = data["phone"].toString();
        });
      } else {
        print("Error: ${response.body}");
      }
    } catch (e) {
      print("Exception: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final String image = 'assets/anonymous_profile.png';

    final content = Column(
      children: [
        const SizedBox(height: 60),
        // Name and ID Section
        Text(
          username,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          "Phone: $phoneNumber",
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
        const SizedBox(height: 32),
        // Options Section
        Expanded(
          child: ListView(
            children: [
              ListTile(
                leading: const Icon(Icons.person, color: Colors.blue),
                title: const Text("Edit Profile"),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileEditScreen(token: widget.token,)));
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings, color: Colors.blue),
                title: const Text("Settings"),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>  ProfileSettingsScreen(token: widget.token,)));
                },
              ),
              ListTile(
                leading: const Icon(Icons.help_outline, color: Colors.blue),
                title: const Text("Help"),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileHelpScreen()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.blue),
                title: const Text("Logout"),
                onTap: () {
                  showLogoutDialog(context);
                },
              ),
            ],
          ),
        ),
      ],
    );

    return CustomScaffoldToken(
      title: "Profile",
      content: CustomBodyWithImage(content: content, image: image),
      token: widget.token,
    );
  }
}
