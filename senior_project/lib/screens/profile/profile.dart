import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import "package:senior_project/Providers/token_provider.dart";
import "package:senior_project/Providers/user_provider.dart";
import "package:senior_project/templates/custom_scaffold.dart";
import 'dart:convert';
import 'package:senior_project/Providers/token_provider.dart';
import "package:senior_project/templates/custom_body_with_image.dart";
import "../../widgets/dialog_utils.dart";
import "./profile_edit.dart";
import "./profile_settings.dart";
import "./profile_help.dart";

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
 late String username;
  String phoneNumber = "Loading...";

  @override
  void initState() {
    super.initState();
    username = ref.read(userProvider);
    fetchUserProfile();
  }

  // ✅ Fetch user profile from API using token from Riverpod provider
  Future<void> fetchUserProfile() async {
    final token = ref.read(tokenProvider); // ✅ Read token from Riverpod

    if (token == null) {
      print("Error: No token found");
      return;
    }

    final url = Uri.parse("http://10.0.2.2:8080/getinfo");

    try {
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
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
    final token = ref.watch(tokenProvider); // ✅ Watch token from Riverpod
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfileEditScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings, color: Colors.blue),
                title: const Text("Settings"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfileSettingsScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.help_outline, color: Colors.blue),
                title: const Text("Help"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfileHelpScreen(),
                    ),
                  );
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

    return CustomScaffold(
      title: "Profile",
      content: CustomBodyWithImage(content: content, image: image),
    );
  }
}
