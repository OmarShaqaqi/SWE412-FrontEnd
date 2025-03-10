import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import "package:senior_project/Providers/token_provider.dart";
import "package:senior_project/templates/custom_scaffold.dart";
import "package:senior_project/screens/profile/password_settings.dart";
import "../../templates/custom_body.dart";
import "./delete_account.dart";

class ProfileSettingsScreen extends ConsumerWidget {
  const ProfileSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final token = ref.watch(tokenProvider); // ✅ Get token from Riverpod

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
            // ✅ Navigate and pass token automatically from provider
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PasswordSettingsScreen(),
              ),
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
            // ✅ Navigate and pass token automatically from provider
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const DeleteAccountScreen(),
              ),
            );
          },
        ),
      ],
    );

    return CustomScaffold(
      title: "Settings",
      content: CustomBody(
        content: content,
      ),
    );
  }
}
