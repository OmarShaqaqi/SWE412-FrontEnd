import 'package:flutter/material.dart';
import "package:senior_project/screens/profile/password_settings.dart";
import "package:senior_project/templates/custom_scaffold.dart";
import "package:senior_project/templates/custom_scaffold_token.dart";
import "../../templates/custom_bottom_navigation_bar.dart";
import "../../templates/custom_body.dart";
import "./delete_account.dart";

class ProfileSettingsScreen extends StatelessWidget {
  final String token;
  const ProfileSettingsScreen({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final content = ListView(
      children: [
        ListTile(
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 0, 208, 158),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.key,
              color: Colors.white,
            ),
          ),
          title: const Text(
            "Password Settings",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            color: Colors.black,
            size: 16,
          ),
          onTap: () {
            // Navigate to Password Settings screen
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PasswordSettingsScreen(token: token,)),
            );
          },
        ),
        ListTile(
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 0, 208, 158),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.person,
              color: Colors.white,
            ),
          ),
          title: const Text(
            "Delete Account",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            color: Colors.black,
            size: 16,
          ),
          onTap: () {
            // Navigate to Password Settings screen
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>  DeleteAccountScreen(token: token,)),
            );
          },
        ),
      ],
    );

    return CustomScaffoldToken(
        title: "Settings",
        content: CustomBody(
          content: content,
        ),        
        token: token,
        );
  }
}
