import "dart:convert";
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:senior_project/Providers/token_provider.dart';
import 'package:senior_project/Providers/user_provider.dart';
import 'package:senior_project/templates/custom_scaffold.dart';
import "package:senior_project/templates/custom_body_with_image.dart";


class ProfileEditScreen extends ConsumerStatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  ConsumerState<ProfileEditScreen> createState() => _ProfileEditState();
}

class _ProfileEditState extends ConsumerState<ProfileEditScreen> {
  bool _darkModeEnabled = false;
  String username = "Loading...";
  String phoneNumber = "Loading...";
  final TextEditingController usernameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchUserProfile();
  }

  // ✅ Function to fetch user profile data
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
          "Authorization": "Bearer $token"
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          username = data["username"].toString();
          phoneNumber = data["phone"].toString();
          usernameController.text = username;
        });
      } else {
        print("Error: ${response.body}");
      }
    } catch (e) {
      print("Exception: $e");
    }
  }

  // ✅ Function to update username via API request
  Future<void> updateUserProfile() async {
    final token = ref.read(tokenProvider); // ✅ Read token from Riverpod

    if (token == null) {
      print("Error: No token found");
      return;
    }

    final url = Uri.parse("http://10.0.2.2:8080/updateuser");

    try {
      final response = await http.put(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
        body: jsonEncode({
          "username": usernameController.text.trim(),
        }),
      );

      if (response.statusCode == 200) {
        print("Profile updated successfully");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Profile updated successfully!")),
        );
        ref.read(userProvider.notifier).updateUsername(usernameController.text.trim());
      } else {
        print("Update failed: ${response.body}");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to update profile")),
        );
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
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 60),
        Text(
          username,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        Text(
          phoneNumber,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32),
        const Text(
          "Account Information",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Username",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: usernameController,
                decoration: InputDecoration(
                  hintText: "Enter new username",
                  filled: true,
                  fillColor: const Color.fromARGB(255, 223, 247, 226),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(18.0)),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Phone",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 223, 247, 226),
                  borderRadius: BorderRadius.circular(18.0),
                  border: Border.all(color: Colors.grey.shade400),
                ),
                child: Text(
                  phoneNumber,
                  style: const TextStyle(fontSize: 16, color: Colors.black54),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 0, 208, 158),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: updateUserProfile, // ✅ Trigger profile update
                    child: const Text("Update Profile"),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );

    return CustomScaffold(
      title: "Edit Profile",
      content: CustomBodyWithImage(content: content, image: image),
    );
  }
}
