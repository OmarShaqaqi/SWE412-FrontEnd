import "dart:io";

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import "package:image_picker/image_picker.dart";
import "package:senior_project/Providers/profileImage_provider.dart";
import "package:senior_project/Providers/token_provider.dart";
import "package:senior_project/Providers/user_provider.dart";
import "package:senior_project/config.dart";
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
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

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

    final url = Uri.parse("$baseUrl/getinfo");

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

    //   Future<void> uploadProfileImage(File file) async {
    //   final token = ref.read(tokenProvider);
      
    //   final bytes = await file.readAsBytes();
    //   final base64Image = base64Encode(bytes);
    //   print("Base64 Image: $base64Image");
    //   final url = Uri.parse('$baseUrl/uploadProfilePicture');
    //   final response = await http.post(
    //     url,
    //     headers: {
    //       "Content-Type": "application/json",
    //       "Authorization": "Bearer $token",
    //     },
    //         body: jsonEncode({
    //           "image_encode": base64Image, // match backend field name
    //         }),
    //   );

    //   if (response.statusCode == 200) {
    //     print("✅ Profile image uploaded successfully");
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       const SnackBar(content: Text("Profile picture updated!")),
    //     );
    //   } else {
    //     print("❌ Failed to upload: ${response.statusCode}");
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       const SnackBar(content: Text("Upload failed")),
    //     );
    //   }
    // }

    // Future<void> _pickImage() async {
    //   final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    //   if (pickedFile != null) {
    //     File image = File(pickedFile.path);
    //     setState(() {
    //       _imageFile = image;
    //     });

    //     await uploadProfileImage(image); // <-- Call upload
    //   }
    // }

  @override
  Widget build(BuildContext context) {
    final token = ref.watch(tokenProvider); // ✅ Watch token from Riverpod
    Widget profileImage =  Consumer(
    builder: (context, ref, _) {
    final imageAsync = ref.watch(profileImageProvider);
    print("Image Async: $imageAsync");
    return imageAsync.when(
      data: (data) {
        return CircleAvatar(
          radius: 50,
          backgroundImage: data != null
              ? MemoryImage(data)
              : const AssetImage('assets/anonymous_profile.png') as ImageProvider,
          backgroundColor: Colors.white,
        );
      },
      loading: () => const CircleAvatar(radius: 50, child: CircularProgressIndicator()),
      error: (_, __) => const CircleAvatar(
        radius: 50,
        backgroundImage: AssetImage('assets/anonymous_profile.png'),
        backgroundColor: Colors.white,
      ),
    );
  },
);


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
                  showLogoutDialog(context,ref);
                },
              ),
            ],
          ),
        ),
      ],
    );

    return CustomScaffold(
      title: "Profile",
      content: CustomBodyWithImage(content: content, profileWidget: profileImage,),
    );
  }
}
